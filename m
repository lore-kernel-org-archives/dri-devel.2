Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD607F3ED56
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 15:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB28F10EA11;
	Sat, 11 Apr 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1ZS4E7j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KJNh+v1O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E27410EA11
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:22:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B46Seu2624931
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=vKvdTnORaHFuK/1CL2XcGIMBxSPWOIyal4x5nux2nvw=; b=I1
 ZS4E7jy6AppONFbfFvty63VQDI4VlIKcvxz++6CxuFSOTITFqKTPW6knS4immDtk
 asWOnOIE/da4BYIJwGFgAFNw0JJWfNbw3iGhic3c7KkTGJbhY1gub5ay6CGCAG80
 HenB+z8swXy2jpKibHh4AzqpjJkpWp1g4BfNsWQxHkkSwvvNLYz9wBV1kd+6O3m1
 T2ZANyQS1aZH0LDyOQSMrTuS+6k0N5DFCugx0sAJF5tHCMNCm4QyntRPVoKeP5C6
 HsVq31BS7mP1zdBr4d5REmzifKmsLm9f8MTXqqMyoNSavdO2lDSzm2MARkMdNi1V
 YZwivvKw0fZr6abQSRJg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfeyyrxhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:22:43 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-463c632f9a3so3552489b6e.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 08:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775920963; cv=none;
 d=google.com; s=arc-20240605;
 b=GkatkIkkDV8BF0xA5tqM7CZB1ucCd1eODi6Y0sVm5fJrDGy+UQZPoDIfV76JbYitpQ
 QAq7OloTtwBAyDCGHs3ozRFN2LluLsWCMbm4sM0/nZS3LTK/aRInqNCvd8JKIQrMkFaG
 UqUP/X/hFa+0ryDyqvfBlIEH9FjExHXRThPfbplovosO1xflw1QClV9ZNsJpGuzYYopL
 Y1jt8pT34N02viG5iFOjES7FFD0qiOfoeJhhDdi0OLfrtoKqknsnmBgOl7kAj/eVu1+k
 Ctcan59gdYBNz7LmwO62JFZqFdorSLHJMtL97O2SFqw1vPA1/6X9je+zGtqYlChme8ox
 4r5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=vKvdTnORaHFuK/1CL2XcGIMBxSPWOIyal4x5nux2nvw=;
 fh=WdRWe3ezH0n6eiUxkLG1BSKo+QOyMWTBxvsFkSCoY+A=;
 b=gD1kxwQZXOa+h7tukPcoJW+czRPXJ87J8XTJgYNaAEeTgjTbrEJIQ+/Y366egHpIDA
 S6UyOCLv+t6Y9+fGZoga4foOJN/Ueaq0wROhmvtfmLeOJVz/JkcpmLwg03FMJaYTzYJ8
 x+MNPFcBXHwpVpRf9dfxQ/ZZKvc5DIzCDJ1C+NYL26GJrqNXAbKcsqiLgKOmelA/CI2q
 VV1Jzm3avfOABZGc6x+2BeGKtW5FixWueC9IyjtKs4JtZNZHdaMRJb1vOPR1J23JZsm+
 SF336QFqf5QsiQ4O9e8lAgkUR/YR1Q5JvtrgZHDJfD3/6ZHpZGRYPBL5CsEW+gGljTHZ
 1oKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775920963; x=1776525763;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vKvdTnORaHFuK/1CL2XcGIMBxSPWOIyal4x5nux2nvw=;
 b=KJNh+v1OoH6ahjb0D1Bspqad3jecGjic4ZE3R5u3skbQBKSwVI4uSblmZy5kiiYe8d
 ZgTBJ9J/xntsWy5v1R4xPxGo0VQWnoGMFi/slPi4eLY4Hx9eEq/TDlIA5P61q4Un5l5o
 gCdDkrWwsPALEVAc31IJ9SnJCQ0XaqHlTsxpHW4hniBsI1VnXOE7QMpqMethgVXJWu3T
 QmQlYTJqYRiV3L3Rd6/YsAbayIYw0+R+fqx2rkN+7/Dip9U1xCe2oOEDf0KitY+smoLN
 GB9E6tMPBF4yrjMlYmb5u6jygt8XZAE8Q7JelHPI7y30lnlDrjqq0UKVbTAsZeLXk5cR
 JC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775920963; x=1776525763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vKvdTnORaHFuK/1CL2XcGIMBxSPWOIyal4x5nux2nvw=;
 b=VKshi4VdTQIz+CapJX9B12jqHPvddTxTFLY9ImHgjI7le9o4bOM5+n4Jaid3Pfw0pZ
 PZEzPvFjSy8+n03tq7pERhW7CkueIVVGxF04K9RlQ5pwKlMgYcWnjGyhnz+uqcSviv9/
 FLJYCH97k5pBvNuwqUllaEPp/Y7gEbYRquKayxjUYtICiCGARDSI/o7hj5d3/JVMpfD+
 ANlv0NmHmp2AF1j0gxil/jKKLTxMQcBiVd3wbUPaJolKkI44wm99ypdrWMhqB6cznA0E
 E8JgyGObGhoYjXVlFsoCVKgBZymKJoxsINXWyzmcgQEeoDBACKhH9L7dFlCXq0y6rMJb
 VLHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeqU50tb4ioAxnar6IpC9BnnE4gm1J95yc5F72mw8hFEX3dpwG3H7bTTVN+v0ud60N/XXcQeQCo5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3z1m9ya2F16npeI4B1iSt1QKhPacvb/twIjiMKTdVQEkCvBAq
 uhDSx0ml3qXsZr3flRkd/PZYEqMsjORrE0VLQcgMREkJVmL+JM0uRSQ/595Ftooo8xyXpYsPGVB
 oW1e9lqQFbF+FphIu8ATOyeRSWGjtKXIqwDckcYw6hAA9yv3g1fb2GMe6eDky/mzSDvw38P6Ih6
 WxTyU1g0V33o3frRsEx+IXxzw6qd+diTvr81UJsWN8wO6/3A==
X-Gm-Gg: AeBDieus/iDVPIgFArjfxQB9bK16p79WreAPwmvpfXsm/gUw+dR7h8PSVhSb9aJHOjH
 Sij7jBo9CDsBbSyMlegiz+aTvwa3N8Ds7psJXdYK/u3aPe2Z4vvXzE1Y233fkGSZc0A4KcH8e0T
 5fCfqKm5owtYu6TOISrYU50Mu5s1cFbhABiCJBoSUi8iyKvnVkdSB//2yA2/k5MYTY9r/fuemnh
 PzCcY2hahKEXqWThzajITyIiMxL+PP/e7gjrQ==
X-Received: by 2002:a05:6808:30a8:b0:450:32f0:4887 with SMTP id
 5614622812f47-4789f9ff626mr3831296b6e.31.1775920963043; 
 Sat, 11 Apr 2026 08:22:43 -0700 (PDT)
X-Received: by 2002:a05:6808:30a8:b0:450:32f0:4887 with SMTP id
 5614622812f47-4789f9ff626mr3831289b6e.31.1775920962630; Sat, 11 Apr 2026
 08:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-adreno-fix-ubwc-v3-1-4983156f3f80@oss.qualcomm.com>
In-Reply-To: <20260411-adreno-fix-ubwc-v3-1-4983156f3f80@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 08:22:31 -0700
X-Gm-Features: AQROBzAkCg2ixkfheB1sFv6waLyf2e4IBAvktrAUcduCO6-KjO2YWa3wU7mSwEE
Message-ID: <CACSVV01cT0kQa_iY2se05MXae4nBGvfHiL4K5m8SFQBkWFi4yQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/adreno: fix userspace-triggered crash on
 a2xx-a4xx
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7K337znhZekcPKovQ_m6szFEKyPZie2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEzMyBTYWx0ZWRfX193aqwixotHr
 n9V2YX6Qzw5/IZYBfd0tcFPJK+o2gFyJK4U/IsrtG6M9qsWIRiBxtTUHF+cR7bkTO1NO4b43SJ4
 ABuQHsZFWEZ6kn6EyTrIOxsYEWeSqRVHNhQC5PdVBxspVKvK9hUWAQpJtuTSvzCR2guCr1IZ8Jg
 FYxfK4qORgh/EYD4WTcFOj+32h9QjqrWcBc/xG+Y0cm+nBtUovqhjsBuPWnDVY2IoO2E3txICZm
 IRmq2RmwRn11Bh7iW/lck26yBlMC9o+DwiBkeFl4NyxpqZkjZejisaTbsQYgg/9uUl0aN8MxWz0
 5vUxD7uVUc6pSytVNzsAmRFEhz0bhB+1Uim/bAxmvFa42ulXXWuYR9eXnqFPoFnLFs4w4EXEvOH
 e4XMJrO3FSvXJKgkEnBi208JQylIkOMUag3YYIIMWLrqHm3POUSbj6NLMSzfV/fTxphgque9MNd
 at2RUHvTsvL+yJLzIBA==
X-Authority-Analysis: v=2.4 cv=FPQrAeos c=1 sm=1 tr=0 ts=69da6743 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=dQ27rmbLVP968nd230MA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 7K337znhZekcPKovQ_m6szFEKyPZie2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110133
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

On Sat, Apr 11, 2026 at 7:59=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Before a5xx Adreno driver will not try fetching UBWC params (because
> those generations didn't support UBWC anyway), however it's still
> possible to query UBWC-related params from the userspace, triggering
> possible NULL pointer dereference. Check for UBWC config in
> adreno_get_param() and return sane defaults if there is none.
>
> Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config st=
ruct")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
> Changes in v3:
> - Switched to UERR (Rob)
> - Link to v2: https://patch.msgid.link/20260407-adreno-fix-ubwc-v2-1-7ff7=
3624635e@oss.qualcomm.com
>
> Changes in v2:
> - Changed adreno_get_param() return -ENOENT for affected params (Rob)
> - Link to v1: https://patch.msgid.link/20260407-adreno-fix-ubwc-v1-1-bb2b=
09450b87@oss.qualcomm.com
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 66f80f2d12f9..02f60b33ea1d 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -424,15 +424,21 @@ int adreno_get_param(struct msm_gpu *gpu, struct ms=
m_context *ctx,
>                 *value =3D vm->mm_range;
>                 return 0;
>         case MSM_PARAM_HIGHEST_BANK_BIT:
> +               if (!adreno_gpu->ubwc_config)
> +                       return UERR(ENOENT, drm, "no UBWC on this platfor=
m");
>                 *value =3D adreno_gpu->ubwc_config->highest_bank_bit;
>                 return 0;
>         case MSM_PARAM_RAYTRACING:
>                 *value =3D adreno_gpu->has_ray_tracing;
>                 return 0;
>         case MSM_PARAM_UBWC_SWIZZLE:
> +               if (!adreno_gpu->ubwc_config)
> +                       return UERR(ENOENT, drm, "no UBWC on this platfor=
m");
>                 *value =3D adreno_gpu->ubwc_config->ubwc_swizzle;
>                 return 0;
>         case MSM_PARAM_MACROTILE_MODE:
> +               if (!adreno_gpu->ubwc_config)
> +                       return UERR(ENOENT, drm, "no UBWC on this platfor=
m");
>                 *value =3D adreno_gpu->ubwc_config->macrotile_mode;
>                 return 0;
>         case MSM_PARAM_UCHE_TRAP_BASE:
>
> ---
> base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
> change-id: 20260407-adreno-fix-ubwc-6a2564710e21
>
> Best regards,
> --
> With best wishes
> Dmitry
>
