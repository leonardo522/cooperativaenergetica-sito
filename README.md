# cooperativaenergetica.it — pagine del sito

Qui ci sono **solo le pagine pubbliche** del sito cooperativaenergetica.it: le stesse che chiunque vede online.
Il backend (pagamenti, PEC, documenti degli utenti) e il database stanno in un repository privato separato e non si toccano da qui.

## Come si lavora

- Nessuna modifica va direttamente su `main`: si lavora su un ramo e si apre una pull request.
- La pull request la approva Leonardo. Dopo l'approvazione la pubblica lui con `./deploy.sh` dal suo computer.
- Anteprima: dalla cartella del repository, `python3 -m http.server 8000` e poi http://localhost:8000.

## Attenzione

Le pagine `addio-canone.html` e `socio.html` parlano con il backend **in produzione** e con il pagamento Stripe **reale**.
Durante le prove non si inviano moduli e non si paga: si guardano solo testi, impaginazione e link.

## Cosa non si tocca senza chiedere

- `admin.html` (pannello di amministrazione)
- `privacy.html` (testo legale)
- gli indirizzi del backend (`API_BASE`), il link di pagamento Stripe e il funzionamento dei moduli
- `_headers` e `deploy.sh`
