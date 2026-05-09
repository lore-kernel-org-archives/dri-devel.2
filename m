Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AC7CD37B7
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0AB10E3E9;
	Sat,  9 May 2026 19:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bbigV7Ua";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCCB10E3E9
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:27 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so2208187f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353226; x=1778958026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFHSVkKikAqL7V5/tk/bF1gVjwq2bK7i4HjBHfLDqaU=;
 b=bbigV7Uaj1hJVX5vrj/bFvlWav19cjLU/0YP3ggQqA8uzrU/5Ffoo6uviyGcsNa8tY
 yfBju7BQqDLcCOzKqLLmDEhj9tmjTDEVf4rWusTzKAvOsK/9O8ymGQkLdMrPMmlTUae4
 E50Hji+6syqq6kf3Z63Df9e3Vvzzxt5M8NfZb8Ty9jQbkwEZl95ujjkMBNcLB+HPRWdM
 ZfIlvD4rW3KsaZ/TTu7EinliGv9P5eDbJX8+A88IdByl9lf0DozzKUWusro3EgcSEeU6
 TvoBF8EqKKZsZw3nu0ipz2NFB1EH8uZUANCZi90RLIK/SYQhkBvvXcJ/ZuCNpBsAwaIb
 Pt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353226; x=1778958026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OFHSVkKikAqL7V5/tk/bF1gVjwq2bK7i4HjBHfLDqaU=;
 b=NcaiI8TXCc21gTaKAMIrASVvozOrjKVHwW1LYcpRuw7RyFLp1tPBk7MLoV05dm10Uy
 eBVNHMDlZU+thGuFHzkjWJjZnm5VJnjM4w/NJ6LlXfJKE4lDARwAf6wtuRfHg3rE5MYQ
 brWdSGWinB2tMVjXp3vbHyRbWQQHqv13fwKpOdCq4uUNEx3jWHMcuVbVNx9EzvwGSbh+
 taRO+ZdFOmJxGVWcYl619sdsfobdY6JDSCPP9KC/It55HFdPWhCgPt6cQUPW1sOvhpwp
 or3h3OGDhvXoIGkv/5+7iPkwWcjwZJmhdQZpuV3PjbA/dG59+2JFMXo9hAxt8zhpv/PE
 54AA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QpkeI+Dqt5+/Si2S+AqwRgUvVbiFG5noUrZ4OEDkiKQodkVyyUTrX2vahuSjo4tXkzSoEq9BZRmM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwenmqOJ8RHnejmLsdIOR28hHVhWcHhehpIT/FkSObp9fV2/wnl
 Bf1gLwhVAXQYhybSyna8GPxX+xrB6OCaYVIu2KtBRTLZlRSKf0emBDlt
X-Gm-Gg: Acq92OGjMVuRTHNBl+0pwIu+s0ZjPeWmVXcypmvLp/6fMpdgoN+gxkxq+NYv3wQdco4
 hTqsb27NYzhEozvka4APO51hl015i6yAps/rnSdwkDHLLzwzJRWQe3cdj1PFyNDw0CwB3IalvDv
 u1iJwViV2iBBb5tni8IIo3y6Oj5dhw9+YMpFN28xBjYb4TtZilPadN0ANOWWUd8NCl+0kdsqEDW
 91ENvM+SzudmYzVFZednov6/EVKA/acvv4lxqn/Qwjl7SD1kT3We4T9Lp0j1YXERh3gEfYQBZsM
 uKcwLuL9sJGASqRnC1SumNfvCDn9bewYkivYnPX6Cxt4Si6NOJHw6+pec8fbxP9kZ5Td44roydS
 NUv/AndSXBr0ixwKNmINvFP24DrraQIO8dAzz9Quu6+T1Bw77Ch/1UoqSmpEadEcJbGQIdADJnI
 rPGPu1NWJLX2kny1qOBBWCdJhhI90uiRMszUTHpLGYYg8obAatAR2FjKETrmyST0HI9qs=
X-Received: by 2002:a05:6000:40dc:b0:43d:309b:9c4f with SMTP id
 ffacd0b85a97d-4515b056c90mr27920879f8f.6.1778353225999; 
 Sat, 09 May 2026 12:00:25 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:25 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
X-Google-Original-From: Jernej Skrabec <jernej.skrabec@siol.net>
To: wens@csie.org,
	samuel@sholland.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 jernej.skrabec@gmail.com, Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH v2 4/8] drm/sun4i: vi_layer: Limit formats for DE33
Date: Sat,  9 May 2026 21:00:11 +0200
Message-ID: <20260509190015.79086-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509190015.79086-1-jernej.skrabec@siol.net>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

YUV formats need scaler support due to chroma upscaling, but that's not
yet supported in the driver. Remove them from supported list until
DE33 scaler is properly supported.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- collected tag
- generalize check to be dependant on scaler feature

 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index cd8d6c2da0c7..afbd41a18a0e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -380,6 +380,33 @@ static const u32 sun8i_vi_layer_de3_formats[] = {
 	DRM_FORMAT_YVU422,
 };
 
+static const u32 sun8i_vi_layer_de3_no_yuv_formats[] = {
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ARGB2101010,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_BGRA1010102,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGBA1010102,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XRGB8888,
+};
+
 static const uint64_t sun8i_layer_modifiers[] = {
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
@@ -410,8 +437,17 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	layer->cfg = cfg;
 
 	if (layer->cfg->de_type >= SUN8I_MIXER_DE3) {
-		formats = sun8i_vi_layer_de3_formats;
-		format_count = ARRAY_SIZE(sun8i_vi_layer_de3_formats);
+		/*
+		 * TODO: DE33 drivers doesn't support scaling yet, which is a
+		 * requirement for YUV support.
+		 */
+		if (layer->cfg->scaler_mask & BIT(phy_index)) {
+			formats = sun8i_vi_layer_de3_formats;
+			format_count = ARRAY_SIZE(sun8i_vi_layer_de3_formats);
+		} else {
+			formats = sun8i_vi_layer_de3_no_yuv_formats;
+			format_count = ARRAY_SIZE(sun8i_vi_layer_de3_no_yuv_formats);
+		}
 	} else {
 		formats = sun8i_vi_layer_formats;
 		format_count = ARRAY_SIZE(sun8i_vi_layer_formats);
-- 
2.54.0

