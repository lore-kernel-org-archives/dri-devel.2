Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7221606A33B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=m4yHhOqy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C2F10FAB5;
	Wed,  4 Nov 2026 09:55:30 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223BA10FAAD;
 Wed,  4 Nov 2026 09:55:23 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKLQw3V7pzMlw5;
 Wed, 04 Nov 2026 10:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793786120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iySrpio9o8GgGW3QdcTg4NSWFnaIY9bxvXmhoUKbzWg=;
 b=m4yHhOqyxb6/MaRS5+7VKtMjo0Ig9E2xOTxmRy6R1EWNAzzJA5TgY7avWymCyrAoy53B1T
 DC0RP1TADH2pYmaHUGh1uNW1qTFov44B7vo3kh0hJm0O1k+iE+EZV88x2u+BpmnWXG5s2n
 9ltQyVbPdzE0+NW5Cp9k+r/Dbc/RMeveLjWrc52Fxz+pXw6zOOQ47HR2hnisbqLGkCZE+e
 w3GYt+UQ9lsieUV2v+t3uLdxU5BaJVScyVTsFnnmEZieeXgHBL4VQQzYImP+6UsGUmlujp
 y9ObgCKCRE8mU27HKQwsYYhKzCkOzLiL9ybJIEYkkbBCIuT+vE03+hSLKrT0VQ==
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
Subject: [PATCH RFC RFT 1/8] drm/amd/display: Rename the user brightness range
 to user_min and user_max
Date: Wed,  4 Nov 2026 09:55:09 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-1-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32289; i=hugo@hsal.es;
 h=from:subject:message-id; bh=s+OzsfO5hSBrlVmUmdcyaI4P/f/IMLudvMgNyEoImBY=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRPHyJmUo3OjdaTJpWrHlbp23K1f9WLt00oTSu
 Tku/tfu+yR2lLIwiHExyIopsuje8GRgmTh5Zk7R8yUwc1iZQIYwcHEKwESeHmH4Z/TGP4vLN+iZ
 qZVxj/KuDpZnXpuddf82nvqffVQ76+OzYIb/wVtaF0UuP+zgmy204VTERqP3+979PMxcUHdPziU
 uvegxIwCVaEzX
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKLQw3V7pzMlw5
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

get_brightness_range() gives the range of the user brightness level,
and the code around it calls its two ends min and max. The custom curve
code later in this series adds an input signal range and an output
range next to it, so call this one user_min and user_max

No functional change

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Rename only. It also joins two lines in
amdgpu_dm_backlight_fill_props() that now fit in 100 columns, and wraps
two test comments that no longer do

amdgpu_dm_backlight.o disassembles the same with and without this
patch. amdgpu_dm_backlight_test.o differs only in the line numbers its
KUnit asserts record, since the two wrapped comments add two lines

KUnit: amdgpu_dm_backlight passes 74 of 74 with and without this
patch, and the tests from patches 5, 6 and 8 give the same results with
and without it
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  72 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   4 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 194 +++++++++++----------
 3 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index cef2ad8fea74d..3b59699e74287 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -98,34 +98,34 @@ EXPORT_IF_KUNIT(amdgpu_dm_update_backlight_caps);
 
 STATIC_IFN_KUNIT
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-			 unsigned int *min, unsigned int *max)
+			 unsigned int *user_min, unsigned int *user_max)
 {
 	if (!caps)
 		return 0;
 
 	if (caps->aux_support) {
 		/* Firmware limits are in nits, DC API wants millinits. */
-		*max = 1000 * caps->aux_max_input_signal;
-		*min = 1000 * caps->aux_min_input_signal;
+		*user_max = 1000 * caps->aux_max_input_signal;
+		*user_min = 1000 * caps->aux_min_input_signal;
 	} else {
 		/* Firmware limits are 8-bit, PWM control is 16-bit. */
-		*max = 0x101 * caps->max_input_signal;
-		*min = 0x101 * caps->min_input_signal;
+		*user_max = 0x101 * caps->max_input_signal;
+		*user_min = 0x101 * caps->min_input_signal;
 	}
 	return 1;
 }
 EXPORT_IF_KUNIT(get_brightness_range);
 
-/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
-static inline u32 scale_input_to_fw(int max, u64 input)
+/* Rescale userspace [0..user_max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int user_max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, user_max);
 }
 
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [0..max] */
-static inline u32 scale_fw_to_input(int max, u64 input)
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [0..user_max] */
+static inline u32 scale_fw_to_input(int user_max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * max, AMDGPU_MAX_BL_LEVEL);
+	return DIV_ROUND_CLOSEST_ULL(input * user_max, AMDGPU_MAX_BL_LEVEL);
 }
 
 static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *caps,
@@ -173,18 +173,18 @@ static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *
 static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
 					      u32 user_brightness)
 {
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	u32 signal, luminance;
 
-	if (!get_brightness_range(caps, &min, &max))
+	if (!get_brightness_range(caps, &user_min, &user_max))
 		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000,
 					     MAX_BACKLIGHT_LEVEL);
 
-	user_brightness = clamp(user_brightness, min, max);
+	user_brightness = clamp(user_brightness, user_min, user_max);
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
-		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000, max);
+		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000, user_max);
 
-	signal = scale_input_to_fw(max, user_brightness);
+	signal = scale_input_to_fw(user_max, user_brightness);
 	luminance = backlight_signal_to_luminance(caps, signal);
 
 	return min_t(u32, luminance * 1000, 100000);
@@ -192,9 +192,9 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
 
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int max, uint32_t *user_brightness)
+			       unsigned int user_max, uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(max, *user_brightness);
+	u32 brightness = scale_input_to_fw(user_max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 
@@ -250,7 +250,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 						    (brightness - lower_signal),
 						    upper_signal - lower_signal);
 scale:
-	*user_brightness = scale_fw_to_input(max, DIV_ROUND_CLOSEST(lum * brightness, 101));
+	*user_brightness = scale_fw_to_input(user_max, DIV_ROUND_CLOSEST(lum * brightness, 101));
 }
 
 EXPORT_IF_KUNIT(convert_custom_brightness);
@@ -259,15 +259,15 @@ STATIC_IFN_KUNIT
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				uint32_t brightness)
 {
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
-	if (!get_brightness_range(caps, &min, &max))
+	if (!get_brightness_range(caps, &user_min, &user_max))
 		return brightness;
 
-	convert_custom_brightness(caps, max, &brightness);
+	convert_custom_brightness(caps, user_max, &brightness);
 
-	/* Rescale 0..max to min..max */
-	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
+	/* Rescale 0..user_max to user_min..user_max */
+	return user_min + DIV_ROUND_CLOSEST_ULL((u64)(user_max - user_min) * brightness, user_max);
 }
 
 EXPORT_IF_KUNIT(convert_brightness_from_user);
@@ -276,16 +276,16 @@ STATIC_IFN_KUNIT
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 			      uint32_t brightness)
 {
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
-	if (!get_brightness_range(caps, &min, &max))
+	if (!get_brightness_range(caps, &user_min, &user_max))
 		return brightness;
 
-	if (brightness < min)
+	if (brightness < user_min)
 		return 0;
-	/* Rescale min..max to 0..max */
-	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
-				 max - min);
+	/* Rescale user_min..user_max to 0..user_max */
+	return DIV_ROUND_CLOSEST_ULL((u64)user_max * (brightness - user_min),
+				 user_max - user_min);
 }
 EXPORT_IF_KUNIT(convert_brightness_to_user);
 
@@ -484,16 +484,14 @@ void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
 				    bool custom_curve_enabled,
 				    struct backlight_properties *props)
 {
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
-	if (get_brightness_range(caps, &min, &max)) {
+	if (get_brightness_range(caps, &user_min, &user_max)) {
 		if (is_system_supplied)
-			props->brightness = DIV_ROUND_CLOSEST(max * caps->ac_level,
-							       100);
+			props->brightness = DIV_ROUND_CLOSEST(user_max * caps->ac_level, 100);
 		else
-			props->brightness = DIV_ROUND_CLOSEST(max * caps->dc_level,
-							       100);
-		props->max_brightness = max;
+			props->brightness = DIV_ROUND_CLOSEST(user_max * caps->dc_level, 100);
+		props->max_brightness = user_max;
 	} else {
 		props->brightness = MAX_BACKLIGHT_LEVEL;
 		props->max_brightness = MAX_BACKLIGHT_LEVEL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 32ba2f8efb33b..c5400b6c98660 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -66,9 +66,9 @@ ssize_t panel_power_savings_store(struct device *device,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count);
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-			 unsigned int *min, unsigned int *max);
+			 unsigned int *user_min, unsigned int *user_max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int max, uint32_t *user_brightness);
+			       unsigned int user_max, uint32_t *user_brightness);
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 3d00cde8c77bc..d38f388961d69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -482,7 +482,7 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link = dm_kunit_alloc_link(test);
 	struct drm_minor *primary;
-	unsigned int max;
+	unsigned int user_max;
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
@@ -499,14 +499,14 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps->ac_level = 50;
 	caps->dc_level = 25;
-	max = 0x101 * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	user_max = 0x101 * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
 	amdgpu_dm_register_backlight_device(aconnector);
 
 	KUNIT_ASSERT_NOT_NULL(test, adev->dm.backlight_dev[0]);
-	KUNIT_EXPECT_EQ(test, adev->dm.backlight_dev[0]->props.max_brightness, max);
+	KUNIT_EXPECT_EQ(test, adev->dm.backlight_dev[0]->props.max_brightness, user_max);
 	KUNIT_EXPECT_EQ(test, adev->dm.backlight_dev[0]->props.brightness,
-			DIV_ROUND_CLOSEST(max * caps->ac_level, 100));
+			DIV_ROUND_CLOSEST(user_max * caps->ac_level, 100));
 	KUNIT_EXPECT_EQ(test, adev->dm.brightness[0],
 			adev->dm.backlight_dev[0]->props.brightness);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
@@ -821,12 +821,12 @@ static void dm_test_validate_backlight_caps(struct kunit *test)
  */
 static void dm_test_brightness_range_null_caps(struct kunit *test)
 {
-	unsigned int min = 99, max = 99;
+	unsigned int user_min = 99, user_max = 99;
 
-	KUNIT_EXPECT_EQ(test, get_brightness_range(NULL, &min, &max), 0);
-	/* min/max should remain untouched */
-	KUNIT_EXPECT_EQ(test, min, 99U);
-	KUNIT_EXPECT_EQ(test, max, 99U);
+	KUNIT_EXPECT_EQ(test, get_brightness_range(NULL, &user_min, &user_max), 0);
+	/* user_min/user_max should remain untouched */
+	KUNIT_EXPECT_EQ(test, user_min, 99U);
+	KUNIT_EXPECT_EQ(test, user_max, 99U);
 }
 
 /**
@@ -836,16 +836,16 @@ static void dm_test_brightness_range_null_caps(struct kunit *test)
 static void dm_test_brightness_range_pwm(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
+	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &user_min, &user_max), 1);
 	/* 0x101 * AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, 0x101 * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT */
-	KUNIT_EXPECT_EQ(test, min, 0x101U * AMDGPU_DM_DEFAULT_MIN_BACKLIGHT);
-	KUNIT_EXPECT_EQ(test, max, 0x101U * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
+	KUNIT_EXPECT_EQ(test, user_min, 0x101U * AMDGPU_DM_DEFAULT_MIN_BACKLIGHT);
+	KUNIT_EXPECT_EQ(test, user_max, 0x101U * AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
 }
 
 /**
@@ -855,16 +855,16 @@ static void dm_test_brightness_range_pwm(struct kunit *test)
 static void dm_test_brightness_range_aux(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = true;
 	caps.aux_min_input_signal = 1;
 	caps.aux_max_input_signal = 512;
 
-	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
+	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &user_min, &user_max), 1);
 	/* millinits: 1000 * value */
-	KUNIT_EXPECT_EQ(test, min, 1000U);
-	KUNIT_EXPECT_EQ(test, max, 512000U);
+	KUNIT_EXPECT_EQ(test, user_min, 1000U);
+	KUNIT_EXPECT_EQ(test, user_max, 512000U);
 }
 
 /* Tests for convert_brightness_to_user() */
@@ -878,7 +878,7 @@ static void dm_test_brightness_to_user_null_caps(struct kunit *test)
 	/*
 	 * With NULL caps, get_brightness_range fails → passthrough.
 	 * We simulate this by passing a zeroed caps struct where
-	 * max_input_signal=0 makes max=0 and the function hits
+	 * max_input_signal=0 makes user_max=0 and the function hits
 	 * get_brightness_range returning 0 since caps is NULL.
 	 */
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(NULL, 42), 42U);
@@ -896,7 +896,7 @@ static void dm_test_brightness_to_user_below_min(struct kunit *test)
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	/* brightness < min (0x101*AMDGPU_DM_DEFAULT_MIN_BACKLIGHT), should return 0 */
+	/* brightness < user_min (0x101*AMDGPU_DM_DEFAULT_MIN_BACKLIGHT), should return 0 */
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, 100), 0U);
 }
 
@@ -907,16 +907,16 @@ static void dm_test_brightness_to_user_below_min(struct kunit *test)
 static void dm_test_brightness_to_user_at_max(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	/* At max → should return max */
-	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, max), max);
+	/* At user_max → should return user_max */
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, user_max), user_max);
 }
 
 /**
@@ -926,16 +926,16 @@ static void dm_test_brightness_to_user_at_max(struct kunit *test)
 static void dm_test_brightness_to_user_at_min(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	/* At min → should return 0 */
-	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, min), 0U);
+	/* At user_min → should return 0 */
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, user_min), 0U);
 }
 
 /**
@@ -945,19 +945,19 @@ static void dm_test_brightness_to_user_at_min(struct kunit *test)
 static void dm_test_brightness_to_user_midpoint_pwm(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max, mid_hw, result;
+	unsigned int user_min, user_max, mid_hw, result;
 	u64 expected;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/* midpoint of hw range */
-	mid_hw = min + (max - min) / 2;
-	/* expected = DIV_ROUND_CLOSEST_ULL((u64)max * (mid_hw - min), max - min) */
-	expected = DIV_ROUND_CLOSEST_ULL((u64)max * (mid_hw - min), max - min);
+	mid_hw = user_min + (user_max - user_min) / 2;
+	/* DIV_ROUND_CLOSEST_ULL((u64)user_max * (mid_hw - user_min), user_max - user_min) */
+	expected = DIV_ROUND_CLOSEST_ULL((u64)user_max * (mid_hw - user_min), user_max - user_min);
 	result = convert_brightness_to_user(&caps, mid_hw);
 
 	KUNIT_EXPECT_EQ(test, result, (u32)expected);
@@ -981,7 +981,7 @@ static void dm_test_brightness_from_user_null_caps(struct kunit *test)
 static void dm_test_brightness_from_user_zero(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
@@ -989,10 +989,10 @@ static void dm_test_brightness_from_user_zero(struct kunit *test)
 	/* no custom curve */
 	caps.data_points = 0;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	/* brightness=0 → min + 0 = min */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)min);
+	/* brightness=0 → user_min + 0 = user_min */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)user_min);
 }
 
 /**
@@ -1002,20 +1002,21 @@ static void dm_test_brightness_from_user_zero(struct kunit *test)
 static void dm_test_brightness_from_user_max(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 0;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
-	 * brightness=max → min + DIV_ROUND_CLOSEST((max-min)*max, max)
-	 *               = min + (max - min) = max
+	 * brightness=user_max →
+	 *   user_min + DIV_ROUND_CLOSEST((user_max-user_min)*user_max, user_max)
+	 *   = user_min + (user_max - user_min) = user_max
 	 */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)max);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, user_max), (u32)user_max);
 }
 
 /**
@@ -1025,19 +1026,19 @@ static void dm_test_brightness_from_user_max(struct kunit *test)
 static void dm_test_brightness_from_user_aux(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.aux_support = true;
 	caps.aux_min_input_signal = 1;
 	caps.aux_max_input_signal = 512;
 	caps.data_points = 0;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	/* brightness=0 → min */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)min);
-	/* brightness=max → max */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)max);
+	/* brightness=0 → user_min */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)user_min);
+	/* brightness=user_max → user_max */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, user_max), (u32)user_max);
 }
 
 /* Tests for convert_custom_brightness() */
@@ -1094,7 +1095,7 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
 	uint32_t brightness;
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
@@ -1110,22 +1111,23 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
 	caps.luminance_data[2].input_signal = 200;
 	caps.luminance_data[2].luminance = 90;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
 	 * Set brightness so that scale_input_to_fw yields exactly 128.
-	 * scale_input_to_fw(min, max, x) = DIV_ROUND_CLOSEST(x * 255, max - min)
-	 * With min=0, max=0x101*255=65535:
+	 * scale_input_to_fw(user_min, user_max, x) =
+	 *   DIV_ROUND_CLOSEST(x * 255, user_max - user_min)
+	 * With user_min=0, user_max=0x101*255=65535:
 	 * We need x such that DIV_ROUND_CLOSEST(x * 255, 65535) = 128
 	 * → x = 128 * 65535 / 255 = 32896
 	 */
 	brightness = 32896;
 
-	convert_custom_brightness(&caps, max, &brightness);
+	convert_custom_brightness(&caps, user_max, &brightness);
 
 	/*
 	 * Exact match: lum=50, brightness_scaled=128
-	 * result = scale_fw_to_input(max, DIV_ROUND_CLOSEST(50*128, 101))
+	 * result = scale_fw_to_input(user_max, DIV_ROUND_CLOSEST(50*128, 101))
 	 *        = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(6400, 101))
 	 *        = scale_fw_to_input(65535, 63)
 	 *        = DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
@@ -1144,7 +1146,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
 	uint32_t brightness;
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
@@ -1158,7 +1160,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
 	caps.luminance_data[1].input_signal = 200;
 	caps.luminance_data[1].luminance = 80;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
 	 * Set brightness low enough that scaled value < 100.
@@ -1167,7 +1169,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
 	 */
 	brightness = 12850;
 
-	convert_custom_brightness(&caps, max, &brightness);
+	convert_custom_brightness(&caps, user_max, &brightness);
 
 	/*
 	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
@@ -1189,7 +1191,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
 	uint32_t brightness;
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
@@ -1203,7 +1205,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
 	caps.luminance_data[1].input_signal = 200;
 	caps.luminance_data[1].luminance = 80;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
 	 * Choose a value between data points 50 and 200.
@@ -1211,7 +1213,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
 	 */
 	brightness = 32125;
 
-	convert_custom_brightness(&caps, max, &brightness);
+	convert_custom_brightness(&caps, user_max, &brightness);
 
 	/*
 	 * The function should interpolate between data points and produce
@@ -1230,7 +1232,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
 	uint32_t brightness;
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
@@ -1244,7 +1246,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
 	caps.luminance_data[1].input_signal = 150;
 	caps.luminance_data[1].luminance = 60;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
 	 * Choose brightness above the last data point (150).
@@ -1254,7 +1256,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
 	 */
 	brightness = 56533;
 
-	convert_custom_brightness(&caps, max, &brightness);
+	convert_custom_brightness(&caps, user_max, &brightness);
 
 	/* Output should differ from input (remapped via curve) */
 	KUNIT_EXPECT_TRUE(test, brightness != 56533);
@@ -1271,7 +1273,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
 	uint32_t brightness;
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
@@ -1283,7 +1285,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 	caps.luminance_data[0].input_signal = 128;
 	caps.luminance_data[0].luminance = 50;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
 	 * Brightness below the single data point triggers the
@@ -1292,7 +1294,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 	 */
 	brightness = 16448;
 
-	convert_custom_brightness(&caps, max, &brightness);
+	convert_custom_brightness(&caps, user_max, &brightness);
 
 	KUNIT_EXPECT_TRUE(test, brightness < 16448);
 
@@ -1307,7 +1309,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
 	uint32_t brightness;
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
@@ -1321,7 +1323,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 	caps.luminance_data[1].input_signal = 200;
 	caps.luminance_data[1].luminance = 80;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
 	/*
 	 * Choose brightness between data points to trigger interpolation.
@@ -1330,7 +1332,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 	 */
 	brightness = 32125;
 
-	convert_custom_brightness(&caps, max, &brightness);
+	convert_custom_brightness(&caps, user_max, &brightness);
 
 	/* Should remap; result should differ from input */
 	KUNIT_EXPECT_TRUE(test, brightness != 32125);
@@ -1345,18 +1347,18 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 static void dm_test_brightness_to_user_above_max(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max, result;
+	unsigned int user_min, user_max, result;
 
 	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	/* brightness above max → result > max (linear extrapolation) */
-	result = convert_brightness_to_user(&caps, max + 1000);
+	/* brightness above user_max → result > user_max (linear extrapolation) */
+	result = convert_brightness_to_user(&caps, user_max + 1000);
 
-	KUNIT_EXPECT_GT(test, result, max);
+	KUNIT_EXPECT_GT(test, result, user_max);
 }
 
 /**
@@ -1366,7 +1368,7 @@ static void dm_test_brightness_to_user_above_max(struct kunit *test)
 static void dm_test_brightness_from_user_midrange(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	u32 result;
 
 	caps.aux_support = false;
@@ -1374,13 +1376,13 @@ static void dm_test_brightness_from_user_midrange(struct kunit *test)
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 0;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	/* Mid-range brightness should map to between min and max */
-	result = convert_brightness_from_user(&caps, max / 2);
+	/* Mid-range brightness should map to between user_min and user_max */
+	result = convert_brightness_from_user(&caps, user_max / 2);
 
-	KUNIT_EXPECT_GE(test, result, min);
-	KUNIT_EXPECT_LE(test, result, max);
+	KUNIT_EXPECT_GE(test, result, user_min);
+	KUNIT_EXPECT_LE(test, result, user_max);
 }
 
 /**
@@ -1429,7 +1431,7 @@ static void dm_test_brightness_from_user_curve_min(struct kunit *test)
 static void dm_test_brightness_from_user_with_curve(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 	u32 with_curve, without_curve;
 	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 
@@ -1444,13 +1446,13 @@ static void dm_test_brightness_from_user_with_curve(struct kunit *test)
 	caps.luminance_data[1].input_signal = 200;
 	caps.luminance_data[1].luminance = 80;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 
-	with_curve = convert_brightness_from_user(&caps, max / 2);
+	with_curve = convert_brightness_from_user(&caps, user_max / 2);
 
 	/* Now disable the curve and compare */
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-	without_curve = convert_brightness_from_user(&caps, max / 2);
+	without_curve = convert_brightness_from_user(&caps, user_max / 2);
 
 	/* Custom curve should produce a different mapping */
 	KUNIT_EXPECT_NE(test, with_curve, without_curve);
@@ -1465,16 +1467,16 @@ static void dm_test_brightness_from_user_with_curve(struct kunit *test)
 static void dm_test_brightness_range_zero_signals(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min = 99, max = 99;
+	unsigned int user_min = 99, user_max = 99;
 
 	caps.aux_support = false;
 	caps.min_input_signal = 0;
 	caps.max_input_signal = 0;
 
-	/* Both signals zero → min=max=0 */
-	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
-	KUNIT_EXPECT_EQ(test, min, 0U);
-	KUNIT_EXPECT_EQ(test, max, 0U);
+	/* Both signals zero → user_min=user_max=0 */
+	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &user_min, &user_max), 1);
+	KUNIT_EXPECT_EQ(test, user_min, 0U);
+	KUNIT_EXPECT_EQ(test, user_max, 0U);
 }
 
 /* Tests for amdgpu_dm_backlight_fill_props() */
@@ -1487,19 +1489,19 @@ static void dm_test_backlight_fill_props_ac_linear(struct kunit *test)
 {
 	struct backlight_properties props = {};
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.min_input_signal = 12;
 	caps.max_input_signal = 255;
 	caps.ac_level = 40;
 	caps.dc_level = 20;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 	amdgpu_dm_backlight_fill_props(&caps, true, false, &props);
 
 	KUNIT_EXPECT_EQ(test, props.brightness,
-			 DIV_ROUND_CLOSEST(max * caps.ac_level, 100));
-	KUNIT_EXPECT_EQ(test, props.max_brightness, max);
+			 DIV_ROUND_CLOSEST(user_max * caps.ac_level, 100));
+	KUNIT_EXPECT_EQ(test, props.max_brightness, user_max);
 	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_LINEAR);
 	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
 }
@@ -1512,7 +1514,7 @@ static void dm_test_backlight_fill_props_dc_nonlinear(struct kunit *test)
 {
 	struct backlight_properties props = {};
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
+	unsigned int user_min, user_max;
 
 	caps.min_input_signal = 12;
 	caps.max_input_signal = 255;
@@ -1520,12 +1522,12 @@ static void dm_test_backlight_fill_props_dc_nonlinear(struct kunit *test)
 	caps.dc_level = 20;
 	caps.data_points = 2;
 
-	get_brightness_range(&caps, &min, &max);
+	get_brightness_range(&caps, &user_min, &user_max);
 	amdgpu_dm_backlight_fill_props(&caps, false, true, &props);
 
 	KUNIT_EXPECT_EQ(test, props.brightness,
-			 DIV_ROUND_CLOSEST(max * caps.dc_level, 100));
-	KUNIT_EXPECT_EQ(test, props.max_brightness, max);
+			 DIV_ROUND_CLOSEST(user_max * caps.dc_level, 100));
+	KUNIT_EXPECT_EQ(test, props.max_brightness, user_max);
 	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_NON_LINEAR);
 	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
 }

-- 
2.56.0

