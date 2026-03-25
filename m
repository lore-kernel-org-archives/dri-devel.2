Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AD0106B504
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E38310E02B;
	Wed, 25 Mar 2026 21:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rq1nt6pb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e/6S42IF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D9A10E1F6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:24:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFHCxL2432296
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AfCGYJqubvQ+hqpDUprihSdfOOzSMrvZeD+Kh62V36g=; b=Rq1nt6pb8oU4qEef
 RAShjodPQO94i0aiKlFLToSHQH2fqIb12iFf3+Yqiq/ikrVolMrX2p1hdHV7P3gW
 NpaU3WR9ZYDAwZn0OZcynlAWdc34m0+XJzHQjBsJ2hxLxcYvvYe5DEXbVIPoRpuV
 edSW8gwczSR7FQ30l56367bRKRSm6y4hzY4C1nKQ3nJfps4Yim7DvS6OReEYjGqT
 aVVqio3+LVY5OQqWElQ6rgMmAxztA+slWC8IXZT5rpsXQFVR4rtWRhD3dZJ+q4+X
 txBbE8qF3Yu62bn8IIcIF4RIdlENYhaucjYtZuqlXXJKK9ptqijp3ASaoo+P281u
 jEqSnw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489mkp0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:24:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso1343635a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774473891; x=1775078691;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AfCGYJqubvQ+hqpDUprihSdfOOzSMrvZeD+Kh62V36g=;
 b=e/6S42IFMrlFeOIummrQWT98utaj0hOygqCt+A6tdnOWFQsnd30P1X9sL6euy1UIj1
 xSEgYLJ6wsL4gFyXx7RU8eZUlQFKx12quW2Hb9vO3mHcmAEXC/KcXo0J8z5l3A7c9tB6
 4ULjrxgDBhK72iQexw6BgXwIlnCZfN41PhuB5MjPrjPchWuP67RsP099kEBFx/vQ1yqi
 9QplokUu1o8NJ2/H8+l0iYKU86vI/Tmdkhc65+t2xBlJw2VWca1ETo6TzBs/6NIafHNy
 M4MqdVX05FfpaK0DXKpXL3TWwHGaIkaal/DdiN3RqgF4AdZ/+l0P3zjXZ5/2oC6q25/S
 tuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473891; x=1775078691;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AfCGYJqubvQ+hqpDUprihSdfOOzSMrvZeD+Kh62V36g=;
 b=jgsiCFJbUZzJgPoeFrWvdHNc4mzUY5H+gKgB3G/ZcwgbOrS80Lo0cBibjq9FMKWXAl
 dEth5IwipWrhubPv8RkRmeAlkmZJWavgSHEWq4JmFYVXOUDvV7qGQ/fWzsK/q/3ipDlY
 MdVarKtqQ6Yc9YgjgJQ4XUqbSUWrrTcLtRTO4mLTLdGCqJ/9oe6pjgNWUr3mxfO8fG0T
 2LWpa18c8dhXilTRPILKpx+P31RKcARzolljJE1PTNsw5YziJ5xv8GUtz9JsdjSGUh72
 +qppJfBo3NSRnVcB6ic/lK+G/G0agEebt99W5JxHEf33U12AP92TVEA9e3r4yjuAhfGx
 L70A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJIOv8JPLvCLYOLPIWTGtUsaVKPXnw8p1okTNQqu2dUwmmlOb/FvHQULeW1611d7l8xOJXC7wdbdI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIxBwoLVOdsd9mbEl5+mn7gnvJOvKYQMIZJU3+cAGo891tpM5s
 j1Myy9pC3BTJsLgrSSa9UNEyqXn2+p7jYovfyJM6w3JqswPfkCG1ssmEapDHkerKWLVGi/HkT1y
 5mO04CEWsCcgA6FRyOhgXjO2Pxt3zIZ0kAOfRTrj95QAe6E87kNx2mgkaiLUDDyl3FCfiSvo=
X-Gm-Gg: ATEYQzzto4XwqriXSf9lTHV9YDkBSgcv7z78PbxcZPLt5jOP+g3mGRZtM2tjYkN3z/m
 9JnqU9TcoRRdrvls8YBuiHFJuYKGClt8YxPcG37xrV4kaj4cRkZSS/C4ZvrEtDxBzhRQGM0d546
 T5N7b9+vnNKeKUVXP12E1KRp+FlUYaK5E6zklQqU77/nwibKzl8esPEPZNlGM/g1HPcOlvH0bU3
 1/CnRiUEPAVVIAIFx0FEJj5baY5GW2p2InHUSTnih1muyR/0m6xVohCEk6cmzPT63sCfD1VPfPP
 +xo4e2stZuBCaRBq4qjG8f9CtRzqzj77r9kDWW19Al3sAIZrBFh7VOm2tb3AM4Aw/6R4ULE4Wr/
 ccNlnCep51t46nhuro1gstobhkXTe1I37lGqUCn3DgC6c
X-Received: by 2002:a17:90b:2645:b0:359:ff8a:ee44 with SMTP id
 98e67ed59e1d1-35c0dc8ee2bmr4558441a91.2.1774473891051; 
 Wed, 25 Mar 2026 14:24:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:359:ff8a:ee44 with SMTP id
 98e67ed59e1d1-35c0dc8ee2bmr4558400a91.2.1774473890521; 
 Wed, 25 Mar 2026 14:24:50 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.235.17])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c1e150e47sm61548a91.1.2026.03.25.14.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:24:49 -0700 (PDT)
Message-ID: <6ca731e8-3876-4a9b-b54e-4d6609ae77a9@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 02:54:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] drm/msm/a8xx: Fix the ticks used in submit traces
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
 <20260324-a8xx-gpu-batch2-v1-1-fc95b8d9c017@oss.qualcomm.com>
 <b0ce15a6-b2b4-4059-93fd-9b4b0b4360c8@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b0ce15a6-b2b4-4059-93fd-9b4b0b4360c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE1NyBTYWx0ZWRfX3S6uSUmldXIK
 /duYMIAgv41M0RENhM8ZCaHFcnUiwbGSQkI8l1bDO5VXauq0jZRWMj3KuXjEthRBLayMo7iRVfQ
 O8u5wGpXBPU/BMHN9rHBrLvW4mZkHhLWi6NG6IVmraMDrQ0d81P7GwNOi660bVVvaie42JrC/5f
 Vjh7W4bnV+aJvYve/orDuz/aYk4de6/fQ+AvN0b4/6XqJ5siFmlB+GAO0RE//64JJNwVHQqPOg/
 y2V/3WmZ0Ms3qPtR5yN5K2ESxjLMluTszN0KSQA9QiBq7sKce3HCovjU8INepNIT8j4qcHGo4l+
 4vGuozY35rhc/OnA0RZn4exolgSSyUVQs3dY0V2vYn1ZkODaUsrnOg9534PoXHL3K+UaH2yDe/x
 BVfys+duW94aDPwq+Ru+JjAsFFNPPHh9cuHe8xCGFAStp7iFgKVvbjbfVAG4WHNm066bxsZT3dM
 612lRbLmV9K+3N3qGTA==
X-Proofpoint-GUID: UT8DlfABX-xd7GMgN7lwXpp-HuwuxDth
X-Proofpoint-ORIG-GUID: UT8DlfABX-xd7GMgN7lwXpp-HuwuxDth
X-Authority-Analysis: v=2.4 cv=AKSYvs3t c=1 sm=1 tr=0 ts=69c452a3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=yg4K9g8yQ9z8uKSC4i4MOg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XS4MtbDpHg606iH8EgQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250157
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

On 3/24/2026 3:18 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> GMU_ALWAYS_ON_COUNTER_* registers got moved in A8x, but currently, A6x
>> register offsets are used in the submit traces instead of A8x offsets.
>> To fix this, refactor a bit and use adreno_gpu->funcs->get_timestamp()
>> everywhere.
>>
>> While we are at it, update a8xx_gmu_get_timestamp() to use the GMU AO
>> counter.
>>
>> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> -static int a6xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
>> +static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>>  {
>>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>>  
>> -	*value = read_gmu_ao_counter(a6xx_gpu);
>> -
>> -	return 0;
>> +	return read_gmu_ao_counter(a6xx_gpu);
> 
> Can we instead make read_gmu_ao_counter() take a struct msm_gpu * and drop
> this wrapper? Other callers also already have a ptr of that type
> 
> [...]
> 
>> -int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
>> +static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)
> 
> Similarly here (also I know this is a static symbol, but keeping an
> a8xx_ prefix would be nice
> 
> [...]
> 
>>  	case MSM_PARAM_TIMESTAMP:
>>  		if (adreno_gpu->funcs->get_timestamp) {
>> -			int ret;
>> -
>>  			pm_runtime_get_sync(&gpu->pdev->dev);
>> -			ret = adreno_gpu->funcs->get_timestamp(gpu, value);
>> +			*value = (uint64_t) adreno_gpu->funcs->get_timestamp(gpu);
> 
> "u64", I think checkpathch will also warn about whitespace after a typecast

I didn't see any checkpatch error (with b4 prep --check), but we can
just remove this unnecessary typecast here.

Ack on all other suggestions.

-Akhil.

> 
> Konrad

