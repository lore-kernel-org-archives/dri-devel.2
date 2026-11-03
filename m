Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D2606B12C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qCt93gv2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739E910F4EC;
	Tue,  3 Nov 2026 10:51:35 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E2510F4FD
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:51:29 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93e7ad9f78dso509244185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 02:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703088; cv=none;
 d=google.com; s=arc-20260327;
 b=rAu5rAauorqVcI/zStI4Uc0Q5C6jN5teHR6NDkUCxBqGF0UvFC2/1jrW1byPexOS+P
 LlJU5W537Yj4U7coVbp8VsJpLQ/yl2ttkGEBIl4ZvP1ywp7q+QzxOKwo//qsKaDVuqnd
 fGUPAa+QzYCxcl0Aq8+6GCc2nJ84HIOTLtSGHLHRsjnr74Qn1Tu8MZL3n5jn8wuQf2sO
 08z+OA6BxNIEENKsKC39BHJbqpJwithn18afa6zy3VnoW0hgCPuIkRiJLHRlHiLZ/wWA
 lAaV+MYX1hDlA6hHuBAWR8ViyyxiRp+TC6l2YJ6SpPW/1lZW+yf47bzmpEkl10NqiUGg
 6ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=imAw8ZIdSV8OvmuW0pEH39O2GWMZ5lvM009/jM+c93A=;
 fh=s7p3oHr38DXxwdzQMmU4ISvvSFwwJ0Brz4NBQCJiWJc=;
 b=oUOQS3tc0vGxzpVRurcIC8/AessOMW0WTRYJIAhFR/X2zIpUR7F1UFg3nnZ1aKcFrn
 yu7rdWrl5i58Cdz8S+Pox46q+TVqk835ENP7AFCqVSEzoRdHjLzJzsGS1vRnhMvLvqHb
 Krz3uXfFTJioyXEEFR4MTdesb3rjsSZCla0Cq43O+xlm106HN/4zco1WpaXlKhjkWwIx
 B3ZpoLjKp1t2KiMY7ryHd2IoCNAeFRPPFjMvO2yCdKsSpHyBsmLL3XjWFb7G7uPu2kfo
 19HpfKgiJNRTJtXRVOaMgDFp8UKS4FsmKvLeyZ+xAZZwXOh/ZElvncf6TloVboE1xxNJ
 /Qrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793703088;
 x=1794307888; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=imAw8ZIdSV8OvmuW0pEH39O2GWMZ5lvM009/jM+c93A=;
 b=qCt93gv2hVAFKa6XcLpfKvwTFCyOBn2Krw+dKo6mjNDwXeXQkRb6HQEC8Iz3vlVyO8
 lfGNpMydfUmjQtKzzdLaeiQEOXiu6VK9Dj8scoirv7ogomYMrCKG3FV2PeK9OARA4Vqv
 mzcehJ5TkjH/V5b5j4ruNPzWXjP3oehmzjActy9cY+V/qf8Dy4UnpcuaeBbXqK4oGhJP
 KpIvOFl3ldewaiwJOZcx+n96y3nKcGXNLAMinmbyjaZrFpar9/LdQFmcKOPcWr8uOStO
 G66xWF98YmB7EgWelOyX8fgYUXNfPCkCpcXCD6cQHXUNhsMzAMYqC6pZGQnLgxx2IbeH
 EbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703088; x=1794307888;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imAw8ZIdSV8OvmuW0pEH39O2GWMZ5lvM009/jM+c93A=;
 b=igTmuU4CkN/d22pf30bYyHhnmHcZOP+0L86U6ghpR0yHjuvxey4gaQi31cdrWqPsHc
 lrN6oUcbaGaNMfdgwsegmANjcvazdrkOtfDuFNBl3HPkn5TR3MPR/lEhK2Fk8Ay/Fx7l
 mZzVXNY8YwwpPX4q7iJ7R4M93yJK/I/PpsJM5EKbqaYNNN4oVOZud/AKoh/7kJqWyxRj
 SeuXTzygzWMOja9wBmGsAu5fldjU0Zhdwoaq8mBNlS/SLk6LeGk5zoNg7OJkw6CV341M
 88xxFoaFyUYYgJxl3c2BrGpa4V+sTQWP4cl+9P4gHyWQrBirc2cIAutf/16wVyc1GH/+
 q5Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOnYIdiUT47o7z9VUWEX36JMHDLuAX7fu8TtN8Vz1vLsuakosvghjevydoQjoekMtqODxLB8t3FGw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/IwXJsSBJ9drPWvgwvbZs6VMqdPYSHiCzaoOzi50KwljdoThA7
 0gOJPZJMVDg1190chviy2r03JvdTWen5YAV+aGUFRadrV0PBaW+nbwc4rOaE7P6Rt2PD8RhEmPF
 Wxsu2yIUld/HyQ0MeKUjYtbjSOXxvyEwadjKMG4wr5A==
X-Gm-Gg: AYBFou2bdrSl107f8cINjFdEQjvm1SZjiKDIWOsH9Eg0p5YgoepJIaPP2BE8s3Pk72Q
 T8qHm/ZFIV1HyS6AK38N6OfWQ1UyGUvxEb3fDR8h6B5iimVb07+Ov35w2/q26mIlcm6lcVi5Yxu
 VW+sQGuUrvzdYxWY4nrDlDPdEkxz0t5SVQ2X56+DG+0vbdPIO0ZLZsyye0v3RZtRtZotEjfELWo
 ap43ARjmxFsD8RD5PoWDphF4Fs4ocrhBeopz3z7paSO3g92DpADr8nT/RG/256h+NWU1p43ghko
 SpmT7ObWoncB69OUD1vBAYUaRAfFjHCP5nE/yq30wjaFoYN2+hfBDL0Zd0QOUNRgaEjDcIUzNYy
 Cgck0IL74hMPkFMoBrtIJDPeCVMT/eidMJV6VqkCVb/bwyoYgDJOO8XK5AslsuzElslRXXHpA73
 S9Xv8tEByuLRjHiSd8q/E=
X-Received: by 2002:a05:620a:84c4:b0:93e:66e6:fa4 with SMTP id
 af79cd13be357-94421712a8dmr1989192685a.16.1793703087871; Tue, 03 Nov 2026
 02:51:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101152723.1430312-1-sidong.yang@furiosa.ai>
In-Reply-To: <20261101152723.1430312-1-sidong.yang@furiosa.ai>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 3 Nov 2026 11:51:16 +0100
X-Gm-Features: AclHuK-z6BmO2pZg0oIpH0qZUB9cGfGSi7vP1P71zNtjG5vZjK7jOSPibONtTLI
Message-ID: <CAPsqS2Q_U=ZJEnZ=hCztVW=_8iRvj4uy-3cGbOLNLJaYMjdQbQ@mail.gmail.com>
Subject: Re: [PATCH v2] accel/rocket: Report per-core engine usage through
 fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Oded Gabbay <ogabbay@kernel.org>, Gyeyoung Baek <gye976@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sidong,

can you please check the drm usage stats spec at
Documentation/gpu/drm-usage-stats.rst ?

I think you need to conform to the key naming part of it, with a
single key with a capacity equal to the number of cores. We also need
an entry in Documentation/gpu/drm-usage-stats.rst like the other
drivers have.

Btw, with a perfmon ioctl, we could have Perfetto integration and
benefit from other work such as drm-sched tracepoint visualization.
Just saying in case it can help in your use cases.

Thanks,

Tomeu

On Sun, Nov 1, 2026 at 4:27=E2=80=AFPM Sidong Yang <sidong.yang@furiosa.ai>=
 wrote:
>
> There is no way to tell how much of the NPU a client uses, or whether its
> jobs reach more than one core. Implement the DRM usage stats: account the
> time each job occupies a core and report it per client as
> drm-engine-npu<n>, along with drm_show_memory_stats() for the BOs.
>
> Jobs can outlive the file that submitted them, so the counters are
> refcounted and each job holds a reference. The time covers the whole
> period a job owns a core, so it also includes handling the completion
> interrupt and the gaps between the tasks of a multi-task job.
>
> The array is sized by rdev->max_cores, the number of core slots, not by
> the number of cores bound when the file is opened. A core can still be
> probing while a client opens the device, and the IRQ handler indexes the
> array with core->index, which stays valid when a core is unbound. A slot
> with no core bound reads as zero.
>
> For example, teflon running a model two operations deep 3001 times gives:
>
>   drm-engine-npu0:      22719385 ns
>   drm-engine-npu1:      23345296 ns
>   drm-engine-npu2:      0 ns
>
> The NPU is busy 15.6% of the wall clock time and one core is never used.
>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
> v2: Size the per-core counters by rdev->max_cores, the number of core
>     slots, instead of the number of cores bound when the file is opened.
>     Sashiko reported the out-of-bounds read and Gyeyoung Baek reproduced
>     it with KASAN.
>
>     This depends on commit 6eff1d69dae8 ("accel/rocket: search every core
>     slot when a core is removed"), which added rdev->max_cores. It is in
>     mainline through drm-misc-fixes but not yet in drm-misc-next.
>
> Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1-sidong.y=
ang@furiosa.ai/
>
>  drivers/accel/rocket/rocket_drv.c | 60 +++++++++++++++++++++++++++++--
>  drivers/accel/rocket/rocket_drv.h | 14 ++++++++
>  drivers/accel/rocket/rocket_job.c |  7 ++++
>  drivers/accel/rocket/rocket_job.h |  4 +++
>  4 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 2bcfe4ab3c68..58a486206565 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -3,8 +3,10 @@
>
>  #include <drm/drm_accel.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
> +#include <drm/drm_print.h>
>  #include <drm/rocket_accel.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -68,6 +70,25 @@ rocket_iommu_domain_put(struct rocket_iommu_domain *do=
main)
>         kref_put(&domain->kref, rocket_iommu_domain_destroy);
>  }
>
> +static void
> +rocket_engine_usage_destroy(struct kref *kref)
> +{
> +       kfree(container_of(kref, struct rocket_engine_usage, kref));
> +}
> +
> +struct rocket_engine_usage *
> +rocket_engine_usage_get(struct rocket_file_priv *rocket_priv)
> +{
> +       kref_get(&rocket_priv->engine_usage->kref);
> +       return rocket_priv->engine_usage;
> +}
> +
> +void
> +rocket_engine_usage_put(struct rocket_engine_usage *usage)
> +{
> +       kref_put(&usage->kref, rocket_engine_usage_destroy);
> +}
> +
>  static int
>  rocket_open(struct drm_device *dev, struct drm_file *file)
>  {
> @@ -86,10 +107,19 @@ rocket_open(struct drm_device *dev, struct drm_file =
*file)
>         }
>
>         rocket_priv->rdev =3D rdev;
> +
> +       rocket_priv->engine_usage =3D kzalloc_flex(*rocket_priv->engine_u=
sage,
> +                                                elapsed_ns, rdev->max_co=
res);
> +       if (!rocket_priv->engine_usage) {
> +               ret =3D -ENOMEM;
> +               goto err_free;
> +       }
> +       kref_init(&rocket_priv->engine_usage->kref);
> +
>         rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0]=
.dev);
>         if (IS_ERR(rocket_priv->domain)) {
>                 ret =3D PTR_ERR(rocket_priv->domain);
> -               goto err_free;
> +               goto err_put_engine_usage;
>         }
>
>         file->driver_priv =3D rocket_priv;
> @@ -109,6 +139,8 @@ rocket_open(struct drm_device *dev, struct drm_file *=
file)
>         mutex_destroy(&rocket_priv->mm_lock);
>         drm_mm_takedown(&rocket_priv->mm);
>         rocket_iommu_domain_put(rocket_priv->domain);
> +err_put_engine_usage:
> +       rocket_engine_usage_put(rocket_priv->engine_usage);
>  err_free:
>         kfree(rocket_priv);
>  err_put_mod:
> @@ -125,6 +157,7 @@ rocket_postclose(struct drm_device *dev, struct drm_f=
ile *file)
>         mutex_destroy(&rocket_priv->mm_lock);
>         drm_mm_takedown(&rocket_priv->mm);
>         rocket_iommu_domain_put(rocket_priv->domain);
> +       rocket_engine_usage_put(rocket_priv->engine_usage);
>         kfree(rocket_priv);
>         module_put(THIS_MODULE);
>  }
> @@ -139,7 +172,29 @@ static const struct drm_ioctl_desc rocket_drm_driver=
_ioctls[] =3D {
>         ROCKET_IOCTL(FINI_BO, fini_bo),
>  };
>
> -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *f=
ile)
> +{
> +       struct rocket_device *rdev =3D to_rocket_device(file->minor->dev)=
;
> +       struct rocket_file_priv *rocket_priv =3D file->driver_priv;
> +       unsigned int core;
> +
> +       /*
> +        * These are estimates: the time is taken around the whole period=
 a job
> +        * occupies a core, so it also covers handling the completion int=
errupt
> +        * and, for a job made of several tasks, the gaps between them.
> +        */
> +       for (core =3D 0; core < rdev->max_cores; core++)
> +               drm_printf(p, "drm-engine-npu%u:\t%llu ns\n", core,
> +                          rocket_priv->engine_usage->elapsed_ns[core]);
> +
> +       drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations rocket_accel_driver_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       DRM_ACCEL_FOPS,
> +       .show_fdinfo =3D drm_show_fdinfo,
> +};
>
>  /*
>   * Rocket driver version:
> @@ -150,6 +205,7 @@ static const struct drm_driver rocket_drm_driver =3D =
{
>         .open                   =3D rocket_open,
>         .postclose              =3D rocket_postclose,
>         .gem_create_object      =3D rocket_gem_create_object,
> +       .show_fdinfo            =3D rocket_show_fdinfo,
>         .ioctls                 =3D rocket_drm_driver_ioctls,
>         .num_ioctls             =3D ARRAY_SIZE(rocket_drm_driver_ioctls),
>         .fops                   =3D &rocket_accel_driver_fops,
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99ccc..eff5c2ac54d1 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -16,6 +16,15 @@ struct rocket_iommu_domain {
>         struct kref kref;
>  };
>
> +/*
> + * Time each core has spent running a client's jobs, in nanoseconds, ind=
exed by
> + * core. Jobs hold a reference, as they can outlive the file that submit=
ted them.
> + */
> +struct rocket_engine_usage {
> +       struct kref kref;
> +       u64 elapsed_ns[];
> +};
> +
>  struct rocket_file_priv {
>         struct rocket_device *rdev;
>
> @@ -24,9 +33,14 @@ struct rocket_file_priv {
>         struct mutex mm_lock;
>
>         struct drm_sched_entity sched_entity;
> +
> +       struct rocket_engine_usage *engine_usage;
>  };
>
>  struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_p=
riv *rocket_priv);
>  void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
>
> +struct rocket_engine_usage *rocket_engine_usage_get(struct rocket_file_p=
riv *rocket_priv);
> +void rocket_engine_usage_put(struct rocket_engine_usage *usage);
> +
>  #endif
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ce994748dd5d..c0ffbccfb6cc 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -13,6 +13,7 @@
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/sched/clock.h>
>
>  #include "rocket_core.h"
>  #include "rocket_device.h"
> @@ -265,6 +266,7 @@ static void rocket_job_cleanup(struct kref *ref)
>         unsigned int i;
>
>         rocket_iommu_domain_put(job->domain);
> +       rocket_engine_usage_put(job->engine_usage);
>
>         dma_fence_put(job->done_fence);
>         dma_fence_put(job->inference_done_fence);
> @@ -351,6 +353,7 @@ static struct dma_fence *rocket_job_run(struct drm_sc=
hed_job *sched_job)
>
>         scoped_guard(mutex, &core->job_lock) {
>                 core->in_flight_job =3D job;
> +               job->start_ns =3D local_clock();
>                 rocket_job_hw_submit(core, job);
>         }
>
> @@ -379,6 +382,9 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>                                 return;
>                         }
>
> +                       core->in_flight_job->engine_usage->elapsed_ns[cor=
e->index] +=3D
> +                               local_clock() - core->in_flight_job->star=
t_ns;
> +
>                         iommu_detach_group(NULL, iommu_group_get(core->de=
v));
>                         dma_fence_signal(core->in_flight_job->done_fence)=
;
>                         pm_runtime_put_autosuspend(core->dev);
> @@ -587,6 +593,7 @@ static int rocket_ioctl_submit_job(struct drm_device =
*dev, struct drm_file *file
>
>         rjob->rdev =3D rdev;
>         rjob->domain =3D rocket_iommu_domain_get(file_priv);
> +       rjob->engine_usage =3D rocket_engine_usage_get(file_priv);
>
>         ret =3D drm_sched_job_init(&rjob->base,
>                                  &file_priv->sched_entity,
> diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/roc=
ket_job.h
> index 4ae00feec3b9..14aa78aebc99 100644
> --- a/drivers/accel/rocket/rocket_job.h
> +++ b/drivers/accel/rocket/rocket_job.h
> @@ -38,6 +38,10 @@ struct rocket_job {
>
>         struct rocket_iommu_domain *domain;
>
> +       /* When the job was handed to a core, and where to account the ti=
me */
> +       u64 start_ns;
> +       struct rocket_engine_usage *engine_usage;
> +
>         struct kref refcount;
>  };
>
>
> base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
> prerequisite-patch-id: 519bcdfdde80d902309c8346f749ebc4bb6b29c0
> --
> 2.53.0
>
