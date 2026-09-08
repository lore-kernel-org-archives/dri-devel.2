Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A70C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9674210E0D4;
	Tue,  8 Sep 2026 09:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="evteExj4";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2AD10E0D4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:08:03 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ceb47d53so192088a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788858483; x=1789463283;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2nbiAaHsEOkyMIOSUPLzzSXJU25j/HCglaTjq/uSdS0=;
 b=evteExj4Rw2V/9K3meGb3ytSiYMPz07kgnmO5DhJNy0GVY2TAIUGH74lraWHtGcRnM
 7oS2f3HI2rcOHwmn+rq3nqaboCl41qGS/59u8B4nqlzTLhymOBLST819/coUdZxxVs2A
 qVJCM7iSQadiCJY9oWypF4HJ+XHpkEn7mLYAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858483; x=1789463283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2nbiAaHsEOkyMIOSUPLzzSXJU25j/HCglaTjq/uSdS0=;
 b=Pv+gi2DgD1kaQ54JEe3/WbDNAX58jz8Khraj6C4gG+dPpDKt7wwzfpG8HpJxZ86pEv
 yAC9uw7ZxRPWol8DoXlQonAZ5BGdRz78Zl5rWGF4jLBZIZB1J6AwOezcetV2UYDKRI89
 pXMk16/6p/ZeIeZYQ46LM/Ng6WCjWCMcmub50cd4JO4akbDSKBiqUbx6vKj/c/P+9UDt
 dck1Uo4fTe7Yx03bDST0zwLFXi2LULUMHhiELZ1W0gXLDp7VZyUq49mOPoXe3NZ1gZXF
 fMvjbuukXKQFyPCQHUhXuYocKLY4M6DxykxGGpUcpSnvKJ6Wx/UFEqpxLP35+7ErHMcp
 tShg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj0nInz+DDH8WlrkhQxDRpJ2gFxteesheN1HAt1auEGq0ErwKvx9b7wVz7+Iwccrr/Sbv6EOxoTK8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0+AEDOmKT8prGgenQ6gAup63UEw5aI9x9zqeKWDxeP2RJGi+O
 JBOcc9wYmjawF+R87p41L2Qh0yUmMoZczklRSjMh81vmp7Qhz71ryhtliRSQ3mUEKw==
X-Gm-Gg: AYBFou2ndXZ0vg+L12n6psFCSfoZBZglSntQ9NQEZkRbRrf8cJHOp4zjUShlNBJpuxH
 cHDeSpLOgjq2FFMoErl1B/gN0lW4zbrGw5rHrqUJvmWuoiAtmzi1sZJrfaegqlnJwqxwBndxwif
 ZB0VA8V1Y2nqSbQSYV7mMcimvw5CewSDyc9dPVDeK13IN1zYfOnuq9Qd7q6DQ+MPFsoxr/LOMsP
 GHJuGZXWi2ZaeEtd+3Si9bgQhkmyWyxtmubImGh3WFv9QuhD0CfE8IVARPE/cKTCFF20sbI4ITX
 eB1A0fURJ6SAJ452La2+LOuZIbtgBdJ4co4VypLPK6ZFm4NNLlkwpLVjX0U5BU4eAn+J0xPQdcl
 hVmDK9c2I+fygF4HShrGJfxjzGaDFa5APqmiLarXNpRp4g6lAel7RnjuVP3M1qHtBp375l4vuVx
 JRn0tIckcP2dtwSbGWnziex425jzqDlPt2jsUOZ9h8hSnjOVij6qa4+Y2FnCQMKlqehNLRVH3NL
 qbFJpwU6+6wvgciCnWX2QwIAUNcAdHFOVaI8gPRfusRV0s=
X-Received: by 2002:a17:90a:d010:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-39b8be7a13dmr4691886a91.10.1788858483369; 
 Tue, 08 Sep 2026 02:08:03 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:08:02 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH 2/4] drm/sun4i: layers: Fix VI buffer address for clipped
 offsets
Date: Tue,  8 Sep 2026 17:07:41 +0800
Message-ID: <20260908090745.1089143-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908090745.1089143-1-wenst@chromium.org>
References: <20260908090745.1089143-1-wenst@chromium.org>
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

Commit 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
get display memory") dropped the code to calculate the framebuffer's DMA
address in favor of drm_fb_dma_get_gem_addr().

This turned out to be wrong in a couple ways. The hardware is programmed
with clipped dimensions, so it needs the buffer address to start at the
clipped boundary. Moving to the helper negated the clipping. Also, when
clipping on the left, the buffer address needs to start at the first
pixel in the sub-sampling group even for the luma plane. The hardware
handles the interpolation internally.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary. Calculate the intra-group
offset and adjust the luma plane buffer address so that it points to the
start of the sub-sampling group.

Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memory")
Cc: <stable@vger.kernel.org> # v7.1+, needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is an alternative to Jernej's original revert:
https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com/
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index bad102134726..530efae7e13c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -130,7 +130,7 @@ static void sun8i_ui_layer_update_buffer(struct sun8i_layer *layer,
 	ch_base = sun8i_channel_base(layer);
 
 	/* Get the start of the displayed memory */
-	dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 2e9cda45c04e..7a1d5f1db037 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -205,7 +205,21 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 
 	for (i = 0; i < format->num_planes; i++) {
 		/* Get the start of the displayed memory */
-		dma_addr = drm_fb_dma_get_gem_addr(fb, state, i);
+		dma_addr = drm_fb_dma_get_gem_clipped_addr(fb, state, i);
+
+		/*
+		 * The mixer can handle odd offsets into sub-sampled YUV
+		 * planes, but needs the address of the first pixel in each
+		 * sub-sampled block. Adjust the luma buffer address backwards.
+		 */
+		if (i == 0) {
+			u32 x_diff, y_diff;
+
+			x_diff = (state->src.x1 >> 16) & (format->hsub - 1);
+			y_diff = (state->src.y1 >> 16) & (format->vsub - 1);
+			dma_addr -= y_diff * fb->pitches[i];
+			dma_addr -= x_diff * format->cpp[i];
+		}
 
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
-- 
2.55.0.979.g7e5102b832-goog

