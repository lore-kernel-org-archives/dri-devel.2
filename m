Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9501EC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE68110F417;
	Thu,  3 Sep 2026 07:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="Sqp15A5H";
	dkim-atps=neutral
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D8610F1A1
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788352385; x=1788611585;
 bh=czoiifOrjQOOSsp1SWakje73Vk1OJ3PnpNEpueAQcgE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Sqp15A5HwsyvkJafJtKjiCWipKY5Lm0Dgx7tOPJADdvcYUNCJ4V3xeNy16bUXgoX1
 EyAMg7j/uDuL1w0l8f09IFyjGGFA1Nm0NONajtmMqLXAyzIXhjD4XVPhQJ5c2a7cH2
 u4EELTxTwc6v6S1o3d/DahMzOzKEoNxWknutf8MgX1MoTe0X3O4UnieZpEyooTsVA0
 x9Yi+w0U/iHmEP6tcJ+EhDvqEFNmhe0sE5dajLJO2e4WNIKAbpSihf5pv4AGprDNpH
 6BB/8/FlyYzgTUpXEtf5xmLFHDrb9Jgyy+InJu0hFUM+YvkE1UdvWESvKyxYOrQz8B
 Vbg8ZpewTbXCA==
Date: Wed, 02 Sep 2026 12:33:01 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com
Subject: [PATCH 4/4] drm/amd/display: test power module brightness input domain
Message-ID: <20260902-brightness-4-abf809f2@empyreal.works>
In-Reply-To: <20260902-brightness-cover-abf809f2@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: b22fbbc5f2b81e94182aea359eb77092d11efe8a
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

Exercise the exact value selected for the power module on PWM and AUX
panels. Cover non-zero and zero PWM minimums, both endpoints, an
interior value, clamping, invalid caps, and retention of the AUX custom
curve and source-unit brightness mask.

The PWM case carries valid ATIF points to prove that the display manager
passes the userspace percentage without applying that curve before the
power module applies its own lookup table. Additional cases prove that
the brightness mask follows the effective control type: true AUX remains
unchanged, while ordinary PWM and AUX fallback-to-PWM are masked. The
selected panel's linear-curve bypass is covered independently.

The cases were verified under UML KUnit.

Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 .../tests/amdgpu_dm_backlight_test.c          | 159 +++++++++++++++++-
 1 file changed, 156 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_=
test.c
index a6fa052a8272..e0d46635130b 100644
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
@@ -1019,6 +1020,151 @@ static void dm_test_brightness_from_user_aux(struct=
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
+ * dm_test_power_module_aux_keeps_curve_and_mask - Test AUX conversion pat=
h
+ * @test: The KUnit test context
+ */
+static void dm_test_power_module_aux_keeps_curve_and_mask(struct kunit *te=
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
+=09=09=0981159U);
+
+=09amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
 /* Tests for convert_custom_brightness() */
=20
 /**
@@ -1590,7 +1736,7 @@ static void dm_test_curve_from_user_monotonic(struct =
kunit *test)
 =09for (i =3D 0; i <=3D max; i +=3D 1023) {
 =09=09u32 level =3D convert_brightness_from_user(&caps, i);
=20
-=09=09KUNIT_ASSERT_GE(test, level, previous);
+=09=09KUNIT_EXPECT_GE(test, level, previous);
 =09=09previous =3D level;
 =09}
=20
@@ -1619,8 +1765,8 @@ static void dm_test_curve_from_user_within_range(stru=
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
@@ -2198,6 +2344,13 @@ static struct kunit_case dm_backlight_test_cases[] =
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
+=09KUNIT_CASE(dm_test_power_module_aux_keeps_curve_and_mask),
 =09/* convert_custom_brightness */
 =09KUNIT_CASE(dm_test_custom_brightness_no_data_points),
 =09KUNIT_CASE(dm_test_custom_brightness_debug_mask_disables),

