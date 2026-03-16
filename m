Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6697F53D9B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2091F10E2C8;
	Mon, 16 Mar 2026 20:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHAcJTnV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h45xEXOS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB5810E367
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:55:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GFMqt82314590
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J8ltMeCUJ0Nsuy3U77T/BrncqvvnFsJLNLRyPi9NiG8=; b=XHAcJTnVlXHdRzQ4
 7IaKVN/vHTyrTCr39y8CPlkBgJRQZ2egZCafDTmXuPNfAvk7lpy0lx2d0rNIlwpj
 gqrZOR0nDJLQCJ2A9kvk/7IGG/PXC4C5jakmXuyD3J/VjzvjHi2OKscokepNfXO0
 hgnkNxIb6y6U+Hpsztan4feSvLgXUcMgPXFN9Fq5rp4D6GXF4iFvKZE4x43ekrVj
 muPEQkkgjrnX/0PxDO250/BtsXqCG5ILYta0NC/J9935EoEx8j5ME7ayxGKR9mvm
 4iLQZnNSZtcIJsnGOjVrExrAO8I3yfDNrvUErQicXwRhCLYvKV/zctOKUpYSGlwX
 rgdlUg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxmf291s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:55:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aeb90532f6so59369055ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773694536; x=1774299336;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8ltMeCUJ0Nsuy3U77T/BrncqvvnFsJLNLRyPi9NiG8=;
 b=h45xEXOS2CPaWqwgQvuqIkRrDp4UqugXtkUXY+ZhPNgcuAZNAhcfrjBdqeA9rYwyUf
 9CjFcuL3O7/JReYC3JUecF/hXJjKiEfbRGigiCOC+E3FwP3JIl6PgEl+BYlwGk1PinJp
 ADA0q6Gg68U3XLuDJEsWOn1ZwBBg8avjyT9b2kPzBSJX32YGisneo7D4xnP54aE2KwB0
 wcA6M7wg5SCRI7lmnih2gsQ7xoAktUgwsmfQiaBKqG4QH0IM4OQNWpGcyLcgvvgIH2R5
 XK7DwP2sMqrdbQJJEQl4Lqk8dFWPuJNcTAy8HWDAnSDqEEsq+y2sGPlnAd+QFBa+ogvu
 PMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773694536; x=1774299336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8ltMeCUJ0Nsuy3U77T/BrncqvvnFsJLNLRyPi9NiG8=;
 b=ZPY3SMvn3KbtHhmZ0HqDcxbPfd4L5fjMHmvi1zwYPOguW8i4RMsKYbXfoqCNjaj6Qz
 dzKn3BV7h7j9/aMZTr+HAbUxkwXEzYd54ISiZvuvnJx8BbDeA9PPTn7DAxQb+l0QW3pR
 v8/v6lmuC4u16dGN+s5dnDIAsFxsRsIut0GcdvaZTQgTd2BWhOu/Lzjmu1wRczut+ktw
 g4EdDbs6SpYiya57thxHYrB/27t/ze3Vbetp7d9Yg5gIgNEvLVMTaZKjQUifJxo6CWCj
 sU66g2hjsFe5jFZjQdex/H5RHgpFxRTqgFTpCDZ/bw1imbCr61vfNbWqcR70I2g1jGdj
 6Wyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvrsq8mXKjcZ8aixyu/i5Dmte+ndNqgu/iZm73vUQdqphMYFqxqGJQ72r5eR+cN+GOKrTSK635DYU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIdXytuQdGACqB83fWd4pBwSPuliGkdfaZXtzPoI6afA0AQc5R
 /zSYZ/ObuhPe2iY5/pO7qHyK9G+681y69C2kHctFtpRiJSCVNVT29wR00ZgHd+VHXFO/i0mCaok
 m65V35lAUfzB7qSmzSP731kGelOxnmHHe4AT2TDjdnkhPB61hGprDShqC13dR5oGpje4CpnlcyD
 qkWB8=
X-Gm-Gg: ATEYQzxaFxC3s0qz4vewP9hN13KQ5kLWPOSiLkSg4NxFskalm1sq1JHYIdCnfi8Hg2p
 qTuVsu7t8xS7IROB56EFZP+2FhpTtLPxnk6MnQWzsfyaPdfe++Eyofm/jOvnKdWh0ItL78UzkaB
 Lb4uULKHh9Uy82INcER5Xm4i3QVBNNAggQgKEZl8n8WnZLcU4Tf4bmxxt8gJQqKT2HbhOuQXdcQ
 cIYD6LqSunZNsmRiUlTvFxPMm25pA43nVexpTPpZGnDho0bKUaSm8JtLgX9vCNmyGafYgA/QHqK
 unchcPGb6Ib0A9gsIJdM3r7quRuzwuplRJv6qQMoE1kSE8xmUwCUvPygs7LJ55MBgdUQAXiyk6G
 GkysuOIBvaigHf1hF/YHZ+LuVT8Fg3CGkJvG4fU6l4C+oh8rRv3A01RKwgXmj3bBom7LIdHtD1j
 JHkueK
X-Received: by 2002:a17:903:1aa7:b0:2ae:6012:3168 with SMTP id
 d9443c01a7336-2aecab1e84bmr145221275ad.32.1773694535621; 
 Mon, 16 Mar 2026 13:55:35 -0700 (PDT)
X-Received: by 2002:a17:903:1aa7:b0:2ae:6012:3168 with SMTP id
 d9443c01a7336-2aecab1e84bmr145220905ad.32.1773694535126; 
 Mon, 16 Mar 2026 13:55:35 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c27:17c8:7897:b4f6:fc6e:b55?
 ([2401:4900:1c27:17c8:7897:b4f6:fc6e:b55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee6c6sm119821975ad.48.2026.03.16.13.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 13:55:34 -0700 (PDT)
Message-ID: <9b788a02-2b43-427e-9358-483e8dcff3b3@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 02:25:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yJvC68Hjh-ZEzZPLkNWKo332CD6dB3fh
X-Proofpoint-GUID: yJvC68Hjh-ZEzZPLkNWKo332CD6dB3fh
X-Authority-Analysis: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=69b86e48 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=e0mgrY8X18LXsc_zQXUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE3MCBTYWx0ZWRfX/srWzWXpMkV3
 QlIodndDLPPTGLX2wviUgktr12nCfU54MHd7H1jIQHcXDb4S4SO8Jt8Ji+Ab9p3k+l1xh0bU+tJ
 Fg6oSIRL5fqr5GyWIPmB1uDLl0v0BKk5VeZPGugBSY8hMjeLxr0wWPXf16UwGctbS3AMB/w7mu3
 gS7kUfPPIfkI+tFYZgd6rGu69bvNnMDSefUJaDPfAHvmFOdkOlZujFBm9+LeIhMISNsunFjmfEy
 gUfona1OvQZ6A4pelpE/5C4Cfi1NAwh2RrliGz2ZfVrC/OZvJFTrzSScm4tvygxQ6dGhH8QZThU
 GJhB6/Az15CrFvRnOLWhqwDKuzG9pnhOcH3rKHnw0iO5+xlTUhLgmjImqkrbZBxH2D6uHz0V8Rt
 fx7s0BFG566bTHvsuToftYWyiEk/XsoTSLqnzQMRjVj1325s434Uv+Dcq/Y9byaKatHMXmMQuvg
 b7NYocAWgpMKikBpQPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160170
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

On 3/14/2026 9:44 AM, Alexander Koskovich wrote:
> Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
> GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
> to family >= ADRENO_6XX_GEN4.
> 
> This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
> an incorrect GMEM_BASE which results in severe rendering corruption.
> 
> Update check to also include ADRENO_6XX_GEN3 to fix A650.
> 
> Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index d5fe6f6f0dec..0ac3fba5c277 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		*value = adreno_gpu->info->gmem;
>  		return 0;
>  	case MSM_PARAM_GMEM_BASE:
> -		if (adreno_gpu->info->family >= ADRENO_6XX_GEN4)
> +		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
>  			*value = 0;
>  		else
>  			*value = 0x100000;
> 
> ---
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425
> 
> Best regards,

