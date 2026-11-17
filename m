Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckxI6ifW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D223510F583;
	Tue, 17 Nov 2026 01:21:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C23C10F583
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:21:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 249044633D;
 Tue, 17 Nov 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794878498;
 b=GmbCFuhu7udzcAjokbKsJVljYeYSQEOGv3rIfQIgwqvqFu2BDpZvhtv78axsbPCgoc10
 /nFUK2ibd3YYUKycRWUKF+EcHDVFgaXure7oc6zDYOxuQByejKB3XrvneiMJQaMtqnc9t
 3pBaWCJ1j1wKeHANqS1xp+mx+jjrDk11mCckhopsH9hE/kWiyKPtHA+pIZTYIFl5Kkbw3
 M6xYQQiQStGPhZFBAriyaLav6SoNUmFgKqb7vL/LqaS6RjNwpBbP1hq4bYMATanG9hgh0
 V5XAmh3+5vhNuEzKvn/TxRHQaqXBNcP2f9fMBDh1VOW0z4XZJ/5T225VbsQEimxkXUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794878498;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=MOJyHYocdDLJcARQVx7190cWEwg2aBstuqciBYpZQCM=;
 b=zKKx4sHjFe1Onz4LVc7vImTCutwNy6NUx3P2LuvFeqGXUIwZ1KeBfctwKcYYTfuue+Rq
 8Q1Bq3KEdfqPPqrnNUXtRDoLoapMhEmgrywvG1iDSMUg0xQhk9mf0QhKxcgCzp7yDZQJG
 CiKDJa2eF7cG5JDIF0i9PO+Um14VwQtkejXNHcspJGHe7TvSNd55ipA2D5NbemEjvUbzG
 XfzzU3Lx2U/2g6QEJyY2I3Zzn/pUcOtY0pF/PSNn1xy12im7zKLnjODbK/AkzkXHH/nG2
 KUO32ceXcy0LU/vQqI81g+nsFeHwzLmCHsz2y1amH18E1ZnoVmHPdjxJiLKtw+ybnQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D98B61F000C8;
 Tue, 17 Nov 2026 01:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794878498;
 bh=MOJyHYocdDLJcARQVx7190cWEwg2aBstuqciBYpZQCM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ckxI6ifW7a8bWN0PQUzV/oZMwjzzglhWoLmn+EoBZrl+fQb57/LgtkrHxG55j7m40
 +jt2bFBrgGZeCAq7w0e77CiNzNxd0/Y3le1hK4T9GWj4ayj1T8/v1vAcYTV5fcWp+w
 1qbyUXEKI5tq9ZrAiIk1SwAqQ1sMrojwI+1UVljN10wwKE3BUPBf3qdV2nkyDlcuMx
 llw+vkw6FoBcaCMMDvhyM2NWmM5O7hbVPYrw2e8+sqmFSppwZPSEMut9lp3WC5XYNR
 CUHJFYL5y71wmrFpKqcy+ejX6+ZqjUdInbe0yWDQF60eIk3qN/6tcU1LnR94GcpPbI
 c4dc8GchhpkQw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 648E04A672;
 Tue, 17 Nov 2026 01:21:36 +0000 (UTC)
From: Sidharth Saha via B4 Relay <devnull+ssaha2000.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 18:21:35 -0700
Subject: [PATCH 4/5] drm/vkms: Add KUnit tests for RGB332 and BGR233
 writeback conversion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-rgb565-test-v1-4-27f49c1aa694@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794878495; l=5670;
 i=ssaha2000@gmail.com; s=20261116; h=from:subject:message-id;
 bh=oW4NiG0eUzOhqiT+/BQfyXE5E+eIC3toSjVSzeY/eCo=;
 b=RK0IngExzcr8M//doPxpyJvbO4fUF53CkhTxK64aVCkPXFPn0MiOEoeT3Nj/rhgFig6kgh2hO
 MmtD/Tl8u/tBMj4/Vcdr/+DswtzX1f5C62madO2EqhwdWIZjYPJhV7h
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

Test argb_u16_to_RGB332() and argb_u16_to_BGR233(), which reduce 16-bit
channels to 3/3/2 bits. Cases cover the 0x8000 midpoint, inputs on
either side of the first rounding step for both 3- and 2-bit channels,
and a round trip using values produced by the read conversion.

Make both functions visible to KUnit so the tests can call them.

Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 51 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c           |  6 ++--
 drivers/gpu/drm/vkms/vkms_formats.h           |  2 ++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index ab95d6c3d2d5..0683a74fc623 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -362,12 +362,63 @@ static void vkms_format_test_argb_u16_from_BGR233(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, out.a, 0xffff);
 }
 
+struct u8_write_case {
+	const char *name;
+	struct pixel_argb_u16 in;
+	u8 rgb332, bgr233;	/* expected output, packed both ways */
+};
+
+static struct u8_write_case u8_write_cases[] = {
+	{ "zero",       { .a = 0xffff, .r = 0,      .g = 0,      .b = 0      }, 0x00, 0x00 },
+	{ "max",        { .a = 0xffff, .r = 0xffff, .g = 0xffff, .b = 0xffff }, 0xff, 0xff },
+	{ "red-only",   { .a = 0xffff, .r = 0xffff, .g = 0,      .b = 0      }, 0xe0, 0x07 },
+	{ "green-only", { .a = 0xffff, .r = 0,      .g = 0xffff, .b = 0      }, 0x1c, 0x38 },
+	{ "blue-only",  { .a = 0xffff, .r = 0,      .g = 0,      .b = 0xffff }, 0x03, 0xc0 },
+	/* r=4, g=4, b=2 */
+	{ "midpoint",   { .a = 0xffff, .r = 0x8000, .g = 0x8000, .b = 0x8000 }, 0x92, 0xa4 },
+	/* r=1, g=0, b=0 */
+	{ "steps-1",    { .a = 0xffff, .r = 4682,   .g = 4681,   .b = 10922  }, 0x20, 0x01 },
+	/* r=0, g=1, b=1 */
+	{ "steps-2",    { .a = 0xffff, .r = 4681,   .g = 4682,   .b = 10923  }, 0x05, 0x48 },
+	/* r=4, g=5, b=2 */
+	{ "round-trip", { .a = 0xffff, .r = 37449,  .g = 46811,  .b = 43690  }, 0x96, 0xac },
+	/* r=7, g=4, b=0 */
+	{ "distinct",   { .a = 0xffff, .r = 0xffff, .g = 0x8000, .b = 0      }, 0xf0, 0x27 },
+};
+
+static void vkms_format_test_u8_write_case_desc(struct u8_write_case *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", t->name);
+}
+
+KUNIT_ARRAY_PARAM(u8_write, u8_write_cases, vkms_format_test_u8_write_case_desc);
+
+static void vkms_format_test_argb_u16_to_RGB332(struct kunit *test)
+{
+	const struct u8_write_case *c = test->param_value;
+	u8 out;
+
+	argb_u16_to_RGB332(&out, &c->in);
+	KUNIT_EXPECT_EQ(test, out, c->rgb332);
+}
+
+static void vkms_format_test_argb_u16_to_BGR233(struct kunit *test)
+{
+	const struct u8_write_case *c = test->param_value;
+	u8 out;
+
+	argb_u16_to_BGR233(&out, &c->in);
+	KUNIT_EXPECT_EQ(test, out, c->bgr233);
+}
+
 static struct kunit_case vkms_format_test_cases[] = {
 	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_RGB565, rgb565_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_BGR565, rgb565_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_from_RGB332, u8_read_gen_params),
 	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_from_BGR233, u8_read_gen_params),
+	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_RGB332, u8_write_gen_params),
+	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_BGR233, u8_write_gen_params),
 };
 
 static struct kunit_suite vkms_format_test_suite = {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index eccca25f51d4..a5d04f922a94 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -709,7 +709,7 @@ VISIBLE_IF_KUNIT void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_
 }
 EXPORT_SYMBOL_IF_KUNIT(argb_u16_to_BGR565);
 
-static void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+VISIBLE_IF_KUNIT void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	u16 r, g, b;
 
@@ -717,8 +717,9 @@ static void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 
 	*out_pixel = r << 5 | g << 2 | b;
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_to_RGB332);
 
-static void argb_u16_to_BGR233(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+VISIBLE_IF_KUNIT void argb_u16_to_BGR233(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	u16 r, g, b;
 
@@ -726,6 +727,7 @@ static void argb_u16_to_BGR233(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 
 	*out_pixel = b << 6 | g << 3 | r;
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_to_BGR233);
 
 /**
  * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index 90006325a87e..8565b2ca86c3 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -22,6 +22,8 @@ void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
 void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
 struct pixel_argb_u16 argb_u16_from_RGB332(u8 pixel);
 struct pixel_argb_u16 argb_u16_from_BGR233(u8 pixel);
+void argb_u16_to_RGB332(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
+void argb_u16_to_BGR233(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
 #endif
 
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.53.0


