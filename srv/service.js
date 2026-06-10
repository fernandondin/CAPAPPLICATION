const cds = require('@sap/cds');
const { UPDATE, SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = class Products extends cds.ApplicationService {
    async init(){
        const {Header, Item, Status, Options} = this.entities;
         this.on('setStatus', async (req) => {

            const selectedOption = req.data.option; // <-- opción elegida por el usuario

            console.log('selectedOption:', selectedOption);

            const itemId = req.params[1]?.ID ?? req.params[1];
            const item = await SELECT.one.from(Item).where({ ID: itemId });

            if (!item) return req.error(404, 'Item not found');

            // Obtener el status actual del Header padre
            const header = await SELECT.one.from(Header).where({ ID: item.header_ID });

            if (!header) return req.error(404, 'Header not found');

            const currentStatus = header.orderStatus_code;
            const now = new Date();
            let newReleaseDate = item.releaseDate;
            let newStatus;

            if (selectedOption === 'R')  {
                // Cambiar releaseDate a mañana
                const tomorrow = new Date(now);
                tomorrow.setDate(tomorrow.getDate() + 1);
                newReleaseDate = tomorrow.toISOString();
                newStatus = 'Released';

            } else if (selectedOption === 'L') {
                // Cambiar releaseDate a hoy
                newReleaseDate = now.toISOString();
                newStatus = 'Locked';

            } else if (selectedOption === 'C') {
                // No cambiar fecha, solo status
                newStatus = 'Created';
            }

            // Actualizar releaseDate del Item solo si cambió
            if (newReleaseDate !== item.releaseDate) {
                await UPDATE(Item)
                    .set({ releaseDate: newReleaseDate })
                    .where({ ID: itemId });
            }

            // Actualizar status del Header
            await UPDATE(Header)
                .set({ orderStatus_code: newStatus })
                .where({ ID: item.header_ID });

            return await SELECT.one.from(Item).where({ ID: itemId });
         });
        return super.init()
    }
}