Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C5910ED65B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AED10ED93;
	Fri, 27 Mar 2026 10:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rkdjajjV";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C1B10ED90
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:52:01 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4074A1E31;
 Fri, 27 Mar 2026 11:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774608641;
 bh=iK79vSGxmns2y2FFs/BykcdWu6MRhpA8TvBzjd9/I/M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rkdjajjV7dauI7qvaKKrUIvoN953EQ1gmEU7kX1RBWR+Whry6Yi2b4BBZoldrYzsP
 4DQsy1skdBi9BHq3Z5n3ZaWe44SI7vSWcSbl/2Gl+BMWvb40yo7DeFasXXdZdSDbEr
 vhxVX1pVSEbxT7o/GIxD2Pc4SO0g5c02X5NBMbSw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:51:39 +0200
Subject: [PATCH 1/3] drm/bridge: cdns-dsi: Add clk debug print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-cdns-dsi-fixes-v1-1-088edd40e97f@ideasonboard.com>
References: <20260327-cdns-dsi-fixes-v1-0-088edd40e97f@ideasonboard.com>
In-Reply-To: <20260327-cdns-dsi-fixes-v1-0-088edd40e97f@ideasonboard.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=945;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=iK79vSGxmns2y2FFs/BykcdWu6MRhpA8TvBzjd9/I/M=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxmFNAjSXelPoigvgol7U1vdg/UXL4cgAw3uG0
 mrgVEma68SJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZhTQAKCRD6PaqMvJYe
 9eMeD/4+S9jr3GmmvKtWcBmcHzDSzOm7gP93cuQ9Pe2sCQCf9xlRyW1OkjNYQGuXH+ibLghlddJ
 1pOeDQdG5kzJvDk1aRlyKNmecdd/V/Mu2nfn+FVwjx0s/uBGhC9bYLme8oo8s2HgtQr4UaQUF9M
 IIr0Cz0Mz6/35Ywpz5Henfyx9E7sDQ9ZLAfK98xEK4/3AieLT61UZdUyOMfrSjf8+EEV7960gqR
 rKshxfIaVdpA8Ia9SVuqN+Xr/kHAR7p40fKmZZHPM8CLVaS5HSqAEq7xRHoPv0nYPy6+18ExCdh
 90j5k9jePyeiLoYueStALLfwUBOQPGdyWmHrQrKlJfbodYaVPkllqmf2BjsqJ6CxcMK4+C8xpkV
 nwsy3RyW1tpumJPjoY3O6LoDqE3/J1Rm79cku9WkMATb+3LHZ6rJfdYpZ2YZSOy72iF13Ahz7Ja
 V8G0zJbanTMn3I27C5yUOAMk12hArzuK95zfWamwzOA6O7fy1awuBGo/GOe98k0H6bfALnhyd4g
 8/Z6EZ6O1VbrhX2BqNcWh4W/SrapdQbiqr7L8oZ1urIbq7rJOMbVFp7D8axImgF0xt+1QcpZ2/h
 QRBifAJuULk+3CjC+II80Zjedaib3qhti+APpml+t8PzK6vBnMDP+X9y30TTyeiW2hBU4jw/vQ4
 DvQBFh1I9fjFSYg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

I keep adding this debug print while debugging panel problems. So let's
add it properly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0dd85e26248c..2c86bf346fea 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -718,6 +718,9 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	u32 tmp, reg_wakeup, div, status;
 	int nlanes;
 
+	dev_dbg(dsi->base.dev, "bitclk %lu, byteclk %lu\n",
+		phy_cfg->hs_clk_rate, phy_cfg->hs_clk_rate / 8);
+
 	/*
 	 * The cdns-dsi controller needs to be enabled before it's DPI source
 	 * has begun streaming. If this is not followed, there is a brief window

-- 
2.43.0

