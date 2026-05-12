Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8206CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0721110EB0D;
	Tue, 12 May 2026 13:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FOj8TgBA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0B010EB21
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:31:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C8B8861331
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F94AC4AF09
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778592687;
 bh=gHiae8Tm8WEGQomlCcq5bqDjmepoB3EYSnqeCXvxyYQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FOj8TgBALfFcmvigoRC9qlxAbhsn8BprN1mk6KfHOUDiHXAXr0WNgMDyA+Ka6KWSN
 7cJYp+heml34psgNB7/cxlVqtHyyZ/ySkxGzmDAg+Zx0s8s6a0Rl2dkkju+YlA8vGT
 I/elKTaRJcLXeaxNork9YKmOKD0oFYJZyyP0KWcypoL50J4uln3D7+YI5lSU4ZXVKb
 CJatYpeGH7QOIeYntLYJGePmHoEgpTynD4KAqqqA1LcL1/Ir4n4X+0a1wfFsLUPSq7
 RynnQE/5ZbGuPOym21dMMr8sPKA2qrptxQvn/JF/2aQAScoJEsH0scIVUxpaCzZrS/
 A2ip+14pLhblg==
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-67c2d57a5ceso9735409a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/pX82FocO6QldYedawNN38r18GGLVghk0CNx2XRQZxfddEHPLXCM5Kgk21+bAhh6CI4rdjUfTqtPY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzx4pD4f/XtuRvzW42/FiQPA34jRKmxdlJwk8iFhx5gvM6g7tQD
 s+c9izykrUqGWflfeVcYDOJ1/9w1zE1eFJ6ZTUBnkfDxSaYdvX76hq7TW/6DhMcqaDCz+3e2+Dg
 rLt7nB92SNqXhzgcvNSRhm+Ag95RYqA==
X-Received: by 2002:a17:907:9404:b0:bcb:9366:4cfb with SMTP id
 a640c23a62f3a-bcc12668f80mr892101966b.15.1778592685818; Tue, 12 May 2026
 06:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260306163658.2741860-2-robh@kernel.org>
 <CAPsqS2SVm=LruoyAaBUyEBkDuP1Bv1=a4t=Oucx+jwGTk9CCXQ@mail.gmail.com>
In-Reply-To: <CAPsqS2SVm=LruoyAaBUyEBkDuP1Bv1=a4t=Oucx+jwGTk9CCXQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 May 2026 08:31:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4nMVMA+8b3kOFo2_isAYK_ePeXFcmPn2i4mvsuNObqQ@mail.gmail.com>
X-Gm-Features: AVHnY4J6n_Uz0xU2sTEd2I86rxlmGjt5KV0_ZdfoyFrQrbgaLJrYRwSIJsRk6qg
Message-ID: <CAL_JsqK4nMVMA+8b3kOFo2_isAYK_ePeXFcmPn2i4mvsuNObqQ@mail.gmail.com>
Subject: Re: [PATCH] accel: ethosu: Add performance counter support
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
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

On Tue, May 5, 2026 at 12:45=E2=80=AFPM Tomeu Vizoso <tomeu@tomeuvizoso.net=
> wrote:
>
> Hi Rob,
>
> On Fri, Mar 6, 2026 at 5:38=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
> >
> > The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> > supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> > different events. There is also a dedicated cycle counter.
> >
> > The ABI and implementation are copied from the V3D driver. The main
> > difference in the ABI is there is no query API for the the event list.
> > The events differ between the U65 and U85, so the events lists are
> > maintained in userspace along with other differences between the U65 an=
d
> > U85.
> >
> > The cycle counter is always enabled when the PMU is enabled. When the
> > user requests N events, reading the counters will return the N events
> > plus the cycle counter.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> <snip>
>
> >
> >  struct ethosu_file_priv {
> >         struct ethosu_device *edev;
> >         struct drm_sched_entity sched_entity;
> > +
> > +       struct {
> > +               struct idr idr;
> > +               struct mutex lock;
> > +       } perfmon;
> > +};
> > +
> > +/* Performance monitor object. The perform lifetime is controlled by u=
serspace
> > + * using perfmon related ioctls. A perfmon can be attached to a submit=
_cl
>
> I guess submit_cl is more of a v3d thing?
>
> > + * request, and when this is the case, HW perf counters will be activa=
ted just
> > + * before the submit_cl is submitted to the GPU and disabled when the =
job is
> > + * done. This way, only events related to a specific job will be count=
ed.
> > + */
> > +struct ethosu_perfmon {
> > +       /* Tracks the number of users of the perfmon, when this counter=
 reaches
> > +        * zero the perfmon is destroyed.
> > +        */
> > +       refcount_t refcnt;
> > +
> > +       /* Protects perfmon stop, as it can be invoked from multiple pl=
aces. */
> > +       struct mutex lock;
> > +
> > +       /* Number of counters activated in this perfmon instance
> > +        * (should be less than or equal to DRM_ETHOSU_MAX_PERF_COUNTER=
S).
> > +        */
> > +       u8 ncounters;
> > +
> > +       /* Events counted by the HW perf counters. */
> > +       u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> > +
> > +       /* Storage for counter values. Counters are incremented by the
> > +        * HW perf counter values every time the perfmon is attached
> > +        * to a GPU job.  This way, perfmon users don't have to
> > +        * retrieve the results after each job if they want to track
> > +        * events covering several submissions.  Note that counter
> > +        * values can't be reset, but you can fake a reset by
> > +        * destroying the perfmon and creating a new one.
> > +        */
> > +       u64 values[] __counted_by(ncounters);
> >  };
>
> <snip>
>
> > +void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_=
perfmon *perfmon)
> > +{
> > +       unsigned int i;
> > +       u8 ncounters;
> > +       u32 mask;
> > +
> > +       if (WARN_ON_ONCE(!perfmon || ethosu->active_perfmon))
> > +               return;
> > +
> > +       writel_relaxed(PMCR_CNT_EN, ethosu->pmu_regs + NPU_REG_PMCR);
> > +       writel_relaxed(0x000011, ethosu->pmu_regs + NPU_REG_PMCCNTR_CFG=
);
>
> Can we use macros for this value so we have it documented in the source c=
ode?
>
> <snip>
>
> > +void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_p=
erfmon *perfmon,
> > +                     bool capture)
> > +{
> > +       unsigned int i;
> > +       u8 ncounters;
> > +       u32 mask;
> > +
> > +       if (!perfmon || !ethosu->active_perfmon)
> > +               return;
> > +
> > +       mutex_lock(&perfmon->lock);
> > +       if (perfmon !=3D ethosu->active_perfmon) {
> > +               mutex_unlock(&perfmon->lock);
> > +               return;
> > +       }
> > +
> > +       ncounters =3D perfmon->ncounters - 1;
> > +
> > +       if (capture) {
> > +               for (i =3D 0; i < ncounters; i++)
> > +                       perfmon->values[i] +=3D readl_relaxed(ethosu->p=
mu_regs + NPU_REG_PMU_EVCNTR(i));
> > +               perfmon->values[ncounters] +=3D
> > +                       readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNT=
R_LO) |
> > +                       (u64)readl_relaxed(ethosu->pmu_regs + NPU_REG_P=
MCCNTR_HI) << 32;
> > +       }
> > +
> > +       mask =3D 0x80000000;
> > +       if (ncounters)
> > +               mask |=3D GENMASK(ncounters - 1, 0);
> > +       writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENCLR);
> > +
> > +       writel_relaxed(0, ethosu->pmu_regs + NPU_REG_PMCR);
> > +       ethosu->active_perfmon =3D NULL;
> > +       mutex_unlock(&perfmon->lock);
>
> Wonder if the npu-idle counter won't continue to accumulate until we
> call stop(), and in that case, if we shouldn't stop the counters on
> the job IRQ. So we can know for how long the NPU was idle during the
> job, without extra idle time.

From what the h/w folks have told me, that is the only idle time. When
the job starts, the idle time is 0 and active counts every clock cycle
until we hit the STOP cmd.

>
> I think we could freeze the counters in the job_done IRQ, and harvest
> the values on job cleanup. At freeze time it would be good to also
> capture a timestamp and return to userspace in get_values, so that
> userspace doesn't have to take it with considerable delay (for tools
> such as Perfetto).

Note that perfetto uses the global perfmon which I think we want free
running and sampled.

Essentially, all the events other than idle and cycle cnt are stopped.

>
> <snip>
>
> > +int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
> > +                            struct drm_file *file_priv)
> > +{
> > +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv=
;
> > +       struct drm_ethosu_perfmon_create *req =3D data;
> > +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> > +       struct ethosu_perfmon *perfmon;
> > +       unsigned int i, event_max;
> > +       int ret;
> > +
> > +       /* Number of monitored counters cannot exceed HW limits. */
> > +       if (req->ncounters > ethosu->npu_info.pmu_counters)
> > +               return -EINVAL;
> > +
> > +       /* Make sure all counters are valid. */
> > +       event_max =3D ethosu_is_u65(ethosu) ? 433 : 671;
>
> Can we have macros for these constants?
>
> <snip>
>
> > +int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data=
,
> > +                                struct drm_file *file_priv)
> > +{
> > +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> > +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv=
;
> > +       struct drm_ethosu_perfmon_get_values *req =3D data;
> > +       struct ethosu_perfmon *perfmon;
> > +       int ret =3D 0;
> > +
> > +       if (req->pad !=3D 0)
> > +               return -EINVAL;
> > +
> > +       perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);
> > +       if (!perfmon)
> > +               return -EINVAL;
> > +
> > +       ret =3D pm_runtime_resume_and_get(dev->dev);
> > +       if (ret)
>
> Should we cal put() here?

Err, yes.

>
> > +               return ret;
> > +
> > +       ethosu_perfmon_stop(ethosu, perfmon, true);
> > +
> > +       pm_runtime_put_autosuspend(dev->dev);
> > +
> > +       if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->val=
ues,
> > +                        perfmon->ncounters * sizeof(u64)))
>
> And here?
>
> > +               ret =3D -EFAULT;
> > +
> > +       ethosu_perfmon_put(perfmon);
> > +
> > +       return ret;
> > +}
> > +
> > +int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data=
,
> > +                                struct drm_file *file_priv)
> > +{
> > +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv=
;
> > +       struct drm_ethosu_perfmon_set_global *req =3D data;
> > +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> > +       struct ethosu_perfmon *perfmon;
> > +
> > +       if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
> > +               return -EINVAL;
> > +
> > +       perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);
>
> Aren't we leaking this second reference?

No, this function does the get and then userspace calls
ethosu_ioctl_perfmon_destroy() to do the put. However, I think if
userspace forgets or crashes, then we need to do a put.

Rob
