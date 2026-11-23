Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED332606A333
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hoOxe6cf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGL2Savp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4D110EF0C;
	Mon, 23 Nov 2026 15:39:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97B610EF0C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:38:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDLJTm4030561
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=gCVuzChl+qO4tFfIRRaq7R9WsSlLoWjA/ThFeM3Nkpk=; b=ho
 Oxe6cfARPCtlTyBaxNA5wTR5sD9+yw7sTOHRGuQ4gBjc5TvQ8/0cpPgW3nD4fUUk
 Jx4uyallOivIXXTB+WjarpzXqeAf5JMp4hvj9vB8lywcWB3q+4nPrSf3ACbvH7ud
 JW6D91HYQxxrX4Gue9XK/AlIkFwH+UNErv5llqB4ZKG0apW/e7tVqucz/Img1Vvb
 Zc3fQXxI3Xs19uXfW160vYEbA3hK29BNsnVKRq/utJs43vnjCmS4brXnh3vCUyvm
 /jAoRmKSuBJfJhQCyUv+dh3a9I/Ads8A/btgqP5v2X1lwWSK/EnL1wjdrGWgoxJC
 ixZEmRVFB7YQ03HuVqAQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsjak5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:38:50 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-4a72bcd6599so2625777fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:38:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448330; cv=none;
 d=google.com; s=arc-20260327;
 b=dzfIQIyea1SLPzKF4bVK/GgxOF7R6/LD6sXSsI/O2X++72eWhgSQ+x7ommuMAu7z9M
 jDDYl3mU1XNzlzmdih5KfRi2wbEega88R0JYLTIWpM6iuaYfrLdIcJspMO4p3vjQuDow
 3f1cyBxztTMGDwUVJRF+7EoTk/Pn38rQHVDBncTzxevmCFS7LFTR1Ym7yJBnAsavPk93
 4arLs5SykMW7nT1Jl+MdYzj5YNb8xRS3vQRbF43hRDElkyGRv1ZlbS63lD3R3DzNUnTt
 pS+n2vtsvVPmmiMfNykipeGPxfyX+MrftLrLN6A9CBmXFOaQ9JHakXU4z+tKIyeomcMB
 XYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=gCVuzChl+qO4tFfIRRaq7R9WsSlLoWjA/ThFeM3Nkpk=;
 fh=4oj82CmrM+k4PxRf+oMF41hJ9Fhk3IFM8xnJOHQaRt8=;
 b=namtO+8OIiBCl1IxpFhYWooMElE3yJpW+1uCUZ5AR7E4wIMmISHiyPjnlr5IUbYjhj
 tMnDAARyfrk44A54cofq1iaC0gJ5ysql57nM/GcBzF2pxn9UDpiB4G/UG2FidvjEMFC8
 E2u7Ri9PZUKCiRbjWOFUwZ0czZ+/1QTRahFHC4ZoFuwN23VzOi5b2CC+fojxHbzl80Bj
 Aiv2y7jP9/XnbhWnPqnhdrKaMGRL4qU0ZJpFM3ZsqrJ3+6yT7jvTZ4Hl982En4LFGQN0
 2JHCvqrHXP8GDZE/QjsD76PpmaM1wa8wjSi/udpFDQOMb/z2+684Aupu7Z2VsbCdQNUg
 Nxqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795448330; x=1796053130;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gCVuzChl+qO4tFfIRRaq7R9WsSlLoWjA/ThFeM3Nkpk=;
 b=RGL2Savp+B0PsT7AG0KzIbvLP2mzGl0S2zWOY/trP1sfDzyBby2vBafk78ufa8lVqm
 pcXkwGIjobQCERkZHVluFdQVIXW7twtoq2mafZ0SK/ad24zGFmruPPuqaDBB2Yro2yFs
 MUHYeUHXCGLky3J+CrAdsSMja/WstER9x8lZXmlWNdosi+jS5JbH7CRJbjNyuLcPDvg0
 Zsy6fm9JDPbu8XWGpFNCdddBIOLUjtyU/82vOLa4FDvpGdzeELX42xJLYuZiq+//s3ut
 bCHWMdWhBZI0AVCd8mxhH2SsEMiFJVmSJsmFOMB6yBV6WmtZuUx+Ynpu1FbP2j14NXAV
 KgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448330; x=1796053130;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gCVuzChl+qO4tFfIRRaq7R9WsSlLoWjA/ThFeM3Nkpk=;
 b=E07d86kJflIxiQXuVXizVyN0f5/52LZidxSsaPiaQw9m9bw4hNVmEFAT9e0sGiQoRi
 9NR3DPTu6EmQXYh7aBkZ6nFZ28LSj73qmA6+Rl9nk6G21nYFQz7FL8gBi+y+11UXwFYo
 JmaWLYAz2T+Zbv6FI3x9ag/HE+gzPmO1bt/yHPisP/BLB4oMSYLPiXWSTfs0A/hwjVc7
 DvVp4Q5AmA7/OZUMdYCj3llfuJdxlsp69w/yeHlLrROXszfqR9pFiFCbaK+26nuRbJ+m
 /XdB+a8hoRhFlLdcvAdfuZCBiPTUTvPEZwkh9zcQONq70+1Lz4q8i6De8e1rBU0lu/b9
 dm5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEKLjZThdYahBHLN1MenvQ8sJ6A0ThHXTSwC7duaMlaymgNzS6U+UIyPv1ECPmX1dq4hraq+0sJ9Hk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+IY0LRZ5j9OcX0mAYXRokf1SO7veZHQCdEO8O2BddIW2WniZyp
 l93dBqoKjEzCSlEX4y4AyNp75EghrsLRXufpdfhDihm8XNzgiuSyxu56O5V//VLusDeXAAavFcM
 XfAjnfinl7Y0S3VTyeK4ycb36a30AI3gsppGXFC02ZuL3EdRQgoiMweEevPmw6np3uLdvRw/CB/
 aGK+nZSuNbwHJE+McvAbt5Ox7crc/MyweOEeux1Oa4Vp5SGQ==
X-Gm-Gg: AZFdTZd/SpJRQlUkcWa+6UAV56ppDgzfiQ4LfTAvLDUh7QM96ssg23T461QqhhUoGy8
 lHbFaGzBNLFovqPJjEM6vAvmHCXFEtyWm6vvnDsJkg1zWRa6OpYtqr7u5jaM9C+vjvbW0fsXZ8K
 SMV3r87i3T94fF/GNi+vfwUBOLesvDTfQOTQrm3zqjFa3qV7lfEms8fg/uOO+NquT3Br9i55lvN
 kDGYVtuKTVMuCyz1TTtyQ==
X-Received: by 2002:a05:6870:160f:b0:49a:84fb:a67e with SMTP id
 586e51a60fabf-4bc81aa22e7mr11083133fac.19.1795448329786; 
 Mon, 23 Nov 2026 07:38:49 -0800 (PST)
X-Received: by 2002:a05:6870:160f:b0:49a:84fb:a67e with SMTP id
 586e51a60fabf-4bc81aa22e7mr11083108fac.19.1795448329302; Mon, 23 Nov 2026
 07:38:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
 <20261031-b4-adreno-timestamp-v2-1-0836856b228f@oss.qualcomm.com>
In-Reply-To: <20261031-b4-adreno-timestamp-v2-1-0836856b228f@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 07:38:38 -0800
X-Gm-Features: Aa3M54r2MCQoQ3PqXzI3hpH_qsmTUYcXPDHzocmgon31QcuLcq7PZJCcVO3KLFk
Message-ID: <CACSVV02JZe-i2gBS0ShiGBaH61MNYEtn8RxsM+sZe4NY7jHFzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/msm: share a page of kernel state with the GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b045e0a cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=Sjt1sVUzr0hdpTIL:21 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=uvoR58hokDgp53dTwF4A:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: q4k16cEeyG2xzOckQENVyT9FN616R_jM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfX9UHHAxTkIxux
 eE2Mu5gMf3xqfKibkYTUAO3WMOu4cYrluJNG3X51b+MQLXgwgaetTk3zoda4RKyPK2exzJoIBfx
 MUj3CBeoDQpPwYtuycbvHvyH3Er95t4dd8GzhQW7wKtGWl88i1x4rj05sDMAtZDJv0AzZ0ASfEM
 ZPXi4+G96TVTdj2nu0E1+DMKcDsdurgCdXx2li195Riciw1kr4mz48IQqWbIoiA9D37HvGnVaN9
 UT/bBNUTt85tNrUAaMQvT96LfhS0dRBVzKcB0/Ew6D1kbGrY4ysSAVyQbbRffFejPP2su3tvoBb
 OSj+9KtLRJ3DApZHAYGVFq3z5sKMwzNRq32ZrYX5+uBValTXNMxyPwjraydIO8vVWOGVNNMJNU6
 0xzT7I85mVPiiBC+Hc3vujUCA+hacAg1O0KKvy5GDlEiNuEtVl3NvKT/O9fUVymdDhgRSOGYf4b
 lWX+btBXTKypv4YNWxQ==
X-Proofpoint-GUID: q4k16cEeyG2xzOckQENVyT9FN616R_jM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfX7tTgOZEqwAsh
 jeE/hdznhLAxxzzZcufrw5V3/eBeUlWuBrMGW2LJEYEMriSVlPeyWV+z9eVvNGZ5HbMOqukDpvx
 bqgquw0zka+E6m7U1jNUqjTcdRB67ug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230062
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 9:12=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Some state the kernel keeps has to be applied to values the GPU produces
> by itself, the first case being the always-on counter that restarts
> across a GPU power collapse. A GET_PARAM can't carry it, as command
> streams need the value at the time they execute.
>
> Allocate one page in the global GPU address space, read-only to the GPU
> and not privileged, so the command streams of every context can read
> it, and report its address. Start it with a flags word so that fields
> appended later can be announced.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  3 +++
>  drivers/gpu/drm/msm/msm_gpu.c           | 15 +++++++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  5 +++++
>  include/uapi/drm/msm_drm.h              |  9 +++++++++
>  4 files changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index dadfe4c69438..0adf56fb9563 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -404,6 +404,9 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>                         return 0;
>                 }
>                 return -EINVAL;
> +       case MSM_PARAM_VDSO_IOVA:
> +               *value =3D gpu->vdso_iova;
> +               return 0;
>         case MSM_PARAM_PRIORITIES:
>                 *value =3D gpu->nr_rings * NR_SCHED_PRIORITIES;
>                 return 0;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index 0c2c35636251..747cd90e329a 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -989,6 +989,19 @@ int msm_gpu_init(struct drm_device *drm, struct plat=
form_device *pdev,
>
>         msm_gem_object_set_name(gpu->memptrs_bo, "memptrs");
>
> +       gpu->vdso =3D msm_gem_kernel_new(drm, PAGE_SIZE,
> +               MSM_BO_WC | MSM_BO_GPU_READONLY, gpu->vm, &gpu->vdso_bo,
> +               &gpu->vdso_iova);
> +
> +       if (IS_ERR(gpu->vdso)) {
> +               ret =3D PTR_ERR(gpu->vdso);
> +               gpu->vdso =3D NULL;
> +               DRM_DEV_ERROR(drm->dev, "could not allocate vdso: %d\n", =
ret);
> +               goto fail;
> +       }
> +
> +       msm_gem_object_set_name(gpu->vdso_bo, "vdso");
> +
>         if (nr_rings > ARRAY_SIZE(gpu->rb)) {
>                 DRM_DEV_INFO_ONCE(drm->dev, "Only creating %zu ringbuffer=
s\n",
>                         ARRAY_SIZE(gpu->rb));
> @@ -1033,6 +1046,7 @@ int msm_gpu_init(struct drm_device *drm, struct pla=
tform_device *pdev,
>                 gpu->rb[i] =3D NULL;
>         }
>
> +       msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
>         msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
>
>         platform_set_drvdata(pdev, NULL);
> @@ -1050,6 +1064,7 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
>                 gpu->rb[i] =3D NULL;
>         }
>
> +       msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
>         msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
>
>         if (!IS_ERR_OR_NULL(gpu->vm)) {
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index d27d54bdb7a7..f78f3bc62977 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -252,6 +252,11 @@ struct msm_gpu {
>
>         struct drm_gem_object *memptrs_bo;
>
> +       /* page of kernel state shared read-only with the GPU: */
> +       struct drm_gem_object *vdso_bo;
> +       struct drm_msm_vdso *vdso;
> +       uint64_t vdso_iova;
> +
>         struct msm_gpu_devfreq devfreq;
>
>         uint32_t suspend_count;
> diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> index 3d363f12f66a..f8bf48fdc339 100644
> --- a/include/uapi/drm/msm_drm.h
> +++ b/include/uapi/drm/msm_drm.h
> @@ -118,6 +118,7 @@ struct drm_msm_timespec {
>   */
>  #define MSM_PARAM_EN_VM_BIND 0x16  /* WO, once */
>  #define MSM_PARAM_AQE       0x17  /* RO */
> +#define MSM_PARAM_VDSO_IOVA  0x18  /* RO: GPU address of struct drm_msm_=
vdso */
>
>  /* For backwards compat.  The original support for preemption was based =
on
>   * a single ring per priority level so # of priority levels equals the #
> @@ -127,6 +128,14 @@ struct drm_msm_timespec {
>   */
>  #define MSM_PARAM_NR_RINGS   MSM_PARAM_PRIORITIES
>
> +/* A page of kernel state that the GPU can read, at MSM_PARAM_VDSO_IOVA,=
 for
> + * command streams to use.  New fields are only ever appended, and the k=
ernel
> + * sets a bit in @flags for each one that needs announcing.
> + */
> +struct drm_msm_vdso {
> +       __u64 flags;

I like the VDSO idea, but we should probably have a
MSM_PARAM_VDSO_FLAGS, or something along those lines, for easier UMD
access (ie. without having to start out by doing a SUBMIT just to read
back the flags)

BR,
-R

> +};
> +
>  struct drm_msm_param {
>         __u32 pipe;           /* in, MSM_PIPE_x */
>         __u32 param;          /* in, MSM_PARAM_x */
>
> --
> 2.47.3
>
