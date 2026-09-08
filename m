Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17448C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E2910E9AF;
	Tue,  8 Sep 2026 05:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ea0ngCsT";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F05310E9AF
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 05:02:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so3925337a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788843761; x=1789448561;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q5Plj4uGj3BvxxxoyuAGWT0KJk9RqOTiZJAPsoPxBFY=;
 b=Ea0ngCsTSBM8FD934uB3pu2V8GGOU277I9LvnrjXmr3N1lQ+yqgKju8TyluXkRFgWD
 07ka3peLZZJCGySI+61KyOFpoekK/HaVJuwafvcUyPh0mA52OVpyFWKaC8OHSFaBXdH6
 BPVcRUN+Vk4HFVwpnkRtFutbq/UjJKTO1VIEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788843761; x=1789448561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q5Plj4uGj3BvxxxoyuAGWT0KJk9RqOTiZJAPsoPxBFY=;
 b=kCwVVifXGnVGxfjWqdeTaMZW09kmrZz2ODy/Nqq5cNrfHon6tyqaxfzeDoxJevAw45
 MJZUJ7GNQn/Guf5tQzb4YiT+N0UiZrYzkfLfp8pdTtz6OsGLLyXKiyUFZ0vX+Y09aYVM
 +cNhAREU18NVlPAB41iohGJ+H0sfaWoQOnJU3qYpjU1WcvjeydwF7zHpwzbOMeazaJv2
 nUkmyTJFNzB1JjfIpFIvvh/IldPGMd4usQq6sq8xUj3LKGcqRQH0/v0h6vxT50gdKYP9
 gDJlVEiRZog9aiVFy1kZ7Sfb/qHO77HTvUMXhlnqfeHraXE1aK2h27Rbrn4q78LqYytj
 +GBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP+6FCKer6kRea5fUbBuVFugGuAhZRCvDhvbD1Sr/O+kcWIzZ1cf0uEgZxr6W6Tf4TOENdYpAHuGI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n/NP9+mpQ2rXV7CFwdsJDSgxRd5vtUwpIWgrBq846JnGpfikdQ
 l9EhKElowcV2wYb5zAVNZfOTPMag7D0yZf9bAtFMBM+i98sRCVqr//aIpXJkIwZ+RQ==
X-Gm-Gg: AYBFou3Be3NtWMF3+usvuVs3GsPZ6yDsQPDWoZHkJr6aMMgz6sd76mswYXBR7T1OELM
 KZimvW1LOxcTs3E5NYa7JD2h3UCHYIoTq/ePVf+8gEM2F2YURnTI6sD4AAA8RbvHwDEMiVsFZqo
 AC8nRVcqlAgVagKVbwPw8zUe8XXEezVxozQiMtarPpk6OskHY/NWZXTWhn7q4t2BYcLJnHFzs4F
 JvnvN3zjwdosEQZWdz9g9vBvF+w+JrDy4YaPlIW+4MG9sCz/4+dns7B47S07K3+KVn17xZZca0v
 t4GCkNbMrX9WRqZBOq+slNRG4wAI5CFaaerUXrl44v3asRkzX6YlHlul7jlpRRzxpcqgUMwi07b
 tEsRxhZ8NI/OofrCssER6j8u251pfFXITCt7SoP/N0tP0sJUqq1HTmGLWDtNpHO3WaIzHdqH3bK
 tobxFYMGNhP+G4p6NZ2fMiZsOgXY0CM7mS+DHWth5h5ZHr/wwaclXVytjA4HAYi0A78dENAaPXF
 C+DgEwdiSjKlUTxZ+g7K/NE9ETLopub5NrkEOpVtJhvnE2jArpm/xs7Wg==
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39b26100e5dmr38830828a91.4.1788843761523; 
 Mon, 07 Sep 2026 22:02:41 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b813fb4ddsm6342730a91.10.2026.09.07.22.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 22:02:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/sun4i: Align VI buffer addresses for subsampled formats
Date: Tue,  8 Sep 2026 13:02:28 +0800
Message-ID: <20260908050229.754977-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
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

This turned out to be wrong in a couple ways. The hardware can handle
pixel offsets within a sub-sampling block, but the buffer address must
start at the beginning of the subsampled block for all planes. The
hardware then does the interpolation internally. However the helper
gives the address exact pixel for luma, which messes up the result.

Instead of reverting the commit, calculate the intra-block offset and
adjust the buffer address so that it points to the start of the block.

Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memory")
Cc: <stable@vger.kernel.org> # 7.1+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is an alternative to Jernej's original revert:
https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com/
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 2e9cda45c04e..185e9e5211c1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -207,6 +207,20 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 		/* Get the start of the displayed memory */
 		dma_addr = drm_fb_dma_get_gem_addr(fb, state, i);
 
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
+
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
 				 i + 1, fb->pitches[i]);
-- 
2.55.0.979.g7e5102b832-goog

