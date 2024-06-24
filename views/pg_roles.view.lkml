# The name of this view in Looker is "Pg Roles"
view: pg_roles {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: pg_catalog.pg_roles ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Oid" in Explore.

  dimension: oid {
    type: string
    sql: ${TABLE}."oid" ;;
  }

  dimension: rolbypassrls {
    type: yesno
    sql: ${TABLE}."rolbypassrls" ;;
  }

  dimension: rolcanlogin {
    type: yesno
    sql: ${TABLE}."rolcanlogin" ;;
  }

  dimension: rolconfig {
    type: string
    sql: ${TABLE}."rolconfig" ;;
  }

  dimension: rolconnlimit {
    type: number
    sql: ${TABLE}."rolconnlimit" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_rolconnlimit {
    type: sum
    sql: ${rolconnlimit} ;;  }
  measure: average_rolconnlimit {
    type: average
    sql: ${rolconnlimit} ;;  }

  dimension: rolcreatedb {
    type: yesno
    sql: ${TABLE}."rolcreatedb" ;;
  }

  dimension: rolcreaterole {
    type: yesno
    sql: ${TABLE}."rolcreaterole" ;;
  }

  dimension: rolinherit {
    type: yesno
    sql: ${TABLE}."rolinherit" ;;
  }

  dimension: rolname {
    type: string
    sql: ${TABLE}."rolname" ;;
  }

  dimension: rolpassword {
    type: string
    sql: ${TABLE}."rolpassword" ;;
  }

  dimension: rolreplication {
    type: yesno
    sql: ${TABLE}."rolreplication" ;;
  }

  dimension: rolsuper {
    type: yesno
    sql: ${TABLE}."rolsuper" ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: rolvaliduntil {
    type: time
    timeframes: [raw, time, date, week, month,hour, quarter, year]
    sql: ${TABLE}."rolvaliduntil" ;;
  }

  parameter: dynamic_last_update_date_selection {
    type: string
    allowed_value: {value: "Last Update Month"}
    allowed_value: {value: "Last Update Date"}
    allowed_value: {value: "Last Update Hour"}
  }

  dimension: dynamic_last_update_date_dimension {
    type: string
    label_from_parameter: dynamic_last_update_date_selection
    sql:
    {% if dynamic_last_update_date_selection._parameter_value == "'Last Update Month'" %} ${rolvaliduntil_month}
    {% elsif dynamic_last_update_date_selection._parameter_value == "'Last Update Hour'" %} ${rolvaliduntil_hour}
    {% else %} ${rolvaliduntil_date} {% endif %}

      ;;
  }

  measure: count {
    type: count
    drill_fields: [rolname]
  }
}
