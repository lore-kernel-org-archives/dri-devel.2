Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A78C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3BC10F17B;
	Wed, 23 Sep 2026 20:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tMFRJAaS";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E7010F173
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:10:59 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso8858545e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194258; x=1790799058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OC847st04FyQ0eid/r6wSfnOUb+hyMcWCkXMSMi0LQk=;
 b=tMFRJAaSUGuqoitlSaSpJBJAzNG7rJg8RmSTsC2Hcrd/XD9gc1+iZfOIGTAbb5ZD0v
 r0jYBRm5bD/hRAPcW+BzwZZ+cQLDW5hWWpufCylb52cetGFs9uYiJeBDvKNwWZvFHDPv
 TEFqiJmRTVRpv/Tv16W0dAKACX3kgCPejjikhswUX/IvvmnjjXErZgTcKB1rK9TxsLu7
 zVwMWm5g8iSmHtwPJdWAvH3xn1/jWV66i+6ALIdimDrDERJ7PjNFmX8iXDXZj3ghJlEe
 817XX7qAMil0Vbxi5Vp9ReJF7nXYF/NPbPcTBQTzcdIRORRPNFeBN2o2FNjtc/Z9Al5U
 iP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194258; x=1790799058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OC847st04FyQ0eid/r6wSfnOUb+hyMcWCkXMSMi0LQk=;
 b=rQ0ncSbbwpA/WgdBZ1Poas67eDaBcX33cBIORSMUmjA9I3g1wrd7lZwstifCOQ27D1
 I7UBYeuKQBat/Qlgy2ErBqgaKOZQgOFQoTlg/xhXtLEBpsLJoNT0ZmY9Fhd3rK7RJUuI
 6rSYmU7t18OFhRmh8H01j15OiX7m/ESeNwhLE+ZJOEd0GtQSBkKoPZdunk1kyg1aon2Y
 TIvD+F9hR/dpasYn1iOfwJ+kJEVlLvgVzd2vICfEjXy5ZZ3Pyncha+BbKmec68JuBFho
 GHdC3T+ztoDI8sIfo7/WK5jgi2npTfDuUydwcXvcdEO/nwJxu6EgVckbTKmPaOkNPopZ
 jeag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnerZALnJgEycxIwJxAJ+gVPgCaO0JbjRlrJwHgvKjotZ7thTnf70ixIzGvS6FJLnHbo2uRUO63go=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAmerg5gdHaiF/FjGLJ7qHoLiCjYn/LgkUH7EVdf03VQeCXOWc
 cTpmwQiX2SaE88V+gGL0W7B/iJEjPx3jEh2mtiDE6FyIf3GAygmReoYX
X-Gm-Gg: AYBFou0D7vaPMl+bKGQYoRWu82own0qCFS2uKbaDfc1veuQRGuiXsTjA0KittjWHojv
 Mx/DdmEJ9Ww8YauB4p9tVti+TUs9xfxe9s2F2mmCgCEHvuTf72Jmi4Ls3WNFri1mj6sP+1Z+e5C
 lY3Ky80Cx5O8Ckr0505S5lDpMg5UeoZw6lAE8ZKZyIHVfe9BAmWpUKvplodWWlPt/m5frIhfPoE
 FoeK8TJyNETNJtfwmxpy2pZr8VBS01IIHaT4ByHcKxrOEqf5qfLvFXvAZVGwR3i31fjkjcB9Cd7
 K1NNzSs4i4Tm3lLeHS2WOXt5JTeMakFABS3ombIKYpgYCqw2GIsc+3Bnq/dODeK7gnwg477xaPe
 VfzcEv9//GLK92JX6f6wgV0EE9QVr2KXDmSRlzY7PRkPcUjwwL+Ys5afCDlfJn/oPtafFUhMOK+
 QcZpMBJj9f8jXOUxee1eYEILqUFWN7jbCh37+Ni8nas5Ym3y+h5mx59sLSnBqd5qEJAc4RVwuQq
 f0NXzrvLWbktqKgn5n8rbhK
X-Received: by 2002:a05:600c:3b02:b0:49f:bd3c:bc26 with SMTP id
 5b1f17b1804b1-49fe6711fd2mr4734555e9.33.1790194257582; 
 Wed, 23 Sep 2026 13:10:57 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:10:57 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 4/7] fbdev: honour the device tree boot logo placement
 properties
Date: Wed, 23 Sep 2026 22:10:32 +0200
Message-Id: <20260923201035.51007-5-maximpedraza@gmail.com>
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

A logo supplied by the device tree describes a specific product, so where
it lands on the panel matters in a way it does not for the built-in Tux.
Fill in the placement added earlier from the optional "logo-position",
"logo-offset" and "logo-rotation" properties of the
"boot-logo-clut224" node, so that it takes the place of what the
console command line would otherwise have asked for.

"logo-position" gives the top left corner, with -1 on an axis meaning
centre on that axis, which is what fb_center_logo already meant.
"logo-offset" is added afterwards, and is the reason the offset joins the
structure here. Centring and then displacing is what panels with a
partially visible area need, where the usable region is not the centre of
the mode, and it is the only way to express it when the image comes from a
reserved memory region and the device tree therefore does not know the logo
size. Both come straight from the device tree, so the sum is done in 64
bits and clamped, and a silly pair of values lands the logo against an edge
rather than off the screen.

The properties are read by logo_dt_placement(), in logo.c next to the
parser of the image that comes from the same node, so that everything that
knows the binding lives in one place. The frame buffer code only asks for
the result.

The rotation values match FB_ROTATE_*, but they do not mean what a
rotated console means. fbcon turns the screen, so it looks at the panel
sideways, places the logo in the console's own frame and maps the result
back. A rotation asked for by the device tree turns the logo alone, on a
screen that stays where it is, so the placement stays in screen pixels
and only the room the logo takes up changes. fb_rotate_logo() is split
into the part that turns the image and the part that moves the
placement, and a device tree rotation uses only the former.

A logo placed by the device tree is drawn once rather than once per CPU:
the device tree names one position, and repeating the image from there
would either overlap the copies or walk them off the reserved region.

For the same reason the extra logos appended by fb_append_extra_logo() are
not drawn when the device tree supplied the logo. They stack up from
wherever the previous logo ended, which is an arbitrary point once the
device tree has placed the first one, so the two do not compose. Only
PowerPC Cell appends any, and a message is printed if there was anything to
drop. The space fb_prepare_extra_logos() reserves for them is left alone,
so that combination keeps a gap it no longer fills.

The node is read once, from fb_prepare_logo(), since fb_show_logo() is only
ever reached after that has run. The read is guarded with IS_ENABLED()
rather than an #ifdef so that the code is compile checked whatever the
configuration, and optimised away when the option is off.

A node whose image is rejected still has its placement honoured, so a
malformed node yields the built-in logo drawn where the device tree asked
for it.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/fbdev/core/fb_logo.c | 189 ++++++++++++++++++++++++-----
 drivers/video/logo/logo.c          |  78 ++++++++++++
 include/linux/linux_logo.h         |  45 +++++--
 3 files changed, 274 insertions(+), 38 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index 5ec9f9554f..ff7d0b409e 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -9,13 +9,72 @@ bool fb_center_logo __read_mostly;
 int fb_logo_count __read_mostly = -1;
 
 /*
- * The placement in effect, as asked for on the console command line.
+ * Placement of a logo supplied by the device tree. Both the image and its
+ * placement are parsed by drivers/video/logo/logo.c, here we only keep a copy
+ * of where it goes.
+ */
+static struct {
+	struct logo_placement pos;
+	bool valid;
+	int rotation;		/* LOGO_ROTATE_* (== FB_ROTATE_*), or -1 */
+} fb_logo_dt;
+
+/*
+ * Read the placement out of the device tree. Called once, from
+ * fb_prepare_logo(): fb_show_logo() is only ever reached after that has run,
+ * so everything below can just look at fb_logo_dt.
+ */
+static void fb_logo_dt_read(void)
+{
+	static bool read_done;
+
+	/*
+	 * logo_dt_placement() checks the option too, but it lives in another
+	 * translation unit, so without the check here the compiler would have
+	 * to keep fb_logo_dt around for a call that can only fail.
+	 */
+	if (!IS_ENABLED(CONFIG_LOGO_DT_CLUT224) || read_done)
+		return;
+
+	fb_logo_dt.valid = !logo_dt_placement(&fb_logo_dt.pos,
+					      &fb_logo_dt.rotation);
+	/* Last, so that nothing can observe a half filled in placement */
+	read_done = true;
+}
+
+/*
+ * A rotation asked for by the device tree turns the logo, not the screen, so
+ * it is placed in screen pixels. A rotated console turns the screen, and the
+ * logo is placed in the console's own frame. Telling the two apart is what
+ * this is for.
+ */
+static bool fb_logo_dt_rotated(void)
+{
+	return IS_ENABLED(CONFIG_LOGO_DT_CLUT224) && fb_logo_dt.valid &&
+	       fb_logo_dt.rotation >= 0;
+}
+
+static int fb_logo_dt_rotation(int rotate)
+{
+	if (fb_logo_dt_rotated())
+		return fb_logo_dt.rotation;
+
+	return rotate;
+}
+
+/*
+ * The placement in effect: what the device tree asked for if it supplied a
+ * logo, otherwise what the console command line asked for. fb_prepare_logo()
+ * has already called fb_logo_dt_read() by the time anything gets here.
  */
 static const struct logo_placement *fb_logo_placement(void)
 {
 	static const struct logo_placement centred = { .x = -1, .y = -1 };
 	static const struct logo_placement top_left = { };
 
+	if (IS_ENABLED(CONFIG_LOGO_DT_CLUT224) && fb_logo_dt.valid)
+		return &fb_logo_dt.pos;
+
 	return fb_center_logo ? &centred : &top_left;
 }
 
@@ -218,35 +277,45 @@ static void fb_rotate_logo_ccw(const u8 *in, u8 *out, u32 width, u32 height)
 			out[height * (w - j) + i] = *in++;
 }
 
-static void fb_rotate_logo(struct fb_info *info, u8 *dst,
-			   struct fb_image *image, int rotate)
+/* Turn the image itself, leaving @image->dx and @image->dy alone */
+static void fb_rotate_logo_image(u8 *dst, struct fb_image *image, int rotate)
 {
-	u32 tmp;
-
 	if (rotate == FB_ROTATE_UD) {
 		fb_rotate_logo_ud(image->data, dst, image->width,
 				  image->height);
-		image->dx = info->var.xres - image->width - image->dx;
-		image->dy = info->var.yres - image->height - image->dy;
 	} else if (rotate == FB_ROTATE_CW) {
 		fb_rotate_logo_cw(image->data, dst, image->width,
 				  image->height);
 		swap(image->width, image->height);
-		tmp = image->dy;
-		image->dy = image->dx;
-		image->dx = info->var.xres - image->width - tmp;
 	} else if (rotate == FB_ROTATE_CCW) {
 		fb_rotate_logo_ccw(image->data, dst, image->width,
 				   image->height);
 		swap(image->width, image->height);
-		tmp = image->dx;
-		image->dx = image->dy;
-		image->dy = info->var.yres - image->height - tmp;
 	}
 
 	image->data = dst;
 }
 
+/* As above, and map the placement from the console's frame to the screen */
+static void fb_rotate_logo(struct fb_info *info, u8 *dst,
+			   struct fb_image *image, int rotate)
+{
+	u32 tmp = rotate == FB_ROTATE_CW ? image->dy : image->dx;
+
+	fb_rotate_logo_image(dst, image, rotate);
+
+	if (rotate == FB_ROTATE_UD) {
+		image->dx = info->var.xres - image->width - image->dx;
+		image->dy = info->var.yres - image->height - image->dy;
+	} else if (rotate == FB_ROTATE_CW) {
+		image->dy = image->dx;
+		image->dx = info->var.xres - image->width - tmp;
+	} else if (rotate == FB_ROTATE_CCW) {
+		image->dx = image->dy;
+		image->dy = info->var.yres - image->height - tmp;
+	}
+}
+
 static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			    int rotate, unsigned int num)
 {
@@ -295,6 +364,8 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 	const struct logo_placement *p;
 	unsigned int xres = info->var.xres;
 	unsigned int yres = info->var.yres;
+	bool dt_rotated = fb_logo_dt_rotated();
+	unsigned int fw, fh;
 	struct fb_image image;
 	unsigned int block;
 
@@ -340,28 +411,60 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 	image.width = logo->width;
 	image.height = logo->height;
 
-	if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW)
-		swap(xres, yres);
+	/* How much of the screen the logo covers once it has been turned */
+	fw = image.width;
+	fh = image.height;
+	if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW) {
+		swap(fw, fh);
+		/* A turned console is looked at sideways, a turned logo is not */
+		if (!dt_rotated)
+			swap(xres, yres);
+	}
 
-	while (n && (n * (logo->width + 8) - 8 > xres))
-		--n;
+	if (IS_ENABLED(CONFIG_LOGO_DT_CLUT224) && fb_logo_dt.valid) {
+		/*
+		 * The device tree asks for the logo at one place, so draw it
+		 * once. Repeating it per CPU would either overlap the copies
+		 * or walk them out of the region reserved for the logo.
+		 */
+		n = 1;
+	} else {
+		while (n && (n * (logo->width + 8) - 8 > xres))
+			--n;
+	}
 
 	/* The copies are drawn in a row, so they are centred as one block */
 	block = n ? n * (logo->width + 8) - 8 : logo->width;
 
 	p = fb_logo_placement();
-	image.dx = logo_place_axis(p->x, xres, block);
-	/* A stacked logo goes where the caller put it */
-	image.dy = y ? y : logo_place_axis(p->y, yres, image.height);
+	if (dt_rotated) {
+		/*
+		 * The device tree names a place on the screen, so the logo is
+		 * placed by the room it takes up there and drawn as it lies.
+		 */
+		image.dx = logo_place_axis(p->x, p->offset_x, xres, fw);
+		image.dy = logo_place_axis(p->y, p->offset_y, yres, fh);
+	} else {
+		image.dx = logo_place_axis(p->x, p->offset_x, xres, block);
+		/* A stacked logo goes where the caller put it */
+		image.dy = y ? y : logo_place_axis(p->y, p->offset_y, yres,
+						   image.height);
+	}
 
 	if (rotate) {
 		logo_rotate = kmalloc_array(logo->width, logo->height,
 					    GFP_KERNEL);
-		if (logo_rotate)
-			fb_rotate_logo(info, logo_rotate, &image, rotate);
+		if (logo_rotate) {
+			if (dt_rotated)
+				fb_rotate_logo_image(logo_rotate, &image,
+						     rotate);
+			else
+				fb_rotate_logo(info, logo_rotate, &image,
+					       rotate);
+		}
 	}
 
-	fb_do_show_logo(info, &image, rotate, n);
+	fb_do_show_logo(info, &image, dt_rotated ? FB_ROTATE_UR : rotate, n);
 
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)
@@ -414,10 +517,23 @@ static int fb_prepare_extra_logos(struct fb_info *info, unsigned int height,
 	return height;
 }
 
+/*
+ * A logo supplied by the device tree is placed where the device tree asks,
+ * and the extra logos stack up from wherever the previous one ended. Those
+ * two do not compose: the stack would start at an arbitrary point and walk
+ * off the screen. The device tree wins, and says so if anything is dropped.
+ */
 static int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
 {
 	unsigned int i;
 
+	if (IS_ENABLED(CONFIG_LOGO_DT_CLUT224) && fb_logo_dt.valid) {
+		if (fb_logo_ex_num)
+			pr_info("fb: device tree logo in use, %u extra logo(s) not drawn\n",
+				fb_logo_ex_num);
+		return y;
+	}
+
 	for (i = 0; i < fb_logo_ex_num; i++)
 		y = fb_show_logo_line(info, rotate,
 				      fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
@@ -430,11 +546,14 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
 	const struct logo_placement *p;
-	unsigned int yres;
+	unsigned int yres, fh;
 	int height;
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
+	fb_logo_dt_read();
+	rotate = fb_logo_dt_rotation(rotate);
+
 	if (info->flags & FBINFO_MISC_TILEBLITTING ||
 	    info->fbops->owner || !fb_logo_count)
 		return 0;
@@ -458,12 +577,23 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	if (!fb_logo.logo)
 		return 0;
 
-	if (rotate == FB_ROTATE_UR || rotate == FB_ROTATE_UD)
+	/*
+	 * A turned console is looked at sideways, so the logo is measured
+	 * against the console's own frame. A logo turned by the device tree
+	 * leaves the screen alone, and only covers a different part of it.
+	 */
+	fh = fb_logo.logo->height;
+	if (fb_logo_dt_rotated()) {
 		yres = info->var.yres;
-	else
+		if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW)
+			fh = fb_logo.logo->width;
+	} else if (rotate == FB_ROTATE_UR || rotate == FB_ROTATE_UD) {
+		yres = info->var.yres;
+	} else {
 		yres = info->var.xres;
+	}
 
-	if (fb_logo.logo->height > yres) {
+	if (fh > yres) {
 		fb_logo.logo = NULL;
 		return 0;
 	}
@@ -499,8 +629,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	 * that the two cannot disagree.
 	 */
 	p = fb_logo_placement();
-	height = logo_place_axis(p->y, yres, fb_logo.logo->height) +
-		 fb_logo.logo->height;
+	height = logo_place_axis(p->y, p->offset_y, yres, fh) + fh;
 #ifdef CONFIG_FB_LOGO_EXTRA
 	height = fb_prepare_extra_logos(info, height, yres);
 #endif
@@ -516,6 +645,8 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	if (!fb_logo_count)
 		return 0;
 
+	rotate = fb_logo_dt_rotation(rotate);
+
 	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
 	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
 #ifdef CONFIG_FB_LOGO_EXTRA
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 84afd5b337..b600fc3aab 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -158,6 +158,84 @@ static const struct linux_logo *logo_dt_find(void)
 	return logo_dt_data ? &logo_dt_clut224 : NULL;
 }
 
+static int logo_dt_parse_rotation(const char *rotation)
+{
+	if (!strcmp(rotation, "none"))
+		return LOGO_ROTATE_NONE;
+	if (!strcmp(rotation, "cw"))
+		return LOGO_ROTATE_CW;
+	if (!strcmp(rotation, "ud"))
+		return LOGO_ROTATE_UD;
+	if (!strcmp(rotation, "ccw"))
+		return LOGO_ROTATE_CCW;
+
+	return -EINVAL;
+}
+
+/**
+ * logo_dt_placement - where a logo supplied by the device tree asks to go
+ * @pos: filled in with the requested position and offset
+ * @rotation: filled in with one of LOGO_ROTATE_*, or -1 when the node does
+ *            not ask for any
+ *
+ * Only the placement is read here, the image itself is fb_find_logo()'s
+ * business. It lives next to the image parser rather than in any one user so
+ * that everything that draws the logo reads the same properties the same way.
+ *
+ * Return: 0 if the device tree supplies a logo node, -ENODEV otherwise, in
+ * which case @pos and @rotation are left untouched.
+ */
+int logo_dt_placement(struct logo_placement *pos, int *rotation)
+{
+	struct device_node *np;
+	const char *str;
+	u32 val[2];
+	int rot;
+
+	if (!IS_ENABLED(CONFIG_LOGO_DT_CLUT224))
+		return -ENODEV;
+
+	/*
+	 * Same node the image itself comes from, looked up the same way: a
+	 * child of /chosen, not just anything compatible anywhere in the tree.
+	 */
+	np = of_get_compatible_child(of_chosen, LOGO_DT_COMPATIBLE);
+	if (!np)
+		return -ENODEV;
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	*pos = (struct logo_placement){ };
+	*rotation = -1;
+
+	if (!of_property_read_u32_array(np, "logo-position", val, 2)) {
+		pos->x = (s32)val[0];
+		pos->y = (s32)val[1];
+	}
+
+	if (!of_property_read_u32_array(np, "logo-offset", val, 2)) {
+		pos->offset_x = (s32)val[0];
+		pos->offset_y = (s32)val[1];
+	}
+
+	if (!of_property_read_string(np, "logo-rotation", &str)) {
+		rot = logo_dt_parse_rotation(str);
+		if (rot < 0)
+			pr_warn("logo: %pOF: unknown logo-rotation \"%s\"\n",
+				np, str);
+		else
+			*rotation = rot;
+	}
+
+	of_node_put(np);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(logo_dt_placement);
+
 /*
  * Logos are located in the initdata, and will be freed in kernel_init.
  * Use late_init to mark the logos as freed to prevent any further use.
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index 1e7e9db6dd..a8b7bde8d4 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -12,6 +12,7 @@
  *  Copyright (C) 2003 Geert Uytterhoeven <geert@linux-m68k.org>
  */
 
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/minmax.h>
 #include <linux/types.h>
@@ -43,29 +44,55 @@ extern const struct linux_logo logo_spe_clut224;
 extern const struct linux_logo *fb_find_logo(int depth);
 
 /*
- * Where a boot logo goes. A coordinate of -1 centres the logo on that axis.
- * Whatever draws the logo describes its placement this way and computes it
- * with logo_place_axis(), so that no two places can end up disagreeing about
- * where the logo is.
+ * Where a boot logo goes. A coordinate of -1 centres the logo on that axis,
+ * and the offset is added afterwards. Whatever draws the logo describes its
+ * placement this way and computes it with logo_place_axis(), so that no two
+ * places can end up disagreeing about where the logo is.
  */
 struct logo_placement {
 	s32 x, y;
+	s32 offset_x, offset_y;
 };
 
+/* Rotation a device tree supplied logo can ask for, same values as FB_ROTATE_* */
+#define LOGO_ROTATE_NONE	0
+#define LOGO_ROTATE_CW		1
+#define LOGO_ROTATE_UD		2
+#define LOGO_ROTATE_CCW		3
+
+#ifdef CONFIG_LOGO
+int logo_dt_placement(struct logo_placement *pos, int *rotation);
+#else
+static inline int logo_dt_placement(struct logo_placement *pos, int *rotation)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * Place a logo along one axis. @pos is the coordinate asked for, or -1 to
- * centre on that axis. The result is clamped so that the logo always lies
- * entirely within the screen: the drawing code does not clip, so asking for
- * more than that would otherwise scribble past the end of the frame buffer.
+ * centre on that axis, and @off is applied afterwards. The result is clamped
+ * so that the logo always lies entirely within the screen: the drawing code
+ * does not clip, so a device tree asking for more than that would otherwise
+ * scribble past the end of the frame buffer.
  */
-static inline int logo_place_axis(s32 pos, unsigned int span, unsigned int size)
+static inline int logo_place_axis(s32 pos, s32 off, unsigned int span,
+				  unsigned int size)
 {
 	int last = (int)span - (int)size;
+	s64 coord;
 
 	if (size > span)
 		return 0;
 
-	return pos == -1 ? last / 2 : clamp(pos, 0, last);
+	coord = pos == -1 ? last / 2 : pos;
+
+	/*
+	 * Both come straight from the device tree, so the sum is done wide
+	 * enough that a silly pair of values lands the logo against an edge
+	 * instead of wrapping round to the other one.
+	 */
+	return clamp_t(s64, coord + off, 0, last);
 }
 
 #ifdef CONFIG_FB_LOGO_EXTRA
-- 
2.39.5

