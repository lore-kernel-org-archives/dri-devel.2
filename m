Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F0606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKt0Hj8r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCD010F57C;
	Tue, 17 Nov 2026 01:21:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319F810F588
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:21:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 023516110D;
 Tue, 17 Nov 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794878497;
 b=tUOBOR1GjFBim4j31TZOSLBH9NmTGZgnyaDxJg17r+GQVltgl16VIg7TDmCwtRFflAR/
 4OS0K5E9uzRNfLYKDVzKFClqt9DQivYJ8eTWR8alZ4ZTqI83pko3lemoWzjGMT8yeqiQK
 6gwVh9yVUPozrbflCQC5xofDZmsyTg6lpGZpg/o4oKinXTLybJFnbWzjYVvp9OHoRiimD
 RAAgNyYqMbUjJ2dRTXEMPqvFhJxyrRbNHR7KmG6JxnO5YHjCi58qBq5xk43sAllLhuGsc
 0+siF3TD5BernkXvq8VcyoPP2bQbJNTrF/blHX+RjXn27pCLX1DOmfYA2uIRHGuh8Cw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794878497;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+NEqIzO4lVYZKsrLNCtEbMrhik/O8EWaQEFpZTHO4Sw=;
 b=U2rzyhMaR8Bdt4dhoVtvJjK1zbbZtTcgjYJTdG4vZNIcpNk6OIc3t1SMtxNjYQppH1yZ
 Ji8rZAUMjiz+7jsQ+NJQxuNlCD66SOttZH3D3SkaKdHD1gcM6wR8KO5dGN31d7Cv4klYS
 fMAGOa1pjv9h6rDtXrWClERSNlfG8rB0HVyba0TXg3LW4NSXx8kvB5/Fu/ZBC7BsYAHgh
 sIuoggRzTUDFu//b+GTmG8Uv3PH2HCyUGg0ryUSdy6gpmBgLbci1KHLWVKLjco4iCov6k
 hMnM99p67mJeAbwG8xUPP5H4ytEsPLZEQ9Aa7y2xIH6qoOBxXHQyzSOLty0S4pVbYuw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9EED01F000C4;
 Tue, 17 Nov 2026 01:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794878497;
 bh=+NEqIzO4lVYZKsrLNCtEbMrhik/O8EWaQEFpZTHO4Sw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NKt0Hj8r0w5LG1pezooafXYLTK4Dah7cb8erDTbSAmvBldXA4Wjap2mFRpS0lY9QV
 NEaNPuXIHbH3XVRSs7x0t108IT2KtYhU7igkI7vFkyWMPyxxjUGG7a22eSXaDAV2yF
 utGErXQbiOvBzbjwBQhCYzXHOZ8OfaMg5hNgPFGnAHZS3NBe8WyOqHlH8gMPSZQxEr
 n4WiUelXshOJz8qN2Bb3tif1Wq0UW+5ClKr1DXuB1qKDDIgF6BBVoHJyQM32+yv3IS
 oipKCZJ4RodFW1zzDfMIbtvp7uFkwxrddbX79ddT27R1xirRq9dgpmUmCtKrxcFnGq
 aPZZp4OhKWOFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1AE554A65D;
 Tue, 17 Nov 2026 01:21:36 +0000 (UTC)
From: Sidharth Saha via B4 Relay <devnull+ssaha2000.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 18:21:32 -0700
Subject: [PATCH 1/5] drm/vkms: Add KUnit test for RGB565 writeback conversion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-rgb565-test-v1-1-27f49c1aa694@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794878495; l=4548;
 i=ssaha2000@gmail.com; s=20261116; h=from:subject:message-id;
 bh=O4oCx5AVv4hw3TWfDUOkN6pr1WzBeONVMnkcYKgeUH4=;
 b=MJ11pi2eRZ7b71iwFlTOwgt0+haFEbdRh4RXrvssD92e6jGdROeJFOqffEsjOT20mlsigyfxF
 9t28QHgWgDQCXjZurmMaxb+Spxo9euLS3gjmquIWDBR+bXIIzqjUXol
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

argb_u16_to_RGB565() reduces each 16-bit channel to 5 or 6 bits. Its
rounding was fixed in commit ab87f558dcfb ("drm/vkms: Fix RGB565 pixel
conversion"), lost again in commit cc4fd2934d41 ("drm/vkms: Isolate
writeback pixel conversion functions"), and restored by "drm/vkms: make
argb_u16_to_RGB565 round resulting values". Add a KUnit test so it can't
silently regress again.

The test checks hand-computed values for zero, maximum, the 0x8000
midpoint, inputs on either side of the first rounding step, and distinct
per-channel values to catch channel placement errors.

Make argb_u16_to_RGB565() visible to KUnit so the test can call it.

Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 38 ++++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_formats.c           |  3 ++-
 drivers/gpu/drm/vkms/vkms_formats.h           |  1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index bbb1ad18c99f..a8ef93b9c806 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -265,9 +265,45 @@ KUNIT_ARRAY_PARAM(yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_cases,
 		  vkms_format_test_yuv_u16_to_argb_u16_case_desc
 );
 
+struct rgb565_case {
+	const char *name;
+	struct pixel_argb_u16 in;
+	u16 r, g, b;		/* expected 5/6/5-bit outputs */
+};
+
+static struct rgb565_case rgb565_cases[] = {
+	{ "zero",       { .a = 0xffff, .r = 0,      .g = 0,      .b = 0      },  0,  0,  0 },
+	{ "max",        { .a = 0xffff, .r = 0xffff, .g = 0xffff, .b = 0xffff }, 31, 63, 31 },
+	{ "midpoint",   { .a = 0xffff, .r = 0x8000, .g = 0x8000, .b = 0x8000 }, 16, 32, 16 },
+	{ "below-step", { .a = 0xffff, .r = 1057,   .g = 0,      .b = 0      },  0,  0,  0 },
+	{ "above-step", { .a = 0xffff, .r = 1058,   .g = 0,      .b = 0      },  1,  0,  0 },
+	{ "distinct",   { .a = 0xffff, .r = 0xffff, .g = 0x8000, .b = 0      }, 31, 32,  0 },
+};
+
+static void vkms_format_test_rgb565_case_desc(struct rgb565_case *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", t->name);
+}
+
+KUNIT_ARRAY_PARAM(rgb565, rgb565_cases, vkms_format_test_rgb565_case_desc);
+
+static void vkms_format_test_argb_u16_to_RGB565(struct kunit *test)
+{
+	const struct rgb565_case *c = test->param_value;
+	__le16 out;
+	u16 v;
+
+	argb_u16_to_RGB565((u8 *)&out, &c->in);
+	v = le16_to_cpu(out);
+
+	KUNIT_EXPECT_EQ(test, (v >> 11) & 0x1f, c->r);
+	KUNIT_EXPECT_EQ(test, (v >> 5) & 0x3f, c->g);
+	KUNIT_EXPECT_EQ(test, v & 0x1f, c->b);
+}
+
 static struct kunit_case vkms_format_test_cases[] = {
 	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_gen_params),
-	{}
+	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_RGB565, rgb565_gen_params),
 };
 
 static struct kunit_suite vkms_format_test_suite = {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index b0078d6efb90..c5ee2d6a920f 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -685,7 +685,7 @@ static void argb_u16_to_channels(u16 *out_r, u16 *out_g, u16 *out_b, u16 *out_a,
 		*out_a = u16_to_channel(a_size, in_pixel->a);
 }
 
-static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+VISIBLE_IF_KUNIT void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 	u16 r, g, b;
@@ -694,6 +694,7 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_to_RGB565);
 
 static void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index d969cc669a5e..2b8a1c4a5d46 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -16,6 +16,7 @@ void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encod
 #if IS_ENABLED(CONFIG_KUNIT)
 struct pixel_argb_u16 argb_u16_from_yuv161616(const struct conversion_matrix *matrix,
 					      u16 y, u16 channel_1, u16 channel_2);
+void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
 #endif
 
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.53.0


