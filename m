Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E230C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF4610E0B1;
	Mon, 29 Jun 2026 14:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iP6Gl1fg";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CD3B110E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:55:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1EA425DE
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:55:09 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 F2B6A3F905
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782744914; bh=NWejcmIO/DoW6BO9c6i/19FrFck8ORAYhgTY8TIvHl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iP6Gl1fgjJs6hwoPGDTIK2SJVH0tHUs7yFvkTpnRAUmTAUagN9tHQHoeHx4DOjdg0
 tyot0pqdx1L60EUYYQCO9GbQLXzCRtpKA3QWa3MoSgqIe8B5QBAsvf9HTmIsQ6PICp
 VKZggWgffat4ueO2HAZIeC7h5BDctYL/jLXCuHOI=
Date: Mon, 29 Jun 2026 15:55:03 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] drm/panthor: Don't overrule pending immediate
 ticks in sched_resume_tick()
Message-ID: <akKHR01Dq_GDfZDW@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
 <aj50chPdgUKBWVBx@e142607> <20260626151906.7b32fc29@fedora-2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626151906.7b32fc29@fedora-2.home>
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

On Fri, Jun 26, 2026 at 03:19:06PM +0200, Boris Brezillon wrote:
> On Fri, 26 Jun 2026 13:45:38 +0100
> Liviu Dudau <liviu.dudau@arm.com> wrote:
> 
> > On Thu, Jun 25, 2026 at 02:40:32PM +0200, Boris Brezillon wrote:
> > > We schedule immediate ticks when we need to process events on CSGs,
> > > but those immediate ticks don't change the resched_target because we
> > > want the other groups to stay scheduled for the remaining of the GPU
> > > timeslot they were given. Make sure these immediate ticks don't get
> > > overruled by a sched_queue_delayed_work() that would delay the tick
> > > execution.
> > > 
> > > Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jobs are submitted")
> > > Reported-by: sashiko-bot@kernel.org
> > > Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=9
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_sched.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> > > index 8fd4d97b062e..ab3e13e44a26 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > > @@ -2667,7 +2667,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
> > >  	else
> > >  		delay_jiffies = 0;
> > >  
> > > -	sched_queue_delayed_work(sched, tick, delay_jiffies);
> > > +	/* We schedule immediate ticks when we need to process events on CSGs,
> > > +	 * but those don't change the resched_target because we want the other
> > > +	 * groups to stay scheduled for the remaining of the GPU timeslot they
> > > +	 * were given. Make sure those immediate ticks don't get overruled by
> > > +	 * a sched_queue_delayed_work() that would delay the tick execution.
> > > +	 */
> > > +	if (!delayed_work_pending(&sched->tick_work))
> > > +		sched_queue_delayed_work(sched, tick, delay_jiffies);  
> > 
> > Maybe I'm having a Friday heat brain freeze, but it feels like the comment and the code
> > are going in a different direction. It doesn't help that the commit message copies the
> > comment so I can't tell if I'm misreading the comment or there was a different intent.
> 
> There's basically two kind of ticks:
> 
> 1. The periodic ones that serve as a way to rotate groups on the slots
>    and give everyone a chance to get a GPU slice
> 2. The immediate ones which are there to process events coming from an
>    interrupt, or to re-evaluate groups to schedule because a new group
>    became active
> 
> To detect the kind of tick, we use ::resched_target. If current time is
> before this target, this is an event, and resident groups shouldn't be
> evicted (I'm intentionally eluding RT groups to keep things simple).
> 
> The problem we have with sched_resume_tick() is that it's
> unconditionally calling sched_queue_delayed_work()
> (mod_delayed_work() internally). So, if we have an immediate tick
> pending (one that didn't adjust ::resched_target), we end up
> rescheduling the work to a later point thus delaying the processing of
> this asynchronous event for no good reason. What this commit does is
> skip the sched_queue_delayed_work() if the tick_work is pending.

Yeah, my confusion was from not understanding that immediate work is still
considered "delayed work" but one that does not adjust ::resched_target.

> 
> I'd be happy to change the wording if you have something to propose.

I don't think I have better wording to offer.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
