Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB526C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA1F10E11F;
	Wed, 23 Sep 2026 21:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YWIcHgJu";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078EC10E11F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 21:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790200324; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C30j4qnsHAOwT8Fx65sNvAdY9yITSAddrW4Ya92eJdwmUTzDpBUtxqd0cVBcqfzFn8e6WgJiO8ilTB6ub7YivLPte6GHrnXpUYnHjfwRVHH65lB5sr9MrKMFXwmrJq2ATS+hn0ca6Jqah+P1CMxpBjNlUyXG4caW1B3LuO63Cqc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790200324;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uOXdJTLZnP2nqLI/uIuWSrbbF84KAZB1fKnEXUgAS14=; 
 b=D2FGyw3DBGhZz6Bu90y3wntqAFC2yHm2T1oK7KUNlgoUbPA+2CrsQ4YVHwrYpgiVhHy8P0VMaARhzGAOdJrNS6Xdd1pq1JFGKzCnzsvv9N2tlFRm94rIw6HP2GJWoKN0TsgYqgwPNwqOZl5Kzo7LBjmwQF8xJv4yS0HAV5+F+FE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790200324; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=uOXdJTLZnP2nqLI/uIuWSrbbF84KAZB1fKnEXUgAS14=;
 b=YWIcHgJuQk8LW6UfDGZiFkqIhgh/Ggn47nLgO8ysS2C9MRHUeO5QP+c7wcF1vgb5
 GTupkRQiVgOX+k5RIDxc3jrDEg9KEWU87MozGkskRcXgcVog+l0DguEp7zh+clKpHdN
 GkYnToEOd2At5lmDCV4oq8NoA7P3SD6N0MTtbyeI=
Received: by smtp.zohomail.com with SMTPS id 1790200323922277.6380951213183;
 Wed, 23 Sep 2026 14:52:03 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:51:58 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <arQ8G6ba8jFRwhk7@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
 <20260914121657.2e9925c9@fedora-21.home>
 <arLg_vX52EGl-AMN@sobremesa>
 <20260923100849.573d4d92@fedora-32.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923100849.573d4d92@fedora-32.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.183.46
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

On 23.09.2026 10:08, Boris Brezillon wrote:
> On Wed, 23 Sep 2026 02:39:10 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > > > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> > > > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *state)
> > > >  {
> > > > -	u64 gpuva;
> > > > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > > > +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > > >  	int ret;
> > > >  
> > > > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > > > -	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > > > -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > > > -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > > > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > > > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > > > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > > > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > > +		perfcnt->dump_finished = false;
> > > > +		*state = 0;
> > > > +
> > > > +		if (!perfcnt->owns_as_ref) {
> > > > +			*state = PANFROST_PERFCNT_SESSION_DEAD;
> > > > +			return -EIO;
> > > > +		}
> > > > +
> > > > +		if (perfcnt->reset_happened) {
> > > > +			*state = PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > > > +			perfcnt->reset_happened = false;
> > > > +		}  
> > > 
> > > 		*state = perfcnt->state;  
> > 
> > I'm thinking maybe we don't need to set the ioctl output state here. Even if there was
> > a reset, if we recovered from it and didn't lose the AS reference, we might be able to
> > go forward as usual. In that case, counters would be measured since the latest reset
> > rather than the last successful dump, although maybe this is not an issue.
> 
> I think userspace needs to know about INTERRUPTED_BY_RESET, at the very
> least. But honestly, I'd keep it simple and propagate the state
> regardless of the flags userspace might or might not care about.

Agreed.

> > > > +	/*
> > > > +	 * Here we release the reset semaphore because perfcnt should not get in the way
> > > > +	 * of a HW reset. Besides, a legitimate reset might be issued during the wait.
> > > > +	 */
> > > >  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
> > > >  							msecs_to_jiffies(1000));
> > > > -	if (!ret)
> > > > -		ret = -ETIMEDOUT;
> > > > -	else if (ret > 0)
> > > > -		ret = 0;
> > > > +
> > > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > > +		/* Either sample finished or reset happened */
> > > > +		if (ret > 0) {
> > > > +			ret = perfcnt->dump_finished ? 0 :
> > > > +			      perfcnt->owns_as_ref ? -EAGAIN : -EIO;
> > > > +
> > > > +		} else if (!ret) {
> > > > +			ret = -ETIMEDOUT;
> > > > +		}
> > > > +
> > > > +		if (perfcnt->reset_happened)
> > > > +			*state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > > > +		if (!perfcnt->owns_as_ref)
> > > > +			*state |= PANFROST_PERFCNT_SESSION_DEAD;
> > > > +	}  
> > > 
> > > 	if (!ret)
> > > 		return -ETIMEDOUT;  
> > 
> > I was doing this check inside the guard because, in the time between the completion
> > is signalled and the semaphore locked, another reset could come right through.
> 
> I wouldn't worry about late signaling to be honest, the timeout is
> 1sec, which is way more than I would expect a DUMP request to take in
> a normal situation. Now, we might want to propagate the state in that
> case too, so it might make sense to return ETIMEDOUT inside the
> scoped_guard, after the state has been copied.

On a second thought, I agree with you. Not only is the completion timeout much longer
than the usual sample period, but also, in the event of a timeout (and no counters being
copied back to UM), I don't think a perfcnt user would care much about the reset state.

> > And then because I believed counter values were accumulated rather than reset between
> > consecutive dumps, it was best to notify the user as soon as possible, even if that
> > meant losing one legitimate frame.
> > 
> > > 	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > 		u32 new_state = perfcnt->state;
> > > 
> > > 		*state |= new_state;
> > > 		if (new_state & PANFROST_PERFCNT_SESSION_DEAD)
> > > 			return -EIO;
> > > 
> > > 		perfcnt->state = 0;  
> > 
> > I think this should not be here, because we're already resetting the state before
> > running the PERFCNT_SAMPLE GPU command, and also we need to check it right below.
> 
> I think we want to reset in both places, especially if we propagate the
> state before the DUMP too, otherwise we might leave the
> INTERRUPTED_BY_RESET bit behind even though we already informed
> userspace about this event in the previous DUMP request. And yes, the
> following test should have been on new_state instead of perfcnt->state,
> indeed.
> > 
> > > 		/* If we faced a reset during our SAMPLE, the user needs to try again. */
> > > 		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> > > 			return -EAGAIN;
> > > 	}  
> > 
> > The main reason I added the panfrost_perfcnt::dump_finished flag was that when a reset happens,
> > the GPU IRQ handler might've been already running in response to a finished perfcnt sample
> > command. However, the reset sequence might come off first and cancel the completion, leaving
> > us with a ret > 0 despite sampling having succeeded.
> > 
> > I'm thinking rather than trying to sort of patch this up precariously as I did in this revision,
> > I'll leave it the way you suggested and address the race between the GPU IRQ handler and the
> > reset sequence in a future series.
> 
> Yes, that's exactly what needs to be done: reset should synchronize
> IRQs, mask/suspend them while the reset sequence is happening, and
> unmask them when it's done. As for the completion of a DUMP request
> interrupted by a RESET, we want a ret > 0 (AKA no-timeout) in that
> case, but the perfcnt::state should be updated prior to that, so that
> this function knows exactly what to expect from this completion: if
> SESSION_INTERRUPTED_BY_RESET is set, it's likely that the DUMP didn't
> complete which is why I return EAGAIN in that case, but we can also have
> a dedicated flag for DUMP_COMPLETE if you want to be accurate (when
> set, DUMP is effective, when not set EAGAIN).

I'll leave dealing with the problem of synchronisation between reset and the IRQ
handlers to a later patch series, so in the meantime, SESSION_INTERRUPTED_BY_RESET
should always lead to EAGAIN being returned.

> > 
> > > 	return 0;  
> > 
> > We still need to return -ERESTARTSYS when wait_for_completion_interruptible_timeout()
> > is interrupted from UM.
> 
> Oh, absolutely.
> 
> >
> > > > +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> > > > +{
> > > > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > > > +
> > > > +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> > > > +		return;
> > > > +
> > > > +	lockdep_assert_held(&pfdev->reset.lock);
> > > > +
> > > > +	if (!perfcnt->user)
> > > > +		return;
> > > > +
> > > > +	perfcnt->owns_as_ref = !panfrost_perfcnt_hw_enable(pfdev);
> > > > +	perfcnt->reset_happened = true;
> > > > +	complete(&perfcnt->dump_comp);  
> > > 
> > > 	/* All active AS are released during the MMU post_reset. */
> > > 	perfcnt->owns_as_ref = false;  
> > 
> > I'm guessing this should go away as soon as I move it into panfrost_perfcnt_hw_enable().
> 
> If you reset it at the beginning of panfrost_perfcnt_hw_enable(), sure,
> but I think it's easier to assume that when
> panfrost_perfcnt_hw_enable() is called, the AS is not owned, and reset
> it here instead.

Noted.

> > 
> > > 	perfcnt->state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > > 	if (panfrost_perfcnt_hw_enable(pfdev))
> > > 		perfcnt->state |= PANFROST_PERFCNT_SESSION_DEAD;
> > > 
> > > 	/* Unblock pending sample requests. */
> > > 	complete(&perfcnt->dump_comp);  
> > > > +}

Adrian Larumbe
