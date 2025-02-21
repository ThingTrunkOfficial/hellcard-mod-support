enum sound_events {
  IDLE,
  HIDE,
  BURN,
  LAND,
  DEATH,
  UNHIDE,
  APPEAR,
  ATTACK,
  DAMAGE,
  DAMAGE_ABSORB,
  SHIELD_CRUSH,
  UNPACK,
  FREEZE,
  EXPLODE,
  TRIGGER,
  WING_FLAP,
  DISAPPEAR,
  CRIT_JUMP,
  ADD_DEATH,
  CAST_START,
  ADD_APPEAR,
  MAGE_APPEAR,
  MAGE_DEATH,
  SCARE_JUMP,
};

string monsterId;

f32 sound_option_vol;
f32 sound_option_pitch;
f32 sound_option_delay;

f32 sound_option_vol_boss;
f32 sound_option_pitch_boss;

array<Sound @> sound_appear_arr;
array<string> sound_appear;
array<Sound @> sound_hide_arr;
array<string> sound_hide;
array<Sound @> sound_unhide_arr;
array<string> sound_unhide;
array<Sound @> sound_disappear_arr;
array<string> sound_disappear;
array<Sound @> sound_idle_arr;
array<string> sound_idle;
array<Sound @> sound_attack_arr;
array<string> sound_attack;
array<Sound @> sound_damage_arr;
array<string> sound_damage;
array<Sound @> sound_damage_absorb_arr;
array<string> sound_damage_absorb;
array<Sound @> sound_shield_crush_arr;
array<string> sound_shield_crush;
array<Sound @> sound_crit_jump_arr;
array<string> sound_crit_jump;
array<Sound @> sound_trigger_arr;
array<string> sound_trigger;
array<Sound @> sound_death_arr;
array<string> sound_death;
array<Sound @> sound_cast_start_arr;
array<string> sound_cast_start;
array<Sound @> sound_scare_jump_arr;
array<string> sound_scare_jump;
array<Sound @> sound_land_arr;
array<string> sound_land;
array<Sound @> sound_unpack_arr;
array<string> sound_unpack;

array<Sound @> sound_attack_boss_arr;
array<string> sound_attack_boss;
array<Sound @> sound_damage_boss_arr;
array<string> sound_damage_boss;
array<Sound @> sound_crit_jump_boss_arr;
array<string> sound_crit_jump_boss;
array<Sound @> sound_trigger_boss_arr;
array<string> sound_trigger_boss;
array<Sound @> sound_death_boss_arr;
array<string> sound_death_boss;
array<Sound @> sound_cast_start_boss_arr;
array<string> sound_cast_start_boss;
array<Sound @> sound_scare_jump_boss_arr;
array<string> sound_scare_jump_boss;
array<Sound @> sound_land_boss_arr;
array<string> sound_land_boss;

array<Sound @> sound_wing_flap_arr;
array<string> sound_wing_flap;

array<Sound @> sound_mage_appear_arr;
array<string> sound_mage_appear;

array<Sound @> sound_mage_death_arr;
array<string> sound_mage_death;

array<Sound @> sound_add_death_arr;
array<string> sound_add_death;
array<Sound @> sound_add_appear_arr;
array<string> sound_add_appear;

array<Sound @> sound_freeze_arr;
array<string> sound_freeze;
array<Sound @> sound_burn_arr;
array<string> sound_burn;
array<Sound @> sound_explode_arr;
array<string> sound_explode;

f32 demon_appear_speed_multiplier;

f32 attack_jump_length;
f32 db_att_delay;

f32 walk_mover_multiplier;
f32 idle_mover_multiplier;

f32 star_scale;

string hierarchy;
string boss_hierarchy;

////////////
// MOVERS //
////////////
int walk_mover_id;
int fly_mover_id;
int idle_mover_id;

f32 flying_speed;
f32 flying_speed_on_move;
f32 flying_noise_strenght;
f32 flying_noise_strenght_move;
f32 flying_noise_speed;

f32 winged_flap_speed;
f32 winged_flap_speed_on_move;
f32 winged_fade_time;

string death_fx;

string caster_appear_fx;
string caster_death_fx;
string caster_death_fx_floor;

string fire_death_fx;
string ice_death_fx;

/**
* poison_death_fx is the poison explosion by default, it is mainly used to
* set the toxic cloud size
*/
string poison_death_fx;

string appear_fx;
string disappear_fx;

string land_fx_f;
string land_fx_b;

BodDungSoundType footstep_sound_preset = BDST_FOOTSTEP_SILENT;

Point2D_f32 effect_offset;
Point2D_f32 boss_effect_offset;

f32 boss_scale;

// Death Shrapnel
/**
* Boss on death explosion effect.
*/

BodDecalPreset boss_death_fx_shrapnel_decal;
string boss_death_fx_shrapnel_effect;

f32 boss_death_fx_shrapnel_radius;
f32 boss_death_fx_shrapnel_scale;
s32 boss_death_fx_shrapnel_amount;

array <u32> boss_death_fx_shrapnel_sprite_range;
array <f32> boss_death_fx_shrapnel_delay_range;
array <f32> boss_death_fx_shrapnel_height_range;

bool boss_death_fx_shrapnel_use_true_dt;

// Caster
string caster_fx_back;
string caster_fx_front;
string caster_fx_floor;
string caster_fx_nonmagic_back;
string caster_fx_nonmagic_front;
string caster_fx_boss_back;
string caster_fx_boss_front;
bool   caster_nonmagic;

HierGenericEffectPreset appear_preset;
EaseType appear_preset_easeX;
EaseType appear_preset_easeY;
f32      appear_preset_speed_mult;

HierGenericEffectPreset disappear_preset;
EaseType disappear_preset_easeX;
EaseType disappear_preset_easeY;
Color    disappear_preset_CrashColorEnd;
Color    disappear_preset_CrashColorStart;
f32      disappear_preset_CrashScaleMax;
f32      disappear_preset_CrashScaleMin;
int      disappear_preset_CrashMaxY;
int      disappear_preset_CrashMinY;
f32      dissapear_preset_FadeToVal;
f32      dissapear_preset_FadeStart;
f32      dissapear_preset_FadeEnd;
f32      dissapear_preset_SpeedMult;

HierGenericEffectPreset boss_disappear_preset = HGEP_DEFAULT_DISAPPEAR;
EaseType boss_disappear_preset_easeY = EASE_SCURVE;
EaseType boss_disappear_preset_easeX = EASE_BACK;

string boss_death_fx;
