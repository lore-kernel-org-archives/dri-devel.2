Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F8AC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB2E10F147;
	Thu, 20 Aug 2026 17:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i8NcJD2N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WX4nLkRg";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA9E10F147
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:39:50 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hQrKw4hXGzMlGh;
 Thu, 20 Aug 2026 19:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787247588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1hHtaUf9NAZHILvzPNcph6/53NxSvJ26X5f+QWyfUu4=;
 b=i8NcJD2NIzy8Ol/erLFshZeol36pk1Uw6/fIPFQj9/AMw7djSB4tVc8pTt3kjxWS6fgtFC
 p7DNoGFyIN5q5uCir6mfxDHwKziwTeQtAeCvSuXlvUJN9+evP/67tErV5d7iV1nTF9MPaG
 mGr14Mya4C1h932CeXNARRds36+aZxAhrFbEK+1Tl2u7od2xv4BWlBoiNZ28fhTmvwIIAR
 4HeazjPXGuwaWdSolcRxlNzKJOiJxn47gubMT/PmmMqzuCa4tb72712WkZzRDymdt+WCH/
 FdBjFZebH6TB/VhDG/oGjhjSmWKiuhYpTdr5kxAgOumZjNQfYcVXayFyGz/nOA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WX4nLkRg;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787247586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1hHtaUf9NAZHILvzPNcph6/53NxSvJ26X5f+QWyfUu4=;
 b=WX4nLkRgju9uXIdGEDGGRtavsi91wBYt76WD8jJ3iOM6kuA4Faf6LE6t2OoVIiiJKttLFW
 +5PcNxXhjWdfbQJZ0yYMAdYRJDxhepeaX9ZK1dOIXdY7+2aGrtXECvYxgZp7DlwhTsLZgJ
 JPwWMEGqrpmKeOuVAB6RYsSct5QWhCR1Vx4ARgXgsyFDmnUzkPXHGunTZvf9cow9zSLAQg
 lyC3UvRbH7eMYBjE0P+QvdWW8HKbde5LdHIn56SL2r0il9AJDVKrF2fNV9TePXCVJ4bEi6
 qvj7v8QWPKsAKnHs5Vhmc6nxEZAvFqj/5gpHn5rDA1zJTxW1vCfF0LponukPAA==
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
Date: Thu, 20 Aug 2026 19:39:10 +0200
Message-ID: <20260820173937.55008-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jfap5ckhrf7ruchj6rmineoqnjq1yrzg
X-MBO-RS-ID: 3085eaeb25d768e1c60
X-Rspamd-Queue-Id: 4hQrKw4hXGzMlGh
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

Currently, the driver supports register access mode for DSI command
transfer, which limits both TX and RX to only 16 Bytes long packets.
Implement support for DSI command TX using AXI memory access mode,
which extends the packet transfer length up to 128 Bytes long in LP
and 1024 Bytes long in HS. Support for DSI command RX using the AXI
access mode is not implemented due to missing test hardware.

The implementation allocates a DMAble 4k page. In case the command
transfer is longer than 16 Bytes, the payload is copied into the
page and sent out using the AXI access mode, otherwise the register
access mode is used.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: David Airlie <airlied@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Use dma_set_mask_and_coherent() to set up global DMA mask and
      drop GFP_DMA32 from dma_alloc_coherent() gfp flags.
    - Fix DMA memory leak in missing fail path in rcar_mipi_dsi_probe()
      and move dma_alloc_coherent() almost to the end of the probe
      function, so as much as possible of the probe function is devm
      managed.
    - Unregister DSI host first, then free the DMA page
---
 .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   | 50 ++++++++++++++++---
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 6e46d6d99f3c0..8a380cbe72bbb 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/math64.h>
@@ -75,6 +76,9 @@ struct rcar_mipi_dsi {
 	unsigned long mode_flags;
 	unsigned int num_data_lanes;
 	unsigned int lanes;
+
+	void *cmd_axi_cpu;
+	dma_addr_t cmd_axi_dma;
 };
 
 struct dsi_setup_info {
@@ -977,6 +981,7 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct mipi_dsi_host *host,
 					      bool is_rx_xfer)
 {
 	const bool is_tx_long = mipi_dsi_packet_format_is_long(msg->type);
+	const bool is_tx_axi = !is_rx_xfer && is_tx_long && (msg->tx_len > 16);
 	struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
 	struct mipi_dsi_packet packet;
 	u8 payload[16] = { 0 };
@@ -987,9 +992,14 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct mipi_dsi_host *host,
 	if (ret)
 		return ret;
 
-	/* Configure LP or HS command transfer. */
-	rcar_mipi_dsi_write(dsi, TXCMSETR, (msg->flags & MIPI_DSI_MSG_USE_LPM) ?
-					   TXCMSETR_SPDTYP : 0);
+	/* Configure LP or HS and register or AXI command transfer. */
+	rcar_mipi_dsi_write(dsi, TXCMSETR, ((msg->flags & MIPI_DSI_MSG_USE_LPM) ?
+					    TXCMSETR_SPDTYP : 0) |
+					   (is_tx_axi ? TXCMSETR_LPPDACC : 0));
+
+	/* Configure DMA source address for AXI command transfer. */
+	if (is_tx_axi)
+		rcar_mipi_dsi_write(dsi, TXCMADDRSET0R, dsi->cmd_axi_dma);
 
 	/* Register access mode for RX transfer. */
 	if (is_rx_xfer)
@@ -1011,7 +1021,10 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct mipi_dsi_host *host,
 			    TXCMPHDR_DATA1(packet.header[2]) |
 			    TXCMPHDR_DATA0(packet.header[1]));
 
-	if (is_tx_long) {
+	if (is_tx_axi) {
+		memcpy(dsi->cmd_axi_cpu, packet.payload,
+		       min(msg->tx_len, 128));
+	} else if (is_tx_long) {
 		memcpy(payload, packet.payload,
 		       min(msg->tx_len, sizeof(payload)));
 
@@ -1162,10 +1175,16 @@ static ssize_t rcar_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
 	int ret;
 
-	if (msg->tx_len > 16 || msg->rx_len > 16) {
-		/* ToDo: Implement Memory on AXI bus command mode. */
+	if (msg->tx_len > 1024 || msg->rx_len > 16) {
+		/* ToDo: Implement Memory on AXI bus RX command mode. */
 		dev_warn(dsi->dev,
-			 "Register-based command mode supports only up to 16 Bytes long payload\n");
+			 "Command mode supports only up to 1024B long TX and 16B long RX payload\n");
+		return -EOPNOTSUPP;
+	}
+
+	if ((msg->flags & MIPI_DSI_MSG_USE_LPM) && msg->tx_len > 128) {
+		dev_warn(dsi->dev,
+			 "Command mode in LP supports only up to 128B long TX payload\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1266,6 +1285,10 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
 	struct rcar_mipi_dsi *dsi;
 	int ret;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "No suitable DMA available\n");
+
 	dsi = devm_drm_bridge_alloc(&pdev->dev, struct rcar_mipi_dsi, bridge,
 				    &rcar_mipi_dsi_bridge_ops);
 	if (IS_ERR(dsi))
@@ -1295,12 +1318,21 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->rstc);
 	}
 
+	dsi->cmd_axi_cpu = dma_alloc_coherent(&pdev->dev, SZ_4K, &dsi->cmd_axi_dma,
+					      GFP_KERNEL);
+	if (!dsi->cmd_axi_cpu) {
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate DSI AXI Access command buffer\n");
+	}
+
 	/* Initialize the DSI host. */
 	dsi->host.dev = dsi->dev;
 	dsi->host.ops = &rcar_mipi_dsi_host_ops;
 	ret = mipi_dsi_host_register(&dsi->host);
-	if (ret < 0)
+	if (ret < 0) {
+		dma_free_coherent(&pdev->dev, SZ_4K, dsi->cmd_axi_cpu, dsi->cmd_axi_dma);
 		return ret;
+	}
 
 	return 0;
 }
@@ -1310,6 +1342,8 @@ static void rcar_mipi_dsi_remove(struct platform_device *pdev)
 	struct rcar_mipi_dsi *dsi = platform_get_drvdata(pdev);
 
 	mipi_dsi_host_unregister(&dsi->host);
+
+	dma_free_coherent(&pdev->dev, SZ_4K, dsi->cmd_axi_cpu, dsi->cmd_axi_dma);
 }
 
 static const struct rcar_mipi_dsi_device_info v3u_data = {
-- 
2.53.0

