Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643F2C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9BF10E5B2;
	Sun,  9 Aug 2026 20:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UHZtAQyd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B8D10E5B2
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:05:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36865600B1;
 Sun,  9 Aug 2026 20:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B735E1F000E9;
 Sun,  9 Aug 2026 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786305912;
 bh=Md7wY/ruwLujf4Bte3bYw31vpaiymTb59DJrGh3F1zM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UHZtAQyd+EktTSjeOffm6S4RAcZVBkb0KsbhjJ6BAEqiIvGT+SK6TSi5+9cgP4Fra
 nKO0/wLTFpfsiuRWUyBandUeMXVlUc7wHWvMLbOQy0VYgjRcFlef6HYnD/SW+Z8nZs
 mzgetU2udzvSPLuQL/R60Qn5l/G0QCpfXwdJsg3pAxPLuFq0CR9343ZmfM48NbeAZi
 5XO7IHSxF8Jy2IeKNI90Qj9w6gfj34q9sSKesZFhrEAabG8gTqdnlbdPtNtcYj5LRm
 o2RDId4s4LdOjIGqGxqQ/dQEnaLfqr2VBKIkou2jJDIajYc6yZIaH1av1QTA9RXkrq
 Kd0jq01AQW7Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260809195831.842907-1-marek.vasut+renesas@mailbox.org>
References: <20260809195831.842907-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 20:05:12 +0000
Message-Id: <20260809200512.B735E1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] High Speed (HS) AXI command payload is silently truncated to 128 b=
ytes.
- [High] Use-After-Free of the AXI DMA buffer during device removal due to =
teardown order inversion.
- [High] Large TX payloads combined with an RX or ACK request are forced in=
to register mode and truncated.
- [Medium] Memory leak of the DMA coherent buffer on probe error paths.
--

--- Patch [1]: [PATCH] drm/rcar-du: dsi: Implement DSI command TX using AXI=
 memory access ---
commit b5f3f6a7ebb3a67c9d4682699f04e9f66eb46473
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsi: Implement DSI command TX using AXI memory access
   =20
This commit implements support for DSI command TX using AXI memory access
mode. It extends the packet transfer length up to 128 Bytes long in LP and
1024 Bytes long in HS by allocating a DMAble 4k page for large transfers.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_mipi_dsi.c
> index 6e46d6d99f3c0..c25218ca4320a 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> @@ -977,6 +981,7 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct =
mipi_dsi_host *host,
>  					      bool is_rx_xfer)
>  {
>  	const bool is_tx_long =3D mipi_dsi_packet_format_is_long(msg->type);
> +	const bool is_tx_axi =3D !is_rx_xfer && is_tx_long && (msg->tx_len > 16=
);

[Severity: High]
If a caller requests a transfer with a payload larger than 16 bytes and also
expects a response or requests an ACK (MIPI_DSI_MSG_REQ_ACK), is_tx_axi
evaluates to false. Will this cause the hardware to be misconfigured?

The packet header is instructed to transmit the full msg->tx_len, but since
it falls back to register mode, the payload is truncated to 16 bytes in the
TXCMPPD* registers. Does this lead to sending stale data or hardware
timeouts?

>  	struct rcar_mipi_dsi *dsi =3D host_to_rcar_mipi_dsi(host);
>  	struct mipi_dsi_packet packet;

[ ... ]

> @@ -1011,7 +1021,10 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(stru=
ct mipi_dsi_host *host,
>  			    TXCMPHDR_DATA1(packet.header[2]) |
>  			    TXCMPHDR_DATA0(packet.header[1]));
> =20
> -	if (is_tx_long) {
> +	if (is_tx_axi) {
> +		memcpy(dsi->cmd_axi_cpu, packet.payload,
> +		       min(msg->tx_len, 128));

[Severity: High]
Does this silently truncate High Speed (HS) AXI command payloads to 128
bytes?=20

The validation in rcar_mipi_dsi_host_transfer() explicitly allows up to 1024
bytes in HS mode, but this memcpy() caps the copy at 128 bytes regardless of
the actual requested transfer size.

> +	} else if (is_tx_long) {
>  		memcpy(payload, packet.payload,
>  		       min(msg->tx_len, sizeof(payload)));

[ ... ]

> @@ -1276,6 +1295,13 @@ static int rcar_mipi_dsi_probe(struct platform_dev=
ice *pdev)
>  	dsi->dev =3D &pdev->dev;
>  	dsi->info =3D of_device_get_match_data(&pdev->dev);
> =20
> +	dsi->cmd_axi_cpu =3D dma_alloc_coherent(&pdev->dev, SZ_4K, &dsi->cmd_ax=
i_dma,
> +					      GFP_KERNEL | GFP_DMA32);
> +	if (!dsi->cmd_axi_cpu) {
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Failed to allocate DSI AXI Access command buffer\n");
> +	}
> +
>  	ret =3D rcar_mipi_dsi_parse_dt(dsi);
>  	if (ret < 0)
>  		return ret;

[Severity: Medium]
Does this leak the DMA coherent buffer on probe error paths?=20
   =20
If an error occurs during rcar_mipi_dsi_probe() after dma_alloc_coherent()
succeeds (such as in rcar_mipi_dsi_parse_dt() or clock setup), the function
returns directly without calling dma_free_coherent().

[ ... ]

> @@ -1309,6 +1335,8 @@ static void rcar_mipi_dsi_remove(struct platform_de=
vice *pdev)
>  {
>  	struct rcar_mipi_dsi *dsi =3D platform_get_drvdata(pdev);
> =20
> +	dma_free_coherent(&pdev->dev, SZ_4K, dsi->cmd_axi_cpu, dsi->cmd_axi_dma=
);
> +
>  	mipi_dsi_host_unregister(&dsi->host);
>  }

[Severity: High]
Could this create a use-after-free of the AXI DMA buffer during device
removal?=20

The DMA buffer is freed before mipi_dsi_host_unregister() is called.
Unregistering the host detaches child DSI panels, triggering their remove
callbacks. If a panel driver sends DSI commands (like entering sleep mode)
during unbind, it will attempt to memcpy() into the already-freed
dsi->cmd_axi_cpu buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809195831.8429=
07-1-marek.vasut+renesas@mailbox.org?part=3D1
