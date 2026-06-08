Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC0CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4040510F6A0;
	Mon,  8 Jun 2026 16:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YAHXi37l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90DE10F6A0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:15:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8058D4425A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4365C1F00893;
 Mon,  8 Jun 2026 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780935317;
 bh=wKd421tzeRgMA27v3lrrlUWIjsinzebfDIVLpJlHeH0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YAHXi37lllxJrgvoyw0QlPKEtKCW7Y5cNsKqu1b/9rBQUYOHFy7sLE2nHv4TvumVf
 brDkxG5TrWaw+53IJIBlBnQGqZT3Nd/KvGBpdwC3iru80y9Xkir/eqmDJI0gy2MHCX
 nfvUg0vmp7bxTaBxEwvUhkV/zIvyANKhjXrjV9Tl1p9qlhwj6eiogdi3vW1Z++d6Jp
 QTQvTCc9XIEMX1T2CdF0jdSJhobhL6yF1ePC1v9VwVAQaqizA2xzkMn06BzbIUe5eO
 yzOJmF7lmi9spGAEOn3QBHwHLWFr1SkPVQR0c8ehmT5bUSQsGz7O7GgHw40jBXDKmw
 Wu3ttK6phHVQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/78] drm/bridge: nwl-dsi: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-27-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-27-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:15:16 +0000
Message-Id: <20260608161517.4365C1F00893@smtp.kernel.org>
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
- [High] The asynchronous DSI transfer operation is not properly canceled o=
n timeout, leaving `dsi->xfer` pointing to a popped stack frame. This cause=
s potential stack corruption if a delayed interrupt fires.
--

commit 83396eabd0228d642366b0524e14cdcca0036136
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: nwl-dsi: Switch to atomic_create_state

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated. Switch to the
atomic_create_state callback and its counterpart.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 3c9ae93c4f671..09992529f3d85 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -960,7 +960,7 @@ static u32 *nwl_bridge_atomic_get_input_bus_fmts(stru=
ct drm_bridge *bridge,
>  static const struct drm_bridge_funcs nwl_dsi_bridge_funcs =3D {
>  	.atomic_duplicate_state	=3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset		=3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state		=3D drm_atomic_helper_bridge_create_state,

[Severity: High]
This is a pre-existing issue, but I noticed a potential stack use-after-free
in the DSI transfer timeout path of this driver.

In nwl_dsi_host_transfer(), dsi->xfer is assigned a pointer to a
stack-allocated struct nwl_dsi_transfer. If wait_for_completion_timeout()
times out, the function returns without clearing the pointer:

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_host_transfer()
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

If a delayed hardware completion or spurious interrupt fires after the
timeout and the original stack frame has been destroyed,
nwl_dsi_finish_transmission() might dereference this dangling pointer and
mutate stack memory:

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_finish_transmission()
	struct nwl_dsi_transfer *xfer =3D dsi->xfer;
//...
		xfer->status =3D xfer->tx_len;
		end_packet =3D true;
//...
	if (end_packet)
		complete(&xfer->completed);

Should dsi->xfer be set to NULL in the timeout path before returning, or
should pending transfers be explicitly aborted to prevent the interrupt
handler from writing to an invalid stack address?

>  	.atomic_check		=3D nwl_dsi_bridge_atomic_check,
>  	.atomic_enable		=3D nwl_dsi_bridge_atomic_enable,
>  	.atomic_disable		=3D nwl_dsi_bridge_atomic_disable,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D27
