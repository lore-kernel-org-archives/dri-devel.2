Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE34CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586CF10EB35;
	Tue, 23 Jun 2026 12:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cLlXUUsE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935E310EB35
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782219127;
 bh=x7zPnl50SWmAh2PPFhcivp1YUm7KJkGQWNbj4k3l66c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cLlXUUsEOIP1ewjgwICfih+A0Qbv1NicCl/r8PzBzL1Mr9X+g7mhJ2q9ShOYLzj/z
 CI+AvZNBHBmeDpQ4AVT6Wp1jCwrhXo6EMxZbIicLlVo2D1Sva9y2I8uE2zqeMmRdXQ
 r6Y9av9QXy5wY9rC7B76WIoYuyGw5Jlt7bFQdNyE4By1/VsmyzeQETLJYymk1XqfDE
 AtTi7C+ZE4lJvVvJgAu5zHGiN18cIOLX/znKJtO9DwGsXxrzhobvMWpFe3r03E92Ui
 S3pPIAYnUeKxneT1SzoFtRgf2ud9fiFkzfGeOFlMYQNWHOOB0P40W19E6lYqkIo/me
 KSUxGoYLZ2Ang==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E20D517E091C;
 Tue, 23 Jun 2026 14:52:06 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:52:03 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for
 FW events in IRQ context
Message-ID: <20260623145203.01656d68@fedora-2.home>
In-Reply-To: <20260622144949.67c8932c@fedora-2.home>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
 <20260518154516.65ba8592@fedora>
 <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
 <20260519095354.123f8b61@fedora>
 <CAPaKu7Se1jLiZ+6VNY=Ykf+nkMzu-q2r3UOdQ9Qf2DzpGNiCCQ@mail.gmail.com>
 <20260519202629.76bcc3a3@fedora>
 <CAPaKu7TUmZcAJLmub0Xu-wsFOGeQp0zwrhXKLavBo9E=83kSdA@mail.gmail.com>
 <CAPaKu7ToQmHHhTyb-az_b7EG2iRpc23=AJOYQ5P=HgrG29bS1A@mail.gmail.com>
 <20260520100946.398c5282@fedora>
 <CAPaKu7T_J3Om=rJB-ShF9Kyusdk+P6kXAk=W7S1dxim-OmAukA@mail.gmail.com>
 <20260622144949.67c8932c@fedora-2.home>
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

On Mon, 22 Jun 2026 14:49:49 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 20 May 2026 15:15:54 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
> 
> > > > > I collected
> > > > > some numbers with baseline, with this series, and with patch 9
> > > > > reverted at https://gitlab.freedesktop.org/panfrost/linux/-/work_items/85#note_3481308.
> > > > > Reposting the numbers here for reference
> > > > >
> > > > > |                    | baseline | entire series | patch 9 reverted |
> > > > > | -                  | -        | -             | -                |
> > > > > | frag job median    | 2.8ms    | 2.2ms         | 2.2ms            |
> > > > > | frag job 95%       | 4.5ms    | 2.8ms         | 2.8ms            |
> > > > > | frag job 99%       | 4.9ms    | 2.8ms         | 2.8ms            |
> > > > > | panthor-job median | 0.8us    | 6.2us         | 0.9us            |
> > > > > | panthor-job 95%    | 1.5us    | 16.6us        | 1.5us            |
> > > > > | panthor-job 99%    | 1.6us    | 28.0us        | 1.8us            |    
> > > >
> > > > panthor-job rows are the durations of the raw irq handlers, collected
> > > > from irq/irq_handler_{entry,exit}.
> > > >
> > > > frag job rows are the durations from frag jobs, collected from
> > > > gpu_scheduler/drm_sched_job_{run,done}.
> > > >
> > > > The fence signaling paths of them are
> > > >
> > > >  - baseline: raw handler -> rt threaded handler -> wq job -> wq job ->
> > > > fence signal
> > > >  - entire series: raw handler -> fence signal
> > > >  - patch 9 reverted: raw handler -> rt threaded handler -> fence signal    
> > >
> > > Just did another set of throughput tests, and I confirm the gains are
> > > noticeable only with patch 9 applied (that's on rk3588, which embeds a
> > > G610, so not the exact same setup). As an example, on
> > > gfxbench/gl_manhattan, I get the following score bump 2391 -> 2457.
> > >
> > > Now I need to set things up to measure latency like you did and make
> > > sure I'm observing the same thing: threaded handlers providing roughly
> > > the same latency as hardirq handlers. If not it probably has to do with
> > > some config options that differ and change the preemptability of the
> > > system.
> > >
> > > I'll hold off on the submission of v3 until this is done, because if
> > > threaded handlers are roughly as efficient as hardirq ones, we probably
> > > want to stick to threaded handlers.   
> 
> Sorry for the delay, I only got back to this on Friday.
> 
> So, I've been using ftrace/function-graph with some noinline added to
> get a sense of where most of the time was spent in the hardirq handler
> after the transition to hardirqs, and unlike what I thought, it's not
> coming from the accesses to uncached mappings of the FW
> interface/syncobjs, but instead the various queue[_delayed]_work()
> and/or wake_up_all() on panthor_fw::req_waitqueue. I don't expect us to
> be able to optimize that anytime soon, so I guess we should just keep
> everything in the threaded handler for now and accept the extra delay
> (assuming 20+ usec for the hardirq handler is too long). This also
> means that a lot of the things I do in this series are moot
> (irqsave/restore, using spinlocks instead of mutexes, ...), but before
> I go and rework that, I'd like to get some feedback from Steve and
> Liviu to make sure this is okay with Arm.

I ended up sending a v3 doing that. I can easily go back to the
previous version if needed.
