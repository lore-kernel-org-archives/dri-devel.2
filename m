Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0246FC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0725E10E3BC;
	Fri,  7 Aug 2026 11:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l4RLp1LN";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F5D10E3BC
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 11:47:02 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so2968438b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786103222; x=1786708022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZhwYEHM2ubRYoBgnMQxxPYmFjqJ2ATlRS0+mstcmx4Q=;
 b=l4RLp1LNzvCzVwOgixJXzoaS9kDD5CQ6CikQUe1rpsJs4MSaixKdzHjaSXbMhOvhEU
 ihjrJUNXeyzqY7Xqum5lTO6xyZurcUVq+g4Mwe0BgeXsq27anmThNEY/oDaO+yvqVLFT
 XQJosKg0FY3ja01wMioFB2DkDdrNSqlgsmktU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786103222; x=1786708022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZhwYEHM2ubRYoBgnMQxxPYmFjqJ2ATlRS0+mstcmx4Q=;
 b=Tpxk9zdvnscrgnMZTekpcbA+usdU6WGyPkehFIbsQkoBtIREISCmoh+LbJcLP78EWl
 BdX0A7NudMmw12yKmnhq63mHfyl4Rth1hZlq3da7/SFwD7yZJ8r5GiDHqEhIy8Ndu0Vz
 h/SB0V6MyixpdeifZ6pCAXZfTMcSJjbnBR1diQw4esZkaS0Qk0fzV+eLq1Xao1r2oghk
 Fm6r2ZhmaJ/yKxjjyhHO5CD9zvLStaMIQhOJH0N+Dm03i45vF0INYBJXL5Si8s8nCzte
 GeR2bsdeq2B/Zc31kcpHU6I1oaxdGFT2YyJVLVd9FtKyRdOoBelRndHN2U4eSgqxpx99
 YZbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7qNI3BqGHxs2o+h+kmyWDlQpPBmGbCCiFC3PqibFVXV6S4mF8lWn3FhwZHyIfCHMbdjWRiIvqQ0M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyyd21B03+3Oq91vwIn4B7Jkq9TXQi/csiN9ZmGMg5PSVdTOJEM
 /ZPuECb34+2HqMtYGcmIBhV6S2s5l9Gv89Xg5XoiekRI0hsmIZgJCjERghNqfcrtDg==
X-Gm-Gg: AR+sD10m59kfmX3y97S8LVJQ1tbiR64OW/K2kGy65Sfdkhm2RhOUJiRPmv3eMaA1gXq
 79MEgT4VBG5I1Uk7+jqZJAEzFdL5KJllbGo1KcRIldrIytu+cWcyKYGx1sj1ybuxl7Y2bgdWNTH
 AkGFU+5ER7LSkKscI2RcK9qW7IqIYVyvP085rv0M8rcq9E5tJ9GhmLi+ycgrspnNPPDdqpvz4uS
 SjtVoBfrlY4EKXQFiqFo2NRGwzmn7SVtbH4C1a/o47rOP30+99r3XQ4Hplsi8nIYBmcrvoscEe6
 D92KYbDJlb++lnFpY82Gt7bT5GfSRRTZXEc/aF0e+FCGkB6KmzWoJr67qf1mlwiFXJZR5V156qc
 YpV6sHCUBpj3h+X2+3TW0Lb09Lhs4mDM26gL744lZTO6bjvDPwjXNftQ3nj6cCy2sDWF+AvEglP
 yofP6f0ESKUj82M+rEH+lAYYjk7o9GsbgNU912W3NdmSw+zWKqFqn+LP+CcA8g4GXkIATwGxHWp
 OECbxFTPgpj9+9oQo8OJqVVQdYTTtR4zuUOkgYtikNwyA==
X-Received: by 2002:a05:6a00:b90:b0:848:6447:e09c with SMTP id
 d2e1a72fcca58-84f2e152a10mr21860852b3a.39.1786103221911; 
 Fri, 07 Aug 2026 04:47:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3622:c86b:3bef:6958])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f38839esm607634a12.29.2026.08.07.04.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:47:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2] drm/verisilicon: Switch to drm_fb_dma_get_addr() for
 framebuffer addresses
Date: Fri,  7 Aug 2026 19:46:53 +0800
Message-ID: <20260807114654.1373305-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
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

The verisilicon driver has a custom framebuffer address calculating
helper that the common drm_fb_dma_get_addr() can substitute.

Differences from drm_fb_dma_get_addr():

- Uses drm_format_info_min_pitch() to calculate the horizontal offset;
  however the driver does not support any of the blocked formats, so
  this just ends up being the same as in drm_fb_dma_get_addr():
  "cpp[plane] * y"

- Uses clipped source coordinates instead of non-clipped coordinates
  as in drm_fb_dma_get_addr();

  For the primary plane this doesn't matter, since the primary plane
  must match the output, i.e. it cannot be clipped. Also this driver
  doesn't support scaling.

  For the cursor plane this seems wrong, as the clipping seems to be
  done by the hardware, and thus the buffer address should be unclipped.

As such, it should be fine to use the common helper and drop the custom
code.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Fixed compile issues

This is only compile tested. I do not have the hardware.
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  4 +++-
 drivers/gpu/drm/verisilicon/vs_plane.c        | 20 -------------------
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  7 ++++++-
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index fa4f601dd0c8..59778433ae84 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -12,6 +12,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -176,7 +177,8 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 		break;
 	}
 
-	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
+	/* hardware handles clipping as seen below */
+	dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
 
 	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
 		     lower_32_bits(dma_addr));
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
index d81f7b8f4c65..38b8b536eccb 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -107,26 +107,6 @@ int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format)
 	return 0;
 }
 
-dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
-			      const struct drm_rect *src_rect)
-{
-	struct drm_gem_dma_object *gem;
-	dma_addr_t dma_addr;
-
-	/* Get the physical address of the buffer in memory */
-	gem = drm_fb_dma_get_gem_obj(fb, 0);
-
-	/* Compute the start of the displayed memory */
-	dma_addr = gem->dma_addr + fb->offsets[0];
-
-	/* Fixup framebuffer address for src coordinates */
-	dma_addr += drm_format_info_min_pitch(fb->format, 0,
-					      src_rect->x1 >> 16);
-	dma_addr += (src_rect->y1 >> 16) * fb->pitches[0];
-
-	return dma_addr;
-}
-
 struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct vs_plane_state *vs_state, *vs_state_old;
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 1f2be41ae496..2750016a7f2c 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -126,7 +127,11 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
 			   vs_state->format.uv_swizzle);
 
-	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
+	/*
+	 * Primary plane cannot be moved, no clipping is involved,
+	 * so the non-clipped framebuffer address can be used.
+	 */
+	dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
 
 	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
 		     lower_32_bits(dma_addr));
-- 
2.55.0.654.g21b8a5bc05-goog

