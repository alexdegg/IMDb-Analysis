{% macro isAdult_description(isAdult) -%}

    case 
        when isAdult = FALSE then 'non-adult title'
        when isAdult = TRUE then 'adult title'
        else 'EMPTY'
    END
{%- endmacro %}