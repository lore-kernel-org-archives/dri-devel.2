Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FE606D81F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=P4cR5fKS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601D510FAD1;
	Wed,  4 Nov 2026 09:55:39 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E14F10FAB7;
 Wed,  4 Nov 2026 09:55:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKLR46B2yzMm4k;
 Wed, 04 Nov 2026 10:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793786128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25MNtijzcOe+5x6jv2uk4Ld/cRiFGcxQziSZ3KTb4LM=;
 b=P4cR5fKS8KHU+/Em5Q5gvd9iyCcmqlrS5oWEcTRJC8xTXrLRWGtu26r7nKRW+p0u5gkL69
 4KsVUGPm1yQuLga5hiDwkv7wEdRNhMWt+CIH6FF6eTqhc7N2XLNCvaUuVNe53YYwgrJ7U0
 BsabHGMLta8MCSjGl2kv7+KpY6DBoqDNOQfBlqTTWtfr+234baoEACokkAr/ASzBGBwn5M
 o/wjlSqXfR4D9wFMiAfbPt6l+0v1NgS4tvuvUc53x00uEcS8FUh3EJ02IdhFtf2apx76qH
 BHo8N7Ur2nCQZuU8kh2Ft4JHmklbL+zqmBqbCQtMcOFdWH/NjX8YzdaBroHpxQ==
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
Subject: [PATCH RFC RFT 6/8] drm/amd/display: Add KUnit tests for backlight
 LUT interpolation
Date: Wed,  4 Nov 2026 09:55:14 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-6-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11960; i=hugo@hsal.es;
 h=from:subject:message-id; bh=0mMCaT8mms2X7zb63wewS8AewVlg8BBP+QOblL9WdwI=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRDE8Fgy1nxA10+1fj+M5blc1yYxZe0JuH3j+8
 o5my/5VHYwdpSwMYlwMsmKKLLo3PBlYJk6emVP0fAnMHFYmsCFcnAIwkYspjAxdFtM7rVNUwnS6
 l8QJGfLMEmfi93/qMKlnxuGljccOX1ZhZGj9v25ybfLzjEf1NqK/V3q3fjioIh11Z8uVHfVbexM
 4TzADAF5ZSJ0=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKLR46B2yzMm4k
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

Build the power module's LUT with initialize_backlight_caps() from the
ATIF reply of an ASUS ROG Flow X13 GV301QH, with min_input_signal 0, and
test backlight_millipercent_to_pwm() on it. A whole percent gives its
LUT entry, and a request in between lands between the two entries, at
values worked out by hand. The PWM never goes down as the request goes
up, and below the first curve point every millipercent gets its own
PWM, where the floor index gave only 0 and 0x707

Test backlight_pwm_to_millipercent() by hand at two points too, and
check that every PWM turned into a percentage and back lands within 1
of where it started. A LUT built with the real min_input_signal of 12
gets the same hand checks in both directions

Export these functions when the KUnit tests are enabled, so the tests
can call them

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
The tests use gv301qh_curve and set_gv301qh_caps() from patch 5

KUnit on UML with PROVE_LOCKING: amdgpu_dm_backlight passes 78 of 78
without this patch and 83 of 83 with it. dm_test_pwm_lut_whole_percents
passes at every patch, since a whole percent always gave the LUT entry.
dm_test_pwm_lut_between_percents, dm_test_pwm_lut_monotonic and
dm_test_pwm_lut_min_input_signal pass from patch 2, and
dm_test_pwm_lut_readback from patch 3

The other amdgpu_dm suites behave the same with and without the series,
as in patch 5

checkpatch --strict flags two prototypes whose line ends in '('. They
follow the DC style of the prototypes around them in power_abm.c and
power_helpers.h
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 146 +++++++++++++++++++++
 .../gpu/drm/amd/display/modules/power/power_abm.c  |  10 +-
 .../drm/amd/display/modules/power/power_helpers.h  |   4 +
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index ba8ffb92ae7af..e9da2c46779fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -24,6 +24,7 @@
 #include "amd_shared.h"
 #include "link_service.h"
 #include "dc/inc/hw/panel_cntl.h"
+#include "power_helpers.h"
 
 struct dm_backlight_connector_fixture {
 	struct amdgpu_device *adev;
@@ -2163,6 +2164,145 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
 }
 
+/* Tests for the legacy backlight LUT conversion, in both directions */
+
+/*
+ * Build the power module's backlight LUT from the GV301QH curve the same
+ * way the driver does, through the ATIF caps cached in the display manager
+ */
+static struct core_power *gv301qh_power_module(struct kunit *test, int min_input_signal)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct core_power *core_power;
+
+	core_power = kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, core_power);
+
+	set_gv301qh_caps(&adev->dm.backlight_caps[0], false);
+	adev->dm.backlight_caps[0].min_input_signal = min_input_signal;
+	adev->dm.backlight_caps[0].caps_valid = true;
+	dc->ctx->driver_context = adev;
+	core_power->dc = dc;
+	core_power->bl_prop[0].num_backlight_levels = 101;
+	core_power->bl_prop[0].backlight_lut = kunit_kcalloc(test, 101, sizeof(unsigned int),
+							     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, core_power->bl_prop[0].backlight_lut);
+
+	initialize_backlight_caps(core_power, 0);
+	KUNIT_ASSERT_TRUE(test, core_power->bl_prop[0].backlight_caps_valid);
+
+	return core_power;
+}
+
+/**
+ * dm_test_pwm_lut_whole_percents - Test Whole percents give the LUT entry
+ * @test: The KUnit test context
+ *
+ * With min_input_signal 0 the LUT starts at 0, reaches the first curve
+ * point (signal 14, 2%) at index 2 and has 0x707 halfway at index 1. Index
+ * 50 is the point (98, 50%)
+ */
+static void dm_test_pwm_lut_whole_percents(struct kunit *test)
+{
+	struct core_power *core_power = gv301qh_power_module(test, 0);
+
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 0, 0), 0U);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 1000, 0), 0x707U);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 2000, 0), 0xe0eU);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 50000, 0), 98U * 0x101);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 100000, 0), 0xffffU);
+}
+
+/**
+ * dm_test_pwm_lut_between_percents - Test Requests between percents interpolate
+ * @test: The KUnit test context
+ *
+ * The code rounds the step between two entries before adding it. 0.5% is
+ * halfway from 0 to 0x707, so 1799 / 2 = 899.5, which rounds to 900. 1.5%
+ * is 1799 + 900 = 2699. 2.5% is halfway from 0xe0e to 0xf0f, so 257 / 2 =
+ * 128.5 rounds to 129 and 3598 + 129 = 3727. 99.999% is 1028 * 999 / 1000
+ * = 1026.97 past 64507, which rounds to 1027 and gives 65534
+ */
+static void dm_test_pwm_lut_between_percents(struct kunit *test)
+{
+	struct core_power *core_power = gv301qh_power_module(test, 0);
+
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 500, 0), 900U);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 1500, 0), 2699U);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 2500, 0), 3727U);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 99999, 0), 65534U);
+}
+
+/**
+ * dm_test_pwm_lut_readback - Test PWM reads back as the percentage that set it
+ * @test: The KUnit test context
+ *
+ * 900 is halfway from 0 to 0x707, so it reads back as 0.5%. Every PWM from
+ * 0 to 0xffff turned into a percentage and back must land within 1 of
+ * where it started
+ */
+static void dm_test_pwm_lut_readback(struct kunit *test)
+{
+	struct core_power *core_power = gv301qh_power_module(test, 0);
+	unsigned int pwm, mp;
+
+	KUNIT_EXPECT_EQ(test, backlight_pwm_to_millipercent(core_power, 0x707, 0), 1000U);
+	KUNIT_EXPECT_EQ(test, backlight_pwm_to_millipercent(core_power, 900, 0), 500U);
+
+	for (pwm = 0; pwm <= 0xffff; pwm++) {
+		mp = backlight_pwm_to_millipercent(core_power, pwm, 0);
+		KUNIT_ASSERT_LE_MSG(test,
+				    abs((int)backlight_millipercent_to_pwm(core_power, mp, 0) -
+					(int)pwm), 1,
+				    "pwm %u", pwm);
+	}
+}
+
+/**
+ * dm_test_pwm_lut_monotonic - Test PWM never goes down as the request goes up
+ * @test: The KUnit test context
+ *
+ * Every millipercent below 2% must also get its own PWM, where the floor
+ * index gave only 0 and 0x707
+ */
+static void dm_test_pwm_lut_monotonic(struct kunit *test)
+{
+	struct core_power *core_power = gv301qh_power_module(test, 0);
+	unsigned int mp, pwm, prev = 0, steps = 0;
+
+	for (mp = 0; mp <= 100000; mp++) {
+		pwm = backlight_millipercent_to_pwm(core_power, mp, 0);
+		KUNIT_ASSERT_GE_MSG(test, pwm, prev, "millipercent %u", mp);
+		if (mp < 2000 && (mp == 0 || pwm != prev))
+			steps++;
+		prev = pwm;
+	}
+
+	KUNIT_EXPECT_EQ(test, steps, 2000U);
+}
+
+/**
+ * dm_test_pwm_lut_min_input_signal - Test the LUT with the real minimum of 12
+ * @test: The KUnit test context
+ *
+ * With min_input_signal 12 the LUT starts at 0xc0c, has 3341 at index 1 and
+ * reaches the first curve point (signal 14, 2%) at index 2, 0xe0e. 1.714%,
+ * the curve's value at the minimum, is 0.714 of the way from 3341 to 0xe0e,
+ * so 3341 + 183 = 3524. A PWM at or below 0xc0c reads back as 0%
+ */
+static void dm_test_pwm_lut_min_input_signal(struct kunit *test)
+{
+	struct core_power *core_power = gv301qh_power_module(test, 12);
+
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 0, 0), 0xc0cU);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 1000, 0), 3341U);
+	KUNIT_EXPECT_EQ(test, backlight_millipercent_to_pwm(core_power, 1714, 0), 3524U);
+	KUNIT_EXPECT_EQ(test, backlight_pwm_to_millipercent(core_power, 3341, 0), 1000U);
+	KUNIT_EXPECT_EQ(test, backlight_pwm_to_millipercent(core_power, 0xc0c, 0), 0U);
+	KUNIT_EXPECT_EQ(test, backlight_pwm_to_millipercent(core_power, 1000, 0), 0U);
+}
+
 static struct kunit_case dm_backlight_test_cases[] = {
 	/* dm_find_stream_with_link */
 	KUNIT_CASE(dm_test_find_stream_with_link_returns_match),
@@ -2255,6 +2395,12 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_setup_backlight_device_max_edps),
 	KUNIT_CASE(dm_test_setup_backlight_device_oled_success),
 	KUNIT_CASE(dm_test_setup_backlight_device_attaches_abm_property),
+	/* legacy backlight LUT conversion */
+	KUNIT_CASE(dm_test_pwm_lut_whole_percents),
+	KUNIT_CASE(dm_test_pwm_lut_between_percents),
+	KUNIT_CASE(dm_test_pwm_lut_readback),
+	KUNIT_CASE(dm_test_pwm_lut_monotonic),
+	KUNIT_CASE(dm_test_pwm_lut_min_input_signal),
 	{}
 };
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index 83d79c20281ec..11efe59b9f96b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -3,6 +3,7 @@
 // Copyright 2026 Advanced Micro Devices, Inc.
 
 #include "dm_services.h"
+#include "dm_helpers.h"
 #include "dc.h"
 #include "mod_power.h"
 #include "core_types.h"
@@ -436,7 +437,8 @@ static unsigned int backlight_pwm_to_millipercent_legacy(
  * 0 PWM = 0% and max_backlight_pwm = 100%.
  * Otherwise, falls back to the legacy LUT based mapping.
  */
-static unsigned int backlight_pwm_to_millipercent(
+STATIC_IFN_KUNIT
+unsigned int backlight_pwm_to_millipercent(
 		struct core_power *core_power, unsigned int pwm, unsigned int inst)
 {
 	if (!is_vesa_abc(core_power, inst))
@@ -456,6 +458,8 @@ static unsigned int backlight_pwm_to_millipercent(
 			core_power->bl_prop[inst].max_backlight_pwm);
 }
 
+EXPORT_IF_KUNIT(backlight_pwm_to_millipercent);
+
 static unsigned int backlight_pwm_to_millinit_legacy(
 		struct core_power *core_power, unsigned int pwm, unsigned int inst)
 {
@@ -586,6 +590,8 @@ unsigned int backlight_millipercent_to_pwm(
 			BACKLIGHT_MILLIPERCENT_MAX);
 }
 
+EXPORT_IF_KUNIT(backlight_millipercent_to_pwm);
+
 /* Legacy millinit→PWM conversion: scales linearly between
  * [min_brightness_millinits, max_brightness_millinits] → [min_backlight_pwm, max_backlight_pwm].
  */
@@ -844,6 +850,8 @@ void initialize_backlight_caps(struct core_power *core_power, unsigned int inst)
 	core_power->bl_prop[inst].backlight_caps_valid = true;
 }
 
+EXPORT_IF_KUNIT(initialize_backlight_caps);
+
 static void varibright_set_level(struct core_power *core_power)
 {
 	if (!core_power->varibright_prop.varibright_active ||
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 68679fa109460..9c07f1c92a781 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -201,6 +201,10 @@ void mod_power_set_backlight_control_type(struct core_power *core_power,
 		unsigned int inst, enum backlight_control_type backlight_control_type);
 unsigned int backlight_millipercent_to_pwm(
 		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+unsigned int backlight_pwm_to_millipercent(
+		struct core_power *core_power, unsigned int pwm, unsigned int inst);
+#endif
 unsigned int backlight_millipercent_to_millinit(
 		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
 void fill_backlight_level_params(struct core_power *core_power,

-- 
2.56.0

