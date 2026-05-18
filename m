Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D4DCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BF510E5CB;
	Mon, 18 May 2026 08:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="an5bPjxh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixWhVKGG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3824610E5CB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:04:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I7e4GG2892697
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZewacJ3i9lKnkmzTTca31dtk4aGbjL3egDzG8Fs6hJM=; b=an5bPjxh9W9uZAis
 qJ7AWW2Gyc+6/v8OPAslx0aP+c783pPpC52iegEeBmd4xOTu+E/f5VO8qjW/SND9
 lCEKKRKK31oKDifc5fvYKN261vn12J1UVi9YP3t1AVd97jCAg6R7mFqyUrJBENin
 TAHUD1teG9wd08hC5BrUVd3bFWmmhhnWadk5s2YWxY99X17FPC5mfbky7AGWdLmz
 JeLqNOJw4v1tl1p+cpRf0QpAXqy51E6IBjwZ6w9R0T1K2/Qtr/Spj5TBLyghoEGj
 ykbySr798kLVC4mwS5fSsqMGMvzHNEfk8HF6NrTRv1Uc8RxKvvSsV3UEfOgX+4n4
 +YsG3Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk183t9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:04:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50f1b94ac9dso10581151cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779091496; x=1779696296;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZewacJ3i9lKnkmzTTca31dtk4aGbjL3egDzG8Fs6hJM=;
 b=ixWhVKGGrg0drpoTN4TX2lbGXtwy34W1MscP/DYo6rIE4jvUpXJWv67tGlTMN7tXyD
 KIGKAexm+6W5rF3fdrD8s7NZY/09UWUpqu9sR0sQph0PTY/o9BTjzqzlbxpkeTjJcaYA
 0sFOOMiHgBlrMxHL5OYkkrMvppiHwD0r1Sv+At6z3zpcwKrQqh22QLHmsFC/9rFLscsQ
 y6QjY5EVzZeKjBgtp8sw5m4PfEOgFIN6j6pJoq9D4FEH6JbodeVKQQC6+EW5ZC/0eAqy
 GtEG1HOyVgvY6KS9XiTK11ZsWGv784WQPOMlpo8Op/ksJmhUZMNlbmFje33fNB93LrNt
 TuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091496; x=1779696296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZewacJ3i9lKnkmzTTca31dtk4aGbjL3egDzG8Fs6hJM=;
 b=m5sMMOqh9nCeqM8WNSRoHSDNNE36VHxnrv/8QhKcLWM6uAY8Ft7B0wGxly6D+TRWxY
 RqaWA2bd83sjEG/C8uFkgazvj1x7jggCSPJIER40E4TzZiLZfPm1Qte1gCpyFXcPGrwy
 CZVbsvdhB3INbcJ50n9W6gNtZe3Loiif+wXxh/ykhUsrMSrK3WDfqzfTktyYmcsyQgkx
 qF242X/D9R7WG1NI+h1BhKyk9KYGW0FTGdahOZ0L0j4l85xLmU2l5E8clrRcqS2l2dst
 6wkhOlb/QHvVhu4lZ+j7nHvb5r3tMQw8TkK+HImjzCj1/PeQqGVnbLu+Xl6KzXjkHXp9
 Jvyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VslW3CxDCgJijet6eU34BThgKGMdqhbsQ+uJUO3jd0xp74RCyVk5lgv6cflCYvfZ9jOkEtUByKFw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJMJlAzzKNkWWb5ZQvOLb0zztuc0TkJtHlR8jD9ol8yCn9k5Xt
 KLFuWLk7l65j9ZkaIawSoqCMSGd/Y249zN3xII4RPci6jNro/XAi3H/weN/9iLS2yWYdzd7VohX
 U8qplQlHHQm0RtsewAo0TCdmiKQOIxHV8qLKqbiR41wkli6y2niqDl9mDVhAx0PlhYJJCwbM=
X-Gm-Gg: Acq92OGscxMNyPGLDOH5GIaMp/nEjLegFw1+RcJLlECXISOmFbrEUaRehJs13owhmi+
 gawfemaIBPOSyPXNszDtz6wSF8qqYyYBPb4/EY3Nl6MVGxZ+1MVJFLnBapEekGUjtutksQrUUB1
 oRQQsqhU4bYuhive3WJNZ02YUbBYA3pByz4WK5nAyyBVeDAi0w0BKxdQA+6IHBaGuTWE2cSVoN5
 DcOEB7FtTMFS4cIaNYPoej1gT+VtVtQ3NDy2Gj/qBqZXR4unN6F2Y9SHPsfVZfyB8n4DMNcc2kP
 TEX+wPrX92ZYeCFC/gFr4qQEL7111tXs9/Yj3JCFgVAp7rIx0fMj2Z1hsTYwtslgt/R9SFMwJAD
 SMe8D+fV9eg9IrMJ1uSN3n9xx2GXYf9EU6BCcmWtI3kfIrRotsuww0chQ/cZKtR43ZcFM55UEzZ
 3Kf6wqCkZbU9wC1A==
X-Received: by 2002:a05:622a:11ce:b0:513:43ce:eaa3 with SMTP id
 d75a77b69052e-5165a202f87mr142817351cf.6.1779091495638; 
 Mon, 18 May 2026 01:04:55 -0700 (PDT)
X-Received: by 2002:a05:622a:11ce:b0:513:43ce:eaa3 with SMTP id
 d75a77b69052e-5165a202f87mr142817141cf.6.1779091495183; 
 Mon, 18 May 2026 01:04:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd2f67sm531577166b.7.2026.05.18.01.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:04:54 -0700 (PDT)
Message-ID: <bd5fd048-7336-4609-ac78-abc6c2caeae8@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/msm/a6xx: Add HFI support for CLX feature
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-1-62508bf651ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260516-a8xx-clx-support-v1-1-62508bf651ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Z4E0uedTVUnUvxngbCr4H6VWsnjDpCdV
X-Proofpoint-ORIG-GUID: Z4E0uedTVUnUvxngbCr4H6VWsnjDpCdV
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0ac828 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ktFr412pgo1MGF5CTeQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NSBTYWx0ZWRfX3OZvexzq3GWF
 1PeZb7QD4DVuYQffvhqN7lp80NNOdRlF6/S2H5WzwphKeJ9IIkdGZTkieZlh/FwvtmQ7QhDO+iM
 vbGTCPIwbPV8PzsPVjS+yuUXsaerJRqu5w6wtLNXGfzWtsmFUNSgddSIGP/n7rxairZPNzXdNGk
 X8Fqefolptvfy9qDokAeYxe9m7G+ykosaUWNukZ4/7TeAi6pm9Gmw9xU4bvjyVnY+UFDQ2A17Q4
 tSmSVlzcTXGjuRPjjjMJkMvHyMW4DtX0oWMwoL6eBQ/u7EHSKwn7V5sJcPBDdAHnh7cget8L65J
 7up+3RimPfmgci4THc1bj1gC4n0yFUEXUxJCS0fSfBGZihV7fHt5ocgy/KXEaW++rsfX/5SWOkP
 0AKucp2deN2YpDmM+ZH9yFgDZtYqS5ZYO3OEvA0qpEPWG/xPuIaFoCcKg6tYq12qQjJH1CBVWBr
 chQFVPySciEkO5oNU/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180075
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

On 5/15/26 10:07 PM, Akhil P Oommen wrote:
> Add support for Current Limit Extension (CLX) feature found on a few A8x
> GPUs. This feature is required to limit the peak current consumption to
> avoid HW spec violation on GX/MX rails.
> 
> Add the necessary HFI interface support to pass the recommended CLX and
> IFF/PCLX limits tables to the GMU. Per-GPU configuration is consumed
> from the catalog entries.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +static int a6xx_hfi_enable_clx(struct a6xx_gmu *gmu)
> +{
> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
> +	struct a6xx_hfi_clx_table_v2_cmd cmd = { 0 };
> +	int ret;
> +
> +	if (!info->clx_tbl)
> +		return 0;
> +
> +	ret = a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_CLX, 1, 0);
> +	if (ret) {
> +		DRM_DEV_ERROR(gmu->dev, "Unable to enable CLX (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	memcpy(&cmd, info->clx_tbl, sizeof(cmd));

You're not adjusting anything (unlike the other function), so you can just pass
info->clx_tbl below

> +
> +	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_CLX_TBL, &cmd, sizeof(cmd), NULL, 0);
> +	if (ret) {
> +		DRM_DEV_ERROR(gmu->dev, "Unable to send CLX table (%d)\n", ret);
> +		return ret;
> +	}

Konrad
