Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E6CC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D651C10E321;
	Thu, 16 Jul 2026 10:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="d6WvngIJ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2BFA310E321
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:44:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8AA339
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 03:44:20 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 103373F7B4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784198664; bh=s6cC+CW20Vbw/ke8vNQXuUd/cwm0suHsHuNqrE/kDls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d6WvngIJbVzsw/QM8AyadO8VhuR2NbrWaA8sc9HWWYMR9JO3W17vd/Y+phsR0s3jg
 aB8SaUykJomdBDOWwxRKx9dTZBXJM609FOrY1uY7rFa08hL/occeYrBQc1zk/8Be3c
 EOTISAL8XpqTtee/lpmfkXVrZmXmqy8s1MOIzVS4=
Date: Thu, 16 Jul 2026 11:44:11 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Guangliu Ding <guangliu.ding@nxp.com>
Cc: Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] drm/panthor: add gpu_load debugfs node
Message-ID: <ali1-3Yc1i4sVliI@e142607>
References: <20260708-master-v1-1-713a00fe35ec@nxp.com>
 <98345cd1-9693-447d-b4cd-08a889b2303b@arm.com>
 <GVXPR04MB12158DCAE296381B3A0E7195FF3FA2@GVXPR04MB12158.eurprd04.prod.outlook.com>
 <6e9cdc1f-de2d-4ef4-9a30-42592752fd49@arm.com>
 <GVXPR04MB12158872FC4B07EEA08071FD9F3C72@GVXPR04MB12158.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GVXPR04MB12158872FC4B07EEA08071FD9F3C72@GVXPR04MB12158.eurprd04.prod.outlook.com>
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

On Thu, Jul 16, 2026 at 02:05:47AM +0000, Guangliu Ding wrote:
> > On 13/07/2026 04:19, Guangliu Ding wrote:
> > >> On 08/07/2026 04:24, Guangliu Ding wrote:
> > >>> Expose GPU utilization via /sys/kernel/debug/dri/<N>/gpu_load.  The
> > >>> file reports busy_time_ns, idle_time_ns and gpu_load %.
> > >>>
> > >>> Values are snapshotted at the end of each devfreq sampling window
> > >>> (~50 ms) rather than read from live accumulators, avoiding load
> > >>> swings over short observation intervals.
> > >>>
> > >>> The snapshot is cleared on suspend to avoid stale data when the GPU
> > >>> is powered off.
> > >>>
> > >>> Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
> > >>
> > >> Hi Guangliu,
> > >>
> > >> I'm puzzled exactly what you're trying to achieve with this. I can
> > >> see that getting the GPU load might be useful, we do already have the
> > >> 'fdinfo' mechanism to do this in a per-client manner but nothing good for
> > "whole GPU"
> > >> measurements.
> > >>
> > >> But stashing it in debugfs and formatting it as a string seems odd.
> > >> Do you have a tool which uses this file, or is just for 'cat'ing to see the
> > instantaneous load?
> > >>
> > >> Ideally we'd have something that would provide this information in a
> > >> format that all drivers could implement, and not rely on debugfs files.
> > >>
> > >> Thanks,
> > >> Steve
> > >>
> > >
> > > Hi Steve
> > >
> > > Panthor currently exposes very limited runtime telemetry. The intent
> > > is to expose utilization in this patch, together with other
> > > device-wide GPU runtime metrics (frequency, shader activity, draw-call counts,
> > memory usage, etc.) to a userspace tool for monitoring and
> > workload-optimization purposes.
> > >
> > > fdinfo is primarily a per-client interface. Since it requires an open
> > > DRM fd and reports information associated with that client, it does
> > > not map particularly well to the global metrics exported by this patch.
> > >
> > > If a generic cross-driver interface for this kind of GPU telemetry
> > > emerges, I'm happy to switch to it. However, no such interface
> > > currently exists for devfreq-based device utilization, so debugfs
> > > seemed like the most appropriate existing option. Suggestions for a better
> > interface are welcome.
> > 
> > So my point really is someone should ideally implement a better interface that
> > multiple drivers can use. Having a point hack for one driver doesn't really help
> > the situation.
> > 
> > Indeed you can get the load information with ftrace already:
> > 
> >   cd /sys/kernel/tracing
> >   echo 0 > tracing_on
> >   echo > trace
> >   echo 'dev_name == "fb000000.gpu"' > events/devfreq/devfreq_monitor/filter
> >   echo 1 > events/devfreq/devfreq_monitor/enable
> >   echo 1 > tracing_on
> >   cat trace_pipe
> > 
> > And you'll get a stream of messages when the GPU is in use which includes a
> > "load=xx" value at the end.
> > 
> > If this is going to be extended to other properties for a user space tool then we
> > should probably be putting this in sysfs and trying to come up with a design that
> > other drivers can copy.
> > 
> > Thanks,
> > Steve
> > 
> 
> Hi Steve,
> 
> Thanks for the feedback and sharing.
> I agree that a generic interface shared by multiple drivers would be preferable in the long term.
> 
> For our use case, we need to provide customers with a simple way to quickly observe GPU 
> performance metrics from a userspace tuning tool. Even though the devfreq_monitor tracepoint already 
> exposes the load information, ftrace is typically not enabled or supported in our deployed products,
> making it unsuitable as a user-facing interface for the tool.

You are enabling debugfs but not ftrace? Seems like an odd choice if you want to monitor and tune your system.

We are working on adding performance counters support to Panthor that will expose performance metrics in a
more meaningful way.

> 
> As far as I know, there is currently no generic DRM/devfreq interface for querying device-wide 
> GPU utilization on demand. Given that gap, exporting the information through debugfs 
> seemed like the most practical option for Panthor today.

Knowing that the GPU was 80% busy without knowing exactly who was submitting jobs is not a particularly
useful information, in my opinion. I would like to understand better what you are trying to do with the
information and why implementing a devfreq governor for your usecase would not be useful here.

Best regards,
Liviu

> 
> Thanks,
> Guangliu
> 
> > > Best Regards,
> > > Guangliu
> > >
> > >>> ---
> > >>> Add /sys/kernel/debug/dri/<N>/gpu_load to expose GPU utilisation
> > >>> from the last devfreq sampling window (~50 ms).
> > >>> The file reports busy_time_ns, idle_time_ns and load percentage.
> > >>>
> > >>> Tested on NXP i.MX95 EVK (Mali-G310 V2).
> > >>> ---
> > >>>  drivers/gpu/drm/panthor/panthor_devfreq.c | 80
> > >>> +++++++++++++++++++++++++++++++
> > >> drivers/gpu/drm/panthor/panthor_devfreq.h |  6 +++
> > >>>  drivers/gpu/drm/panthor/panthor_drv.c     |  2 +
> > >>>  3 files changed, 88 insertions(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c
> > >>> b/drivers/gpu/drm/panthor/panthor_devfreq.c
> > >>> index 2249b41ca4af..1b3f58ddfbd3 100644
> > >>> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> > >>> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> > >>> @@ -1,12 +1,16 @@
> > >>>  // SPDX-License-Identifier: GPL-2.0 or MIT
> > >>>  /* Copyright 2019 Collabora ltd. */
> > >>> +/* Copyright 2026 NXP */
> > >>>
> > >>>  #include <linux/clk.h>
> > >>> +#include <linux/debugfs.h>
> > >>>  #include <linux/devfreq.h>
> > >>>  #include <linux/devfreq_cooling.h>
> > >>> +#include <linux/math64.h>
> > >>>  #include <linux/platform_device.h>
> > >>>  #include <linux/pm_opp.h>
> > >>>
> > >>> +#include <drm/drm_file.h>
> > >>>  #include <drm/drm_managed.h>
> > >>>  #include <drm/drm_print.h>
> > >>>
> > >>> @@ -43,6 +47,22 @@ struct panthor_devfreq {
> > >>>        * and panthor_devfreq_record_{busy,idle}().
> > >>>        */
> > >>>       spinlock_t lock;
> > >>> +
> > >>> +#ifdef CONFIG_DEBUG_FS
> > >>> +     /**
> > >>> +      * @last_busy_ns: Busy time in nanoseconds of the last
> > >>> +completed
> > >> devfreq window.
> > >>> +      * Updated by panthor_devfreq_get_dev_status() before
> > >>> + resetting the
> > >> counters.
> > >>> +      * Protected by @lock.
> > >>> +      */
> > >>> +     u64 last_busy_ns;
> > >>> +
> > >>> +     /**
> > >>> +      * @last_total_ns: Total time in nanoseconds of the last
> > >>> + completed
> > >> devfreq window.
> > >>> +      * Updated by panthor_devfreq_get_dev_status() before
> > >>> + resetting the
> > >> counters.
> > >>> +      * Protected by @lock.
> > >>> +      */
> > >>> +     u64 last_total_ns;
> > >>> +#endif
> > >>>  };
> > >>>
> > >>>  static void panthor_devfreq_update_utilization(struct
> > >>> panthor_devfreq
> > >>> *pdevfreq) @@ -101,6 +121,11 @@ static int
> > >>> panthor_devfreq_get_dev_status(struct device *dev,
> > >>>
> > >>>       status->busy_time = ktime_to_ns(pdevfreq->busy_time);
> > >>>
> > >>> +#ifdef CONFIG_DEBUG_FS
> > >>> +     pdevfreq->last_busy_ns = status->busy_time;
> > >>> +     pdevfreq->last_total_ns = status->total_time; #endif
> > >>> +
> > >>>       panthor_devfreq_reset(pdevfreq);
> > >>>
> > >>>       spin_unlock_irqrestore(&pdevfreq->lock, irqflags); @@ -283,6
> > >>> +308,17 @@ void panthor_devfreq_suspend(struct panthor_device
> > >>> +*ptdev)
> > >>>               return;
> > >>>
> > >>>       drm_WARN_ON(&ptdev->base,
> > >>> devfreq_suspend_device(pdevfreq->devfreq));
> > >>> +
> > >>> +#ifdef CONFIG_DEBUG_FS
> > >>> +     {
> > >>> +             unsigned long irqflags;
> > >>> +
> > >>> +             spin_lock_irqsave(&pdevfreq->lock, irqflags);
> > >>> +             pdevfreq->last_busy_ns = 0;
> > >>> +             pdevfreq->last_total_ns = 0;
> > >>> +             spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
> > >>> +     }
> > >>> +#endif
> > >>>  }
> > >>>
> > >>>  void panthor_devfreq_record_busy(struct panthor_device *ptdev) @@
> > >>> -332,3 +368,47 @@ unsigned long panthor_devfreq_get_freq(struct
> > >>> panthor_device *ptdev)
> > >>>
> > >>>       return freq;
> > >>>  }
> > >>> +
> > >>> +#ifdef CONFIG_DEBUG_FS
> > >>> +static int panthor_devfreq_gpu_load_show(struct seq_file *m, void
> > >>> +*unused) {
> > >>> +     struct panthor_device *ptdev = m->private;
> > >>> +     struct panthor_devfreq *pdevfreq = ptdev->devfreq;
> > >>> +     unsigned long irqflags;
> > >>> +     unsigned int gpu_load;
> > >>> +     u64 total_ns;
> > >>> +     u64 busy_ns;
> > >>> +
> > >>> +     if (!pdevfreq->devfreq) {
> > >>> +             seq_puts(m, "devfreq not initialized\n");
> > >>> +             return 0;
> > >>> +     }
> > >>> +
> > >>> +     spin_lock_irqsave(&pdevfreq->lock, irqflags);
> > >>> +     busy_ns = pdevfreq->last_busy_ns;
> > >>> +     total_ns = pdevfreq->last_total_ns;
> > >>> +     spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
> > >>> +
> > >>> +     busy_ns = min(busy_ns, total_ns);
> > >>> +     gpu_load = total_ns ? (unsigned int)div64_u64(busy_ns *
> > >>> + 100ULL,
> > >>> + total_ns) : 0;
> > >>> +
> > >>> +     seq_printf(m, "busy_time_ns: %llu  idle_time_ns: %llu
> > >> gpu_load: %u%%\n",
> > >>> +                busy_ns, total_ns - busy_ns, gpu_load);
> > >>> +
> > >>> +     return 0;
> > >>> +}
> > >>> +DEFINE_SHOW_ATTRIBUTE(panthor_devfreq_gpu_load);
> > >>> +
> > >>> +/**
> > >>> + * panthor_devfreq_debugfs_init() - Initialize devfreq debugfs
> > >>> +entries
> > >>> + * @minor: DRM minor.
> > >>> + */
> > >>> +void panthor_devfreq_debugfs_init(struct drm_minor *minor) {
> > >>> +     struct panthor_device *ptdev = container_of(minor->dev,
> > >>> +                                                 struct
> > >>> +panthor_device, base);
> > >>> +
> > >>> +     debugfs_create_file("gpu_load", 0444, minor->debugfs_root, ptdev,
> > >>> +                         &panthor_devfreq_gpu_load_fops); }
> > #endif
> > >> /*
> > >>> +CONFIG_DEBUG_FS */
> > >>> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h
> > >>> b/drivers/gpu/drm/panthor/panthor_devfreq.h
> > >>> index f8e29e02f66c..4552569abfe4 100644
> > >>> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> > >>> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> > >>> @@ -1,5 +1,6 @@
> > >>>  /* SPDX-License-Identifier: GPL-2.0 or MIT */
> > >>>  /* Copyright 2019 Collabora ltd. */
> > >>> +/* Copyright 2026 NXP */
> > >>>
> > >>>  #ifndef __PANTHOR_DEVFREQ_H__
> > >>>  #define __PANTHOR_DEVFREQ_H__
> > >>> @@ -20,4 +21,9 @@ void panthor_devfreq_record_idle(struct
> > >>> panthor_device *ptdev);
> > >>>
> > >>>  unsigned long panthor_devfreq_get_freq(struct panthor_device
> > >>> *ptdev);
> > >>>
> > >>> +#ifdef CONFIG_DEBUG_FS
> > >>> +struct drm_minor;
> > >>> +void panthor_devfreq_debugfs_init(struct drm_minor *minor); #endif
> > >>> +
> > >>>  #endif /* __PANTHOR_DEVFREQ_H__ */
> > >>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> b/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> index e8dc4096c1d2..4093a6d21337 100644
> > >>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> @@ -2,6 +2,7 @@
> > >>>  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> > >>>  /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
> > >>>  /* Copyright 2019 Collabora ltd. */
> > >>> +/* Copyright 2026 NXP */
> > >>>
> > >>>  #ifdef CONFIG_ARM_ARCH_TIMER
> > >>>  #include <asm/arch_timer.h>
> > >>> @@ -1761,6 +1762,7 @@ static void panthor_debugfs_init(struct
> > >>> drm_minor *minor)  {
> > >>>       panthor_mmu_debugfs_init(minor);
> > >>>       panthor_gem_debugfs_init(minor);
> > >>> +     panthor_devfreq_debugfs_init(minor);
> > >>>  }
> > >>>  #endif
> > >>>
> > >>>
> > >>> ---
> > >>> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> > >>> change-id: 20260706-master-bd0eef99ca8e
> > >>>
> > >>> Best regards,
> > >>> --
> > >>> Guangliu Ding <guangliu.ding@nxp.com>
> > >>>
> > >
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
