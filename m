Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433CEC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 04:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DF310E43D;
	Fri, 28 Aug 2026 04:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QFjaBCOg";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6640310E43D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 04:07:47 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc1cb48db3eso50801a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 21:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787890067; cv=none;
 d=google.com; s=arc-20260327;
 b=rODArgdCLSgqMdAFBinO5+63fU0SU5kdgt+Sh0lhiR+ktIqfnzumE9Qi9oISHf77wA
 NLR+RSXj88uUjJoyCrf2FJLy0Nof8mWuUz7a8FqVIJRoAgxjM/XOItEsDWMRMFjZ/jPT
 dlR9Vb24pNRg8xxAABfvEpkIx7WO2VearL2fyMi2lWnzw+vtX+kJMvT3r3yVqX/s1+fd
 jRVWqwurY17B4dDDzYbwmqutA8f2jj+c5MIPyPdmIGcja0Gy1bfouZyWjeEZ6/Vm+XBW
 l8jTGnUBxLsjWo7C/+6PTuNJ8fbzQetFxFCfDl0BA9vNLvcOCAADLsCkNm3Vvf3Hvitv
 e5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pjyZxus3uT9pxC3JoEDD54aUS4Cv4NEWFZ73hqH+6Aw=;
 fh=+3XINMFCrMEV8YUJgSzxvv8HpfYpCZbZU11TmWROmtE=;
 b=YC4IgyQswkY+s/eqGyX8yZhS6YZMv9dZuaJicC6wyd/bac80EfjgoTRsXClQBMxJG3
 +YX6ZDixe2/U6JSbD/YJGaCN+7Awf6zbZOmyK3oGdtEXt772zuuV5Vhrfo0IAWLICeDr
 XWfy++qnMkG75/m+axYDYyfUpKcGtMqUXszhO3+plf+Y9kI7jNJPc5fHaHyhBcf/JTGU
 CyzdDqzu9KSbgGfSFxSpZzo6gPta2AstHnMpZuVeTJL5cASBCxM8WQ5zqi7Tr2+vkRu/
 RwlnxvpnJPQ3l/Z1sHeEL2DFfP2Zr2zXPHO9GUd5pZSsy6ReyUPomW5FDGHtViPqqkdM
 m/7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787890067; x=1788494867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pjyZxus3uT9pxC3JoEDD54aUS4Cv4NEWFZ73hqH+6Aw=;
 b=QFjaBCOgqB7k7CSjk4BxYOjF9ziaWczMqUaKU+lCAsTNzhY477EZfCtn+ZcQA3NSI2
 C60R7w17UBLftcDFrxCyaht9fpWOCSSpQRcC9jUorUDmG5YG0hnXMkDa/h8hVBqtgh80
 588RCT5Ec/2USSc1nWe5yzXC/EUPuej+gP5YdJ9y8nLfS4iMhEtTUshSa8hnzhT8EZkX
 b0eswgM7+x0M+f3gxVxWwxV0dVj+20xO8v00O8XDGNYdXhcEo1oyNq97A+avos40uOA3
 tbZwKX6ptr+UV34/MXGRGTE/KaQNwj23ehT69krjf9gqxH2hY9+ma7p+7YUACq3SO7hV
 ZiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787890067; x=1788494867;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjyZxus3uT9pxC3JoEDD54aUS4Cv4NEWFZ73hqH+6Aw=;
 b=gztzbCRePNoXYh3TDNN75KdqVU+OwVyxzWQMZbYAMvaD5HNh/YeVe8Z4Htuv6zLkig
 O/zMYQxyZnUWGgOQ2UU17azxLmS1YS/HYzy2Q1UKWQeOwDDqqtHlmg+oyD/rlB5NZBeU
 IcAISlOmZ3D/nmbbDu48m9n/d+BVrKzNClclsUQJZFniyuaItCs+jReAm+hEsUevQRfp
 7rOR5bbjDiakuqkNmClmPmGvY/sO8L4ljDwsj+iFDa+EArsXnPqfZH6UoXiLgf9IUpAB
 n0uKIjoylWdGdLYh9DZ8+0q2rHnGKKsIa3em0+K+3QbfFltKwkwXsjOCt46CbXeoIMWg
 HtSg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0Tfn35kbzRum1/6fIROvFmEoN32Beg8mZko+bAApf4xKIS5eimatFAJqXZarcpt291EHPc8cigrw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lXAD/202jCfmnhWqndwELRHv48115Q3JufRml0YThZS64/M5bj
 SicO94Tyo5OW3D045YUjTa0/o+bqp21OGJCo1pttsiRHeHZNTGCoUCjaVpcSPDRYGBT9+KNM6jt
 rpfQanXTIeqxERB/FYdvYmjWrAVWNkjw=
X-Gm-Gg: AR+sD12n/QoXp5e223IHnrwpdiJIbgK1TBzj/tqKzEATVAMzHYoJ8QCVoWU697Hi7hp
 Hf424ZaqWJaUpHemODEVxfsL5nxtVJ4A2LmjyrPlrXzpC8K+6kjNUbtnB1eaD5WhBdrl1UZ5EjA
 MRO+R3+PoRrOFz7LVhQIByc7/6AFEFM2KN+RMZjdRQieifRstVaMewbLF9kUBLho/uhyGVcy66R
 POWd5q4K4pOHEyr2fxO/jiZlzzODl+aruR18fx/S3h8M7ipcvhwcK55UA7gj7UukMJVO8Au86Ju
 IDmzI/1dBCv4Vo7BGtqXTLZV264e/0m5hFBY5qbVAhyFh0OtZXRl1lsQa2wWPRyRqoMRwPmVE+A
 FdjuYVlG4F18=
X-Received: by 2002:a05:6a20:2444:b0:3c3:94bb:ceb8 with SMTP id
 adf61e73a8af0-3d267429a52mr3685786637.1.1787890066689; Thu, 27 Aug 2026
 21:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
In-Reply-To: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Fri, 28 Aug 2026 00:07:35 -0400
X-Gm-Features: AcwNN1XwharkwlC7cSncUV7uNpjfVtyCFXp0PJJugzLcPCDR30LNsSXNbwLuIPg
Message-ID: <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
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

On Thu, Aug 27, 2026 at 7:13=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> zero whenever the GPU is powered up again and the timestamp reported to
> userspace jumps backwards. On an a702 six reads three seconds apart all
> land in the 500..1200 tick range, stepping backwards twice, and on an
> a530 the OpenCL device timer conformance test fails because
> clGetDeviceAndHostTimer() returns an end time below the start time.
>
> Save the counter in the suspend path of the affected generations, while
> the GPU is still powered, and add the accumulated ticks to the value
> reported to userspace.

This is useless because the entire point of clGetDeviceAndHostTimer()
(and the similar thing in Vulkan) is to match what the GPU itself
returns, and now you've broken that by adding an offset.

Connor

>
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from zer=
o
> whenever the GPU is powered up again and the timestamp userspace reads
> jumps backwards.  Accumulate what the counter reached before each suspend
> and add it to what is reported afterwards.
>
> Measured on an a530 and an a702; the GMU parts keep their own counter ali=
ve
> and are left alone.
> ---
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c   |  2 ++
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  2 ++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++++++-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +++
>  5 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a4xx_gpu.c
> index 6392126f48f2..7d9dd9460f5b 100644
> --- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> @@ -593,6 +593,8 @@ static int a4xx_pm_suspend(struct msm_gpu *gpu) {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>         int ret;
>
> +       adreno_save_timestamp(gpu);
> +
>         ret =3D msm_gpu_pm_suspend(gpu);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index f1df2514c613..c5552f1085e0 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1423,6 +1423,8 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
>                 gpu_write(gpu, REG_A5XX_RBBM_BLOCK_SW_RESET_CMD, 0x000000=
00);
>         }
>
> +       adreno_save_timestamp(gpu);
> +
>         ret =3D msm_gpu_pm_suspend(gpu);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index f9de9329dee3..106cc2ac55ff 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2252,6 +2252,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
>
>         trace_msm_gpu_suspend(0);
>
> +       /* only the GMU-less parts come here, and their counter is in the=
 GPU */
> +       adreno_save_timestamp(gpu);
> +
>         a6xx_llc_deactivate(a6xx_gpu);
>
>         msm_devfreq_suspend(gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 3370cd44382f..f83960b31901 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -226,6 +226,13 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
>         return vm;
>  }
>
> +void adreno_save_timestamp(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +
> +       adreno_gpu->timestamp_offset +=3D adreno_gpu->funcs->get_timestam=
p(gpu);
> +}
> +
>  u64 adreno_private_vm_size(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -398,7 +405,8 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>         case MSM_PARAM_TIMESTAMP:
>                 if (adreno_gpu->funcs->get_timestamp) {
>                         pm_runtime_get_sync(&gpu->pdev->dev);
> -                       *value =3D adreno_gpu->funcs->get_timestamp(gpu);
> +                       *value =3D adreno_gpu->timestamp_offset +
> +                                adreno_gpu->funcs->get_timestamp(gpu);
>                         pm_runtime_put_autosuspend(&gpu->pdev->dev);
>
>                         return 0;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 114a40f79ef3..db080a6d515c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -207,6 +207,8 @@ struct adreno_gpu {
>         uint16_t speedbin;
>         const struct adreno_gpu_funcs *funcs;
>
> +       u64 timestamp_offset;
> +
>         struct completion fault_coredump_done;
>
>         /* interesting register offsets to dump: */
> @@ -610,6 +612,7 @@ static inline int adreno_is_a840(struct adreno_gpu *g=
pu)
>  /* Put vm_start above 32b to catch issues with not setting xyz_BASE_HI *=
/
>  #define ADRENO_VM_START 0x100000000ULL
>  u64 adreno_private_vm_size(struct msm_gpu *gpu);
> +void adreno_save_timestamp(struct msm_gpu *gpu);
>  int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>                      uint32_t param, uint64_t *value, uint32_t *len);
>  int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
>
> ---
> base-commit: 140b13475302601368c0cf4e193e66126a49feb3
> change-id: 20260828-b4-adreno-timestamp-f4c846391b97
>
> Best regards,
> --
> With best wishes
> Dmitry
>
