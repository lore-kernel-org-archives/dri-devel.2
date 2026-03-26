Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD29106F2F9
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F070D10EAF5;
	Thu, 26 Mar 2026 14:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J2M2N7wo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SGyRM4sI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7373D10EAFD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:57:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QArlx8220830
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jt4jdDfkQbJQhWE0oZ8OqglR8mliegdo/pvYwgB5H7Q=; b=J2M2N7woSXjLjInS
 oTAvOMnkcaDaeXyYN+4DXMQGDHsL9R90bQM5LoSfJ1Z+8QDjNdFdFv3PuVYunXEl
 D9x5yj1/+E4EMivNeiy6eFXvDmLs29cRgricN9Hxr5rGe4qMVQ10eJg0le6BdqwI
 FkNEw3QfHeTWq5+zU8WHL52+7/VwvKHmfoKHt46uFsr6csK6AhBFn8iKU076MJtf
 gjf0rRqx6kdLgWdiuFnJg55hZdYmbWpAi+1q9P2+h4zepvIHqrPZL+/US2+qqPuy
 i6R62RbYeoD1zZQ4v6f3bQEjPpycyEDSyPlxWDr4tgioaoSE1194zJhIELSt6QQH
 juh/CA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqgs56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:57:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35641c14663so1522245a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774537058; x=1775141858;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jt4jdDfkQbJQhWE0oZ8OqglR8mliegdo/pvYwgB5H7Q=;
 b=SGyRM4sIaRFZTJxMnwAd2gz3v89HhNNKs4AEsVZBC+4NphN4djGSJFMJgOJPr0a/Pl
 92942WL9n9LfpAqR6vZQyb6pdjSc7zijt7+l3YUsRwwXmj0gMY/ycLV5uKYTYgf49zii
 s0gyhSXNGTQTIH4CiLqbZBf4zWrnspgq+ICDyM5rUVhYoiwwAhmyGqkYjI/ptnFL9Pm3
 dCDJlidrXbk6MJkPsVcDzZ8X1p5UfzDLYrxtJuNfdKB/plcjJ/EWi6Zz0C8T/jAFoQXk
 waqMpi+luef/PaguM34BBmv6dzi5T+FxrHwBaTY6hvjXXfRK6DkH7kWZ8DrJaOnPNzoy
 bDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774537058; x=1775141858;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jt4jdDfkQbJQhWE0oZ8OqglR8mliegdo/pvYwgB5H7Q=;
 b=QhSUP9O8KWtnGjEM1TtZJs5r2+PzPSs7pCNDtX4o/GkGJ3FWTbOCSq2OAI7nOXapKp
 ffK01Yx66qplYrzLpenrBhBQMN3MQ4Rtj2tZYaAPJocIwvkwNb7mV0FL9X1JgB5L2yyh
 WlRhPNRzwflESLAHwHbrQ98sJ3aJ8mde+YC05EP4JRXr4KQ9E0v0D+0eduJhd5qH0Jke
 cSU4zA9aNUODC+9EOGVQeVAQO4NLk//jkUr5UjnBxBWR43nlLZIr7y6XHoCDIsUs5uwU
 wN11W9rpK1nXJm0CUYsnbUQiwWi37a4ujOHVwVRve0/4OIgOEPLTLLuQsLKVV4NgWmlg
 ubQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOUyFnn/dH+VRKGKuFiz+m7fdJCH7End3E98V6+m1rSOjs3Jl7nIx3Isj0ToXs8hX0S4W3o1BuFBo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGjIWef0rStiXorkYMjF8lmt6M7ELSiEfC3U/ZBhTALkIwyXuM
 5ZMAl4vhAtEig3UIlMkpLz9xI1Uy0Ui0i/fulhOU2kaBlqu/x8XyPJpvif5gGlJgqL/wKBUsHrH
 Zd0yHuY+UgsVobQx4vRRPReTxAtvGv9hzP0Mb1OfqcvrZVzeTJT50+AWU13pXlsRV64H8m5c=
X-Gm-Gg: ATEYQzyzPSlu/9T3f8/mDzEOUuHT6ubmys+Y7tvzyLeP/UOp5L9CI95NgrMhIWKxiyW
 /l2ABBOi6jE550crf/yIDGw0OsnqNUMm9UhKQuf7LlMivPQDtld4+32ptWYDb48FZi6ON9dripo
 6gaJkjdNgojGtzrZUuB0Bgo21SFQ4/yKOPOPjW1k08GXyCMeEPhdVA6mySvWjK6IEGpFw/hUjSL
 qW3pOPlrX9G3kaavRTDlSemN7BRrbx7ylXqE78PNxax6QxA8qcE6YbrEWHDxXOKjumuRt59PZiE
 xcKDd1Hpt2Vvr6OoC7ZO0qzh2p403DhGRLILbiv8X5B8WDoJfT3Jx7M/R7CEhuBb56rBoXSHtFG
 QCZQJpFgEeMoMyUqN45rrJBveLL5+uHz4DKzA2nEG7jYb
X-Received: by 2002:a17:90a:d408:b0:35b:a8cf:7969 with SMTP id
 98e67ed59e1d1-35c0dd0d076mr6948790a91.11.1774537058219; 
 Thu, 26 Mar 2026 07:57:38 -0700 (PDT)
X-Received: by 2002:a17:90a:d408:b0:35b:a8cf:7969 with SMTP id
 98e67ed59e1d1-35c0dd0d076mr6948750a91.11.1774537057676; 
 Thu, 26 Mar 2026 07:57:37 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22cebf63sm1853913a91.15.2026.03.26.07.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 07:57:37 -0700 (PDT)
Message-ID: <66b8deb8-6138-406e-a503-27cbe5dce2cc@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 20:27:30 +0530
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
 <cb4543e8-dcdd-434b-85ea-561f341452de@oss.qualcomm.com>
 <4bd0e8fb-a41b-4d56-88d0-c241d6ab431a@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4bd0e8fb-a41b-4d56-88d0-c241d6ab431a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNSBTYWx0ZWRfX0d7Kb3KCqRNs
 Y/gGiba7CF4C/T6ENPi+srdHUjLCMvlJfYsPG5IA8IQ6mPf2Sb302v+RxDNWUofwiidNgE7gDNC
 EmJqBBv2gwXBmpuWetz/o4a2L1GeK6RrqNezIgq4LMbl5UeXHgZItr5J8S64iXrYXoLxuUPDBLU
 rTtm/lk/lVUB59Xb/neeWapvbU0Orqx2fPbnskZtabrYfQASgyj3TTMHrh1ax6qdqfTwQ79BbHI
 uG+ruwp5dV2L8CPVUGcBN0pJiGDV23Z81CysvMLbUihAYYDSesvrVfcyJEpYhLZszHP83R6SFTJ
 UA2OZkik7s9bgtBCUESnTsbG1uYUlJNepGKkpNLfr+c8UDbklTAVAe7z7FK2nCR7Sf6zEeJLBpf
 Xs2Tr1RXAG/d6Of6JSlpiTwGMl9ra9mnqmQN2UCUCFoh7ISoWdqxu9GZoFPMgzDyPUEsdvj549+
 VNYxKswAxEQKWNYeYEA==
X-Proofpoint-GUID: v-NMHLq44gQsUaOpuu_F-Xs_ajOdU0HL
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c54962 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tHuJs617m-YSc7YiAWEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: v-NMHLq44gQsUaOpuu_F-Xs_ajOdU0HL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260105
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

On 3/26/2026 2:34 PM, Konrad Dybcio wrote:
> On 3/25/26 10:46 PM, Akhil P Oommen wrote:
>> On 3/24/2026 3:21 PM, Konrad Dybcio wrote:
>>> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>>>> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
>>>> provide accurate data about the 'submit' when preemption is enabled.
>>>> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
>>>>
>>>> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index 14d5b5e266f7..93bf2c40bfb9 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -345,7 +345,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>>  	 * GPU registers so we need to add 0x1a800 to the register value on A630
>>>>  	 * to get the right value from PM4.
>>>>  	 */
>>>> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
>>>> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>>>>  		rbmemptr_stats(ring, index, alwayson_start));
>>>>  
>>>>  	/* Invalidate CCU depth and color */
>>>> @@ -386,7 +386,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>>  
>>>>  	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
>>>>  		rbmemptr_stats(ring, index, cpcycles_end));
>>>> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
>>>> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>>>>  		rbmemptr_stats(ring, index, alwayson_end));
>>>>  
>>>>  	/* Write the fence to the scratch register */
>>>> @@ -478,10 +478,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>>  
>>>>  	if (adreno_is_a8xx(adreno_gpu)) {
>>>>  		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
>>>> -		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
>>>> +		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
>>>
>>> I'm a little worried about mixing the names here - KGSL uses both of
>>> these registers (A6XX_KERNEL_PROFILE vs A6XX_KERNEL_PROFILE_CONTEXT)
>>> to track different fields of the struct adreno_drawobj_profile_entry
>>
>> But this naming aligns with the HW reg spec. So I prefer to use the same.
> 
> To make it clear, my confusion comes from:
> 
> cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT
>              ^^^^^^^    vs                   ^^^^^^^
> 
> i.e. I'm not saying this is wrong, but rather that the local variable
> could be renamed as well, to match
> 

Aah! okay. Ack. :)

-Akhil.

> Konrad

