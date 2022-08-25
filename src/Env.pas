unit Env;

interface

uses
  KLib.Constants;

const
  VERSION = '1.0';
  APPLICATION_NAME = 'MyService';

  SERVICE_NAME = APPLICATION_NAME;
  SERVICE_NAME_DESCRIPTION = APPLICATION_NAME + ' ' + VERSION;
  SERVICE_REGKEY = SERVICES_REGKEY + '\' + SERVICE_NAME;

implementation

end.
