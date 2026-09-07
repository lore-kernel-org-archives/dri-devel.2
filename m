Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAA8C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B6C10E395;
	Mon,  7 Sep 2026 11:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HDcs9Z0t";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C04010E187
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:13:59 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E53AE2E9;
 Mon,  7 Sep 2026 13:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788779543;
 bh=0JexZinUpjJtgR80UaLACEgHGQL+Rq4cVcA9jrJe0r0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HDcs9Z0teeAN+3BWeOW7fJahBvOr/6IFgxyQ73AlthwUNZTfPYQAE1zcLqZYKyCJr
 ubS9PLmj/Rv5y/ie7StbsVRtogBU0yAX1NRCOBFHz/849z0WMDw4NY9Zso1FxdAc+H
 Wu++n2XIwtmPkcb4JpUEQ6XjMCcD3aplrrvMQ9fE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:13:35 +0300
Subject: [PATCH v2 1/3] drm/bridge: cdns-dsi: Add clk debug print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-cdns-dsi-fixes-v2-1-96d9b116e9bc@ideasonboard.com>
References: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
In-Reply-To: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=0JexZinUpjJtgR80UaLACEgHGQL+Rq4cVcA9jrJe0r0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnpxzEtWj/WWLIUGQ078uBPQOpOdXjSubr/NYo
 ZwGOqSNXmmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6ccwAKCRD6PaqMvJYe
 9evvD/9IRnhJvTSATPOtlmlncU5+6EE4JbhoJjZdmcgIljvud0Tr2N3zrC2Ia3qjPWa/CgcdBzC
 okohd4/OQr4BiATCq8PTOI4YuzqAeYZzcwtVZei8NOjjCVGz4bVnnP9EELGb4JII/MasFyeESCO
 bKi4V5ebPsPLhFL8dIJGiMA0V76POARpERzn+wZag8MFxULXxVpDUKeQHbqxouMsecINIVlvIpD
 uG5Fa24w5GHCNL0LmRxBSz1V/ObD78zk/28hhCrZVdwLxbx5BGfSUdojS8esE/QhH3tncc/TX0B
 SCUhM0ygjKy4xObPcEFA198YDxPWkBmlszAGeQotNgapHKTnzofPNgS6IS5Mt8OyVGRDywrWNd5
 iBOamLLUIR0hz8O0Suc2cixQ5BOtRLJFtqVtxME/fO8qMXWEb2YkiqI29ENSqwg9GxyZK1d33E0
 aNFYJGp8u6LH/DOE4Y2C45Z5aSoOv9VWIrM7C79MiWZm0JDjp8X4zlyCNRYq701sMi30JZXXiZ+
 jV5sSQQJuOQFFMud+7kgJ62ymvj/J8dI0n+ZltJHKoKVu2SDPnbepZsUlJnldAF7SQ3POMqYT+2
 ATeM3gG5hAll4bUnIEDRRm5rl3VZLjnFFiFRd39oSQAs2d/6qIpQhL5lHcA9csEaVzF1rD/D+58
 NEdCUoaK+ZaKt/Q==
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
index c3e466ded84a..4b7a3bf58255 100644
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

