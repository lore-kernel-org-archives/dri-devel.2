Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D9106F30A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BA310E30A;
	Thu, 26 Mar 2026 09:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SKmBJX+P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KVSaqMoQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4C810E30A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:04:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q7cqII2887611
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dm7+IkHm6u3Ao2yPOvX+EC3oSpBBKWxXJu32fAZJmu8=; b=SKmBJX+Prt9utq8F
 pulv5S/Dzl0T/M/OhuoOry5fWfak9jVzJzptISTfv1yDKRpOysnUbaZdVRNR4pbv
 syOJd6mQwe1gOwQtfg9l7BuaT6cDuv8Mf63z72uQSgi8tTHpuzZl3elZRLwlRJj0
 Ldt/svGvnK1kgkty3J/la8EfJNJ65zPbMUEWmro+fK/soY0U6VfoTffZOIhkIRe4
 DkFJ/hKvEoYPJ9NyTMcu1HS20B3jIVRg+q0wWHunvHYs4jhvCKnLFgkSlRWrck3b
 0A2q413plVVlGc+v59P1X94X1YwRJG6EIuI1+sL4sASLDEpfg4H0lRFsfxvn603X
 l0GYPw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kg89tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:04:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89c69c8dc7bso1809786d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774515886; x=1775120686;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dm7+IkHm6u3Ao2yPOvX+EC3oSpBBKWxXJu32fAZJmu8=;
 b=KVSaqMoQiBulucQ6K0zLYTJL211SaHAFCOSYUfNkLTNflfkvKQWKIyFPTfXF2LGMeQ
 ufHeBOCdb6dbV1OlJ/QQj++64PzTVWybFNLge9erTBEW8UUcRDD4x5M/rhw5OIqbGWCv
 NzTp3M2kwTOTXw32vgNj87NfSR9+PwYK1HiDlR8fHThMY0tYjG4agUYiKk4oeKezdzT2
 evWUAvuw3n8qp6BCh6rbTdXq8Jpk0ffSsDzs3L7A58s6qCYnoK0jQbIVrYRfHuaHjdHT
 NkLYjBxexeTB7+2CRh+5H6HRAEG4I8L+ZGMju/a5np3uAFgfu+LHDJQHs3t73HYtsNJu
 7Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515886; x=1775120686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dm7+IkHm6u3Ao2yPOvX+EC3oSpBBKWxXJu32fAZJmu8=;
 b=IzXZnhWIgOKmlpWLTLoJItruRVOEyI+8OmFYan95WlxgdXb54ClzArSbOjlt15WlbX
 AgdG7qFrVz3qO7rSrGUsqyNptW8BP0qYUs6B/My4wbeQYOkV+iqI55SHsyFwnYOqjEGb
 m3k68PA5wmG7C9xBQ6rFX2bUsFir4Wiq0DqTj3l+EJbhmcjyi9O3Oo6LBZf5cYDVNMp3
 0e/xMeExKZZbjAqkqklVsF9wU03gY0n2unwPR1ncIgvw7s0kk0f5Y4XGmFBe2o+ns+Jm
 dgeXVgQdi12IB6ucCL2zD4PPLg5oRqnEND5BjNS8cDHYa5U8ObGa3EyUBgmyqB2XKHiW
 5iTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrM5jhk80Cf5qj2N9KPyqvWkhjUKK/5RxamAxKkkYBVQD0zr6H+incqTxKxviXOm+t1XSiYRop/PI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk9hzlNLOaALYs2NiNlyugbgzzXVYo1RSltyyGQViXwjzJurWQ
 l6jbX3yuXuQsQf6g7gY7xOVC1w8qBh4+AS0RveCEXBPpIyMtTlrSZtqW5fYMvIQkrOEhUhpudQP
 qL6rafwuh+MnO2Nhho/W/16qCPYPaeRB2g2TnzdLGo17xbLnq+DZPZv6cfaY4eAv8nH00zQs=
X-Gm-Gg: ATEYQzxAB0RVJtYhANoDooIiAbAqd2MK7/oVMW07DlSV96MjZd80L/32NjqBFfxSUWL
 ClEzDMovtgkMjfIMSSVYmnh6FBzfDsli9r4A0LopCL+bawWUVEXFTBJAsn35xJIG5okB61u6/CM
 rUOXhUc+GVwVY/AFz5teyXwVJcRdmLo1OzVMiNdlc5hUTf8/MufcehcMyrG9fQTttjBWfN9XTTX
 3G6NXCji3ZjHmnfF6Y58sERJNgAoIshQygzEagXM506BTVGFal1kpQp5o+Ssfn2sHuJR9nAhm4V
 hnBch9XJO6uphrDTv/Jb02647nCiXvRtRgdLooz3Wy/ZI+jo1Iho/WTKDLbyW0FuoyxZ4Omfrfb
 psFq+N/E8g1m0PfI69FTco+rdaNyZagvDl8JNoMPaxxhfLus8wtIHsF1oIbDASdg+stHFTd2uze
 F7rtI=
X-Received: by 2002:a05:6214:21c3:b0:89c:cacb:e8fb with SMTP id
 6a1803df08f44-89ccacbee74mr55023596d6.7.1774515885676; 
 Thu, 26 Mar 2026 02:04:45 -0700 (PDT)
X-Received: by 2002:a05:6214:21c3:b0:89c:cacb:e8fb with SMTP id
 6a1803df08f44-89ccacbee74mr55023176d6.7.1774515885035; 
 Thu, 26 Mar 2026 02:04:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203ef95csm87773966b.52.2026.03.26.02.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 02:04:44 -0700 (PDT)
Message-ID: <4bd0e8fb-a41b-4d56-88d0-c241d6ab431a@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:04:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] drm/msm/a6xx: Switch to preemption safe AO counter
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cb4543e8-dcdd-434b-85ea-561f341452de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c4f6ae cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=5p6duuq3bivipkMi_LoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NSBTYWx0ZWRfX49ei6pNpQx+l
 yBD3IkQ50Axa/UtqnsPAB8g90ClrYnyjXH3s4J6kXu3wm8liyPcOLmLuiInOkxovCGxQDNUR5zi
 e5BoYPJoeTeyPiZLvBdY+DmxMs2UPcd+9p8s2wReHnjkEznpNaXG1YIZgiUY0V3Isn8FwLmLMcA
 PLzFV+WQs15CpiPhvNjW2ddbQgIvHUMxzuwuX+txdawzfxB5HCudjMP+7VM9fg/22M2X0BX6HPP
 ogLXWbPS7DLQYHWwD6vBV8+ZYxFibInKcqhaIQ3s5qIT43lplQcEufEe++GhCnX2wue3GhXCf7i
 gurVFI1g2sq4tUDU7W/jG0niX848iH7mSSvcFKhXSN5ILsw03LCT0FTDrtX7FKDw4fm+VUTovUo
 JuMJXMedCyoPZP68wGEQHo9jkp3UYwAEVHzFEqxrqrijULWZg4JJAtj2Ygt1kDIW/Y8g7R/mxVk
 KnqPOrMAhjHHhttOfHA==
X-Proofpoint-GUID: eaxyvbhAT_jF_8p3xqrHMrvwIHFNNQeL
X-Proofpoint-ORIG-GUID: eaxyvbhAT_jF_8p3xqrHMrvwIHFNNQeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260065
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

On 3/25/26 10:46 PM, Akhil P Oommen wrote:
> On 3/24/2026 3:21 PM, Konrad Dybcio wrote:
>> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>>> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
>>> provide accurate data about the 'submit' when preemption is enabled.
>>> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
>>>
>>> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> index 14d5b5e266f7..93bf2c40bfb9 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> @@ -345,7 +345,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>  	 * GPU registers so we need to add 0x1a800 to the register value on A630
>>>  	 * to get the right value from PM4.
>>>  	 */
>>> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
>>> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>>>  		rbmemptr_stats(ring, index, alwayson_start));
>>>  
>>>  	/* Invalidate CCU depth and color */
>>> @@ -386,7 +386,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>  
>>>  	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
>>>  		rbmemptr_stats(ring, index, cpcycles_end));
>>> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
>>> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>>>  		rbmemptr_stats(ring, index, alwayson_end));
>>>  
>>>  	/* Write the fence to the scratch register */
>>> @@ -478,10 +478,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>  
>>>  	if (adreno_is_a8xx(adreno_gpu)) {
>>>  		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
>>> -		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
>>> +		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
>>
>> I'm a little worried about mixing the names here - KGSL uses both of
>> these registers (A6XX_KERNEL_PROFILE vs A6XX_KERNEL_PROFILE_CONTEXT)
>> to track different fields of the struct adreno_drawobj_profile_entry
> 
> But this naming aligns with the HW reg spec. So I prefer to use the same.

To make it clear, my confusion comes from:

cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT
             ^^^^^^^    vs                   ^^^^^^^

i.e. I'm not saying this is wrong, but rather that the local variable
could be renamed as well, to match

Konrad
