Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAA606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QQiKhDCO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615EA112098;
	Thu, 26 Nov 2026 07:13:48 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7641310FD2C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:13:42 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso2767620a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795677222; x=1796282022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQV4QP0qYKuYxZ6jnr2bO2k6G5yVFMpzRyKHmSwnLAg=;
 b=QQiKhDCOqMPS6UuZGdsNYWYbIqD/bfRXOJZ1dCCF8wWDGcn+K/2rZT0E7bk9DwTo2D
 h4kd6tK66IZxL4JDz4vGxKooPXbw7lWxuYjG8z54ThrMmMEZY1kYBjQMT0S4Cku2uEl8
 2aYvzGROr8eIcPSCcnwGs4ldTxY53fLaGlyQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677222; x=1796282022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQV4QP0qYKuYxZ6jnr2bO2k6G5yVFMpzRyKHmSwnLAg=;
 b=GbNX9kLLfI8pmJ5fVi8XFmkZE+U7Hlt464szVXvmQP/84NIGT5r/wpyVG9pe9sHXKQ
 y2J1GK5R0/SXJQDGPrrgkEUFy37g7WI2R/FhJjhaGvpcAS4UJTXKc2fKpKdtPQh8vuYM
 cVcLgPPZUnqjXAXe4ZxGnN6zXHk/4+ZzJVGSARpso+ejcQTHD7SNJs976O7/MxYg0TxB
 Ns1AXLFghlUFEVo1K57+8wxEpa5iEofywTX9+tcM8djquBcG7JPjM+fdIt77V2vP4exp
 PVILFBWhQmY4Jp4mGhkd9o/y9FnExXKfmMykQVYCZzeyUtcMzf6euK0skrYsfljVssWC
 W+OA==
X-Forwarded-Encrypted: i=1;
 AL+hErEPflsXbC3YkOwmBi1bJslEgVWaP1q+BwARQbeIsQhCbR0OlAd87tfx3Q1jZ2dXPIU3WsodUbhOtlM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Lp8xTtdN3pkXb6dJBAigAY41ihVHtQKpdgyXmnGDANlLchWiv
 +Bc/eba4QwX59xhInmENZ+vScCL6YWJrQILvvHKMV/0k9jp5/u8PzrEaTqOqnczpCQ==
X-Gm-Gg: AZFdTZehwy29TdWvzWhzWIQSYUDTMyHTebzSPbpTuLKmxsUI5AA/r7oqTir7SJCYVhX
 JZ9Jq3q6dC9NwckuKTUyaagCTv408R05hFqqA2S6K0VO1lzj4AhNl8Dh4Aims1ZTLtvNH6VfAe+
 BwS0utjVUMEYEeRZ2Wl78KOuApf9vZHh59EwexfZSYMrsGp6Wb9HFrGPPo+dU51+HTXZJ7q8W7R
 n7bf8oifxgdbC2U6GhqWhkwwZBnP6rScuJmuTGyC1oeZiuoJ23Zr1f94V7SzsV9A8dAwxu8wwKc
 WqM5gHjhWqepm4N6v8i/OwNPonR1zPfq1d7goFX3NuWvbeCUk7N3Wne2wvhdWfq0UWzHSRKDa0s
 Y3bdOJKaSAop4pufdwFJiRCTX7VJfmwrImaYsgaMGCLAtFJq+lAMS2PRYZbSfqeLIqZ4c5Xuhhu
 qc9YkxLywbfQtjBnSrnGjMeINGwmLXVHhBW6lrUur/7RTpYFrCVai9MrtmnHgxq5NGu9ZVlnbeO
 uY25ObO/v9wjBgNHcrZ71xQPeHmtK5DxiId/mOBOnG1ZiynCQFCceMNPq0aTnpFGugfil5JucoS
 WnqRCMHDL11+/z6ekj2bQozLuKJ0myiFZuGjISG/0mUdNoXdv6JPiFMA83qBGcXszNjlLzgADof
 HpS4/cA==
X-Received: by 2002:a17:90b:4b0e:b0:3b1:8380:a9a0 with SMTP id
 98e67ed59e1d1-3b41c95c18dmr20709401a91.46.1795677221915; 
 Wed, 25 Nov 2026 23:13:41 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3b41ad0b52dsm33777492a91.5.2026.11.25.23.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:13:41 -0800 (PST)
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
 stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH RFT v4 3/5] drm/sun4i: layers: Fix VI buffer address for
 clipped offsets
Date: Thu, 26 Nov 2026 15:12:51 +0800
Message-ID: <20261126071314.253890-4-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126071314.253890-1-wenst@chromium.org>
References: <20261126071314.253890-1-wenst@chromium.org>
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
Cc: stable@vger.kernel.org # v7.1+, needs drm_fb_dma_get_gem_clipped_addr()
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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
2.56.1.839.g22a8290db9-goog

