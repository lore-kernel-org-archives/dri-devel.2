Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36243606A33D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=sPEUSkFO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9C010FAAD;
	Wed,  4 Nov 2026 09:55:44 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F5910FAB2;
 Wed,  4 Nov 2026 09:55:35 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKLR80xYDzMlw4;
 Wed, 04 Nov 2026 10:55:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793786132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSX/1XUwvLJLJz6lq4o1xr498yf2Qc2aomJHi27Xy2I=;
 b=sPEUSkFOziTu868ZeP1BoPGuOOfEouNiO242Y6cy2u8D5l/2QUMpxRRj0vwFHFO1hr9Ojj
 AylCcZLV55S7E1wmRUsRnOAJo2V9/3DR5lQYoOWxBAl00SbUVJCy4qDFc+YctTtri8vukr
 i+lKxLZ5Pin6h6AAKxxoUS/mvrPxad+SDy+48vhIdwBpxdlgBzIi0Rsu2gcGXaqHX11lXi
 Tw4SnHdgBhoJ/375c8fx6UOJRquU5VaWfFuD9rP1gdHsBgu2gER4AuZk9zFklnq8DMsZUq
 ASxrZ6McYAvlp9EeEZGa4kE2IefDL/ugzj5r7NqJtTEj6x9QbAl4mdim3jkPqA==
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
Subject: [PATCH RFC RFT 8/8] drm/amd/display: Add KUnit tests for the AUX
 custom brightness curve
Date: Wed,  4 Nov 2026 09:55:16 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-8-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8862; i=hugo@hsal.es;
 h=from:subject:message-id; bh=iwaAc4GsJnoeuRBokxJnBL0Uww8p0y0rlvxvEudRSf4=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRJUUxR5LilEMfTMzmfm6zIdlHXmLLVudNCT+/
 mhIuxwrmt5RysIgxsUgK6bIonvDk4Fl4uSZOUXPl8DMYWUCGcLAxSkAEwnJZmTY7n3g89q2Ixru
 Am2e5acCPRquXjTP3pK4gpclJvn7n49ljAwXJ7+P2xO1IIi5uOtN32POO4t+f/tVNf/btkULbO3
 DPv5iBQDk+EzO
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKLR80xYDzMlw4
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

Test the AUX mapping with the GV301QH curve on the 1..512 nits fallback
range. A request for 0 and for max must give user_min and user_max on
both paths, and values must match ones worked out by hand. A walk over
every request must never go down, must leave the minimum within 1% of
the scale and must change the output on most steps. An AUX curve whose
max_input_signal is below 255 must still run to 100% at signal 255

Check convert_brightness_from_user() on the PWM and AUX ranges in the
test with a luminance over 100% too

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
KUnit on UML with PROVE_LOCKING: amdgpu_dm_backlight passes 83 of 83
without this patch and 87 of 87 with it. Without patch 7 the four new
tests fail, and so do the brightness checks added to the luminance over
100% test

This and patch 7 are the AUX half of the series. My laptop's panel
ignores AMD's AUX brightness, so I tested them only in KUnit and with
the amdgpu_dm_brightness trace on a forced AUX path. Patches 1 to 6
don't need them
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 133 ++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 06c1e084357ff..b3e6a96320164 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1517,6 +1517,75 @@ static void dm_test_brightness_curve_pwm_steps(struct kunit *test)
 	KUNIT_EXPECT_GT(test, steps, (user_max - user_min) / 2);
 }
 
+/**
+ * dm_test_brightness_from_user_curve_floor - Test Custom curve ends are the minimum and max
+ * @test: The KUnit test context
+ *
+ * A request for 0 must reach the panel as the minimum, not as the minimum
+ * applied twice, and a request for max must reach max, on both the PWM and
+ * the AUX range
+ */
+static void dm_test_brightness_from_user_curve_floor(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int user_min, user_max;
+
+	dm_test_enable_custom_curve(test);
+
+	set_gv301qh_caps(&caps, false);
+	get_brightness_range(&caps, &user_min, &user_max);
+	KUNIT_EXPECT_EQ(test, user_min, 3084U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)user_min);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, user_max), (u32)user_max);
+
+	set_gv301qh_caps(&caps, true);
+	get_brightness_range(&caps, &user_min, &user_max);
+	KUNIT_EXPECT_EQ(test, user_min, 1000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)user_min);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, user_max), (u32)user_max);
+}
+
+/**
+ * dm_test_brightness_from_user_curve_values - Test Custom curve output on the AUX range
+ * @test: The KUnit test context
+ *
+ * Worked out by hand on the AUX range of 1000..512000 millinits. 1000 is
+ * signal 0.498, so 0.0711% from (0, 0) to the first point (14, 2), and
+ * 1000 + 511000 * 0.000711 gives 1364. 200000 is signal 99.61, between
+ * (98, 50) and (103, 52), so 50.644% and 259790
+ */
+static void dm_test_brightness_from_user_curve_values(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	dm_test_enable_custom_curve(test);
+	set_gv301qh_caps(&caps, true);
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 1000), 1364U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 200000), 259790U);
+}
+
+/**
+ * dm_test_brightness_from_user_curve_aux_top - Test AUX curve ignores the PWM max_input_signal
+ * @test: The KUnit test context
+ *
+ * On AUX the curve runs to 100% at signal 255 even when max_input_signal,
+ * a PWM limit, is lower. With max_input_signal 251, 499953 is signal
+ * 249.00003, between the last point (247, 98) and 100% at 255, so 98.5%
+ * and 504335. Ending the curve at 251 would give 99% and 506890
+ */
+static void dm_test_brightness_from_user_curve_aux_top(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	dm_test_enable_custom_curve(test);
+	set_gv301qh_caps(&caps, true);
+	caps.max_input_signal = 251;
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 499953), 504335U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 512000), 512000U);
+}
+
 /**
  * dm_test_brightness_curve_pwm_points_above_max - Test PWM curve points above max_input_signal
  * @test: The KUnit test context
@@ -1543,6 +1612,51 @@ static void dm_test_brightness_curve_pwm_points_above_max(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 0x101 * 200), 100000U);
 }
 
+static void check_curve_steps(struct kunit *test,
+			      const struct amdgpu_dm_backlight_caps *caps)
+{
+	unsigned int user_min, user_max, user, steps = 0;
+	u32 prev, cur;
+
+	get_brightness_range(caps, &user_min, &user_max);
+	prev = user_min;
+	for (user = 0; user <= user_max; user++) {
+		cur = convert_brightness_from_user(caps, user);
+		if (cur < prev || cur > user_max) {
+			KUNIT_FAIL(test, "%u gives %u after %u, range %u..%u",
+				   user, cur, prev, user_min, user_max);
+			return;
+		}
+		steps += cur != prev;
+		prev = cur;
+	}
+
+	KUNIT_EXPECT_GT(test, convert_brightness_from_user(caps, user_max / 100), (u32)user_min);
+	KUNIT_EXPECT_GT(test, steps, (user_max - user_min) / 2);
+}
+
+/**
+ * dm_test_brightness_from_user_curve_monotonic - Test Custom curve never drops and keeps its steps
+ * @test: The KUnit test context
+ *
+ * Every request from 0 to max, on both the PWM and the AUX range, must give
+ * a value in user_min..user_max that is no lower than the one for the request
+ * before. 1% of the range must already be above the minimum, and most
+ * requests must change the output
+ */
+static void dm_test_brightness_from_user_curve_monotonic(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	dm_test_enable_custom_curve(test);
+
+	set_gv301qh_caps(&caps, false);
+	check_curve_steps(test, &caps);
+
+	set_gv301qh_caps(&caps, true);
+	check_curve_steps(test, &caps);
+}
+
 /**
  * dm_test_brightness_curve_pwm_luminance_over_100 - Test PWM with an ATIF luminance over 100%
  * @test: The KUnit test context
@@ -1550,7 +1664,9 @@ static void dm_test_brightness_curve_pwm_points_above_max(struct kunit *test)
  * Points (100, 50), (200, 150) and (250, 120) claim more than 100%. The
  * curve uses them as given and caps only the result, as before.
  * Level 125 is 50 + 100 * 25 / 100 = 75%, and the curve reaches full
- * brightness at level 150, halfway to the second point, and stays there
+ * brightness at level 150, halfway to the second point, and stays there.
+ * On the AUX range of 1..255 nits, level 125000 is signal 125, so 1000 +
+ * 75% of 254000
  */
 static void dm_test_brightness_curve_pwm_luminance_over_100(struct kunit *test)
 {
@@ -1564,9 +1680,20 @@ static void dm_test_brightness_curve_pwm_luminance_over_100(struct kunit *test)
 	dm_test_enable_custom_curve(test);
 	set_custom_curve_caps(&caps, points, ARRAY_SIZE(points));
 
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 125 * 0x101), 49151U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 150 * 0x101), 65535U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 225 * 0x101), 65535U);
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 125 * 0x101), 75000U);
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 150 * 0x101), 100000U);
 	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 225 * 0x101), 100000U);
+
+	caps.aux_support = true;
+	caps.aux_min_input_signal = 1;
+	caps.aux_max_input_signal = 255;
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 125000), 191500U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 150000), 255000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 225000), 255000U);
 }
 
 /**
@@ -2268,7 +2395,11 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_brightness_from_user_curve_min),
 	KUNIT_CASE(dm_test_brightness_curve_pwm_values),
 	KUNIT_CASE(dm_test_brightness_curve_pwm_steps),
+	KUNIT_CASE(dm_test_brightness_from_user_curve_floor),
+	KUNIT_CASE(dm_test_brightness_from_user_curve_values),
+	KUNIT_CASE(dm_test_brightness_from_user_curve_aux_top),
 	KUNIT_CASE(dm_test_brightness_curve_pwm_points_above_max),
+	KUNIT_CASE(dm_test_brightness_from_user_curve_monotonic),
 	KUNIT_CASE(dm_test_brightness_curve_pwm_luminance_over_100),
 	KUNIT_CASE(dm_test_brightness_range_zero_signals),
 	/* amdgpu_dm_backlight_fill_props */

-- 
2.56.0

