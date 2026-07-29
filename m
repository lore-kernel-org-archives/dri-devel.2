Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EFAC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAA110EBA9;
	Wed, 29 Jul 2026 11:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Mkd/jsAF";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326C910EBA9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785325221; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YkCZ4YyuadrW1WX7YkA9OJV9m+4/hwNaqVNhr/Fmulcks7tuuD8otn5958FxQDDJ6OU15G2SbIA2pn93XriHssirTOjb1mASP5al5QmwtKePJkk/Be7VXycLlvx9kRiadv8opkEZtm0V1rgUxQ2zRg2jEqDuLCojMxute+c2gnc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785325221;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wQd1NqZlCCX6VhDNozvBKi94epNsHltx20+2BwdzdnU=; 
 b=cOlogG1JuHgZDaVCPsCsMLJ35PWlRuFMdIc+ULGnQ7+XTOhxE19nFNYYowRoAbB7P/OVIAqhvJW0mxBaqOnwp6GVGXc7zAMc9I0yZe2GuHEk7hVupJ/ChsYYrTRiFnHjzGcaDON7lRnEYLw/GOqzrEabwnP4qn8udJlZeHAcFYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785325221; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=wQd1NqZlCCX6VhDNozvBKi94epNsHltx20+2BwdzdnU=;
 b=Mkd/jsAFebJLFfx38K00wclEPlc2ny8CTt40AxUXGKreU4DC2KEmmy0gSUqqijtG
 GekCqVVakx+BNT3iJj3hNI6URG75BRwe+GJmJc0X+jaI9SsPpBB+d2677/837Gex4T5
 ZFqkQHlJI/sMnjprAyyQ8s5L9gvDwQO9qF/WLBqA=
Received: by mx.zohomail.com with SMTPS id 1785325220791608.7855802563574;
 Wed, 29 Jul 2026 04:40:20 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Date: Wed, 29 Jul 2026 13:40:17 +0200
Message-ID: <hYwWT5hnSGOYgXC5sTOMDg@collabora.com>
In-Reply-To: <20260729063431.363B61F000E9@smtp.kernel.org>
References: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
 <20260729-panthor-cache-flush-fix-v1-2-205921ed3c81@collabora.com>
 <20260729063431.363B61F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, 29 July 2026 08:34:30 Central European Summer Time sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The timeout fallback logic creates a TOCTOU race with the threaded IRQ handler, potentially causing subsequent requests to falsely succeed immediately.
> - [High] If a soft reset actually times out in hardware, the pending flag is never cleared, permanently breaking all future soft reset attempts.
> --
> 
> --- Patch [2]: [PATCH 2/3] drm/panthor: Revisit reqs_lock handling in flush/reset paths ---
> commit 179344ff59dcf475c58ff1e22983a6fa7e1203f4
> Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> drm/panthor: Revisit reqs_lock handling in flush/reset paths
> 
> This patch revisits the handling of the reqs_lock in the panthor driver's
> flush and reset paths. It switches from using spin_lock_irqsave() around a
> wait_event_timeout() block to using wait_event_lock_timeout() with standard
> spinlocks. This ensures the pending_reqs register is read and updated under
> the lock without unnecessarily disabling interrupts.
> 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> > index c013d6bf9a599..f015bde80abf0 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> [ ... ]
> > @@ -330,35 +330,34 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
> >  			     u32 l2, u32 lsc, u32 other)
> >  {
> [ ... ]
> > -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> > +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
> >  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> > -				msecs_to_jiffies(100))) {
> > -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > +				ptdev->gpu->reqs_lock, msecs_to_jiffies(100))) {
> >  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> >  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> >  			ret = -ETIMEDOUT;
> >  		else
> >  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this timeout fallback 
> logic create a race condition with the threaded IRQ handler?
> 
> If the timeout occurs because the threaded IRQ handler was delayed (e.g. by
> high CPU load), the fallback path clears the pending_reqs flag based on 
> INT_RAWSTAT, but it doesn't clear the physical interrupt via INT_CLEAR.
> 
> When the threaded IRQ handler eventually runs, won't it read the pending
> interrupt and clear pending_reqs again? If a subsequent request was submitted
> in the meantime, could its pending flag be spuriously cleared, causing its
> wait to falsely succeed immediately?

Not that the special case logic isn't in need of some explanation which
I do not have handy, but: no, there's no pre-existing TOCTOU here as
far as I can tell. If the threaded handler didn't run, it wouldn't have
woken up the waitqueue here.

The fallback likely shouldn't exist in the first place, since it'd only
modify pending_reqs if the timeout and event wakeup coincided, but we
acquired the spinlock and pending_reqs still hasn't updated, which is
impossible, because the wakeup is fired by the threaded handler with
the spinlock held after pending_reqs is updated.

If `ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0` is
false, the else branch is essentially a no-op.

> > -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  	}
> > +	spin_unlock(&ptdev->gpu->reqs_lock);
> >  
> >  	if (ret) {
> >  		panthor_device_schedule_reset(ptdev);
> [ ... ]
> > @@ -378,27 +377,25 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
> >  {
> [ ... ]
> > -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> > +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
> >  				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
> > +				ptdev->gpu->reqs_lock,
> >  				msecs_to_jiffies(100))) {
> > -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> >  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> >  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> >  			timedout = true;
> >  		else
> >  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> 
> [Severity: High]
> This is the same pre-existing race condition as in panthor_gpu_flush_caches(),
> where clearing the pending flag without clearing the hardware interrupt could
> allow a subsequent soft reset to succeed spuriously.
> 
> > -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  	}
> >  
> >  	if (timedout) {
> 
> [Severity: High]
> This is a pre-existing issue, but if a soft reset actually times out in
> hardware and timedout is set to true, does this early return bypass
> clearing GPU_IRQ_RESET_COMPLETED from pending_reqs?
> 
> Looking at the end of panthor_gpu_soft_reset(), there is a
> ptdev->gpu->pending_reqs = 0; after the timeout check. If we return early
> here via return -ETIMEDOUT, the pending flag is left set.
> 
> Would any subsequent calls to panthor_gpu_soft_reset() hit the drm_WARN_ON
> check at the start of the function, skip issuing the hardware command, and
> permanently fail with a timeout?
> 

The bigger problem is that none of the callers even care about whether
it timed out.



