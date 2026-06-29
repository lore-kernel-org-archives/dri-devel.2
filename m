Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FA7C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131E510E081;
	Mon, 29 Jun 2026 12:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="cNt3EdhW";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F0F10E840
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=TNQlr+faI3TO4fVi/XZUbvkD64iV2T4NOc8w24a6S/Q=; t=1782734458; x=1783944058; 
 b=cNt3EdhWeEEx5EsExqCFVinhnc/oKh/4jw71B9RQJLJhdfzXrfCuBFWIf6EIwSGsw1ujLtmsRbB
 bDJoIogI670UmOled8H0remR18IKoeiRsnL7MC6lsMRbQnXd3+8q4EN0ljROSYqbiv0/4jWSB1qyQ
 TgCifGqKQ6Lg2VS2RfcPT+9F5/fzeJ8gA6PJSje4GOGpmb/ibWjwFCwYi0mpRbkPFS9cfP8h+KnnI
 PFD3YzprFkc+E4ZwY5eju8i0q3haYODklwys0UEg8RsjA/CLGwrNfE89QzEMwJ7ZV+DUHGK3KNdCZ
 bAvkpbCFza79TW2T1IhL8DEhbNC7tdVicqUg==;
Date: Mon, 29 Jun 2026 14:00:52 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/omap: dsi: avoid sending bta sync all the time
 in writes
Message-ID: <20260629140052.37b7096e@kemnade.info>
In-Reply-To: <20260628142654.01D4E1F000E9@smtp.kernel.org>
References: <20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info>
 <20260628142654.01D4E1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 28 Jun 2026 14:26:53 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Missing wait/pacing for short packets leads to TX FIFO overflows and transmission failures.
> - [High] The wait for a long packet's transmission can be prematurely satisfied by the PACKET_SENT interrupt of a preceding short packet.
> 
> Pre-existing issues:
> - [High] A race condition during timeout handling causes a use-after-free on a stack-allocated completion object due to lockless IRQ dispatch.
> --
> 
> commit 13757a7bc4e8503b706178de5f3a86e797b3589f
> Author: Andreas Kemnade <andreas@kemnade.info>
> 
> drm/omap: dsi: avoid sending bta sync all the time in writes
> 
> This patch modifies the DSI write logic to avoid sending a BTA sync on
> every write unless acknowledgments are explicitly requested. Instead,
> it waits for the packet transmission to complete to prevent FIFO overflows.
> This change allows configuration of chips like the TC358762 that require
> specific commands before they can send data.
> 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > index 27fe7bca9e2cf..f7079a49e824e 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > @@ -2194,28 +2194,39 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
> >  static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
> >  			       const struct mipi_dsi_msg *msg)
> >  {
> > +	DECLARE_COMPLETION_ONSTACK(completion);
> >  	struct dsi_data *dsi = to_dsi_data(dssdev);
> >  	int r;
> >  
> >  	if (mipi_dsi_packet_format_is_short(msg->type))
> >  		r = dsi_vc_send_short(dsi, vc, msg);
> > -	else
> > +	else {  
> 
> [Severity: High]
> The commit message states "wait for the packet to be sent to avoid FIFO
> overflows", but does this code omit that wait for short packets?
> 
I would switch back to also wait there and have that confirmed by Ivo.
My testing was also done with short packets, so apparently the interrupt
comes there, too, so I can probably go back to the v1 way of doing things.

> If a panel driver sends a rapid sequence of short DCS configuration
> commands, it appears dsi_vc_send_short() will push to the FIFO and
> return immediately. Since the unconditional dsi_vc_send_bta_sync() was
> removed, could this lack of pacing cause the TX FIFO to overflow during
> consecutive short writes?
> 
as said, I can turn back.

> > +		/* wait for IRQ for long packet transmission confirmation */
> > +		r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> > +					&completion, DSI_VC_IRQ_PACKET_SENT);  
> 
> [Severity: High]
> Because short packets return immediately without waiting, what happens if
> a short packet is followed immediately by a long packet?
> 
which would also avoid this problem. 

> If the short packet finishes transmitting after the DSI_VC_IRQ_PACKET_SENT
> status is cleared by dsi_register_isr_vc() for the long packet, will the
> short packet's completion interrupt fire and prematurely satisfy the
> wait_for_completion_timeout() for the long packet?
> 
> > +		if (r)
> > +			return r;
> > +
> >  		r = dsi_vc_send_long(dsi, vc, msg);
> >  
> > -	if (r < 0)
> > +		if ((!r) && wait_for_completion_timeout(&completion,
> > +					msecs_to_jiffies(500)) == 0)
> > +			r = -EIO;
> > +
> > +		dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> > +				      &completion, DSI_VC_IRQ_PACKET_SENT);  
> 
> [Severity: High]
> This is a pre-existing issue, but can this sequence lead to a
> use-after-free on the stack-allocated completion object?
> 
> If the 500ms timeout expires, the thread wakes up, unregisters the ISR,
> returns -EIO, and destroys the stack frame. However, omap_dsi_irq_handler()
> makes a copy of the ISR table and executes handlers locklessly:
> 
> omap_dsi_irq_handler() {
>     memcpy(&dsi->isr_tables_copy, &dsi->isr_tables, sizeof(dsi->isr_tables));
>     spin_unlock(&dsi->irq_lock);
>     dsi_handle_isrs(&dsi->isr_tables_copy, ...);
> }
> 
> If a delayed hardware interrupt fires concurrently, could the IRQ handler
> invoke dsi_completion_handler() from its local copy and call complete() on
> the now-destroyed stack pointer, since it doesn't synchronize with
> dsi_unregister_isr_vc()?
> 
I looked around, the idea beding this copy seems to be invalid:
 /* make a copy and unlock, so that isrs can unregister
         * themselves */

nobody seems to do that. I will send a separate patch to remove that copy.

Regards,
Andreas
