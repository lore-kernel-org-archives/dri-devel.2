Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48731CD37B2
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AE210E0ED;
	Sat,  9 May 2026 19:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjyOy2n6";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D40B10E0ED
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:26 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so1711214f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353225; x=1778958025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CrDBvKu/hcgSB1anyD1GXBKe06ZzlWC9+3i2f9q0bQ=;
 b=MjyOy2n686MsVDPyOYVcxEZjrlbt8/3wJf7GRX0itetERSwMK4UtlwdoASPb90H3yz
 875Ls/fqGfJ2T+EcnU9vSm1zCVATpWlSqOCW9CQ+oOga78PtGc8M3yPAtB1frpVryq1W
 Rb8XAtaXKeo5sFXYU1zVHcoBPyXwHB2sNf4+ZpRPremJxt9fbcr8QdyPLT6HOxvu/DHa
 0q00j5DF+K+ikfUow0xx95mHKEszWh+bYGy/6wPky1vGKRuwGrPrhTdU1AAhP6VOg2ss
 GLn43T9CqmSeyXdxyu/KI/nOHX+BfRQhKKPnW8ilBF7Nbr/YdWQ4WuPWxqlkkACPKfrS
 G3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353225; x=1778958025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+CrDBvKu/hcgSB1anyD1GXBKe06ZzlWC9+3i2f9q0bQ=;
 b=s/SZi+zYJj2Ko9ZnRlk+dLIp8dvGX9ZDVHi0Cg2+aiFKfB1XXlTaq9jUDyu9x91ZJ+
 khjRpV4uRgq43EKgOHP4+5/0u1UDpkfMwGuCJe+DRhSEJEebZPnZXhupG1kiTyrS+h75
 S3MP1OoiF8cvxyDPuSv9i9QcZFETwiYRedn0YgPxNQfri3hosCmsH/LvKdPcSSFD/NN8
 O9O+xcNVhDnqEhdNCmvXa0Yb6j0+cwY4UsvcZLqpotGikAoQ25dayXo77ZfRg7ZnX8BW
 I2p9lz54ecmc1/3gQIaGZhnHKYOA4gqFM/eCSIxDyVhlEfH5wSVOlxKzLTnWNqy+JuEW
 o13g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3XtUVIyF39LAnDBhEH/VfMa2GOE7++t2S4vbBIkmUDtGohLfe4Ixfi6WH3I8OJRJPoZ8w2/TnfZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqcVvVutZRYwxI/Rw6GgdDv/PWr9SJeX1g7yjuUkskm7wCzDTu
 TutXuTR9r83oxB5C+978U0X8o+PehazoWU41NFMbuzSNON2vKMJKIeZT
X-Gm-Gg: Acq92OFufhDyfdmzoSygokCzgYclvvSWjhXvGYYoc7NuaO5BCeVOMWgttuE4ov6Dqwn
 iAx0UFt42ntXOQJAB9aFE8ZzabBQfOAhcvZbSzO9GxnV18dWBMiiR6ZQk5JbofRRxCotmhInayW
 P54+Bqh2ceimAfzMNWQuH+hQEc1ZePdRGYG48PmBnriaG4sA1j6vhublBtwf9DIk1DHNxjTpJyt
 JeKgT4DGfD6FAKt1N253c4S6R8qKD8Ro++JPjdgb+aK+kGbGEGGKCzqoHrw1nnje+fD2VTsm1RR
 IQZ68AMEOtage/VDRbAttJXx9ZRO86MMrbXIMR5jvBZoP1tlg6Lzzo2EqsrePspTVkTxVI/JzYo
 tyHwsYCXTix5hlsdwqRKNjOavp8k3z56efJdS2BcfNWG48EmlCcG5jPDYUR5UKOGufNm8UaP5Ms
 xERGnYeKSv4zCGJTLl/oKe282f+oYXEgHH2F6/HqkVDT2JOYt7rQqLEj5niCyTYJm7+G0=
X-Received: by 2002:a05:6000:2910:b0:44d:821:1a0b with SMTP id
 ffacd0b85a97d-4515d3dc326mr27958440f8f.29.1778353224452; 
 Sat, 09 May 2026 12:00:24 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:24 -0700 (PDT)
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
Subject: [PATCH v2 3/8] drm/sun4i: Add support for DE33 CSC
Date: Sat,  9 May 2026 21:00:10 +0200
Message-ID: <20260509190015.79086-4-jernej.skrabec@siol.net>
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

DE33 has channel CSC units (for each plane separately) so pipeline can
be configured to output in desired colorspace.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- collected tag

 drivers/gpu/drm/sun4i/sun8i_csc.c | 71 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_csc.h |  5 +++
 2 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index ce81c12f511d..70fc9b017d17 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -205,6 +205,72 @@ static void sun8i_de3_ccsc_setup(struct regmap *map, int layer,
 			   mask, val);
 }
 
+/* extract constant from high word and invert sign if necessary */
+static u32 sun8i_de33_ccsc_get_constant(u32 value)
+{
+	value >>= 16;
+
+	if (value & BIT(15))
+		return 0x400 - (value & 0x3ff);
+
+	return value;
+}
+
+static void sun8i_de33_convert_table(const u32 *src, u32 *dst)
+{
+	dst[0] = sun8i_de33_ccsc_get_constant(src[3]);
+	dst[1] = sun8i_de33_ccsc_get_constant(src[7]);
+	dst[2] = sun8i_de33_ccsc_get_constant(src[11]);
+	memcpy(&dst[3], src, sizeof(u32) * 12);
+	dst[6] &= 0xffff;
+	dst[10] &= 0xffff;
+	dst[14] &= 0xffff;
+}
+
+static void sun8i_de33_ccsc_setup(struct regmap *map, int layer,
+				  enum sun8i_csc_mode mode,
+				  enum drm_color_encoding encoding,
+				  enum drm_color_range range)
+{
+	u32 addr, val, base, csc[15];
+	const u32 *table;
+	int i;
+
+	table = yuv2rgb_de3[range][encoding];
+	base = DE33_CCSC_BASE + layer * DE33_CH_SIZE;
+
+	switch (mode) {
+	case SUN8I_CSC_MODE_OFF:
+		val = 0;
+		break;
+	case SUN8I_CSC_MODE_YUV2RGB:
+		val = SUN8I_CSC_CTRL_EN;
+		sun8i_de33_convert_table(table, csc);
+		regmap_bulk_write(map, SUN50I_CSC_COEFF(base, 0), csc, 15);
+		break;
+	case SUN8I_CSC_MODE_YVU2RGB:
+		val = SUN8I_CSC_CTRL_EN;
+		sun8i_de33_convert_table(table, csc);
+		for (i = 0; i < 15; i++) {
+			addr = SUN50I_CSC_COEFF(base, i);
+			if (i > 3) {
+				if (((i - 3) & 3) == 1)
+					addr = SUN50I_CSC_COEFF(base, i + 1);
+				else if (((i - 3) & 3) == 2)
+					addr = SUN50I_CSC_COEFF(base, i - 1);
+			}
+			regmap_write(map, addr, csc[i]);
+		}
+		break;
+	default:
+		val = 0;
+		DRM_WARN("Wrong CSC mode specified.\n");
+		return;
+	}
+
+	regmap_write(map, SUN8I_CSC_CTRL(base), val);
+}
+
 static u32 sun8i_csc_get_mode(struct drm_plane_state *state)
 {
 	const struct drm_format_info *format;
@@ -238,6 +304,11 @@ void sun8i_csc_config(struct sun8i_layer *layer,
 				     mode, state->color_encoding,
 				     state->color_range);
 		return;
+	} else if (layer->cfg->de_type == SUN8I_MIXER_DE33) {
+		sun8i_de33_ccsc_setup(layer->regs, layer->channel,
+				      mode, state->color_encoding,
+				      state->color_range);
+		return;
 	}
 
 	base = ccsc_base[layer->cfg->ccsc][layer->channel];
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index 2a4b79599610..d2ba5f8611aa 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -18,9 +18,14 @@ struct sun8i_layer;
 #define CCSC10_OFFSET 0xA0000
 #define CCSC11_OFFSET 0xF0000
 
+#define DE33_CCSC_BASE 0x800
+
 #define SUN8I_CSC_CTRL(base)		((base) + 0x0)
 #define SUN8I_CSC_COEFF(base, i)	((base) + 0x10 + 4 * (i))
 
+#define SUN50I_CSC_COEFF(base, i)	((base) + 0x04 + 4 * (i))
+#define SUN50I_CSC_ALPHA(base)		((base) + 0x40)
+
 #define SUN8I_CSC_CTRL_EN		BIT(0)
 
 void sun8i_csc_config(struct sun8i_layer *layer,
-- 
2.54.0

