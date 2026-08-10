Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E57EC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D18110E6EC;
	Mon, 10 Aug 2026 07:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="38D0UM+S";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBB510E6E6
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1786346093; x=1786605293;
 bh=OtohktVyQJKXvNkAqv8snMUDoXWGxu44sYvdQA4z/zA=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=38D0UM+SZ5I5k8CA1blTNAkNOTQoCAaWw5KwMV6o5gx68jN5pddCAoab+BEpvjIJz
 a1LsMdH9nEY5bXwieRmnCyoJGz0vzP74Yd9U6jHlrn8p5+rdm7qalaobJ7L/s3EZEh
 I0Sj9mL4WXYTyqUMFmmKlKxJPubY/JPsoTcqyN7aM8RaoO2As1zo884zEO73yGxyM+
 hQoC5XuyRFvcBONdUauJa5q/a5XwtrAAY4dxWZJ48e2NXA4PW7dBkAREsqyPBgnz8G
 KKJajakKBfWdVdrH47bnOIEe2maUW9uW/XeUvN03ftB6tzJHx9KKAKYO+Fwej20QFp
 gb/ZNzJQls24g==
X-Pm-Submission-Id: 4hJQxS5CMCz1DFFK
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:14:41 +0200
Subject: [PATCH v3 5/5] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal
 sync timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-nwl-dsi-fixes-v3-5-256da9d672e1@geanix.com>
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
In-Reply-To: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
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
 Sam Ravnborg <sam@ravnborg.org>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346082; l=4286;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=bFFilPL9n/Q9d52v3UsM+SJ2cQjcjDxrD8yGnZ95O2Q=;
 b=NjHe8ys8z2OUvQztvA+PHNzFQW0oVUrf3+ieaBBiHS4eCQ0BZ2Q1UnQfJw9VlU4rzMpyOw65l
 jtfhCIhzHjHAKWnq8HZ4j/SRvqqVxYVgloGLNGuh8B5yjB5ldWd0Pcj
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Oliver F. Brown <oliver.brown@oss.nxp.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 64 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index e90588299c5e..87d22b3bd79c 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -22,6 +22,7 @@
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
 #include <linux/time64.h>
+#include <linux/math64.h>
 
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
@@ -264,6 +265,10 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
 	bool burst_mode;
 	int hfront_porch, hback_porch, vfront_porch, vback_porch;
 	int hsync_len, vsync_len;
+	int hfp, hbp, hsa;
+	unsigned long long pclk_period;
+	unsigned long long hs_period;
+	int h_blank, pkt_hdr_len, pkt_len;
 
 	hfront_porch = dsi->mode.hsync_start - dsi->mode.hdisplay;
 	hsync_len = dsi->mode.hsync_end - dsi->mode.hsync_start;
@@ -317,9 +322,62 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
 			      dsi->mode.hdisplay);
 	}
 
-	nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
-	nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
-	nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
+	pclk_period = DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->mode.clock * 1000);
+	DRM_DEV_DEBUG_DRIVER(dsi->dev, "pclk_period: %llu\n", pclk_period);
+
+	hs_period = DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->phy_cfg.mipi_dphy.hs_clk_rate);
+	DRM_DEV_DEBUG_DRIVER(dsi->dev, "hs_period: %llu\n", hs_period);
+
+	/*
+	 * Calculate the bytes needed, according to the RM formula:
+	 * Time of DPI event = time to transmit x number of bytes on the DSI
+	 * interface
+	 * dpi_event_size * dpi_pclk_period = dsi_bytes * 8 * hs_bit_period /
+	 * num_lanes
+	 * ===>
+	 * dsi_bytes = dpi_event_size * dpi_pclk_period * num_lanes /
+	 * (8 * hs_bit_period)
+	 */
+	hfp = hfront_porch * pclk_period * dsi->lanes / (8 * hs_period);
+	hbp = hback_porch * pclk_period * dsi->lanes / (8 * hs_period);
+	hsa = hsync_len * pclk_period * dsi->lanes / (8 * hs_period);
+
+	/* Make sure horizontal blankins are even numbers */
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
2.55.0

