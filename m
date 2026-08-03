Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A687BC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F4310E702;
	Mon,  3 Aug 2026 16:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="noB2JpDM";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6813310E6FA
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:17 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso10750525e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773476; x=1786378276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7t2IG/bjYzTOtWYdkDb/FYlzP9IlRZpnBpyzw8LyRI=;
 b=noB2JpDMeO2D8o/PZ8snOdD5JQpghr5C67MJRle8owumT2k8tnDqw8a0EZCHeRASP6
 /Em9Mq/1uoAzbqN/7EXwpEi2gjxO1KMEVvBQB1EnknFoPbMHQKVzvyXApxAxVgM5kBkh
 GNo9Rgi6fAj1X7MfrAZG0uhhY0IBZv7ZCgOXU9eXkXkIQRZRgomtNIb2bOC8vpSuAtdC
 BWRRWlFbgyoEueI1/y2Bkk+SKp8t3G9aFuw8+tgpTA4Xw7oYJcAFGDjMjRwVYlFdj0pq
 ZjW6CfGIK3lqxUetiMhwiHGz2uxhdnLLU3wOyPpaDWXQzld/9PX8EeuOcU9GMlx0l7aG
 Y2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773476; x=1786378276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O7t2IG/bjYzTOtWYdkDb/FYlzP9IlRZpnBpyzw8LyRI=;
 b=CqgXvpQLR7ZOFUW2i7QHVhjGm7ZSQKh/yWixrwWAcl54IQj0CH49Yp8b+unl7W8yOc
 GFG+D91XjSYBGIrP6p7M2+yGiamMUjt8Cx6j0ffvDHffjk1HaTIU5MeJgi/zKNd41zcV
 Yy4Zhld0cs7smgLRsu8mtE1IItTmsedFQDFRFwnh1hknXj5KWZAgurP0TWKG+3sJEuoG
 HjEN2eBTZ88SMmC6q8C7inH/n6qcPTPOxZhkbTaAQnmtcxCwdRNd5WwOZ0F2N8VYDNs7
 kKoXgMRQjNkSmbOEw0vx8svKD+1eX6WL9egayGcTvIN4OkULICBehQQxFxGdILY2aF5x
 81XA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU49wD2QWN9XZ/7inIU/aA8gNO49J+JdHGHPURg6iyAd3VUehI3VFcN/+l9U25Ej9lcbB8QRI0doI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUDvDipBOiGdtGLKSjPZMiLjmqmU1xSxqrLi4eAwyKvE0ZRo3W
 VgmdyUJ+yV7sEzP8nwwOaeDWmLH1XpEnYbG51TTsidXP1mvJmAaBTgY7
X-Gm-Gg: AR+sD13R/h9FD2/wgCO5iNgsO9PifK0avVsgsaxc2ZEycBnKKGpmOUinpulWiBbFt75
 UxO8GQSMtMHQnUmU0xsEatuu6Bhq2M+6cUeXw7k6EXbng7IVcqEqyaKl7QUBYVcf5Nnh5IxXfyo
 ymjHOVU2Q7dhKc4Ab2aOJaPGQ8p5kdcT41WgxCnr2TjzEJkEpdFs7nZ3erbgp/+mI2o0lJZa50Q
 w9kC+wJ/UZVPWxuAkSgJvnXm4mSEeDo17yfIMLNR9nHS4CUvvf6GsZ1dpjt39FioTzwhPtsoZF9
 ASpk/I4RS95wZKrt3eHjcNS0HN2gEMnOLQC2IWLqJZGaEOsjhpw1ACBqE0S6BtktaLhf0dG9qPu
 WZCTQ0iWizH8gOQVM9IZgiNTjNADwjE3EO2asUqGZmT4KtPOnfsuThSEbHIPCPAzHVngeCorz/L
 dYZDt6SIGf6Mx3gQc+7kqwXKzss7WqQSp4k73UZLXdbOxzrZgz+vABIwf1wRIuGOqQElBXcNqJg
 LmcpeSdgHgFATxTujh7mkvVUy06YEqhec3UaL4yc0tg4QKi8w8o4xFBEpue69M1xCDlpscGaQ2R
 C+iIS8pBLhZwkSqsBMWPO082b1BA8K90Dr/BDCyFdyes7H6l35im2ybi/39Z8sWyS08Q1GyJzjq
 1qu+MnpuaRCqpreHhI30QYTBT1nF8kYg3BDYTpdisx2nseeJNtvmrxdPXXJvDW8/eCwXjAZo3tR
 LqmA==
X-Received: by 2002:a05:600c:6d03:b0:495:7a23:1eee with SMTP id
 5b1f17b1804b1-4980c674f32mr180465495e9.12.1785773475697; 
 Mon, 03 Aug 2026 09:11:15 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:15 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 02/13] drm/sun4i: vi scaler: Fix coefficient selection
Date: Mon,  3 Aug 2026 18:10:40 +0200
Message-ID: <263a4a41442a3c8b072b170256b72658f1b90802.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

Currently, vertical coefficients are selected based on horizontal
scaling, which is wrong. Additionally, chroma coefficients should be
selected based on format subsampling.

Fix all that.

Fixes: b862a648de3b ("drm/sun4i: Add support for HW scaling to DE2")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index 3dec4eeb1ba2..d4412a62c2f0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -894,20 +894,26 @@ static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
 			     lan3coefftab32_left[offset + i]);
 		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF1(base, i),
 			     lan3coefftab32_right[offset + i]);
+	}
+	offset = sun8i_vi_scaler_coef_index(vstep) *
+			SUN8I_VI_SCALER_COEFF_COUNT;
+	for (i = 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++)
+		regmap_write(map, SUN8I_SCALER_VSU_YVCOEFF(base, i),
+			     lan2coefftab32[offset + i]);
+
+	offset = sun8i_vi_scaler_coef_index(hstep / format->hsub) *
+			SUN8I_VI_SCALER_COEFF_COUNT;
+	for (i = 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++) {
 		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF0(base, i),
 			     ch_left[offset + i]);
 		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF1(base, i),
 			     ch_right[offset + i]);
 	}
-
-	offset = sun8i_vi_scaler_coef_index(hstep) *
+	offset = sun8i_vi_scaler_coef_index(vstep / format->vsub) *
 			SUN8I_VI_SCALER_COEFF_COUNT;
-	for (i = 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++) {
-		regmap_write(map, SUN8I_SCALER_VSU_YVCOEFF(base, i),
-			     lan2coefftab32[offset + i]);
+	for (i = 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++)
 		regmap_write(map, SUN8I_SCALER_VSU_CVCOEFF(base, i),
 			     cy[offset + i]);
-	}
 }
 
 void sun8i_vi_scaler_enable(struct sun8i_layer *layer, bool enable)
-- 
2.43.0

