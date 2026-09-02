Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7ACC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E60C10F3E9;
	Thu,  3 Sep 2026 07:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="m1ypZuxM";
	dkim-atps=neutral
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FE310E822
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788388324; x=1788647524;
 bh=cU+mHpCE5AklMKmea6B0FHA+o+J9NLEbp5sKadjcQxg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=m1ypZuxMtNFDGjfJ7nyJDlywLsr6nehTGuOal72f9FwkKqnRIY7BbiDFgA4NqdnY3
 kBeAZWM1MSzjKk3uWioNKV/xeJaoWX5Cg0kxeft9RVtXCBAVyycZtza6zQdd8Kl6wG
 wn5bsJg1oDO9mKAFc4Te8wGn68QtGLx8UOWf464V1OASCCC4HQ2+RsM9r7jsO3uj1A
 NkXdIynFS5JXBZZu1HrsYF9/qR1VX/QdfIA9ZvT1P1UygpqNuVoQIq8yf8XNTJ0kq+
 fuhwIdgu/j3mebWNTHm2/23nkxYP2VPflyoMQ78XzXzrxEVMdCP71Af58l71ii+LsR
 u9YiZe59nKnLg==
Date: Wed, 02 Sep 2026 22:31:59 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com,
 stable@vger.kernel.org
Subject: [PATCH v2 3/4] drm/amd/display: pass userspace brightness to power
 module
Message-ID: <065649410e7f8682d15048a7a49cff5d89e54fb3.1788388049.git.arc@empyreal.works>
In-Reply-To: <cover.1788388049.git.arc@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <cover.1788388049.git.arc@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 132667f34c4ebdf17ba9adbaa530adf9debfeab3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The power module consumes millipercent and builds its own PWM lookup
table from the ATIF brightness transfer characteristics.

The Linux display manager instead converts the userspace request to a
firmware level, then derives a percentage from that hardware-domain
value. For a non-zero PWM minimum this maps the minimum above zero and
the maximum above 100 percent. It also applies the ATIF curve once in
the display manager and again in the power module.

Pass the original userspace percentage to the power module on PWM
panels. Keep the existing nits conversion for AUX panels, but keep the
resulting millinit value unmasked while the power module derives cached
percentages and PWM levels.

The brightness mask is a final DP source-level quirk. Carry it into the
power module and apply it immediately before an AMD AUX write or after
PWM derivation when the effective hardware handoff is PWM. This
preserves ordinary PWM, forced-PWM OLED, AUX fallback-to-PWM, live AMD
AUX, and mode-change replay without perturbing an intermediate unit.

DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE previously bypassed only the display
manager's copy of the curve. Wire it to the power module's existing
linear bypass and use the selected panel's policy rather than panel
zero's. Label the brightness trace value as millipercent or millinits so
the corrected input domain is explicit.

A live DCN 3.5.1 trace exposed the domain mismatch. KUnit coverage is
added separately.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260902-brightness-cover-abf809f2@e=
mpyreal.works?part=3D3
Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Cc: stable@vger.kernel.org # 7.2.x
Assisted-by: LLM
Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 44 ++++++++++++---
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  3 +-
 .../drm/amd/display/modules/inc/mod_power.h   |  1 +
 .../gpu/drm/amd/display/modules/power/power.c |  2 +
 .../drm/amd/display/modules/power/power_abm.c | 55 +++++++++++++++----
 .../amd/display/modules/power/power_helpers.h | 14 +++++
 9 files changed, 107 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ec483276d753..4e730527be4a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -425,7 +425,9 @@ static int amdgpu_dm_init_power_module(struct amdgpu_di=
splay_manager *dm)
 =09=09=09!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
 =09=09init_data[i].use_custom_backlight_caps =3D false;
 =09=09init_data[i].custom_backlight_caps_config_no =3D 0;
-=09=09init_data[i].use_linear_backlight_curve =3D false;
+=09=09init_data[i].use_linear_backlight_curve =3D
+=09=09=09!!(amdgpu_dc_debug_mask &
+=09=09=09   DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 =09=09init_data[i].def_varibright_enable =3D 0;
 =09=09init_data[i].varibright_level =3D 0;
 =09=09/*
@@ -436,6 +438,8 @@ static int amdgpu_dm_init_power_module(struct amdgpu_di=
splay_manager *dm)
 =09=09=09dm->backlight_caps[i].min_input_signal * 0x101;
 =09=09init_data[i].max_backlight_pwm =3D
 =09=09=09dm->backlight_caps[i].max_input_signal * 0x101;
+=09=09init_data[i].brightness_mask =3D
+=09=09=09dm->backlight_caps[i].brightness_mask;
 =09=09init_data[i].min_abm_backlight =3D
 =09=09=09dm->backlight_caps[i].min_input_signal * 0x101;
=20
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3524931451c8..5969c5fbe480 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -229,7 +229,7 @@ struct amdgpu_dm_backlight_caps {
 =09 */
 =09bool aux_support;
 =09/**
-=09 * @brightness_mask: After deriving brightness, OR it with this mask.
+=09 * @brightness_mask: OR this with the final source backlight value.
 =09 * Workaround for panels with issues with certain brightness values.
 =09 */
 =09u32 brightness_mask;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 424b33573a73..adeb4a7ab7c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -218,6 +218,39 @@ u32 convert_brightness_to_user(const struct amdgpu_dm_=
backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(convert_brightness_to_user);
=20
+static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backl=
ight_caps *caps,
+=09=09=09=09=09      u32 brightness)
+{
+=09unsigned int min, max;
+
+=09if (!get_brightness_range(caps, &min, &max) || max <=3D min)
+=09=09return 0;
+
+=09if (brightness >=3D max)
+=09=09return 100 * 1000;
+
+=09return DIV_ROUND_CLOSEST_ULL((u64)brightness * 100 * 1000, max);
+}
+
+STATIC_IFN_KUNIT
+u32 convert_brightness_for_power_module(const struct amdgpu_dm_backlight_c=
aps *caps,
+=09=09=09=09=09u32 user_brightness)
+{
+=09u32 brightness;
+
+=09if (!caps)
+=09=09return user_brightness;
+
+=09if (!caps->aux_support)
+=09=09return convert_brightness_to_millipercent(caps, user_brightness);
+
+=09brightness =3D convert_brightness_from_user(caps, user_brightness);
+
+=09return brightness;
+}
+
+EXPORT_IF_KUNIT(convert_brightness_for_power_module);
+
 STATIC_IFN_KUNIT
 struct dc_stream_state *dm_find_stream_with_link(
 =09struct amdgpu_display_manager *dm,
@@ -262,7 +295,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_displa=
y_manager *dm,
 =09bool rc =3D false, reallow_idle =3D false;
 =09struct drm_connector *connector;
 =09struct dc_stream_state *stream;
-=09unsigned int min, max;
=20
 =09list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, h=
ead) {
 =09=09struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(co=
nnector);
@@ -285,12 +317,9 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_displ=
ay_manager *dm,
 =09/* update scratch register */
 =09if (bl_idx =3D=3D 0)
 =09=09amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brigh=
tness[bl_idx]);
-=09brightness =3D convert_brightness_from_user(caps, dm->brightness[bl_idx=
]);
 =09link =3D (struct dc_link *)dm->backlight_link[bl_idx];
-
-=09/* Apply brightness quirk */
-=09if (caps->brightness_mask)
-=09=09brightness |=3D caps->brightness_mask;
+=09brightness =3D convert_brightness_for_power_module(caps,
+=09=09=09=09=09=09=09 dm->brightness[bl_idx]);
=20
 =09if (trace_amdgpu_dm_brightness_enabled()) {
 =09=09trace_amdgpu_dm_brightness(__builtin_return_address(0),
@@ -314,9 +343,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_displa=
y_manager *dm,
 =09=09rc =3D mod_power_set_backlight_nits(dm->power_module, stream, bright=
ness,
 =09=09=09AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
 =09} else {
-=09=09/* power module uses millipercent */
-=09=09get_brightness_range(caps, &min, &max);
-=09=09brightness =3D DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 10=
00;
 =09=09rc =3D mod_power_set_backlight_percent(dm->power_module, stream,
 =09=09=09=09=09=09     brightness, 0, false);
 =09}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 90bed0ea5d00..396e7654e299 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -72,6 +72,8 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_b=
acklight_caps *caps,
 =09=09=09=09 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps=
,
 =09=09=09       uint32_t brightness);
+u32 convert_brightness_for_power_module(const struct amdgpu_dm_backlight_c=
aps *caps,
+=09=09=09=09=09u32 user_brightness);
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm=
,
 =09=09=09=09=09 struct backlight_device *bd);
 void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps =
*caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index f33a2c1e0da5..5e7782f9e89f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -744,10 +744,11 @@ TRACE_EVENT(amdgpu_dm_brightness,
 =09=09__entry->aux =3D aux;
 =09=09__entry->ac =3D ac;
 =09),
-=09TP_printk("%ps: brightness requested=3D%u converted=3D%u aux=3D%s power=
=3D%s",
+=09TP_printk("%ps: brightness requested=3D%u converted=3D%u unit=3D%s aux=
=3D%s power=3D%s",
 =09=09  (void *)__entry->function,
 =09=09  (u32)__entry->user_brightness,
 =09=09  (u32)__entry->converted_brightness,
+=09=09  (__entry->aux) ? "millinits" : "millipercent",
 =09=09  (__entry->aux) ? "true" : "false",
 =09=09  (__entry->ac) ? "AC" : "DC"
 =09)
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/=
gpu/drm/amd/display/modules/inc/mod_power.h
index 02bee3b1956d..56b41861e164 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -19,6 +19,7 @@ struct mod_power_init_params {
=20
 =09unsigned int min_backlight_pwm;
 =09unsigned int max_backlight_pwm;
+=09unsigned int brightness_mask;
=20
 =09unsigned int min_abm_backlight;
 =09unsigned int num_backlight_levels;
diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gp=
u/drm/amd/display/modules/power/power.c
index ee15c14a899e..1d5e94893e36 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -157,6 +157,8 @@ struct mod_power *mod_power_create(struct dc *dc,
 =09=09=09=09init_params[inst].use_custom_backlight_caps;
 =09=09core_power->bl_prop[inst].custom_backlight_caps_config_no =3D
 =09=09=09=09init_params[inst].custom_backlight_caps_config_no;
+=09=09core_power->bl_prop[inst].brightness_mask =3D
+=09=09=09=09init_params[inst].brightness_mask;
=20
 =09=09// Do not allow less than 101 backlight levels
 =09=09if (init_params[inst].num_backlight_levels < 101)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/driver=
s/gpu/drm/amd/display/modules/power/power_abm.c
index 5e86889eaa84..0e00042bced4 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -3,6 +3,7 @@
 // Copyright 2026 Advanced Micro Devices, Inc.
=20
 #include "dm_services.h"
+#include "dm_helpers.h"
 #include "dc.h"
 #include "mod_power.h"
 #include "core_types.h"
@@ -266,6 +267,16 @@ void mod_power_set_backlight_control_type(struct core_=
power *core_power,
 =09core_power->bl_prop[inst].backlight_control_type =3D backlight_control_=
type;
 }
=20
+STATIC_IFN_KUNIT
+unsigned int backlight_apply_source_mask(struct core_power *core_power,
+=09=09=09=09=09 unsigned int backlight,
+=09=09=09=09=09 unsigned int inst)
+{
+=09return backlight | core_power->bl_prop[inst].brightness_mask;
+}
+
+EXPORT_IF_KUNIT(backlight_apply_source_mask);
+
 /* Returns true when the panel uses the VESA AUX backlight control path, w=
hich
  * requires zero-anchored linear brightness interpolation.
  */
@@ -529,7 +540,7 @@ static unsigned int backlight_millipercent_to_pwm_legac=
y(
 =09=09return 0;
=20
 =09// Bypass the brightness mapping LUT
-=09if (core_power->bl_prop->use_linear_backlight_curve) {
+=09if (core_power->bl_prop[inst].use_linear_backlight_curve) {
 =09=09pwm =3D core_power->bl_prop[inst].min_backlight_pwm +
 =09=09=09(unsigned int) div_u64((unsigned long long) millipercent *
 =09=09=09core_power->bl_prop[inst].backlight_range,
@@ -615,8 +626,10 @@ static unsigned int backlight_millinit_to_pwm_legacy(
  * 0 nits =3D 0 PWM and max_brightness_millinits =3D max_backlight_pwm.
  * Otherwise, falls back to the legacy min=E2=86=92max nits range mapping.
  */
-static unsigned int backlight_millinit_to_pwm(
-=09=09struct core_power *core_power, unsigned int millinit, unsigned int i=
nst)
+STATIC_IFN_KUNIT
+unsigned int backlight_millinit_to_pwm(struct core_power *core_power,
+=09=09=09=09       unsigned int millinit,
+=09=09=09=09       unsigned int inst)
 {
 =09if (!is_vesa_abc(core_power, inst))
 =09=09return backlight_millinit_to_pwm_legacy(core_power, millinit, inst);
@@ -639,6 +652,8 @@ static unsigned int backlight_millinit_to_pwm(
 =09=09=09core_power->bl_prop[inst].max_brightness_millinits);
 }
=20
+EXPORT_IF_KUNIT(backlight_millinit_to_pwm);
+
 static bool validate_ext_backlight_caps(
 =09=09struct dm_acpi_atif_backlight_caps *ext_backlight_caps)
 {
@@ -894,6 +909,7 @@ void mod_power_update_backlight_on_mode_change(
     bool is_hdr)
 {
     struct set_backlight_level_params backlight_level_params =3D { 0 };
+=09unsigned int backlight_millinit;
=20
 =09=09/* Cache the panel's backlight control type once at mode-change/init
 =09=09 * time. It is a stable per-panel property (decided in the OS shim
@@ -905,9 +921,15 @@ void mod_power_update_backlight_on_mode_change(
=20
 =09=09if ((link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control =3D=3D =
1 ||
 =09=09=09link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control =3D=3D 1)=
 &&
-=09=09=09link->backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX)
+=09=09=09link->backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX) {
+=09=09=09backlight_millinit =3D
+=09=09=09=09core_power->bl_state[panel_inst].backlight_millinit;
+=09=09=09backlight_millinit =3D
+=09=09=09=09backlight_apply_source_mask(core_power, backlight_millinit,
+=09=09=09=09=09=09=09    panel_inst);
 =09=09=09dc_link_set_backlight_level_nits(link, core_power->bl_state[panel=
_inst].isHDR,
-=09=09=09=09core_power->bl_state[panel_inst].backlight_millinit, 0);
+=09=09=09=09backlight_millinit, 0);
+=09=09}
=20
 =09=09backlight_level_params.frame_ramp =3D 0;
=20
@@ -918,11 +940,12 @@ void mod_power_update_backlight_on_mode_change(
 =09=09dc_link_set_backlight_level(link, &backlight_level_params);
 }
=20
-static bool set_backlight_millinits_aux(struct core_power *core_power,
-=09=09struct dc_stream_state *stream,
-=09=09unsigned int backlight_millinits,
-=09=09unsigned int transition_time_millisec,
-=09=09unsigned int inst)
+STATIC_IFN_KUNIT
+bool set_backlight_millinits_aux(struct core_power *core_power,
+=09=09=09=09 struct dc_stream_state *stream,
+=09=09=09=09 unsigned int backlight_millinits,
+=09=09=09=09 unsigned int transition_time_millisec,
+=09=09=09=09 unsigned int inst)
 {
 =09struct dc_link *link =3D NULL;
=20
@@ -939,10 +962,17 @@ static bool set_backlight_millinits_aux(struct core_p=
ower *core_power,
 =09=09link->dc->caps.dmub_caps.aux_backlight_support)
 =09=09return true;
=20
+=09if (link->backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX)
+=09=09backlight_millinits =3D
+=09=09=09backlight_apply_source_mask(core_power, backlight_millinits,
+=09=09=09=09=09=09    inst);
+
 =09return dc_link_set_backlight_level_nits(link, core_power->bl_state[inst=
].isHDR,
 =09=09=09backlight_millinits, transition_time_millisec);
 }
=20
+EXPORT_IF_KUNIT(set_backlight_millinits_aux);
+
 static bool set_backlight(struct core_power *core_power,
 =09=09struct dc_stream_state *stream,
 =09=09struct set_backlight_level_params *backlight_level_params,
@@ -1020,6 +1050,11 @@ void fill_backlight_level_params(struct core_power *=
core_power,
=20
 =09if (backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX && !is_hdr)
 =09=09backlight_level_params->control_type =3D BACKLIGHT_CONTROL_PWM;
+
+=09if (backlight_level_params->control_type =3D=3D BACKLIGHT_CONTROL_PWM)
+=09=09backlight_level_params->backlight_pwm_u16_16 =3D
+=09=09=09backlight_apply_source_mask(core_power, backlight_pwm,
+=09=09=09=09=09=09    panel_inst);
 }
=20
 bool mod_power_set_backlight_nits(struct mod_power *mod_power,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/dr=
ivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 68679fa10946..d4d8ebee1cde 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -94,6 +94,7 @@ struct pwr_backlight_properties {
 =09unsigned int min_backlight_pwm;
 =09unsigned int max_backlight_pwm;
 =09unsigned int backlight_range;
+=09unsigned int brightness_mask;
=20
 =09/* Describes the panel's min and max luminance in millinits measured
 =09 * on full white screen, in min and max backlight settings.
@@ -203,6 +204,19 @@ unsigned int backlight_millipercent_to_pwm(
 =09=09struct core_power *core_power, unsigned int millipercent, unsigned i=
nt inst);
 unsigned int backlight_millipercent_to_millinit(
 =09=09struct core_power *core_power, unsigned int millipercent, unsigned i=
nt inst);
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+unsigned int backlight_millinit_to_pwm(struct core_power *core_power,
+=09=09=09=09       unsigned int millinit,
+=09=09=09=09       unsigned int inst);
+unsigned int backlight_apply_source_mask(struct core_power *core_power,
+=09=09=09=09=09 unsigned int backlight,
+=09=09=09=09=09 unsigned int inst);
+bool set_backlight_millinits_aux(struct core_power *core_power,
+=09=09=09=09 struct dc_stream_state *stream,
+=09=09=09=09 unsigned int backlight_millinits,
+=09=09=09=09 unsigned int transition_time_millisec,
+=09=09=09=09 unsigned int inst);
+#endif
 void fill_backlight_level_params(struct core_power *core_power,
 =09struct set_backlight_level_params *backlight_level_params,
 =09int panel_inst, uint8_t aux_inst, unsigned int backlight_pwm,
--=20
2.54.0


