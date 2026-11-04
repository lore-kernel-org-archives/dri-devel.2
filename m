Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338C606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=b1dqIlBc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391EF10FAEE;
	Wed,  4 Nov 2026 10:31:28 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D4010FAEE;
 Wed,  4 Nov 2026 10:31:20 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKMDR0LwvzMm4r;
 Wed, 04 Nov 2026 11:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793788279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXJwSyTxqd69ivwfRklJ7NYbfg1UZOo9zbh8+QCFhNU=;
 b=b1dqIlBcjFG1HaGVqsVdox3BdZEapIOjR/jtR4adUHzBWaLDWFXX3gYUCOHGpLhKr+HNPl
 M/eNKDo/lulRQjC2gEQcqbDcWVfcjbApXwrh2xm/EHghIvNGiO9zd9KlwGzfQQtdjPu4E4
 3LGRFvmeNwF7nuw173xuhYrqoc6jKobf2Wi6NPKoTqCyPiLhUJUo3t8QIQ8DX9vgm1R1TC
 dlQNUXFNgQEeNPCLXUjG0jJswaVuf0TpQ8S7a3jkTeZoBHsg9e4bpuxDoLna7EAR2+lwXv
 0euX1n9N615kNR5yI3sKlvaOmZyfxc4QdMxmOEk1qEqt+ZhsO9dl6eDrTwoxkg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: harry.wentland@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: Hugo Sales <hugo@hsal.es>, mario.limonciello@amd.com,
 christian.koenig@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, simona@ffwll.ch, alex.hung@amd.com,
 airlied@gmail.com
Subject: [PATCH RFC 2/3] drm/amd/display: Add KUnit tests for the ATIF
 backlight curve check
Date: Wed,  4 Nov 2026 10:31:11 +0000
Message-ID: <20261104-backlight-curve-validate-v1-2-10c688880e85@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
References: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9076; i=hugo@hsal.es;
 h=from:subject:message-id; bh=1GUm0bJWyR6vkTkTLmBmcbS3bTdhLNLiizcAiIg41xo=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl5zFqzQEfVpPTlrDsc8ixp+j+mC7qK73rKzsd4X6
 N/q3lvrcL2jlIVBjItBVkyRRfeGJwPLxMkzc4qeL4GZw8oEMoSBi1MAJvKog+F/ZfTWb3c4Lm9K
 aWnK6TvexZczY5fzLKv25N/L2fTNKg5+YPgfc3KpiF/LBre/Zx9l+tQHbC6Lu798t89z5vzCVAa
 WrezsACxnSPo=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKMDR0LwvzMm4r
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

Test the curve check in amdgpu_dm_validate_backlight_caps():

- the GV301QH curve stays as it is
- a luminance over 100% becomes 100%
- a falling luminance rises to the point before
- a curve whose signals fall gets dropped
- a repeated signal stays
- a curve with more points than luminance_data holds is cut to fit

Also check the brightness the PWM and AUX paths give on the checked
curves

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
KUnit: dm_test_validate_custom_curve_unsorted and the luminance checks
in the falling test fail without patch 1
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 184 +++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index b3e6a96320164..d76527e49acf2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1696,6 +1696,185 @@ static void dm_test_brightness_curve_pwm_luminance_over_100(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 225000), 255000U);
 }
 
+/* Tests for the custom curve check in amdgpu_dm_validate_backlight_caps() */
+
+static struct amdgpu_display_manager *alloc_validate_dm(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+
+	dm->adev = dm_kunit_alloc_adev(test);
+	/* drm_warn() prints the curve warnings against this device */
+	KUNIT_ASSERT_NOT_NULL(test, adev_to_drm(dm->adev)->dev);
+
+	return dm;
+}
+
+static struct amdgpu_dm_backlight_caps *
+validate_custom_curve(struct amdgpu_display_manager *dm,
+		      const struct amdgpu_dm_luminance_data *points, int n)
+{
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	set_custom_curve_caps(caps, points, n);
+	caps->caps_valid = true;
+	amdgpu_dm_validate_backlight_caps(dm, 0);
+
+	return caps;
+}
+
+/**
+ * dm_test_validate_custom_curve_gv301qh - Test a good ATIF curve is left alone
+ * @test: The KUnit test context
+ *
+ * The GV301QH curve rises and stays within 100%, so the check must keep
+ * every point as it is
+ */
+static void dm_test_validate_custom_curve_gv301qh(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	set_gv301qh_caps(caps, false);
+	caps->caps_valid = true;
+	amdgpu_dm_validate_backlight_caps(dm, 0);
+
+	KUNIT_EXPECT_TRUE(test, caps->caps_valid);
+	KUNIT_ASSERT_EQ(test, caps->data_points, ARRAY_SIZE(gv301qh_curve));
+	KUNIT_EXPECT_MEMEQ(test, caps->luminance_data, gv301qh_curve, sizeof(gv301qh_curve));
+}
+
+/**
+ * dm_test_validate_custom_curve_luminance_over_100 - Test ATIF luminance over 100% becomes 100%
+ * @test: The KUnit test context
+ *
+ * Points (100, 50), (200, 150) and (250, 120) become (100, 50), (200, 100)
+ * and (250, 100). Level 150 is then 50 + 50 * 50 / 100 = 75% and level 200
+ * is full brightness. Over AUX, 301176 of 512000 is just below signal 150,
+ * so it lands one below 75% of 1000..512000, at 384249
+ */
+static void dm_test_validate_custom_curve_luminance_over_100(struct kunit *test)
+{
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 100, .luminance = 50 },
+		{ .input_signal = 200, .luminance = 150 },
+		{ .input_signal = 250, .luminance = 120 },
+	};
+	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
+	struct amdgpu_dm_backlight_caps *caps;
+
+	dm_test_enable_custom_curve(test);
+	caps = validate_custom_curve(dm, points, ARRAY_SIZE(points));
+
+	KUNIT_ASSERT_EQ(test, caps->data_points, 3);
+	KUNIT_EXPECT_EQ(test, caps->luminance_data[0].luminance, 50);
+	KUNIT_EXPECT_EQ(test, caps->luminance_data[1].luminance, 100);
+	KUNIT_EXPECT_EQ(test, caps->luminance_data[2].luminance, 100);
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 150 * 0x101), 49151U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 200 * 0x101), 65535U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 150 * 0x101), 75000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 200 * 0x101), 100000U);
+
+	caps->aux_support = true;
+	caps->aux_min_input_signal = 1;
+	caps->aux_max_input_signal = 512;
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 301176), 384249U);
+}
+
+/**
+ * dm_test_validate_custom_curve_falling - Test a falling ATIF point is raised
+ * @test: The KUnit test context
+ *
+ * In (50, 30), (100, 60), (150, 40) and (200, 80), the point at 150 is
+ * raised to 60%, so the curve is flat from 100 to 150. Level 125 is 60% on
+ * both paths, which over AUX is 307600 in 1000..512000
+ */
+static void dm_test_validate_custom_curve_falling(struct kunit *test)
+{
+	static const struct amdgpu_dm_luminance_data points[] = {
+		{ .input_signal = 50, .luminance = 30 },
+		{ .input_signal = 100, .luminance = 60 },
+		{ .input_signal = 150, .luminance = 40 },
+		{ .input_signal = 200, .luminance = 80 },
+	};
+	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
+	struct amdgpu_dm_backlight_caps *caps;
+
+	dm_test_enable_custom_curve(test);
+	caps = validate_custom_curve(dm, points, ARRAY_SIZE(points));
+
+	KUNIT_ASSERT_EQ(test, caps->data_points, 4);
+	KUNIT_EXPECT_EQ(test, caps->luminance_data[1].luminance, 60);
+	KUNIT_EXPECT_EQ(test, caps->luminance_data[2].luminance, 60);
+	KUNIT_EXPECT_EQ(test, caps->luminance_data[3].luminance, 80);
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 125 * 0x101), 39321U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 125 * 0x101), 60000U);
+
+	caps->aux_support = true;
+	caps->aux_min_input_signal = 1;
+	caps->aux_max_input_signal = 512;
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 250980), 307600U);
+}
+
+/**
+ * dm_test_validate_custom_curve_unsorted - Test a curve whose signals fall is dropped
+ * @test: The KUnit test context
+ *
+ * A signal below the one before leaves no curve, so the mapping is
+ * linear. A repeated signal is a step: the curve stays, and level 100 is
+ * at the later point's 60%
+ */
+static void dm_test_validate_custom_curve_unsorted(struct kunit *test)
+{
+	static const struct amdgpu_dm_luminance_data falling[] = {
+		{ .input_signal = 100, .luminance = 40 },
+		{ .input_signal = 80, .luminance = 60 },
+	};
+	static const struct amdgpu_dm_luminance_data repeated[] = {
+		{ .input_signal = 50, .luminance = 20 },
+		{ .input_signal = 100, .luminance = 40 },
+		{ .input_signal = 100, .luminance = 60 },
+	};
+	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
+	struct amdgpu_dm_backlight_caps *caps;
+
+	dm_test_enable_custom_curve(test);
+
+	caps = validate_custom_curve(dm, falling, ARRAY_SIZE(falling));
+	KUNIT_EXPECT_EQ(test, caps->data_points, 0);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 32768), 32768U);
+
+	caps = validate_custom_curve(dm, repeated, ARRAY_SIZE(repeated));
+	KUNIT_EXPECT_EQ(test, caps->data_points, 3);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 100 * 0x101), 60000U);
+}
+
+/**
+ * dm_test_validate_custom_curve_too_many_points - Test data_points is cut to the array
+ * @test: The KUnit test context
+ *
+ * data_points is a u8 from firmware, so it can claim more points than
+ * luminance_data holds. The check keeps the points that fit
+ */
+static void dm_test_validate_custom_curve_too_many_points(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+	int i;
+
+	set_gv301qh_caps(caps, false);
+	for (i = 0; i < ARRAY_SIZE(caps->luminance_data); i++) {
+		caps->luminance_data[i].input_signal = 2 * i;
+		caps->luminance_data[i].luminance = i;
+	}
+	caps->data_points = 255;
+	caps->caps_valid = true;
+	amdgpu_dm_validate_backlight_caps(dm, 0);
+
+	KUNIT_EXPECT_EQ(test, caps->data_points, ARRAY_SIZE(caps->luminance_data));
+}
+
 /**
  * dm_test_brightness_range_zero_signals - Test Brightness range with zero min and max signals
  * @test: The KUnit test context
@@ -2365,6 +2544,11 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_caps_aux_support_noop),
 	/* amdgpu_dm_validate_backlight_caps */
 	KUNIT_CASE_PARAM(dm_test_validate_backlight_caps, dm_validate_caps_gen_params),
+	KUNIT_CASE(dm_test_validate_custom_curve_gv301qh),
+	KUNIT_CASE(dm_test_validate_custom_curve_luminance_over_100),
+	KUNIT_CASE(dm_test_validate_custom_curve_falling),
+	KUNIT_CASE(dm_test_validate_custom_curve_unsorted),
+	KUNIT_CASE(dm_test_validate_custom_curve_too_many_points),
 	/* get_brightness_range */
 	KUNIT_CASE(dm_test_brightness_range_null_caps),
 	KUNIT_CASE(dm_test_brightness_range_pwm),

-- 
2.56.0

