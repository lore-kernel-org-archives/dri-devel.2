Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2224CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C29710E98D;
	Mon,  5 Oct 2026 14:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwT4N7zl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwEBLi13";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC1C10E25C
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 14:54:46 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP8iJ3141524
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 14:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=ApQSUFVI2oW1ohSRn0/36SH+054N3pE3T9i78ZQXk34=; b=Rw
 T4N7zleli/KGH+oInNyb2+VoirvJOg5zCbCk38L1ROJ8Fl66nVnmi+UkTbfqzU4P
 9qCE9ocv7QpBM+AkQJjHBtKsTShJ/Yp5ONAk7292RkWgV71cLF2L4AR6p3rf2eyd
 DKua+QumR3H+jlYmHD+y8oCtnK9K+8HT2RzTCZCh8VLBEK+N+GgtXF2qUENI1del
 WWxwCfdbx+AVQdOH488yGn2aua6NePMuCFKILlxsG+yqOg+PqoRhBPZ4XAFBsoTD
 2XS+CCi0DYi8BPT0DruTloZ8aOkkE2ma/IJquD/etbhYStCPgrZMdkq2l5YoLvlT
 fqSrMkfiqOS6M6NakaEg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49u411rd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 14:54:46 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-469debb526fso1998118fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212085; cv=none;
 d=google.com; s=arc-20260327;
 b=WVuqur6TkZP6JKYc7Mmk30Z0d6W7z97ZZWllqLl3JIaH1Dykj1OVTBNmpb+NojGJwu
 JCGWL72eddze9QjNUQVJlLvtepZpQuwkaXl51okJgtqQsMmqAIEDRv+OEm7LXcqxblzk
 9qmyS6npORukO+rXAEhmUf9DFBBWRwMQGHft9RL265TiLSEWfF3DvGs67wFDjE0U9cVA
 HI3EB6U1DMxu6y8X//3mN0Kuav929vr3xaF0OAhYjcMrT7DCZ5gYCcppCXw1fBkXI0f0
 yI1v6o2afsUnMEnDcW66NqgOhvV/J0J8+aMv3+Zv+hqw34P3cMM4hsyGWN5ATVwgXN50
 mq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ApQSUFVI2oW1ohSRn0/36SH+054N3pE3T9i78ZQXk34=;
 fh=hR+9I3PQS+blvG03sEUtGRx6YylAHWLLT5kqgXoFAo0=;
 b=b87iY+OBuZDmOcfivjJnLEUzkKBnrtAsc09MTWMNMfJFOBt/FFi/t/TRQg2FnTeSD+
 QfwTtSW8fAhBh5gtU7OvHqSA9TBcVBwdeP1weTwWt7Yl07PwT5AvSo+2uXRHIKXDXDRi
 wWABj9k+oC30proN2x2cd6EQ0UAs0bXm2XRFew0bLKHofFDMedi6Fp51H0Q5z+fMiRta
 h3zB9qbSGCn62wytLK1NkB0pPvkHXM/ZnyepmCjofqHTdsOtvEJZ7DK4J59i5tNHZwmX
 PyACv9a5AhqK1MkULhFeE/NzyYzIoinxsqCEehM6rLhf6H9Wq6jTs3RSUqd4mvD6k95+
 HxGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791212085; x=1791816885;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ApQSUFVI2oW1ohSRn0/36SH+054N3pE3T9i78ZQXk34=;
 b=FwEBLi13dyu/TWBSr3topdZ2xi5zswiEMe9whLAsS2EiZQekgeB3G20/Yv7zb/ckLR
 nvHR2K97cjg/EAeDT5q9HFfQbnOOLbTqGf7HdxuBKgQPJS4ShTTnTo1CIxLhd79lH89P
 01rDALjdxD7fz/PjmyOqzu39cXR90az0+yMpeAI3FNa+OLfNnj6VEhggaR0N3sPwHNGf
 zv4ZQdiVjBXdpQH7jDb+XueNHdl3Rc6bksLo4mGouXB5+edTBab5Uhuxz4TUCrdgVJiy
 POKuy2X3Smsv2d49rrhfyvVDpuFkjsgG1Aw05Od7UUaU3v9dOfBRzqIUc+V46tLdavaC
 mCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212085; x=1791816885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ApQSUFVI2oW1ohSRn0/36SH+054N3pE3T9i78ZQXk34=;
 b=g0Y2v0klDmDaBPbp0AVa6WyZhTHk3DjWWW3blzj2pMGPv/ycnF7h8cy4/Ttlp6ANB+
 xuSCVYElaEgT4Ymankvl9SySxM3GPAGt1Q/PV+Q0wbo9M27RyjOosO+DzPXaCYES2mBW
 m2oZRoHtmGftv2qE0ldHU+3KEES0Q6szY0W9zwkpl9Z7kJR+5qhMc9zGxv6b1tDLTAnh
 0RiUMZTRleTFv7SC2x49ly+NiUjEN34xJrzU7Zx/sf9eLmo+FpgBUyJYqK/GaTVs8x5k
 4JVEqS91sP+heA4HrFjuye2lRAHEW1JZTa8pA+dLdHT8gzhx/Dz14Q2R9lbhanlt63Uq
 2uTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyJX8CJIWGYs560z+XtVH5UUc5HxvdHVk2EnQu+7Mr120aOLjZ/z+rniCNmayjEYVf105SY5/HH4Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwKmrPc9vuIHi77/Bb5Wm/i+iLdqR8y43ZJuQ0qlYuWvv643oO
 G8TB4RhdiMx0TRTontGaPUbY+C9PC86ABRyqkh2t8JeynyUS71zc+4z1RQckn/MU5myVjRTwPcS
 +f9NxvCEwgPX8HzGDZYkH8d+Y5Jlj9N6mSbxV7UAvk1D//Nx7EipGQTobW/lM2dssWUCFUII5qZ
 IF/y+/XKI0gcianugtV6dGDuwLC/ilqHiuBR1e6El/KQkWcg==
X-Gm-Gg: AYBFou0T0OzFviB6X0Ea3+hik5DKBKYi3wPM2dV9NbtZ8z2vX1ray6d8puKe5FduxHo
 Z6PneTRXM9pD7LgZpCHmX37tqUuZiibrKfGo4P2NDwyfIjSVtIZga6S8VM892YMF222MEOJ2KV2
 xm5N0TN8BPOeS0iJfSkEqsmz1yFCJQSkZFVBn64C7tj9rhNjBjje30mVco
X-Received: by 2002:a05:6870:d892:b0:447:a816:9328 with SMTP id
 586e51a60fabf-49e3a59bd9amr5060476fac.6.1791212085065; 
 Mon, 05 Oct 2026 07:54:45 -0700 (PDT)
X-Received: by 2002:a05:6870:d892:b0:447:a816:9328 with SMTP id
 586e51a60fabf-49e3a59bd9amr5060455fac.6.1791212084569; Mon, 05 Oct 2026
 07:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
 <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
In-Reply-To: <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 07:54:32 -0700
X-Gm-Features: AclHuK9HudIjSgMqJ3EcpweDFeA8JvXrNOQ7VzbVPGFBjWu5VmzRi8Z8u8xEFGw
Message-ID: <CACSVV00sJmmRqpTJUD4AfB5-LJRCtzdWDTKVCQwH+y-uYYYMbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on handle
 close
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: XEye5Ba7xdoj06NNSldo7Uor-cUzBAXr
X-Proofpoint-GUID: XEye5Ba7xdoj06NNSldo7Uor-cUzBAXr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1OCBTYWx0ZWRfX+zLVcJyelo1i
 ENSliq0x25m1o1T7F9uFhgTfAZMmqzixhm+yLbSqQftgqCHCgT0qJjDzEaAMwqrCIzpuRu5cO5Q
 +tGkUxDed7fJGa8wXpdR/R3hNxE6GCU=
X-Authority-Analysis: v=2.4 cv=LuEHWXdc c=1 sm=1 tr=0 ts=6ac3ba36 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VfJzBMOGgdBi7dMCBGQA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1OCBTYWx0ZWRfX/mMLJ6dtD7xo
 3pBSvSQ+Jm1FKCt0mtRjjyJZho3nLgu7ReoxKmwKDC7Fi0ijjSfnfBLH+1UbLIp2pPrf3iXxJOh
 VFv3jL6S3dZ9jDTExAjlgwUnp3Z5Als8slmRA9e7cIA2ImLpS+nKupf9JRWCNvO0Bt9GRsI70Ju
 kT/dF2wZlfFUrf6EIWUkgBTZEASwKa+wolm0uHLKdcdJz9KY5nM1+WjYPEjzH+8LtPrHMEv8Z3k
 lQcAbuLtPGuR1XbLz9vffi4tFNMxghtrp8Fea02JnHapxsBOObggPL2Bnh1WXfxUN9JqUCMKjYs
 +wCEjy9Uok5q2Vjau4kMnorn3YIYxaF6jSzDPpfJ7F7oLlzLHvf9zheloTojBGwA0FXQiWgxgzI
 45fuPy4N1h+A/L+LHD+cy2yRy5h3kMoeB16ID3pCRX4krLTJVAnEBGlkd9Hi7xlSKuJ84w8EL/d
 LhT3oDzXN/jefkuPIlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050058
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

On Sat, Aug 22, 2026 at 1:49=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On targets (like A530 / MSM8996) without per-process pgtables
> msm_gpu_create_private_vm() uses the global VM, so all DRM files share
> one GPU address space.  msm_gem_close() unmaps the object from ctx->vm,
> which on those targets pulls the buffer out from under every other file
> that still has it open, and frees the iova for immediate reuse.
>
> A dma-buf imported into a second file hits this as soon as the exporter
> closes its handle: the importer's texture keeps sampling the old
> address, which the next allocation has taken over.  On a530 this is
> every ext_image_dma_buf_import sampling test, reading back all zeros.
>
> The VMA teardown a shared VM needs is the one already used for kms->vm
> -- defer it to the @vma_ref drop, when the last handle and dma_buf
> reference are gone.  That restores the pre-drm_gpuvm lifetime without
> reintroducing the reference loop, since a BO with a live vma_ref is held
> by userspace anyway.
>
> Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 13 ++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.c |  4 +++-
>  drivers/gpu/drm/msm/msm_gpu.h |  3 +++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.=
c
> index f90afffe3442..e73cf49c360e 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -63,6 +63,7 @@ static void put_iova_spaces(struct drm_gem_object *obj,=
 struct drm_gpuvm *vm,
>
>  static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *f=
ile)
>  {
> +       struct msm_drm_private *priv =3D obj->dev->dev_private;
>         struct msm_context *ctx =3D file->driver_priv;
>
>         update_ctx_mem(file, -obj->size);
> @@ -84,6 +85,10 @@ static void msm_gem_close(struct drm_gem_object *obj, =
struct drm_file *file)
>         if (msm_context_is_vmbind(ctx))
>                 return;
>
> +       /* A global VM's VMAs are torn down by the @vma_ref drop above */
> +       if (priv->gpu && ctx->vm =3D=3D priv->gpu->vm)
> +               return;
> +
>         /*
>          * TODO we might need to kick this to a queue to avoid blocking
>          * in CLOSE ioctl
> @@ -95,7 +100,7 @@ static void msm_gem_close(struct drm_gem_object *obj, =
struct drm_file *file)
>  }
>
>  /*
> - * Get/put for kms->vm VMA
> + * Get/put for VMAs in VMs shared between contexts: kms->vm, gpu->vm
>   */
>
>  void msm_gem_vma_get(struct drm_gem_object *obj)
> @@ -110,6 +115,12 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
>         if (atomic_dec_return(&to_msm_bo(obj)->vma_ref))
>                 return;
>
> +       if (priv->gpu && priv->gpu->vm_shared) {
> +               dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP,=
 false,
> +                                     MAX_SCHEDULE_TIMEOUT);
> +               put_iova_spaces(obj, priv->gpu->vm, true, "vma_put");
> +       }
> +
>         if (!priv->kms)
>                 return;
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index 0c2c35636251..31d84e2b123a 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -879,8 +879,10 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struc=
t task_struct *task,
>                         to_msm_vm(vm)->pid =3D get_pid(task_pid(task));
>         }
>
> -       if (IS_ERR_OR_NULL(vm) && kernel_managed)
> +       if (IS_ERR_OR_NULL(vm) && kernel_managed) {
>                 vm =3D drm_gpuvm_get(gpu->vm);
> +               gpu->vm_shared =3D true;
> +       }
>
>         return vm;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index d27d54bdb7a7..7722776e9129 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -223,6 +223,9 @@ struct msm_gpu {
>
>         struct drm_gpuvm *vm;
>
> +       /** @vm_shared: Has @vm been handed out as a context VM? */
> +       bool vm_shared;

nit, this seems unnecessary, just check if vm =3D=3D gpu->vm

> +
>         /* Power Control: */
>         struct regulator *gpu_reg, *gpu_cx;
>         struct clk_bulk_data *grp_clks;
>
> --
> 2.47.3
>
