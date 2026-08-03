Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31A4C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0732610E703;
	Mon,  3 Aug 2026 16:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sUIn5a2I";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD9010E70A
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:20 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so12695615e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773478; x=1786378278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R8mU3xQ3VaqFI9TKErwKoPI9PJbEs0xdMOgJUVHqdkY=;
 b=sUIn5a2ITovosaz9cIR4xQe/rQi53rdAR50eddRoJVYHuLAlodejPHxs1szvb+JxJD
 QiGRkUGgwO4mrdoh0Jk9zVNkmJaB0I+PZPi3N3u7l2FbDdYwOItN4c0QpdT7vOpFZbrC
 lBMekLt3WzLdVWv8Dmscaz6npfjeSqkku6s4gIrde7Es5XRHxHpkfElDUmAzTX/+5/Q/
 GIZ6WNH72S6g61JfKeDxXj+AdnWdHVu+inbBIm+Y4KYR7ymqLLvbKwInY2/fqneg1kbm
 3Am7XzzJh4BUabwa2mqTkur1hzwh3c/qtG8L7blkWDq+vEvs5xWy05jSgoE2eCQtSjiE
 6Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773478; x=1786378278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R8mU3xQ3VaqFI9TKErwKoPI9PJbEs0xdMOgJUVHqdkY=;
 b=Fqlg2+N+FJb/s8XsQ9ibITChhvm3xZwBRe00+wR81ESWP8l3nRJlrDAaDfm7mrGGr8
 1+NI5X6tX9pOjapmCn1u7549sCKclzsl0SwCnASe9x7WsjWEQ/APSZ9pWXDzmlGVVTnZ
 pgMlBVzO+2bfgiopx78TE9LvEVe0vFhgVydjnvvRdREZ/8EDldjMj5TbeFJZeZDD9Lla
 LL/MMXm65hA/DvNTMTW2DE14IOU5xqyAGOrDeVOVq80NSjTbP9Vm4oGvCNGpXr05TZ9S
 MzBgvFdCT+ssRSmObpXGpUbvV0kft30uh5mv/VbXjURX3VDRKzsUca9ESekBrQgFg5mn
 kB3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RriRTdlfOEfjuBloCuiswg7msnD/2RD+xrstIo0zeEt2wZL2IoY8YX0QbhyzlTmZTpmVZmmNN83rNQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYn4MVRJPxe2ADk9aPR9PhF8u7D9pllU8ookwKAMYtjQJXsVKy
 aC+Ho/b/vZLfAIeyJLdEF305heiAvTEsOP2UWVwBVfkgBsVcWTE3Ecy8
X-Gm-Gg: AR+sD132xdSk5sfC6oM9fV771yTlHNCa4rX8WW8ES5Nezj6J7ySRyrjG5/uyOF7RWdP
 PT6RY+AVgzqn4iYArBWDWslRfqi1dcq9AuTOamGZlyQ4H8Hs0zdKbw1XqeZcqfzfPorRHeieSJc
 o6rnjDe5z0Cxz+Fd6vvVdMuac+fT6ac5weygLmscLYMrRAmEPu4GqmfArR7dsiTT0zYIIb7M3Nr
 +G1hNvG1kC+rrMSnK7HclMXYDuu/L8+3uZZAGJaiIN5xf5csOpc855jGlU5n7IlXWOxS6bHYV5J
 4GT2BvmnrbOaFBnDXFVG21DU+uaLHvnKHglH2AVAVcxUMNj58zcJNIfprbkzKwbM169nnxH+6a9
 U0IcLxs2WXo5ipjfavoZj4bvdey4jl3/PjQCqV8Tu2nPbxt+YBILIbN+beJnTQ5X6gyFqDKUenr
 1L7X8fvKxAght4gpeEXFQxoGPJpgxptbQwiTB2mYySol084i/RwOLbBYGvlMYp7NghNIOlqhoiw
 iyglZWhWvQGJuiquCnqgYCSZIrZIBBuFivy4yJINgAcwNqwKBI43aRkq94XYQv8R/USaTfspPms
 l3q/nLduDlcKr/rCLZB6bbzNqIEQjAKP1WRbpy9JtY3kNBzDtukiuG9MXR0woyFuzEzZ31xt8jv
 qFvWi9gWC0YqbYBt7yvOoPEbBu+6ywVqHdzHta0hksWxlWtV8VakPc+pY0vCSSMxBJqqM4KnPO1
 BT5g==
X-Received: by 2002:a05:600c:8b43:b0:496:c93d:35d9 with SMTP id
 5b1f17b1804b1-4980c66b45emr202147415e9.6.1785773478485; 
 Mon, 03 Aug 2026 09:11:18 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:18 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 03/13] drm/sun4i: vi scaler: Restore opaque alpha in video
 modes
Date: Mon,  3 Aug 2026 18:10:41 +0200
Message-ID: <c48ba85b9e4478d51afde4f36839fd1c1d363b23.1785772659.git.jernej.skrabec@gmail.com>
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

The DE3 mixer initialization clears the entire mixer register space. This
also clears VSU_GLOBAL_ALPHA, despite its hardware reset value being 0xff.

The VI scaler uses Video Normal mode for subsampled YUV formats. In this
mode, VSU_GLOBAL_ALPHA provides the scaler output alpha. Leaving the
register at zero causes the scaler to produce fully transparent output.

Set VSU_GLOBAL_ALPHA to 0xff whenever configuring a DE3 or newer VI
scaler. The register is ignored in UI scaling mode.

Fixes: c50519e6db4d ("drm/sun4i: Add basic support for DE3")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 2 ++
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index d4412a62c2f0..a5cc99981006 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -975,6 +975,8 @@ void sun8i_vi_scaler_setup(struct sun8i_layer *layer,
 
 		regmap_write(layer->regs,
 			     SUN50I_SCALER_VSU_SCALE_MODE(base), val);
+		regmap_write(layer->regs,
+			     SUN50I_SCALER_VSU_GLB_ALPHA(base), 0xff);
 	}
 
 	regmap_write(layer->regs,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
index 245fe2f431c3..d89c0cbe188d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -36,6 +36,7 @@
 #define SUN50I_SCALER_VSU_EDSCL_CTRL(base)		((base) + 0x28)
 #define SUN50I_SCALER_VSU_ANGLE_THR(base)		((base) + 0x2c)
 #define SUN8I_SCALER_VSU_OUTSIZE(base)		((base) + 0x40)
+#define SUN50I_SCALER_VSU_GLB_ALPHA(base)	((base) + 0x44)
 #define SUN8I_SCALER_VSU_YINSIZE(base)		((base) + 0x80)
 #define SUN8I_SCALER_VSU_YHSTEP(base)		((base) + 0x88)
 #define SUN8I_SCALER_VSU_YVSTEP(base)		((base) + 0x8c)
-- 
2.43.0

