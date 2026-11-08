Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02E606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKe140Od
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9BB10E831;
	Sun,  8 Nov 2026 19:33:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D23B10E831
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:33:37 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so1520395e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166415; x=1794771215; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gA1PeZUXcKToREHFxU8m4mbzxqXNLHeYj9MYxhwCIdI=;
 b=LKe140OdmUcHmY6fIrgeOnXuvjP0+x16DAU68fJW0wWpbSvn4yq9JAHrQLUCwxW2K2
 EegP32MgTVdqCYfuKOMXkcs0ZuXcMfr9XX0YJl1Awc7wSRZRTCSJdC1wbHvKTJx/NRf8
 WNjVe24EAfxhFgVXMPizCqn0u9evc+pdD7rUn6WrJ82mxbiyNad1gGD0nbQyfeSNtftC
 D6W9XwKzVBqDN+LsbWneBa/0WaNJnFQ6eVp3V9WXBL5/Hn1ajEEE2Z5WCdSxNES3D2C5
 YeOZZRq0Tm/ewsCT71OlAjaKuYyADbyv5+GQjVezDyhKbGpqiOBpAHFJFZRqt2csEq0a
 JkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166415; x=1794771215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gA1PeZUXcKToREHFxU8m4mbzxqXNLHeYj9MYxhwCIdI=;
 b=cFjarmaNBrCQSAyKY3VGblqR9Gw7lnccZSF78fElu3SXQ+isvYxn8K/ScdXtEVB4sd
 PfWejH99arMKkCflakW7St6A75gPtvAelcLWhuXTpNX9eu9NSIj8mP65hSPnB0DB6zGs
 JThYlRTYjm/SUhBahMvRvHoOyM9WCULSW2dKYiaL4OZpmCXtGBWX3KVdEBlCN+8VbXBR
 OOh7Ul3igCEJK0iDK0Lm3eZTqDCe+ez83aA+mbd3c9LRxTvgL9p/lGTYIDqKNgaFmzOq
 pIDJTcU4gVN1+XpvLXu+qoburVr6zbOm9aUKqZBBjny7Wi3FjwxHBA3ZNQdUDeZaCahE
 Mi0A==
X-Gm-Message-State: APuU4Z9thxAalxgPFofgRLXCuO83jVur3a3n4rHcIiZSuILdv023l9mM
 3lE6Mi4FGJghsI2wKWAcBxYJAvzhYD5g7cxZNgIU1AQOJWg7K4Mb0sxA
X-Gm-Gg: AYBFou0aauukh0w6RhXTiDuryWX1xOhzhG0alf/onZO39GccgQJC7Bc94WSV//haI+W
 EyOzsN2JGNbUExKppMFPIXzH7v91pc2u217OW2xJn4U+RH7qKxF+bY4g6leyw1aQsSItcEMkTAv
 x42flB7GXTPmMlrrNgbB6/LLCFjc0/Xv1Nuv5SGUzQhoXn84Apa7AcJLkAAX/W5MF2BhHOVtzPs
 X29UX6ax6uQxUlHUGFOnP7XJZqmcBR0DfWXUBGVbeCfGH8swsGDb5Lj3wh9fCxov5ARda87TptK
 cplozDz63vJimT2+hfgyDlBvEQnAElT2q2oowQ94yS8yl1inNIJrR66lpnrKH1QATHwg+ECeAFY
 ZORT9MMDtu2w1+jyjONaVBWVAqxbNCnK3t407A1y3XHFoUSJKcy1Ia8sn3vtBN5I62sTnqyq+1f
 G9KKMU0fGdjUozcWX7dZEScHpwbOFI8VVlSVyR3+CFRG8iEskJgpR6+knsl9sGlaFFmYr4I0j+Q
 k83999YPhoV5XeMKwTxm9rh/d8vg36rVjeS5lLxIaj3ChoCzs55M/RaSOdW+uuNzNIHd05uykzt
 I8POrQ3YKBHvu3lD7T7HQFp26YUczxyydooS/vqulA==
X-Received: by 2002:a05:600c:1d18:b0:4a6:42cc:bf6c with SMTP id
 5b1f17b1804b1-4b960d9bb75mr43471715e9.7.1794166415480; 
 Sun, 08 Nov 2026 11:33:35 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbfa121sm105422115e9.1.2026.11.08.11.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:33:34 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Sun, 08 Nov 2026 19:33:11 +0000
Subject: [PATCH 3/4] drm/vkms: add a KUnit test for the precomputed LUT table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-lut-v1-3-f762d70ae4cd@gmail.com>
References: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
In-Reply-To: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
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
2.55.0

