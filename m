Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F4606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKqXs/iP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3605710F586;
	Tue, 17 Nov 2026 01:22:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A391810F586
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:21:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BCE34642A;
 Tue, 17 Nov 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794878498;
 b=TY22tHijk8v67X4KeN0k912oWR0kVPUEW5FeGKqt1HBYAzD/akkmXkzn90rkbAJ/VIzd
 IXgtiyOWhu1wU1sn5/YsuYmjARpK13H5he/F1bJbZ0Ya6eJNG70VVEY1Gn/2oGGc7LUdN
 0P9GbP/DYfVG1HbAKxqXI5pRtZ44xolYzzCWQ6rz1IjL68AbcyktfFNZMPTqlO/7ozK+n
 wcCdgRs+FwiHaqgnYJCcoYcoSI+D5ZpN1SXzQEWTmzb03TCtjYBp5xH4JaTR0oTcLTeqT
 +3PMXXjVHaK1EZAM7IK10W/Tn2vj7bQtYaYFcbnZj/JAi7A7AHqZDZlsYFi9pp3Snsg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794878498;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=A4rcYGnRkuvRii1ymoou6n7+CAz2Ckdj72mitbXpH4Y=;
 b=tWa9zA6fjte5NoSn/sws5KXHlEPqKbcX7kBZO+Dv5COjQUPBPU54IwBkGtR7RL5t+uzJ
 wxjnIEBjGdPKAbMau012ducogcQacgFb0ExvKuTOOAuNNxx5CO4F8na5mqLCuPgTj2qfu
 t/6gP3jsguvHvMyp/R/4bKw1pVD/TpxKfNt3C01NviqJhq1nP1rzIvW4UXIlC7OZx7UVb
 JiN6DJ+a15WpNRqMpc0kFPUxTR8YyDQ3gdeAJACArs7PI/4Uj3jOT5KQXVefPgjT1XWV0
 QvNiDN+KRn941rrHdn2BKOUgIVWDl6/MoGJp3PTKG2SpgSxxM1E8OhkkQSqIvXSZRSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C88B01F000CC;
 Tue, 17 Nov 2026 01:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794878498;
 bh=A4rcYGnRkuvRii1ymoou6n7+CAz2Ckdj72mitbXpH4Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=hKqXs/iPSPKQceZWc8s0kYs39aLu7/4YVUy+RFmApD1BIPYcN4Bobo0hidFTZafRx
 f/tfiw6a5i5SaO6LDk9YFca2C8Kb+w9tnjyIZh4yPgnhDznwnuYL8REoolmy4YpYV1
 XLKaDjEUubTjogkcnGcxhJbXlrIO2c41Mi07XfOgQwBHJkM3TGqhslTN1qczt7ib9F
 uda05glaMeIwVa0VIJ9fjrHhf/1cTcyAhwoYLMQ/jCPoyHtl8aAtUlL3L4Ykzupe0A
 SrPndP4lZiDi+NevXF+QgCY1F9oOmisvW+4Sh21TC8k1K4rwWaDyEBatfpQfaVmzmj
 Tf0dDGyHSB8dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7C3C84A676;
 Tue, 17 Nov 2026 01:21:36 +0000 (UTC)
From: Sidharth Saha via B4 Relay <devnull+ssaha2000.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 18:21:36 -0700
Subject: [PATCH 5/5] drm/vkms: Add KUnit tests for RGB565 and BGR565 read
 conversion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-rgb565-test-v1-5-27f49c1aa694@gmail.com>
References: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
In-Reply-To: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794878495; l=5464;
 i=ssaha2000@gmail.com; s=20261116; h=from:subject:message-id;
 bh=nLg0GXM40ZvS+lymhOWLgN3H/hzyxZ7QxDXgGA4ujHc=;
 b=/4S5BZwIsgS2oSg3ck2MdmiOR19T3JEAqT6p98NwjsAoq/vW/48NOWTQ93chkoGl4w55apn7U
 5/ZsOnFykvABnbTvFN3iALHhV3e8Zf0KbFJbTcFHrDjhAoxy0bPQyPg
X-Developer-Key: i=ssaha2000@gmail.com; a=ed25519;
 pk=wMWW9xOklVZkO7Yh4yIXvhVVRs/3ROsqgjTt8XBGybI=
X-Endpoint-Received: by B4 Relay for ssaha2000@gmail.com/20261116 with
 auth_id=1541
X-Original-From: Sidharth Saha <ssaha2000@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: ssaha2000@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sidharth Saha <ssaha2000@gmail.com>

argb_u16_from_RGB565() and argb_u16_from_BGR565() were converted to the
new channels_to_argb_u16() helper. Test them against hand-computed
values; the tests pass both before and after that conversion, showing
it didn't change behavior.

Make both functions visible to KUnit so the tests can call them.

Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 51 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c           |  6 ++--
 drivers/gpu/drm/vkms/vkms_formats.h           |  2 ++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index 0683a74fc623..841f2c840ed8 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -411,6 +411,54 @@ static void vkms_format_test_argb_u16_to_BGR233(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, out, c->bgr233);
 }
 
+struct u16_565_read_case {
+	const char *name;
+	u16 rgb565, bgr565;	/* the same color packed both ways */
+	u16 r, g, b;
+};
+
+static struct u16_565_read_case u16_565_read_cases[] = {
+	{ "zero",       0x0000, 0x0000,     0,     0,     0 },
+	{ "max",        0xffff, 0xffff, 65535, 65535, 65535 },
+	{ "red-only",   0xf800, 0x001f, 65535,     0,     0 },
+	{ "green-only", 0x07e0, 0x07e0,     0, 65535,     0 },
+	{ "blue-only",  0x001f, 0xf800,     0,     0, 65535 },
+	{ "low",        0x0821, 0x0821,  2114,  1040,  2114 },	/* 1,1,1 */
+	{ "mid",        0x8410, 0x8410, 33825, 33288, 33825 },	/* 16,32,16 */
+	{ "distinct",   0xfc00, 0x041f, 65535, 33288,     0 },	/* 31,32,0 */
+};
+
+static void vkms_format_test_u16_565_read_case_desc(struct u16_565_read_case *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", t->name);
+}
+
+KUNIT_ARRAY_PARAM(u16_565_read, u16_565_read_cases, vkms_format_test_u16_565_read_case_desc);
+
+static void vkms_format_test_argb_u16_from_RGB565(struct kunit *test)
+{
+	const struct u16_565_read_case *c = test->param_value;
+	__le16 px = cpu_to_le16(c->rgb565);
+	struct pixel_argb_u16 out = argb_u16_from_RGB565(&px);
+
+	KUNIT_EXPECT_EQ(test, out.r, c->r);
+	KUNIT_EXPECT_EQ(test, out.g, c->g);
+	KUNIT_EXPECT_EQ(test, out.b, c->b);
+	KUNIT_EXPECT_EQ(test, out.a, 0xffff);
+}
+
+static void vkms_format_test_argb_u16_from_BGR565(struct kunit *test)
+{
+	const struct u16_565_read_case *c = test->param_value;
+	__le16 px = cpu_to_le16(c->bgr565);
+	struct pixel_argb_u16 out = argb_u16_from_BGR565(&px);
+
+	KUNIT_EXPECT_EQ(test, out.r, c->r);
+	KUNIT_EXPECT_EQ(test, out.g, c->g);
+	KUNIT_EXPECT_EQ(test, out.b, c->b);
+	KUNIT_EXPECT_EQ(test, out.a, 0xffff);
+}
+
 static struct kunit_case vkms_format_test_cases[] = {
 	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_RGB565, rgb565_gen_params),
@@ -419,6 +467,9 @@ static struct kunit_case vkms_format_test_cases[] = {
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_from_BGR233, u8_read_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_RGB332, u8_write_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_BGR233, u8_write_gen_params),
+	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_from_RGB565, u16_565_read_gen_params),
+	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_from_BGR565, u16_565_read_gen_params),
+	{}
 };
 
 static struct kunit_suite vkms_format_test_suite = {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index a5d04f922a94..95456ac9d003 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -251,21 +251,23 @@ static struct pixel_argb_u16 channels_to_argb_u16(u16 in_r, u16 in_g, u16 in_b,
 	return out_pixel;
 }
 
-static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
+VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
 {
 	u16 rgb_565 = le16_to_cpu(*pixel);
 
 	return channels_to_argb_u16((rgb_565 >> 11) & 0x1f, (rgb_565 >> 5) & 0x3f,
 				    rgb_565 & 0x1f, 0xffff, 5, 6, 5, 0);
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_RGB565);
 
-static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
+VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
 {
 	u16 bgr_565 = le16_to_cpu(*pixel);
 
 	return channels_to_argb_u16(bgr_565 & 0x1f, (bgr_565 >> 5) & 0x3f,
 				    (bgr_565 >> 11) & 0x1f, 0xffff, 5, 6, 5, 0);
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_BGR565);
 
 VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_RGB332(u8 pixel)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index 8565b2ca86c3..d7a42771fd4c 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -24,6 +24,8 @@ struct pixel_argb_u16 argb_u16_from_RGB332(u8 pixel);
 struct pixel_argb_u16 argb_u16_from_BGR233(u8 pixel);
 void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
 void argb_u16_to_BGR233(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
+struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel);
+struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel);
 #endif
 
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.53.0


