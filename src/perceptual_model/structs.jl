abstract type AbstractNode end
Base.@kwdef mutable struct NodeParams
    evolution_rate::AbstractFloat = 0
    value_coupling::Dict{String,AbstractFloat} = Dict{String,AbstractFloat}()
    volatility_coupling::Dict{String,AbstractFloat} = Dict{String,AbstractFloat}()
end
Base.@kwdef mutable struct NodeState
    posterior_mean::AbstractFloat = 0
    posterior_precision::AbstractFloat = 1
    value_prediction_error::Union{AbstractFloat,Missing} = missing
    volatility_prediction_error::Union{AbstractFloat,Missing} = missing
    prediction_mean::AbstractFloat = 0
    prediction_volatility::AbstractFloat = 0
    prediction_precision::AbstractFloat = 0
    auxiliary_prediction_precision::AbstractFloat = 0
end
Base.@kwdef mutable struct NodeHistory
    posterior_mean::Vector{AbstractFloat} = []
    posterior_precision::Vector{AbstractFloat} = []
    value_prediction_error::Vector{Union{AbstractFloat,Missing}} = [missing]
    volatility_prediction_error::Vector{Union{AbstractFloat,Missing}} = [missing]
    prediction_mean::Vector{AbstractFloat} = []
    prediction_volatility::Vector{AbstractFloat} = []
    prediction_precision::Vector{AbstractFloat} = []
    auxiliary_prediction_precision::Vector{AbstractFloat} = []
end
Base.@kwdef mutable struct StateNode <: AbstractNode
    name::String
    value_parents = []
    volatility_parents = []
    value_children = []
    volatility_children = []
    params::NodeParams = NodeParams()
    state::NodeState = NodeState()
    history::NodeHistory = NodeHistory()
end
Base.@kwdef mutable struct InputNodeParams
    evolution_rate::AbstractFloat = 0
    value_coupling::Dict{String,AbstractFloat} = Dict{String,AbstractFloat}()
    volatility_coupling::Dict{String,AbstractFloat} = Dict{String,AbstractFloat}()
end
Base.@kwdef mutable struct InputNodeState
    input_value::Union{AbstractFloat,Missing} = missing
    value_prediction_error::Union{AbstractFloat,Missing} = missing
    volatility_prediction_error::Union{AbstractFloat,Missing} = missing
    prediction_volatility::AbstractFloat = 0
    prediction_precision::AbstractFloat = 0
    auxiliary_prediction_precision::AbstractFloat = 0
end
Base.@kwdef mutable struct InputNodeHistory
    input_value::Vector{Union{AbstractFloat,Missing}} = [missing]
    value_prediction_error::Vector{Union{AbstractFloat,Missing}} = [missing]
    volatility_prediction_error::Vector{Union{AbstractFloat,Missing}} = [missing]
    prediction_volatility::Vector{AbstractFloat} = []
    prediction_precision::Vector{AbstractFloat} = []
    auxiliary_prediction_precision::Vector{AbstractFloat} = []
end
Base.@kwdef mutable struct InputNode <: AbstractNode
    name::String
    value_parents = []
    volatility_parents = []
    params::InputNodeParams = InputNodeParams()
    state::InputNodeState = InputNodeState()
    history::InputNodeHistory = InputNodeHistory()
end

mutable struct HGFStruct
    perceptual_model
    input_nodes::Dict{String,InputNode}
    state_nodes::Dict{String,StateNode}
    ordered_input_nodes::Vector{InputNode}
    ordered_state_nodes::Vector{StateNode}
end