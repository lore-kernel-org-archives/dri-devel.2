Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8098606A32F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=It7lJn6w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AE010FAE1;
	Wed,  4 Nov 2026 09:55:42 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7246A10FAA4;
 Wed,  4 Nov 2026 09:55:33 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jKLR63ZnxzKsnJ;
 Wed, 04 Nov 2026 10:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793786130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCVdSM1kM7/uZvnSQUkuqCkbuzNpjhnwfETImVxRT08=;
 b=It7lJn6wY9+f2dInpDkAYmtSChiYQURK+WyR9s8Lj5QTaT7e+uoOhtfcvgxYDfk00uWqyI
 8ZxmTu5mDSOdLrdlKkmmS4fFs80tUJyv/AAjN6VBVgghhbAsqA9/0moFqq06F8kfu6Y0r/
 cmKTqC6ALw55RKEBoen7MfDjKJrndFrU4zjppiHFsmopnzTWWtm37aTW85EGexIiSoWuHw
 5I5q9J+DLJnxUKdMknIHByOqBjYvO/D27TsAwnvWEFIfUZhj9cOKB76DA9KA/r5PWM3rMp
 XujgxqLC+2f1f3Cgpl2SqbEmsP3yhsG3qd0smtYUUDOAwczxq+Yb7niXT+9PDw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: alexander.deucher@amd.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, amd-gfx@lists.freedesktop.org
Cc: Hugo Sales <hugo@hsal.es>, ray.wu@amd.com, simona@ffwll.ch,
 alex.hung@amd.com, mario.limonciello@amd.com, linux-kernel@vger.kernel.org,
 lohita.mudimela@amd.com, bhawanpreet.lakha@amd.com,
 dri-devel@lists.freedesktop.org, roman.li@amd.com, airlied@gmail.com,
 christian.koenig@amd.com
Subject: [PATCH RFC RFT 7/8] drm/amd/display: Map AUX brightness through the
 custom curve like PWM
Date: Wed,  4 Nov 2026 09:55:15 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-7-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25522; i=hugo@hsal.es;
 h=from:subject:message-id; bh=phJWRkIbVCIaX7mq+Uhz2RKUHJmIV5bbgp+H48qbjK0=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRC01eLhvY6WniaJVx/KKD1tmvWy8zNx89uX6c
 5VTFy5wNHXqKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgImszGL47/DvlaNR7jn2
 VWY1Five6Owszg9cGzYlnb9BWUuLsStJnpFhRlLGycTJe63e6IU/kJYqi87ctohr5SKHK8enPWs
 t2yzFDQCv0klt
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKLR63ZnxzKsnJ
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

convert_custom_brightness() rounds the user level to 8 bits and the
luminance to a whole percent, then multiplies that percentage by the
level again

Use the backlight_custom_curve_scale() helper from the PWM path instead.
It places the level between user_min and user_max by the curve's
luminance. This changes the AUX mapping on purpose. A level now asks for
the luminance the curve gives it, as on PWM, and no longer for that
luminance times the level

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
On the 1..512 nits fallback range with the GV301QH curve, the 512001
levels gave 182 different values from 1000 to 495968 millinits. Now they
give 433295 different values from 1000 to 512000, and only levels 0 and
1 give 1000, instead of the bottom 6.1% of the scale. Half the scale
moves from 159310 to 315265 millinits

The convert_custom_brightness() tests now check exact values through
convert_brightness_from_user(), and
dm_test_brightness_from_user_curve_min expects 261610 for half the AUX
range now that the level goes in once. The early returns for
DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE and for no data points keep the
linear mapping. convert_brightness_to_user() never inverted the curve
and doesn't change

As before, the AUX curve ends at 100% at signal 255. It doesn't read
max_input_signal, which is a PWM limit. A point at signal 255 with less
than 100% no longer holds the top level below max, as it already
doesn't on PWM

KUnit: the four tests in patch 8, and the brightness values it adds to
the luminance over 100% test, fail without this patch and pass with it
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  88 +-----
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   2 -
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 314 +++++++--------------
 3 files changed, 115 insertions(+), 289 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 2c1da5cbf5d7f..358ba0c73d795 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -117,18 +117,6 @@ int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(get_brightness_range);
 
-/* Rescale userspace [0..user_max] to the firmware curve's [0..255]. */
-static inline u32 scale_input_to_fw(int user_max, u64 input)
-{
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, user_max);
-}
-
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [0..user_max] */
-static inline u32 scale_fw_to_input(int user_max, u64 input)
-{
-	return DIV_ROUND_CLOSEST_ULL(input * user_max, AMDGPU_MAX_BL_LEVEL);
-}
-
 /*
  * Map user level 0..user_max to 0..output_max through the custom curve,
  * which ends at 100% at signal_max, or at AMDGPU_MAX_BL_LEVEL when the
@@ -198,71 +186,6 @@ u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *ca
 
 EXPORT_IF_KUNIT(convert_brightness_to_millipercent);
 
-STATIC_IFN_KUNIT
-void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int user_max, uint32_t *user_brightness)
-{
-	u32 brightness = scale_input_to_fw(user_max, *user_brightness);
-	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
-	int left, right;
-
-	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
-		return;
-
-	if (!caps->data_points)
-		return;
-
-	/*
-	 * Handle the case where brightness is below the first data point
-	 * Interpolate between (0,0) and (first_signal, first_lum)
-	 */
-	if (brightness < caps->luminance_data[0].input_signal) {
-		lum = DIV_ROUND_CLOSEST(caps->luminance_data[0].luminance * brightness,
-					caps->luminance_data[0].input_signal);
-		goto scale;
-	}
-
-	left = 0;
-	right = caps->data_points - 1;
-	while (left <= right) {
-		int mid = left + (right - left) / 2;
-		u8 signal = caps->luminance_data[mid].input_signal;
-
-		/* Exact match found */
-		if (signal == brightness) {
-			lum = caps->luminance_data[mid].luminance;
-			goto scale;
-		}
-
-		if (signal < brightness)
-			left = mid + 1;
-		else
-			right = mid - 1;
-	}
-
-	/* verify bound */
-	if (left >= caps->data_points)
-		left = caps->data_points - 1;
-
-	/* At this point, left > right */
-	lower_signal = caps->luminance_data[right].input_signal;
-	upper_signal = caps->luminance_data[left].input_signal;
-	lower_lum = caps->luminance_data[right].luminance;
-	upper_lum = caps->luminance_data[left].luminance;
-
-	/* interpolate */
-	if (right == left || !lower_lum)
-		lum = upper_lum;
-	else
-		lum = lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
-						    (brightness - lower_signal),
-						    upper_signal - lower_signal);
-scale:
-	*user_brightness = scale_fw_to_input(user_max, DIV_ROUND_CLOSEST(lum * brightness, 101));
-}
-
-EXPORT_IF_KUNIT(convert_custom_brightness);
-
 STATIC_IFN_KUNIT
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				uint32_t brightness)
@@ -272,10 +195,15 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 	if (!get_brightness_range(caps, &user_min, &user_max))
 		return brightness;
 
-	convert_custom_brightness(caps, user_max, &brightness);
+	if ((amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE) ||
+	    !caps->data_points)
+		return user_min + DIV_ROUND_CLOSEST_ULL((u64)(user_max - user_min) * brightness,
+							user_max);
 
-	/* Rescale 0..user_max to user_min..user_max */
-	return user_min + DIV_ROUND_CLOSEST_ULL((u64)(user_max - user_min) * brightness, user_max);
+	/* max_input_signal is a PWM limit, so the AUX curve ends at signal 255 */
+	return user_min + backlight_custom_curve_scale(caps, brightness, user_max,
+						       AMDGPU_MAX_BL_LEVEL,
+						       user_max - user_min);
 }
 
 EXPORT_IF_KUNIT(convert_brightness_from_user);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 9eec805809158..d3e64d74d81c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -67,8 +67,6 @@ ssize_t panel_power_savings_store(struct device *device,
 				 const char *buf, size_t count);
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *user_min, unsigned int *user_max);
-void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int user_max, uint32_t *user_brightness);
 u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
 				       u32 user_brightness);
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index e9da2c46779fd..06c1e084357ff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1042,48 +1042,69 @@ static void dm_test_brightness_from_user_aux(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, user_max), (u32)user_max);
 }
 
-/* Tests for convert_custom_brightness() */
+/* Tests for the custom curve in convert_brightness_from_user() */
+
+/*
+ * A PWM range of 0..65535 with no minimum, so the result is the curve's
+ * output on 0..65535
+ */
+static void set_custom_curve_caps(struct amdgpu_dm_backlight_caps *caps,
+				  const struct amdgpu_dm_luminance_data *points,
+				  int n)
+{
+	caps->aux_support = false;
+	caps->min_input_signal = 0;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->data_points = n;
+	memcpy(caps->luminance_data, points, n * sizeof(*points));
+}
 
 /**
  * dm_test_custom_brightness_no_data_points - Test Custom brightness no data points
  * @test: The KUnit test context
+ *
+ * With no data points the request maps linearly onto user_min..user_max
  */
 static void dm_test_custom_brightness_no_data_points(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness = 128;
-	uint32_t saved = brightness;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 0;
 
-	convert_custom_brightness(&caps, 65535, &brightness);
+	/* 3084 + DIV_ROUND_CLOSEST(62451 * 32768, 65535) */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 32768), 34310U);
 
-	/* No data points → no-op */
-	KUNIT_EXPECT_EQ(test, brightness, saved);
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
 
 /**
  * dm_test_custom_brightness_debug_mask_disables - Test Custom brightness debug mask disables
  * @test: The KUnit test context
+ *
+ * DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE skips the curve, so the request maps
+ * linearly onto user_min..user_max
  */
 static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 50, .luminance = 10 },
+		{ .input_signal = 128, .luminance = 50 },
+		{ .input_signal = 200, .luminance = 90 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness = 128;
-	uint32_t saved = brightness;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	caps.data_points = 3;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 10;
-
-	/* Set the disable flag */
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 
-	convert_custom_brightness(&caps, 65535, &brightness);
+	amdgpu_dm_set_dc_debug_mask(saved_mask | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 
-	/* Should be no-op due to debug mask */
-	KUNIT_EXPECT_EQ(test, brightness, saved);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 32768), 34310U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1091,50 +1112,24 @@ static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
 /**
  * dm_test_custom_brightness_exact_match - Test Custom brightness exact match
  * @test: The KUnit test context
+ *
+ * 32896 is signal 128 exactly, the point (128, 50), so the result is 50% of
+ * 65535, rounded to 32768
  */
 static void dm_test_custom_brightness_exact_match(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 50, .luminance = 20 },
+		{ .input_signal = 128, .luminance = 50 },
+		{ .input_signal = 200, .luminance = 90 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 3;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 128;
-	caps.luminance_data[1].luminance = 50;
-	caps.luminance_data[2].input_signal = 200;
-	caps.luminance_data[2].luminance = 90;
-
-	get_brightness_range(&caps, &user_min, &user_max);
-
-	/*
-	 * Set brightness so that scale_input_to_fw yields exactly 128.
-	 * scale_input_to_fw(user_min, user_max, x) =
-	 *   DIV_ROUND_CLOSEST(x * 255, user_max - user_min)
-	 * With user_min=0, user_max=0x101*255=65535:
-	 * We need x such that DIV_ROUND_CLOSEST(x * 255, 65535) = 128
-	 * → x = 128 * 65535 / 255 = 32896
-	 */
-	brightness = 32896;
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
-	convert_custom_brightness(&caps, user_max, &brightness);
-
-	/*
-	 * Exact match: lum=50, brightness_scaled=128
-	 * result = scale_fw_to_input(user_max, DIV_ROUND_CLOSEST(50*128, 101))
-	 *        = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(6400, 101))
-	 *        = scale_fw_to_input(65535, 63)
-	 *        = DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
-	 */
-	KUNIT_EXPECT_TRUE(test, brightness != 32896);
-	KUNIT_EXPECT_TRUE(test, brightness < 32896);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 32896), 32768U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1142,44 +1137,23 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
 /**
  * dm_test_custom_brightness_below_first - Test Custom brightness below first
  * @test: The KUnit test context
+ *
+ * 12850 is signal 50, halfway from (0, 0) to the first point (100, 40), so
+ * the result is 20% of 65535
  */
 static void dm_test_custom_brightness_below_first(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 100, .luminance = 40 },
+		{ .input_signal = 200, .luminance = 80 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 100;
-	caps.luminance_data[0].luminance = 40;
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
-
-	get_brightness_range(&caps, &user_min, &user_max);
-
-	/*
-	 * Set brightness low enough that scaled value < 100.
-	 * scale_input_to_fw(0, 65535, x) = DIV_ROUND_CLOSEST(x*255, 65535)
-	 * For result=50: x = 50*65535/255 = 12850
-	 */
-	brightness = 12850;
-
-	convert_custom_brightness(&caps, user_max, &brightness);
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
-	/*
-	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
-	 * Then: scale_fw_to_input(65535, DIV_ROUND_CLOSEST(20 * 50, 101))
-	 *      = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(1000, 101))
-	 *      = scale_fw_to_input(65535, 10)
-	 * The output should be significantly less than input.
-	 */
-	KUNIT_EXPECT_TRUE(test, brightness < 12850);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 12850), 13107U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1187,40 +1161,23 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
 /**
  * dm_test_custom_brightness_interpolation - Test Custom brightness interpolation
  * @test: The KUnit test context
+ *
+ * 32125 is signal 125, halfway from (50, 20) to (200, 80), so the result is
+ * 50% of 65535, rounded to 32768
  */
 static void dm_test_custom_brightness_interpolation(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 50, .luminance = 20 },
+		{ .input_signal = 200, .luminance = 80 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
-
-	get_brightness_range(&caps, &user_min, &user_max);
-
-	/*
-	 * Choose a value between data points 50 and 200.
-	 * scale_input_to_fw(0, 65535, x) = 125 when x = 125*65535/255 = 32125
-	 */
-	brightness = 32125;
-
-	convert_custom_brightness(&caps, user_max, &brightness);
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
-	/*
-	 * The function should interpolate between data points and produce
-	 * a remapped value different from the input.
-	 */
-	KUNIT_EXPECT_TRUE(test, brightness != 32125);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 32125), 32768U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1228,40 +1185,25 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
 /**
  * dm_test_custom_brightness_above_last - Test Custom brightness above last data point
  * @test: The KUnit test context
+ *
+ * Above the last point (150, 60) the curve runs to (255, 100). 56540 is
+ * signal 220, so the luminance is 60 + 40 * 70 / 105, 86.67%, and the
+ * result is 56797. The top of the range gives max
  */
 static void dm_test_custom_brightness_above_last(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 50, .luminance = 20 },
+		{ .input_signal = 150, .luminance = 60 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 150;
-	caps.luminance_data[1].luminance = 60;
-
-	get_brightness_range(&caps, &user_min, &user_max);
-
-	/*
-	 * Choose brightness above the last data point (150).
-	 * scale_input_to_fw(0, 65535, x) = 220 when x = 220*65535/255 = 56533
-	 * After binary search, left >= data_points, clamped → right==left,
-	 * so lum = upper_lum = 60.
-	 */
-	brightness = 56533;
-
-	convert_custom_brightness(&caps, user_max, &brightness);
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
-	/* Output should differ from input (remapped via curve) */
-	KUNIT_EXPECT_TRUE(test, brightness != 56533);
-	KUNIT_EXPECT_TRUE(test, brightness < 56533);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 56540), 56797U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 65535), 65535U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1269,35 +1211,22 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
 /**
  * dm_test_custom_brightness_single_data_point - Test Custom brightness with single data point
  * @test: The KUnit test context
+ *
+ * 16448 is signal 64, halfway from (0, 0) to the only point (128, 50), so
+ * the result is 25% of 65535, rounded to 16384
  */
 static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 128, .luminance = 50 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 1;
-	caps.luminance_data[0].input_signal = 128;
-	caps.luminance_data[0].luminance = 50;
-
-	get_brightness_range(&caps, &user_min, &user_max);
-
-	/*
-	 * Brightness below the single data point triggers the
-	 * "below first" path: lum = DIV_ROUND_CLOSEST(50 * scaled, 128).
-	 * scale_input_to_fw(0, 65535, x) = 64 when x = 64*65535/255 = 16448
-	 */
-	brightness = 16448;
-
-	convert_custom_brightness(&caps, user_max, &brightness);
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
-	KUNIT_EXPECT_TRUE(test, brightness < 16448);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 16448), 16384U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1305,38 +1234,24 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 /**
  * dm_test_custom_brightness_lower_lum_zero - Test Custom brightness with zero lower luminance
  * @test: The KUnit test context
+ *
+ * A point with 0% luminance is interpolated like any other. 32125 is
+ * signal 125, halfway from (50, 0) to (200, 80), so the result is 40% of
+ * 65535
  */
 static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 {
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 50, .luminance = 0 },
+		{ .input_signal = 200, .luminance = 80 },
+	};
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 0;	/* zero lower luminance */
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
-
-	get_brightness_range(&caps, &user_min, &user_max);
-
-	/*
-	 * Choose brightness between data points to trigger interpolation.
-	 * scale_input_to_fw(0, 65535, x) = 125 when x = 125*65535/255 = 32125
-	 * With lower_lum == 0, code takes shortcut: lum = upper_lum = 80.
-	 */
-	brightness = 32125;
-
-	convert_custom_brightness(&caps, user_max, &brightness);
+	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
-	/* Should remap; result should differ from input */
-	KUNIT_EXPECT_TRUE(test, brightness != 32125);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 32125), 26214U);
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
@@ -1392,10 +1307,10 @@ static void dm_test_brightness_from_user_midrange(struct kunit *test)
  *
  * On the AUX range of 1..512 nits with points (50, 20%) and (200, 80%), a
  * request for 0 must give the 1000 millinit minimum, where adding the
- * minimum twice gave 1998. Half the scale is signal 128, luminance 51%,
- * so 51 * 128 / 101 = 65 of 255, which is 1000 + 511000 * 65 / 255 =
- * 131255. A request for 0 on the PWM range with min_input_signal 12 must
- * give 12 * 0x101
+ * minimum twice gave 1998. Half the scale is signal 127.5, so luminance
+ * 20 + 60 * 77.5 / 150 = 51%, which is 1000 + 511000 * 51% = 261610. A
+ * request for 0 on the PWM range with min_input_signal 12 must give
+ * 12 * 0x101
  */
 static void dm_test_brightness_from_user_curve_min(struct kunit *test)
 {
@@ -1417,7 +1332,7 @@ static void dm_test_brightness_from_user_curve_min(struct kunit *test)
 	caps.luminance_data[1].luminance = 80;
 
 	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), 1000U);
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 256000), 131255U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 256000), 261610U);
 
 	caps.aux_support = false;
 	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), 12U * 0x101);
@@ -1547,21 +1462,6 @@ static void set_gv301qh_caps(struct amdgpu_dm_backlight_caps *caps, bool aux)
 	memcpy(caps->luminance_data, gv301qh_curve, sizeof(gv301qh_curve));
 }
 
-/*
- * A PWM range of 0..65535 with no minimum, so the result is the curve's
- * output on 0..65535
- */
-static void set_custom_curve_caps(struct amdgpu_dm_backlight_caps *caps,
-				  const struct amdgpu_dm_luminance_data *points,
-				  int n)
-{
-	caps->aux_support = false;
-	caps->min_input_signal = 0;
-	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps->data_points = n;
-	memcpy(caps->luminance_data, points, n * sizeof(*points));
-}
-
 /**
  * dm_test_brightness_curve_pwm_values - Test PWM millipercent on the GV301QH curve
  * @test: The KUnit test context
@@ -2353,7 +2253,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_brightness_from_user_zero),
 	KUNIT_CASE(dm_test_brightness_from_user_max),
 	KUNIT_CASE(dm_test_brightness_from_user_aux),
-	/* convert_custom_brightness */
+	/* custom curve in convert_brightness_from_user */
 	KUNIT_CASE(dm_test_custom_brightness_no_data_points),
 	KUNIT_CASE(dm_test_custom_brightness_debug_mask_disables),
 	KUNIT_CASE(dm_test_custom_brightness_exact_match),

-- 
2.56.0

