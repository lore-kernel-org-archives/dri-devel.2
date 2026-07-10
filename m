Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256FBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8140A10F8F1;
	Fri, 10 Jul 2026 13:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="kxgZRlCs";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A8010F8F1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1783691644; x=1783950844;
 bh=fsAnr3kjqpYuXcuApLrk9JFunB978fsCh8abhH5K8xY=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kxgZRlCslD1szHBHaYnNOX0ZmW4vt+1pqBQpvBvwUXCH9JxPKuu1uaRX9WiafWpoe
 oh3k+bodBUgFe1eavuMAqsCSgMl6Ku/bYUjWgwb0zrguKl/OHPUR8RIT10bAilBQQF
 61JUHo9AJzS0KrSZw5AVxg2KYDvYkk0EILrJrYh35LY+fR5LOARgIAHIKTlbvERXfF
 iFG2Y7AcrItq2J7EBMxFtyAAMY0y0EoljWL/TKyvFD+muVMbwu85TtsDLlKW+Fh1qA
 HttWGXtOb4HnVTANdow07LN+vENxz0DR+wjJWWitLa9Q3fckJZKgQAxKlwRGJiruuw
 V9Cx+qN2RskMg==
X-Pm-Submission-Id: 4gxYGM33Qmz1DDrP
From: Esben Haabendal <esben@geanix.com>
Date: Fri, 10 Jul 2026 15:53:53 +0200
Subject: [PATCH 3/3] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync
 timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-nwl-dsi-fixes-v1-3-927d918a86ad@geanix.com>
References: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
In-Reply-To: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>, Robert Chiras <robert.chiras@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783691637; l=4033;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=tNRZSSK2OL6E3vIEk3tpiBMkXERKkLYCZ/9foXsqa5M=;
 b=GarpfREI/KRkgHmyNQV8uyb78xhXHC43qKxvBCQDbmsfUfQELECetO0ptbzTpbLSYkUXFc4zc
 uHWr3lBMJirCrhWLucbDCsyx9jrvLJHyh7omwGv/8VN+957xXQ4S0+S
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
 drivers/gpu/drm/bridge/nwl-dsi.c | 56 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index c9af6a3d47e1..ed61580a3545 100644
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
@@ -317,9 +322,54 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
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
+	pkt_len = roundup(((hfp * 100 / h_blank) * 32) / 100, 2);
+	pkt_hdr_len = pkt_len;
+	hfp -= pkt_len;
+
+	pkt_len = roundup(((hbp * 100 / h_blank) * 32) / 100, 2);
+	pkt_hdr_len += pkt_len;
+	hbp -= pkt_len;
+
+	hsa -= (32 - pkt_hdr_len);
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

