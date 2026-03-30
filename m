Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE21061B1F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12D610E78C;
	Mon, 30 Mar 2026 19:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+Lh1jeK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L92MKse6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828C410E78C
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:51:57 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDchm02458393
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=BYgmQX9+7HJDFRI8vACIRqbXCl+Z+u+oPt2KaFypG/k=; b=a+
 Lh1jeK+87PsB/vP6pgt94QDKcoUuSlq+S9Hg5U+BJ1Y6leK6lGVheYB8h4Skdzps
 RIhy4CZPlLo/oKcWVBGRrBrIiY/5uN80g38Gf8yi/zeQk1fGDnHUxVdJIYdyDe2z
 GE/v9hBpvlr8buExcZYKchovLnvA52E4ktOXTyCrExWsz8GR7zp13ozHsNNDaZZ2
 U6mjonr20j79t8RF4v11qwSMJeSH5qCzMaav8Df3a/bPlnV4XSer1B0XxRsmmxoW
 63k55hDJz/tVJtbW7TR8vSqTh+DL+7nWAuh06kO0Az6INkTIauRIKINv8cN78vAH
 iMPXpVkj9//wN1/MI06A==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmtt75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:51:56 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d742da766aso8393613a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774900316; cv=none;
 d=google.com; s=arc-20240605;
 b=kYay4Jrl5pEeileD82zZfIYyDYg2WitG6QK+DYDdFfSmEf6H2KJzyO+xf3i03bbwXa
 /fTsjUFQKBS4ADfSeZrA5nYHNcmr3rlLRU7qJYOs78k7NHxJbE3vpctJtuHBfqHww+zA
 aH4UPy8/evPssU3pqkPLmFgsrc3sq1RtTVZ4struRgosUtlQchbe8eGM5fKXAZD+BuoQ
 8zoPpOYwsPlOqY/RxAZNJ18arXU0Uo0UYPRHLeYOAUKwgVgPApBHnO8VmO6zKdKeGxHi
 7LL1sL2rjRT+6x0NM3XJzIW570VZGmzsHcka/Sdnn+MoRxtScdLaP2zqKIHLUvtrIE2b
 Z/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=BYgmQX9+7HJDFRI8vACIRqbXCl+Z+u+oPt2KaFypG/k=;
 fh=njni3WD16Air3OU1yntudpVjBrrLoQeqE4NfKmcaSNQ=;
 b=IitOMQYwOJ4S8nfNsaV857oJ5DAsYDI2PmdDBrRXbHLuX4G+3JP72Z3B3FVK5KYnL8
 0GGixcX091T5/etZBfCV96eTjxwvpqu28B2Yq0pui3An8TRtz/9sjZ0FzP5I5mq5o67p
 eohufFbxYjphP553TQGd1O8jXn5yn66oWCYYQhjECbK3JHHL/MoMk+yJ25R52xURLSaR
 Z3Um331x70Qjl8mxGdorEs7EesJa74qba00Nfavk2mIg0xD6sBkeQ1htofjzcWJ2j+5U
 R4bm3npCxkKMOcmOsTiVWaFqMBuWZshA0L2gayL1vdXjGdh/zuNgGHkbUCxoXfhB6K/7
 uDmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774900316; x=1775505116;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BYgmQX9+7HJDFRI8vACIRqbXCl+Z+u+oPt2KaFypG/k=;
 b=L92MKse6S6ufqdzq0XCmwY5D/7Xxz+Jw4t3oeSu1kTcK+b1+mnDwBwRMlfTFuMg53u
 KBD7rOv9NutKpnLO0zccQ8zkoy1y9cJX0uv3Ty53olZeYvTkObVew3j5Kwv0EB9WlCGq
 RJuch1IlvdbxUiZ9gX7KaeQJCglxVW9Mtzfd+bgHIBedVlQTuGNhyDQWuRaCRX7mHVI7
 CYRHHMGj+Sn7tXwVRahF1jIsNjcaAvuxFBn94G/xe6Po/N3orGxtrsIHQgwE6aTjg+Na
 wl9tB6x4BBfa6uCQoQFT5RvGr3/Y6Ohztu7D7Wht6oaapOkM9PA71+PbgOPngFkbg2KD
 +CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774900316; x=1775505116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYgmQX9+7HJDFRI8vACIRqbXCl+Z+u+oPt2KaFypG/k=;
 b=snEx1poP9ExPP4+RQY/pcz0P0K9+cwBfto0n0APMMDj4FfdEFyfNIu3hkXeCuTYWsk
 vH6RUB0VC2iOFnGeVtSPxl10yuCRY9L99mq1tic9j/Ma830JVdlcWRjdREQ0uwg/jys1
 0mQqtlY4G29hk95QzgGOO1P2vzoV9EiptKB+xN5hEYxhHhyMVxEfhLVrmd34p/2ICIbB
 /+LD7RJeztVxDNzIvwFUMGrSQKfIdsH8i7oYw+rZOw5kLh7vw8IfNOGYoj/bmCcauOFa
 Xj16XDz4/2BDptz/lmd4kISTYf5QTU9+0JiQ8CyZ7zNf6ylnstwK8jd6SHseK4ebqmIX
 h70g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwMIAq/TS3KlGBnKKwBY/nEn96RG6vlfz1GoX142Hh4fJkwHyva3M4XQfOOweL9s7lnHPWX0T+Loc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoekNMFbPme+aT8lodVVCIEflheGBoIzS/rF7XdEwns3cEoftb
 hIq+u98ZeoE+oho0nKgRHYcQTKCXCgmT0zKxWc6lmUhy6qE/xwmSAqRsvIc/S5EED2ofYz9ZGgC
 LJTDEjEewMr0zMNB2Z2+vEhSixI40BmmsZvM60jq1O41KgUVuOjUMoZu5lqrNnyTomekFznQ67b
 aiGJsDOHFWs6Nd70x4WVCP7rfKDLKaeDYtnYzKo7AAhbDEIQ==
X-Gm-Gg: ATEYQzwjH1qSjOnS4NYyXlSssz/KiSFnNQ7+7HXImxo1pwnT33zu6Sn+8aen3dHJHgt
 wP4eKa9h2EVa4V7m5WRoz8/uDBe4O0QAva39MuAFRGrTll14RVmdLqHrbLqGi7D2wfF045Qq0/S
 5p/JGwc/Bez60iN+K5VPZXH/PXrXef1aQX7d/UoY6iN5PfU85ImdQ9wHoz+/IWiFQUwqyKdyTkY
 XtjDva6SFY0G/Hdqz0hz8PQ/fsQt6CHc/J0QQ==
X-Received: by 2002:a05:6820:6285:b0:67e:3e13:3315 with SMTP id
 006d021491bc7-67e3e1337f8mr308906eaf.34.1774900315992; 
 Mon, 30 Mar 2026 12:51:55 -0700 (PDT)
X-Received: by 2002:a05:6820:6285:b0:67e:3e13:3315 with SMTP id
 006d021491bc7-67e3e1337f8mr308891eaf.34.1774900315543; Mon, 30 Mar 2026
 12:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 12:51:44 -0700
X-Gm-Features: AQROBzDzeXlufVAcHp-mfT91Ri0TTEd0QRnKKZ9AjJjqeYURY2jinS7-RfD9G6o
Message-ID: <CACSVV01RxTce4qEkt=vPb8AmPSuTLVTh5DR5gCAP2n3U3vkDqw@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] drm/msm/adreno: Coredump on GPU/GMU init failures
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2NyBTYWx0ZWRfX3psE4XCWI7Bb
 E19NNgEIDSlNspdDwH2FKpH5nusGenszgs38b5pvbG1nvSIbvDzm+A+ew2B10jvfM3ySLjZ/jzR
 I8uN6RKQr2Y6ZHl7QfiDdGiKSnPPUVSsOkyoxoMhp5Etp0eFCwWJwsjUngeBEnlQ1whKQv8rwWY
 1DiKjhGYcYb++jiOXvQX/HJhKT0xrLCkSpYS3ijC8JyjY8z/VTuUv3+I15gNhseQvAJY7CwLyiE
 IW0giORi6Vl0vgB/q/1o51nDuT9fn0rDoI1Yx484JTWdlpTjRbm4FvOSrV7dJNJhHB/TKyU+2kn
 dq8mqeivTJY8FPaVfx+Qsb4J71cSOBbGhQMGjFsYAsEgdGU5C9MDIZa94S3Yi05sZzz5QqYHoQN
 EJZMx/fZsiaA66Z8LC28oJlxCIH5ux2nPCBMP0QG+iA5obtQxqCWX3TM7vLuBrV3fnFO7U0KXtj
 e+4ptBSAU9wZOu/kbMA==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69cad45c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=fHbsih_gTjd1DzczjOkA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: vQNHj5_Ntbk2DCIQggK3jEhMDyN-A-dI
X-Proofpoint-ORIG-GUID: vQNHj5_Ntbk2DCIQggK3jEhMDyN-A-dI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300167
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Mar 26, 2026 at 5:15=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> Capture coredump on GPU or GMU errors during initialization to help in
> debugging the issues. To be consistent with the locks while calling
> msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
> msm_gpu->lock.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 1 +
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 5 ++++-
>  drivers/gpu/drm/msm/msm_gpu.c              | 5 +++--
>  drivers/gpu/drm/msm/msm_gpu.h              | 2 ++
>  5 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 1b44b9e21ad8..916c5d99c4d1 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1335,6 +1335,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>
>  disable_irq:
>         disable_irq(gmu->gmu_irq);
> +       msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>         a6xx_rpmh_stop(gmu);
>  disable_clk:
>         clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
> index 4edfe80c5be7..ca5f96e16870 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -105,6 +105,8 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *de=
v)
>          */
>         pm_runtime_enable(&pdev->dev);
>
> +       guard(mutex)(&gpu->lock);

so, I am a fan of guard(), but I realized this means we are holding
gpu->lock across the debugfs_init() (only a5xx).. which I suspect will
anger lockdep, although I don't have a good way to test that atm.

BR,
-R

> +
>         ret =3D pm_runtime_get_sync(&pdev->dev);
>         if (ret < 0) {
>                 pm_runtime_put_noidle(&pdev->dev);
> @@ -112,10 +114,9 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *d=
ev)
>                 goto err_disable_rpm;
>         }
>
> -       mutex_lock(&gpu->lock);
>         ret =3D msm_gpu_hw_init(gpu);
> -       mutex_unlock(&gpu->lock);
>         if (ret) {
> +               msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>                 DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
>                 goto err_put_rpm;
>         }
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 785e99fb5bd5..8475802fdde2 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -391,10 +391,13 @@ int adreno_get_param(struct msm_gpu *gpu, struct ms=
m_context *ctx,
>                 return 0;
>         case MSM_PARAM_TIMESTAMP:
>                 if (adreno_gpu->funcs->get_timestamp) {
> +                       mutex_lock(&gpu->lock);
>                         pm_runtime_get_sync(&gpu->pdev->dev);
> +
>                         *value =3D adreno_gpu->funcs->get_timestamp(gpu);
> -                       pm_runtime_put_autosuspend(&gpu->pdev->dev);
>
> +                       pm_runtime_put_autosuspend(&gpu->pdev->dev);
> +                       mutex_unlock(&gpu->lock);
>                         return 0;
>                 }
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index 995549d0bbbc..472db2c916f9 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -361,7 +361,7 @@ static void crashstate_get_vm_logs(struct msm_gpu_sta=
te *state, struct msm_gem_v
>         mutex_unlock(&vm->mmu_lock);
>  }
>
> -static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
> +void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
>                 struct msm_gem_submit *submit, struct msm_gpu_fault_info =
*fault_info,
>                 char *comm, char *cmd)
>  {
> @@ -886,7 +886,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_g=
em_submit *submit)
>
>         pm_runtime_get_sync(&gpu->pdev->dev);
>
> -       msm_gpu_hw_init(gpu);
> +       if (msm_gpu_hw_init(gpu))
> +               msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>
>         submit->seqno =3D submit->hw_fence->seqno;
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index 666cf499b7ec..eb5b3a7b81f9 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -747,6 +747,8 @@ static inline void msm_gpu_crashstate_put(struct msm_=
gpu *gpu)
>  }
>
>  void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gp=
u_fault_info *fault_info);
> +void msm_gpu_crashstate_capture(struct msm_gpu *gpu, struct msm_gem_subm=
it *submit,
> +               struct msm_gpu_fault_info *fault_info, char *comm, char *=
cmd);
>
>  /*
>   * Simple macro to semi-cleanly add the MAP_PRIV flag for targets that c=
an
>
> --
> 2.51.0
>
