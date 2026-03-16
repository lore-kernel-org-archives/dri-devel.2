Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D25F53D96
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21F710E245;
	Mon, 16 Mar 2026 20:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqCS0vSF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PWLY9hgH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C8710E2C8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:54:53 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GFMpEQ2314565
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIPRW9ojG6PosnLQMZvCH1qVnkK0dNhAcHrugDb3mb4=; b=iqCS0vSFgvA95inI
 FDkdY8rpRTOm38K0Q/aNEVo+HRhDTGcu0lBX6P0GmFNN/Fc4pPRjuY5MgiWsacq6
 eEXzcu+ATLUp7LnrxwtT7yxq66Ew7SvFGjfQbZEi0qzbY9+NcKHx/NNWGFQJPj0B
 w6mVFRiGQlF5wswRcztc/U3dIw68FaBu7aIqHYfW20Vws3ld3as6+XUxp/8vVenW
 qIj9UG4fMUpR5cd+4T7qojAenMbQN9R9XC+7dpGdk6/dRoKI982H+kMci8W020ao
 hTdfZGkD/HmjpMK/tOJsCw+t7LpqwCcfcdU0PRZ6DPpyPmRBj9fM9tAcnkLSfIT+
 66JaKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxmf291qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 20:54:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b060c14ccbso41319335ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773694492; x=1774299292;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIPRW9ojG6PosnLQMZvCH1qVnkK0dNhAcHrugDb3mb4=;
 b=PWLY9hgHnfIQzWEA0o/U4R66IQun8mxLYD1iSAfJ0/rLxyvaPmGmUDFJB0kfL/qG8l
 hi/WPAd0gzu+a/VsckPMBIdxk7pRbM1dwZt05bOBlM2gvFMQ2rX/5DnE+l3SXlhvm4wY
 90/rB/qdS6HYbj5fc5lyjeaAD1KlA/ZKMeU92GUQBN57lp2XAmlntnH92JHMDkwCElKf
 JLG7gfmZ3lLNxuouoZmwwim7hJgH4cS1WCofJXCymXqHfoqUoLh1MWvP0JdV1BpWVA4H
 t9K0GWXOFNKSuc/tl4vBvQmJDykmumOZZpTGA+N+oayD5pPxSUUv3xdKvajp9/3BP+2/
 8Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773694492; x=1774299292;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fIPRW9ojG6PosnLQMZvCH1qVnkK0dNhAcHrugDb3mb4=;
 b=e1ZYt2KmD1WDZ5BS+iRMZgXyHJHup5S40kxNnhD6jnHi+JBkkF2KU/oWKHQ0EWZ9Uk
 KvaDH5YcIPOJSghxI/h4uSWMblb/ZHm7HPYxs6nyVgWtbgkqly3ag1vgKTLeYmXYKs/R
 ER6Q27ggWjYZNE2WvdjNt1NHcFzl4HsbPUNZXANaMQNVQIMgTxW/dSXFmj2N6XRrmz63
 WOpXcPhsIA++8Unfjmt0lmWki3N8k/+xhvhxG1cdSDIW/W+v0K6FwV53t1lnEjZ7GObw
 IMT5qFE0W0xNU3yON72XedIpHvFb4rah99goAUx5Hr3xASMIpaPtoZsRh42Qa22hspJb
 oMPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXQ+zV4EJ7hr67WvzYZPO7OOgEVpD1zdr0WJGvI/dcA06uPT6bZB5CKudR2nYnb/z+wd2S1GXCeVI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUmVFJO4HPwrdbWWcnEk9o0WqW8D60vPrGl1eiM+6xOd3ZDaCf
 s75xAb1vKKRWxGNLwNgAkeX1MSWTujGvF5TlUx4OZ7++xulFwhlNqvAyzl64dFdd3FkCKwj37yq
 zFkoZXDadUAhqki0yBpVg/HFJ8MlCBCcstjVe3YLG/q+8TT8XyVFtfu3LJ1d/00HxGPDrw5I=
X-Gm-Gg: ATEYQzxKEzW+bJen+sBCAHPyjszKttWWyEQhi4EL3Kj0Nh89BI6ara5rbIesGKuD1Mz
 AQaDD/oFQra39WPOxciCKSHdYAg51UteS2BXaEHPI1Lbhuzm6ULH3Onpqr2Q4MYq3HGprhy95Mo
 1p874YtCDCKYrx96l0LvkzF85Myz9w6QUA9jhWpc1bQHGf7nEqwsYoUtVwbnqaNIiUp7njxPQW/
 h39UiPbMJNZNfH/N07DmbcHFrSnf4gwzaerB7ZlmbzKqzma6Ar2YgX9lnU9oKq5+MkX61CxxBwS
 xoqtQ53kjyj8dZYYz3EB5JXASnOOpKHg+ZnMUT8TQvksjXcDdSSRjLSuphThlxNuomHo7hHa2Lp
 WUus7e1wkFp/dSI33EDOTkqHx/L1ZupDoxf+LfiZ1FM+nECd9/AXyZ5UjO1GSVVXwnV5PHtDyp9
 odia89
X-Received: by 2002:a17:902:e5d2:b0:2ae:7f24:4940 with SMTP id
 d9443c01a7336-2aecac97dbcmr161128845ad.50.1773694491598; 
 Mon, 16 Mar 2026 13:54:51 -0700 (PDT)
X-Received: by 2002:a17:902:e5d2:b0:2ae:7f24:4940 with SMTP id
 d9443c01a7336-2aecac97dbcmr161128715ad.50.1773694491133; 
 Mon, 16 Mar 2026 13:54:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c27:17c8:7897:b4f6:fc6e:b55?
 ([2401:4900:1c27:17c8:7897:b4f6:fc6e:b55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83b35fsm128243285ad.80.2026.03.16.13.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 13:54:50 -0700 (PDT)
Message-ID: <97b5fc67-9dc0-4d86-a98d-eabf7465ba40@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 02:24:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: rob.clark@oss.qualcomm.com
Cc: Alexander Koskovich <akoskovich@pm.me>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
 <CACSVV00HQY6OfWRSWDcv4KnpwhTO+aLpTXLoQuGutvTTmgJFnw@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV00HQY6OfWRSWDcv4KnpwhTO+aLpTXLoQuGutvTTmgJFnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AcJGKRqiFwqxE6smkpBIhwYI528V_i00
X-Proofpoint-GUID: AcJGKRqiFwqxE6smkpBIhwYI528V_i00
X-Authority-Analysis: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=69b86e1c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=iNc0q687GlOE84pCJgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2OSBTYWx0ZWRfX3imloRRVUBaG
 PF1L+7cUKP8to0HiW0xNsyHRdtiB0ybzb+AjOqdxukhOEhigGq+E7a4d1P9y9HrAMDsiDpv9iRz
 gXENNkGLU2oURQ5U7Fhwz8wz0r7hdTtwFDyAoxWZO9qLLSbNirjfTKvRsKPVi6GvqMcWNm3NT1e
 1ujvZB6yEgOoV0TfXDcbu0vggfIhtMU++LvNxMMsROQWhAz/Ol8d5nR5hjv132Zo6TBb/mL4q7q
 187qsFPwN+Ol48MPqtVHxPmW/5jN2dxII0XiTVAE5fAVkCjNwl7PA/qKcWab02OiQBu6zTH417P
 WNvSTrsmu4oF/0lkLzpAOi1H0BThAJKrNQ89eQJ7TFp0MT8TlbsORzBOraewLQLcrLhSsVgS/iH
 a4WZ7A2x9W1vSqeCvxtCeh5kUEerAjqmWwJ0I79QHzANj60uWnKBrWgypWa/M3sl4rep3JmXm0/
 gFfrxLpeAmu67c/KY7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160169
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

On 3/16/2026 8:01 PM, Rob Clark wrote:
> On Mon, Mar 16, 2026 at 2:22 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 3/14/26 5:14 AM, Alexander Koskovich wrote:
>>> Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
>>> GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
>>> to family >= ADRENO_6XX_GEN4.
>>>
>>> This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
>>> an incorrect GMEM_BASE which results in severe rendering corruption.
>>>
>>> Update check to also include ADRENO_6XX_GEN3 to fix A650.
>>>
>>> Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
>>
>> Hm, that commit also changed the value for A730 - Akhil/Rob, should
>> that be changed back?
> 
> No, it was incorrect before my patch.  The only problem was the change
> happened in a6xx_gen3, not a6xx_gen4.  So this patch is correct.

<< a little unrelated to this patch >>

Rob, on A740 and A8x GPU, KMD is mapping GMEM at 16MB and 64MB offsets
respectively. So returning 0 here to userspace for those GPUs doesn't
seem right for those GPUs.

I believe userspace is interested in the aperture base address
configured in UCHE_GMEM_RANGE/UCHE_CCHE_GC_GMEM_RANGE registers so that
it can compute the IOVA to read GMEM via UCHE.

-Akhil.

> 
> BR,
> -R
> 
>> Konrad
>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> index d5fe6f6f0dec..0ac3fba5c277 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> @@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>>>               *value = adreno_gpu->info->gmem;
>>>               return 0;
>>>       case MSM_PARAM_GMEM_BASE:
>>> -             if (adreno_gpu->info->family >= ADRENO_6XX_GEN4)
>>> +             if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
>>>                       *value = 0;
>>>               else
>>>                       *value = 0x100000;
>>>
>>> ---
>>> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
>>> change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425
>>>
>>> Best regards,

