Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C716C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7273910E35D;
	Sun, 28 Jun 2026 14:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VkTQklak";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5874610E35D
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:26:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3312941AE6;
 Sun, 28 Jun 2026 14:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D4E1F000E9;
 Sun, 28 Jun 2026 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782656814;
 bh=gCF7YrUVTT5UW7zvWu2vz/3UR9SlUM4Lijd3nbXiIek=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VkTQklaklfZoOGuDA8hEzrUrgYprCNZaf8YE9OLJj47XnqKmNUU5IYkTbzyMQTWJg
 eEv+ScRQlTNSHLsl869o2FUWwU0hFMn/6ekVn7seTqR+pENOVyNziODPs31Wjyh9R9
 8skYRqnoejypUdn/OyZE2pLM0eV0qnAHhprg9oFHVHL54HqNW3BmNzyXktPoES9lap
 zjkpHvuZH5WTwttlL8QqjfHbJ+uznehNQU6mCkitEkkJ6mBcpvQDPcQpsRZLUKli20
 ybGUZQMfgY3cjPrHlzMh3U8U4D4gbeDW8cKQx4/LTuRFuA0hTAw8OooEr3TDnAl1Au
 c2shh3XHAI11Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/omap: dsi: avoid sending bta sync all the time
 in writes
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info>
References: <20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:26:53 +0000
Message-Id: <20260628142654.01D4E1F000E9@smtp.kernel.org>
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

New issues:
- [High] Missing wait/pacing for short packets leads to TX FIFO overflows a=
nd transmission failures.
- [High] The wait for a long packet's transmission can be prematurely satis=
fied by the PACKET_SENT interrupt of a preceding short packet.

Pre-existing issues:
- [High] A race condition during timeout handling causes a use-after-free o=
n a stack-allocated completion object due to lockless IRQ dispatch.
--

commit 13757a7bc4e8503b706178de5f3a86e797b3589f
Author: Andreas Kemnade <andreas@kemnade.info>

drm/omap: dsi: avoid sending bta sync all the time in writes

This patch modifies the DSI write logic to avoid sending a BTA sync on
every write unless acknowledgments are explicitly requested. Instead,
it waits for the packet transmission to complete to prevent FIFO overflows.
This change allows configuration of chips like the TC358762 that require
specific commands before they can send data.

> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index 27fe7bca9e2cf..f7079a49e824e 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2194,28 +2194,39 @@ static int dsi_vc_send_null(struct dsi_data *dsi,=
 int vc, int channel)
>  static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>  			       const struct mipi_dsi_msg *msg)
>  {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>  	struct dsi_data *dsi =3D to_dsi_data(dssdev);
>  	int r;
> =20
>  	if (mipi_dsi_packet_format_is_short(msg->type))
>  		r =3D dsi_vc_send_short(dsi, vc, msg);
> -	else
> +	else {

[Severity: High]
The commit message states "wait for the packet to be sent to avoid FIFO
overflows", but does this code omit that wait for short packets?

If a panel driver sends a rapid sequence of short DCS configuration
commands, it appears dsi_vc_send_short() will push to the FIFO and
return immediately. Since the unconditional dsi_vc_send_bta_sync() was
removed, could this lack of pacing cause the TX FIFO to overflow during
consecutive short writes?

> +		/* wait for IRQ for long packet transmission confirmation */
> +		r =3D dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +					&completion, DSI_VC_IRQ_PACKET_SENT);

[Severity: High]
Because short packets return immediately without waiting, what happens if
a short packet is followed immediately by a long packet?

If the short packet finishes transmitting after the DSI_VC_IRQ_PACKET_SENT
status is cleared by dsi_register_isr_vc() for the long packet, will the
short packet's completion interrupt fire and prematurely satisfy the
wait_for_completion_timeout() for the long packet?

> +		if (r)
> +			return r;
> +
>  		r =3D dsi_vc_send_long(dsi, vc, msg);
> =20
> -	if (r < 0)
> +		if ((!r) && wait_for_completion_timeout(&completion,
> +					msecs_to_jiffies(500)) =3D=3D 0)
> +			r =3D -EIO;
> +
> +		dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +				      &completion, DSI_VC_IRQ_PACKET_SENT);

[Severity: High]
This is a pre-existing issue, but can this sequence lead to a
use-after-free on the stack-allocated completion object?

If the 500ms timeout expires, the thread wakes up, unregisters the ISR,
returns -EIO, and destroys the stack frame. However, omap_dsi_irq_handler()
makes a copy of the ISR table and executes handlers locklessly:

omap_dsi_irq_handler() {
    memcpy(&dsi->isr_tables_copy, &dsi->isr_tables, sizeof(dsi->isr_tables)=
);
    spin_unlock(&dsi->irq_lock);
    dsi_handle_isrs(&dsi->isr_tables_copy, ...);
}

If a delayed hardware interrupt fires concurrently, could the IRQ handler
invoke dsi_completion_handler() from its local copy and call complete() on
the now-destroyed stack pointer, since it doesn't synchronize with
dsi_unregister_isr_vc()?

> +	}
> +	if (r)
>  		return r;
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-vm-upstr-v=
3-1-9e9add93378b@kemnade.info?part=3D1
