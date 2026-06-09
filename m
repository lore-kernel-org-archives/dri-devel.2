Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D5CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8009010E603;
	Tue,  9 Jun 2026 20:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U+4KgRIO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KntgBoRo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25AD810E63C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 20:03:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659GOX4g2746260
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 20:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+iDlhgiTQyAJZ+H1EN2BAvPrKf8+QgAknHjV7x0ZDU=; b=U+4KgRIOwOX7SWaU
 GfbWK49NGSGZ3n2YIvvI0tkLctbJKl1yCIXUFpa1j1RlecsO8Ba9/pjJ7MX1bMPI
 h1Jkje4okRBiX2vPEFDqvR37fC5cwFAswWqPx0H0JMkwSJnTpc3cxBFhMd5q0AMn
 OFOGx8cMjQxSqyljb7vpWS1Q5L0gTAzXAqOwPesdUar+ysyuEAXGXL7cqYxvoK8X
 t3aUWcMQMo6APsrqbaicZmWcKUl7EdTOXHqoFudlI3h5M2HFfFgYzP4mneYfOycD
 LDwpIvuT+rlsB9yo1pgBPKvxncJUbCeF5BNTj9u9II50Zuzg3nBL/XUm+QYfkE6S
 PP0yGg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wk2wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 20:03:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so4511330a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781035422; x=1781640222;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+iDlhgiTQyAJZ+H1EN2BAvPrKf8+QgAknHjV7x0ZDU=;
 b=KntgBoRodICiXBlkCWURb0dyjt28zBJWUWFlpuQScpAuqtG3YCqoXExNRDT8tEtv1j
 YRK8HrTEbuDgEtBKkHmyU0VkT1lJjaF00uOUsn8IkS+6p+a/H/qXpdETWiBLUDNzrxMp
 2hCgbkcRQgkwTFgAVPJftg2tbN0EcrPduZqTSzHryNoXNZZU9HinOvlIhh+Nx4TqXaJa
 OL2Ie+SKZ3Xt9yPXa7Jqr9NEKqqPgnT7LU7XX+B/jFFVST2HkEI2+IBhL6GCy64QxWuT
 DgPN06zzOVQFyyz+S2Z9D3WQQZa0pd3mDbqE0BbrsbwXQF2KeRns0qOTl+c6F696XQIn
 y/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781035422; x=1781640222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+iDlhgiTQyAJZ+H1EN2BAvPrKf8+QgAknHjV7x0ZDU=;
 b=UgP/BOM/4QQLURgbCAIZxBbl2ia5/YR1jZsq6VOTWIRcxXo6v4ZIljqePBUM3Q4Krg
 IMGXa0qEJ9qq5LwuGIeWZGbZFv7m9duRryHGeWzBOka14jcaqcuX2iAJeGXjslwIKMF0
 xHRBaILXlEmJpef8XWawB3HTyYolVBSNyvm57Y1JWqyRFLSDYZKku9Lpz8ynLuHkfWrp
 /pp7YPJCIPfRq6eTKFr2zBwpI0Ls1eBXRtq+oXfJnxhY3QFDM0918FB8zafNvDyLJfSj
 TZA72ndUnCy7eMvY8W/v47fjAtiZpyASXbpPrEO1kqdZF8DKbNTeoELUzEaBb3ZjFe3P
 O06w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tQW/n1M+VtMDKSstQqOjltgArlX4jmbLW6R9a/acPGHuiIwe6hR4MR4CCTHH2sJaq4IvrZ1bxVUA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxye+MEJt5zil4FHMlLi8OlU+1BeqQbD02iAi7ozfGoxi3shGrh
 l8mJKzPQJgk6qkf58CTdVuKA/BpbLk5zLSYAk8GXspfix32+iDtAFzBxp38FBJ+ShALWCJqN1cO
 f80MGtStY+Z6h7IPnHA0g/MUnIaNNgcERYUpjpQivNJH9s7SlYD8JlnAso+jmt2c+Kk/WyPI=
X-Gm-Gg: Acq92OGy5gnMiTdN8e556bMgk2OTT/r9A6/iIRhq258o1ZPJClZMIGllZ6SgPoGFMgo
 8QVJ8fNBdPMeaedOUALcrvbCctuQWTEVLc0GMW0YTrhC7y9HfVM8G6GLQe1r6PUx5W20X3+44Ec
 n2GudbFyDbvxgEg3u5M8KodI/MHobmfKeMlR0hA4K50av3CEoZ6Yc+nuVBN35DOn55R2GVXk4+t
 ltBoA5Q5nQ7GTWlJvRsuORvUH5I+zF3uO/+v1w1eHMf7nTE6w80hRtgtSFbjWlmi+HqudrHiOMw
 QD45xLYl6Id4x76R2ALc+bAFqN69nLeRf65pRlEwDbMu6LJl6vjfDEqOSwq5wkotZbip/6mVjX5
 tH+Nw2w/tVkioGAzlHkHV3DR0V2Zg33IlmSsR6qhoNqfgYTKrexPf2Q4b
X-Received: by 2002:a17:90b:4a50:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-370f0c4ecf2mr23289058a91.21.1781035421748; 
 Tue, 09 Jun 2026 13:03:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4a50:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-370f0c4ecf2mr23289030a91.21.1781035421239; 
 Tue, 09 Jun 2026 13:03:41 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.228.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-376212812ffsm241869a91.3.2026.06.09.13.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 13:03:40 -0700 (PDT)
Message-ID: <b8d6f4eb-49b8-4886-8c78-8adb2ffd0b3d@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 01:33:34 +0530
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
 <49b8530f-24d3-4201-b22c-0f8eaea9f4e0@oss.qualcomm.com>
 <CACSVV00vFNZDCN24wSdffZFRWpijb53qbX_-3b09ny4noa7-Mw@mail.gmail.com>
 <d153235f-ffec-4fee-87b2-6008f26d7014@oss.qualcomm.com>
 <CACSVV02_Yh21Ld5NX6Z6iaG0sfTGseOD5S9X_avSC=7RAfNt6w@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV02_Yh21Ld5NX6Z6iaG0sfTGseOD5S9X_avSC=7RAfNt6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE4OCBTYWx0ZWRfX0gR8egHpp0Gg
 9bH+7AhqdAOmaB0Bz2/TJo8ToeZ4Orba8PgrOXvUgTe9UYYYqCvhPNKFZS2ma8hKVZn1IbfOSB6
 wttKzNE8ycVvzLZQMj+jvFtcGiU1viObrW9hBTO47z20sNpuVK+wN4nSvv7USdpsl3Oe6eZdHbL
 zfbjfDnxTVLxQZNK+DN1uBD8bGB6HJY/Y2e41gg8h7gQG/+2GOTXiVEQ8hqdBpTfpPOoZRxU20t
 Lj9aY1AAqAreV2hRUzLoiZhhJXCx7WhSSnN54/nDUP09PVxU2rK/F6n2MUfezVzXRVJ37FGf3KK
 WcL3whngoXdfzPuK7K/ONewlY5aI3P2n4gs5UKs49elWloF0Mh8+10QPYv5qiFVAqk8r81ryXEH
 e3u1ExFxFt/yEVoaf9nC0hJypK8XfpNF1Cb7qL6nn5FHkOuJsH1Cbommh7uQRZvNWv4s5rZr0CK
 6d49/ssVo7pqxOa//Tg==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a28719e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Q2jhz0oZVy1Wt6PcVz7aQg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mdSVG8094VgbVpz2fjIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: RsDVud4_6C3ex5RmGdDzIw-OwsjSN3EC
X-Proofpoint-ORIG-GUID: RsDVud4_6C3ex5RmGdDzIw-OwsjSN3EC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090188
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

On 6/9/2026 7:55 PM, Rob Clark wrote:
> On Tue, Jun 9, 2026 at 6:09 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> On 6/9/2026 5:50 AM, Rob Clark wrote:
>>> On Mon, Jun 8, 2026 at 2:55 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>>>
>>>> On 6/5/2026 12:20 PM, Rob Clark wrote:
>>>>> On Thu, Jun 4, 2026 at 1:10 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
>>>>>>
>>>>>> Once a hang is triggered by the msm_recovery test, the gpu error irq
>>>>>> remains asserted and triggers an interrupt storm. In the worst case,
>>>>>> this IRQ storm lands on the CPU core where the hangcheck timer is
>>>>>> scheduled, blocking it from running. This eventually leads to CPU
>>>>>> watchdog timeouts.
>>>>>>
>>>>>> To fix this, mask the gpu error irqs during msm_recovery test and
>>>>>> enable them back during the recovery.
>>>>>>
>>>>>> Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handling")
>>>>>> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
>>>>>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
>>>>>>  drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
>>>>>>  4 files changed, 15 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>>>>>> index 2c0bbac43c52..f1df2514c613 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>>>>>> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu)
>>>>>>                 status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
>>>>>>
>>>>>>         if (priv->disable_err_irq) {
>>>>>> +               /* Turn off interrupts to avoid interrupt storm */
>>>>>> +               gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
>>>>>> +                              A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>>>>>> +                              A5XX_RBBM_INT_0_MASK_CP_SW);
>>>>>> +
>>>>>>                 status &= A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>>>>>>                           A5XX_RBBM_INT_0_MASK_CP_SW;
>>>>>>         }
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> index 8b3bb2fd433b..9a4f9d0e1780 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>>>>>>
>>>>>>         gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
>>>>>>
>>>>>> -       if (priv->disable_err_irq)
>>>>>> +       if (priv->disable_err_irq) {
>>>>>> +               /* Turn off interrupts to avoid interrupt storm */
>>>>>> +               gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
>>>>>>                 status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
>>>>>> +       }
>>>>>>
>>>>>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>>>>>>                 a6xx_fault_detect_irq(gpu);
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>>>>> index 9e44fd1ae634..0f6fd35bd587 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>>>>> @@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
>>>>>>
>>>>>>         gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
>>>>>>
>>>>>> -       if (priv->disable_err_irq)
>>>>>> +       if (priv->disable_err_irq) {
>>>>>> +               /* Turn off interrupts to avoid interrupt storm */
>>>>>> +               gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
>>>>>>                 status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
>>>>>> +       }
>>>>>>
>>>>>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>>>>>>                 a8xx_fault_detect_irq(gpu);
>>>>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>>>>>> index 9ac7740a87f0..48ac51f4119b 100644
>>>>>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>>>>>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>>>>>> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *work)
>>>>>>                 msm_update_fence(ring->fctx, fence);
>>>>>>         }
>>>>>>
>>>>>> +       priv->disable_err_irq = false;
>>>>>
>>>>> Ok, so we rely on recovery to re-enable the error irqs..  that is
>>>>> probably ok, given the intended purpose of the debugfs file.  And,
>>>>> well, it is debugfs.  But why do we clear disable_err_irq here?
>>>>
>>>> Now that we are updating the IRQ mask register which won't reset until
>>>> there is a gpu suspend, its side effect will be felt even after
>>>> userspace deasserts the debugfs knob, potentially into the next
>>>> testcase. This is different from the older behavior. So, I felt it would
>>>> be better to reset this flag during the recovery, considering
>>>> msm_recovery is the only user of this knob, afaiu.
>>>
>>> Hmm... maybe debugfs writes should just immediately update the irq
>>> mask (if the gpu is powered)?
>>
>> That needs some plumbing in adreno func table to program the register.
>> We can do that if you prefer that, but is it an overkill for this usecase?
> 
> Yeah, that is why I didn't suggest it earlier.  But stealth re-enable
> of err irqs makes the behavior harder to reason about, which I
> dislike.  I guess it works now because msm_recovery only does a single
> hang-test w/ hw error irq's disabled.  But from userspace PoV it seems
> natural to expect error irq's to remain disabled until writing debugfs
> again.
> 
> Since it is about debugfs and a single igt test, maybe it is just best
> to document that this is how it works.
> 
> Or, would it be reasonable just to update the irq mask in gpu->submit()?

IFPC complicates this a little bit. We need to vote OOB to keep the GX
domain up to program this register. And I am not sure if we have any
existing OOB bit that we can use for this purpose.

I feel this debugfs knob is not worth any additional complications in
the driver at the moment. We can consider improving this when more
usecases show up. For now, I feel it is better to just document the
modified behavior.

-Akhil

> 
> BR,
> -R
> 
> 
>> -Akhil
>>
>>>
>>> BR,
>>> -R
>>>
>>>> I should have explicitly called out this new behavior of disable_err_irq
>>>> in the commit text, but I forgot.
>>>>
>>>> -Akhil.
>>>>
>>>>>
>>>>> BR,
>>>>> -R
>>>>>
>>>>>> +
>>>>>>         gpu->funcs->recover(gpu);
>>>>>>
>>>>>>         /* retire completed submits, plus the one that hung: */
>>>>>>
>>>>>> --
>>>>>> 2.51.0
>>>>>>
>>>>
>>

