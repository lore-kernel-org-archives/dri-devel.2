Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374C2C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D82410E61B;
	Thu, 10 Sep 2026 18:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UNnF0pnZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ED410E61B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:29:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DC754359D;
 Thu, 10 Sep 2026 18:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCDB1F000FF;
 Thu, 10 Sep 2026 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789064999;
 bh=wgQ4x38GerwXpCXBb//Lm4GWfSh9m6sY6nwr2F77ytY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UNnF0pnZz60stjpGoAEYeWWJxlQVaaMa5A7gh6ZJ9lpV0omRlObcqW/z/w5bvzqYs
 A1n6t3cD/cEiiJXghERsD3HSKBWUxMKYx14NGysmDYLXp95aZ7z5vzAA3Qj88xI1AN
 2DYlNrVgh48x3NGJFLCDc48Uawe1J46aO7u9rBqdGkGMaQsXXolRF0tcK341rtk1ax
 +H9UPXWKnQcN1Uq2PzbVoccXkv9qmG2uUZGldF0Ej19EGII5kk7lPfwv/5sOnIn4V0
 m5tfrSjJhmkTo89lF9F+8+8argDCJxfgLqdGxTxAs9Uz1y2PJNNJ/7EaFU1phB4wLr
 WeSugCkfIMDMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260910182003.31612-1-marek.vasut+renesas@mailbox.org>
References: <20260910182003.31612-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:29:58 +0000
Message-Id: <20260910182958.EFCDB1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent truncation of TX payloads > 16 bytes when a transfer reques=
ts an ACK or involves an RX response, leading to hardware desynchronization.
--

commit 13f2cd4029598c96fbe1cf82c539c77f33326afa
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsi: Implement DSI command TX using AXI memory access

Currently, the driver supports register access mode for DSI command
transfer, which limits both TX and RX to only 16 Bytes long packets.
Implement support for DSI command TX using AXI memory access mode,
which extends the packet transfer length up to 128 Bytes long in LP
and 1024 Bytes long in HS.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_mipi_dsi.c
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c

[ ... ]

> @@ -977,6 +981,7 @@ static ssize_t rcar_mipi_dsi_host_tx_transfer(struct =
mipi_dsi_host *host,
>  					      bool is_rx_xfer)
>  {
>  	const bool is_tx_long =3D mipi_dsi_packet_format_is_long(msg->type);
> +	const bool is_tx_axi =3D !is_rx_xfer && is_tx_long && (msg->tx_len > 16=
);

[Severity: High]
If a DSI panel driver initiates a transfer with a payload > 16 bytes and
requests an ACK (by setting MIPI_DSI_MSG_REQ_ACK in msg->flags), is_rx_xfer
evaluates to true. Does this unintentionally force the driver to bypass AXI
mode and use register mode, regardless of tx_len?

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
> +		       min(msg->tx_len, 1024));
> +	} else if (is_tx_long) {
>  		memcpy(payload, packet.payload,
>  		       min(msg->tx_len, sizeof(payload)));

[Severity: High]
When AXI mode is bypassed for a long write (because is_rx_xfer is true),
the payload is silently truncated to 16 bytes here. Since the hardware head=
er
will still expect the full transfer size, can this starve the hardware FIFO,
leading to garbage data transmission and a DSI link timeout?

[ ... ]

> @@ -1162,10 +1175,16 @@ static ssize_t rcar_mipi_dsi_host_transfer(struct=
 mipi_dsi_host *host,
>  	struct rcar_mipi_dsi *dsi =3D host_to_rcar_mipi_dsi(host);
>  	int ret;
> =20
> -	if (msg->tx_len > 16 || msg->rx_len > 16) {
> -		/* ToDo: Implement Memory on AXI bus command mode. */
> +	if (msg->tx_len > 1024 || msg->rx_len > 16) {
> +		/* ToDo: Implement Memory on AXI bus RX command mode. */
>  		dev_warn(dsi->dev,
> -			 "Register-based command mode supports only up to 16 Bytes long paylo=
ad\n");
> +			 "Command mode supports only up to 1024B long TX and 16B long RX payl=
oad\n");
> +		return -EOPNOTSUPP;
> +	}

[Severity: High]
This overarching validation check permits transfers with tx_len > 16 to
proceed even if is_rx_xfer is true. Since AXI mode isn't supported for RX
transfers, and long writes requiring an ACK are forced to bypass AXI mode,
should this block tx_len > 16 when is_rx_xfer is true to prevent silent
truncation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910182003.3161=
2-1-marek.vasut+renesas@mailbox.org?part=3D1
