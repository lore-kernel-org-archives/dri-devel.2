Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85595C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05FA10E559;
	Mon,  3 Aug 2026 09:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Yg4UesiG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F8710E559
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785749399;
 bh=zoaM8tKoFUvw0g8W7cpM9crcYV/t5OzS0yVXiTNuVY4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Yg4UesiGWMbG3g3hhxQzQcl8pXd0+dNFiNt22nBZ7V3ZQwjwZrWaWYYg9oJDZkhdz
 lYJUCLVcCGmhze4/FCYYibD/mPnBJ9gXmjVqtBI+BpTw/9zielvt4NQKPLnG6btB1F
 jJF05ymlKHPlKVB9hp61ezSAoCS4ftCEc5RQaXEhjmaexqy0ptSs9lH/HWAjHPWL1G
 QSk3N7UuW3q8k402j5389VGsu2CQbvHQ29zxkEdikoFSdi60cBQ/1pncawnT3ExH8f
 daZttOwJwl2NvWztQwDjO17H74+0PZamHK58X2wenZYHL/ZDM9YO7rf8eJAhTSu+lX
 jKRiZrYo63WBQ==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 87B6217E08E1;
 Mon, 03 Aug 2026 11:29:58 +0200 (CEST)
Date: Mon, 3 Aug 2026 11:29:54 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chia-I Wu
 <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] drm/panthor: Fix UAF on works queued to
 panthor_cleanup_wq
Message-ID: <20260803112954.69bf18f5@fedora1.home>
In-Reply-To: <bw7DeMSTSiqMFTSPLhpuNA@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
 <bw7DeMSTSiqMFTSPLhpuNA@collabora.com>
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

On Mon, 20 Jul 2026 11:47:59 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> On Thursday, 25 June 2026 14:40:29 Central European Summer Time Boris Brezillon wrote:
> > If we don't drain the panthor_cleanup_wq before
> > unregistering/destroying the panthor_device, we might end up with
> > cleanup works that are executed after the device is gone.
> > 
> > Add a drain_workqueue() call in panthor_device_unplug() to prevent
> > that.
> > 
> > Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> > Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> > index 0b25abebb803..a0774e28aa94 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.c
> > +++ b/drivers/gpu/drm/panthor/panthor_device.c
> > @@ -101,6 +101,11 @@ void panthor_device_unplug(struct panthor_device *ptdev)
> >  	panthor_gpu_unplug(ptdev);
> >  	panthor_pwr_unplug(ptdev);
> >  
> > +	/* Make sure works queued to panthor_cleanup_wq are executed
> > +	 * before the device is destroyed.
> > +	 */
> > +	drain_workqueue(panthor_cleanup_wq);
> > +
> >  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> >  	pm_runtime_put_sync_suspend(ptdev->base.dev);
> >  
> > 
> >   
> 
> I feel like nothing in the driver instance should be allowed to queue new
> work to that workqueue while the unplug mutex is being held, and
> panthor_sched_unplug should just disable_work_sync all the associated group
> release_work items as well. If there's not a strong enough relationship
> between a scheduler and the groups to ensure we get all the groups in a
> non-racey manner that might not work out cleanly though.

Release is a bit a special work though. It's something that happens
once we know the group has left the scheduler, and all it's supposed
to do is free the resources the group might hold (mostly memory).

> 
> Having a scheduler unplug be completely disconnected from the associated
> groups being gone seems counter-intuitive to me.

It's actually the other way around: unplugging the scheduler might
result in new group_release work items being queued to the cleanup_wq.
The drain_worqueue() (which should actually be a flush_worqueue) is
here to guarantee that we're not leaving objects behind that would
still have references to objects that are about to be destroyed (in the
case of group_release, that's the drm_device, which holds all the GEM
database that we need to return the GEM refs the destroyed groups need
to release).
