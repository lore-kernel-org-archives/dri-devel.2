Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA4606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=St5vZC+e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552FF10FAC4;
	Wed,  4 Nov 2026 09:55:36 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA4010FAAD;
 Wed,  4 Nov 2026 09:55:30 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKLR31YykzKm4R;
 Wed, 04 Nov 2026 10:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793786127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9SjIRlN22aEJ/eflOcuaFanjf0EtRwA1GZ/Ili63jY=;
 b=St5vZC+e69zF+0QYl7tzsomIn/cBnY9p1wfZrtZVcwtRx7Ww6NJrSKZp/ecvdqBfJzwv1n
 EdDVz38s/Mhsm1OVk9jDBNhfA70E9ZHLXKxRQrd+r6XlGg5VUv8e/SW0miaCTHCnYK2rvE
 Zt+4hAlJw10Ywlry7WxvipnAg+K/iDcwQdu1iLZaIMj7tWLvOBhhlqivcEcYw6Mqvncrbs
 7HcCR+t2OSIe6OwD4TS+Cct7c49nAwUGy3HoBXnXlJZ0t5K4rvwwBLi74bAcNIc8BZC+rP
 gR1iYqQSoH1Ie2pYUHKczEDdj1GU2FjrUOM02OSLVe4RGbjFeDGhekgiF2FDTg==
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
Subject: [PATCH RFC RFT 5/8] drm/amd/display: Add KUnit tests for the custom
 brightness curve
Date: Wed,  4 Nov 2026 09:55:13 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-5-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13031; i=hugo@hsal.es;
 h=from:subject:message-id; bh=T/NqxQ3zNHoPNDzc6oEevd6n3mdwS2oL1FfQWjZQ/Ys=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRKVfDjKe3cl0omFDWq4j/8R595tZ11Qc4ZhxK
 WBjXNzJ7R86SlkYxLgYZMUUWXRveDKwTJw8M6fo+RKYOaxMIEMYuDgFYCL3AhkZNoru+qUfEy55
 Xa3/cVqJu+WchIayXulbvPfmTP/P89X9IcP/SL0dJswvZdLu71D1jE9LjGLfutm78Lh5tIF65Pf
 t3S/4ARNqSTY=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKLR31YykzKm4R
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

Add KUnit tests for the PWM path, using the curve from the ATIF reply of
an ASUS ROG Flow X13 GV301QH: minimum 12 and 49 points. They check
values worked out by hand, and walk every request to check that the
millipercent never goes down and changes on most steps. Two more curves
cover points above max_input_signal and a luminance over 100%

Export convert_brightness_to_millipercent() when the KUnit tests are
enabled, so the tests can call it

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
KUnit on UML with PROVE_LOCKING: amdgpu_dm_backlight passes 74 of 74
without this patch and 78 of 78 with it. Patch 4 says which of the new
tests fail without it

The other amdgpu_dm suites behave the same with and without the series.
Both runs stop in amdgpu_dm_crtc, at the BUG in drm_vblank_restore()
that dm_test_crtc_enable_vblank_ips_restore hits. With that test
skipped, the crtc, helpers, quirks and services suites pass

W=1 C=1 on power_abm, amdgpu_dm, amdgpu_dm_backlight,
amdgpu_dm_connector, amdgpu_dm_services and the backlight and connector
test objects adds no warnings at any patch, and checkpatch --strict is
clean
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 212 +++++++++++++++++++++
 3 files changed, 219 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 900c17e0285c9..2c1da5cbf5d7f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -178,8 +178,9 @@ static u32 backlight_custom_curve_scale(const struct amdgpu_dm_backlight_caps *c
 		     output_max);
 }
 
-static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
-					      u32 user_brightness)
+STATIC_IFN_KUNIT
+u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
+				       u32 user_brightness)
 {
 	unsigned int user_min, user_max;
 
@@ -195,6 +196,8 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
 					    caps->max_input_signal, 100000);
 }
 
+EXPORT_IF_KUNIT(convert_brightness_to_millipercent);
+
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int user_max, uint32_t *user_brightness)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index c5400b6c98660..9eec805809158 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -69,6 +69,8 @@ int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *user_min, unsigned int *user_max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int user_max, uint32_t *user_brightness);
+u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
+				       u32 user_brightness);
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index d38f388961d69..ba8ffb92ae7af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1460,6 +1460,214 @@ static void dm_test_brightness_from_user_with_curve(struct kunit *test)
 	amdgpu_dm_set_dc_debug_mask(saved_mask);
 }
 
+/*
+ * ATIF QBTC reply of an ASUS ROG Flow X13 GV301QH (BIOS 418), with
+ * min_input_signal 12 and max_input_signal 255
+ */
+static const struct amdgpu_dm_luminance_data gv301qh_curve[] = {
+	{ .input_signal =  14, .luminance =  2 },
+	{ .input_signal =  16, .luminance =  4 },
+	{ .input_signal =  18, .luminance =  6 },
+	{ .input_signal =  21, .luminance =  8 },
+	{ .input_signal =  23, .luminance = 10 },
+	{ .input_signal =  26, .luminance = 12 },
+	{ .input_signal =  29, .luminance = 14 },
+	{ .input_signal =  32, .luminance = 16 },
+	{ .input_signal =  35, .luminance = 18 },
+	{ .input_signal =  38, .luminance = 20 },
+	{ .input_signal =  41, .luminance = 22 },
+	{ .input_signal =  44, .luminance = 24 },
+	{ .input_signal =  48, .luminance = 26 },
+	{ .input_signal =  52, .luminance = 28 },
+	{ .input_signal =  55, .luminance = 30 },
+	{ .input_signal =  59, .luminance = 32 },
+	{ .input_signal =  62, .luminance = 34 },
+	{ .input_signal =  67, .luminance = 36 },
+	{ .input_signal =  71, .luminance = 38 },
+	{ .input_signal =  75, .luminance = 40 },
+	{ .input_signal =  80, .luminance = 42 },
+	{ .input_signal =  84, .luminance = 44 },
+	{ .input_signal =  88, .luminance = 46 },
+	{ .input_signal =  93, .luminance = 48 },
+	{ .input_signal =  98, .luminance = 50 },
+	{ .input_signal = 103, .luminance = 52 },
+	{ .input_signal = 108, .luminance = 54 },
+	{ .input_signal = 113, .luminance = 56 },
+	{ .input_signal = 118, .luminance = 58 },
+	{ .input_signal = 123, .luminance = 60 },
+	{ .input_signal = 129, .luminance = 62 },
+	{ .input_signal = 135, .luminance = 64 },
+	{ .input_signal = 140, .luminance = 66 },
+	{ .input_signal = 146, .luminance = 68 },
+	{ .input_signal = 152, .luminance = 70 },
+	{ .input_signal = 158, .luminance = 72 },
+	{ .input_signal = 164, .luminance = 74 },
+	{ .input_signal = 171, .luminance = 76 },
+	{ .input_signal = 177, .luminance = 78 },
+	{ .input_signal = 183, .luminance = 80 },
+	{ .input_signal = 190, .luminance = 82 },
+	{ .input_signal = 197, .luminance = 84 },
+	{ .input_signal = 204, .luminance = 86 },
+	{ .input_signal = 211, .luminance = 88 },
+	{ .input_signal = 218, .luminance = 90 },
+	{ .input_signal = 225, .luminance = 92 },
+	{ .input_signal = 232, .luminance = 94 },
+	{ .input_signal = 240, .luminance = 96 },
+	{ .input_signal = 247, .luminance = 98 },
+};
+
+static void dm_test_restore_dc_debug_mask(void *data)
+{
+	amdgpu_dm_set_dc_debug_mask((uintptr_t)data);
+}
+
+/* Turn the custom curve on, and back off when the test ends, even if it aborts */
+static void dm_test_enable_custom_curve(struct kunit *test)
+{
+	uint mask = amdgpu_dm_get_dc_debug_mask();
+
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_restore_dc_debug_mask,
+							(void *)(uintptr_t)mask), 0);
+	amdgpu_dm_set_dc_debug_mask(mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+}
+
+/*
+ * Over AUX, use the 1..512 nits range amdgpu_dm_backlight falls back to when
+ * the EDID gives no luminance range
+ */
+static void set_gv301qh_caps(struct amdgpu_dm_backlight_caps *caps, bool aux)
+{
+	caps->aux_support = aux;
+	caps->aux_min_input_signal = 1;
+	caps->aux_max_input_signal = 512;
+	caps->min_input_signal = 12;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->data_points = ARRAY_SIZE(gv301qh_curve);
+	memcpy(caps->luminance_data, gv301qh_curve, sizeof(gv301qh_curve));
+}
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
+
+/**
+ * dm_test_brightness_curve_pwm_values - Test PWM millipercent on the GV301QH curve
+ * @test: The KUnit test context
+ *
+ * Worked out by hand on the PWM range of 3084..65535. A request below the
+ * minimum is raised to 3084, signal 12, which is 12 / 14 of the way to the
+ * first point (14, 2), so 1714 millipercent. 32000 is signal 124.51,
+ * between (123, 60) and (129, 62), so 60505. 65535 is 100000
+ */
+static void dm_test_brightness_curve_pwm_values(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	dm_test_enable_custom_curve(test);
+	set_gv301qh_caps(&caps, false);
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 0), 1714U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 3084), 1714U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 32000), 60505U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 65535), 100000U);
+}
+
+/**
+ * dm_test_brightness_curve_pwm_steps - Test PWM millipercent never drops and keeps its steps
+ * @test: The KUnit test context
+ *
+ * Walk every request from user_min to user_max. The millipercent must
+ * never go down, and most requests must change it. There are 62452
+ * requests and 100001 possible millipercent values, against 101 with
+ * whole percents
+ */
+static void dm_test_brightness_curve_pwm_steps(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int user_min, user_max, user, steps = 0;
+	u32 prev, cur;
+
+	dm_test_enable_custom_curve(test);
+	set_gv301qh_caps(&caps, false);
+	get_brightness_range(&caps, &user_min, &user_max);
+
+	prev = convert_brightness_to_millipercent(&caps, user_min);
+	for (user = user_min + 1; user <= user_max; user++) {
+		cur = convert_brightness_to_millipercent(&caps, user);
+		if (cur < prev || cur > 100000) {
+			KUNIT_FAIL(test, "%u gives %u after %u", user, cur, prev);
+			return;
+		}
+		steps += cur != prev;
+		prev = cur;
+	}
+
+	KUNIT_EXPECT_GT(test, steps, (user_max - user_min) / 2);
+}
+
+/**
+ * dm_test_brightness_curve_pwm_points_above_max - Test PWM curve points above max_input_signal
+ * @test: The KUnit test context
+ *
+ * With max_input_signal 200 and points (180, 70) and (220, 90), the curve
+ * still runs between the two points. 42330 is signal 210.003, so 85001
+ * millipercent. Past the last point the curve runs on to 100% at signal
+ * 255: 47873 is signal 237.502, so 95001
+ */
+static void dm_test_brightness_curve_pwm_points_above_max(struct kunit *test)
+{
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 180, .luminance = 70 },
+		{ .input_signal = 220, .luminance = 90 },
+	};
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	dm_test_enable_custom_curve(test);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
+	caps.max_input_signal = 200;
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 42330), 85001U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 47873), 95001U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 0x101 * 200), 100000U);
+}
+
+/**
+ * dm_test_brightness_curve_pwm_luminance_over_100 - Test PWM with an ATIF luminance over 100%
+ * @test: The KUnit test context
+ *
+ * Points (100, 50), (200, 150) and (250, 120) claim more than 100%. The
+ * curve uses them as given and caps only the result, as before.
+ * Level 125 is 50 + 100 * 25 / 100 = 75%, and the curve reaches full
+ * brightness at level 150, halfway to the second point, and stays there
+ */
+static void dm_test_brightness_curve_pwm_luminance_over_100(struct kunit *test)
+{
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 100, .luminance = 50 },
+		{ .input_signal = 200, .luminance = 150 },
+		{ .input_signal = 250, .luminance = 120 },
+	};
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	dm_test_enable_custom_curve(test);
+	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 125 * 0x101), 75000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 150 * 0x101), 100000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 225 * 0x101), 100000U);
+}
+
 /**
  * dm_test_brightness_range_zero_signals - Test Brightness range with zero min and max signals
  * @test: The KUnit test context
@@ -2018,6 +2226,10 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_brightness_from_user_midrange),
 	KUNIT_CASE(dm_test_brightness_from_user_with_curve),
 	KUNIT_CASE(dm_test_brightness_from_user_curve_min),
+	KUNIT_CASE(dm_test_brightness_curve_pwm_values),
+	KUNIT_CASE(dm_test_brightness_curve_pwm_steps),
+	KUNIT_CASE(dm_test_brightness_curve_pwm_points_above_max),
+	KUNIT_CASE(dm_test_brightness_curve_pwm_luminance_over_100),
 	KUNIT_CASE(dm_test_brightness_range_zero_signals),
 	/* amdgpu_dm_backlight_fill_props */
 	KUNIT_CASE(dm_test_backlight_fill_props_ac_linear),

-- 
2.56.0

