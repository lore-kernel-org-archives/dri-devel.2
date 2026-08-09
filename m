Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0DBC5AD5A
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 19:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4FD10E1C2;
	Sun,  9 Aug 2026 19:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cO068ybS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qGvkZcwA";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599B710E1C2
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 19:58:41 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hJ7xB5sxvz8v05;
 Sun, 09 Aug 2026 21:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dYZ3oDU/XfSEn16rDkLYoq3IW5P2xX4KakGGecDGTgM=;
 b=cO068ybSh3T1kOr9bvIG0KkVDMmjmEka0nNrMKuNQXn4FuwpsXSXhWHkviA6FNodr3uB9k
 Q1UkdLumo6W6xLNhNfbtMKS9iPGLbJhWCD6jO+5MD+njA3MqCq3Sqg0x9RC6exuRN3EC0E
 1+SyrGiAsVMk74pUxQ2IFv5CI4mA66SOD9S76nn7g3g9G2h3DTO3BbryejjPc9Vk/1/wCm
 Mp4rK7q8GagChjzXRg2TZVA2Lp+2rWTZcuhACL8B85Ip9KTTTvdhOTAOOuE9aQxby4l5fn
 H0g1A35H5Cm70sWvjxDqeowQwUBxXK88FFgt8xz62ESY2orQ6SlwP7dYS9oKPQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qGvkZcwA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786305517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dYZ3oDU/XfSEn16rDkLYoq3IW5P2xX4KakGGecDGTgM=;
 b=qGvkZcwA2kZzcjAV8LgK8Ryth00jv21+l3Egded4gKhmLNFPHk7DsLmPlOhSwRPqJAfsS2
 76EK7/s7fwFsKJZVtZ0oc9Rz5La6OOlG0zxbQ/RPwg9jqh3YPhTrmDFFDFYKc6kzGxQ7dM
 y+rA/+ZYNccEAfQO43/OBUtUVLndFnlrds7GbX7fePNOHSod2jzawGPeyM90LGUo4Uc0xW
 5wj/jfcFay/k03eOfpUFfQC2hdnTXwJlB6fwMe9+uzgdUIiCb2D7eLRBD2vC3EdXA/i1Pl
 TBPcgkUUZ3Dqvjpf5KOqn3cfarWKSH+BWF1HFl32mSD8sXj55aBXScYVS1ltng==
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
Subject: [PATCH] drm/rcar-du: dsi: Implement DSI command TX using AXI memory
 access
Date: Sun,  9 Aug 2026 21:58:06 +0200
Message-ID: <20260809195831.842907-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ob1gw3moqdbhkyqi61u88a7wt6oakxhx
X-MBO-RS-ID: 6b5b9a330ba6ff7d48f
X-Rspamd-Queue-Id: 4hJ7xB5sxvz8v05
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
 .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   | 42 +++++++++++++++----
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 6e46d6d99f3c0..c25218ca4320a 100644
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
 
@@ -1276,6 +1295,13 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
 	dsi->dev = &pdev->dev;
 	dsi->info = of_device_get_match_data(&pdev->dev);
 
+	dsi->cmd_axi_cpu = dma_alloc_coherent(&pdev->dev, SZ_4K, &dsi->cmd_axi_dma,
+					      GFP_KERNEL | GFP_DMA32);
+	if (!dsi->cmd_axi_cpu) {
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate DSI AXI Access command buffer\n");
+	}
+
 	ret = rcar_mipi_dsi_parse_dt(dsi);
 	if (ret < 0)
 		return ret;
@@ -1309,6 +1335,8 @@ static void rcar_mipi_dsi_remove(struct platform_device *pdev)
 {
 	struct rcar_mipi_dsi *dsi = platform_get_drvdata(pdev);
 
+	dma_free_coherent(&pdev->dev, SZ_4K, dsi->cmd_axi_cpu, dsi->cmd_axi_dma);
+
 	mipi_dsi_host_unregister(&dsi->host);
 }
 
-- 
2.53.0

