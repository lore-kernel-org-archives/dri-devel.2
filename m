Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A6C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543B510EBC6;
	Mon, 14 Sep 2026 07:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C2B+m65U";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7976D10EBC6
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789372386;
 bh=EVjb24lAVYiF77qqXys6L35Z/ttsHp63jp+8emA2q8U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C2B+m65UZHRg/2mGO3axwU7GbMkzmJGnWHnLSRgP+ebnVkxuMqOyl6pf6tJ9nFNnE
 NwUnIg0x9G7AdvgSHPqZLw+uAFLMUvVjF9VsA5H4/eaZMako2zoZcDdhsNnP3mdRm4
 Rb9ZiOWyrLkUmpNGtxTpcc0+iwQdBq26C6EKcEiHpBuRjaGwHuV/UTm191mg2NvIF0
 MzvC6FG3+jq+VZvLACBdyo/aRmR3OQ9V4aiJvmNEQoJw1DpsG4wwaAldNofAO1uV61
 90e/Djiee9ei+ofwT2CIYi1ufj3qsTLRjvR4C2R1jTknWu1PV2Xqatg+xcrX5Ck9nB
 sZhuzGWWFDycw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FC8317E0700;
 Mon, 14 Sep 2026 09:53:06 +0200 (CEST)
Date: Mon, 14 Sep 2026 09:53:00 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Adrian Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/18] drm/panthor: Fix the unplug logic
Message-ID: <20260914095300.21633554@fedora-21.home>
In-Reply-To: <aqRXJMCsiu3DC0_S@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-17-982cc8f4234b@collabora.com>
 <aqRXJMCsiu3DC0_S@sobremesa>
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

On Fri, 11 Sep 2026 23:44:55 +0100
Adrian Larumbe <adrian.larumbe@collabora.com> wrote:

> On 26.08.2026 16:56, Boris Brezillon wrote:
> > The current unplug logic is broken in multiple subtle ways:
> > 
> > 1. it assumes that the HW is still accessible in multiple places,
> >    which goes against the very concept of hot-unplug
> > 2. it doesn't take into account the fact the stop is a failible  
> 
> On a related note, this made me wonder whether it's the same in Panfrost.
> It seems panfrost_gpu_power_off() can fail, leaving the GPU running after
> the driver has been removed.

Actually, by stop I meant SOFT_RESET, which shutdowns the power rails
automatically. This makes me realize this commit message is
out-of-date, because we now rely on the fact SOFT_RESET is considered
non-fallible to keep things simple.

> 
> >    operation, and that we theoretically have no guarantee that the HW
> >    is actually stopped after we've released the resources
> > 
> > Those issues are hard to reason about because Mali GPUs are on a
> > platform bus, which is not hot-pluggable, so they are in practice
> > always accessible as long as we can enable their dependencies (clocks,
> > power-domain, ...). The problem is, if the GPU is in such a bad state
> > it can't properly reset/resume, there are various operations that can't
> > be done properly, and the unplug logic is clearly not ready for that.
> > And more importantly, if we can't guarantee the reset was effective,
> > we have to assume the HW still has access to the resource we passed to
> > it, meaning we can't return these resources to the system without
> > risking a UAF.
> > 
> > This patch does several things:
> > 
> > - it resets the GPU before calling the <component>_unplug() functions
> > - it drops the pm_get/put that around the sub-component unplug calls  
>                            Nit: remove 'that'?                                
> 
> >   (no longer needed if we assume the HW is gone and can't be accessed
> >   anymore)
> > - it changes the _unplug() implementations to not touch the HW anymore
> > - it let's each component know whether it should leak resources the HW  
>       Nit: lets
> >   might have its hands on at the time the unplug happens
> > - it releases all resources at unplug time even if open FDs exist. This
> >   is needed otherwise we could have deferred cleanup work accessing
> >   objects that have been freed
> > 
> > Unfortunately, I couldn't find a way to break things into multiple
> > commits while preserving bisectability.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.c |  50 +++++++++----
> >  drivers/gpu/drm/panthor/panthor_drv.c    | 122 ++++++++++++++++++++++++-------
> >  drivers/gpu/drm/panthor/panthor_fw.c     |   9 +--
> >  drivers/gpu/drm/panthor/panthor_gpu.c    |   2 +-
> >  drivers/gpu/drm/panthor/panthor_mmu.c    |  72 +++++++++++-------
> >  drivers/gpu/drm/panthor/panthor_pwr.c    |   2 +-
> >  drivers/gpu/drm/panthor/panthor_sched.c  |  90 +++++++++++++++++++++--
> >  7 files changed, 267 insertions(+), 80 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> > index 817312f598f3..328e601d80e8 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.c
> > +++ b/drivers/gpu/drm/panthor/panthor_device.c
> > @@ -83,13 +83,28 @@ void panthor_device_unplug(struct panthor_device *ptdev)
> >  	/* Make sure we're not interrupted by resets while we're unplugging. */
> >  	disable_work_sync(&ptdev->reset.work);
> >  
> > -	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> > +	/* Disable RPM callbacks early, so we're sure external RPM calls won't
> > +	 * interfere with our unplug logic.
> > +	 */
> > +	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> > +	pm_runtime_disable(ptdev->base.dev);  
> 
> If a sysfs or debugfs knob was executing at the time device_unplug() kicks in, and they had
> taken a PM reference, wouldn't the previous statement mean when they try to release that
> reference they wouldn't be able to? And maybe leave the RPM reference count unbalanced.

PM refs can always still be released with pm_runtime_put[_sync()] after
that point. All pm_runtime_disable() does is skip the call to the RPM
hooks, which is exactly what we want, because we're going to suspend
things manually.


> > @@ -2243,6 +2253,11 @@ static bool vm_prep_for_cleanup(struct panthor_vm *vm)
> >  	}
> >  
> >  	if (!drm_dev_enter(&ptdev->base, &cookie)) {
> > +		/* Device is gone, take the unplug lock to make sure
> > +		 * panthor_device_stop_before_unplug() has run and
> > +		 * ::leak_active_resources is valid.
> > +		 */  
> 
> This looks like a holdover from a previous revision.

Oops, indeed.


> > @@ -3658,6 +3676,8 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
> >  	 */
> >  	flush_work(&ptdev->mmu->vm.cleanup_work);
> >  	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->as.cleanup_list));
> > +	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->vm.list));
> > +	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->vm.user_owned));  
> 
> Here I understand that vm.user_owned must be empty by now, but vm's are only taken off
> the vm.list at VM release time, either in vm_prep_for_cleanup() or when disabling its
> HW AS fails and release is delayed until the next reset. So this assumes that for every
> user facing VM that we destroy at the beginning of this function, its refcount was 1.
> But I'm not sure when we've made it this far we're certain no more vmbind jobs are
> targetting those VM's, all of which take VM reference.

Hm, that's a valid point. We probably need to stop the VM_BIND
queue in vm_destroy() instead of vm_cleanup().

> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> > index bd5dcf4cb580..7d2815b4db0f 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -2548,7 +2548,7 @@ static void tick_work(struct work_struct *work)
> >  		return;
> >  
> >  	ret = panthor_device_resume_and_get(ptdev);
> > -	if (drm_WARN_ON(&ptdev->base, ret))
> > +	if (ret)  
> 
> Why have we dropped the warning here?

Because this can be executed during an unplug, and the
pm_runtime_disable() we added in panthor_device_unplug() makes it
so panthor_device_resume_and_get() can now return an error that's
expected. If we really wanted to keep that WARN_ON() we'd need to
distinguish error-because-its-disabled vs
error-returned-by-the-resume-hook, and I thought it wasn't worth it.
But I can find a solution to make that work if you think it's important.

> 
> >  		goto out_dev_exit;
> >  
> >  	/* If the tick is stopped, calculate when the next tick would be */
> > @@ -3100,12 +3100,17 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
> >  void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
> >  {
> >  	struct panthor_group_pool *gpool = pfile->groups;
> > +	struct panthor_device *ptdev = pfile->ptdev;
> >  	struct panthor_group *group;
> >  	unsigned long i;
> > +	int cookie;
> >  
> >  	if (IS_ERR_OR_NULL(gpool))
> >  		return;
> >  
> > +	if (!drm_dev_enter(&ptdev->base, &cookie))
> > +		return;
> > +
> >  	xa_lock(&gpool->xa);
> >  	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
> >  		guard(spinlock)(&group->fdinfo.lock);
> > @@ -3115,6 +3120,8 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
> >  		group->fdinfo.data.time = 0;
> >  	}
> >  	xa_unlock(&gpool->xa);
> > +
> > +	drm_dev_exit(cookie);
> >  }
> >  
> >  struct panthor_job_ringbuf_instrs {
> > @@ -3320,7 +3327,7 @@ queue_run_job(struct drm_sched_job *sched_job)
> >  	}
> >  
> >  	ret = panthor_device_resume_and_get(ptdev);
> > -	if (drm_WARN_ON(&ptdev->base, ret))
> > +	if (ret)
> >  		return ERR_PTR(ret);
> >  
> >  	mutex_lock(&sched->lock);
> > @@ -3873,14 +3880,23 @@ int panthor_group_pool_create(struct panthor_file *pfile)
> >  void panthor_group_pool_destroy(struct panthor_file *pfile)
> >  {
> >  	struct panthor_group_pool *gpool = pfile->groups;
> > +	struct panthor_device *ptdev = pfile->ptdev;
> >  	struct panthor_group *group;
> >  	unsigned long i;
> > +	int cookie;
> >  
> >  	if (IS_ERR_OR_NULL(gpool))
> >  		return;
> >  
> > -	xa_for_each(&gpool->xa, i, group)
> > -		panthor_group_destroy(pfile, i);
> > +	/* If device is gone groups have been destroyed already, and the XArray
> > +	 * contains pointers to objects that have been freed.
> > +	 */  
> 
> I find this a bit confusing, but probably because I don't fully understand how groups are made
> to go away at unplug time. All I can see in panthor_sched_unplug() is that group references are
> put, for bound groups, idle ones and then those owned by the user. However, do we know by this time
> that there are no more group references taken by extant scheduler jobs at queue entities?

It's the group_term_work that's supposed to stop the queues and cancel
all remaining jobs, and we queue this work for all bound, idle and
runnable groups that remain at unplug time. We also make sure those are
executed with a flush_workqueue(sched->wq). So, unlike the VM_BIND
queue which is really lacking this vm_term_work step to cancel jobs and
finish the drm_sched objects, I think the group side of things is sound.

> 
> > +	if (drm_dev_enter(&ptdev->base, &cookie)) {
> > +		xa_for_each(&gpool->xa, i, group)
> > +			panthor_group_destroy(pfile, i);
> > +
> > +		drm_dev_exit(cookie);
> > +	}
> >  
> >  	xa_destroy(&gpool->xa);
> >  	kfree(gpool);
> > @@ -3899,11 +3915,16 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
> >  				     struct drm_memory_stats *stats)
> >  {
> >  	struct panthor_group_pool *gpool = pfile->groups;
> > +	struct panthor_device *ptdev = pfile->ptdev;
> >  	struct panthor_group *group;
> >  	unsigned long i;
> > +	int cookie;
> > +
> > +	if (!drm_dev_enter(&ptdev->base, &cookie))
> > +		return;  
> 
> Do we need drm_dev_enter() here when it's already been checked in the calling function?

Probably not, I'll drop it.

