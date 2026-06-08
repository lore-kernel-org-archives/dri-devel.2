Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52390CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 21:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EDF10F9FC;
	Mon,  8 Jun 2026 21:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LcYyTOLv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eWiExLr5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B5310F9E0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 21:55:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658Iwvvk345857
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 21:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lq5r65cI4cvQDT8K/mXYMGb5P7nfGwEpZycTXrCr7oE=; b=LcYyTOLv9hMZW+nS
 IwDQmHUcI9lm2Oo8B1hzhHrTzaWPS2lBKmVKRjW01jVpoR2AmjcZJamP6TbmfCDp
 4r/v82hcPSZok8By1k6PiQo8CbR7+suLiV/a75NNRFbWW6op2S7WFOVBFhIP831I
 c8wjPwyGObREczr3oDQOzr2ngspZb9NItDIV2HzkP1f6uqB/hybkDjGoy3qJ13+j
 MxfILZ76gxH8dkiVIyxXGU1n6cKyFkrrYhIe1sKoD9DtKpYD9QYUYFfHfeE3n23I
 YK1SpHtd68kKNfxzM6/l15iJvjmNcftHrUQYcQakzVIVU/K0m80GovqA9ByufzGm
 vG7QEQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxee2ac1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 21:55:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842446a3851so2293680b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780955707; x=1781560507;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lq5r65cI4cvQDT8K/mXYMGb5P7nfGwEpZycTXrCr7oE=;
 b=eWiExLr5R+tjtbB5eAZOAISkfb/QcInATJ5Le5M5cibX0eyrkyUiER1NPdvTFwDxWE
 vxb17E9zgHISr6PU+1H3VHaRiwRedzD3OL2JV/TqP4lxK0EtSr5M5ImPYMOYzIZE8Lcj
 kUDj0J3H87LBWW4Myr/M7v4TUwzpr0DsHVbYXubkeKnLc9D6D7ulgDwO8muEhX//brEn
 b03bUep+8/TwZIEdO3mnVSt5BqE5kkH/r8IiyXffpRYnVGoqy2zeayOx7uHSxfKHUuVC
 QPUk13Atr3p9jTMGd9cpwuUY0p3ZS7RZ106NR09o0jvzlUASOwGOg+gXasGWUmXPmA7A
 zG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780955707; x=1781560507;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lq5r65cI4cvQDT8K/mXYMGb5P7nfGwEpZycTXrCr7oE=;
 b=YYNw96QaPBv78/MAX1SGnaNUAiccIwYRT0lhxK/m/7DmJLDvIfsmLZ63HpaBxGoYqF
 ORAu6/YCBymUzbcQht7fGIu6TN33LbMl92hptHaFJuxX376wbuFei0a/NY7GvJGXslv5
 0uhT+coSeB/0qgmmlYMi8CiwSrHiP+oS9joeQ38fuYkdXgIebSjeT5+IM1hbGpgwGsXL
 yiGH3Auwp0CtvEhHNIHlZw/63NoNxCMktaeYjPDahRwM63Utiw8MfRxZzHaqr7TglfYk
 c8qrGVKZdAODn26Q10551D0oSg639NTwsFZB36Wk/YSMomhC3+kwiuWH5gN4NiRAy3iH
 h37w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4ErWWqnPEFYFK/v+E6PxTg49/VrfLyLrgbkUlRpdL4zgiSnGJQfuzGtbpSOqJ3/RKgMGpXm8sthM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxky+Yhr5L83eDqLvw6fW98T7sOzZyfXA4XuqfENIyBY5xs+O3S
 +R2XuRnzRcR1uU8Md8TyUSlqwhKa505LF8gfJtY5Ad6Z12xbsKrlfJd9I1HgJT5u56bM2i4Tz2t
 yY8MISkKh69U9VfOdvYd7OnXdOdPkcp5hUS0fZo0LBbhc0caPhgPgl6uHRrCAJsNbDSRBR+A=
X-Gm-Gg: Acq92OGQRgyis/59e5K087AGcU1GO2wRpoJXJffR4ziNu13wzTS1RHIommh6C+olDa9
 4A3/uh6oJ6m5QpJTWan1m5hZdRKGqyOWnWiZV+mD58Ak+CPDkzMw98Rudjq3fP5Gpp1c8AP9Zu/
 g88ltua+3G4Fc644YVHYioprmIc2vBxks7hVnyqLoVeziYQI8ntipHbEdfYoLJv9mCUFO/32xPK
 ypx+urkg+TBSNtB5R3w7UABGoJNyP7V5hExXlI376mXge1GJo/BWF2G+fnmPgmCbelDYqoTMib6
 /m6G9H2pmPCxY+JGtwMalwNRu2qtCS7NGAGzUVOjiTm+/FQzS2V+EQUk+kFbb6e0jccjPGoUECa
 ODWadF4MLgPOpUwsEuGSLC3mbCo0i5syWU3SeMaLZRtnVpWtXULeE22M/
X-Received: by 2002:a05:6a00:844:b0:835:405a:7e6d with SMTP id
 d2e1a72fcca58-842b0ea14f4mr17787860b3a.21.1780955707059; 
 Mon, 08 Jun 2026 14:55:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:844:b0:835:405a:7e6d with SMTP id
 d2e1a72fcca58-842b0ea14f4mr17787832b3a.21.1780955706571; 
 Mon, 08 Jun 2026 14:55:06 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.228.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282221470sm20386450b3a.6.2026.06.08.14.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 14:55:06 -0700 (PDT)
Message-ID: <49b8530f-24d3-4201-b22c-0f8eaea9f4e0@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 03:24:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/msm/a6xx: Fix IRQ storm during msm_recovery test
To: rob.clark@oss.qualcomm.com
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
 <CACSVV01dbQcjE+nTic+9R4VfCtNGvpwODH8BMZi8B7LFtcCCfQ@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV01dbQcjE+nTic+9R4VfCtNGvpwODH8BMZi8B7LFtcCCfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDIwMCBTYWx0ZWRfXyr332DDIU//t
 KbLfRI3SHTy8IVl3ck0MgLf6zF7B7qGhsc4iAvvK7YYZn1zFllxd5fY6fMgrodpNMKrv85tZqPV
 /6xP4TxMjvU2fg5Sr/ti4GYi9WlEllAt9+bzlmH3Acoly6bs0KNYl1f5nMDSCWns1QAr59LZDOM
 d30G+4344gA5k2/EvN7jL43pmVOe8eTnNrurVxuy6OM69OSzRNwdICTFGCrLsntmeeHPtJnjCzU
 YrZFpUvXLXIje0+UZFpKKbGBCo590PWjHThWMEUoNXz3b6za1Qj0AaBMZOFvakvv0/ub2iZHiu4
 O5dbTYazOhBY0JOWTwOgmnvB5GGzGETieLeV5hXwNQfm18gZS0uhnx9xfCLM8/mGqtStVNYDk3+
 Uc2+gRCUYP9mW2LadAKIbgUBKQ8h+aC+TaNf4KIcd5P47CBC4A8MoZYUF/fgoJr2o+36cWhyfbE
 tv1j7UogFgsbwEAI2Jg==
X-Authority-Analysis: v=2.4 cv=V6BNF+ni c=1 sm=1 tr=0 ts=6a273a3c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Q2jhz0oZVy1Wt6PcVz7aQg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WJmIXLFun9vGvqKifugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: -RwjpHxe-qCFK80r0M0v24IkRnG4vDAY
X-Proofpoint-ORIG-GUID: -RwjpHxe-qCFK80r0M0v24IkRnG4vDAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080200
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

On 6/5/2026 12:20 PM, Rob Clark wrote:
> On Thu, Jun 4, 2026 at 1:10 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
>>
>> Once a hang is triggered by the msm_recovery test, the gpu error irq
>> remains asserted and triggers an interrupt storm. In the worst case,
>> this IRQ storm lands on the CPU core where the hangcheck timer is
>> scheduled, blocking it from running. This eventually leads to CPU
>> watchdog timeouts.
>>
>> To fix this, mask the gpu error irqs during msm_recovery test and
>> enable them back during the recovery.
>>
>> Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handling")
>> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
>>  drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
>>  4 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> index 2c0bbac43c52..f1df2514c613 100644
>> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu)
>>                 status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
>>
>>         if (priv->disable_err_irq) {
>> +               /* Turn off interrupts to avoid interrupt storm */
>> +               gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
>> +                              A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>> +                              A5XX_RBBM_INT_0_MASK_CP_SW);
>> +
>>                 status &= A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>>                           A5XX_RBBM_INT_0_MASK_CP_SW;
>>         }
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 8b3bb2fd433b..9a4f9d0e1780 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>>
>>         gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
>>
>> -       if (priv->disable_err_irq)
>> +       if (priv->disable_err_irq) {
>> +               /* Turn off interrupts to avoid interrupt storm */
>> +               gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
>>                 status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
>> +       }
>>
>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>>                 a6xx_fault_detect_irq(gpu);
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index 9e44fd1ae634..0f6fd35bd587 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
>>
>>         gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
>>
>> -       if (priv->disable_err_irq)
>> +       if (priv->disable_err_irq) {
>> +               /* Turn off interrupts to avoid interrupt storm */
>> +               gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
>>                 status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
>> +       }
>>
>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>>                 a8xx_fault_detect_irq(gpu);
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 9ac7740a87f0..48ac51f4119b 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *work)
>>                 msm_update_fence(ring->fctx, fence);
>>         }
>>
>> +       priv->disable_err_irq = false;
> 
> Ok, so we rely on recovery to re-enable the error irqs..  that is
> probably ok, given the intended purpose of the debugfs file.  And,
> well, it is debugfs.  But why do we clear disable_err_irq here?

Now that we are updating the IRQ mask register which won't reset until
there is a gpu suspend, its side effect will be felt even after
userspace deasserts the debugfs knob, potentially into the next
testcase. This is different from the older behavior. So, I felt it would
be better to reset this flag during the recovery, considering
msm_recovery is the only user of this knob, afaiu.

I should have explicitly called out this new behavior of disable_err_irq
in the commit text, but I forgot.

-Akhil.

> 
> BR,
> -R
> 
>> +
>>         gpu->funcs->recover(gpu);
>>
>>         /* retire completed submits, plus the one that hung: */
>>
>> --
>> 2.51.0
>>

