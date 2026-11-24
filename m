Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E0606A330
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ANBFl1ZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F182010EF01;
	Tue, 24 Nov 2026 07:41:20 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E53510EED1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:41:10 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2f0414c1062so23811125ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795506070; x=1796110870;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZnUOXR4q7AEOdZeeEt7YaH+i+q8V7R+T5wpH12+fNyk=;
 b=ANBFl1ZXOg2qtb41CWcxMUS80Mx8Wew9yfUl2QL6ZkylLYsiWsoXV5SXE5VOVbE25D
 igU6Ysqp2DkQF1UgEQWbT5FXYigbhWcb14UwePRYAN4BB+m9t6s4AKdw0+WnaCwgTC0G
 AAM0RoKhJmpA0s4r+QfF5568v5/ARgOwMxvX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506070; x=1796110870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnUOXR4q7AEOdZeeEt7YaH+i+q8V7R+T5wpH12+fNyk=;
 b=BHlVsbh99R0D+njtvQcU9VwatWXVgPvk79Sxe1LCndM/Cfwf8qQ4Z9jzzY4okmxRZD
 dnbE3ctU5ILP0Ge5A6PnW5EBPzR+SU0cWRdUWa33fHFEPcE3nz7RNfMWTBLP3/o1gYVj
 +lbFxo/Ac9ChPemUrVoAXhjmlQ14be8XBRfOXrhaA7mlwwiXQKCBwk3mmnav21yYRBtd
 g6Rnj+oGp75fJnWd1Ss6HEqjCOx8l2ipFn5btozh6SHWxG9ifLJMwkVHRzGecV4E+4ty
 n/ohTeyvT03mKQWH/aeGEpwRz+819DYw0Coa707L+A5xlVNNhRpz52YqsNFXVAfmOlbT
 Kl1g==
X-Forwarded-Encrypted: i=1;
 AL+hErEpi4WQPGqn0+5RzmKeX8cP8BTxHMKj5apD4VklBGbg0/Z0RnnH/1PJMH/dq9G4FI/dx17P31GlRvE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8IOHXWVVTmh2ZWNXzaYYuZLl+3I3WhHR5ZS88hJVZzzdpv8j2N
 ziJQFPiX6rlN39i6bGCjvyxd90iwjoW8+SwFv6fNyVIBUcRQRYHI3Lxa24mC+ydYTw==
X-Gm-Gg: AZFdTZcLC2TGhmscuxBClXX5UpKecZljQqJLx0ynnW3kEmiWhIilhJqxckHbugwsW06
 do2wLx/XWX7u9cGJUCJ2FSFqTuIM+nxXrs9dSX3JDKjcFLLRzck6cwlWsU9HE9tApXG9YaIIoX6
 OOMTg8leUN+9TS2zbz+HLNyHwSO31pZ3tErM2EnrIPs1BIRUVmRfcAdReRrsZXP67Jq9orSk01/
 0TjrBduLQRjCJ9VgVMbIM1SF8qfLOXlw/qYCHY4kdejmCo/NwPTIRc+pB1QIAPYnPknCL++/eKl
 2UrWXPZqw60agRCjK+kfI54WcGEDo9bSZNPV5cDwkW1RSYkBFLp4dV6eYudZ+tF8HHZgDLr6/Uv
 P6QZg5nUa8QP4jBhmG28XizRLWt9L+6INJBJUdu/C+MDjNWgO7pFUnHBiAMJSOcNX7Pg4EBcOZp
 4RJSoAdXEbltF9ScADjdwYwBxYvNcXTWwAYprJ0mH6aHs5U89/TJVNsY9LVFkjIX1bkVO+gseTy
 ZOk0twM8+6WYVZ/jJNt4M82PSAE2EUff0nqCUiFzFI7oWR+3n5BweCmKiF0Vy2X2ORWuBH2s2Zy
 av26j8kXO05dTg0QG1CqVuc1pQJwNlNZ9ZCtRqJiKt5bIipQc0GmUpbuYIcJ
X-Received: by 2002:a17:903:298c:b0:2e9:5714:6075 with SMTP id
 d9443c01a7336-2f03f117c82mr126158455ad.17.1795506070067; 
 Mon, 23 Nov 2026 23:41:10 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2f04f6049dfsm55300615ad.19.2026.11.23.23.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:41:09 -0800 (PST)
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
Subject: [PATCH RFT v3 3/5] drm/sun4i: layers: Fix VI buffer address for
 clipped offsets
Date: Tue, 24 Nov 2026 15:39:31 +0800
Message-ID: <20261124074041.115251-4-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index f9c7f28f9fa2..67cce1b0e70f 100644
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
index 4d3fc03f9877..b6796416d550 100644
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
2.56.1.809.ga0b61035b5-goog

