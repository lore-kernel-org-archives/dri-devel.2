Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2BFCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0328B10E34E;
	Fri, 26 Jun 2026 11:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jGwD1bJR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12C610E34E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782474033;
 bh=ItFHcTXy/Z84JIIJJfgIO2Thrx6FCmqfpef5CRmRZc8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jGwD1bJRrj5LfWL2ZYzurU1hT0UPXZpiPM018loMgNPA0jjtHMe++LPIbW7xFhMPS
 58e/bYa09pzp4fnyQVWSD7y2KzMRx6hOJ2FasPGuI4gPwQmKlcvWHWlVrDcssqX8Ws
 sNqfNsYW4n4bdNQMmqDiAObrknW26W1kbeRumro5qAnh0JRr6QEcr34FNX1SgIVg+Y
 TIIdFBwPvb+U2vMbPZbzbkmD5UKR5Ce5y6EyWE3N8dMmdOqjRnN7S92plX3euZdk1v
 mXIKz68FMM2Na/9EHopPNzLWjkL++SBtHzFJ7capdAEGLeL2lih0y7C5WKnCLRkW0/
 Xb25gxtqH1BMg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B17517E018C;
 Fri, 26 Jun 2026 13:40:32 +0200 (CEST)
Date: Fri, 26 Jun 2026 13:40:28 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Chia-I Wu <olvaffe@gmail.com>, Karunika
 Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] drm/panthor: Fix theoretical IOMEM access in
 suspended state
Message-ID: <20260626134028.518607ea@fedora-2.home>
In-Reply-To: <aj5GkoBpmrpMWHSV@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-5-b67ed973fea6@collabora.com>
 <aj5GkoBpmrpMWHSV@e142607>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Fri, 26 Jun 2026 10:29:54 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Thu, Jun 25, 2026 at 02:40:31PM +0200, Boris Brezillon wrote:
> > In theory, our hardirq handler can be called while the device (and
> > thus the panthor_irq) is suspended, because the IRQ line is shared.
> > In practice though, in all the designs we've seen, the line is only
> > shared within the GPU, and because sub-component suspend state is
> > consistent (all-suspended or all-resumed), we shouldn't end up with
> > an interrupt triggered while we're suspended.
> > 
> > Fix the problem anyway, if nothing else, for our sanity.
> > 
> > Fixes: 0b2d86670a84 ("drm/panthor: Rework panthor_irq::suspended into panthor_irq::state")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=1
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.h | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> > index 35679bfa1f3a..a39386bd6382 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > @@ -512,9 +512,6 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
> >  	struct panthor_irq *pirq = data;							\
> >  	enum panthor_irq_state old_state;							\
> >  												\
> > -	if (!gpu_read(pirq->iomem, INT_STAT))							\
> > -		return IRQ_NONE;								\
> > -												\
> >  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> >  	old_state = atomic_cmpxchg(&pirq->state,						\
> >  				   PANTHOR_IRQ_STATE_ACTIVE,					\
> > @@ -522,6 +519,13 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
> >  	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
> >  		return IRQ_NONE;								\
> >  												\
> > +	if (!gpu_read(pirq->iomem, INT_STAT)) {							\
> > +		atomic_cmpxchg(&pirq->state,							\
> > +			       PANTHOR_IRQ_STATE_PROCESSING,					\
> > +			       PANTHOR_IRQ_STATE_ACTIVE);					\
> > +		return IRQ_NONE;								\
> > +	}											\  
> 
> Hmm,
> 
> I get it that you're trying to revert the effect of the previous atomic_cmpxchg() here but it feels
> like a better option would be to not do the swap at all if the state is not ACTIVE.

That's what [1] does, but it's not possible until we've made this
atomic -> lock-based transition, and I want a fix that's not dependent
on non-Fixes patches so we can backport it.

[1]https://lore.kernel.org/dri-devel/20260625-panthor-signal-from-irq-v5-8-8836a74e0ef9@collabora.com/
