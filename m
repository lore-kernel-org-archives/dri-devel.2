Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C3610E9A4;
	Mon, 29 Jun 2026 16:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="6HRU96kK";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C464E10E9A4
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=7htlJ/iqKAhb3sxtbY07IJU41mzqAd4NW5lkYsgilx4=; t=1782751723; x=1783961323; 
 b=6HRU96kK6LmMhSC+L69kKzZjKZLxtnPBhkvZk83ZwiurfqHyo4/lSqG4niJNqHffunURB7Nw5Q5
 iEN3jEgDHn1nOR3cFCvZrn+X0NA8X6xbgLFXZEt4iCuTMOoOg318ur9kWd/BASxR1DfoWsdUdoav7
 pi7vbdGZLz3UvLuIYfmhP6fvelqRw89ExJHxhdbdW0dk4WfJKpIOPJTHRhiF8d5pE5Xtz4KRccJY5
 VvfJct1All/hdsWbeRhcgj+MadV3zvfDUtfsZZk2+rIanOjsD++wP+xF1EjtG7XLQKmLqqzZWgpys
 aczRGb22milS2EYbFhylsy4WUsG7LoPYTcoQ==;
Date: Mon, 29 Jun 2026 18:48:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time
 in writes
Message-ID: <20260629184837.7ffdec12@kemnade.info>
In-Reply-To: <20260629160448.13D001F000E9@smtp.kernel.org>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <20260629160448.13D001F000E9@smtp.kernel.org>
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

On Mon, 29 Jun 2026 16:04:47 +0000
sashiko-bot@kernel.org wrote:

> > @@ -3268,13 +3263,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
> >  	DSSDBG("dsi_update_channel: %d", vc);
> >  
> >  	/*
> > -	 * Send NOP between the frames. If we don't send something here, the
> > +	 * Transition to LP here. If we don't send something here, the
> >  	 * updates stop working. This is probably related to DSI spec stating
> >  	 * that the DSI host should transition to LP at least once per frame.
> >  	 */
> > -	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
> > +	r = dsi_vc_send_bta_sync(dssdev, vc);  
> 
> [Severity: Medium]
> Will this break command-mode panels?
> 
this was introduced to fix command mode panels in v2 and confirmed to do that.

> The original code explicitly sent a DCS NOP on VC_CMD (which is typically
> configured for Low Power/CPU). This replaces it with a BTA sync on the vc
> passed to the function, which is usually VC_VIDEO (configured as High
> Speed/Video Port).
>
original code indirectly also has sent a bta sync.
 
> Is a BTA sync on a Video Port channel valid hardware behavior here? Also,
> will panels that depend on receiving the DCS NOP payload to transition to
> LP mode stop updating?

The NOP packet (with the bta sync) was solely introduced to transition
to LP mode. It was confirmed that updating works with just the BTA sync.

Regards,
Andreas
