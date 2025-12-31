%% Biogas Burner Outlet Velocity, Port Mass Flow, and Port Loading Calculator with Excel Output
% This script calculates:
% 1. The mass fractions of CH4, CO2, O2, and N2 in the biogas-air mixture.
% 2. The total mass flow rate of the mixture.
% 3. The exit velocity of the gas mixture for different burner port configurations.
% 4. The mass flow rate through a single port.
%
% The results are then exported to an Excel file where:
% - The "Composition" sheet contains the overall composition for each air mixing scenario.
% - Separate sheets are created for each scenario (30%, 50%, and 70% air requirement)
%   with all burner configurations grouped for that scenario.
%
% Burner naming convention: 'BBG1/<number of ports>/<port diameter in mm>'
% For example, a burner with 22 ports of 5 mm diameter is identified as 'BBG1/22/5'.

clear; clc;

%% Given Data and Constants
m_biogas = 0.00013;          % kg/s, biogas mass flow rate
stoich_ratio = 5.712;        % stoichiometric air-to-biogas mass ratio

% Air mixing scenarios (as a fraction of the stoichiometric air requirement)
air_mix_percent = [0.3, 0.5, 0.7];

% Biogas composition (by volume) converted to mass fractions using molar masses:
% CH4: 16 g/mol, CO2: 44 g/mol
Y_CH4_biogas = 0.6 * 16 / (0.6 * 16 + 0.4 * 44);  % ~0.3529
Y_CO2_biogas = 0.4 * 44 / (0.6 * 16 + 0.4 * 44);  % ~0.6471

% Air composition (by volume: 21% O2, 79% N2) converted to mass fractions:
% O2: 32 g/mol, N2: 28 g/mol
Y_O2_air = 0.21 * 32 / (0.21 * 32 + 0.79 * 28);  % ~0.233
Y_N2_air = 0.79 * 28 / (0.21 * 32 + 0.79 * 28);  % ~0.767

% Updated densities and calorific value
biogas_density   = 1.0995;   % kg/m^3 for biogas
mixture_density  = 1.15;     % kg/m^3 for the mixture at outlet conditions
calorific_value  = 22e6;     % J/m^3 (22 MJ/m^3)

% Calculate the total burner input power (W)
% Volumetric flow of biogas (m^3/s) = m_biogas / biogas_density
input_power = (m_biogas / biogas_density) * calorific_value; % in Watts

%% Burner Port Configurations

% Set 1: Ports of 5 mm diameter
configs_5mm = [22, 37, 55, 111];  
port_diam_5mm = 5;              % mm
area_5mm = pi * ((port_diam_5mm/1000)/2)^2;    % m^2 (converted mm -> m)

% Set 2: Ports of 4 mm diameter
configs_4mm = [35, 58, 87, 173];
port_diam_4mm = 4;              % mm
area_4mm = pi * ((port_diam_4mm/1000)/2)^2;    % m^2

%% Initialize Tables
% Composition Table: one row per air mixing scenario
CompositionTable = table();

% Burner Configuration Table: one row per burner configuration
BurnerTable = table();

%% Calculations for Each Air Mixing Scenario
for s = 1:length(air_mix_percent)
    % Calculate the air mass flow rate for the scenario
    m_air = air_mix_percent(s) * stoich_ratio * m_biogas;
    
    % Total mass flow rate (biogas + air)
    m_total = m_biogas + m_air;
    
    % Mass of each species from the biogas and air:
    m_CH4 = m_biogas * Y_CH4_biogas;
    m_CO2 = m_biogas * Y_CO2_biogas;
    m_O2  = m_air * Y_O2_air;
    m_N2  = m_air * Y_N2_air;
    
    % Overall mass fractions in the mixture
    Y_CH4 = m_CH4 / m_total;
    Y_CO2 = m_CO2 / m_total;
    Y_O2  = m_O2  / m_total;
    Y_N2  = m_N2  / m_total;
    
    % Append Composition information for this scenario
    CompositionTable = [CompositionTable; 
        table(air_mix_percent(s)*100, m_total, Y_CH4, Y_CO2, Y_O2, Y_N2, ...
        'VariableNames',{'AirMixPercent_Percent','TotalMassFlow_kgps','Y_CH4','Y_CO2','Y_O2','Y_N2'})];
    
    %% Burner Configurations for 5 mm ports
    for i = 1:length(configs_5mm)
        n_ports = configs_5mm(i);
        total_area = n_ports * area_5mm;    % Total port area (m^2)
        exit_velocity = m_total / (mixture_density * total_area); % m/s
        mass_flow_per_port = m_total / n_ports;         % kg/s per port
        
        % Calculate Port Loading (W/mm^2)
        % Convert total area from m^2 to mm^2 (1 m^2 = 1e6 mm^2)
        port_loading = input_power / (total_area * 1e6); % W/mm^2
        
        % Burner name using the format 'BBG1/<number of ports>/<port diameter in mm>'
        burnerName = sprintf('BBG1/%d/%d', n_ports, port_diam_5mm);
        
        BurnerTable = [BurnerTable; table(air_mix_percent(s)*100, {burnerName}, port_diam_5mm, n_ports, m_total, exit_velocity, mass_flow_per_port, port_loading, ...
            'VariableNames',{'AirMixPercent_Percent','BurnerName','PortDiameter_mm','NumberOfPorts','TotalMassFlow_kgps','ExitVelocity_mps','MassFlowPerPort_kgps','PortLoading_W_per_mm2'})];
    end
    
    %% Burner Configurations for 4 mm ports
    for i = 1:length(configs_4mm)
        n_ports = configs_4mm(i);
        total_area = n_ports * area_4mm;    % Total port area (m^2)
        exit_velocity = m_total / (mixture_density * total_area); % m/s
        mass_flow_per_port = m_total / n_ports;         % kg/s per port
        
        % Calculate Port Loading (W/mm^2)
        port_loading = input_power / (total_area * 1e6); % W/mm^2
        
        burnerName = sprintf('BBG1/%d/%d', n_ports, port_diam_4mm);
        
        BurnerTable = [BurnerTable; table(air_mix_percent(s)*100, {burnerName}, port_diam_4mm, n_ports, m_total, exit_velocity, mass_flow_per_port, port_loading, ...
            'VariableNames',{'AirMixPercent_Percent','BurnerName','PortDiameter_mm','NumberOfPorts','TotalMassFlow_kgps','ExitVelocity_mps','MassFlowPerPort_kgps','PortLoading_W_per_mm2'})];
    end
end

%% Write Results to an Excel File
filename = 'BiogasBurnerResults MATLAB.xlsx';

% Write the overall composition table to a sheet called 'Composition'
writetable(CompositionTable, filename, 'Sheet', 'Composition');

% Group burner configurations by air mixing scenario and write each group to a separate sheet.
uniqueScenarios = unique(BurnerTable.AirMixPercent_Percent);
for i = 1:length(uniqueScenarios)
    scenario = uniqueScenarios(i);
    % Filter BurnerTable for the current scenario
    subsetTable = BurnerTable(BurnerTable.AirMixPercent_Percent == scenario, :);
    % Create a sheet name such as 'Scenario_30' (for 30% air requirement)
    sheetName = sprintf('Scenario_%d', scenario);
    writetable(subsetTable, filename, 'Sheet', sheetName);
end

fprintf('Results have been written to %s\n', filename);
