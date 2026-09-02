Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F07C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457DB10F3FC;
	Thu,  3 Sep 2026 07:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="NLcjPR/e";
	dkim-atps=neutral
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CF910F1A1
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788352283; x=1788611483;
 bh=CIXG5k8Z42Dvwo3n4OTF/HGNzdZ5644vv8fHSBN0grA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NLcjPR/eJiF/NWaCblNVUCHSx42EIQ+gVQE5iBYmjcMD8iqT1gXzRvZgMTC8I8t/p
 OSwwhIQtizzDJ/7oIoC9dEj2cbu3uJ8rZ8uBrJ6hMtHVVMg45o/g5+33tLcKyCuooq
 4/MyeS6+RPvBFmpWHDc99YqYCS1KP3tuLvD8H8fMuASOeTwDwtw+sQDiT3A/hAU5T+
 /tEgGi8civO5EUoTipF4ZLnpTBP7YXyNiCksIcLAb7nzJBabTBQfXy4uFZyY3nFj1Q
 m1z33G9gx/FOqlgFKcG8surWSxMAsfCyBcDz9RMFQ0aUa/y9qT1ytJrOrmH/Tkucri
 8jPzRJVKA30Iw==
Date: Wed, 02 Sep 2026 12:31:17 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com,
 stable@vger.kernel.org
Subject: [PATCH 1/4] drm/amd/display: keep custom brightness curve in
 userspace domain
Message-ID: <20260902-brightness-1-fd468d7a@empyreal.works>
In-Reply-To: <20260902-brightness-cover-abf809f2@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: d3c1787a7ff7f8453ae90f24a3b3e0855c107f25
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

convert_brightness_from_user() expects convert_custom_brightness() to
reshape a value in the userspace [0..max] domain before the caller maps
it once into the firmware [min..max] domain.

Commit 8dbd72cb7900 ("drm/amd/display: Export full brightness range to
userspace") instead made convert_custom_brightness() call
scale_fw_to_input(min, max, ...). That helper adds min and scales by the
firmware span, entering the firmware domain before the caller applies
the same span and minimum again.

With the default PWM range, min is 3084 and max is 65535. A zero request
through any custom curve consequently returns 6023 instead of 3084, so
the darkest 2939 firmware levels are unreachable.

Keep the curve result in [0..max]. scale_fw_to_input() then becomes the
inverse of scale_input_to_fw(), and the caller remains the sole owner of
the userspace-to-firmware conversion. The linear path is unchanged.

A later patch removes this helper from the PWM power-module path because
the power module owns that curve. AUX panels continue to use it, and
stable kernels predating the power-module refactor still require this
correction on PWM panels.

Commit 6fd83a1c2cde ("drm/amd/display: Scale custom brightness curve from
full range") fixed the corresponding input-side domain error. This
completes the output side of the same conversion.

Source and arithmetic analysis identified the duplicate
domain conversion. KUnit coverage for a non-zero firmware minimum is
added separately.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to user=
space")
Cc: stable@vger.kernel.org # 6.17.x: 6fd83a1c2cde: drm/amd/display: Scale c=
ustom brightness curve from full range
Cc: stable@vger.kernel.org # 6.17.x
Cc: stable@vger.kernel.org # before 7.3 this code is in amdgpu_dm.c; drop t=
he header and test hunks

Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 13 ++++----
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  3 +-
 .../tests/amdgpu_dm_backlight_test.c          | 30 +++++++++----------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index e61bbc310f33..424b33573a73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -112,16 +112,15 @@ static inline u32 scale_input_to_fw(int max, u64 inpu=
t)
 =09return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
=20
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
-static inline u32 scale_fw_to_input(int min, int max, u64 input)
+/* Rescale the firmware curve's [0..AMDGPU_MAX_BL_LEVEL] back to userspace=
 [0..max]. */
+static inline u32 scale_fw_to_input(int max, u64 input)
 {
-=09return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_L=
EVEL);
+=09return DIV_ROUND_CLOSEST_ULL(input * max, AMDGPU_MAX_BL_LEVEL);
 }
=20
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps=
,
-=09=09=09       unsigned int min, unsigned int max,
-=09=09=09       uint32_t *user_brightness)
+=09=09=09       unsigned int max, uint32_t *user_brightness)
 {
 =09u32 brightness =3D scale_input_to_fw(max, *user_brightness);
 =09u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
@@ -179,7 +178,7 @@ void convert_custom_brightness(const struct amdgpu_dm_b=
acklight_caps *caps,
 =09=09=09=09=09=09    (brightness - lower_signal),
 =09=09=09=09=09=09    upper_signal - lower_signal);
 scale:
-=09*user_brightness =3D scale_fw_to_input(min, max,
+=09*user_brightness =3D scale_fw_to_input(max,
 =09=09=09=09=09     DIV_ROUND_CLOSEST(lum * brightness, 101));
 }
=20
@@ -194,7 +193,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm=
_backlight_caps *caps,
 =09if (!get_brightness_range(caps, &min, &max))
 =09=09return brightness;
=20
-=09convert_custom_brightness(caps, min, max, &brightness);
+=09convert_custom_brightness(caps, max, &brightness);
=20
 =09/* Rescale 0..max to min..max */
 =09return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 07b75064847c..90bed0ea5d00 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -67,8 +67,7 @@ ssize_t panel_power_savings_store(struct device *device,
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 =09=09=09 unsigned int *min, unsigned int *max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps=
,
-=09=09=09       unsigned int min, unsigned int max,
-=09=09=09       uint32_t *user_brightness);
+=09=09=09       unsigned int max, uint32_t *user_brightness);
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *ca=
ps,
 =09=09=09=09 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps=
,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_=
test.c
index 7ca17f803f9d..1fb171fdbc3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.=
c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.=
c
@@ -1033,7 +1033,7 @@ static void dm_test_custom_brightness_no_data_points(=
struct kunit *test)
=20
 =09caps.data_points =3D 0;
=20
-=09convert_custom_brightness(&caps, 3084, 65535, &brightness);
+=09convert_custom_brightness(&caps, 65535, &brightness);
=20
 =09/* No data points =E2=86=92 no-op */
 =09KUNIT_EXPECT_EQ(test, brightness, saved);
@@ -1057,7 +1057,7 @@ static void dm_test_custom_brightness_debug_mask_disa=
bles(struct kunit *test)
 =09/* Set the disable flag */
 =09amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_=
CUSTOM_BRIGHTNESS_CURVE);
=20
-=09convert_custom_brightness(&caps, 3084, 65535, &brightness);
+=09convert_custom_brightness(&caps, 65535, &brightness);
=20
 =09/* Should be no-op due to debug mask */
 =09KUNIT_EXPECT_EQ(test, brightness, saved);
@@ -1100,14 +1100,14 @@ static void dm_test_custom_brightness_exact_match(s=
truct kunit *test)
 =09 */
 =09brightness =3D 32896;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/*
 =09 * Exact match: lum=3D50, brightness_scaled=3D128
-=09 * result =3D scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(50*128, 101=
))
-=09 *        =3D scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(6400, 101))
-=09 *        =3D scale_fw_to_input(0, 65535, 63)
-=09 *        =3D 0 + DIV_ROUND_CLOSEST(63 * 65535, 255) =3D 16191 (approx)
+=09 * result =3D scale_fw_to_input(max, DIV_ROUND_CLOSEST(50*128, 101))
+=09 *        =3D scale_fw_to_input(65535, DIV_ROUND_CLOSEST(6400, 101))
+=09 *        =3D scale_fw_to_input(65535, 63)
+=09 *        =3D DIV_ROUND_CLOSEST(63 * 65535, 255) =3D 16191 (approx)
 =09 */
 =09KUNIT_EXPECT_TRUE(test, brightness !=3D 32896);
 =09KUNIT_EXPECT_TRUE(test, brightness < 32896);
@@ -1146,13 +1146,13 @@ static void dm_test_custom_brightness_below_first(s=
truct kunit *test)
 =09 */
 =09brightness =3D 12850;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/*
 =09 * Below first data point: lum =3D DIV_ROUND_CLOSEST(40 * 50, 100) =3D =
20
-=09 * Then: scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(20 * 50, 101))
-=09 *      =3D scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(1000, 101))
-=09 *      =3D scale_fw_to_input(0, 65535, 10)
+=09 * Then: scale_fw_to_input(65535, DIV_ROUND_CLOSEST(20 * 50, 101))
+=09 *      =3D scale_fw_to_input(65535, DIV_ROUND_CLOSEST(1000, 101))
+=09 *      =3D scale_fw_to_input(65535, 10)
 =09 * The output should be significantly less than input.
 =09 */
 =09KUNIT_EXPECT_TRUE(test, brightness < 12850);
@@ -1190,7 +1190,7 @@ static void dm_test_custom_brightness_interpolation(s=
truct kunit *test)
 =09 */
 =09brightness =3D 32125;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/*
 =09 * The function should interpolate between data points and produce
@@ -1233,7 +1233,7 @@ static void dm_test_custom_brightness_above_last(stru=
ct kunit *test)
 =09 */
 =09brightness =3D 56533;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/* Output should differ from input (remapped via curve) */
 =09KUNIT_EXPECT_TRUE(test, brightness !=3D 56533);
@@ -1271,7 +1271,7 @@ static void dm_test_custom_brightness_single_data_poi=
nt(struct kunit *test)
 =09 */
 =09brightness =3D 16448;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09KUNIT_EXPECT_TRUE(test, brightness < 16448);
=20
@@ -1309,7 +1309,7 @@ static void dm_test_custom_brightness_lower_lum_zero(=
struct kunit *test)
 =09 */
 =09brightness =3D 32125;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/* Should remap; result should differ from input */
 =09KUNIT_EXPECT_TRUE(test, brightness !=3D 32125);

