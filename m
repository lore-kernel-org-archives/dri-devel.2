Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2182606A322
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=muHUo6CB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017E910E3D5;
	Tue, 27 Oct 2026 10:37:21 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8384010F3A0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1793097249; x=1793356449;
 bh=lZWQDrAmoiw6SBLgex16MiXr1FeSMl0JItqbKleN6Mg=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=muHUo6CBdB8jAn3g3QcV5Uvtkq9GAAmeasq7kZe2NHZY7/LADAnhT9fbgOi01JTpc
 hYD9xh/J78O+Pcsj+D+p32OnsRsgyoGhfvlApTR7aa9bQvG6to1mLedIAT+tm7kfRc
 hHp0lxEQD9sm8aiGtmFQ73v8isZtmEau5Gy+KOX9erHWZehCCguTCncLQqod6xb9eR
 YjePshm33kn2owlrZ0QPfzWapTk/o039NdGwJ7wiXuoLBRf7Q4VBpUBNsGg+S5Lsmi
 bHkCrfcmCRkzSdLjOhQId2QJkncRxKx7G+FtJcbnbyoYVJhBIpZB/nL5L8iNcHpfH7
 GgD2GNiZRdhAg==
X-Pm-Submission-Id: 4jDRgL36l0z1DF5K
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 27 Oct 2026 11:33:52 +0100
Subject: [PATCH v5 4/4] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal
 sync timing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-nwl-dsi-fixes-v5-4-b6d1d3d2d356@geanix.com>
References: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
In-Reply-To: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev
Cc: Esben Haabendal <esben@geanix.com>, Frank.Li@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=4569;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=BPl/W4P4TrdcCjFEm+Lx0MMHf20hrmW0utgAkepjgi4=;
 b=Ihcv8FGi4DIdFuSdBeE1cuHcHTTvyNGzsH8MCTHaJUVWuqTWFRhufbqlExjx2CYC1aeHPF27V
 1cuYF2GVsacAbdAbUgnoRVsRDNj6FMXUeR/ZWg5+lW7bCY5NErsxumj
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NWL MIPI Host controller registers specifies the horizontal front
porch, sync pulse, and back porch in DSI packet payload size in bytes (ie.
not in pixel clocks).

The calculation for this is (mostly) described in section 13.6.3.5.1.2 of
the i.MX 8M Dual/8M QuadLite/8M Quad Applications Processors Reference
Manual (rev. 3.1). The formula shown there does not take packet header size
into account though.

The formula implemented here converts the hfp, hsa, and hbp to DSI packet
bytes and then subtracts the number of packet header bytes.

It is worth noting that these values only needs to match approximately,
according to the reference manual.

Based on commit in NXP vendor tree
commit f2a61699749d ("LF-7981-4: drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing")

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Oliver F. Brown <oliver.brown@oss.nxp.com>
Tested-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Acked-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 60 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index f3f4334136c0..870a308589cd 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -13,6 +13,7 @@
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
 #include <linux/media-bus-format.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mux/consumer.h>
 #include <linux/of.h>
@@ -264,6 +265,9 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
 	bool burst_mode;
 	int hfront_porch, hback_porch, vfront_porch, vback_porch;
 	int hsync_len, vsync_len;
+	int hfp, hbp, hsa;
+	u64 hs_clk_rate, pclk_rate;
+	int h_blank, pkt_hdr_len, pkt_len;
 
 	hfront_porch = dsi->mode.hsync_start - dsi->mode.hdisplay;
 	hsync_len = dsi->mode.hsync_end - dsi->mode.hsync_start;
@@ -317,9 +321,59 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
 			      dsi->mode.hdisplay);
 	}
 
-	nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
-	nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
-	nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
+	hs_clk_rate = dsi->phy_cfg.mipi_dphy.hs_clk_rate;
+	pclk_rate = (u64)dsi->mode.clock * 1000;
+	DRM_DEV_DEBUG_DRIVER(dsi->dev, "hs_clk_rate: %llu Hz\n", hs_clk_rate);
+
+	/*
+	 * Calculate the bytes needed, according to the RM formula:
+	 * Time of DPI event = time to transmit x number of bytes on the DSI interface
+	 * dpi_event_size * dpi_pclk_period = dsi_bytes * 8 * hs_bit_period / num_lanes
+	 * ===>
+	 * dsi_bytes = dpi_event_size * dpi_pclk_period * num_lanes / (8 * hs_bit_period)
+	 * ===> (substituting period = 1 / rate)
+	 * dsi_bytes = dpi_event_size * num_lanes * hs_clk_rate / (8 * dpi_pclk_rate)
+	 */
+	hfp = DIV64_U64_ROUND_UP((u64)hfront_porch * dsi->lanes * hs_clk_rate, 8 * pclk_rate);
+	hbp = DIV64_U64_ROUND_UP((u64)hback_porch * dsi->lanes * hs_clk_rate, 8 * pclk_rate);
+	hsa = DIV64_U64_ROUND_UP((u64)hsync_len * dsi->lanes * hs_clk_rate, 8 * pclk_rate);
+
+	/* Make sure horizontal blanking values are even numbers */
+	hfp = roundup(hfp, 2);
+	hbp = roundup(hbp, 2);
+	hsa = roundup(hsa, 2);
+
+	/*
+	 * We need to subtract the packet header length: 32
+	 * In order to make sure we don't get negative values,
+	 * subtract a proportional value to the total length of the
+	 * horizontal blanking duration.
+	 */
+	h_blank = hfp + hbp + hsa;
+
+	if (h_blank) {
+		pkt_len = min(hfp, roundup(((hfp * 100 / h_blank) * 32) / 100, 2));
+		pkt_hdr_len = pkt_len;
+		hfp -= pkt_len;
+
+		pkt_len = min(hbp, roundup(((hbp * 100 / h_blank) * 32) / 100, 2));
+		pkt_hdr_len += pkt_len;
+		hbp -= pkt_len;
+
+		pkt_len = min(hsa, 32 - pkt_hdr_len);
+		pkt_hdr_len += pkt_len;
+		hsa -= pkt_len;
+		if (pkt_hdr_len != 32)
+			dev_warn(dsi->dev,
+				 "Unable to subtract packet header length fully: %d left\n",
+				 32 - pkt_hdr_len);
+	}
+
+	DRM_DEV_DEBUG_DRIVER(dsi->dev, "Register values: hfp=%d hbp=%d hsa=%d\n", hfp, hbp, hsa);
+
+	nwl_dsi_write(dsi, NWL_DSI_HFP, hfp);
+	nwl_dsi_write(dsi, NWL_DSI_HBP, hbp);
+	nwl_dsi_write(dsi, NWL_DSI_HSA, hsa);
 
 	nwl_dsi_write(dsi, NWL_DSI_ENABLE_MULT_PKTS, 0x0);
 	nwl_dsi_write(dsi, NWL_DSI_BLLP_MODE, 0x1);

-- 
2.56.0

