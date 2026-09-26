Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D413C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7060F10E161;
	Sat, 26 Sep 2026 15:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fO7jfr7l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXR6m2Ij";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0C010E0E3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:47:42 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QDpBQ03379244
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=JMZ+iTCkhXTeqoblAjLsoVh6+/LG9XNCLdnREQCp/DI=; b=fO
 7jfr7lwRzdlPAXZlW3o5LbBTZrJPA0ZNCtEMuY8mBLR7J/Uz27vkKnTD8FP+KFE8
 fJQ+ZoF4ph4GuByFffW8/zuGWUILSkvS3B2RNwb+h7b/H0P2RgbU0+1WsjCyifxQ
 WOmYAPpMQYlcfv9YuASU2K7EhId7nlUTaue6lj/fRjdTO9nAOQqVMr9LCzsDHelT
 6C1rZ3/Z80FzeuKOyT3L3kqxdCnNe8wpxmcWGYibLMflEErw3DLrLNbbpTx2wCdt
 W6jbFVeBJbFExt4YS32LMLGrpITr6PQ0KaHQxqZnI3ji4rjeTqPNc3YysoCozCWF
 lPa7oOvZoAPfs3iFEmUQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6e814t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:47:41 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-46a4168b520so2066014fac.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 08:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790437660; cv=none;
 d=google.com; s=arc-20260327;
 b=WOZJwVYFu5XyKF4xIvI4/ZpU0mICOlQ5kQ4QTOp7a7ki7S0TEd47YcjI4tFrkeKaio
 9l6KPm0iCPf321FSWxQn+13t4lNPyDASeWKxkzGSa53ihhVmDJUuULO1rRVvaltLNwvP
 4O7rMvzqmBdo3q1zl6EjJhrgIvK9ym+qFVpTrhfUp1LdPULTEloART0eNNAg2W+lzJvu
 dNslnbSbRqfKF1618lb7irx+D1vOMLOFBDP6qCbyroWUYtDmENhHxg3I7BZgQvKt8Dv7
 c6n8DkGnvQYEj3ePcCU8rs0gGyOhfhYSHQNVUUSNNkMJv3L1PvaJbZL0I7VjpHUBgwam
 Qz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=JMZ+iTCkhXTeqoblAjLsoVh6+/LG9XNCLdnREQCp/DI=;
 fh=hKhCaZnU+QeQD/Q17OmWc/QsWl8p2S/8OOw0R+G3364=;
 b=hcwDCQVQSriq+eoxlhZKmdKY3a6ICc9mqWBxFfCqwEaNNVlNEiKN0oEfjuTVzNjkud
 T+isxZswqcHMS7RngDRbRZ+Ln/6Tnh0VNp+lDOOOOPLgRCDSBwLEw7lEb7rRhuiSTzEn
 /XYbd+xmaKcdRMtHg1xrgKC2lddc2vdaWouhFgXzLFCPjTdxl4FKxO7ExZpfMduibiIC
 tgpyOor2Vt4Bu8EghSr+3HYi99048vLqCIHAfKsT8rYoUPMQkfAm7TgcgemHEUuHJgY0
 3ftHDEnORiPQOYzfvv+zo8TfRuJltXdkkKibgX+qGj1rkGU8L9PM+xNABCy82EI488GO
 u9cg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790437660; x=1791042460;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JMZ+iTCkhXTeqoblAjLsoVh6+/LG9XNCLdnREQCp/DI=;
 b=dXR6m2IjcgasOUorhqGDmdZHAjg4GeUfQT1SpxPwh+BVxVC0Ha7yx6c+ejOTiMQAMS
 6BbNnMsBhaFnzvzeRq6+MubwhKiWvRijNGL0w/38A3y9Dmuwyd/afrf2rEBJklB8o+pR
 ZjLTi4GLxSjZTPD72vY5UybyCtmCuNSWIyZm6BAWVZIK2kTRL87+Rw3Xpjx5qopNdiMe
 t7OpxkYC62JaH2kTY0bMo5tT46NFPchrJZgILklwJUCG5QvFAbuAUSeqZKIV6bshsTQ0
 MCXCOYrrHQVHKCg8ZuMgJaXi6V9sR55IAyY0jUsT+RINxb441k+TKF2JsVyW26EdSaZ9
 ROwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790437660; x=1791042460;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMZ+iTCkhXTeqoblAjLsoVh6+/LG9XNCLdnREQCp/DI=;
 b=TOxclMj/5f5TxbkkSdt8EEnye40FZC0FsJciHGL1IPd1iN7b7P3sWVYsQYFmOZbweO
 LuObB0EXt1dM5s8rcBr0YmYxcvY+iNZ9VJ/q9LmeiZU/TmA5kyKdI3s8+aJ9VcB8l2Lb
 dlFi6ApI3f8HmLS4oDdFau+Auc3lpY/MrLXE++UIe4PVmY0Z4/lxm4mRLUzHhYMCZCaW
 jL4Tv9qzRAQcgYiOUIr0bAGP7b19zEfv0gYsoafeEsy6yr6/04p3htHSAepIgbOMbbVV
 QIFOU+up8xuIfwxU+yYjzRhfDebXbpZDJKi4B49beuMDUj/2nkhM6q5wf2nN/RxJpgrq
 Qsuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMoPGjJB2EoVQdSkryQd3LwqP59YLcNjchm6UZYp1D6TZ5KJyWrNMUL8Fk2fBti8VVQDh3m32961c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLJu+kTUH+IzJR1xVqv6rdnQkxN22AhwKxKmqhsF2bqC81lTZYo
 1cHcJVt+vG0UiWnbNzoCwoHWISNLWzifm/9D1P0WwxhuHfN/XKwrX6EuCxoYpPn/+bnVt9YYGDA
 LKXU5O8Bdvl9yUny9LmOTJYrh65oRzMCQDaHIrr+aLyxaC5dpAAGVN9a80C8nLADdIVRD9Q1Opq
 eTPnwA5YHdp63uVxdzzv5nHNg+1geIi5aNpbpksDMWLEL8cA==
X-Gm-Gg: AYBFou0qTF6tEfcdN1jtuLvK+unsgVUTTptOinC9NYffKAYdjoC72cczRDygYUFlJwd
 7JdYU1XndfPoygj6IFRdiPK9Ln/PSdFRB/4PXLwLTLFMiwFn8Ys+CRd+WSBlHZ6J5hSLC+8BqSj
 R8f74NiokHFOZjBBwhymKwSA/ji2/SweXlwtIHzUfZ03m3hxvubwWljwWs
X-Received: by 2002:a05:6870:f613:b0:48f:e107:3189 with SMTP id
 586e51a60fabf-491e6ce18e8mr8561222fac.41.1790437660433; 
 Sat, 26 Sep 2026 08:47:40 -0700 (PDT)
X-Received: by 2002:a05:6870:f613:b0:48f:e107:3189 with SMTP id
 586e51a60fabf-491e6ce18e8mr8561187fac.41.1790437659970; Sat, 26 Sep 2026
 08:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
 <20260912-fd-kms-fix-smmu-v3-1-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-1-a7ddc6fe2032@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 08:47:28 -0700
X-Gm-Features: AclHuK9cxghme6lV-xoFMmZbZ0mWJR0qaLuDqqfDUs6jVDEGvSERVCEWpuW5hG0
Message-ID: <CACSVV00XJ4Ad8AMr9C8hv7LjnjVXmG2JrDtJxsyqx=Gz+rZ2XA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drm/msm: serialise framebuffer pin state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: G5CyX9qiALjbL8-lhh3GrEro7E7zo8Br
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA2MiBTYWx0ZWRfX3zj0g/dVPopQ
 a9APOoQWQeKj7ByhZpcvZLcZe4AZ0g2UKs+9E4C3Q/woPqsa7KOeYNZQXvmJI6sqYQOw5Wy03pg
 jeMh8rtHm6kwPTGYB/8IkTSSdFYFoiEYOSvgV3pWRaxuK+s2htQ6Ln0H2D1dYvJ6PsW2rbIG9If
 ETnnpIPG98OD3SyxEgj0Qa3iUQS3LPDPtCpUjddXCl2YKr9E4IwyabWScUjYjy30eVZm7KbUB35
 H8X9/OXmFSBw4NRtMjR1H++0IAKT9RyIVNr6//7WU1D5eCjINEFEbKYQ9Wm7sTGZeu491b1jiTo
 XKR9ktZNs7uUAPCcRmE4AsgEUZUtw7aQ9l4twiH04eWKG0ILGLxznZU89jbQ8PaDeR0EUj/N9eV
 m9HacMaV099TROdZS+6i+6kCOU0j+zXp03R7WOZ3HGaybypqHSaXyiI2Uy8pkO1MeLX6qHyAy1F
 cvoKU00cKeJaw8ae+uA==
X-Proofpoint-ORIG-GUID: G5CyX9qiALjbL8-lhh3GrEro7E7zo8Br
X-Authority-Analysis: v=2.4 cv=aIFlOr9m c=1 sm=1 tr=0 ts=6ab7e91d cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=LMo7-oU2RdcLhoRdf2wA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA2MiBTYWx0ZWRfXzVkhwSOGOiR2
 P/UYgFmzydD4Fcjz02ADLuzsgVceFvgQsUjjYmYJsizMgYDzS9MDw9aIogsdfxmcBcL5nzSBY5G
 MGvKYMcDnNVlopoQ6ob1QOGxkEvbXeA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260062
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

On Sat, Sep 12, 2026 at 5:48=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> prepare_count, iova[] and the pins they describe are updated locklessly,
> but drm_atomic_helper_commit() prepares a new state in parallel with the
> completion of the previous one -- stall_checks() only stalls on the secon=
d
> previous commit.  Commit N+1's ->prepare_fb() thus runs while commit N is
> in ->cleanup_fb(), and for a double-buffered flip that is the same
> framebuffer:
>
>   cleanup: prepare_count 1 -> 0
>   prepare: prepare_count 0 -> 1, pins, stores iova[]
>   cleanup: memset(iova, 0)
>
> leaving the plane programmed with a NULL base address:
>
>   arm-smmu 15000000.iommu: Unhandled context fault: fsr=3D0x402,
>       iova=3D0x00000100, fsynr=3D0x3e0023, cbfrsynra=3D0x1c00, cb=3D11
>
> The opposite order is broken too since commit 8ac37c88f991 ("drm/msm:
> Refcount framebuffer pins"): a prepare which finds the count non-zero
> returns at once, assuming iova[] is populated.
>
> Both callbacks may sleep, so a mutex will do.  drm_framebuffer_init()
> adds the framebuffer to the object idr, from where userspace can reach it
> before msm_framebuffer_init() returns, so take the private state out of
> its way and initialise it first.
>
> Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_fb.c | 44 +++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index 60c108d35d2a..77415302e6d8 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -22,9 +22,12 @@ struct msm_framebuffer {
>         /* Count of # of attached planes which need dirtyfb: */
>         refcount_t dirtyfb;
>
> +       /* Protects the pin state below: */
> +       struct mutex lock;
> +
>         /* Framebuffer per-plane address, if pinned, else zero: */
>         uint64_t iova[DRM_FORMAT_MAX_PLANES];
> -       atomic_t prepare_count;
> +       unsigned int prepare_count;
>  };
>  #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, ba=
se)
>
> @@ -45,9 +48,17 @@ static int msm_framebuffer_dirtyfb(struct drm_framebuf=
fer *fb,
>                                          clips, num_clips);
>  }
>
> +static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
> +{
> +       struct msm_framebuffer *msm_fb =3D to_msm_framebuffer(fb);
> +
> +       mutex_destroy(&msm_fb->lock);
> +       drm_gem_fb_destroy(fb);
> +}
> +
>  static const struct drm_framebuffer_funcs msm_framebuffer_funcs =3D {
>         .create_handle =3D drm_gem_fb_create_handle,
> -       .destroy =3D drm_gem_fb_destroy,
> +       .destroy =3D msm_framebuffer_destroy,
>         .dirty =3D msm_framebuffer_dirtyfb,
>  };
>
> @@ -76,13 +87,15 @@ int msm_framebuffer_prepare(struct drm_framebuffer *f=
b, bool needs_dirtyfb)
>         struct msm_drm_private *priv =3D fb->dev->dev_private;
>         struct drm_gpuvm *vm =3D priv->kms->vm;
>         struct msm_framebuffer *msm_fb =3D to_msm_framebuffer(fb);
> -       int ret, i, n =3D fb->format->num_planes;
> +       int ret =3D 0, i, n =3D fb->format->num_planes;
>
>         if (needs_dirtyfb)
>                 refcount_inc(&msm_fb->dirtyfb);
>
> -       if (atomic_inc_return(&msm_fb->prepare_count) > 1)
> -               return 0;
> +       mutex_lock(&msm_fb->lock);

guard(mutex)(&msm_fb->lock) ??

here and below that would simplify the error path

BR,
-R

> +
> +       if (msm_fb->prepare_count++)
> +               goto out;
>
>         for (i =3D 0; i < n; i++) {
>                 msm_gem_vma_get(fb->obj[i]);
> @@ -90,10 +103,13 @@ int msm_framebuffer_prepare(struct drm_framebuffer *=
fb, bool needs_dirtyfb)
>                 drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
>                               fb->base.id, i, msm_fb->iova[i], ret);
>                 if (ret)
> -                       return ret;
> +                       break;
>         }
>
> -       return 0;
> +out:
> +       mutex_unlock(&msm_fb->lock);
> +
> +       return ret;
>  }
>
>  void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dir=
tyfb)
> @@ -106,8 +122,10 @@ void msm_framebuffer_cleanup(struct drm_framebuffer =
*fb, bool needed_dirtyfb)
>         if (needed_dirtyfb)
>                 refcount_dec(&msm_fb->dirtyfb);
>
> -       if (atomic_dec_return(&msm_fb->prepare_count))
> -               return;
> +       mutex_lock(&msm_fb->lock);
> +
> +       if (--msm_fb->prepare_count)
> +               goto out;
>
>         memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
>
> @@ -115,6 +133,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *=
fb, bool needed_dirtyfb)
>                 msm_gem_unpin_iova(fb->obj[i], vm);
>                 msm_gem_vma_put(fb->obj[i]);
>         }
> +
> +out:
> +       mutex_unlock(&msm_fb->lock);
>  }
>
>  uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)
> @@ -199,14 +220,15 @@ msm_framebuffer_init(struct drm_device *dev, const =
struct drm_format_info *info,
>
>         drm_helper_mode_fill_fb_struct(dev, fb, info, mode_cmd);
>
> +       refcount_set(&msm_fb->dirtyfb, 1);
> +       mutex_init(&msm_fb->lock);
> +
>         ret =3D drm_framebuffer_init(dev, fb, &msm_framebuffer_funcs);
>         if (ret) {
>                 DRM_DEV_ERROR(dev->dev, "framebuffer init failed: %d\n", =
ret);
>                 goto fail;
>         }
>
> -       refcount_set(&msm_fb->dirtyfb, 1);
> -
>         drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
>
>         return fb;
>
> --
> 2.47.3
>
