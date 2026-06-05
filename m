Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94E6CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 06:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328BB11A49E;
	Fri,  5 Jun 2026 06:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJlyd7wu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VyggRFKF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1ED11A49E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 06:50:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65525pro821588
 for <dri-devel@lists.freedesktop.org>; Fri, 5 Jun 2026 06:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=C0PixtaCHTZbkLE7GHSnrZq7GqB2sS+e9Mz/CFsulb8=; b=GJ
 lyd7wuuvendePSqfJ0ULgItlMswN4Mc3/8yNiOEYRbuEKd4g4BJ1RYhelcxJPKHp
 rhlM46BjIODHFFQjsRj/RMNjV2rbeUV0Ogy2onUM13e1ebyngeA2qdASa07Srnf4
 +escoGxtoTySytgs0DR6JuydDOSrMbe99E+uoyN4le1wYD8+NLkEE0ucxU+TXhdp
 e/jjF/YlzYVqwpoI4wR3SxEApLJhKquecc2r3guFKJLPFad76g16WMTsTxmEKaVg
 rOzXDXtFax2TFQqZYl2HNc+1zFt0TysGOn2HP0BOCsk7boGdz0nfWtHLL9ad+LRL
 1rGk0Pu5TVhWgXd1N2jA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekncbgwg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 06:50:57 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-44124c420cfso1579992fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 23:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780642256; cv=none;
 d=google.com; s=arc-20240605;
 b=VCw+XpdPyKCFfT9SvjCj62sWgl4y/Abr44uLwBSPTbsOsigEl2nKvdW3hYsxsj2KE5
 TxlMerElFpeGeCTNUi1D7jEHSoOR0avp75P19QTBcfjAxnp70ILGw+PuDS6YwieaVsJe
 w187jXKM2I9zzdA5+dhusmgLXh7PUpxrbMKOXj84yFhHg0Miu7EvByoiZUvIjh5vzihb
 I21QWO9+cEkd7A0sueLTejtOW6CglN5Ur8wg3snu7gcWgMfG3XeeoMx+/AMQaK7bUCOI
 yGYALA+z1h293eG7sHPDurgcrHNxdC1nweL4Honrt/XKMGHQOz3wLpLHwRj0dYA8SFgg
 lKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=C0PixtaCHTZbkLE7GHSnrZq7GqB2sS+e9Mz/CFsulb8=;
 fh=YITOv/tNhiS12FjQ4ES/i8Dkcskv2qjJivA75FYSsjQ=;
 b=g7wVefDdhTPhAXGy4Rfl0JgxBN8qVDUvXWqZKnzSZ2Jx5nPuwumXZPTIjj3dFV2old
 344xb/oZJ4c7KIzs271DZN3kRduSa4SorMEJOujvN/ARKEs1X3vLOTCSqKKlrEYgdIAm
 440XY072mE8V/LV7Kuc3f0m+ua5E3ShuA9SpqZWeMUWcF1szJZe5dpGusgOkdluDWvXp
 RTIz37wLoee1gAOIZFSMlMP0tM3IkvnqQPDvr8N+FdDyv2t9Iih7m+OqFTqyf4eVkN7y
 tMsJ33/UBAlxXXTQhYGNAXOJArrreiOUH1qEB5fDf6XmleRrDEkCmRIvnPkPzJzcs37+
 N/hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780642256; x=1781247056;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C0PixtaCHTZbkLE7GHSnrZq7GqB2sS+e9Mz/CFsulb8=;
 b=VyggRFKFvcfBovJLRNKBLU89Gz8D0qCawsGEyrYeyrGytkFQXWzDD8XSfCnHw5JJxU
 kZAQotOn7TzS/6p0T6b8mL2uGYpaeDK/w3eHbrEs5sHQ45DyY86jRE6U/AShZTYur0Cs
 AqoqK4MDVp+LWEzz16VTf7J8R2tiMbDLmzGhp1wIdUC4biQDgnIHzA/pTNpTfaP/rtKz
 NvltTRQNeyVsf1GyMaeOs2ruLBNHsqF5+oNSrxRac/jsCtQh5zTLq6wo9eIvDk6Y75Ti
 R/WBG11xMdYD+VwC1BieFCmOp9CuUs1UxJ7rfWC6F1QYJ6dlnIKr5XShfeHVi5pjGJVL
 l0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780642256; x=1781247056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0PixtaCHTZbkLE7GHSnrZq7GqB2sS+e9Mz/CFsulb8=;
 b=bGI2FpmVKfYeLZTQESfAEKUY3KRrmGTisYghVe3I7relIMx5kPr4W2PkoBhqJ37EUi
 2PfRMXh2sDh4yqTuLlgVd1TSYp+0oERIbXtQyygzB5C/BFJjcRu1LI7NRqH6cJ3SmqDQ
 g0SLykFgfMe9vWFLV1wVwI54e7xtK3DV7Js0/OMdELDoJrLyu6hzIBhUhNwCQlq1zoma
 fzhf1JHyl1g0lb47Ex0RRtHd5bBRVuRCdeVgIN9W8IUYV46UjKIIryggZvMupLv1aBsf
 o2eKaiWfzfqtbeWx8PnNXxB1C3/hyC1qsOcOQaf5abGrPXitixFX0mFc1+xAtIMqhZZf
 GH6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0d34lxHmSIh47dq1DXlZDIs2V3OJpgLoicYROJj3hXB0+4jxMpYh1GkCBuHkM4R6Rnjdina6NpHk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzX0iD2qzL7WROAWug9pMWau6buJmpnMIyidZBHK6bh/kHXohUT
 Ki/97Nu2p36IAjGxef7XykS/KPiTbGfdElYCE1l3Qc+fNEepVaWNoxl++ls8hL902sUizxAAxGs
 /r6YSF4kjU+/3IiMRkgOkM42VHwgT1y2KjPffcvKfdf0cZgDrd35Iz2BEKV3GGXRXGYU93sJ5Vh
 wJgbKaT2iIya9W8PYriezxIwWQFmuwasRFeywt8A9u0dIYWg==
X-Gm-Gg: Acq92OHTv1ZL3+lwwIOSdqFvRnp28VyP6yODmITwR0B0shZv0oQTjyheJXumSalJJb1
 kwOz6qcre2GL1Q7oAYteQDS+k3KiSlr+TDNAhewCP9WXVP6NZx/JcriajNcNl+xym/4FRmWlc6N
 T7lw+6CAAIL5pIthmryQDmwMgqWE5olib6hEcCW1y/xlp88vZhKvwaK4uW4V0hWzXghAsh96MSn
 cGShB/iv/+w7SE=
X-Received: by 2002:a05:6870:390a:b0:43d:2ec2:ff3b with SMTP id
 586e51a60fabf-4413dbe55dcmr1123243fac.30.1780642256503; 
 Thu, 04 Jun 2026 23:50:56 -0700 (PDT)
X-Received: by 2002:a05:6870:390a:b0:43d:2ec2:ff3b with SMTP id
 586e51a60fabf-4413dbe55dcmr1123231fac.30.1780642256113; Thu, 04 Jun 2026
 23:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 23:50:44 -0700
X-Gm-Features: AVHnY4KWQZlB0Wu2YJuzc7z66ane5XslCOJNlcmVyKrJRKSGHNTDKEy_LRM8m2M
Message-ID: <CACSVV01dbQcjE+nTic+9R4VfCtNGvpwODH8BMZi8B7LFtcCCfQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/msm/a6xx: Fix IRQ storm during msm_recovery test
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a2271d1 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=q3ToO-qe0QkLoiTUhZUA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2MiBTYWx0ZWRfX8ZZqYaCDEdVb
 t9o64jngI2MPkDG9dSUCGxPNNuWq4uTQnECe037VUBlDfkjV9dJ+IYyu6g34tO+SvX40JPxwoVN
 BrPRhK1VLigSYBGpVxGysAbvonjs3fzVoc0B6iy7fbUJ3Jk3QycEy/Eb9JA03a/GLjCmW5Bfcxq
 Yjny58o1UNrfwYvMDP09Sdu6faitt0ZKIYKJ8EEnAueYqMQPd0cHDGjRy4e8zu0J2pg9FnfSj2/
 iPpDkj3OZ0YmKrF/MIWNoFQc6Mbn4cZ0zVEq/qpINDYpgSrWKKIBSr7e+UjJ8HaisbjRJ360A0+
 3JKRyfP0WmENaWreepSMDLo/3Qpp+to5UGcb+TVuGKSt7b/LnK8ByE5l64j4pf3/Cw8xuCy5v1L
 TR+g2lALjQ2VOuvt0khGsD9ixkwTtbMs40Uc+goGQ1xZ5gmhGdpi04/p6fAGxz79puGOyehBr6F
 yemHlyS5KrPOQZgueIA==
X-Proofpoint-GUID: P2DChZNB1AE-oeryblK8OYokFMQO4Y2g
X-Proofpoint-ORIG-GUID: P2DChZNB1AE-oeryblK8OYokFMQO4Y2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050062
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

On Thu, Jun 4, 2026 at 1:10=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
>
> Once a hang is triggered by the msm_recovery test, the gpu error irq
> remains asserted and triggers an interrupt storm. In the worst case,
> this IRQ storm lands on the CPU core where the hangcheck timer is
> scheduled, blocking it from running. This eventually leads to CPU
> watchdog timeouts.
>
> To fix this, mask the gpu error irqs during msm_recovery test and
> enable them back during the recovery.
>
> Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handling")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
>  drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index 2c0bbac43c52..f1df2514c613 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu)
>                 status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
>
>         if (priv->disable_err_irq) {
> +               /* Turn off interrupts to avoid interrupt storm */
> +               gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
> +                              A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
> +                              A5XX_RBBM_INT_0_MASK_CP_SW);
> +
>                 status &=3D A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>                           A5XX_RBBM_INT_0_MASK_CP_SW;
>         }
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 8b3bb2fd433b..9a4f9d0e1780 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>
>         gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
>
> -       if (priv->disable_err_irq)
> +       if (priv->disable_err_irq) {
> +               /* Turn off interrupts to avoid interrupt storm */
> +               gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_=
MASK_CP_CACHE_FLUSH_TS);
>                 status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> +       }
>
>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>                 a6xx_fault_detect_irq(gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a8xx_gpu.c
> index 9e44fd1ae634..0f6fd35bd587 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
>
>         gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
>
> -       if (priv->disable_err_irq)
> +       if (priv->disable_err_irq) {
> +               /* Turn off interrupts to avoid interrupt storm */
> +               gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_=
MASK_CP_CACHE_FLUSH_TS);
>                 status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> +       }
>
>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>                 a8xx_fault_detect_irq(gpu);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index 9ac7740a87f0..48ac51f4119b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *work)
>                 msm_update_fence(ring->fctx, fence);
>         }
>
> +       priv->disable_err_irq =3D false;

Ok, so we rely on recovery to re-enable the error irqs..  that is
probably ok, given the intended purpose of the debugfs file.  And,
well, it is debugfs.  But why do we clear disable_err_irq here?

BR,
-R

> +
>         gpu->funcs->recover(gpu);
>
>         /* retire completed submits, plus the one that hung: */
>
> --
> 2.51.0
>
