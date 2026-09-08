Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8580C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D52F10EABF;
	Tue,  8 Sep 2026 09:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hC0sgOY/";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39EE10EABF
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:08:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so4126403a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788858488; x=1789463288;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZHoy8f3OpVjs16q22My2K8o0ZC/itaQqMauUbs1Www=;
 b=hC0sgOY/mJkWjHLk6YHi9VDc07Zs6sXrg9N7ChRbeDhoP7IN3zVyBxxi7lA6Ewaxb2
 Wt+9ogy6HnQZsg/jfdK2CYsycMEc5BcpmsgHDJKoHNOz5jAP9u5nc6gHzGEb4KngTRqu
 mLllgPuRcMB0YUGVajusPJKz6TXGj+GIwc2tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858488; x=1789463288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EZHoy8f3OpVjs16q22My2K8o0ZC/itaQqMauUbs1Www=;
 b=anm8IO8Ihyyv35nuXiVK+Mgzn5no6fUJheyJXRVBq9QdJyZAjSjAWqD7fhZdtEoYkK
 Gf01LLrFX1kTobJiQHpmaNEG4l+/zzwWdZwW/aU5n7rMeRhL+uXLZ/U9qtHGzEvLp82y
 0HX1tP/crw21tjw/UyOzWywK4H7DZ9HVi+N/S6ASZqrMhTcsmbma5WbbUXgQJKOjqlqd
 rmOjFLZvZZXp6kpRmem+jJJdpiVcHXWfZB2a3IigI9Vym0ArEqqBN9x49t32SWiUfNLZ
 17S5f+KCqda3+VopsRapXk5C/1MM/BIGlbmPdQvEfpUrhrBkVg+T/G3hVXeE7eaS/RLw
 aeMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcC1qTU5SdCDyhAFk1IFHTwlQo6bDI2j4/5q5G/M1Q17t2RDGuj38ACU7JyCp5SIu1aMkmQeKRagg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mqdh5K6JaWgreCL1x+D8YTKuh6fWwHEgFOtI8WdcJP32L7iC1o
 5TaOrjh9IeAdYLklrZRtE1418L1Hsc2JUuOSxLLjgSknyKk8s4zZfOp3FLel/8tEzg==
X-Gm-Gg: AYBFou2Ka57ycL1+LvwMDEhWYo9J4dKS5KHRcxruGsiMaKa3a7/pFP45owx4ZUbHlMv
 uXDatfJ8CWAxuUW2ZakmjCIMKuh2hNiOUKrAzQsLhgRHAkEqqz2q2K8cF28KyEqE8H6qgdIfUbI
 U1dt/+4Dba08pBrSY6lGt+GdZlZn6iW8MRjfN/Bk/Ae60IVq9x0gPnE8Qj2gtSJKgeM22v+daR3
 wiQYQGCO5KjoWWb8vTWo8eg3PwyGvcBwrt0XgXaCUmijQpWj89YxOjICWenLkLNHhjLtV8IOxjW
 wz3erxpMDgf5Wnv+OKyLeNrKpoyTgzPBMDUFxVKWmhEmkmjy7QFZ24XZ0fQDgzCOtmAxRct1Wrd
 0PZ5NpNjHecxp+wj5/gRu1/b9NwP5/1587wlHShJAwQw3bj8LfGKR3grjpuiuLrp+gSMyfDovKa
 jCS0LTwI8ICSvh7CT/kzdY9FfNx3/AljuDRw69zUlY4xiuy/ahO0GK76rW6/b0ESftckGS35PoB
 RU8yDUBqDp0d6P/bP6jpKMbCzyzZLqWTBQ1VrkR10ujnIJGqArGjHmkqg==
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-39b26273a40mr43384810a91.21.1788858488251; 
 Tue, 08 Sep 2026 02:08:08 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:08:06 -0700 (PDT)
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
Subject: [PATCH 3/4] drm/imx/dc: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Tue,  8 Sep 2026 17:07:42 +0800
Message-ID: <20260908090745.1089143-4-wenst@chromium.org>
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

The hardware is programmed with clipped source and destination dimensions,
but the framebuffer address is calculated using drm_fb_dma_get_gem_addr(),
which uses the full source dimensions. This will not match the source
offset if the top and/or left sides are clipped.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Cc: <stable@vger.kernel.org> # Needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dc/dc-plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index dea7404fe659..7bab75d5dedd 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -65,7 +65,7 @@ static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 static int dc_plane_check_fb(struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* base address alignment */
 	if (baseaddr & 0x3) {
@@ -146,7 +146,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 	src_w = drm_rect_width(&new_state->src) >> 16;
 	src_h = drm_rect_height(&new_state->src) >> 16;
 
-	baseaddr = drm_fb_dma_get_gem_addr(fb, new_state, 0);
+	baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, new_state, 0);
 
 	fu_ops = dc_fu_get_ops(dplane->fu);
 
-- 
2.55.0.979.g7e5102b832-goog

