#!/usr/bin/env bash

# Generated by POWSCRIPT (https://github.com/coderofsalvation/powscript)
#
# Unless you like pain: edit the .pow sourcefiles instead of this file

# powscript general settings
set -e                         # halt on error
set +m                         #
SHELL="$(echo $0)"             # shellname
SHELLNAME="$(basename $SHELL)" # shellname without path
shopt -s lastpipe              # flexible while loops (maintain scope)
shopt -s extglob               # regular expressions
path="$(pwd)"
selfpath="$( dirname "$(readlink -f "$0")" )"
tmpfile="/tmp/$(basename $0).tmp.$(whoami)"
#
# generated by powscript (https://github.com/coderofsalvation/powscript)
#

isset () 
{ 
    [[ ! "${#1}" == 0 ]] && return 0 || return 1
}

empty () 
{ 
    [[ "${#1}" == 0 ]] && return 0 || return 1
}

on () 
{ 
    func="$1";
    shift;
    for sig in "$@";
    do
        trap "$func $sig" "$sig";
    done
}

values () 
{ 
    echo "$2"
}




assert_caller_root(){
  debug 'Ensure script has been running by root'
  if isset "$SKIP_CHECKS"; then
    debug "OK, skip actual checking of current user"
  else
    if [[ "$EUID" = 0 ]]; then
      debug 'OK, current user is root'
    else
      debug 'NOK, current user is not root'
      fail "$(translate errors.must_be_root)"
    fi
  fi
}


assert_yum_installed(){
  if ! is_installed 'yum'; then
    fail "$(translate errors.yum_not_installed)"
  fi
}





declare -A COLOR_CODE

COLOR_CODE['bold']=1

COLOR_CODE['default']=39
COLOR_CODE['red']=31
COLOR_CODE['green']=32
COLOR_CODE['yellow']=33
COLOR_CODE['blue']=34
COLOR_CODE['magenta']=35
COLOR_CODE['cyan']=36
COLOR_CODE['grey']=90
COLOR_CODE['light.red']=91
COLOR_CODE['light.green']=92
COLOR_CODE['light.yellow']=99
COLOR_CODE['light.blue']=94
COLOR_CODE['light.magenta']=95
COLOR_CODE['light.cyan']=96
COLOR_CODE['light.grey']=37

RESET_FORMATTING='\e[0m'


program_name(){
  echo "${0##*/}"
}


print_with_color(){
  local message="${1}"
  local color="${2}"
  if ! empty "$color"; then
    escape_sequence="\e[${COLOR_CODE[$color]}m"
    echo -e "${escape_sequence}${message}${RESET_FORMATTING}"
  else
    echo "$message"
  fi
}


debug(){
  local message="${1}"
  if [[ "$VERBOSE" == "true" ]]; then
    print_with_color "$message" 'light.green'
  fi
}


print_info(){
  debug "Verbose mode: on"
  debug "Language: ${UI_LANG}"
}


print_err(){
  local message="${1}"
  local color="${2}"
  print_with_color "$message" "$color" >&2
}


fail(){
  local message="${1}"
  print_err "*** $(translate errors.installation_failed_header) ***" 'red'
  print_err "$message" 'red'
  print_err
  exit 1
}


INSTALL_LOG=install.log
SUPPORT_EMAIL=support@keitarotds.com

declare -A DICT

DICT['en.prompts.license_key']='Please enter license key'
DICT['en.prompts.db_name']='Please enter database name'
DICT['en.prompts.db_user']='Please enter database user name'
DICT['en.prompts.db_password']='Please enter database user password'
DICT['en.prompts.admin_login']='Please enter keitaro admin login'
DICT['en.prompts.admin_password']='Please enter keitaro admin password'
DICT['en.prompts.license_ip']='Please enter server IP'
DICT['en.prompts.license_ip']='Please enter server IP'
DICT['en.messages.run_command']='Evaluating command'
DICT['en.messages.successful_install']='Everything done!'
DICT['en.errors.installation_failed_header']='INSTALLATION FAILED'
DICT['en.errors.must_be_root']='You must run this program as root.'
DICT['en.errors.unsuccessful_install']="There was an error installing Keitaro TDS. Please send email to "$SUPPORT_EMAIL" with log "$INSTALL_LOG""
DICT['en.errors.yum_not_installed']='This installer works only on yum-based systems. Please run $(program_name) in CentOS/RHEL/Fedora distro'

DICT['ru.prompts.license_ip']='Укажите IP адрес сервера'
DICT['ru.prompts.license_key']='Укажите лицензионный ключ'
DICT['ru.prompts.db_name']='Укажите имя базы данных'
DICT['ru.prompts.db_user']='Укажите пользователя базы данных'
DICT['ru.prompts.db_password']='Укажите пароль пользователя базы данных'
DICT['ru.prompts.admin_login']='Укажите имя администратора keitaro'
DICT['ru.prompts.admin_password']='Укажите пароль администратора keitaro'
DICT['ru.messages.run_command']='Выполняется команда'
DICT['ru.messages.successful_install']='Установка завершена!'
DICT['ru.errors.installation_failed_header']='ОШИБКА УСТАНОВКИ'
DICT['ru.errors.must_be_root']='Эту программу может запускать только root.'
DICT['ru.errors.unsuccessful_install']="Во время установки Keitaro TDS произошла ошибка. Пожалуйста, отправьте email на "$SUPPORT_EMAIL" приложив "$INSTALL_LOG""
DICT['ru.errors.yum_not_installed']='Утановщик keitaro работает только с пакетным менеджером yum. Пожалуйста, запустите $(program_name) в CentOS/RHEL/Fedora дистрибутиве'


set_ui_lang(){
  if empty "$UI_LANG"; then
    UI_LANG=$(detect_language)
  fi
}

detect_language(){
  if ! empty "$LC_ALL"; then
    detect_language_from_var "$LC_ALL"
  else
    if ! empty "$LC_MESSAGES"; then
      detect_language_from_var "$LC_MESSAGES"
    else
      detect_language_from_var "$LANG"
    fi
  fi
}


translate(){
  local key="${1}"
  i18n_key=$UI_LANG.$key
  if isset ${DICT[$i18n_key]}; then
    echo "${DICT[$i18n_key]}"
  else
    echo "$i18n_key"
  fi
}


detect_language_from_var(){
  local lang_value="${1}"
  if [[ "$lang_value" =~ ^ru_[[:alpha:]]+\.UTF-8$ ]]; then
    echo ru
  else
    echo en
  fi
}





install_ansible_if_not_installed(){
  if ! is_installed ansible; then
    debug "Try to install ansible"
    install_package epel-release
    install_package ansible
  fi
}


install_keitarotds(){
  get_keitaro_provision
  command="ansible-playbook -i ${INVENTORY_FILE} ${KEITARO_PROVISION_DIRECTORY}/playbook.yml >${INSTALL_LOG}"
  run_command "$command" && handle_successful_install || handle_unsuccessful_install
}


is_installed(){
  local command="${1}"
  debug "Try to found "$command""
  if isset "$SKIP_CHECKS"; then
    debug "OK, skip actual checking of '$command' presence"
  else
    if [[ $(sh -c "command -v "$command" -gt /dev/null") ]]; then
      debug "OK, "$command" found"
    else
      debug "NOK, "$command" not found"
      return 1
    fi
  fi
}


install_package(){
  local package="${1}"
  run_command "yum install -y "$package""
}


get_keitaro_provision(){
  KEITARO_RELEASE_URL=https://github.com/keitarocorp/centos_provision/archive/master.tar.gz
  run_command "curl -sSL "$KEITARO_RELEASE_URL" | tar xz"
}


run_command(){
  local command="${1}"
  run_command_message=$(print_with_color "$(translate 'messages.run_command')" 'blue')
  echo -e "$run_command_message '$command'"
  if isset "$PRESERVE"; then
    debug "Actual running disabled"
  else
    eval "$command"
  fi
}


handle_successful_install(){
  print_with_color "$(translate 'messages.successful_install')" 'green'
  print_with_color "http://${VARS['license_ip']}/admin" 'light.green'
  colored_login=$(print_with_color "${VARS['admin_login']}" 'light.green')
  colored_password=$(print_with_color "${VARS['admin_password']}" 'light.green')
  echo -e "login: ${colored_login}"
  echo -e "password: ${colored_password}"
}


handle_unsuccessful_install(){
  fail "$(translate 'errors.unsuccessful_install')"
}



generate_password(){
  LC_ALL=C tr -cd '[:alnum:]' < /dev/urandom | head -c16
}


declare -A VARS

VARS['license_ip']=''
VARS['license_key']=''
VARS['db_name']='keitaro'
VARS['db_user']='keitaro'
VARS['db_password']=$(generate_password)
VARS['admin_login']='admin'
VARS['admin_password']=$(generate_password)

PASSWORD_LENGTH=16

write_inventory_file(){
  read_vars_from_inventory_file
  get_vars_from_user
  write_vars_to_inventory_file
}

read_vars_from_inventory_file(){
  if [ -f "$INVENTORY_FILE" ]; then
    debug "Inventory file found, read defaults from it"
    while IFS="" read -r line; do
      parse_line_from_inventory_file "$line"
    done <   $INVENTORY_FILE
  else
    debug "Inventory file not found"
  fi
}


get_vars_from_user(){
  get_var 'license_ip'
  get_var 'license_key'
  get_var 'db_name'
  get_var 'db_user'
  get_var 'db_password'
  get_var 'admin_login'
  get_var 'admin_password'
}


write_vars_to_inventory_file(){
  echo -n > "$INVENTORY_FILE"
  print_line_to_inventory_file "[server]"
  print_line_to_inventory_file "localhost connection=local"
  print_line_to_inventory_file
  print_line_to_inventory_file "[server:vars]"
  print_line_to_inventory_file "license_ip="${VARS['license_ip']}""
  print_line_to_inventory_file "license_key="${VARS['license_key']}""
  print_line_to_inventory_file "db_name="${VARS['db_name']}""
  print_line_to_inventory_file "db_user="${VARS['db_user']}""
  print_line_to_inventory_file "db_password="${VARS['db_password']}""
  print_line_to_inventory_file "admin_login="${VARS['admin_login']}""
  print_line_to_inventory_file "admin_password="${VARS['admin_password']}""
}


parse_line_from_inventory_file(){
  local line="${1}"
  if [[ "$line" =~ = ]]; then
    IFS="=" read var_name value <<< "$line"
    VARS[$var_name]=$value
    debug "  "$var_name"=${VARS[$var_name]}"
  fi
}


get_var(){
  local var_name="${1}"
  while true; do
    print_prompt "$var_name"
    read -r variable
    if ! empty "$variable"; then
      VARS[$var_name]=$variable
    fi
    if ! empty ${VARS[$var_name]}; then
      break
    fi
  done
}


print_prompt(){
  local var_name="${1}"
  prompt=$(translate "prompts.$var_name")
  prompt="$(print_with_color "$prompt" 'bold')"
  if ! empty ${VARS[$var_name]}; then
    prompt="$prompt [${VARS[$var_name]}]"
  fi
  echo -en "$prompt > "
}


print_line_to_inventory_file(){
  local line="${1}"
  echo "$line" >> "$INVENTORY_FILE"
}



parse_options(){
  while getopts ":hpvsl:" opt; do
    case $opt in
      p)
        PRESERVE=true
        ;;
      s)
        SKIP_CHECKS=true
        ;;
      v)
        VERBOSE=true
        ;;
      l)
        case $OPTARG in
          en)
            UI_LANG=en
            ;;
          ru)
            UI_LANG=ru
            ;;
          *)
            print_err "Specified language \"$OPTARG\" is not supported"
            exit 1
            ;;
        esac
        ;;
      :)
        print_err "Option -$OPTARG requires an argument."
        exit 1
        ;;
      h)
        usage
        exit 0
        ;;
      \?)
        usage
        exit 1
        ;;
    esac
  done
}



usage(){
  set_ui_lang
  if [[ "$UI_LANG" = 'ru' ]]; then
    ru_usage
  else
    en_usage
  fi
}

ru_usage(){
  print_err "$(program_name) устанавливает Keitaro TDS"
  print_err
  print_err "Использование: $(program_name) [-psv] [-l en|ru]"
  print_err
  print_err "  -p"
  print_err "    С опцией -p (preserve installation) $(program_name) не запускает установочные команды. Вместо этого текс команд будет показан на экране."
  print_err
  print_err "  -s"
  print_err "    С опцией -s (skip checks) $(program_name) не будет проверять присутствие yum/ansible в системе, не будет проверять факт запуска из под root."
  print_err
  print_err "  -v"
  print_err "    С опцией -v (verbose mode) $(program_name) будет выводить детальную информацию оп процессе установки."
  print_err
  print_err "  -l <lang>"
  print_err "    $(program_name) определяет язык через установленные переменные окружения LANG/LC_MESSAGES/LC_ALL, однако вы можете явно задать язык при помощи параметра -l."
  print_err "    На данный момент поддерживаются значения en и ru (для английского и русского языков)."
  print_err
}

en_usage(){
  print_err "$(program_name) installs Keitaro TDS"
  print_err
  print_err "Usage: $(program_name) [-psv] [-l en|ru]"
  print_err
  print_err "  -p"
  print_err "    The -p (preserve installation) option causes $(program_name) to preserve the invoking of installation commands. Installation commands will be printed to stdout instead."
  print_err
  print_err "  -s"
  print_err "    The -s (skip checks) option causes $(program_name) to skip checks of yum/ansible presence, skip check root running"
  print_err
  print_err "  -v"
  print_err "    The -v (verbose mode) option causes $(program_name) to display more verbose information of installation process."
  print_err
  print_err "  -l <lang>"
  print_err "    By default $(program_name) tries to detect language from LANG/LC_MESSAGES/LC_ALL environment variables, but you can explicitly set language with -l option."
  print_err "    Only en and ru (for English and Russian) values supported now."
  print_err
}




INVENTORY_FILE=hosts.txt
KEITARO_PROVISION_DIRECTORY=centos_provision-master



install(){
  parse_options "$@"
  set_ui_lang
  print_info
  assert_caller_root
  assert_yum_installed
  install_ansible_if_not_installed
  write_inventory_file
  install_keitarotds
}

install "$@"

# wait for all async child processes (because "await ... then" is used in powscript)
[[ $ASYNC == 1 ]] && wait


exit 0

