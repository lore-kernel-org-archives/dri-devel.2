Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F17C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0426C10F153;
	Thu, 20 Aug 2026 17:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TWq7Clnc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4525010F153
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F41B041AE4;
 Thu, 20 Aug 2026 17:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22DE1F00A3A;
 Thu, 20 Aug 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787248158;
 bh=cje4bW3SvUmgJdWr4uxnOfmvpXuI4O8M5V7TTBEfSfU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TWq7ClncN0BQia13lWFkB6xquJZqix61rfCMSM0hwTD/fj6ab1hGjWEywt0FrMJBg
 RMBi+0ny/iOAQuGjcpfDGXdNUNbvtAuxyWAqiRvAgASYl/nL6mbloGuX6YsfNSqa35
 fiN6jgGlApmt0xUbK1F9i+P/HNPwtobBjoI9ei9OMnEArtKbNgtJ83fqCh1fY0kXKa
 pIYTAwF75swRjgGzKT7G/8TmZJ/O+ov/ru6NXOsg86XzvjK2k5ZbS71cB85+Qv0gmE
 YIDaqGOXJB1nGwnsprtPrSwI8f29+ZAlW/BOzOAfpy1cets5DfUtPXjgw3S/Gplej/
 Hs/q+2Lnxq03w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260820173937.55008-1-marek.vasut+renesas@mailbox.org>
References: <20260820173937.55008-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:49:18 +0000
Message-Id: <20260820174918.A22DE1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] AXI command transfer payloads are incorrectly capped at 128 bytes =
for High Speed (HS) transfers, truncating payloads and causing a compilatio=
n error.
- [High] Long TX commands (>16 bytes) that request an ACK or expect RX data=
 bypass AXI mode, falling back to register mode where they are silently tru=
ncated to 16 bytes.
--

--- Patch [1]: [PATCH v2] drm/rcar-du: dsi: Implement DSI command TX using =
AXI memory access ---
commit be1d10f7046189958d60166cb7834225e599f379
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsi: Implement DSI command TX using AXI memory access

This commit implements support for DSI command TX using AXI memory access
mode for the rcar-du driver. It extends the packet transfer length up to
128 bytes in LP mode and 1024 bytes in HS mode, falling back to register
access mode for smaller packets.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_mipi_dsi.c
> index 6e46d6d99f3c0..8a380cbe72bbb 100644
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
If a long TX command (greater than 16 bytes) requests an ACK or expects RX
data, is_rx_xfer will be true, making is_tx_axi false.=20

Will this cause the transfer to fall back to register mode where the payload
is silently truncated to 16 bytes, while the hardware header is programmed
with the full msg->tx_len?

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
Does this hardcoded 128-byte limit truncate High Speed (HS) transfers, which
are allowed to be up to 1024 bytes long according to the newly added limits=
 in
rcar_mipi_dsi_host_transfer()?

Additionally, does using min() here cause a compilation warning or error du=
e to
a type mismatch between msg->tx_len (size_t) and 128 (signed int)?

> +	} else if (is_tx_long) {
>  		memcpy(payload, packet.payload,
>  		       min(msg->tx_len, sizeof(payload)));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820173937.5500=
8-1-marek.vasut+renesas@mailbox.org?part=3D1
