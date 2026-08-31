Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05976C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E03C10E84C;
	Mon, 31 Aug 2026 13:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NUCNEISH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47BA610E84C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:34:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F1B2436D7;
 Mon, 31 Aug 2026 13:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB07A1F00A3E;
 Mon, 31 Aug 2026 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183289;
 bh=YyAA/wLRsulI5gtoVLh39F9ji1RQ9qlSUoAlklF3EHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NUCNEISHDp9WzFAOZ1+LN6KwsQcaPekaEEHCUlFpjmG0I1yygm1LFVvxva5OCbVK2
 kq/MsldXYu09db7pNETMHn+41bU855gVEe1FaUWhA81Cy4MzByn3TOu5ZDCJn+R1o5
 T+JnGmOKsJDoCLNNUyQd7qx3yrp1uFPqaGeY3NOpb6NxfhTPlGf8fKodzRzSe31vXe
 oinOs5FV2rupVqv7VpMNj9YP4cUnQMDDa69oQlehWKLA2oBkOnWZ+q6vwlXIQCpfTo
 c/NiP3MuWBTGMWNHnHPQEqR+QHUPh+FiMuIGnRPYFa52HPrVZkbRrQ1a1MyXbd4n7K
 hIGWi419m421Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] drm/bridge: nwl-dsi: Cleanup endpoint mux
 control selection
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-nwl-dsi-fixes-v4-1-6a2a1cb23910@geanix.com>
References: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
 <20260831-nwl-dsi-fixes-v4-1-6a2a1cb23910@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:34:48 +0000
Message-Id: <20260831133448.DB07A1F00A3E@smtp.kernel.org>
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
- [High] Dangling pointer to stack variable left in dsi->xfer after transfe=
r completes or times out.
--

commit dea46a0fff2442d283e886a1f263495c782e6706
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Cleanup endpoint mux control selection

This commit cleans up the endpoint mux control selection by storing the
endpoint value in the nwl_dsi struct instead of using a boolean flag. It us=
es
the proper endpoint define values for mux_control_try_select().

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 09992529f3d85..80e26a947ae69 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -110,6 +110,8 @@ struct nwl_dsi {
>  	int error;
> =20
>  	struct nwl_dsi_transfer *xfer;
[Severity: High]
This isn't a bug introduced by this patch, but looking at how dsi->xfer is
handled, could it leave a dangling pointer to a stack variable?

In nwl_dsi_host_transfer(), dsi->xfer is assigned a pointer to a local stack
variable:

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_host_transfer() {
	struct nwl_dsi_transfer xfer;
	...
	dsi->xfer =3D &xfer;
	...
	if (!wait_for_completion_timeout(&xfer.completed,
					 NWL_DSI_MIPI_FIFO_TIMEOUT)) {
		DRM_DEV_ERROR(dsi_host->dev, "[%02X] DSI transfer timed out\n",
			      xfer.cmd);
		ret =3D -ETIMEDOUT;
	} else {
		ret =3D xfer.status;
	}

	clk_disable_unprepare(dsi->rx_esc_clk);

	return ret;
}

When this function returns (either on success or timeout), dsi->xfer is not
cleared. If a delayed or spurious hardware interrupt fires afterwards,
nwl_dsi_irq_handler() calls nwl_dsi_finish_transmission():

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_finish_transmission() {
	struct nwl_dsi_transfer *xfer =3D dsi->xfer;
	bool end_packet =3D false;

	if (!xfer)
		return;

	if (xfer->direction =3D=3D DSI_PACKET_SEND &&
	    status & NWL_DSI_TX_PKT_DONE) {
		xfer->status =3D xfer->tx_len;
	...
}

Does this cause the interrupt handler to dereference and write to the popped
stack frame of nwl_dsi_host_transfer(), potentially corrupting the memory of
whatever thread is currently executing?

> +
> +	unsigned int endpoint;
>  };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-nwl-dsi-fi=
xes-v4-0-6a2a1cb23910@geanix.com?part=3D1
