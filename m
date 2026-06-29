Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EACC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5320D10E0A4;
	Mon, 29 Jun 2026 16:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zf64RDSn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCCDF10E0A4
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:04:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5127E43C87;
 Mon, 29 Jun 2026 16:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D001F000E9;
 Mon, 29 Jun 2026 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782749088;
 bh=y6/YenokjEaYKNREzsk6N2P1Nh+FZAUuHeS/tQjfJRM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zf64RDSnQ78UgsSCnQM5atQbKtYi9nw0liUKWGkj1wOra4gmrYv7lL6MYLHtmKl1X
 q2sly9CJCOWYz8pztwDZ4R2HbeTG0WpSrrMwXDJfGndLDgcfER32C2Ji4yMBYNHGK7
 VEUv4buMbfVAzvx700cwGliPEweGJ2rYBmiT+9JL5KCz23LeGa9MDnBhiexU7esUrj
 OgD/YHqZKBR7QVMyzsAiTVj9Z8EWj/vvMYORmiXHdRYRNvuq1Ll6AZlpBTTOEXuIhI
 Hvwalc1289zY4xt6JtEf314sOiUZNpnRaQIcIXFaKspkkQZClMhtAl/3UIYmNR9fJ2
 pf9wRsyhamEKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time
 in writes
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 16:04:47 +0000
Message-Id: <20260629160448.13D001F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Stack Use-After-Free due to race between IRQ handler and unregiste=
ring on-stack completion
- [Medium] Regression for command-mode panels due to missing DCS NOP and in=
correct channel for BTA
- [Medium] Missing Error IRQ registration causes a 500ms stall on hardware =
transmission errors
--

commit 30f75c50c586dd648e75b97e7fe46e6f3d854488
Author: Andreas Kemnade <andreas@kemnade.info>
Subject: drm/omap: dsi: avoid sending bta sync all the time in writes

This patch avoids sending a BTA sync during writes if no ACKs are requested,
instead waiting for the packet to be sent to prevent FIFO overflows. It also
replaces the NOP sent between frames with a BTA sync during channel updates.

> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index 27fe7bca9e2cf..3f22929c36e2a 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2194,28 +2194,38 @@ static int dsi_vc_send_null(struct dsi_data *dsi,=
 int vc, int channel)
>  static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>  			       const struct mipi_dsi_msg *msg)
>  {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>  	struct dsi_data *dsi =3D to_dsi_data(dssdev);
>  	int r;
> =20
> +	/* wait for IRQ for packet transmission confirmation */
> +	r =3D dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +				&completion, DSI_VC_IRQ_PACKET_SENT);

[Severity: Medium]
Will this stall for the full 500ms timeout if a hardware transmission error
occurs?

Since this is only registered for DSI_VC_IRQ_PACKET_SENT, an error interrupt
(like DSI_IRQ_HS_TX_TIMEOUT) wouldn't wake up the completion. Other functio=
ns
like dsi_vc_send_bta_sync() also register for DSI_IRQ_ERROR_MASK to handle
this case.

> +	if (r)
> +		return r;
> +
>  	if (mipi_dsi_packet_format_is_short(msg->type))
>  		r =3D dsi_vc_send_short(dsi, vc, msg);
>  	else
>  		r =3D dsi_vc_send_long(dsi, vc, msg);
> =20
> -	if (r < 0)
> +	if ((!r) && wait_for_completion_timeout(&completion,
> +				msecs_to_jiffies(500)) =3D=3D 0)
> +		r =3D -EIO;
> +
> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
>  		return r;

[Severity: High]
Could this lead to a stack use-after-free if the timeout is reached?

The wait_for_completion_timeout() can return 0 (timeout), after which
dsi_unregister_isr_vc() unregisters the ISR and the function returns,
destroying the on-stack completion.=20

However, dsi_unregister_isr_vc() doesn't appear to synchronize with the IRQ
handler. If the hardware IRQ fires right after the timeout and the handler
executes from its lockless copy of the ISR table, could it call
dsi_completion_handler() with a dangling pointer to the destroyed stack
frame?

[ ... ]

> @@ -3268,13 +3263,13 @@ static int dsi_update_channel(struct omap_dss_dev=
ice *dssdev, int vc)
>  	DSSDBG("dsi_update_channel: %d", vc);
> =20
>  	/*
> -	 * Send NOP between the frames. If we don't send something here, the
> +	 * Transition to LP here. If we don't send something here, the
>  	 * updates stop working. This is probably related to DSI spec stating
>  	 * that the DSI host should transition to LP at least once per frame.
>  	 */
> -	r =3D _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
> +	r =3D dsi_vc_send_bta_sync(dssdev, vc);

[Severity: Medium]
Will this break command-mode panels?

The original code explicitly sent a DCS NOP on VC_CMD (which is typically
configured for Low Power/CPU). This replaces it with a BTA sync on the vc
passed to the function, which is usually VC_VIDEO (configured as High
Speed/Video Port).

Is a BTA sync on a Video Port channel valid hardware behavior here? Also,
will panels that depend on receiving the DCS NOP payload to transition to
LP mode stop updating?

>  	if (r < 0) {
> -		DSSWARN("failed to send nop between frames: %d\n", r);
> +		DSSWARN("failed to send bta sync between frames: %d\n", r);
>  		goto err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-vm-upstr-v=
4-1-9f0c62d8808e@kemnade.info?part=3D1
