Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27EACA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0543F10F77B;
	Thu,  1 Oct 2026 19:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KPChyrb9";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435AD10F77B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:07 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso71436705e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884746; x=1791489546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3qywgNTd6TlVJPvtlQJLwhQRTzG27xqxJQYleDreMzo=;
 b=KPChyrb9aSnestVFbMQrAyxRbhzy6YhIjG+a13gRJhI2dGVwBNOCp2Jjr6KvVGivZV
 6NUILoqgq+zsQcezK9VXo72J7Qur3xE9hjucnSHCWk+tUssw0FzJI4nh+oR1mYSwiTYC
 lrTc8nTIp6WUe0OlYo15Y40LJUbxAOxSkeE7+w+bM2ABFeFQ2By9RiPs51tzg93OY2ov
 tvcLPLafQ1GSrEjkibfxn6Vw2Hi2V97THsp5F1Hb/u8+Xcoo9bY+GtLWuYNMegWmAAjO
 RaCxgJ7ZEFN5/ei0t4329vn36mXTi7yfoV/PeBQo+uW281bdVFcVFFE3ZDuQtn6oiwgY
 Dyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884746; x=1791489546;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3qywgNTd6TlVJPvtlQJLwhQRTzG27xqxJQYleDreMzo=;
 b=RyD/YW+pLdAdRwRU5UtNIStB95xGvogPAQRakAr/VYcTXJP9SGNsGkFKORsp9s/lr3
 kv1kdRXRn/74GQSQamTzlRB1J2/nTb6DU4QXjc36a9+DM8rj+syPilwQLWQRXtMqj501
 UTG/OqDIo5peNni914cjkfP/xsMPNzO9dJFNx9GBxs/t90WLvRQ/9zMYMXi2DAVwoCSC
 24XdKphVmZyhDXmeMv/VFrqwnzjhRNTAU2ev/BwdaouzpXK+KU8kJg5SFKtgPnrZwNUL
 nU2adV47LeQ95UDq4T9AHY1OXuTmkejWlziGChdAL16HPF2Y9fUbnzL0z054jiSKk2n2
 Mv9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByMXWSWBL2W0O88YHlwRWOLZ5J8p4tK8/Wo7XYvk1XbGJyS8Oych3WxG/lh1MwYWBF5MaPDiH1uCm0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHyXoE/Sld1IFJiWzjtEtyDHBhzIhhDRgTaXgbSDgOhiueOe7J
 GnN/TS4UXNp83RahJ9513d5u+tVNR+rij3v7F4snfs5mdTEn19ibRzIc
X-Gm-Gg: AYBFou3nbBOGijAJDv6B7A5DmBXaWNcaRlQpEOCLZL7qk+yZbQwBoVHW+6xrNrEiFkx
 KxM+jUfm6Jsq+8c9Qy3lxT8BxCVPCfvT6OE+Ob8fcZvIxAcYxSxLpCQL5jOrTcDW5QgqhIBVfay
 POOj1knYtSd+qGrGDXj9OK0NmbtT5Dv43KrSXJqCSfQF7oZ/tRaIlawhQkOXprbY9bmrSUbP37x
 6zEleAUECw2FAnOZqWjjCyKLrOiZRr4cLmm9yTHGM+BTECU9ReoWx385T5wwpPyfk6h8yBIDuvC
 ELIJC2KvHH3sDjLrHw3OdrXNm3O1ya9m068bBSNW2ZgKd8yENt79uNIYb6yBGUNIPDdhOg22UA/
 OlMkPf3hA3Z0d9uiNgukUr/bgR62M3j+4zl3RWQG7uhiCqtEFxNFLSXbsgwdTdBTZJtjawnFEOC
 niBSXScQhhgVe4xqc6L5D4PCFh+MHBbfCF6DyEBmJQa2JmaEtZCxzCpA9dDyXcX8P0fSG9XR087
 M0WzpnRTQ+1iHGvrADeTf/pEQ==
X-Received: by 2002:a05:600c:4592:b0:4a0:bc9:28c6 with SMTP id
 5b1f17b1804b1-4a0276b6860mr10617665e9.34.1790884745507; 
 Thu, 01 Oct 2026 12:59:05 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:59:05 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 08/13] drm/client: splash: place the device tree image
 where it asks
Date: Thu,  1 Oct 2026 21:58:42 +0200
Message-Id: <20261001195847.141192-9-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A logo supplied by the device tree describes a particular product, and
where it lands on the panel matters: some panels only show part of the
mode, so the middle of the mode is not the middle of what the user
sees.

Read the optional "logo-position" and "logo-offset" properties of the
node. The position is the top left corner, with -1 on an axis meaning
centre on that axis, and the offset is added afterwards, which is the
only way to say "below the centre" when the device tree does not know
the image size, as with an image in a reserved region.

Both come straight from the device tree, so the sum is done in 64 bits
and clamped, and a silly pair of values lands the image against an
edge rather than off the screen: the blitters do not clip. Every other
source keeps being centred, except the BGRT, which keeps its own
offsets.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 73 ++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 444f612c48ac..349f68d392e5 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -120,6 +120,14 @@ struct drm_splash {
 	void *map_data;
 
 	enum drm_splash_source src;
+
+	/*
+	 * Where the image goes, in screen pixels: a coordinate of -1 centres
+	 * it on that axis, and the offset is added afterwards. Only the device
+	 * tree asks for anything but the centre.
+	 */
+	s32 pos_x, pos_y;
+	s32 off_x, off_y;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -252,13 +260,21 @@ static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
 	return NULL;
 }
 
-static bool drm_splash_dt_available(struct drm_splash *splash)
+/* The optional placement properties of the node, read once */
+static void drm_splash_dt_placement(struct drm_splash *splash,
+				    struct device_node *np)
 {
-	struct device_node *np = drm_splash_dt_node(splash);
+	u32 val[2];
 
-	of_node_put(np);
+	if (!of_property_read_u32_array(np, "logo-position", val, 2)) {
+		splash->pos_x = (s32)val[0];
+		splash->pos_y = (s32)val[1];
+	}
 
-	return np;
+	if (!of_property_read_u32_array(np, "logo-offset", val, 2)) {
+		splash->off_x = (s32)val[0];
+		splash->off_y = (s32)val[1];
+	}
 }
 
 static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
@@ -311,9 +327,14 @@ static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
 	return ret;
 }
 #else
-static inline bool drm_splash_dt_available(struct drm_splash *splash)
+static inline struct device_node *drm_splash_dt_node(struct drm_splash *splash)
+{
+	return NULL;
+}
+
+static inline void drm_splash_dt_placement(struct drm_splash *splash,
+					   struct device_node *np)
 {
-	return false;
 }
 
 static inline int drm_splash_dt_load(struct drm_splash *splash,
@@ -459,6 +480,26 @@ static int drm_splash_fill_solid_color(struct drm_client_buffer *buffer,
 }
 
 #if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_BMP_SUPPORT)
+/*
+ * Place the image along one axis of the screen. @pos is the coordinate asked
+ * for, or -1 to centre on that axis, and @off is added afterwards. Both may
+ * come from the device tree, so the sum is done wide enough not to wrap, and
+ * the result keeps the whole image on the screen: the blitters do not clip.
+ */
+static unsigned int drm_splash_place_axis(s32 pos, s32 off, unsigned int span,
+					  unsigned int size)
+{
+	s64 last = (s64)span - size;
+	s64 coord;
+
+	if (last <= 0)
+		return 0;
+
+	coord = pos == -1 ? last / 2 : pos;
+
+	return clamp_t(s64, coord + off, 0, last);
+}
+
 static void drm_splash_blit_pix16(struct iosys_map *map, unsigned int dpitch,
 				  unsigned int x_pad, unsigned int y_pad,
 				  const u8 *sbuf8, unsigned int spitch,
@@ -657,9 +698,10 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		}
 #endif
 	} else {
-		/* Center X and Y */
-		x_pad = (scanout->width - bmp_width) / 2;
-		y_pad = (scanout->height - bmp_height) / 2;
+		x_pad = drm_splash_place_axis(splash->pos_x, splash->off_x,
+					      scanout->width, bmp_width);
+		y_pad = drm_splash_place_axis(splash->pos_y, splash->off_y,
+					      scanout->height, bmp_height);
 	}
 
 	image_data = data + bitmap_offset;
@@ -742,8 +784,15 @@ static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
  */
 static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 {
-	if (drm_splash_dt_available(splash))
+	struct device_node *np;
+
+	np = drm_splash_dt_node(splash);
+	if (np) {
+		drm_splash_dt_placement(splash, np);
+		of_node_put(np);
 		return DRM_SPLASH_SRC_DT;
+	}
+
 	if (drm_splash_bgrt_available(splash))
 		return DRM_SPLASH_SRC_BGRT;
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
@@ -1141,6 +1190,10 @@ void drm_splash_register(struct drm_device *dev,
 	spin_lock_init(&splash->fw_lock);
 	init_completion(&splash->fw_done);
 
+	/* Centred unless the image source asks otherwise */
+	splash->pos_x = -1;
+	splash->pos_y = -1;
+
 	if (format && format->num_planes == 1)
 		splash->preferred_format = format->format;
 	else
-- 
2.39.5

