Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151A606A68D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+PHVEOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F70110EFAF;
	Mon, 23 Nov 2026 16:21:26 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2270210EFD6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:21:20 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so27647715e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450878; x=1796055678; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SZTWBMmt2DFM0xgpeL4tW3LgzfUZb1ELoVM7m/gJHa0=;
 b=h+PHVEOvNiFMHfeG4wjj40Kmr9xIP8A5HlnXxsyIibWJZv9KAv4IesBNFCyJgFKBRF
 of7X4KyxkUSCcG80te5fIHrUfkQPHLra40rbv6JpI0CMpTCN15+zFEkVhLWTeXJ4HwOV
 vtEsoP3iw5qO1r7MPaT8stLqYX+F8M0ssB8sK064NOtEF0Gx/5fhCJlIatphyguYOmGY
 gJfVZ2hQ2EA9yPmNTZmFkZPn1Qhfodj/c2tK/BO+qNFyr+G9TkUooTwvql2orkggti7m
 1SskhPORjpfLS5FtGBEf/Npew/moiF2Bz6BW9Wgw8x5dLUTyC0kFFbxUlAMNdsAcmKBW
 saPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450878; x=1796055678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SZTWBMmt2DFM0xgpeL4tW3LgzfUZb1ELoVM7m/gJHa0=;
 b=T1Br92i54jS1T8A3q7L1JhudUBNzluvHqqfAsLZpvPb1ZbpsMYd8n5aWecg0UdWqfJ
 c44D+EDxPghr7JFvS7i6Cqnkem56JrLYME1vtMqjU8sL8ylXubPr9bS9zipRaYcdVI+r
 pUjRjy9Yew+SpeipCHPc8A7crpzzUZgbkLBQOr/I+UzbCkOrEwL6mHFl6IF81SQUfKL9
 insagWZ6xso14Caq2z1feuIHqFT277DjGeTfU/CeYEVXS6FNabladnpeh0YL3LZwccdk
 ukxLulF79CqdfLZ5kPyluzyxNJI00115xYd41qPBJ0T+R8FgAA30CCU1ro8ueXLfUcJd
 A41w==
X-Gm-Message-State: APuU4Z/n0AHPv91+wmYOQGdM1Giao4LHtcwY2bE143aX1DK0OfWuiuJf
 QlnQQMyOtnqQu+dkFJEkm3f2cjsiYtE3qQvy7sICOWVyPRjuXy7z8CGP
X-Gm-Gg: AZFdTZfh2keDKi3Dp9lc9wfugr0z44kP2ZCf6BzHppTJMw+KVvyZSFvYsiSR7f45mZO
 mdIt5HorTCFEkcnjc6WqGwBfjWCLckJ/i0G+t99ekxkcqZtThklXHzB7itO/t+kjG4HPNyWzVeF
 tM3UVdzL5P7y9sAgfMqXoT7XlJ9B+OfdVp6NGLzNwQbO01TDWq1tIUbfl76VQ09Xzu0JzgT4/Ru
 Foj3PhG4VihGWs3/HKls4SJrBR8UyZfX8Gx0tQnMomRQRd1lVP6PijZ8uWFYe6xT4fMcLPyHj4I
 taSZYyc2KzQyzc052fLXampeDHye0CzmpK8+IPSmJgvjFO7b3GW99g3L1cKjy5ZSj8oK8c381of
 Nw/9/teu+MI9D0pIjDfJsS04vjYCOS2t9QL6iNbzYI8zd3C0QNsS3u9Nsxx80UmeHQnPQMn6VqJ
 vYzMtnOHVEbjS6yRSIi/MxWNqOePORBsKKIc9JqqgkNv8dshcItOxjj3cEf6Bbubbz3x+y2/mG8
 +loPQCJQiQJk4ZvsMymXdiL/V0LsPJunSx2LZX1413hpYV1fhFR9oTL+9uZtsLmjwukn5bAttxD
 FXVgZZjoJvrVzFwAdIR3CnZRcjuaYxv0064zNrBd
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr244134215e9.10.1795450878450; 
 Mon, 23 Nov 2026 08:21:18 -0800 (PST)
Received: from [10.56.169.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm18863696f8f.35.2026.11.23.08.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:21:17 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Mon, 23 Nov 2026 17:20:28 +0100
Subject: [PATCH RESEND 3/4] drm/vkms: add a KUnit test for the precomputed
 LUT table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-lut-v1-3-5556c89a2ebd@gmail.com>
References: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
In-Reply-To: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Arthur Grillo <arthurgrillo@riseup.net>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

build_lut_table() turns a per-pixel interpolation into a table lookup, so
a wrong entry changes the composed output with no other symptom.

Compare every entry against apply_lut_to_channel_value() for the same
channel and value, for a 4-entry LUT whose channels differ and for the
256-entry sRGB one. The check stops at the first mismatch and prints its
channel, value and both results.

The tables are built with apply_lut_to_channel_value(), so this proves the
lookup matches the interpolation, not that the LUT arithmetic is right;
vkms_color_srgb_inv_srgb() covers the latter.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 1a1c7cac2f15..cdbb74d16b5e 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
@@ -88,6 +88,21 @@ static const struct vkms_color_lut test_linear_lut = {
 	.channel_value2index_ratio = 0xf000fll
 };
 
+/* Channels differ, so a table built with the wrong channel does not match. */
+static struct drm_color_lut test_distinct_array[] = {
+	{ 0x0000, 0x0000, 0x0000, 0 },
+	{ 0x1000, 0x6000, 0xb000, 0 },
+	{ 0x2000, 0x4000, 0x9000, 0 },
+	{ 0xffff, 0xffff, 0xffff, 0 },
+};
+
+static const struct vkms_color_lut test_distinct_lut = {
+	.base = test_distinct_array,
+	.lut_length = ARRAY_SIZE(test_distinct_array),
+	/* drm_fixp_div(drm_int2fixp(lut_length - 1), drm_int2fixp(0xffff)) */
+	.channel_value2index_ratio = 0x30003ll
+};
+
 static void vkms_color_test_get_lut_index(struct kunit *test)
 {
 	s64 lut_index;
@@ -393,6 +408,44 @@ static void vkms_color_ctm_3x4_bt709(struct kunit *test)
 	KUNIT_EXPECT_LT(test, out.b, 0x100);
 }
 
+static void vkms_color_test_check_lut_table(struct kunit *test,
+					    const struct vkms_color_lut *lut,
+					    const u16 *table)
+{
+	int i;
+
+	for (i = 0; i < LUT_RESERVED * LUT_TABLE_ENTRIES; i++) {
+		enum lut_channel channel = i / LUT_TABLE_ENTRIES;
+		u16 value = i % LUT_TABLE_ENTRIES;
+		u16 expected = apply_lut_to_channel_value(lut, value, channel);
+
+		if (table[i] != expected) {
+			KUNIT_FAIL(test, "channel %d, value %#06x: 0x%04x != 0x%04x",
+				   channel, value, table[i], expected);
+			return;
+		}
+	}
+}
+
+static void vkms_color_test_build_lut_table(struct kunit *test)
+{
+	const struct vkms_color_lut *luts[] = {
+		&test_distinct_lut,
+		&srgb_eotf,
+	};
+	u16 *table;
+	int l;
+
+	table = kunit_kzalloc(test, LUT_RESERVED * LUT_TABLE_ENTRIES * sizeof(*table),
+			      GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, table);
+
+	for (l = 0; l < ARRAY_SIZE(luts); l++) {
+		build_lut_table(luts[l], table);
+		vkms_color_test_check_lut_table(test, luts[l], table);
+	}
+}
+
 static struct kunit_case vkms_color_test_cases[] = {
 	KUNIT_CASE(vkms_color_test_get_lut_index),
 	KUNIT_CASE(vkms_color_test_lerp),
@@ -400,6 +453,7 @@ static struct kunit_case vkms_color_test_cases[] = {
 	KUNIT_CASE(vkms_color_srgb_inv_srgb),
 	KUNIT_CASE(vkms_color_ctm_3x4_50_desat),
 	KUNIT_CASE(vkms_color_ctm_3x4_bt709),
+	KUNIT_CASE(vkms_color_test_build_lut_table),
 	{}
 };
 

-- 
2.56.1

