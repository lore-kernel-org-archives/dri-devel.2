Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4DAC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AE610F401;
	Thu,  3 Sep 2026 07:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="OEldap3x";
	dkim-atps=neutral
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1008C10E532
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788388351; x=1788647551;
 bh=aoMYyzPh1OMrjaFY85SJglQKmUz4G4YGKmqO7ZFqF00=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=OEldap3xzGWrAZdkHfXeaw7qNi/Rf6rv+5qaGSfOKbHXYMlIxPPj1IBJVHPnqzQy8
 r9eirWuH0Z1qjYhzsyf5MBFg7OeV271AZTbITLNNAqTtggUwmkXrxXQFysgSc20El3
 eS8rqZd0DbC/HmaNYBh+TR+EhcLEp4xmbI875oqOvXBsKjXdtSfaKYlSMsqOXIWuWA
 xyzr5DNc9VMqP0jYvkZW/CAVQHmhxpXgAsAh8Ts3PProO9IpipGyLp7MzWvW1dYcZk
 f10fKv71GPwl/J9in8mGtCHl62Rm5nAj1Fb0npDRgMLRgHU9Ms8HBmeMolumbGz+O/
 M0YYomKmvWtTQ==
Date: Wed, 02 Sep 2026 22:32:25 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com
Subject: [PATCH v2 4/4] drm/amd/display: test power module brightness input
 domain
Message-ID: <796855d751af2cfd5d1fcc376f6519c870cafe02.1788388049.git.arc@empyreal.works>
In-Reply-To: <cover.1788388049.git.arc@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <cover.1788388049.git.arc@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: dd2b5eea7d2c5800af0aa61eb7209ea31bf048b4
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

Exercise the exact values selected for the power module and the final
PWM and AMD AUX handoffs. Cover non-zero and zero PWM minimums, both
endpoints, an interior value, clamping, invalid caps, custom-curve
retention, multiple panels, and the source-level brightness mask.

The PWM case carries valid ATIF points to prove that the display manager
passes the userspace percentage without applying that curve before the
power module applies its own lookup table. Additional cases prove that
the brightness mask follows the final hardware domain: the mathematical
AUX millinit remains unmasked, direct AMD AUX receives the mask, and an
AUX fallback derives PWM from the clean millinit before applying the
final PWM mask.

The composition case uses an input for which masking the intermediate
millinit changes the derived PWM value. It fails against the v1
implementation and passes when the mask is applied only at the final
hardware handoffs. Callback captures independently verify the live AMD
AUX value, the unchanged VESA AUX value, and the mode-change replay
value. The selected panel's linear-curve bypass is covered independently.

The cases were verified under UML KUnit.

Assisted-by: LLM
Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 .../tests/amdgpu_dm_backlight_test.c          | 334 +++++++++++++++++-
 1 file changed, 331 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_=
test.c
index a6fa052a8272..7ab47a66c915 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.=
c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.=
c
@@ -23,6 +23,7 @@
 #include "amdgpu_dm_kunit_test_helpers.h"
 #include "amd_shared.h"
 #include "link_service.h"
+#include "modules/power/power_helpers.h"
 #include "dc/inc/hw/panel_cntl.h"
=20
 struct dm_backlight_connector_fixture {
@@ -31,6 +32,33 @@ struct dm_backlight_connector_fixture {
 =09struct dc_link *link;
 };
=20
+struct dm_backlight_aux_capture {
+=09unsigned int calls;
+=09unsigned int backlight_millinits;
+=09unsigned int transition_time_millisec;
+=09bool is_hdr;
+};
+
+static struct dm_backlight_aux_capture *dm_backlight_aux_capture;
+
+static bool dm_test_capture_backlight_nits(struct dc_link *link, bool is_h=
dr,
+=09=09=09=09=09   u32 backlight_millinits,
+=09=09=09=09=09   u32 transition_time_in_ms)
+{
+=09dm_backlight_aux_capture->calls++;
+=09dm_backlight_aux_capture->backlight_millinits =3D backlight_millinits;
+=09dm_backlight_aux_capture->transition_time_millisec =3D transition_time_=
in_ms;
+=09dm_backlight_aux_capture->is_hdr =3D is_hdr;
+
+=09return true;
+}
+
+static bool dm_test_capture_backlight_level(const struct dc_link *link,
+=09=09=09=09=09    struct set_backlight_level_params *params)
+{
+=09return true;
+}
+
 static const struct drm_connector_funcs dm_backlight_test_connector_funcs =
=3D {
 =09.reset =3D drm_atomic_helper_connector_reset,
 =09.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state=
,
@@ -1019,6 +1047,296 @@ static void dm_test_brightness_from_user_aux(struct=
 kunit *test)
 =09KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)ma=
x);
 }
=20
+/* Tests for convert_brightness_for_power_module() */
+
+/**
+ * dm_test_power_module_brightness_invalid_caps - Test invalid PWM range
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_brightness_invalid_caps(struct kunit *tes=
t)
+{
+=09struct amdgpu_dm_backlight_caps caps =3D {};
+
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(NULL, 100), 1=
00U);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, 100), =
0U);
+}
+
+/**
+ * dm_test_power_module_pwm_uses_user_domain - Test PWM input domain
+ * @test: The KUnit test context
+ *
+ * The power module owns the ATIF luminance-to-PWM curve. The display mana=
ger
+ * must therefore pass the original userspace percentage rather than first
+ * converting it to a firmware PWM level.
+ */
+static void dm_test_power_module_pwm_uses_user_domain(struct kunit *test)
+{
+=09struct amdgpu_dm_backlight_caps caps =3D {};
+=09unsigned int min, max;
+
+=09caps.min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+=09caps.max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+=09caps.data_points =3D 3;
+=09caps.luminance_data[0].input_signal =3D 50;
+=09caps.luminance_data[0].luminance =3D 20;
+=09caps.luminance_data[1].input_signal =3D 128;
+=09caps.luminance_data[1].luminance =3D 50;
+=09caps.luminance_data[2].input_signal =3D 230;
+=09caps.luminance_data[2].luminance =3D 90;
+=09get_brightness_range(&caps, &min, &max);
+
+=09KUNIT_EXPECT_EQ(test, min, 3084U);
+=09KUNIT_EXPECT_EQ(test, max, 65535U);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, 0), 0U=
);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, 25700)=
, 39216U);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, 32768)=
, 50001U);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, max), =
100000U);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, max + =
1), 100000U);
+}
+
+/**
+ * dm_test_power_module_pwm_zero_min - Test zero-minimum range
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_pwm_zero_min(struct kunit *test)
+{
+=09struct amdgpu_dm_backlight_caps caps =3D {};
+=09unsigned int min, max;
+
+=09caps.min_input_signal =3D 0;
+=09caps.max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+=09get_brightness_range(&caps, &min, &max);
+
+=09KUNIT_EXPECT_EQ(test, min, 0U);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, 0), 0U=
);
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, max), =
100000U);
+}
+
+/**
+ * dm_test_power_module_mask_follows_effective_control - Test mask handoff
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_mask_follows_effective_control(struct kun=
it *test)
+{
+=09struct set_backlight_level_params params =3D {};
+=09struct core_power core_power =3D {};
+
+=09core_power.bl_prop[0].brightness_mask =3D 3;
+=09fill_backlight_level_params(&core_power, &params, 0, 0, 3084,
+=09=09=09=09    BACKLIGHT_CONTROL_PWM, 0, 0, false);
+=09KUNIT_EXPECT_EQ(test, params.backlight_pwm_u16_16, 3087U);
+
+=09fill_backlight_level_params(&core_power, &params, 0, 0, 32896,
+=09=09=09=09    BACKLIGHT_CONTROL_PWM, 0, 0, false);
+=09KUNIT_EXPECT_EQ(test, params.backlight_pwm_u16_16, 32899U);
+
+=09fill_backlight_level_params(&core_power, &params, 0, 0, 65535,
+=09=09=09=09    BACKLIGHT_CONTROL_PWM, 0, 0, false);
+=09KUNIT_EXPECT_EQ(test, params.backlight_pwm_u16_16, 65535U);
+
+=09fill_backlight_level_params(&core_power, &params, 0, 0, 3084,
+=09=09=09=09    BACKLIGHT_CONTROL_AMD_AUX, 0, 0, true);
+=09KUNIT_EXPECT_EQ(test, params.control_type, BACKLIGHT_CONTROL_AMD_AUX);
+=09KUNIT_EXPECT_EQ(test, params.backlight_pwm_u16_16, 3084U);
+
+=09fill_backlight_level_params(&core_power, &params, 0, 0, 3084,
+=09=09=09=09    BACKLIGHT_CONTROL_AMD_AUX, 0, 0, false);
+=09KUNIT_EXPECT_EQ(test, params.control_type, BACKLIGHT_CONTROL_PWM);
+=09KUNIT_EXPECT_EQ(test, params.backlight_pwm_u16_16, 3087U);
+}
+
+/**
+ * dm_test_power_module_linear_curve_uses_panel_instance - Test linear byp=
ass
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_linear_curve_uses_panel_instance(struct k=
unit *test)
+{
+=09struct core_power core_power =3D {};
+=09unsigned int backlight_lut[101] =3D {};
+
+=09core_power.bl_prop[0].backlight_lut =3D backlight_lut;
+=09core_power.bl_prop[0].num_backlight_levels =3D ARRAY_SIZE(backlight_lut=
);
+=09core_power.bl_prop[1].min_backlight_pwm =3D 3084;
+=09core_power.bl_prop[1].max_backlight_pwm =3D 65535;
+=09core_power.bl_prop[1].backlight_range =3D 62451;
+=09core_power.bl_prop[1].use_linear_backlight_curve =3D true;
+=09backlight_lut[50] =3D 12345;
+
+=09KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(&core_power, 50000,=
 1),
+=09=09=0934309U);
+}
+
+/**
+ * dm_test_power_module_aux_keeps_curve_unmasked - Test AUX conversion pat=
h
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_aux_keeps_curve_unmasked(struct kunit *te=
st)
+{
+=09struct amdgpu_dm_backlight_caps caps =3D {};
+=09uint saved_mask =3D amdgpu_dm_get_dc_debug_mask();
+
+=09amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_=
CURVE);
+=09caps.aux_support =3D true;
+=09caps.aux_min_input_signal =3D 1;
+=09caps.aux_max_input_signal =3D 512;
+=09caps.brightness_mask =3D 3;
+=09caps.data_points =3D 2;
+=09caps.luminance_data[0].input_signal =3D 50;
+=09caps.luminance_data[0].luminance =3D 20;
+=09caps.luminance_data[1].input_signal =3D 200;
+=09caps.luminance_data[1].luminance =3D 80;
+
+=09KUNIT_EXPECT_EQ(test, convert_brightness_for_power_module(&caps, 200000=
),
+=09=09=0981157U);
+
+=09amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_power_module_aux_mask_composition - Compare both final handoffs
+ * @test: The KUnit test context
+ *
+ * AMD AUX writes millinits directly to DP_SOURCE_BACKLIGHT_LEVEL, while i=
ts
+ * non-HDR fallback derives a PWM value from the cached millinits. Applyin=
g
+ * the source-level mask before that conversion can therefore change the P=
WM
+ * before the PWM-domain mask is applied.
+ */
+static void dm_test_power_module_aux_mask_composition(struct kunit *test)
+{
+=09struct set_backlight_level_params params =3D {};
+=09struct amdgpu_dm_backlight_caps caps =3D {};
+=09struct core_power core_power =3D {};
+=09uint saved_mask =3D amdgpu_dm_get_dc_debug_mask();
+=09u32 aux_level, millinit, pwm;
+
+=09amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_=
CURVE);
+=09caps.aux_support =3D true;
+=09caps.aux_min_input_signal =3D 1;
+=09caps.aux_max_input_signal =3D 512;
+=09caps.brightness_mask =3D 3;
+=09caps.data_points =3D 2;
+=09caps.luminance_data[0].input_signal =3D 50;
+=09caps.luminance_data[0].luminance =3D 20;
+=09caps.luminance_data[1].input_signal =3D 200;
+=09caps.luminance_data[1].luminance =3D 80;
+
+=09core_power.bl_prop[0].min_backlight_pwm =3D 3084;
+=09core_power.bl_prop[0].max_backlight_pwm =3D 65535;
+=09core_power.bl_prop[0].backlight_range =3D 62451;
+=09core_power.bl_prop[0].min_brightness_millinits =3D 1000;
+=09core_power.bl_prop[0].max_brightness_millinits =3D 270000;
+=09core_power.bl_prop[0].nits_range =3D 269000;
+=09core_power.bl_prop[0].brightness_mask =3D 3;
+=09core_power.bl_prop[0].backlight_control_type =3D BACKLIGHT_CONTROL_AMD_=
AUX;
+
+=09millinit =3D convert_brightness_for_power_module(&caps, 51200);
+=09aux_level =3D backlight_apply_source_mask(&core_power, millinit, 0);
+=09pwm =3D backlight_millinit_to_pwm(&core_power, millinit, 0);
+=09fill_backlight_level_params(&core_power, &params, 0, 0, pwm,
+=09=09=09=09    BACKLIGHT_CONTROL_AMD_AUX, millinit, 0,
+=09=09=09=09    false);
+
+=09KUNIT_EXPECT_EQ(test, millinit, 7012U);
+=09KUNIT_EXPECT_EQ(test, aux_level, 7015U);
+=09KUNIT_EXPECT_EQ(test, pwm, 4479U);
+=09KUNIT_EXPECT_EQ(test, params.control_type, BACKLIGHT_CONTROL_PWM);
+=09KUNIT_EXPECT_EQ(test, params.backlight_pwm_u16_16, 4479U);
+
+=09amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_power_module_live_aux_handoff_mask - Test the live AUX callback
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_live_aux_handoff_mask(struct kunit *test)
+{
+=09struct dm_backlight_aux_capture *capture;
+=09struct link_service *link_srv;
+=09struct core_power *core_power;
+=09struct dc_stream_state *stream;
+=09struct dc_link *link;
+=09struct dc *dc;
+
+=09capture =3D kunit_kzalloc(test, sizeof(*capture), GFP_KERNEL);
+=09link_srv =3D kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+=09core_power =3D kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
+=09stream =3D kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+=09link =3D kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+=09dc =3D kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, capture);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, core_power);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+=09dm_backlight_aux_capture =3D capture;
+=09link_srv->edp_set_backlight_level_nits =3D dm_test_capture_backlight_ni=
ts;
+=09dc->link_srv =3D link_srv;
+=09link->dc =3D dc;
+=09link->backlight_control_type =3D BACKLIGHT_CONTROL_AMD_AUX;
+=09stream->link =3D link;
+=09core_power->bl_prop[0].brightness_mask =3D 3;
+
+=09KUNIT_ASSERT_TRUE(test, set_backlight_millinits_aux(core_power, stream,
+=09=09=09=09=09=09=09    7012, 50, 0));
+=09KUNIT_EXPECT_EQ(test, capture->calls, 1U);
+=09KUNIT_EXPECT_EQ(test, capture->backlight_millinits, 7015U);
+=09KUNIT_EXPECT_EQ(test, capture->transition_time_millisec, 50U);
+=09KUNIT_EXPECT_FALSE(test, capture->is_hdr);
+
+=09memset(capture, 0, sizeof(*capture));
+=09link->backlight_control_type =3D BACKLIGHT_CONTROL_VESA_AUX;
+=09KUNIT_ASSERT_TRUE(test, set_backlight_millinits_aux(core_power, stream,
+=09=09=09=09=09=09=09    7012, 50, 0));
+=09KUNIT_EXPECT_EQ(test, capture->calls, 1U);
+=09KUNIT_EXPECT_EQ(test, capture->backlight_millinits, 7012U);
+
+=09dm_backlight_aux_capture =3D NULL;
+}
+
+/**
+ * dm_test_power_module_mode_change_aux_mask - Test replay AUX callback
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_mode_change_aux_mask(struct kunit *test)
+{
+=09struct dm_backlight_aux_capture *capture;
+=09struct link_service *link_srv;
+=09struct core_power *core_power;
+=09struct dc_link *link;
+=09struct dc *dc;
+
+=09capture =3D kunit_kzalloc(test, sizeof(*capture), GFP_KERNEL);
+=09link_srv =3D kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+=09core_power =3D kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
+=09link =3D kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+=09dc =3D kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, capture);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, core_power);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+=09dm_backlight_aux_capture =3D capture;
+=09link_srv->edp_set_backlight_level_nits =3D dm_test_capture_backlight_ni=
ts;
+=09link_srv->edp_set_backlight_level =3D dm_test_capture_backlight_level;
+=09dc->link_srv =3D link_srv;
+=09link->dc =3D dc;
+=09link->backlight_control_type =3D BACKLIGHT_CONTROL_AMD_AUX;
+=09link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control =3D 1;
+=09core_power->bl_state[0].backlight_millinit =3D 7012;
+=09core_power->bl_prop[0].brightness_mask =3D 3;
+
+=09mod_power_update_backlight_on_mode_change(core_power, link, 0, 0, false=
);
+=09KUNIT_EXPECT_EQ(test, capture->calls, 1U);
+=09KUNIT_EXPECT_EQ(test, capture->backlight_millinits, 7015U);
+=09KUNIT_EXPECT_EQ(test, capture->transition_time_millisec, 0U);
+
+=09dm_backlight_aux_capture =3D NULL;
+}
+
 /* Tests for convert_custom_brightness() */
=20
 /**
@@ -1590,7 +1908,7 @@ static void dm_test_curve_from_user_monotonic(struct =
kunit *test)
 =09for (i =3D 0; i <=3D max; i +=3D 1023) {
 =09=09u32 level =3D convert_brightness_from_user(&caps, i);
=20
-=09=09KUNIT_ASSERT_GE(test, level, previous);
+=09=09KUNIT_EXPECT_GE(test, level, previous);
 =09=09previous =3D level;
 =09}
=20
@@ -1619,8 +1937,8 @@ static void dm_test_curve_from_user_within_range(stru=
ct kunit *test)
 =09for (i =3D 0; i <=3D max; i +=3D 1023) {
 =09=09u32 level =3D convert_brightness_from_user(&caps, i);
=20
-=09=09KUNIT_ASSERT_GE(test, level, (u32)min);
-=09=09KUNIT_ASSERT_LE(test, level, (u32)max);
+=09=09KUNIT_EXPECT_GE(test, level, (u32)min);
+=09=09KUNIT_EXPECT_LE(test, level, (u32)max);
 =09}
=20
 =09KUNIT_EXPECT_LE(test, convert_brightness_from_user(&caps, max), (u32)ma=
x);
@@ -2198,6 +2516,16 @@ static struct kunit_case dm_backlight_test_cases[] =
=3D {
 =09KUNIT_CASE(dm_test_brightness_from_user_zero),
 =09KUNIT_CASE(dm_test_brightness_from_user_max),
 =09KUNIT_CASE(dm_test_brightness_from_user_aux),
+=09/* convert_brightness_for_power_module */
+=09KUNIT_CASE(dm_test_power_module_brightness_invalid_caps),
+=09KUNIT_CASE(dm_test_power_module_pwm_uses_user_domain),
+=09KUNIT_CASE(dm_test_power_module_pwm_zero_min),
+=09KUNIT_CASE(dm_test_power_module_mask_follows_effective_control),
+=09KUNIT_CASE(dm_test_power_module_linear_curve_uses_panel_instance),
+=09KUNIT_CASE(dm_test_power_module_aux_keeps_curve_unmasked),
+=09KUNIT_CASE(dm_test_power_module_aux_mask_composition),
+=09KUNIT_CASE(dm_test_power_module_live_aux_handoff_mask),
+=09KUNIT_CASE(dm_test_power_module_mode_change_aux_mask),
 =09/* convert_custom_brightness */
 =09KUNIT_CASE(dm_test_custom_brightness_no_data_points),
 =09KUNIT_CASE(dm_test_custom_brightness_debug_mask_disables),
--=20
2.54.0


