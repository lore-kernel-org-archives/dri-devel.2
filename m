Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC869CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2589610E3EB;
	Tue,  9 Jun 2026 13:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrhJ5WOH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qp6YQZjL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD8E10E3EB
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:09:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClQwb2286778
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 13:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HuwQP9SK5OUHdHSWZrC9uShH+8zqF8fHSldRJ1oXwnQ=; b=VrhJ5WOH8XwEK97T
 Q9wvwMaNd/7C3qdcy2nShlYYSMgDcvfea3NIMwH/vZe5Pj3dOmNjVZtM295uweOi
 6ynE2tM8LdufNz4DTU2i8Iwbql8QPFHCVCG+g0CwZ0HjYwlbdYO5lXh6xGHrP3Ho
 /F66nTw2THsss4/jLnJwh9jNeUmXUWxDVGrKBN9HNCxi3Bn1eiwYHhcd3vf3KxSO
 c4of+wqVHsglHbb6ucSSe598Mua39IGBoG+IBVsmtOujoWQe4JPnMfhvy4GPG9nY
 pvQc9vsIAQP9SadjCBf+dvsE9h/sVvzm99YZyH8zfx/s4JvlcfijCYM8O32oMva9
 YSqLkQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jrycv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 13:09:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d99629fd6so9178479a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781010541; x=1781615341;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HuwQP9SK5OUHdHSWZrC9uShH+8zqF8fHSldRJ1oXwnQ=;
 b=Qp6YQZjLWCpozsFdr1OPgc2DuduobXtRkgBtrFak8glY7BV/Er/VmqcWtesLRfffLo
 JqMvXCLZtxKsChP8l+01rI8qoP0+f8VHmO1Djxj2C75sN8jRQ0OVjMiQx3tBijf/v9x5
 4Y79OzIEPbM1/qt0eoH066AcuiUn+21+fnZRVKVLr70kw/07ogBP2B+rQMGzisbhDzO9
 emwidD7G+FIEdPyGiGABEehQVmxxzbY9l+UYihUPfGqfBq9zQ4ViB33gabO+6oWEKyvO
 9EZI/IRv6Bol7r8hdkEaEAHx4BdJ+IMGmz0v3y4JadZqZe15O12nNkGEmnOw0hY3N95Q
 goyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781010541; x=1781615341;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HuwQP9SK5OUHdHSWZrC9uShH+8zqF8fHSldRJ1oXwnQ=;
 b=EhRpVN/xqxKOp5a/HQwa8fhAXud6RZEqfYnmw/ijZ1euzjQSVi9b+XzwgX8NiieZAi
 r3Lwtav2XmJTgfiTup9l0IxwwTo8DZME1T8L5fE+qOdlUxQdDwnkdoCfey420Ydqat40
 ztpW4SVP0jef35mulfDEN0v1gYZFpMhUmEFbbATEQgMRiROqL20ntf5rcl8khZSenuVz
 Xd6BCXQufrwM4+dGl/xrFOfgARIJ/L8QScLWElJgoNRQZC73TN5Lu6NaPIt3D5hlG+Nu
 4GwIWpZVGEkTJMlVJCo+jvC7UNPBp2zb9+Jgxk51O9sd561PtI4t7+nQF4gomwL/GHL7
 G66A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9M9JgUcgmXlPqKtQSDN8mJ7R1Sxa4ZnPKYueWHgwfn0CJtpK8/7yCvhUAXMZzxk4YXb3IFGq4ggPY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKuTXLXx5lKZ0Zt6RrCpEf2WDDgTWMcs7td8wTxXlcFWycH0Lh
 6uF/PlYhURCRmiUdVOdsOB6AjnSKX78v1MMFLiQzqZJn4oztictwgzwc2GV6t4KrNDqtWrEgcAh
 A+xUSND87goo+kosOGXDTid0mX9EmHzr7RpI4etnSPF1lYncL9uhTTNonvZk1ANI7SBFx02E=
X-Gm-Gg: Acq92OEYk209Z3CuUC5Me8msaXKBO+3XzIvvIvo3NfBdKZnZ0Ucgfc77XcfB749rbYU
 sffr2EofCEZlnKSjAa+S36ooR7vkAU8MaBoCdn+FwSoFwl1VbRYwvz8RHyui6mxVkvhDpi/Aeku
 A2MOK7j6WsXBpoG6shNNc63UQhEHX6AWMVlvDrdEGXPuGMH32U0IiGZVWH0FG33K5mIZolC0KBx
 cdPG72rRw24dGZGkHZgYLxBGfsvio+WCZpooQGgXVBqzNss9uVv/o/GA7bigQ3+zFxyqWO7Wh6y
 LuZeFTOFZ/9NUSX+tfHVufAEgtMvg6PfY2krdbM2GJP0peT/jX3fT4JD2qakkt/UOxxefU8C+9I
 b6P17eQ5lcZFZ0+sKPEcdj8G8XeJnrah4dLg997ZIz/b532YomGO1aVeW
X-Received: by 2002:a17:90b:4fd1:b0:366:5c38:fd61 with SMTP id
 98e67ed59e1d1-370ef2f077cmr23445445a91.12.1781010541214; 
 Tue, 09 Jun 2026 06:09:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd1:b0:366:5c38:fd61 with SMTP id
 98e67ed59e1d1-370ef2f077cmr23445385a91.12.1781010540672; 
 Tue, 09 Jun 2026 06:09:00 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.228.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3712ef0add7sm13353137a91.0.2026.06.09.06.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 06:08:59 -0700 (PDT)
Message-ID: <d153235f-ffec-4fee-87b2-6008f26d7014@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 18:38:52 +0530
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV00vFNZDCN24wSdffZFRWpijb53qbX_-3b09ny4noa7-Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _dfhaNUBZUj3ygdDYLzqUPVjX_pe_Bbz
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a28106d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Q2jhz0oZVy1Wt6PcVz7aQg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=FicKLmBmdwvNS0eY_b8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNSBTYWx0ZWRfX0Fl5uh++cYrE
 kRGwx/P+qrz30vhttOjPPAknsIQP/jVgSOjX46HVZ4rAL6Kt/nzrMiWfhSoNx9tNSKukPYWWtcK
 AFdLSDt8vPe+lHRCRV7s9jQXt9l7wJBBnysGWlzaK5yTM6Bec6vBo0tugTBn5l5xp4mCGwpjcjF
 AcshFV+d5d3QblnUwN+SNZXFDVembS/EzD9q44iNVwAsPziGb+ZbyqSAPV8TU7HiPcfj04MzD9S
 j7VvxHKWK4dc6er40bsamD+98/8CMx5Qcxf16Tw+PLWCfBYYTXSu2bIFupPxyx+sn0Lpu6+Y6ij
 stFmKx4SBj2eDiQQFiWbfrIo6MRb3siqN5Uqaf/fEPQ80+uIhR/M8Dl1iR6bYC+1ZQlUOjgBxMx
 iz2L2IUJF8AdFlgKjG8J1EWunWvwnAt45wIQLXZzVCmJ1QB1l3exwPa5bp4bNIY329SXikAU7W+
 ae3DSh0P6wCJuRYOvPA==
X-Proofpoint-ORIG-GUID: _dfhaNUBZUj3ygdDYLzqUPVjX_pe_Bbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090125
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

On 6/9/2026 5:50 AM, Rob Clark wrote:
> On Mon, Jun 8, 2026 at 2:55 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> On 6/5/2026 12:20 PM, Rob Clark wrote:
>>> On Thu, Jun 4, 2026 at 1:10 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>>>
>>>> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
>>>>
>>>> Once a hang is triggered by the msm_recovery test, the gpu error irq
>>>> remains asserted and triggers an interrupt storm. In the worst case,
>>>> this IRQ storm lands on the CPU core where the hangcheck timer is
>>>> scheduled, blocking it from running. This eventually leads to CPU
>>>> watchdog timeouts.
>>>>
>>>> To fix this, mask the gpu error irqs during msm_recovery test and
>>>> enable them back during the recovery.
>>>>
>>>> Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handling")
>>>> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
>>>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
>>>>  drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
>>>>  4 files changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>>>> index 2c0bbac43c52..f1df2514c613 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>>>> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu)
>>>>                 status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
>>>>
>>>>         if (priv->disable_err_irq) {
>>>> +               /* Turn off interrupts to avoid interrupt storm */
>>>> +               gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
>>>> +                              A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>>>> +                              A5XX_RBBM_INT_0_MASK_CP_SW);
>>>> +
>>>>                 status &= A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
>>>>                           A5XX_RBBM_INT_0_MASK_CP_SW;
>>>>         }
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index 8b3bb2fd433b..9a4f9d0e1780 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>>>>
>>>>         gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
>>>>
>>>> -       if (priv->disable_err_irq)
>>>> +       if (priv->disable_err_irq) {
>>>> +               /* Turn off interrupts to avoid interrupt storm */
>>>> +               gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
>>>>                 status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
>>>> +       }
>>>>
>>>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>>>>                 a6xx_fault_detect_irq(gpu);
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>>> index 9e44fd1ae634..0f6fd35bd587 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>>> @@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
>>>>
>>>>         gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
>>>>
>>>> -       if (priv->disable_err_irq)
>>>> +       if (priv->disable_err_irq) {
>>>> +               /* Turn off interrupts to avoid interrupt storm */
>>>> +               gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
>>>>                 status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
>>>> +       }
>>>>
>>>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
>>>>                 a8xx_fault_detect_irq(gpu);
>>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>>>> index 9ac7740a87f0..48ac51f4119b 100644
>>>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>>>> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *work)
>>>>                 msm_update_fence(ring->fctx, fence);
>>>>         }
>>>>
>>>> +       priv->disable_err_irq = false;
>>>
>>> Ok, so we rely on recovery to re-enable the error irqs..  that is
>>> probably ok, given the intended purpose of the debugfs file.  And,
>>> well, it is debugfs.  But why do we clear disable_err_irq here?
>>
>> Now that we are updating the IRQ mask register which won't reset until
>> there is a gpu suspend, its side effect will be felt even after
>> userspace deasserts the debugfs knob, potentially into the next
>> testcase. This is different from the older behavior. So, I felt it would
>> be better to reset this flag during the recovery, considering
>> msm_recovery is the only user of this knob, afaiu.
> 
> Hmm... maybe debugfs writes should just immediately update the irq
> mask (if the gpu is powered)?

That needs some plumbing in adreno func table to program the register.
We can do that if you prefer that, but is it an overkill for this usecase?

-Akhil

> 
> BR,
> -R
> 
>> I should have explicitly called out this new behavior of disable_err_irq
>> in the commit text, but I forgot.
>>
>> -Akhil.
>>
>>>
>>> BR,
>>> -R
>>>
>>>> +
>>>>         gpu->funcs->recover(gpu);
>>>>
>>>>         /* retire completed submits, plus the one that hung: */
>>>>
>>>> --
>>>> 2.51.0
>>>>
>>

