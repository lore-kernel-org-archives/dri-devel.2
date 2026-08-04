Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0F9C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DF510E134;
	Tue,  4 Aug 2026 08:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcLF7v8C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046CB10E134
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:52:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D130D60A6C;
 Tue,  4 Aug 2026 08:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B24E1F000E9;
 Tue,  4 Aug 2026 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785833553;
 bh=WbndRrAXIWPrOEXxolBjTOmspO92ODUAQ4RiT0Y9wMQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bcLF7v8Cuz0/B0aPApHAaBwPWu5b/8T0Sw7uLM4Knh09lUa4a8GQmrtX9fcJj+m8q
 +LEfuxkYLzsvW8lseplQ8xr5Iy98NRIBza9JRsBk5znMs0fFjAjHzAKDDJrGF6Asgf
 Vhfr/AhdpQZqkS/CllbepIRaJdqZ+4Ea8bBDG8OSVqB/zGcROF4rbsP8ErYhxjUtwg
 IkhCQGBCvyNdv7zRmLYLse+Bz83S2rMK8hRda0JdHtAO8XcpPdRXynJaJBTMFKg4xP
 HG3gS0VeZnmJiJcEsp7psXBIL55Tb4qBj9Rr3LTpG6MWEotWYyuKrnUIiqqgjIr32g
 gN37VOsha8UBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/omap: dsi: avoid sending bta sync all the time
 in writes
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
References: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:52:32 +0000
Message-Id: <20260804085233.5B24E1F000E9@smtp.kernel.org>
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

New issues:
- [High] Missing error interrupt registration causes a 500ms hang on transm=
ission errors and leaves uncleared error state that corrupts subsequent tra=
nsfers.

Pre-existing issues:
- [Critical] On-stack completion variable is vulnerable to a stack use-afte=
r-free because `dsi_unregister_isr_vc` does not synchronize with the lockle=
ss IRQ handler.
- [High] A TOCTOU race condition exists between the completion handler waki=
ng up the thread and the IRQ handler recording the hardware error, causing =
missed errors.
- [High] Integer overflow in the payload length check in `dsi_vc_send_long`=
 allows bypassing FIFO size limits, leading to out-of-bounds memory reads.
--

--- Patch [1]: [PATCH v6] drm/omap: dsi: avoid sending bta sync all the tim=
e in writes ---
commit 22196015575a94cb0f42ab30e98b88108820f40e
Author: Andreas Kemnade <andreas@kemnade.info>

drm/omap: dsi: avoid sending bta sync all the time in writes

Some chips need configuration commands to be sent first, before they can
send data. This patch avoids sending bta sync during writes if no acks
are requested, instead waiting for the packet to be sent.

Link: https://patch.msgid.link/20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.=
info
Link: https://patch.msgid.link/20260628-vm-upstr-v3-1-9e9add93378b@kemnade.=
info
Link: https://patch.msgid.link/20260529-vm-upstr-v2-1-24c30671719f@kernel.o=
rg
Link: https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch1-2026=
0529-vm-upstr-v2-1-24c30671719f@kernel.org/
Link: https://patch.msgid.link/20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.o=
rg

> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
[ ... ]
> @@ -2194,28 +2191,45 @@ static int dsi_vc_send_null(struct dsi_data *dsi,=
 int vc, int channel)
>  static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>  			       const struct mipi_dsi_msg *msg)
>  {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>  	struct dsi_data *dsi =3D to_dsi_data(dssdev);
> +	u32 err;
>  	int r;
> =20
> +	/* wait for IRQ for packet transmission confirmation */
> +	r =3D dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +				&completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
> +		return r;
> +
>  	if (mipi_dsi_packet_format_is_short(msg->type))
>  		r =3D dsi_vc_send_short(dsi, vc, msg);
>  	else
>  		r =3D dsi_vc_send_long(dsi, vc, msg);

[Severity: High]
This isn't a bug introduced by this patch, but does the payload length
check in dsi_vc_send_long() properly handle integer overflow?

In dsi_vc_send_long():

    if (dsi->vc[vc].tx_fifo_size * 32 * 4 < msg->tx_len + 4) {

If msg->tx_len is very large (e.g., near SIZE_MAX), msg->tx_len + 4 could
wrap around to a small number, evaluating the condition to false and
bypassing the safety check. Could this lead to out-of-bounds memory reads
from msg->tx_buf when the function iterates msg->tx_len >> 2 times?

> =20
> -	if (r < 0)
> +	if ((!r) && wait_for_completion_timeout(&completion,
> +				msecs_to_jiffies(500)) =3D=3D 0)
> +		r =3D -EIO;
> +
> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +			      &completion, DSI_VC_IRQ_PACKET_SENT);

[Severity: Critical]
This is a pre-existing issue, but does unregistering the ISR here leave us
vulnerable to a stack use-after-free?

If wait_for_completion_timeout() expires, the function proceeds to unregist=
er
the ISR and return, which destroys the stack frame containing the completion
variable.

However, dsi_unregister_isr_vc() only removes the handler under a spinlock.
Concurrently, omap_dsi_irq_handler() creates a lockless copy:

omap_dsi_irq_handler()
    dsi_handle_isrs(&dsi->isr_tables_copy, ...);

If the interrupt fires just as the timeout expires, could the IRQ handler
execute dsi_completion_handler from its local copy and call complete() on
the now-dangling completion pointer?

> +	if (r)
>  		return r;

[Severity: High]
Is there a missing error interrupt registration for this new wait block?

When registering the ISR earlier in this function, only DSI_VC_IRQ_PACKET_S=
ENT
is used, omitting DSI_IRQ_ERROR_MASK. If a hardware transmission error occu=
rs
(e.g., sync lost), the packet is not sent and the PACKET_SENT interrupt nev=
er
fires.

Will this cause the thread to hang for 500ms and return -EIO early here?
Since it returns early, the new dsi_get_errors() cleanup block below is
bypassed. The global IRQ handler might still record the error in dsi->error=
s,
leaving it uncleared and falsely failing the next successful transfer.

> =20
> -	/*
> -	 * TODO: we do not always have to do the BTA sync, for example
> -	 * we can improve performance by setting the update window
> -	 * information without sending BTA sync between the commands.
> -	 * In that case we can return early.
> -	 */
> +	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
> =20
> -	r =3D dsi_vc_send_bta_sync(dssdev, vc);
> -	if (r) {
> -		DSSERR("bta sync failed\n");
> -		return r;
> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> +		r =3D dsi_vc_send_bta_sync(dssdev, vc);
> +		if (r) {
> +			DSSERR("bta sync failed\n");
> +			return r;
> +		}
> +	} else {
> +		err =3D dsi_get_errors(dsi);

[Severity: High]
This is a pre-existing issue, but is there a race condition between the
completion handler and the error state update?

If a packet completes but an error is simultaneously reported in the same I=
RQ,
omap_dsi_irq_handler() executes the ISRs before updating the global error
state:

omap_dsi_irq_handler()
    dsi_handle_isrs(...); // Calls complete(), waking the thread
    dsi_handle_irq_errors(...); // Updates dsi->errors

Can the awakened thread resume and read dsi->errors before the IRQ handler
updates it? This would cause dsi_get_errors() to read 0, missing the hardwa=
re
error, which might then falsely fail the next transmission.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-vm-upstr-v=
6-1-1bf3748b2fa3@kemnade.info?part=3D1
