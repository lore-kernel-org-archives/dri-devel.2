Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132D2C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A76A10F3D4;
	Thu,  3 Sep 2026 07:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="J0KMevOO";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D1610F1B3
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788352359; x=1788611559;
 bh=TtQB3bvuIw6qqZqo5OFatGDqsqwyLHaGUzXVPABnou4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=J0KMevOOnZ+DJQcSD90B5AQQB6BV1Rn/51KRY334BRUuz4qqczIlmp/6iavNjWnKZ
 7X4sb/1UpLv2hXH/L334P+lDaEUQkouzIsQU/nhewsJM4gNIr1hkfRGpVoMvr24RQw
 RaMbNL6MFBqObrR7gq4IrBQ8uUHXUb2ANmBjMV2WOg9WgjnGQE0dne3lfSH8CVWb2W
 rEFw32yFpQRxTPzu/cyszdL96cwbPN3Gc+XKP8GO3tUhPIlg/pUrjFqi3gRPHI5R7Y
 dmZ7ia00EHMFAKUL1AlEPPtGM5BzoXIEZTIM7LRK6mAwwSVlexAEh52JhE3fMNTxiq
 b1IS3RTvKMcPA==
Date: Wed, 02 Sep 2026 12:32:29 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com,
 stable@vger.kernel.org
Subject: [PATCH 3/4] drm/amd/display: pass userspace brightness to power module
Message-ID: <20260902-brightness-3-50f94618@empyreal.works>
In-Reply-To: <20260902-brightness-cover-abf809f2@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 5d77d30cad3537273c8d09ea7186f4c942ade71b
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
panels. Keep the existing nits conversion and source-unit brightness
mask for AUX panels.

The brightness mask is a final DP source-level quirk. Carry it into the
power module and apply it when the effective hardware handoff is PWM,
preserving ordinary PWM, forced-PWM OLED, fallback PWM, and mode-change
replay without altering a true AUX handoff.

DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE previously bypassed only the display
manager's copy of the curve. Wire it to the power module's existing
linear bypass and use the selected panel's policy rather than panel
zero's. Label the brightness trace value as millipercent or millinits so
the corrected input domain is explicit.

A live DCN 3.5.1 trace exposed the domain mismatch. KUnit coverage is
added separately.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Cc: stable@vger.kernel.org # 7.2.x

Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 46 +++++++++++++++----
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  3 +-
 .../drm/amd/display/modules/inc/mod_power.h   |  1 +
 .../gpu/drm/amd/display/modules/power/power.c |  2 +
 .../drm/amd/display/modules/power/power_abm.c |  6 ++-
 .../amd/display/modules/power/power_helpers.h |  1 +
 8 files changed, 55 insertions(+), 12 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 424b33573a73..04e810af4623 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -218,6 +218,41 @@ u32 convert_brightness_to_user(const struct amdgpu_dm_=
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
+=09if (caps->brightness_mask)
+=09=09brightness |=3D caps->brightness_mask;
+
+=09return brightness;
+}
+
+EXPORT_IF_KUNIT(convert_brightness_for_power_module);
+
 STATIC_IFN_KUNIT
 struct dc_stream_state *dm_find_stream_with_link(
 =09struct amdgpu_display_manager *dm,
@@ -262,7 +297,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_displa=
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
@@ -285,12 +319,9 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_displ=
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
@@ -314,9 +345,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_displa=
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
index 5e86889eaa84..4d7d80ac60c9 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -529,7 +529,7 @@ static unsigned int backlight_millipercent_to_pwm_legac=
y(
 =09=09return 0;
=20
 =09// Bypass the brightness mapping LUT
-=09if (core_power->bl_prop->use_linear_backlight_curve) {
+=09if (core_power->bl_prop[inst].use_linear_backlight_curve) {
 =09=09pwm =3D core_power->bl_prop[inst].min_backlight_pwm +
 =09=09=09(unsigned int) div_u64((unsigned long long) millipercent *
 =09=09=09core_power->bl_prop[inst].backlight_range,
@@ -1020,6 +1020,10 @@ void fill_backlight_level_params(struct core_power *=
core_power,
=20
 =09if (backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX && !is_hdr)
 =09=09backlight_level_params->control_type =3D BACKLIGHT_CONTROL_PWM;
+
+=09if (backlight_level_params->control_type =3D=3D BACKLIGHT_CONTROL_PWM)
+=09=09backlight_level_params->backlight_pwm_u16_16 |=3D
+=09=09=09bl_prop->brightness_mask;
 }
=20
 bool mod_power_set_backlight_nits(struct mod_power *mod_power,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/dr=
ivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 68679fa10946..1eeacbfb8d91 100644
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

