Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71405CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAC610EBA6;
	Thu, 15 Oct 2026 10:29:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79237112286
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:29:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jgZF1955865
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OmbFgJmvEHXwXsxMN6rXgxgcJ2kmAcWfcjuPvuxBd9c=; b=FKmpnYOLCBDgEO5q
 HladjQqGKeXKLtdGw32wme9wR70WmcihhqlJHo/qgxCGfrapBp9t502egD93FLku
 nLNt44t4DIG2F+0En6xb4kN9346Ek7YqrN8nIEBZlAqvm6o1AG0op3kj57UUYzOw
 E9v1bwWardp/3KAB6fps9gEoNPQrZTTfv+8Y8ToZj08kZGxIVJzvYUkt3PV3PmQw
 zmVocD0nwLPkz8Ebwmsed9++xV+5T9MPPZyxpEnOMUTxxO1rrmo5knNfcKXJbkKp
 130A8O/LhiMOAmEQNqwXzyyO/BIMuyYBHth7TxtAvKO144GwnQX9HIOFyLc6v10+
 jwqCAw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdetcqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:29:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so6774103a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792060155; x=1792664955;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OmbFgJmvEHXwXsxMN6rXgxgcJ2kmAcWfcjuPvuxBd9c=;
 b=hbYvBT0/t0kgyeLJwg5pTl5xoA9W58Uzk4Ff/HWV6GR+TNTBrFSz2v4buOiNpJOYvE
 uQ8pSgkBqiOV6jhWks0oYZmqruQ08O+rsdDY1g/EZLf4agyVlAe0mvWsaiRHWHXTqYhc
 8HfgajXgFjNQQfn1b9OE9hq8y41fB21w/A7Wtn6quAvGUriYY41UnovdQ01HGMjxr9nh
 aBm4EEprz2AoAhq+g8Rtc6ZIN11PqdoHR18ptHpqB00ILNU9u59GS4JQlE91aL9D5B7p
 0+n/melzkW6LUlgtkpQ66NFm6sz17fEyeBaIObzrNoV0oCSXvNu+qmeRv8dnWlq50ku/
 K12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060155; x=1792664955;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OmbFgJmvEHXwXsxMN6rXgxgcJ2kmAcWfcjuPvuxBd9c=;
 b=bcSqnDwXzhTIxbIQjAndW+5G/h5iXdaQsOoG8u6Mk3J0BQ41hFas8hm3Jrgr8JfemN
 hyaePUpTf2zHRNofMqwUUeOjioyWyYR3PVBsARNhS/5ciPzuuWtXvenOHsZk5hh1HVJD
 zaXaFxT9EmG+gfeja+irmbmGbpCyvPClascAnMabLPQ1IdTxPoJEdWcqa8capVlwNhz/
 tY4KVktXEyzAO1ZP7i8gZzPSqNZQw+KxAkZHWdXAblmBMG5lhTtxj8rAM1kY7oZGNFTq
 /vzQoLiQBbvFicsklYV+xXOoWTKUncCALEd57429OV6pD6p2QHr58uKd1GrafiQI1gSd
 Jd7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCNWMBNIddEsqRWPtHvzD1L5ySyEnF2Z5G4+0VVPE2Ez/7hBZC/AhNKS7U79SYQ6VhjqYwLLGbygE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3Ry7/Yeqc07xKCKCJDuY1XH5b5t7HGaV5lRu8XkQNmVcAnr1t
 yfzSTiRc/OTRZrukcjepz2yASKeSikGsbNlzsmhO3bcsn/zme5rh38OGJU/M8I43D9pke4lkRdO
 9JoVup7zsXgzDHytF8Rdjzw1hSCAyLOIZyCvL9mL8jBpaN9NaApw1WVCLXf/YgfvNeGeul7c=
X-Gm-Gg: AYBFou0k1b1/O4/GrNc7YtQBzeaXnofWLxONB3ydguRBpnfOcw6QLQmQAcvp/txJlx0
 /iDkRBfIulGAmZBqlQtrj7kmz3RY6wzMUVeR6UclFYhFHUspEAi0RsnUtL8mRytJ5NiWc4IXYlB
 Rc9ginowLELKkO4wWXp1aunJzO91HMZT/FZO8AMCyLJD2TAV0zS7DgTwkN5m8r7dYXV/+4rr09j
 Jjz73ZZXyZ1v4UBFyDSzu4eqj9GOjd0hkLyqoNWDwKmW9CHc6kGtHyuSMbjMrlX9U+PHjTaNC6i
 ng5ZDAu7P/0d3SLI/iI6DuslL2lOKKDs3Sl3GQdgCoETDNW4prXbzKA7XS2FYxZwr9eBwXq15th
 1dhT0d29ZD1JajObznKhYB+I7AV4=
X-Received: by 2002:a17:90b:134e:b0:3ac:9259:1234 with SMTP id
 98e67ed59e1d1-3ac92591527mr2146601a91.39.1792060155112; 
 Thu, 15 Oct 2026 03:29:15 -0700 (PDT)
X-Received: by 2002:a17:90b:134e:b0:3ac:9259:1234 with SMTP id
 98e67ed59e1d1-3ac92591527mr2146578a91.39.1792060154527; 
 Thu, 15 Oct 2026 03:29:14 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac945e74bcsm3856778a91.3.2026.10.15.03.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:29:13 -0700 (PDT)
Message-ID: <3bec0e74-3f69-41a8-907f-983becfc8914@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:29:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/35] drm/msm/dp: add support for sending VCPF packets
 in DP controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-12-4b81473185e7@oss.qualcomm.com>
 <20260929045000.55AE01F000FF@smtp.kernel.org>
 <t3klzrnzq3oicg6djkv6ixwy6oteo6c6zvnpddbqk5pjhsodoh@qz7pcou23no7>
 <f7e864e9-8500-430c-8f02-915a162bd2a2@oss.qualcomm.com>
 <rd73b5ovrmqlanussaj5cugi4fx5yzuvwam2kzcizdiusmxzib@ko5xasxrjrzx>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <rd73b5ovrmqlanussaj5cugi4fx5yzuvwam2kzcizdiusmxzib@ko5xasxrjrzx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0aafc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=pcNVBdCq2x3xfCSnuIwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: p6Rm9BuGaN28f4b06VhyIMAIgm1y9kMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MSBTYWx0ZWRfX0VfGRWdHNTX/
 Vd8kwmwht6XhLoXVlzXswc7ySk6561NogsDUjiGJS1x/tKtq+Zmsgh+wi8m3AMWfGkL57CQ1aIl
 qTLnayJjPs7p4gOTDrRSqGUv9hDs1wP0FM5IH79rrNSkVUQFjDWeOTiiTL4aWLWTVBpJ998Ulc8
 Cyuw5QfoseNLUcHo41HKRlBUoeqxXlUnDq0FRQeMtQBA8xKB1rLF5nJewFH/zxFcjnaqxfARMPt
 Syz+k6b/S18pWa6gzNzV4anbskX6nI2AdpGtZ2LtitbX+9yd2/vtTYxU037EjfsxLwgIWCJZag/
 ugDX4rICw+NBSaVzIziFZR8vnrv82VcOCYHlIHZXQu3Ry+1+NHRvIf55lP1v2QsBtTWRx6g3Idy
 g49XBh6ASuIV/TC1KrPHdiavRoRJ8chtBWj7GSdfunCVTKWGqjIgxUxlpRIcBq+cCIxnTDvPkPW
 dYk3aNAwkUocJI5+dzQ==
X-Proofpoint-GUID: p6Rm9BuGaN28f4b06VhyIMAIgm1y9kMl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MSBTYWx0ZWRfX22JWCv6MrD2A
 6qIiZEtUEJx9CjHijOYdTRtyK+//9yS6j4fWHIdf+5ihIP91ZbMXWC3xYWslBMPzSf5Y1dwL6Gx
 yqw+np519pkk+sdOtOJXJxRxcTMsmfY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150041
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



On 10/12/2026 8:24 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 12, 2026 at 05:08:53PM +0800, Yongxing Mou wrote:
>>
>>
>> On 10/1/2026 6:34 PM, Dmitry Baryshkov wrote:
>>> On Tue, Sep 29, 2026 at 04:49:59AM +0000, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>> - [Medium] drm/msm/dp: bitwise OR of STATUS5 and STATUS7 without masking in ISR
>>>> --
>>>>
>>>> commit 987123505b6cfcc4664c72feae6b070ad91b79a8
>>>> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> drm/msm/dp: add support for sending VCPF packets in DP controller
>>>>
>>>> This commit adds support for sending VC Payload Fill (VCPF) sequences in the
>>>> MSM DP controller when stream symbols are absent. It introduces interrupt
>>>> handling for streams 0-3 using the STATUS5 and STATUS7 registers to signal
>>>> VCPF completion.
>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>> index 9a0c9737e6d00..929e0f94f8ddb 100644
>>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -2801,6 +2877,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
>>>>>    		ret = IRQ_HANDLED;
>>>>>    	}
>>>>> +	isr = msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
>>>>> +	if (ctrl->num_pixel_clks > DP_STREAM_2)
>>>>> +		isr |= msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
>>>>> +
>>>>> +	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
>>>>> +		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {
>>>>
>>>> [Severity: Medium]
>>>> Does this bitwise OR of two different status registers cause false positives?
>>>>
>>>> The msm_dp_ctrl_get_mst_vcpf_interrupt_*() functions return the unmasked
>>>> register values. Since the values from REG_DP_INTR_STATUS5 and
>>>> REG_DP_INTR_STATUS7 are ORed together here, bits from one register could
>>>> overlap with the VCPF bits checked for the other.
>>>>
>>>> For example, if an unrelated interrupt sets bit 18 in REG_DP_INTR_STATUS5,
>>>> and it gets ORed into `isr`, the condition will see bit 18 set and assume
>>>> it's DP_INTR_MST_DP2_VCPF_SENT (which is bit 18 of REG_DP_INTR_STATUS7).
>>>>
>>>> This could cause a spurious completion of ctrl->idle_comp during a VCPF push,
>>>> allowing the driver to proceed while the hardware is still executing the
>>>> pattern.
>>>>
>>>> Should the return values of msm_dp_ctrl_get_mst_vcpf_interrupt_*() be masked
>>>> against their respective VCPF bits before returning, or should they be checked
>>>> independently instead of ORing them together?
>>>
>>> Please respond to this comment.
>>>
>>   Thanks for pointing this out. The issue is valid, and we will fix it in the
>> next revision. >>
> 
> Please respond to other Sashiko comments too. You got a review. It's a
> nice practice to respond to them (unless you agree to all of them and
> are going to fix all of the findings in the next revision).
> Thanks for the reminder. I'll respond to the Sashiko comments that need 
changes and address them in the next revision.

