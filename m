Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61124C561E6
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA43710EBD0;
	Tue,  4 Aug 2026 20:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YX7FzAvX";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA3810EBD0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:56:28 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so2046235e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785876987; x=1786481787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aPWyvzGNLa7rHTsTZpFRCraZCWg00Qf6Fr76L45avBk=;
 b=YX7FzAvXCvWLRhu4zg1ZNgnTJvt+U9uorLnntXfIq7CeFhPBd2FtQ49IqcEx+M957I
 ygQj8j5Ut2IdN4Fl2QhrH8EvxWvfXPeZZOVaGpyLeur1oFW24L8hsyUQhKUnu9E18d0R
 dLD7bm0a+H6bcvpleAYJS3o9c/gAtMzmXKamH3ZpppvaM+/RO15x9xX9r3UMLrBdd2Lw
 Sbep1VHukRdm1V+GKislJsEcsMc1DS8CGCSG610Ioak2TVHXjw2GoaIavYdR+dviT2Zs
 rm5RkCrGuVwqhka4VM6KwmXihAOdc06NM4e3Zw2hLC18RGtvGUWdrGdBPghqIZZgkDrK
 I5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785876987; x=1786481787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aPWyvzGNLa7rHTsTZpFRCraZCWg00Qf6Fr76L45avBk=;
 b=ko738WR2MgqIU39Sr8b/hT+7/AzF8PDxzdxOSOaV2k8ParzffYRgwvOY9o89YqtOn4
 PEnOZIhwMzkkKpzZQvzUdLk3mdPw7LHGAIPdUeTCS6/npFadJSFJ6tJJ2m7DpdmP9kTM
 2pB0XHS+vv0VVcUxRq34cs1Adqod3cEaGDlXY1rV5r6v/uh/VBD1/S54499NPbEMk8fi
 /oqDuoALgc4dFs1W+lsGG1VhmxWDsdHRCNSUb9DjAJ0n2gnT3S9z3zV7ocLig5ie62R+
 DrRPhzUFNrV7DIKJedBI+HsSjxmnPd63s1KuciOTJCpkEQQ4+tNmKBoJaig8d4fp+Ih2
 A2qQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RozBbawaHm8tF5y6q09OkgVKYJpHohOCD+P+mSULKEb1pnHL4r3jn2NEEG9de324cBCSeP0YO3ZAbo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9GjZFCDfEcORpT+YTKxy3dmK0f6I7yQZZRa155mWmxhPep44D
 ZnuRrG/p4hUZkI8RBFU6xr8veGbYl9xoVacmSVPV5uyVFDAM7qgZLlel
X-Gm-Gg: AR+sD11bGqzlS5SyBRjicmw6BIPFOp6Y8nRHiX2B2NRcEt+iBLsW75/DJCzo5sdZQgB
 nOCa7GQc3zTd/wqd2d9ruhn+L85Tcq3sDHZRehrh9Y2HJ6eMzQUQoMwF/ODH2V/j0QQIfVGFjTi
 F2H1/sDyD/IfMJ+Jw3MX9MJ37BIh0+kD2/MHd+zI78BU0qjzMT3d9yZssn5qCpnEuWWz6M6tfeb
 syPOdsnkajGQy1STE/Xcr6Irp61WWdAoOYZ+0a3hkSAb+NHdDOiYRQd1xjJqCeL2pI/38QJnLYM
 T2IDOT4+sqCQha7KE8qT3VIqckpyYA41XOBLMOWw6I+bMoE3JsEYVMVtZ4k8HIjq2CZ4Ib5h/2K
 uuDSFPJYprhfGyqzsyuv3qkN9/yvvjfCb8CNGv3JhxYVYjxDDeSYwfaoYqueccG2PYPRgyF7aSC
 yJBWCd3oeqt4gjKF3Vsphsir1WU4Jb2ek7vXOGMNQNykcu1dcOJdRYObW20zSQxFyD2ee5m+7sQ
 OumAQIFcSXnO54=
X-Received: by 2002:a05:600c:1f87:b0:495:607e:5ee7 with SMTP id
 5b1f17b1804b1-4994e7d8ab9mr9728935e9.17.1785876986562; 
 Tue, 04 Aug 2026 13:56:26 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 13:56:25 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 3/6] fbdev: honour the device tree boot logo placement
 properties
Date: Wed,  5 Aug 2026 00:56:14 +0200
Message-Id: <20260804225617.264861-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
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
Honour the optional "logo-position", "logo-offset", "logo-centered" and
"logo-rotation" properties of the "linux,boot-logo-clut224" node.

The rotation is folded into the rotate argument at the entry points, so
fb_prepare_logo() reserves the right amount of space and fb_do_show_logo()
tiles in the same direction the image was rotated in.

Placement is applied after fb_rotate_logo(), since a rotation swaps the
image width and height and centring needs the final dimensions.

fb_prepare_logo() has to grow its reservation to cover wherever the logo
ends up, the way fb_center_logo already does: fbcon only leaves the first
n rows alone, so a logo placed further down is drawn and then immediately
cleared by the console.

"logo-centered" is deliberately close to the existing fb_center_logo, but
it is per device tree rather than per fbcon command line, and it composes
with "logo-offset" so that a logo can be centred and then nudged. That
combination is what panels with a partially visible area need, where the
usable region is not the centre of the mode.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/fbdev/core/fb_logo.c | 174 +++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index 0bab8352b..bfc1b72ce 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -2,12 +2,178 @@
 
 #include <linux/fb.h>
 #include <linux/linux_logo.h>
+#include <linux/of.h>
 
 #include "fb_internal.h"
 
 bool fb_center_logo __read_mostly;
 int fb_logo_count __read_mostly = -1;
 
+#ifdef CONFIG_LOGO_DT_CLUT224
+
+/*
+ * Placement of a logo supplied by the device tree. The image itself is parsed
+ * by drivers/video/logo/logo.c, here we only care about where it goes.
+ */
+struct fb_logo_dt_placement {
+	bool valid;
+	bool centered;
+	bool has_position;
+	int rotation;		/* FB_ROTATE_*, or -1 when unspecified */
+	u32 x, y;
+	s32 offset_x, offset_y;
+};
+
+static struct fb_logo_dt_placement fb_logo_dt;
+
+static int fb_logo_dt_parse_rotation(const char *rotation)
+{
+	if (!strcmp(rotation, "none"))
+		return FB_ROTATE_UR;
+	if (!strcmp(rotation, "cw"))
+		return FB_ROTATE_CW;
+	if (!strcmp(rotation, "ud"))
+		return FB_ROTATE_UD;
+	if (!strcmp(rotation, "ccw"))
+		return FB_ROTATE_CCW;
+
+	return -EINVAL;
+}
+
+static void fb_logo_dt_read(void)
+{
+	struct fb_logo_dt_placement *p = &fb_logo_dt;
+	static bool read_done;
+	struct device_node *np;
+	const char *rotation;
+	u32 val[2];
+	int rot;
+
+	if (read_done)
+		return;
+
+	read_done = true;
+
+	np = of_find_compatible_node(NULL, NULL, "linux,boot-logo-clut224");
+	if (!np)
+		return;
+
+	if (!of_device_is_available(np))
+		goto out;
+
+	p->valid = true;
+	p->rotation = -1;
+	p->centered = of_property_read_bool(np, "logo-centered");
+
+	if (!of_property_read_u32_array(np, "logo-position", val, 2)) {
+		p->has_position = true;
+		p->x = val[0];
+		p->y = val[1];
+	}
+
+	if (!of_property_read_u32_array(np, "logo-offset", val, 2)) {
+		p->offset_x = (s32)val[0];
+		p->offset_y = (s32)val[1];
+	}
+
+	if (!of_property_read_string(np, "logo-rotation", &rotation)) {
+		rot = fb_logo_dt_parse_rotation(rotation);
+		if (rot < 0)
+			pr_warn("fb: %pOF: unknown logo-rotation \"%s\"\n",
+				np, rotation);
+		else
+			p->rotation = rot;
+	}
+
+out:
+	of_node_put(np);
+}
+
+static int fb_logo_dt_rotation(int rotate)
+{
+	fb_logo_dt_read();
+
+	if (fb_logo_dt.valid && fb_logo_dt.rotation >= 0)
+		return fb_logo_dt.rotation;
+
+	return rotate;
+}
+
+/* Top edge of the logo, in the coordinate space the caller works in */
+static int fb_logo_dt_top(unsigned int yres, unsigned int logo_height)
+{
+	struct fb_logo_dt_placement *p = &fb_logo_dt;
+	int top;
+
+	if (p->centered)
+		top = ((int)yres - (int)logo_height) / 2;
+	else if (p->has_position)
+		top = p->y;
+	else
+		top = 0;
+
+	return max(top + p->offset_y, 0);
+}
+
+static void fb_logo_dt_place(struct fb_info *info, struct fb_image *image)
+{
+	struct fb_logo_dt_placement *p = &fb_logo_dt;
+	int dx;
+
+	fb_logo_dt_read();
+
+	if (!p->valid)
+		return;
+
+	if (p->centered)
+		dx = ((int)info->var.xres - (int)image->width) / 2;
+	else if (p->has_position)
+		dx = p->x;
+	else
+		dx = image->dx;
+
+	image->dx = max(dx + p->offset_x, 0);
+	image->dy = fb_logo_dt_top(info->var.yres, image->height);
+}
+
+/*
+ * fbcon only leaves the first @height rows of the screen alone, so a logo
+ * placed further down would be drawn and then immediately cleared. Grow the
+ * reservation to cover wherever the logo actually ends up, the same way
+ * fb_center_logo does.
+ */
+static int fb_logo_dt_reserve(unsigned int yres, unsigned int logo_height,
+			      int height)
+{
+	fb_logo_dt_read();
+
+	if (!fb_logo_dt.valid)
+		return height;
+
+	return max(height, fb_logo_dt_top(yres, logo_height) +
+			   (int)logo_height);
+}
+
+#else /* !CONFIG_LOGO_DT_CLUT224 */
+
+static inline int fb_logo_dt_rotation(int rotate)
+{
+	return rotate;
+}
+
+static inline void fb_logo_dt_place(struct fb_info *info,
+				    struct fb_image *image)
+{
+}
+
+static inline int fb_logo_dt_reserve(unsigned int yres,
+				     unsigned int logo_height, int height)
+{
+	return height;
+}
+
+#endif /* CONFIG_LOGO_DT_CLUT224 */
+
 static inline unsigned int safe_shift(unsigned int d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
@@ -350,6 +516,9 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
 	}
 
+	/* Done last, image dimensions are only final after the rotation */
+	fb_logo_dt_place(info, &image);
+
 	fb_do_show_logo(info, &image, rotate, n);
 
 	kfree(palette);
@@ -423,6 +592,8 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
+	rotate = fb_logo_dt_rotation(rotate);
+
 	if (info->flags & FBINFO_MISC_TILEBLITTING ||
 	    info->fbops->owner || !fb_logo_count)
 		return 0;
@@ -483,6 +654,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	height = fb_logo.logo->height;
 	if (fb_center_logo)
 		height += (yres - fb_logo.logo->height) / 2;
+	height = fb_logo_dt_reserve(yres, fb_logo.logo->height, height);
 #ifdef CONFIG_FB_LOGO_EXTRA
 	height = fb_prepare_extra_logos(info, height, yres);
 #endif
@@ -498,6 +670,8 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	if (!fb_logo_count)
 		return 0;
 
+	rotate = fb_logo_dt_rotation(rotate);
+
 	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
 	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
 #ifdef CONFIG_FB_LOGO_EXTRA
-- 
2.39.5

