Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F73C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0361710F17D;
	Wed, 23 Sep 2026 20:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VdOzPb/l";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A210810F173
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:10:55 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so6611285e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194254; x=1790799054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KzWnvXvBcRYh23VzcFk9fIrKKbovPKtd+dDK4CYg1CA=;
 b=VdOzPb/lI0FMfK1eAHm7UnaySJ1selqG6j5W+oEcylE86S3Gp1eXRJWd4n22ypIpUe
 TE8oEVYiKQj2kl7vISG+TcdIXunzTrWiobrHhN1dL5nJLnL09RbhLTgaqyhq4z1zChGL
 3eqtIP1HwkyB/euIql6eu0ktgMOhVaA6YMUqG8ddP1YNxPZs7ikp+anS6Epq83lMLUBP
 Pkm/2jxcZoplBWmnixzlxHCX9FbTUE2HLNcTAOxdRals7IyahEk1IXUSqrg/I445IDiR
 ExU2MHXhhm9aNdFHKh5Lu0Ql4vostVLWNbyHNmtYKLpWRmkXNB4Gj6+lJKL4ZS6qBVq1
 f19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194254; x=1790799054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KzWnvXvBcRYh23VzcFk9fIrKKbovPKtd+dDK4CYg1CA=;
 b=L3ST5wLpUddGGpWTZcgwkyyHG5BN3elQXeNLhl+AL4cL59NCoHHpCwFChVHuxtoOFY
 HtkLNv165KZm6Y+bttTH/NMGgLC/prXRBkg2Zp2Kr11T3TZpqJVdacmvmEBRPz/+uIS6
 lLcPZFN3fiR8fSXsRn6uqANQZIWk0SzKf9td/JFnUUgz9BAKf7QjIqIKEKfCJmHUPxQc
 dqup87skkDqd58Stn2exuHWmBbTMhvJrLUBITzULXLaGxOLL+fjTaqHd/uMrYU+kKTZq
 64IvTQGkt40K9EjwByo2vYw3buXIw/9KkbnS7P6iYiFLPEpafXfo1A3fgNDoIf3tfQkT
 wIyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCLMiNFxe1o35oNfV9iTbRJwcl1SYHvlk4MXjGrX/JS3R3WyBFGTJHy665PYkxZE6+FEpx1fltnlg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nC+MRi39qdJ6MXkf42vO+RMm8vOJL8tlnHYg1hiWE5l1KSe38b
 mSwjmDXHH74DbFMjJ++Ape4XLECu7tm6i/5KIFgxBlHcm73a52+W1sMB
X-Gm-Gg: AYBFou00Avnsl63/0loYxTvnp769WBEf/goEXoCYRjz7MvUy1m5WkhPXwNy3ZDpt78+
 FqHlrpDiCxPjPTjBp9N3KWhIwKQUqJyq8JO0UNQDuBKmffRawZTvv+NK7Mw0hNaMm5k0fHhirRJ
 Wi9b/gfT1TU4GIUmZxqWC0BatkZBwV7bGo4hCZDD2KAD9YEYvEE+jkZyvuWUKzv0EHa3rOVlQ64
 9ck4Cg1hGGKUUtj036/HAWuMvnmu45uuNU0FTyaCOIvlegOyJ4KYgWh0QNBHqOm9lcLaCY9IvK2
 I3nWuS/A5Tm4HM4ypfOROOWtg6wAo7z8/SWCMe8D3ABeLwXrvKd/AWTX6WzEY9YxL12+vgOXgxA
 rOgF90Z70O8JEIXsEJ2TWPvYnIJXbqjtsAPHACzyQKRo2yR6NcO0MpnTqnk32fvY3BPzZaTj2YO
 cLw9liFD9kgXoC1NzW4PNVWhfPUdLKIfio4iLOa57q5ajV+d8KBUAzLJGGhX/jlZivO7/0cKeRI
 na2rwHOhNTM6EWIpgM3SHrWGcBPJy/mKnI=
X-Received: by 2002:a05:600c:4705:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-49fe66d03b6mr4620805e9.5.1790194253946; 
 Wed, 23 Sep 2026 13:10:53 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:10:53 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 1/7] fbdev: describe where the boot logo goes in one place
Date: Wed, 23 Sep 2026 22:10:29 +0200
Message-Id: <20260923201035.51007-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

fb_prepare_logo() works out how many rows to keep clear for the logo and
fb_show_logo_line() works out where to draw it, and both of them open code
the same decision: centred if fb_center_logo, top left otherwise. The two
calculations have to agree, because fbcon erases whatever falls outside the
rows that were reserved, and nothing makes them.

Give the position a small structure of its own, with -1 on an axis meaning
centre on that axis, and have both callers ask for it. fb_center_logo
becomes {-1, -1} rather than a second path, and the arithmetic lives in one
function that both use, so they cannot end up disagreeing.

The structure and logo_place_axis() go in linux_logo.h rather than in the
frame buffer code, since where a logo goes is a property of the logo, not
of the one thing that draws it today.

logo_place_axis() also clamps, which the open coded version did not: the
result is now always a position at which the logo lies entirely on screen.
That is not reachable today, since the only positions are the two the
console offers, but it stops being something the next caller has to
remember.

No functional change intended.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/fbdev/core/fb_logo.c | 58 +++++++++++++++++++-----------
 include/linux/linux_logo.h         | 29 +++++++++++++++
 2 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index 0bab8352b6..5ec9f9554f 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -8,6 +8,17 @@
 bool fb_center_logo __read_mostly;
 int fb_logo_count __read_mostly = -1;
 
+/*
+ * The placement in effect, as asked for on the console command line.
+ */
+static const struct logo_placement *fb_logo_placement(void)
+{
+	static const struct logo_placement centred = { .x = -1, .y = -1 };
+	static const struct logo_placement top_left = { };
+
+	return fb_center_logo ? &centred : &top_left;
+}
+
 static inline unsigned int safe_shift(unsigned int d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
@@ -281,7 +292,11 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
 	unsigned char *logo_new = NULL, *logo_rotate = NULL;
+	const struct logo_placement *p;
+	unsigned int xres = info->var.xres;
+	unsigned int yres = info->var.yres;
 	struct fb_image image;
+	unsigned int block;
 
 	/* Return if the frame buffer is not mapped or suspended */
 	if (logo == NULL || info->state != FBINFO_STATE_RUNNING ||
@@ -322,26 +337,22 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 		fb_set_logo(info, logo, logo_new, fb_logo.depth);
 	}
 
-	if (fb_center_logo) {
-		int xres = info->var.xres;
-		int yres = info->var.yres;
+	image.width = logo->width;
+	image.height = logo->height;
 
-		if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW) {
-			xres = info->var.yres;
-			yres = info->var.xres;
-		}
+	if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW)
+		swap(xres, yres);
 
-		while (n && (n * (logo->width + 8) - 8 > xres))
-			--n;
-		image.dx = (xres - (n * (logo->width + 8) - 8)) / 2;
-		image.dy = y ?: (yres - logo->height) / 2;
-	} else {
-		image.dx = 0;
-		image.dy = y;
-	}
+	while (n && (n * (logo->width + 8) - 8 > xres))
+		--n;
 
-	image.width = logo->width;
-	image.height = logo->height;
+	/* The copies are drawn in a row, so they are centred as one block */
+	block = n ? n * (logo->width + 8) - 8 : logo->width;
+
+	p = fb_logo_placement();
+	image.dx = logo_place_axis(p->x, xres, block);
+	/* A stacked logo goes where the caller put it */
+	image.dy = y ? y : logo_place_axis(p->y, yres, image.height);
 
 	if (rotate) {
 		logo_rotate = kmalloc_array(logo->width, logo->height,
@@ -418,6 +429,7 @@ static int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
 int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
+	const struct logo_placement *p;
 	unsigned int yres;
 	int height;
 
@@ -480,9 +492,15 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 		}
 	}
 
-	height = fb_logo.logo->height;
-	if (fb_center_logo)
-		height += (yres - fb_logo.logo->height) / 2;
+	/*
+	 * fbcon only leaves the first @height rows of the screen alone, so a
+	 * logo placed further down would be drawn and then immediately
+	 * cleared. Ask the same placement fb_show_logo_line() will use, so
+	 * that the two cannot disagree.
+	 */
+	p = fb_logo_placement();
+	height = logo_place_axis(p->y, yres, fb_logo.logo->height) +
+		 fb_logo.logo->height;
 #ifdef CONFIG_FB_LOGO_EXTRA
 	height = fb_prepare_extra_logos(info, height, yres);
 #endif
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index 1e727a2cb4..b3b15d3800 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -13,6 +13,8 @@
  */
 
 #include <linux/init.h>
+#include <linux/minmax.h>
+#include <linux/types.h>
 
 
 #define LINUX_LOGO_MONO		1	/* monochrome black/white */
@@ -36,6 +38,33 @@ extern const struct linux_logo logo_linux_clut224;
 extern const struct linux_logo logo_spe_clut224;
 
 extern const struct linux_logo *fb_find_logo(int depth);
+
+/*
+ * Where a boot logo goes. A coordinate of -1 centres the logo on that axis.
+ * Whatever draws the logo describes its placement this way and computes it
+ * with logo_place_axis(), so that no two places can end up disagreeing about
+ * where the logo is.
+ */
+struct logo_placement {
+	s32 x, y;
+};
+
+/*
+ * Place a logo along one axis. @pos is the coordinate asked for, or -1 to
+ * centre on that axis. The result is clamped so that the logo always lies
+ * entirely within the screen: the drawing code does not clip, so asking for
+ * more than that would otherwise scribble past the end of the frame buffer.
+ */
+static inline int logo_place_axis(s32 pos, unsigned int span, unsigned int size)
+{
+	int last = (int)span - (int)size;
+
+	if (size > span)
+		return 0;
+
+	return pos == -1 ? last / 2 : clamp(pos, 0, last);
+}
+
 #ifdef CONFIG_FB_LOGO_EXTRA
 extern void fb_append_extra_logo(const struct linux_logo *logo,
 				 unsigned int n);
-- 
2.39.5

