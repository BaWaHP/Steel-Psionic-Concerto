NDefines.NMilitary.MAX_DIVISION_SUPPORT_WIDTH = 2;

NDefines.NSupply.CAPITAL_SUPPLY_BASE = 6;
NDefines.NSupply.CAPITAL_INITIAL_SUPPLY_FLOW = 6;
NDefines.NSupply.NODE_INITIAL_SUPPLY_FLOW = 3;
NDefines.NSupply.NODE_STARTING_PENALTY_PER_PROVINCE = 0.3;
NDefines.NSupply.NODE_ADDED_PENALTY_PER_PROVINCE = 0.4;
NDefines.NSupply.NAVAL_BASE_ADDED_PENALTY_PER_PROVINCE = 0.6
NDefines.NSupply.INFRA_TO_SUPPLY = 0.5
NDefines.NSupply.SUPPLY_FROM_DAMAGED_INFRA = 0.2
NDefines.NSupply.VP_TO_SUPPLY_BONUS_CONVERSION = 0.1
NDefines.NSupply.AVAILABLE_MANPOWER_STATE_SUPPLY = 0.3

NDefines.NGame.START_DATE = "1998.1.1.1"
NDefines.NGame.END_DATE = "2020.1.1.1"

NDefines.NGame.MAX_SCRIPTED_LOC_RECURSION = 100

NDefines.NAI.PLAN_ACTIVATION_SUPERIORITY_AGGRO = 1.8 --default 1.0		-- How aggressive a country is in activating a plan based on how superiour their force is.
NDefines.NAI.ATTACK_HEAVILY_DEFENDED_LIMIT = 0.25 --default 0.5		-- AI will not launch attacks against heavily defended fronts unless they consider to have this level of advantage (1.0 = 100%)
NDefines.NAI.MIN_PLAN_VALUE_TO_MICRO_INACTIVE = 0.1 --default 0.2				-- The AI will not consider members of groups which plan is not activated AND evaluates lower than this.

NDefines_Graphics.NGraphics.COUNTRY_FLAG_TEX_MAX_SIZE = 2048 --default 256 Tweak dependly on amount of countries. Must be power of 2. No more then 2048.
NDefines_Graphics.NGraphics.COUNTRY_FLAG_MEDIUM_TEX_MAX_SIZE = 1024 --default 1024 Tweak dependly on amount of countries. Must be power of 2. No more then 2048.
NDefines_Graphics.NGraphics.COUNTRY_FLAG_SMALL_TEX_MAX_SIZE = 512 --default 256 Tweak dependly on amount of countries. Must be power of 2. No more then 2048.

NDefines.NProduction.MINIMUM_NUMBER_OF_FACTORIES_TAKEN_BY_CONSUMER_GOODS_VALUE = 0
NDefines.NProduction.MINIMUM_NUMBER_OF_FACTORIES_TAKEN_BY_CONSUMER_GOODS_PERCENT = 0

NDefines.NCountry.DAYS_OF_WAR_BEFORE_SURRENDER = 10000
NDefines.NDiplomacy.BASE_CONDITIONAL_PEACE_MONTHS = 1000
