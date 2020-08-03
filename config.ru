# frozen_string_literal: true

app = ->(_env) { [200, { 'Content-Type' => 'text/plain' }, []] }

run app
