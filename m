Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE83DC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BD010E3A9;
	Fri, 26 Jun 2026 13:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C95wF0mU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4583A10E3A9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782479952;
 bh=B3dON+R6I5rOmpOwNPj5eEZCXLkhJvugnVAMOmEnbPs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C95wF0mU7QK4fD/KN6Ki5Wk3Efde+EBjpyp3btxuMcPa5lGnIssRx75Tn+ZvVi6XH
 h1dteLh73GL/b4sETOqgbG83Dr1WLkDsFlwzsjlUof2pM6x20zeeO3CymQBTMy4ypW
 akOIKAIWgsXvMCdAISUYXuHKsscqXQ06+zg5UQEV56quNtWE6A/Q38U1QcHQd+H6er
 E6AoJOLXC2SZVuM995wOSSBgiemBubYwvjWQNklJibiDdAZ0sH7QqItdPjQ+qQHLXJ
 gTUeh1kUgNTrQ+cyDsLejAjwFCxFPD4m2/5OYGRiAL9zmb+lDvdtnGr+e5gyCP+/fC
 +xXIlKrgzTuyg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 26A0B17E0180;
 Fri, 26 Jun 2026 15:19:12 +0200 (CEST)
Date: Fri, 26 Jun 2026 15:19:06 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Chia-I Wu <olvaffe@gmail.com>, Karunika
 Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] drm/panthor: Don't overrule pending immediate
 ticks in sched_resume_tick()
Message-ID: <20260626151906.7b32fc29@fedora-2.home>
In-Reply-To: <aj50chPdgUKBWVBx@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
 <aj50chPdgUKBWVBx@e142607>
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

On Fri, 26 Jun 2026 13:45:38 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Thu, Jun 25, 2026 at 02:40:32PM +0200, Boris Brezillon wrote:
> > We schedule immediate ticks when we need to process events on CSGs,
> > but those immediate ticks don't change the resched_target because we
> > want the other groups to stay scheduled for the remaining of the GPU
> > timeslot they were given. Make sure these immediate ticks don't get
> > overruled by a sched_queue_delayed_work() that would delay the tick
> > execution.
> > 
> > Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jobs are submitted")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=9
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_sched.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> > index 8fd4d97b062e..ab3e13e44a26 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -2667,7 +2667,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
> >  	else
> >  		delay_jiffies = 0;
> >  
> > -	sched_queue_delayed_work(sched, tick, delay_jiffies);
> > +	/* We schedule immediate ticks when we need to process events on CSGs,
> > +	 * but those don't change the resched_target because we want the other
> > +	 * groups to stay scheduled for the remaining of the GPU timeslot they
> > +	 * were given. Make sure those immediate ticks don't get overruled by
> > +	 * a sched_queue_delayed_work() that would delay the tick execution.
> > +	 */
> > +	if (!delayed_work_pending(&sched->tick_work))
> > +		sched_queue_delayed_work(sched, tick, delay_jiffies);  
> 
> Maybe I'm having a Friday heat brain freeze, but it feels like the comment and the code
> are going in a different direction. It doesn't help that the commit message copies the
> comment so I can't tell if I'm misreading the comment or there was a different intent.

There's basically two kind of ticks:

1. The periodic ones that serve as a way to rotate groups on the slots
   and give everyone a chance to get a GPU slice
2. The immediate ones which are there to process events coming from an
   interrupt, or to re-evaluate groups to schedule because a new group
   became active

To detect the kind of tick, we use ::resched_target. If current time is
before this target, this is an event, and resident groups shouldn't be
evicted (I'm intentionally eluding RT groups to keep things simple).

The problem we have with sched_resume_tick() is that it's
unconditionally calling sched_queue_delayed_work()
(mod_delayed_work() internally). So, if we have an immediate tick
pending (one that didn't adjust ::resched_target), we end up
rescheduling the work to a later point thus delaying the processing of
this asynchronous event for no good reason. What this commit does is
skip the sched_queue_delayed_work() if the tick_work is pending.

I'd be happy to change the wording if you have something to propose.
