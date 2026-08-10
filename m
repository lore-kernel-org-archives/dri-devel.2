Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53EDC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E184210E78B;
	Mon, 10 Aug 2026 10:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fkWBatPn";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD15B10E78C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:04:53 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C7BA5E;
 Mon, 10 Aug 2026 12:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1786356218;
 bh=yQdZe9RRs+ShJ14GMJhSuql7BtFumMXPm4coSH46p30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fkWBatPndikYhSLylGsv/qWu0j9wax0c1zQlOKbCOTDnZfZKXRzji5+Ij6WaE9+t9
 JbT1YjlYQS6YBtRmFw+F6tawXwSXXJccq5X6uQmaLQfqgZwwcu+vj1iJxy++jE5UQe
 +W7t5gqZP3tAfdZJmLILpCy09uqRrfLefB9tdYuY=
Date: Mon, 10 Aug 2026 13:04:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
Message-ID: <20260810100451.GA2940644@killaraus.ideasonboard.com>
References: <20260809195831.842907-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809195831.842907-1-marek.vasut+renesas@mailbox.org>
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

Hi Marek,

Thank you for the patch.

On Sun, Aug 09, 2026 at 09:58:06PM +0200, Marek Vasut wrote:
> Currently, the driver supports register access mode for DSI command
> transfer, which limits both TX and RX to only 16 Bytes long packets.
> Implement support for DSI command TX using AXI memory access mode,
> which extends the packet transfer length up to 128 Bytes long in LP
> and 1024 Bytes long in HS. Support for DSI command RX using the AXI
> access mode is not implemented due to missing test hardware.
> 
> The implementation allocates a DMAble 4k page. In case the command
> transfer is longer than 16 Bytes, the payload is copied into the
> page and sent out using the AXI access mode, otherwise the register
> access mode is used.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: David Airlie <airlied@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   | 42 +++++++++++++++----
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> index 6e46d6d99f3c0..c25218ca4320a 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/math64.h>
> @@ -75,6 +76,9 @@ struct rcar_mipi_dsi {
>  	unsigned long mode_flags;
>  	unsigned int num_data_lanes;
>  	unsigned int lanes;
> +
> +	void *cmd_axi_cpu;
> +	dma_addr_t cmd_axi_dma;
>  };
>  
>  struct dsi_setup_info {
> @@ -977,6 +981,7 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct mipi_dsi_host *host,
>  					      bool is_rx_xfer)
>  {
>  	const bool is_tx_long = mipi_dsi_packet_format_is_long(msg->type);
> +	const bool is_tx_axi = !is_rx_xfer && is_tx_long && (msg->tx_len > 16);
>  	struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
>  	struct mipi_dsi_packet packet;
>  	u8 payload[16] = { 0 };
> @@ -987,9 +992,14 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct mipi_dsi_host *host,
>  	if (ret)
>  		return ret;
>  
> -	/* Configure LP or HS command transfer. */
> -	rcar_mipi_dsi_write(dsi, TXCMSETR, (msg->flags & MIPI_DSI_MSG_USE_LPM) ?
> -					   TXCMSETR_SPDTYP : 0);
> +	/* Configure LP or HS and register or AXI command transfer. */
> +	rcar_mipi_dsi_write(dsi, TXCMSETR, ((msg->flags & MIPI_DSI_MSG_USE_LPM) ?
> +					    TXCMSETR_SPDTYP : 0) |
> +					   (is_tx_axi ? TXCMSETR_LPPDACC : 0));
> +
> +	/* Configure DMA source address for AXI command transfer. */
> +	if (is_tx_axi)
> +		rcar_mipi_dsi_write(dsi, TXCMADDRSET0R, dsi->cmd_axi_dma);
>  
>  	/* Register access mode for RX transfer. */
>  	if (is_rx_xfer)
> @@ -1011,7 +1021,10 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct mipi_dsi_host *host,
>  			    TXCMPHDR_DATA1(packet.header[2]) |
>  			    TXCMPHDR_DATA0(packet.header[1]));
>  
> -	if (is_tx_long) {
> +	if (is_tx_axi) {
> +		memcpy(dsi->cmd_axi_cpu, packet.payload,
> +		       min(msg->tx_len, 128));
> +	} else if (is_tx_long) {
>  		memcpy(payload, packet.payload,
>  		       min(msg->tx_len, sizeof(payload)));
>  
> @@ -1162,10 +1175,16 @@ static ssize_t rcar_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  	struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
>  	int ret;
>  
> -	if (msg->tx_len > 16 || msg->rx_len > 16) {
> -		/* ToDo: Implement Memory on AXI bus command mode. */
> +	if (msg->tx_len > 1024 || msg->rx_len > 16) {
> +		/* ToDo: Implement Memory on AXI bus RX command mode. */
>  		dev_warn(dsi->dev,
> -			 "Register-based command mode supports only up to 16 Bytes long payload\n");
> +			 "Command mode supports only up to 1024B long TX and 16B long RX payload\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if ((msg->flags & MIPI_DSI_MSG_USE_LPM) && msg->tx_len > 128) {
> +		dev_warn(dsi->dev,
> +			 "Command mode in LP supports only up to 128B long TX payload\n");
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -1276,6 +1295,13 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
>  	dsi->dev = &pdev->dev;
>  	dsi->info = of_device_get_match_data(&pdev->dev);
>  
> +	dsi->cmd_axi_cpu = dma_alloc_coherent(&pdev->dev, SZ_4K, &dsi->cmd_axi_dma,
> +					      GFP_KERNEL | GFP_DMA32);

I think setting the DMA mask for the device is preferred over using
GFP_DMA32.

> +	if (!dsi->cmd_axi_cpu) {
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Failed to allocate DSI AXI Access command buffer\n");
> +	}

No need for curly braces.

> +
>  	ret = rcar_mipi_dsi_parse_dt(dsi);

The allocated memory is leaking in error paths.

>  	if (ret < 0)
>  		return ret;
> @@ -1309,6 +1335,8 @@ static void rcar_mipi_dsi_remove(struct platform_device *pdev)
>  {
>  	struct rcar_mipi_dsi *dsi = platform_get_drvdata(pdev);
>  
> +	dma_free_coherent(&pdev->dev, SZ_4K, dsi->cmd_axi_cpu, dsi->cmd_axi_dma);
> +
>  	mipi_dsi_host_unregister(&dsi->host);
>  }
>  

-- 
Regards,

Laurent Pinchart
