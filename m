Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95159C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1C110E8D6;
	Mon, 28 Sep 2026 08:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="2ElVj65/";
	dkim-atps=neutral
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A8510E00B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:04:55 +0000 (UTC)
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.112.40.71])
 by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 5D2BA121119;
 Sun, 27 Sep 2026 21:54:48 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
 s=dkim2026; t=1790556889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Nqfzy3UswsFhdkL7rmqN73lRrtY1OlqfEodXP85Wkk=;
 b=2ElVj65/G3GHfz8f/rdQdKVa75X5ZDmOGkbbI1sIJ7d/CNeu5awYBJKujtzhCUoyeMWiyd
 KGYb3e/0aaEr/cb+Kc3gxu2YqkROm6kUNN9T2HpZejWStUNJIftwQV/OmhSjUEIBoCv7AF
 oyAYsy7zTj9TTxTTTgXU98KLVNx9oSSeBXkYWiV+pHdbQ5dnd4jLJKNNsWMD/nnPaV9t/M
 PC58Vl0YnP23uCvSMai88xtWqk84IacJ4mO3HQc8gbYeyvc/+K75w1KvOswI2EHQnNXNou
 Zl5+DE1fF+4ZvURB0lA5FcynlbHi74G+oewFBWqfUMC+v2n76dZbcRelND7Ezg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 1/5] drm/vkms: make argb_u16_to_RGB565 round resulting values
Date: Sun, 27 Sep 2026 21:52:57 -0300
Message-ID: <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:45 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Currently, argb_u16_to_RGB565() truncates the resulting channel values.
Use drm_fixp2int_round() to round them to the nearest representable
RGB565 values.

Restore the rounding behavior from commit
ab87f558dcfb ("drm/vkms: Fix RGB565 pixel conversion") while adding a
separate helper for channel conversion.

Fixes: cc4fd2934d41 ("drm/vkms: Isolate writeback pixel conversion functions")
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 35 ++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index dfb8e13cb..6d7853e87 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -639,20 +639,35 @@ static void argb_u16_to_XRGB16161616(u8 *out_pixel, const struct pixel_argb_u16
 	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+static u16 u16_to_channel(int size, u16 in)
 {
-	__le16 *pixel = (__le16 *)out_pixel;
+	s64 fp_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp((1 << size) - 1));
+	s64 fp_channel = drm_int2fixp(in);
 
-	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
-	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
+	return drm_fixp2int_round(drm_fixp_div(fp_channel, fp_ratio));
+}
+
+static void argb_u16_to_channels(u16 *out_r, u16 *out_g, u16 *out_b, u16 *out_a,
+				 unsigned int r_size, unsigned int g_size,
+				 unsigned int b_size, unsigned int a_size,
+				 const struct pixel_argb_u16 *in_pixel)
+{
+	if (r_size)
+		*out_r = u16_to_channel(r_size, in_pixel->r);
+	if (g_size)
+		*out_g = u16_to_channel(g_size, in_pixel->g);
+	if (b_size)
+		*out_b = u16_to_channel(b_size, in_pixel->b);
+	if (a_size)
+		*out_a = u16_to_channel(a_size, in_pixel->a);
+}
 
-	s64 fp_r = drm_int2fixp(in_pixel->r);
-	s64 fp_g = drm_int2fixp(in_pixel->g);
-	s64 fp_b = drm_int2fixp(in_pixel->b);
+static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+{
+	__le16 *pixel = (__le16 *)out_pixel;
+	u16 r, g, b;
 
-	u16 r = drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
-	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
-	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
+	argb_u16_to_channels(&r, &g, &b, NULL, 5, 6, 5, 0, in_pixel);
 
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
-- 
2.43.0

