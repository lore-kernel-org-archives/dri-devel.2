Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F1CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 08:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A372A10E669;
	Wed, 27 May 2026 08:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="onQzRtAi";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8724010E674
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 08:58:21 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8353fd1cb5fso5756501b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779872301; x=1780477101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WBnDUf8A3kCUQmG4DAP0RGklDkvHvWc4BK6TGiSa/U=;
 b=onQzRtAis9PNXh7bfasF0XfBpbnDp6qlYEI/Y5XDs9z9RulwloDeXNeBx7aAdTvgwA
 ZU7QNa6LRILlpF7SPfIU4rCUGZ7++cNFgJBMlkvCr4bAvW5tpCK+c3TiJvXUlVcAuJ8B
 DyoYx2IIqIBBWjgiRGapCiUFGq+T7PefC5dXVclh7kITtM9T8V0WL57SBOxorvPoSGSZ
 MDSCXHU5+8u5MzkhoC7L+94C33HhJweMLa/zgrRFWzQY7AsMI7F2PWNrZxGNl3Wt43u5
 B2MRQBEnKC4++rXdpyklYrSMSnAPo+10kJaqkFtmzUflVKpYNrCcMstVpuH1fkuGvjlR
 gg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779872301; x=1780477101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6WBnDUf8A3kCUQmG4DAP0RGklDkvHvWc4BK6TGiSa/U=;
 b=p9v4t1+5L/Cx9E3DC9hgg5k3NtbFEBSW2ej/OhoxvQX1hL2QcJWmlvPjHsBoJjxgtl
 6L0z9DX5AmowEdS/GK7Jl2N9axvQY7nF0qxCoqamMlXs9dD33Uhr7khqtWjaJ+DhwOmc
 sarWSJyWKPALwLeYhBa02YP72RggH6rAKSeVfSevwlC2x8qqSPxWCi4GLS6ySY9NHyfb
 wzY57XYXbMERR/4UMMCR4OPxke374F4v9GdJFWnuXCRul0BXtM6mx+1wKDoI3zXbXg0y
 4zDXcg06g9gAXmhre7AnpKzLcV5GIK4drmy4ewywymJdIIB98tk3+t/CCzORw+CBGU/q
 RzWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8foog1qSN7c8hS/acy3VJVRF/DgLkE6fECjaDXFwDN1yyg17A/7FrMdbYLrYzgCiHk8/RgZZxp60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzdwwkg8We1BoTc9v7WKrzRvT9+537r3K9SNh34fJo0KDylyO8e
 cSZXZ0vzZB6hsn84A7VtZKVXuSeREzrSfgX8KAwvqA102aXilv7I6XzL
X-Gm-Gg: Acq92OHrqDVgQW1yld1x5Ej8C+duBkoffXkir2DFTXjxMSeogOVOlRvX8mc3Kp9R75f
 HnmnywoxMk4BxrGTu3YPaaNwNWLVixwr8qpOo5rMQ9bodsRmmFDUI6kiB0ve10ICIE3mX+0FJgC
 6jTZu3/z5TM2djCS+6Wiaag81AFSZpY3TP+mFh3/zvCuU+d9jLEOCqfIzzNHfW2PCYApGsQl5qG
 otLvE04sY1HlwH5m5XjJPVxaogBaLIFIBLltmgc22qa+SQX+dqC5g46w+1LgW8+MJm6jWqyO51x
 hh8+/ZZUJRU0bRLA+jsvxAJzJMVrPkM48ZxF/aQEA8lMkf61/72LuJUhas+mTVS4AGgs5aD6+5k
 uNui8AwUrBglfhKwtBQl0+pEHm/ArK1Q8joBXlPv/yc8aedyqiywsCuveaD3tO5BZrCBKWiKqmf
 yy2Bdmu6M28svXULN/ybrSGLu14E1ZEYIvDPRdXwyrRZBB1ArM
X-Received: by 2002:a05:6a00:4407:b0:82f:1f43:7190 with SMTP id
 d2e1a72fcca58-8414b3e1e94mr20242623b3a.3.1779872300967; 
 Wed, 27 May 2026 01:58:20 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d70b855csm1651909b3a.38.2026.05.27.01.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 01:58:20 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst mode
 for LVDS stability
Date: Wed, 27 May 2026 14:27:36 +0530
Message-Id: <20260527085736.920390-3-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527085736.920390-1-tessolveupstream@gmail.com>
References: <20260527085736.920390-1-tessolveupstream@gmail.com>
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

The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
while burst mode is supported by the hardware, its use
depends on continuous clock behavior from the DSI host. In practice,
burst mode may introduce instability depending on the host controller
implementation, as the DSI link may transition to low-power state
between bursts.

Testing showed improved display stability when using non-burst mode on
affected panels.

Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index c03ff1ea9df8..6b5a6019c30d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -976,8 +976,8 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
+			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-- 
2.34.1

