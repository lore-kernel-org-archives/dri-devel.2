Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B23CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE2F10E714;
	Mon, 18 May 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dYcyfczt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C3710E705
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779091508;
 bh=MS/WhCu9qI/tob+jWShKPvtDV5/XzIYzpmHWCDdqxZ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dYcyfcztQCp85LYrltU+utElhzY3H1Tp1A3afm2KH/Ui187UE13jLjuKQztADE7R1
 AjlsqeyHXsUTgFo9NTBGOsOaaJG4ouIO1F1Y/zcSo7gitEWcVkNcwWenTk3hCaJQqf
 Yddf4lesoEc3o80zicslmBU8bcVuI7Ila9k0b1PgRuYIMqWhw62vWSo7tQg65SbuRc
 Ucq0tDMTbYASTLxWRVNFlQQAP6AiX43gr6h3V65P3Bx4lIvjZGZeNFk1gJvwUb6KOR
 5MNdv99VpnGMiqzbzINphECV/S6PLAjx9AKS1wjoFNKDt3mgcKt3Si/1N899kbp8DX
 +F52EVFgy1vEw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0EAB017E0234;
 Mon, 18 May 2026 10:05:08 +0200 (CEST)
Date: Mon, 18 May 2026 10:04:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] drm/panthor: Use the irqsave variant of
 spin_lock in panthor_gpu_irq_handler()
Message-ID: <20260518100457.3ac641ad@fedora>
In-Reply-To: <85837c7d-fe6c-4b07-b804-b6d113bab4e6@arm.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-10-95c614a739cb@collabora.com>
 <85837c7d-fe6c-4b07-b804-b6d113bab4e6@arm.com>
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

On Thu, 14 May 2026 16:26:25 +0100
Steven Price <steven.price@arm.com> wrote:

> On 12/05/2026 12:37, Boris Brezillon wrote:
> > This is not a bug per-se, because this lock is never taken in an
> > interrupt context, but it's not consistent with the other users of this
> > lock. We're also planning on transitioning GPU event processing to
> > a hard handler. Again, this alone wouldn't justify using the IRQ-safe
> > variant, because then this _lock/unlock sequence would be in the
> > hard-IRQ path, where IRQs are already disabled, but let's do it anyway,
> > to keep things consistent.
> > 
> > While at it, transition to a guard() instead of a plain lock/unlock
> > sequence.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Although this now leaves the lock in panthor_pwr_irq_handler() the odd
> one out...

Yeah, I realized I had overlooked the PWR IRQ after sending v2. I'll
transition that one to an hard handler in v3, and use the irqsave
variant there as well.

> 
> Thanks,
> Steve
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_gpu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> > index d0be758ea3e1..b9c51f8a051d 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > @@ -110,12 +110,11 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
> >  	if (status & GPU_IRQ_PROTM_FAULT)
> >  		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
> >  
> > -	spin_lock(&ptdev->gpu->reqs_lock);
> > +	guard(spinlock_irqsave)(&ptdev->gpu->reqs_lock);
> >  	if (status & ptdev->gpu->pending_reqs) {
> >  		ptdev->gpu->pending_reqs &= ~status;
> >  		wake_up_all(&ptdev->gpu->reqs_acked);
> >  	}
> > -	spin_unlock(&ptdev->gpu->reqs_lock);
> >  }
> >  
> >  static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
> >   
> 

