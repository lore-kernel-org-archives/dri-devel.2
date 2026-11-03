Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BA606D81E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=fol+rvKR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB1910E808;
	Tue,  3 Nov 2026 14:46:53 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE2B89C0D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:46:46 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1931ff67a29so8782854c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1793717205; x=1794322005; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=claJSsAQr76jlRJIbtY4armSDzhGz1HsbIM/s+cv2/E=;
 b=fol+rvKR2Bn4+Ycf73gUgu7uphxI6fJLrQK9vVa/3ppc43aHA5TUAKil7ziGY2Qkhy
 9sZqzvk0iQHhR0QZ4kWMxk5lhGPMOoAFm5orWGAol9lx+rjDK51+3+3DBFQOWAT/3euN
 SZE+6bEdAoypa+shJLgulc4UDjOFpC3hwZihc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717205; x=1794322005;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=claJSsAQr76jlRJIbtY4armSDzhGz1HsbIM/s+cv2/E=;
 b=iq/2ac2e0MmW0WASl0kZ/bgO08FQi6LyjuMq/CVhQ4w3/idMxyJU+/07REvYJ/q54s
 GZGEb2+ncD1zn8wM3BrTPJIlzEu0CQN24w3cXBx/z5G3JCOAihTrhJBibAg0MaVYGPQV
 nMxGW6XN3EoeHHZXWz3G9t+9G6SbbysC07U2TvRqUFUAhqyMC+lDGcf3BruSTNsDM1lL
 smxwLkIyjWSb7Jx5LdpPHuTRvcXimfC6JWp6kUhSMbyvY+9QfijGk9LoPe3lkHytj129
 lKGVjp2Egv0rjAsR2E57oKgz26eZEOQ6y8AFUq4ji8WqWIECFrF5MyNc9m/lZZmbP45T
 8X2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz53ynNYB7Am0XQKPUfhkxCRrd0AZdZtzedecJ/j37qM+QyzaD9dM+kdu+APrzcL8uHqrfg2RqjLTc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qHSeiCwAx9XMLBEflXYxlhWRxt0ytVTcWSv0orjlkUAR5UsIu
 izEiWeZBZhUsex5y2OGg/ETQTaBeMOp2B23H/s1Gj34MDwtt5GlgqxDQj+Tvi9/XhFo=
X-Gm-Gg: AYBFou3ZNw4XNhXxneI3wHG36TxoEG+Q2XarYVakR/0k/kskPFhYweHXzsiFklmQBGW
 V37vl+y00JqBoLUbZXxGPUPPc8PIwA5yH6AEBYuUZsfptNsp6D0rx5R9jENea0PT+XkvTHbDs/2
 4PR8lGMY0QvfCmw3q3YWCAn5B4beLJauwUH3BOshGY5IgnK2DVgkixO01SiiepybtxSq/zP9sMg
 gLAocFT+f4ymLahSiFSNH3RIjjkOxYYmGoVFupWQrgzHdx6Morg/5y8ZozfdMVr+gB+3ASo8GYt
 DReA3ep4OMyHqRJJE972d7SwJYraBNDWEQ1QDHb2HkaHzkxKhlDPZ9ganlWs/V3cLA8VI+/ZB03
 4KMIg9bMRxLjFW3Yh6BZcxyUlOKMan7skcDxVMUKnuHpI1E1djg06W/A5dXuFps6KCpItHNYJvB
 DLwuMlYIOGcA9Wj2Z/a9+3SWm9tdNdYdhh4mCVojrDH7HiBEoWYygeuTnR4CFIwy86F89+W9qaY
 YQtx9YRjeu9lpXEcPpSWK+QgBEeOISQQIQ/wtmUqjL3Jp56yX/sgHXPjnQabMxouR9rygfu+Npb
 kRW+lIgo0Fu9wMOwu263gG8M8B9MsA==
X-Received: by 2002:a05:7022:3f04:b0:181:ccdd:ed2a with SMTP id
 a92af1059eb24-1ac5d5aaeb1mr19868363c88.43.1793717205159; 
 Tue, 03 Nov 2026 06:46:45 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm77500012c88.7.2026.11.03.06.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:46:44 -0800 (PST)
Date: Tue, 3 Nov 2026 23:46:32 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Gyeyoung Baek <gye976@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] accel/rocket: Report per-core engine usage through
 fdinfo
Message-ID: <aunzk5qQOHBEEH3s@rock-5b-plus>
References: <20261101152723.1430312-1-sidong.yang@furiosa.ai>
 <CAPsqS2Q_U=ZJEnZ=hCztVW=_8iRvj4uy-3cGbOLNLJaYMjdQbQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPsqS2Q_U=ZJEnZ=hCztVW=_8iRvj4uy-3cGbOLNLJaYMjdQbQ@mail.gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:51:16AM +0100, Tomeu Vizoso wrote:
> Hi Sidong,
> 
> can you please check the drm usage stats spec at
> Documentation/gpu/drm-usage-stats.rst ?
> 
> I think you need to conform to the key naming part of it, with a
> single key with a capacity equal to the number of cores. We also need
> an entry in Documentation/gpu/drm-usage-stats.rst like the other
> drivers have.

Hi Tomeu,

Thanks, I'll send v4 with a single key and capacity, and the
documentation. v3 crossed with your mail, so please ignore it.

Thanks,
Sidong

> 
> Btw, with a perfmon ioctl, we could have Perfetto integration and
> benefit from other work such as drm-sched tracepoint visualization.
> Just saying in case it can help in your use cases.
> 
> Thanks,
> 
> Tomeu
> 
> On Sun, Nov 1, 2026 at 4:27 PM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > There is no way to tell how much of the NPU a client uses, or whether its
> > jobs reach more than one core. Implement the DRM usage stats: account the
> > time each job occupies a core and report it per client as
> > drm-engine-npu<n>, along with drm_show_memory_stats() for the BOs.
> >
> > Jobs can outlive the file that submitted them, so the counters are
> > refcounted and each job holds a reference. The time covers the whole
> > period a job owns a core, so it also includes handling the completion
> > interrupt and the gaps between the tasks of a multi-task job.
> >
> > The array is sized by rdev->max_cores, the number of core slots, not by
> > the number of cores bound when the file is opened. A core can still be
> > probing while a client opens the device, and the IRQ handler indexes the
> > array with core->index, which stays valid when a core is unbound. A slot
> > with no core bound reads as zero.
> >
> > For example, teflon running a model two operations deep 3001 times gives:
> >
> >   drm-engine-npu0:      22719385 ns
> >   drm-engine-npu1:      23345296 ns
> >   drm-engine-npu2:      0 ns
> >
> > The NPU is busy 15.6% of the wall clock time and one core is never used.
> >
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> > v2: Size the per-core counters by rdev->max_cores, the number of core
> >     slots, instead of the number of cores bound when the file is opened.
> >     Sashiko reported the out-of-bounds read and Gyeyoung Baek reproduced
> >     it with KASAN.
> >
> >     This depends on commit 6eff1d69dae8 ("accel/rocket: search every core
> >     slot when a core is removed"), which added rdev->max_cores. It is in
> >     mainline through drm-misc-fixes but not yet in drm-misc-next.
> >
> > Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1-sidong.yang@furiosa.ai/
> >
> >  drivers/accel/rocket/rocket_drv.c | 60 +++++++++++++++++++++++++++++--
> >  drivers/accel/rocket/rocket_drv.h | 14 ++++++++
> >  drivers/accel/rocket/rocket_job.c |  7 ++++
> >  drivers/accel/rocket/rocket_job.h |  4 +++
> >  4 files changed, 83 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
> > index 2bcfe4ab3c68..58a486206565 100644
> > --- a/drivers/accel/rocket/rocket_drv.c
> > +++ b/drivers/accel/rocket/rocket_drv.c
> > @@ -3,8 +3,10 @@
> >
> >  #include <drm/drm_accel.h>
> >  #include <drm/drm_drv.h>
> > +#include <drm/drm_file.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_ioctl.h>
> > +#include <drm/drm_print.h>
> >  #include <drm/rocket_accel.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > @@ -68,6 +70,25 @@ rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
> >         kref_put(&domain->kref, rocket_iommu_domain_destroy);
> >  }
> >
> > +static void
> > +rocket_engine_usage_destroy(struct kref *kref)
> > +{
> > +       kfree(container_of(kref, struct rocket_engine_usage, kref));
> > +}
> > +
> > +struct rocket_engine_usage *
> > +rocket_engine_usage_get(struct rocket_file_priv *rocket_priv)
> > +{
> > +       kref_get(&rocket_priv->engine_usage->kref);
> > +       return rocket_priv->engine_usage;
> > +}
> > +
> > +void
> > +rocket_engine_usage_put(struct rocket_engine_usage *usage)
> > +{
> > +       kref_put(&usage->kref, rocket_engine_usage_destroy);
> > +}
> > +
> >  static int
> >  rocket_open(struct drm_device *dev, struct drm_file *file)
> >  {
> > @@ -86,10 +107,19 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
> >         }
> >
> >         rocket_priv->rdev = rdev;
> > +
> > +       rocket_priv->engine_usage = kzalloc_flex(*rocket_priv->engine_usage,
> > +                                                elapsed_ns, rdev->max_cores);
> > +       if (!rocket_priv->engine_usage) {
> > +               ret = -ENOMEM;
> > +               goto err_free;
> > +       }
> > +       kref_init(&rocket_priv->engine_usage->kref);
> > +
> >         rocket_priv->domain = rocket_iommu_domain_create(rdev->cores[0].dev);
> >         if (IS_ERR(rocket_priv->domain)) {
> >                 ret = PTR_ERR(rocket_priv->domain);
> > -               goto err_free;
> > +               goto err_put_engine_usage;
> >         }
> >
> >         file->driver_priv = rocket_priv;
> > @@ -109,6 +139,8 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
> >         mutex_destroy(&rocket_priv->mm_lock);
> >         drm_mm_takedown(&rocket_priv->mm);
> >         rocket_iommu_domain_put(rocket_priv->domain);
> > +err_put_engine_usage:
> > +       rocket_engine_usage_put(rocket_priv->engine_usage);
> >  err_free:
> >         kfree(rocket_priv);
> >  err_put_mod:
> > @@ -125,6 +157,7 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
> >         mutex_destroy(&rocket_priv->mm_lock);
> >         drm_mm_takedown(&rocket_priv->mm);
> >         rocket_iommu_domain_put(rocket_priv->domain);
> > +       rocket_engine_usage_put(rocket_priv->engine_usage);
> >         kfree(rocket_priv);
> >         module_put(THIS_MODULE);
> >  }
> > @@ -139,7 +172,29 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
> >         ROCKET_IOCTL(FINI_BO, fini_bo),
> >  };
> >
> > -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> > +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> > +{
> > +       struct rocket_device *rdev = to_rocket_device(file->minor->dev);
> > +       struct rocket_file_priv *rocket_priv = file->driver_priv;
> > +       unsigned int core;
> > +
> > +       /*
> > +        * These are estimates: the time is taken around the whole period a job
> > +        * occupies a core, so it also covers handling the completion interrupt
> > +        * and, for a job made of several tasks, the gaps between them.
> > +        */
> > +       for (core = 0; core < rdev->max_cores; core++)
> > +               drm_printf(p, "drm-engine-npu%u:\t%llu ns\n", core,
> > +                          rocket_priv->engine_usage->elapsed_ns[core]);
> > +
> > +       drm_show_memory_stats(p, file);
> > +}
> > +
> > +static const struct file_operations rocket_accel_driver_fops = {
> > +       .owner = THIS_MODULE,
> > +       DRM_ACCEL_FOPS,
> > +       .show_fdinfo = drm_show_fdinfo,
> > +};
> >
> >  /*
> >   * Rocket driver version:
> > @@ -150,6 +205,7 @@ static const struct drm_driver rocket_drm_driver = {
> >         .open                   = rocket_open,
> >         .postclose              = rocket_postclose,
> >         .gem_create_object      = rocket_gem_create_object,
> > +       .show_fdinfo            = rocket_show_fdinfo,
> >         .ioctls                 = rocket_drm_driver_ioctls,
> >         .num_ioctls             = ARRAY_SIZE(rocket_drm_driver_ioctls),
> >         .fops                   = &rocket_accel_driver_fops,
> > diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
> > index 2c673bb99ccc..eff5c2ac54d1 100644
> > --- a/drivers/accel/rocket/rocket_drv.h
> > +++ b/drivers/accel/rocket/rocket_drv.h
> > @@ -16,6 +16,15 @@ struct rocket_iommu_domain {
> >         struct kref kref;
> >  };
> >
> > +/*
> > + * Time each core has spent running a client's jobs, in nanoseconds, indexed by
> > + * core. Jobs hold a reference, as they can outlive the file that submitted them.
> > + */
> > +struct rocket_engine_usage {
> > +       struct kref kref;
> > +       u64 elapsed_ns[];
> > +};
> > +
> >  struct rocket_file_priv {
> >         struct rocket_device *rdev;
> >
> > @@ -24,9 +33,14 @@ struct rocket_file_priv {
> >         struct mutex mm_lock;
> >
> >         struct drm_sched_entity sched_entity;
> > +
> > +       struct rocket_engine_usage *engine_usage;
> >  };
> >
> >  struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv);
> >  void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
> >
> > +struct rocket_engine_usage *rocket_engine_usage_get(struct rocket_file_priv *rocket_priv);
> > +void rocket_engine_usage_put(struct rocket_engine_usage *usage);
> > +
> >  #endif
> > diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> > index ce994748dd5d..c0ffbccfb6cc 100644
> > --- a/drivers/accel/rocket/rocket_job.c
> > +++ b/drivers/accel/rocket/rocket_job.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/sched/clock.h>
> >
> >  #include "rocket_core.h"
> >  #include "rocket_device.h"
> > @@ -265,6 +266,7 @@ static void rocket_job_cleanup(struct kref *ref)
> >         unsigned int i;
> >
> >         rocket_iommu_domain_put(job->domain);
> > +       rocket_engine_usage_put(job->engine_usage);
> >
> >         dma_fence_put(job->done_fence);
> >         dma_fence_put(job->inference_done_fence);
> > @@ -351,6 +353,7 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
> >
> >         scoped_guard(mutex, &core->job_lock) {
> >                 core->in_flight_job = job;
> > +               job->start_ns = local_clock();
> >                 rocket_job_hw_submit(core, job);
> >         }
> >
> > @@ -379,6 +382,9 @@ static void rocket_job_handle_irq(struct rocket_core *core)
> >                                 return;
> >                         }
> >
> > +                       core->in_flight_job->engine_usage->elapsed_ns[core->index] +=
> > +                               local_clock() - core->in_flight_job->start_ns;
> > +
> >                         iommu_detach_group(NULL, iommu_group_get(core->dev));
> >                         dma_fence_signal(core->in_flight_job->done_fence);
> >                         pm_runtime_put_autosuspend(core->dev);
> > @@ -587,6 +593,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
> >
> >         rjob->rdev = rdev;
> >         rjob->domain = rocket_iommu_domain_get(file_priv);
> > +       rjob->engine_usage = rocket_engine_usage_get(file_priv);
> >
> >         ret = drm_sched_job_init(&rjob->base,
> >                                  &file_priv->sched_entity,
> > diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
> > index 4ae00feec3b9..14aa78aebc99 100644
> > --- a/drivers/accel/rocket/rocket_job.h
> > +++ b/drivers/accel/rocket/rocket_job.h
> > @@ -38,6 +38,10 @@ struct rocket_job {
> >
> >         struct rocket_iommu_domain *domain;
> >
> > +       /* When the job was handed to a core, and where to account the time */
> > +       u64 start_ns;
> > +       struct rocket_engine_usage *engine_usage;
> > +
> >         struct kref refcount;
> >  };
> >
> >
> > base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
> > prerequisite-patch-id: 519bcdfdde80d902309c8346f749ebc4bb6b29c0
> > --
> > 2.53.0
> >
