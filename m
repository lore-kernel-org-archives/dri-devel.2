Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44C5CC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2743810E256;
	Wed, 14 Oct 2026 03:03:06 +0000 (UTC)
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A9110E380
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 03:03:00 +0000 (UTC)
Received: by mail-lr2-f7.google.com with SMTP id
 38308e7fff4ca-3a9ad752b4dso3318451fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791946979; cv=none;
 d=google.com; s=arc-20260327;
 b=LadRnQn9Ssuzbh0eOlYx679LENt8D6HKVAfkMmKtInTSWcVE0XdMfe57Rb/r0S1qmL
 rmwSSGxrNRhrHxm91LYhvvPviwsMVZnlIYrl6NHkh+MHEL5yCsspl9bG86eaJEdUAK/5
 YtKPPC1qRPUofkPSW/l9vm4k1G7IBGlbXHUNjplQwl+kKrxKHUPdH9u+HoX4+iZhjtZN
 Tgrz0FG3UhUCieh0+lj1muHU0VSs7jx7TfahzBwz6u3+3qnC3792pVh9zC1vgQHXWgAP
 lv57Xql2Ex6c+VAC8czmWFQlGzT0/bUpVAF7QZZkXUBRas+9vtZI+QCtPbdMlTawcYrD
 I3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
 fh=DCvuV85aUWIjBMFYV1+bKY4J0dcjOrYwWjvU4cpLaiI=;
 b=LdqGV0SVxF9V9RFiT/J0TohpNw1DuRn2Aixzf+s2gqTb/NmEC1oFWcPLfccl4sbJwg
 gi/6Z0FVTY5bqU4sxFoSrWvDL2qz2ZPSQH8xUBI6/GQF0XCdJ7xyC/+Wi8F3H/MJ9cGV
 FNWRXdWta/TM4J3ccMQ+Rnd6CjiEkufy4c7qvn3VNeTFhpVXcmeIuBbEsd0zpz9T6qEo
 NS5xtgTIpVWMNyjh05bKcB1e+qFPFTpbBNixn5HkG5CeEL8nXFj6kE8TgGSkw3Nx1ng3
 +Ljneg9ETAn6BEdxvXSmA/mmMDbZ1tPceMbw0WdufLaDXBLpwKAd96Y/JcOhWTU49Go8
 9J1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791946979; x=1792551779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
 b=c28mKWdiWFJE5y1hY4UPH7VZt0SOA7nefFD4nAhus9eWjhR3Epc+4stKfTy5aJdgSc
 +2NLPY0ncMdmNEadu0K7EqbcZZ5LNkRjs0Y+m5fU8yIs2VCfZXycTVSChVqAAn/U95Ao
 Kv2bTDdx4thul9EjxA5IU4YcuXmSTEmFcbnm348OLLeVpRYAfC9BI89qclLQL5XSGknB
 5NMe2eUsRSCBFQ3+MadotRbSLUekjXj7rMsR2Ptrzct1KKwL/avHVjHNZYHauaEdqQ/M
 AYaIqFNDNGS7iP3lmSH+ayt3KJRXLs1BhwWVKWN90p3ySr/dMiWia6/wrmhEw6z8bXlE
 1HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791946979; x=1792551779;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
 b=bGhAmqY2tteA4g0vl26a5uGKF/79TM9qAXKeEs9YKkrA1Bb2oOh//VTqBZmjn9KP3L
 vgiJbGlV/36sucDtBWj/vPv8xgpWLPTdbaq1ZLwNt0ZvVuNuUE8n9DdOUf18+2WMii48
 pOA2iP5Ad4/tJrnyd6NI+aw4uPsSmBHg5QKjwSsHTIqrGT2tvKGIzCrBGd16wFnAHpy1
 liqYkJTL3VclA4ztiw835AAqcqxcGC/SJL4q2DJcMze0KzwQUqo3Vr8zOSC4EVyhk6kj
 fvsBQLlofq/HnNdKKevEwDDI4anxyeGhIbNSogFRy0JjgR85HuaKXnyxx9ZP5C09fwtg
 c52Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzOZ7gTPrnphUNjkSbs1v5Be083wcHgrywuRBLkh0Yzhvptw/LfRczhNM+m7OJKw7anzR1c965pFc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/QtBUMsD7rgu2b7biRSxu2CL5ZnAwyrMj16NycXjse9h7sW2R
 3cphJnPuPHFfhNBCOO3o2+z2TBtL8rQwyMJwEHjkzZzu2woCgsSJQHA0DsQqmq9sbGjZhaBwy6N
 +Yr14WbJpueX1D29fTxspI9QF/z+Y3WY=
X-Gm-Gg: AYBFou2AIh8abXCxAuGkug4+2Qh0L+vUwbI+opN+cy14Rwm6WK0zcgfH+6zjY1Nfvd2
 lju/rSnK8NQ6E9iA89dygkjnPHxC5OKD+n2wdvlcHa4dSGdG+SIZYAu2TX74c4J3H8QBFB8GUV9
 M7rv7YyI+Vl/S2y8uZMC+yyEneAxM6aSyqHWohsss4scN5lnlCaP4+z5k5CPxCMFn5pahsFtfMg
 ORfUB8PCnasj3tmlw9Lp9CqO4HNg0EPODFojtzHwEVH4bcSzaAagSc6MbEypkKtQGHodiKgrdCQ
 qMb1y8nr0PB6zcH+fMBihC+uLi7xyuaWLO6pZyx+JsAY/fNkXBPZf7uFGY1xcsRnRIE=
X-Received: by 2002:a05:651c:1542:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3a9c539343dmr38351911fa.20.1791946978412; Tue, 13 Oct 2026
 20:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
 <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
 <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
In-Reply-To: <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 14 Oct 2026 11:02:46 +0800
X-Gm-Features: AclHuK9wmlZSIF4pzMKiC6asGVwJ7ETTkkdCmGmvxP7lUevo_EYe8yPIyar_-KM
Message-ID: <CAEnQdOpWJ-73FyQzgov2g9___KWptdK5PZcOkwi1FS4b6mhOFg@mail.gmail.com>
Subject: Re: [PATCH v2] amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hi Felix,

No objection at all - 16f0013157bf ("drm/amdkfd: Allocate doorbells
only when needed") looks right to me.  Thanks for the archaeology
and for taking care of the tag before submission.

Regards,
Henry

Felix Kuehling <felix.kuehling@amd.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 01:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-10-09 23:02, Henry Martin wrote:
> > The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> > lockless at every call site of kfd_alloc_process_doorbells():
> > kfd_get_process_doorbells() (mmap of /dev/kfd),
> > kfd_ioctl_create_queue() and the CRIU restore path each test the
> > pointer under different locking (or none), so two racing threads can
> > both observe NULL and each allocate a doorbell BO and bitmap,
> > orphaning one allocation and handing the two mappings different
> > backing pages.
> >
> > Move the serialization into kfd_alloc_process_doorbells() itself,
> > using a new per-process-device mutex so all three call sites are
> > covered regardless of their own locking.  The device-global
> > kfd->doorbell_mutex is not suitable here: it is acquired under
> > dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
> > kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
> > the sleeping allocations above would create a lock-ordering
> > inversion with dqm->lock via TTM eviction, and it would also
> > serialize doorbell setup of unrelated processes behind a
> > device-wide lock for per-process state.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2105a15a2046 ("drm/amdgpu: use doorbell mgr for kfd process door=
bells")
>
> I don't think the Fixes tag is correct, even though that's what Claude
> suggested. As far as I can see, the code had the same possible race
> condition before that change. I believe the problem goes back all the
> way to 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed").
> If you don't mind, I'll update that in the commit description before I
> submit your patch. With that, the patch is
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> Thanks,
>    Felix
>
>
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >
> > v2: Use a per-process-device mutex instead of kfd->doorbell_mutex
> >      (avoids the dqm->lock ordering inversion and the device-wide
> >      serialization) and correct the Fixes tag.  Pointed out by Felix
> >      Kuehling.
> >
> >   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  1 +
> >   3 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_doorbell.c
> > index fdcf7f2d1b5b4..55acadc986bee 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> > @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *k=
fd, struct kfd_process_device *
> >       int r;
> >       struct qcm_process_device *qpd =3D &pdd->qpd;
> >
> > +     mutex_lock(&pdd->doorbell_mutex);
> > +
> > +     /* Another thread may have won the check-and-allocate race */
> > +     if (qpd->proc_doorbells) {
> > +             mutex_unlock(&pdd->doorbell_mutex);
> > +             return 0;
> > +     }
> > +
> >       /* Allocate bitmap for dynamic doorbell allocation */
> >       qpd->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_=
PROCESS,
> >                                            GFP_KERNEL);
> >       if (!qpd->doorbell_bitmap) {
> >               DRM_ERROR("Failed to allocate process doorbell bitmap\n")=
;
> > -             return -ENOMEM;
> > +             r =3D -ENOMEM;
> > +             goto unlock;
> >       }
> >
> >       r =3D init_doorbell_bitmap(&pdd->qpd, kfd);
> > @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *k=
fd, struct kfd_process_device *
> >               DRM_ERROR("Failed to allocate process doorbells\n");
> >               goto err;
> >       }
> > +
> > +     mutex_unlock(&pdd->doorbell_mutex);
> >       return 0;
> >
> >   err:
> >       bitmap_free(qpd->doorbell_bitmap);
> >       qpd->doorbell_bitmap =3D NULL;
> > +unlock:
> > +     mutex_unlock(&pdd->doorbell_mutex);
> >       return r;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index d8631847f0eb9..96e59133fee02 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -779,6 +779,9 @@ struct kfd_process_device {
> >       /* per-process-per device QCM data structure */
> >       struct qcm_process_device qpd;
> >
> > +     /* Serializes process doorbell allocation for this device */
> > +     struct mutex doorbell_mutex;
> > +
> >       /*Apertures*/
> >       uint64_t lds_base;
> >       uint64_t lds_limit;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_process.c
> > index 0a7c1900da959..4efe4dae79c13 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -1788,6 +1788,7 @@ struct kfd_process_device *kfd_create_process_dev=
ice_data(struct kfd_node *dev,
> >       pdd->dev =3D dev;
> >       INIT_LIST_HEAD(&pdd->qpd.queues_list);
> >       INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> > +     mutex_init(&pdd->doorbell_mutex);
> >       pdd->qpd.dqm =3D dev->dqm;
> >       pdd->qpd.pqm =3D &p->pqm;
> >       pdd->qpd.evicted =3D 0;
