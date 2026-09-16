Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1650C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2E810E0ED;
	Wed, 16 Sep 2026 03:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDiwc5MR";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F31310E0ED
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:33:49 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so312667a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789529629; x=1790134429;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B3+7MkmB6aG1HjinH/gRhRGDcVk6ogklV5sjoZ/OmL4=;
 b=ZDiwc5MRQhHWKzL1XCWTy7GYiOkA2D5vXS0fJ3c7M5NvdgH7TXrjneFStTTOQ32Nee
 Hm0Q+ylZEZ7pr7d7s7xQHpHIgz0cQHY9y3g5jzJcEKuEXkCMNE3sGj2+0Jp/bGVbP0ZN
 XdqzYYrSVbNe4EwrzreFZ4ZqE8Y9p9Ux8DmC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789529629; x=1790134429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B3+7MkmB6aG1HjinH/gRhRGDcVk6ogklV5sjoZ/OmL4=;
 b=yKxulG4Po/0XYIIl0IjQVrTskMRze41XpU8A70q9qQplmMrRhAnr/ULTGbpIRwWngf
 MDQvJzzcscRPI1wW5iGKcnYblzCif15i2rGrRsNVRdK3cUKJC0XsGAFqSS2mHpYmO/bo
 6pTuxZ5jD+74KsZ51Fe5xPIDaIQ/syyYdzL2LJZaoaqgmhO5pVT8Or1aTcGyEbV/RrW2
 rSvJAxVimSAvsq1T+ivlZEjHWwU3Yru4DFaBVu8hf6UKpEHWNdbcX/kwovZAg8BNA/1S
 OQ5mVAwaiw1NMDWR6s8PhVrUG3KbsTrqqj6rIZaVUdJ8Q5oJGDm40CBhwU2OD6uz6Z4E
 a8bg==
X-Forwarded-Encrypted: i=1;
 AKwUvByFj+WCDbA9tbw3Nb6PB150xtKMrWIkUQhKCD7hmo65UJYRU9zEcaV1Nc7Ne8aPJup2Aw90G5uEyQo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkXgMDkFpCLqjrGWiLL+LdLx8VJsjJx+gfbLgnDN4VgKnY9sj3
 iGOZC65cqOHOqqUtoz71grJt6xq5XQKLQYVNLgpWhhSN4zbLD1BA8PU3kHrre90VbHByLE7VyYH
 NOEU=
X-Gm-Gg: AYBFou1aSpb0YG3xHA/L4RUBfnp3sTkuJra3utMdhTYorFIdrgh8AJBc+UJY+Y54NLh
 G8qx16c3XwFrZ9vZbW9rvcmvZutr5gZlCzHF6Wdxzkq8FyQx9bX70mTGrDIxv+Lqsq4zvISf9bp
 rET1XZ+FMdTv8Lk2GPnNpPvp7oEbRk7ovxij6duKfrd327J2IN4+Q3+5FWHEoHKxcErhvCYtz6v
 fkwNWd0Y1t1o1Mq0qriJkxcOQWJ2B0aYL3B0mdDVtLAryWQYgeYGSdx2QQxc4PiHNRSTIg8iNfF
 B9id97FFM1fL0G2nKQ0Qq84hfq2Io78A3ej/rBUvc9Vi2B5/5S5RFiMJoRsQ7Fuwf4XVh7Bo75n
 w9Wqlyp4B6WZWSkQ49vPcWPNA9irwWiE3H/FXHdgxBDNzA3jGAHC6zIgsXPDOzrC6maaZl7n6xr
 JDhK5WIRFh0eebf1yuBeHw/9FyCIK7KipPLKCTktgdsv7EyBdsQYwYAkLcBUqYOCKbRWvfHwFMe
 f1BPIno12k7EgnH50h9BjTBqLnEQYjyQ8HMX2jXbQkiwU6ZXcvcEC9/Yg==
X-Received: by 2002:a17:90b:3b41:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-39e1e48a416mr2215669a91.15.1789529629173; 
 Tue, 15 Sep 2026 20:33:49 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 20:33:48 -0700 (PDT)
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
Subject: [PATCH RFT v2 3/5] drm/sun4i: layers: Fix VI buffer address for
 clipped offsets
Date: Wed, 16 Sep 2026 11:33:24 +0800
Message-ID: <20260916033327.3054126-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916033327.3054126-1-wenst@chromium.org>
References: <20260916033327.3054126-1-wenst@chromium.org>
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
2.55.0.1032.g73a4cd73de-goog

