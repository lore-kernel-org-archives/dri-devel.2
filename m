Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845AACD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 17:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDB910E139;
	Tue,  5 May 2026 17:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="wJi18V5/";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA22910E139
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 17:45:50 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-62e7d2633e9so110149137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 10:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778003149; cv=none;
 d=google.com; s=arc-20240605;
 b=i9YRV2MT9A2JfBKtwxphgZx25FNGNTkngH6TF4DuTltW9UfGWlhgPd9sWngYe4iawi
 aXfJwZpN7nvcXSEwQYaCjFKfXwTPRiNv9oXel3u9gUpcV5gUlCBaSC4vsA4jorJR4srW
 WFAzvPOyFMo4KllyMsiUCwoIEsf9jRzfXKgmA06+Eow9zBRva7+Qi9VOnL6FMCaZP4+F
 G3o16FUNJj8QtDMbHFzv0z1gAI498SfvkcSE10yujbNrNXF962fvakoI28yYaYLI5nEC
 nQzUPcJCOcLAr6JSZwi4FYAux7It3X3tHhraiAvo6ClQX6vvolW+CWUojYRIXW2Zdsym
 Ybhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hmZ3nDqeDExQJSNMJTyHpyr8eUa2AAYnNivoPeEVhIw=;
 fh=N534StU6t0q/irV0/ZhB04dFt1zZAKXfy6EwzUXzsqU=;
 b=WEhwTvGDhh4sUO9Jkupv/8fxfRCBmLp5WcO9Z++PVS7Hp5aw6aNjHW35CrzZn8q6OW
 o/Oyn/JC1JF5ffRIEnBwtv5TXkmj9BUH1aKHSyPwCEp2AxEUQ11tWP/1yPk9F2+L+DQX
 uKSvpm/cw8ckC3IS8j8NXykZ8zpA6fjMGGhYMVOa/UKcFTPFmHhPkZi0/q3FWTL09Xav
 5JBK0OWZ1KOTVtvWENblzR+41G/EjMOdhUzdv3uPJCEh/x7NL8A5nV38YNn+HD0CeyHG
 8/kMpB8W7G077ieG0tXqRazqDsAJMnLF7ZSuJad6sLotM1Kvhp7nKJy1+H2K+N2pJEL/
 4CAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1778003149;
 x=1778607949; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmZ3nDqeDExQJSNMJTyHpyr8eUa2AAYnNivoPeEVhIw=;
 b=wJi18V5/HZbhKq+ETbxLoSu/3183EcSZsMXwkbXnRy6Dlre5q/khPYPmkc1NCocgQh
 Ca0Ijs6fnUtjw8oPECJcIIqCXEUoMXW4DqeTU/Dg6Gdr9epLxJb59OaEJ7tDDCcX+RG2
 ugKC7RlhHZ66tzhAQLD1ff/XAW5bXKQSe7ST6ARyZUxPiMxlBK6g1bl4NZcWVW3pWjW0
 l87VROIigZn+CgB1riLC3cfJfYKVum108DLYsyc/K2Ob2faxbNlcSuaaZdB1jwkO6lHt
 nnjBu05dFtVW6sdATDc0caQzwe06hBH4apZBLfWMb90IL++Gv7QvQQa3E+hEDCsbA+Gp
 k7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003149; x=1778607949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmZ3nDqeDExQJSNMJTyHpyr8eUa2AAYnNivoPeEVhIw=;
 b=ITPwZvoKYEHgVzc/xP8AjBCWr5NRknOwLCO/M2nWWxN1RsvaKcwZ4tWZowQZ+q6lAU
 koTHNCmKKpxObqU4aNFtVKFXO6GiSP/jeWmRtCsVGUejfg6gMXER+cwnBmp7/RnRJhvs
 m6F0B18rHX53MgsxnBy4kk+gPrvzDJjqObkiKxEu0kFSgEGbTT+Jpl79V7ahyRcUy8V5
 3vxTLEkNHQ51E11HRB9Qi01Vz3Jqwo5JAVhsG/ucG2qHZ1loqMVeKr1GrAO03uQ3f9FP
 ddf3yEu0OK69Th+vp5SE+NRqr0YqS5L3IEGXvsGVo6GHTmpUsCOVNG6KcydYcBweC20G
 HCFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+P0blJLplxNHyNrctL3ELBPHZIhpExhE+DokFfcvn2M6pQjWXkG+dCrXhJTxqee7/vfO0cg+yDlo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYIGaSXz8rdjh5JgDpA/n8WtcR/cIr62zRtoVThcQJ22h8Xvea
 foZU+a+SfUiSdrDWpSjKC/nIjvbKqFtyq2HUrijzzf8eRgMBZDIaxqVRxyJ6bAcn18JFEo0HKoe
 kLRtvu7OD0tvh1kjoo8hDE4CSdzChcbgz8gmou4gktQ==
X-Gm-Gg: AeBDietBqRHDRts1n6mAZEFTGAomLo4Gffpow3V2tgPPYxAqJX3OgRKWtQHAPapyHOz
 0t6yYRi0/6FbMZ/oQfFxwvRN24K/rTlYlWYkSwvxdvPtRLB2aiy5clLY3benhmbNcxko8hzgUNe
 rQgbZ474ikW4JT/YxLj0oBWhnf0fKbY5hwHSXfYLjR9G6Q3iux+vUJBBQxCZLVy/CqAksy1dM5X
 G/6NidQqXzAYjnEBLYbrlaq1Id4HPEphyzZTx4zScuEF0placEzhu2g8706jrIjnoIvvPLaX5HR
 AUNtQeDEefKato10hA==
X-Received: by 2002:a05:6102:688f:b0:60f:b19b:e52c with SMTP id
 ada2fe7eead31-62f55a12512mr2523351137.17.1778003148995; Tue, 05 May 2026
 10:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260306163658.2741860-2-robh@kernel.org>
In-Reply-To: <20260306163658.2741860-2-robh@kernel.org>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 5 May 2026 19:45:35 +0200
X-Gm-Features: AVHnY4Letji3hBYAMx1BxULT-fxmkVkmwMfiiE8fbZYo1Qh4xAyZ5plOyGKGyIU
Message-ID: <CAPsqS2SVm=LruoyAaBUyEBkDuP1Bv1=a4t=Oucx+jwGTk9CCXQ@mail.gmail.com>
Subject: Re: [PATCH] accel: ethosu: Add performance counter support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Rob,

On Fri, Mar 6, 2026 at 5:38=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> different events. There is also a dedicated cycle counter.
>
> The ABI and implementation are copied from the V3D driver. The main
> difference in the ABI is there is no query API for the the event list.
> The events differ between the U65 and U85, so the events lists are
> maintained in userspace along with other differences between the U65 and
> U85.
>
> The cycle counter is always enabled when the PMU is enabled. When the
> user requests N events, reading the counters will return the N events
> plus the cycle counter.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

<snip>

>
>  struct ethosu_file_priv {
>         struct ethosu_device *edev;
>         struct drm_sched_entity sched_entity;
> +
> +       struct {
> +               struct idr idr;
> +               struct mutex lock;
> +       } perfmon;
> +};
> +
> +/* Performance monitor object. The perform lifetime is controlled by use=
rspace
> + * using perfmon related ioctls. A perfmon can be attached to a submit_c=
l

I guess submit_cl is more of a v3d thing?

> + * request, and when this is the case, HW perf counters will be activate=
d just
> + * before the submit_cl is submitted to the GPU and disabled when the jo=
b is
> + * done. This way, only events related to a specific job will be counted=
.
> + */
> +struct ethosu_perfmon {
> +       /* Tracks the number of users of the perfmon, when this counter r=
eaches
> +        * zero the perfmon is destroyed.
> +        */
> +       refcount_t refcnt;
> +
> +       /* Protects perfmon stop, as it can be invoked from multiple plac=
es. */
> +       struct mutex lock;
> +
> +       /* Number of counters activated in this perfmon instance
> +        * (should be less than or equal to DRM_ETHOSU_MAX_PERF_COUNTERS)=
.
> +        */
> +       u8 ncounters;
> +
> +       /* Events counted by the HW perf counters. */
> +       u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> +
> +       /* Storage for counter values. Counters are incremented by the
> +        * HW perf counter values every time the perfmon is attached
> +        * to a GPU job.  This way, perfmon users don't have to
> +        * retrieve the results after each job if they want to track
> +        * events covering several submissions.  Note that counter
> +        * values can't be reset, but you can fake a reset by
> +        * destroying the perfmon and creating a new one.
> +        */
> +       u64 values[] __counted_by(ncounters);
>  };

<snip>

> +void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_pe=
rfmon *perfmon)
> +{
> +       unsigned int i;
> +       u8 ncounters;
> +       u32 mask;
> +
> +       if (WARN_ON_ONCE(!perfmon || ethosu->active_perfmon))
> +               return;
> +
> +       writel_relaxed(PMCR_CNT_EN, ethosu->pmu_regs + NPU_REG_PMCR);
> +       writel_relaxed(0x000011, ethosu->pmu_regs + NPU_REG_PMCCNTR_CFG);

Can we use macros for this value so we have it documented in the source cod=
e?

<snip>

> +void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_per=
fmon *perfmon,
> +                     bool capture)
> +{
> +       unsigned int i;
> +       u8 ncounters;
> +       u32 mask;
> +
> +       if (!perfmon || !ethosu->active_perfmon)
> +               return;
> +
> +       mutex_lock(&perfmon->lock);
> +       if (perfmon !=3D ethosu->active_perfmon) {
> +               mutex_unlock(&perfmon->lock);
> +               return;
> +       }
> +
> +       ncounters =3D perfmon->ncounters - 1;
> +
> +       if (capture) {
> +               for (i =3D 0; i < ncounters; i++)
> +                       perfmon->values[i] +=3D readl_relaxed(ethosu->pmu=
_regs + NPU_REG_PMU_EVCNTR(i));
> +               perfmon->values[ncounters] +=3D
> +                       readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNTR_=
LO) |
> +                       (u64)readl_relaxed(ethosu->pmu_regs + NPU_REG_PMC=
CNTR_HI) << 32;
> +       }
> +
> +       mask =3D 0x80000000;
> +       if (ncounters)
> +               mask |=3D GENMASK(ncounters - 1, 0);
> +       writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENCLR);
> +
> +       writel_relaxed(0, ethosu->pmu_regs + NPU_REG_PMCR);
> +       ethosu->active_perfmon =3D NULL;
> +       mutex_unlock(&perfmon->lock);

Wonder if the npu-idle counter won't continue to accumulate until we
call stop(), and in that case, if we shouldn't stop the counters on
the job IRQ. So we can know for how long the NPU was idle during the
job, without extra idle time.

I think we could freeze the counters in the job_done IRQ, and harvest
the values on job cleanup. At freeze time it would be good to also
capture a timestamp and return to userspace in get_values, so that
userspace doesn't have to take it with considerable delay (for tools
such as Perfetto).

<snip>

> +int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
> +                            struct drm_file *file_priv)
> +{
> +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
> +       struct drm_ethosu_perfmon_create *req =3D data;
> +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> +       struct ethosu_perfmon *perfmon;
> +       unsigned int i, event_max;
> +       int ret;
> +
> +       /* Number of monitored counters cannot exceed HW limits. */
> +       if (req->ncounters > ethosu->npu_info.pmu_counters)
> +               return -EINVAL;
> +
> +       /* Make sure all counters are valid. */
> +       event_max =3D ethosu_is_u65(ethosu) ? 433 : 671;

Can we have macros for these constants?

<snip>

> +int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
> +                                struct drm_file *file_priv)
> +{
> +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
> +       struct drm_ethosu_perfmon_get_values *req =3D data;
> +       struct ethosu_perfmon *perfmon;
> +       int ret =3D 0;
> +
> +       if (req->pad !=3D 0)
> +               return -EINVAL;
> +
> +       perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);
> +       if (!perfmon)
> +               return -EINVAL;
> +
> +       ret =3D pm_runtime_resume_and_get(dev->dev);
> +       if (ret)

Should we cal put() here?

> +               return ret;
> +
> +       ethosu_perfmon_stop(ethosu, perfmon, true);
> +
> +       pm_runtime_put_autosuspend(dev->dev);
> +
> +       if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->value=
s,
> +                        perfmon->ncounters * sizeof(u64)))

And here?

> +               ret =3D -EFAULT;
> +
> +       ethosu_perfmon_put(perfmon);
> +
> +       return ret;
> +}
> +
> +int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
> +                                struct drm_file *file_priv)
> +{
> +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
> +       struct drm_ethosu_perfmon_set_global *req =3D data;
> +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> +       struct ethosu_perfmon *perfmon;
> +
> +       if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
> +               return -EINVAL;
> +
> +       perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);

Aren't we leaking this second reference?

Thanks!

Tomeu

> +       if (!perfmon)
> +               return -EINVAL;
> +
> +       /* If the request is to clear the global performance monitor */
> +       if (req->flags & DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
> +               if (!ethosu->global_perfmon)
> +                       return -EINVAL;
> +
> +               xchg(&ethosu->global_perfmon, NULL);
> +
> +               return 0;
> +       }
> +
> +       if (cmpxchg(&ethosu->global_perfmon, NULL, perfmon))
> +               return -EBUSY;
> +
> +       return 0;
> +}
> diff --git a/include/uapi/drm/ethosu_accel.h b/include/uapi/drm/ethosu_ac=
cel.h
> index af78bb4686d7..dde6756642ea 100644
> --- a/include/uapi/drm/ethosu_accel.h
> +++ b/include/uapi/drm/ethosu_accel.h
> @@ -43,6 +43,11 @@ enum drm_ethosu_ioctl_id {
>
>         /** @DRM_ETHOSU_SUBMIT: Submit a job and BOs to run. */
>         DRM_ETHOSU_SUBMIT,
> +
> +       DRM_ETHOSU_PERFMON_CREATE,
> +       DRM_ETHOSU_PERFMON_DESTROY,
> +       DRM_ETHOSU_PERFMON_GET_VALUES,
> +       DRM_ETHOSU_PERFMON_SET_GLOBAL,
>  };
>
>  /**
> @@ -79,6 +84,7 @@ struct drm_ethosu_npu_info {
>         __u32 config;
>
>         __u32 sram_size;
> +       __u32 pmu_counters;
>  };
>
>  /**
> @@ -220,8 +226,51 @@ struct drm_ethosu_submit {
>         /** Input: Number of jobs passed in. */
>         __u32 job_count;
>
> -       /** Reserved, must be zero. */
> +       /** Input: Id returned by DRM_ETHOSU_PERFMON_CREATE */
> +       __u32 perfmon_id;
> +};
> +
> +#define DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS     8
> +#define DRM_ETHOSU_MAX_PERF_COUNTERS \
> +       (DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS + 1)
> +
> +struct drm_ethosu_perfmon_create {
> +       __u32 id;
> +       __u32 ncounters;
> +       __u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> +};
> +
> +struct drm_ethosu_perfmon_destroy {
> +       __u32 id;
> +};
> +
> +/*
> + * Returns the values of the performance counters tracked by this
> + * perfmon (as an array of (ncounters + 1) u64 values).
> + *
> + * No implicit synchronization is performed, so the user has to
> + * guarantee that any jobs using this perfmon have already been
> + * completed.
> + */
> +struct drm_ethosu_perfmon_get_values {
> +       __u32 id;
>         __u32 pad;
> +       __u64 values_ptr;
> +};
> +
> +#define DRM_ETHOSU_PERFMON_CLEAR_GLOBAL    0x0001
> +
> +/**
> + * struct drm_ethosu_perfmon_set_global - ioctl to define a global perfo=
rmance
> + * monitor
> + *
> + * The global performance monitor will be used for all jobs. If a global
> + * performance monitor is defined, jobs with a self-defined performance
> + * monitor won't be allowed.
> + */
> +struct drm_ethosu_perfmon_set_global {
> +       __u32 flags;
> +       __u32 id;
>  };
>
>  /**
> @@ -252,6 +301,14 @@ enum {
>                 DRM_IOCTL_ETHOSU(WR, CMDSTREAM_BO_CREATE, cmdstream_bo_cr=
eate),
>         DRM_IOCTL_ETHOSU_SUBMIT =3D
>                 DRM_IOCTL_ETHOSU(WR, SUBMIT, submit),
> +       DRM_IOCTL_ETHOSU_PERFMON_CREATE =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_CREATE, perfmon_create),
> +       DRM_IOCTL_ETHOSU_PERFMON_DESTROY =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_DESTROY, perfmon_destroy),
> +       DRM_IOCTL_ETHOSU_PERFMON_GET_VALUES =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_GET_VALUES, perfmon_get_valu=
es),
> +       DRM_IOCTL_ETHOSU_PERFMON_SET_GLOBAL =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_SET_GLOBAL, perfmon_set_glob=
al),
>  };
>
>  #if defined(__cplusplus)
> --
> 2.51.0
>
