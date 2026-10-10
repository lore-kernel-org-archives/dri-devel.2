Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527F5CA9EBD
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29C410EB69;
	Sat, 10 Oct 2026 02:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EdY08S5P";
	dkim-atps=neutral
Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A1E10EB8C
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:55:52 +0000 (UTC)
Received: by mail-lr2-f1.google.com with SMTP id
 38308e7fff4ca-3a772511049so3008691fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 19:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791600951; cv=none;
 d=google.com; s=arc-20260327;
 b=q9NA30b0kprhaoRlcdJA0lUSJQ8K8UQbtc9xaNjRDixLKdWnVDPRwEiuoYOSoRU1rp
 m4wnbTHU6al+6TM0mbEEDZ9fhP0nBapn8zkkLsYVLMwmHr0zhCW04ZXRErNpwYWJdpAR
 i4O3EKLqrtiM3GysGpyYB7YQjlV4IZAaYOEJW9LItVOBagg0h3dJadSrMj5I+E9yCmL/
 Zvtt6e6DFYjfShKtg6lhVSmpWRiKduIXrNGlAQwtnuAhTgJ8qYMhCKAWyLA/f3FzRhI8
 dS28YXjjyJXlYa4GIFfjfPDcDDnjOLViT3SrAncD4/hYFHV3UeJ4YSS0dpgASX2Z3vP+
 ewuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Ed07fuWkE9fwos4AUZ3ykff2cVsq6dA1pVFJ9uVlwM=;
 fh=R4X1BBKAbhpm9eIAH+YZQ0rQs6WmPBe9yTrjlqGsjPU=;
 b=SPBMn1RvwOkJ2ebh3JAjtNEvUILYV47nS1qbsYLPb7v7a5sB77Dldh9/oEk5SaQAW5
 MYAzRRiKi2/5TdbnaDfRHlAc+mI+BRpi+pwxxk4s1zbpxL5skCfDLUA/qfKPxFkzxpgr
 uPofDpll+uqnJaS0ZGXxMhhJ2ETky70GzKiGFctyAYF8rzt96o7gxqOylpf4bqhnBjpX
 sSFqZNJhUhZ//0oCcv+s1a17lZ0JzQP4orZihBc2TzSQuwFPyb+akjoA22jtmO9X8Nqk
 +RoUpdbFvtdURwu9HhL9j0gpBXTmcxs9bJSJCvCt757yS3QTPCzUcHlbj+vzIRzNZUgC
 6o8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791600951; x=1792205751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Ed07fuWkE9fwos4AUZ3ykff2cVsq6dA1pVFJ9uVlwM=;
 b=EdY08S5PHI7IVT+JkyVrc8GdnpDTpsjaMLGfOCFn/mQZUr8I3wx4IStPE2jQ5I6Wwg
 G4Qa9fT7YokY+KdxWLdrzYkJOeOfI0REau0YgVELa9zA+NhEDjqq1Cyk37a7dha3Ryoq
 hUSfWpVOM9KHm7MMwQs6UnSuPFVCycLyG3R9bUVReuX5lsf+WdweLkwky+NuAnYC/XQW
 Eaai++CKd5y9hvM/pnAxSTkssEXd5JvjdfcJo9tVArCka7/8c3DLZ5C2hlJPvljg/rxS
 TDx7EZWdpoe1VE1GgUiHYh2T71xswQXJkC2JNVPgVRi47H9g9tUG71V0zvd7j1d2IdQj
 8oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600951; x=1792205751;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Ed07fuWkE9fwos4AUZ3ykff2cVsq6dA1pVFJ9uVlwM=;
 b=flBU5/uzuBZJWLgrywW5IBK6ODLjeb9ELZb+uRmeMKoX+i4K2JUwNT/CgysZMeg1cP
 tGstvzEesSXlvYsxYCcDEgenRDmTNRTW7q+gdwMM6mZRT51J4nM0KGwaGYqN+xTIo87n
 Y58UGh0daNudifMdEwHtIXVKkB75UrFgG7F5CkNlDR1toJFEeA228vuZlHf9LnN03fvN
 VVt6Rgb1nPTyhVYZM65Bx9306ZZNvnc453hd07r+/yd2Z90OFKZ9R58YLUoGqbuj9syp
 LLvK821qnPAchqlIpEm+9rN5yzd9HNCCQoamCh49mcYvG9QV4MA3KuOUsTiCWGPoNUH6
 O8tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3TKy0LYulXx36UcOvwr5RC3V5QYu+ruhGXSze45DSpZ/pAM2fIjk4dudHYYGFd03BdZBlRrEXVcw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLsa47tLa7numbdNz7CMdXxwB3lFeImgrVSAy8T4CAE0o4G3BCV
 mGDm7F9KS2o4e2j7pF+PzPO/1GqbRbiHklWCqC8xGjaRJqjlFyK7kEWcmmYNXNsN7laQ/+H7fAL
 i3yswABoMiGQZhbnr6WHbOJTh44c5LdE=
X-Gm-Gg: AYBFou28Y/bI67rK9qZ4YPAGYB52r1q3dtjWCWCkcKxf881xgrl2VpNXLWSzmoEYDWl
 jqRi/nr1oGPiyBpd5uaEUoTkKO+1Vtbpk9ux//ap6cwRpnB5IU7LcLSzp//XnE6nDFDosS49ZLp
 mx7t19gbn+ZnJXnr8+O7YwuICh8t9jUMIebu0a4hi/bRrMc4GEEdYQD9LXOKviPTs+0qmKY0om4
 sqlpCgT40QzSLNtaHUdY3AovOOLsDWJDq/pl0lBSE9QpkrOvJdEXzkeP7JX4Zvw0zlw0Gw3PwCg
 mA2nNo2Xn4/wCdu4v+92QkjsAy/Y1G0yWm2XFQBeKm788J/9b1lAGIfm
X-Received: by 2002:a05:651c:198f:b0:3a9:7993:14d9 with SMTP id
 38308e7fff4ca-3a9c55db6demr8033451fa.8.1791600950465; Fri, 09 Oct 2026
 19:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
 <2bbea75d-2e3f-4a57-a291-5f5d9ca698c5@amd.com>
 <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
In-Reply-To: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sat, 10 Oct 2026 10:55:38 +0800
X-Gm-Features: AclHuK8jQu2OuoKyhFajMg-wI8QX3TxzpO-LWoyEF9m9UL71Uox_eNc24B_fdJ4
Message-ID: <CAEnQdOrvD+uju5FBcew7TPWvfcfuSOHHyxuwF3T91yHOG5GYDQ@mail.gmail.com>
Subject: Re: [PATCH] amdkfd: fix doorbell allocation race creating duplicate
 allocations
To: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

You're right on both counts, thanks for the careful look.

v2 drops kfd->doorbell_mutex entirely and adds a per-process-device
mutex in struct kfd_process_device (initialized in
kfd_create_process_device_data()).  The device-global mutex is no
longer held across the sleeping allocations, so the existing
dqm->lock -> doorbell_mutex order on the start_cpsch() -> pm_init()
-> kq_initialize() path cannot invert, and unrelated processes no
longer serialize against each other for per-process doorbell setup.

The Fixes tag is corrected to 2105a15a2046 ("drm/amdgpu: use
doorbell mgr for kfd process doorbells").

Regards,
Henry

Kuehling, Felix <felix.kuehling@amd.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 23:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-10-09 11:00, Kuehling, Felix wrote:
> > On 2026-10-09 06:18, Henry Martin wrote:
> >> The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> >> lockless at every call site of kfd_alloc_process_doorbells():
> >> kfd_get_process_doorbells() (mmap of /dev/kfd), kfd_ioctl_create_queue=
()
> >> and the CRIU restore path each test the pointer under different
> >> locking (or none), so two racing threads can both observe NULL and
> >> each allocate a doorbell BO and bitmap, orphaning one allocation and
> >> handing the two mappings different backing pages.
> >>
> >> Move the serialization into kfd_alloc_process_doorbells() itself:
> >> take kfd->doorbell_mutex and re-check under it, so all three call
> >> sites are covered regardless of their own locking.  The existing
> >> doorbell_mutex users (kfd_get_kernel_doorbell() /
> >> kfd_release_kernel_doorbell()) only guard the device-global
> >> kfd->doorbell_bitmap in short non-sleeping sections and never call
> >> into this path, so there is no nesting.
> >>
> >> This vulnerability was discovered by Tencent CodeBuddy Security.
> >>
> >> Fixes: 428542d91772 ("drm/amd/display: Setup for
> >> mmhubbub3_warmup_mcif with big buffer")
> >> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> >
> > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> >
> > I'm applying the patch to amd-staging-drm-next.
>
> An automatic Claude review pointed out two problems with the patch. I
> agree with both:
>
> The Fixes: tag points at an unrelated drm/amd/display commit
> (428542d91772). It must be corrected =E2=80=94 2105a15a2046 ("drm/amdgpu:=
 use
> doorbell mgr for kfd process doorbells") is the commit that introduced
> the allocation being fixed.
>
> The patch holds the device-global kfd->doorbell_mutex across
> bitmap_zalloc(GFP_KERNEL) and amdgpu_bo_create_kernel(), while that same
> mutex is already acquired under dqm_lock via start_cpsch -> pm_init ->
> kq_initialize -> kfd_get_kernel_doorbell(). That is a plausible ABBA
> inversion once reclaim/TTM eviction runs the KFD eviction fence back
> into dqm_lock. Please either post lockdep (CONFIG_PROVE_LOCKING) results
> for a boot + queue-create cycle, or switch to a per-process-device lock,
> which also avoids serialising unrelated processes behind a device-wide
> mutex for per-process state.
>
> Regards,
>    Felix
>
>
> >
> > Thanks,
> >   Felix
> >
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> index fdcf7f2d1b5b4..07f881573837e 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev
> >> *kfd, struct kfd_process_device *
> >>       int r;
> >>       struct qcm_process_device *qpd =3D &pdd->qpd;
> >>
> >> +    mutex_lock(&kfd->doorbell_mutex);
> >> +
> >> +    /* Another thread may have won the check-and-allocate race */
> >> +    if (qpd->proc_doorbells) {
> >> +        mutex_unlock(&kfd->doorbell_mutex);
> >> +        return 0;
> >> +    }
> >> +
> >>       /* Allocate bitmap for dynamic doorbell allocation */
> >>       qpd->doorbell_bitmap =3D
> >> bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> >>                            GFP_KERNEL);
> >>       if (!qpd->doorbell_bitmap) {
> >>           DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> >> -        return -ENOMEM;
> >> +        r =3D -ENOMEM;
> >> +        goto unlock;
> >>       }
> >>
> >>       r =3D init_doorbell_bitmap(&pdd->qpd, kfd);
> >> @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev
> >> *kfd, struct kfd_process_device *
> >>           DRM_ERROR("Failed to allocate process doorbells\n");
> >>           goto err;
> >>       }
> >> +
> >> +    mutex_unlock(&kfd->doorbell_mutex);
> >>       return 0;
> >>
> >>   err:
> >>       bitmap_free(qpd->doorbell_bitmap);
> >>       qpd->doorbell_bitmap =3D NULL;
> >> +unlock:
> >> +    mutex_unlock(&kfd->doorbell_mutex);
> >>       return r;
> >>   }
> >>
> >> --
> >> 2.43.7
