Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1620B106B504
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6382310E8A6;
	Wed, 25 Mar 2026 21:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GdimBKcJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y9Pdxemg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E68F10E8A6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:46:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFH79J2432173
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EHvpyCZJsypMHVwxXNF2FT+oeJZbUA/sFO+4H7ugunQ=; b=GdimBKcJjkA5CCQu
 kW8yzErCbl9vJ5021GQ6FIhsz4dVPvFr3QTIAZqzRychY7nbW3zwRlRvhFtqL4p3
 2/jh7svL26CyWAf0pq5rHzDW3/8tJXs49hkEIWM5CHxyTDZTA6vl3mq2oJmhLAwb
 lDuzIqq6Dxn4Ab8u+ptgpaUTvH7qiugNjS5SwxFMcNePxhcgUf+LAkCFypi9lqOV
 1jz0xjH6ppCx4a4ZLSI9sB7fMbUehUBN8Hc/9ZcGpLFZYpXYMQ65HcFnpiEPLpRW
 PvMOWnRkty5KqDJ5BTVQVqpqXEc90lxpurylU0megs7LvGCTNbthpxpTORx/gU/A
 CmKPmg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489mkqsx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:46:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso393908a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774475191; x=1775079991;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHvpyCZJsypMHVwxXNF2FT+oeJZbUA/sFO+4H7ugunQ=;
 b=Y9PdxemguY2CT6jFtj8HJYGgAP0jGDhq68dWeAU8pY82I5V5S/Ve978rfO2zsz+Bu4
 oa08xDh0ec/cLipYDCm7Dgc7kOdE8syj9+56gn+E0ke/mO/JP1G7VVZzofr23S28dENC
 l6JUznViDAmZzSOLKqHlUcGgsbOdtB0uZsu8IGbRRVjOdErMgr146eghq7Az4Fyyl54w
 XSjDY1wCWeSFFLWhbzRC2UwR3wUcIEAIBJXQhDB9RogjoovhoDtD7tY2qBdeI3XdlUH3
 cPa7LMv9llfcTr3+tCPYaxDj2OnxqYW/hCzE+aH8wIRna0Nw2v7/t4c+GdGJEIb0hwec
 Hq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475191; x=1775079991;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHvpyCZJsypMHVwxXNF2FT+oeJZbUA/sFO+4H7ugunQ=;
 b=fNt4dmSqqCUHHrJM7v31joUZ3osgTubcA7qC2shSX1G6Bc/+8ADNsTP+BNBvvlITLO
 xfh269leIOMmIYj0XAYMvlqln/E3jeW1oiv+qVoJWWJHYI7gogvWUagt2StLCqUJmcKz
 CDc+ssJTdGgne2/ZZ+gfbWmC72xp5ErWqNgeshr6zyGMOfG1hLROYg4pRllnT36hmOzn
 khH5mpaDD03B099gWAOqwqfTRg4kLl42+5EmpUdg4lNeEMOch/13BbjmwDMAzm6p13gK
 hDPwGWKnZ6WAgKsx9H1CIAhygRVddtmUGK38pKZDUGcLCz8ePA49mYDROtxJUHk66YWK
 7lJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Qbob/mLsB2Fb+1Sh8IZrr4a073PGTKdCCcCbQ3c5Wt4lP5a3U7RehGIcThWSgmrb+REpqfBRAJA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylLMKq6fysXifOqYCPwFvHl5X0KJeA/KLWtn4asM0zfqimYc/R
 wtyowgowNWGIaL9o65hXXkWLlzgtRdBeINGc+KDoOHHG7ruI+sfTmLWYCmZ3zRcRORUsDByug2N
 MS92H+BsBOjfhbmFOd5Lrpl4yWHTEVWE8pBFiri0ceoCsWZUO8HF8gsdLCKAvnfbpTA4Ug00=
X-Gm-Gg: ATEYQzz9ZfPCud4IUGub3sL5iagvZ71nzom3nQUulGIE281cwJimGeCB0+CM0ENZioN
 8f4EeIhYMrDG67gQs0dDQAqgka1BLUkeIzvniT9JTgiYmGA5j2andrHPCrRW6kph7qezXykIBIy
 txh92c3XmV8vzrzg4d4Up4T1YpKgI5bzHk5EXGAYxwfXISictFFIBwaj7IJ/RIx9L7c3+tA6Il9
 YdTVBIUL4XA9eu41A40i+rLt5CpoZdxtfXGM8cDiNSAlnaQHvj8II16ruv7MNrbxI97nEOnq6MF
 3BH1CTPQDwEQ6QqnzPDmS1nJNlbCDTGg6fnk7a0s4Qxp0CON2gM9PYqaewJY+2QpDowlcmc6Ize
 hOyleMJBno+86zYdBZTSycIvp3rv2KRoj5uzsqGv9+FCV
X-Received: by 2002:a05:6a20:a103:b0:39b:ef0f:a6e with SMTP id
 adf61e73a8af0-39c4ab517ebmr5713774637.11.1774475190954; 
 Wed, 25 Mar 2026 14:46:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:a103:b0:39b:ef0f:a6e with SMTP id
 adf61e73a8af0-39c4ab517ebmr5713758637.11.1774475190480; 
 Wed, 25 Mar 2026 14:46:30 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.235.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673978668sm378870a12.27.2026.03.25.14.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:46:30 -0700 (PDT)
Message-ID: <cb4543e8-dcdd-434b-85ea-561f341452de@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 03:16:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] drm/msm/a6xx: Switch to preemption safe AO counter
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-2-fc95b8d9c017@oss.qualcomm.com>
 <deb68834-f384-46d8-81a3-9eff88deaef7@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <deb68834-f384-46d8-81a3-9eff88deaef7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE1OSBTYWx0ZWRfXyht/YYetLV1F
 fTacIrfIdO3o9GzVqFGSYdL6px69wovaZ4w8kIs+hlnU8pnZ6Zt/HCGQOXj6WSfn7Rd2pUNu4LZ
 tSywf+D1AybSFitMkoVv0MZHBCkxZJuDazf8ekp5l6+EosIMDXcitvZJgRlt7OXfEBCruRQUpJB
 mBi5yviwW8oTtqfWhLcIpZ/yNf9ydNHvrkVgTytKYyyVAx7ZtuwLy35/P2CroeMrsVjXr+LkAzm
 XsMjLwm42/fa8ANf/HWSs+AV+5OJ4dt+hfM1f9cnN5zTbeyssRszILcwMRm4opIep+qbqUHE5jY
 c3NMIM/el+G5O5hGUwsnzhXPC7xC7oXo6qo8oXfx1Mr25b40bHDIYdjFLFmFJ6AtVqEuHnaXlzp
 P3CHoPF12T93JrRSFCe5AkI7oCS0oi+0qjpYWXfGhgac9+TXUbGGewc1nQXUn+JDxNDO5OMgL9t
 3tzHj7nwHEieglXwAAw==
X-Proofpoint-GUID: FO0Tyt6ghtMToA86rJD09CSQaV605ETK
X-Proofpoint-ORIG-GUID: FO0Tyt6ghtMToA86rJD09CSQaV605ETK
X-Authority-Analysis: v=2.4 cv=AKSYvs3t c=1 sm=1 tr=0 ts=69c457b8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=yg4K9g8yQ9z8uKSC4i4MOg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=NwhR0-MFI0zYuXa4w7wA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250159
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

On 3/24/2026 3:21 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
>> provide accurate data about the 'submit' when preemption is enabled.
>> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
>>
>> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 14d5b5e266f7..93bf2c40bfb9 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -345,7 +345,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>  	 * GPU registers so we need to add 0x1a800 to the register value on A630
>>  	 * to get the right value from PM4.
>>  	 */
>> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
>> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>>  		rbmemptr_stats(ring, index, alwayson_start));
>>  
>>  	/* Invalidate CCU depth and color */
>> @@ -386,7 +386,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>  
>>  	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
>>  		rbmemptr_stats(ring, index, cpcycles_end));
>> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
>> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>>  		rbmemptr_stats(ring, index, alwayson_end));
>>  
>>  	/* Write the fence to the scratch register */
>> @@ -478,10 +478,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>  
>>  	if (adreno_is_a8xx(adreno_gpu)) {
>>  		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
>> -		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
>> +		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
> 
> I'm a little worried about mixing the names here - KGSL uses both of
> these registers (A6XX_KERNEL_PROFILE vs A6XX_KERNEL_PROFILE_CONTEXT)
> to track different fields of the struct adreno_drawobj_profile_entry

But this naming aligns with the HW reg spec. So I prefer to use the same.

-Akhil

> 
> Konrad

