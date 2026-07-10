Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68E3C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B3310E1DC;
	Fri, 10 Jul 2026 14:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H3COwlnE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56DE10E1DC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:09:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB36F43B55;
 Fri, 10 Jul 2026 14:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6F01F000E9;
 Fri, 10 Jul 2026 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783692550;
 bh=hBMrgBlPHIu/FnikY/JkWC060uPmmKPAa/V9ePxoPtc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H3COwlnEJBI2vJwgZOnhB2XkLo8UJktomT3tFExmw3+zoxSWq5fVazbVi78yNiiCk
 f3hVGHCeFwGks1S/p/cgzcTPGjLjL9n/vzep6L4y5WyofQihoAOVBrfDToS+1AqMyG
 Bq163GuTGqhWpQ2zQulx5278bMs/zQ7/6aLcQ9hdHTcMMm0DmqVP6jBRBJr7HQpXOM
 cRY1xJTHCJRPNL17olMv3iEPb+nhrcc0wYYjdTQtZuLqzuV1wmjPgLeDvlRLs/zlRA
 LJ5EcfCAMN2pbc9Q5XmpIDoZm/B6Q8qB20QUnxlMWSIvOO8fgaRJ0UTkyEQx+rRCUn
 qJDgVj74TnlJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: nwl-dsi: Limit LCDIF specific sync
 override
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710-nwl-dsi-fixes-v1-1-927d918a86ad@geanix.com>
References: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
 <20260710-nwl-dsi-fixes-v1-1-927d918a86ad@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:09:10 +0000
Message-Id: <20260710140910.6C6F01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Dangling pointer `dsi->xfer` leads to stack Use-After-Free if a ti=
meout or clock error occurs during transfer.
--

--- Patch [1]: [PATCH 1/3] drm/bridge: nwl-dsi: Limit LCDIF specific sync o=
verride ---
commit 36a9bfa60fd8b6568d59af4e95e04fc059970758
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Limit LCDIF specific sync override

When using DCSS with NWL, overriding the mode flags to enforce active high
sync is preventing the use of active low with downstream bridges, such as
ti-sn65dsi83, which will not see such mode flags set by the panel.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 3c9ae93c4f671..915e1bdc73c80 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -110,6 +110,8 @@ struct nwl_dsi {
>  	int error;
> =20
>  	struct nwl_dsi_transfer *xfer;

[Severity: High]
This is a pre-existing issue, but could this pointer lead to a stack
use-after-free if a timeout or clock error occurs during a transfer?

In nwl_dsi_host_transfer(), dsi->xfer is assigned the address of a local st=
ack
variable:

	struct nwl_dsi_transfer xfer;
	...
	dsi->xfer =3D &xfer;

If clk_prepare_enable(dsi->rx_esc_clk) fails, or if the DSI transfer times =
out
(wait_for_completion_timeout() returns 0), the function returns without
clearing dsi->xfer.

If a delayed or spurious hardware interrupt later triggers
nwl_dsi_irq_handler(), it will call nwl_dsi_finish_transmission() which
dereferences the dangling dsi->xfer pointer:

	xfer->status =3D xfer->tx_len;
	complete(&xfer->completed);

Because xfer was originally on the stack of the returned function, could th=
is
overwrite arbitrary stack memory of whatever thread happens to be running at
the time of the interrupt?

> +
> +	unsigned int endpoint;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-nwl-dsi-fi=
xes-v1-0-927d918a86ad@geanix.com?part=3D1
