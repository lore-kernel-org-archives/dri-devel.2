Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E4F606A31B
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GIcBgfYH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713CF10E0DE;
	Sat, 24 Oct 2026 18:30:12 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740D510E04F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 18:30:05 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ab3f899c8aso330282a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 11:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792866605; cv=none;
 d=google.com; s=arc-20260327;
 b=mxBD3LEZXNG7hCPrK/5JLdmnSfDV+wiUpqbR1bxeZCn8Rhe4AucErbG0vl0OLwS25r
 Vqido0Q4A27QedNUrTTMtDfjgzeCPfc+XDCXOaSCEgtsR6mfqMHETLcm4zw6cT6QChe2
 2J15cmDAmvEpRSTIc3ZtUpZLgEaJAZd2rrBDIEYoCZ9xvNo++neYVSF1xty5CVn3YHM+
 +JcBotHKRVXjghJCehbSVXkIMGfAoM2ivacWrNTmfN9vEetZWwDrIHkUqsT5NubFGFcf
 b0VHuFhGdG4G88cOFvxpbuFJXfXEGZc7cxvz5WNk7G/DRGlHN1DlCc70S1DQWjDEmMIO
 e/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
 fh=WneOUHoPlQA+zIbMvBzvAsPF/HjhHAjnhQkG6EnAMC8=;
 b=sFlRCvmEvkJ2HdiJxxxmK9jmiTPqLZViWqT17KNbD/CCFced86gSFf5hL+QidIkm5u
 WUuGQUAiY7Tbcnq463LfN6y7o+5xa3ZQ9CoTs8a+lxGg8yBdBuYhWH7ZB875oTDH/euh
 K4asJreQR12K8SVP5n8A8OpGbArUbyFMU1doJTMgk9lQtOhj6NlyZcF8vGZ6nabmL0Pj
 ysnvHs73A7Y6g6kDU7Y7SH7wG0b+qUmU2my5TXLGRFh/VNIeiKxzE7PWI41WE0BD6Yn5
 oQD1hYu0hMMD3JA+8+xmgzb4zyfqk92G4+5K+CQQOjouxzUQFhrFcEh0l6xqO9cSc1rU
 hZ0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792866605; x=1793471405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
 b=GIcBgfYHYnOtRURjwu36DJ3A1h+3eR9/7/Xk8Jti8T2WNJ5OGrrG2O6Ydq2TvQcdyw
 CrPJVo2ReJvyCD701Rm5geSa1zea+TdvA5GEyICKArT745dzRxtrwydRiE80PGKXU2xi
 LG+JVb/jYzG0NFZLFk+gmoIpsUEDjhlIFYbCY2drut30QLKq9EZXtxIunBr41Z06Xgr7
 aXycJfPK8bBq8K9lQOumq/tqfl6gMSt+oXYEkUDZXb7vtJ9RZsZ/TZ+cNn14Abdlcrrt
 P2kfoV9Z0t2Aj/PAMqQoGJTWjB3V8fQfNOdil66/cbFMw6QcKI4W62ittRshMfKnNqbu
 gLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792866605; x=1793471405;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
 b=aFZ1CLdkbk3SOahnMZ3jTXap8Do6TuXTjiuQA45CNoArle4DP+fCcIiRsumOc6oQxo
 M+OoqLpy9F5e2d3j9uOBMDfOLhY5zlPHaNXH8sq8JiDrK0mx1Z9NiqkjWRMw3GZZaOJj
 Gnn7QPXTT9aXPIbEdaFl7/XotFfngKcmzYofsiar771siufjhPTHFd0lCeYAjkb/hLIH
 0wZH3LuWt6C+Ds24R2WszJOD5oSAbjLSVBW2UhR2CJSiON56ey9KYJ2UtPMZXhpujxoE
 HftfuAPZuRWxO+6uBNt08tqXtLxfFsuBgy06jLIvGH4A7WgHFTCA8wAA+3Z+x37KQp8D
 MSQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4AmDYBOE0Usco913DXME/cfrv7lhUKwrVzFqBQ5lJriVl+Mcq46rHaSXC+TXbkkpgUXm6HGiqvKE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKRGJFvEEC3nQlQWzN3Kn8tsW/mRmqSDvC/rRN108F/QkBp9t7q
 nM0RlioHnJAyngnlCGirBtvKeFG1g5Apw1Xk4S0nb5srjEy2eNakH8OM8CeQmR8frTUNw8Lmp2x
 h1XZ9X79m9oZdMcKmadz76O/FSkXeygE=
X-Gm-Gg: AYBFou35SjIEp60ut/P7gz3EBBXs/Kv1N/mCa/Jv+cIxXbeEawavivLoBINByWzCZ/L
 AbVBDn7/bkjBjOXxk8LjKGrtxa7CiPlO4zO+8f4506EB93sGtNbph0USITBH5dL1qCtgHC4fzBL
 L8cN/RQh7oAShR+eH4tLSqCV39dSxpCYl7vhJ3Fk9HKTAqJF3m7eCfFtSgaNdEw/Q6hT3hBYMtf
 T11m7ppkJqAeGe/Emg0pWzUYWVDvvmIqG9QQjJm2k8WcuLb2iP9TqxudwTyiOk/E7LZxCWfTT+s
 4Z/OnzMIaURd33mXTKmhfbYo494QgX6iXisNW39YQ3qgADpvziW/xgqLR57Fzd0eDbLyoW34uTK
 3yFmWlLysj6DCFL58+Jnh7L1NKNY3IMrhQJ8hFbK301wrE8ka/tYFVGYAkidg02Ts9/lZzQKbCC
 eE
X-Received: by 2002:a17:90b:58cd:b0:3ac:9c37:9422 with SMTP id
 98e67ed59e1d1-3adea2003c9mr3866384a91.2.1792866604827; Sat, 24 Oct 2026
 11:30:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-6-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-6-2977f974ddb7@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Sat, 24 Oct 2026 14:29:52 -0400
X-Gm-Features: AclHuK_Wkxnx4x9hzjubfG-sNaa6VFJgJnA97sgJBAGJdBKAT92A62FuiwUWZSg
Message-ID: <CACu1E7EO1rYgy+KN66EqQWLxvdXVKiAhwh=EWqe2ZP6wWdhZ6w@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/msm/a6xx: Reset preemption records across suspend
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jordan Crouse <jordan@cosmicpenguin.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Luben Tuikov <ltuikov89@gmail.com>, Antonino Maniscalco <antomani103@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 6:31=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> The preemption records are initialised only once at probe time. On every
> resume, a6xx_preempt_hw_init() and a8xx_preempt_hw_init() refresh only a
> subset of the fields (rptr, wptr, rptr_addr, info, data, rbase). Whatever
> else the CP wrote into the record before the GPU was power-collapsed
> is left in place and gets consumed again by the CP on the next preemption=
,
> now carrying stale context state.
>
> To fix this, zero the whole preemption record on suspend and fully
> initialise every field in the hw_init path.
>
> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Thanks, this gets the AQE working on my glymur laptop (Slim 7x).

Tested-by: Connor Abbott <cwabbott0@gmail.com>

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  2 ++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 37 ++++++++++++++++++-------=
------
>  drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 11 ++++++---
>  4 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86d..3e4afaa5345f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2248,6 +2248,7 @@ static int a6xx_gmu_pm_suspend(struct msm_gpu *gpu)
>                 for (i =3D 0; i < gpu->nr_rings; i++)
>                         a6xx_gpu->shadow[i] =3D 0;
>
> +       a6xx_preempt_record_reset(gpu);
>         gpu->suspend_count++;
>
>         return 0;
> @@ -2287,6 +2288,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
>                 for (i =3D 0; i < gpu->nr_rings; i++)
>                         a6xx_gpu->shadow[i] =3D 0;
>
> +       a6xx_preempt_record_reset(gpu);
>         gpu->suspend_count++;
>
>         return 0;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 79912a33e17c..62a19e22e230 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -305,6 +305,7 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu);
>  void a6xx_preempt_trigger(struct msm_gpu *gpu);
>  void a6xx_preempt_irq(struct msm_gpu *gpu);
>  void a6xx_preempt_fini(struct msm_gpu *gpu);
> +void a6xx_preempt_record_reset(struct msm_gpu *gpu);
>  void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
>                 struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *qu=
eue);
>  int a6xx_preempt_submitqueue_setup(struct msm_gpu *gpu,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/=
msm/adreno/a6xx_preempt.c
> index 1e599d4ddea1..df8d4f3e8d4c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -140,12 +140,17 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
>         for (i =3D 0; i < gpu->nr_rings; i++) {
>                 struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->pree=
mpt[i];
>
> -               record_ptr->wptr =3D 0;
> -               record_ptr->rptr =3D 0;
> -               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
> +               record_ptr->magic =3D A6XX_PREEMPT_RECORD_MAGIC;
>                 record_ptr->info =3D 0;
> +               record_ptr->errno =3D 0;
>                 record_ptr->data =3D 0;
> +               record_ptr->cntl =3D MSM_GPU_RB_CNTL_DEFAULT;
> +               record_ptr->rptr =3D 0;
> +               record_ptr->wptr =3D 0;
> +               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
>                 record_ptr->rbase =3D gpu->rb[i]->iova;
> +               record_ptr->counter =3D 0;
> +               record_ptr->bv_rptr_addr =3D rbmemptr(gpu->rb[i], bv_rptr=
);
>         }
>
>         /* Write a 0 to signal that we aren't switching pagetables */
> @@ -163,6 +168,19 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
>         a6xx_gpu->cur_ring =3D gpu->rb[0];
>  }
>
> +void a6xx_preempt_record_reset(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       int i;
> +
> +       if (gpu->nr_rings =3D=3D 1)
> +               return;
> +
> +       for (i =3D 0; i < gpu->nr_rings; i++)
> +               memset(a6xx_gpu->preempt[i], 0, a6xx_gpu->preempt_bo[i]->=
size);
> +}
> +
>  void a6xx_preempt_trigger(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -302,8 +320,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_gp=
u,
>         a6xx_gpu->preempt_iova[ring->id] =3D iova;
>         a6xx_gpu->preempt[ring->id] =3D ptr;
>
> -       struct a6xx_preempt_record *record_ptr =3D ptr;
> -
>         ptr =3D msm_gem_kernel_new(gpu->dev,
>                 PREEMPT_SMMU_INFO_SIZE,
>                 MSM_BO_WC | MSM_BO_MAP_PRIV | MSM_BO_GPU_READONLY,
> @@ -329,17 +345,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_g=
pu,
>         smmu_info_ptr->asid =3D 0xdecafbad;
>         smmu_info_ptr->context_idr =3D 0;
>
> -       /* Set up the defaults on the preemption record */
> -       record_ptr->magic =3D A6XX_PREEMPT_RECORD_MAGIC;
> -       record_ptr->info =3D 0;
> -       record_ptr->data =3D 0;
> -       record_ptr->rptr =3D 0;
> -       record_ptr->wptr =3D 0;
> -       record_ptr->cntl =3D MSM_GPU_RB_CNTL_DEFAULT;
> -       record_ptr->rbase =3D ring->iova;
> -       record_ptr->counter =3D 0;
> -       record_ptr->bv_rptr_addr =3D rbmemptr(ring, bv_rptr);
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/=
msm/adreno/a8xx_preempt.c
> index 6cb53a071801..0e0503ed54a1 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> @@ -121,12 +121,17 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu)
>         for (i =3D 0; i < gpu->nr_rings; i++) {
>                 struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->pree=
mpt[i];
>
> -               record_ptr->wptr =3D 0;
> -               record_ptr->rptr =3D 0;
> -               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
> +               record_ptr->magic =3D A6XX_PREEMPT_RECORD_MAGIC;
>                 record_ptr->info =3D 0;
> +               record_ptr->errno =3D 0;
>                 record_ptr->data =3D 0;
> +               record_ptr->cntl =3D MSM_GPU_RB_CNTL_DEFAULT;
> +               record_ptr->rptr =3D 0;
> +               record_ptr->wptr =3D 0;
> +               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
>                 record_ptr->rbase =3D gpu->rb[i]->iova;
> +               record_ptr->counter =3D 0;
> +               record_ptr->bv_rptr_addr =3D rbmemptr(gpu->rb[i], bv_rptr=
);
>         }
>
>         /* Write a 0 to signal that we aren't switching pagetables */
>
> --
> 2.55.0
>
