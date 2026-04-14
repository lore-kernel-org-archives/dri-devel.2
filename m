Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E36F9D0D3
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D2B10E4CD;
	Tue, 14 Apr 2026 14:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifvB9RoR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgkEwsk7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A9610E34F
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:43:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EBAfGd2633299
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oPVV3v4VLtmByB3vAduvUEcC5XOVjKu7FaDLbHcwqQ4=; b=ifvB9RoRSHnIMU2I
 rK5FhIddHMU8buBnI91l/ls9FQjwVZvt0op5f2EGCvjkB2AHX6khDJimGZYHcCk4
 GyaV3fKHa5awMMj0Hqk67g3rjA4D5IugE6jDfBOTPqBJqcAeFLeM8jbjMdEf4dzz
 /A6/HMKtmU+WoJjhuJsyv6zP0QW7hA0iLEu8CL7iKuChZjy80zgdICMYhppDi/Z+
 RBNanF8gczNpB6C2GJS8uiGfmBxid64eIIfQ7CoCRq4vrMlSzsG+aH+ThRQ/aYUu
 xuMFEIKEr1a5049FGkyUdlGoiZ4aXiFZEehgx3YJBz6qJ985iW5gvoWCgOz7Qe87
 Umkh4w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86cb4kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:43:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a5bf7ee420so18257536d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776177783; x=1776782583;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oPVV3v4VLtmByB3vAduvUEcC5XOVjKu7FaDLbHcwqQ4=;
 b=BgkEwsk7+c0hjOA7R4wGCsXO/kpT752MpUTXytmjxjUi2TBbVvmdwVfq+O2caye2Eo
 NMAi0NI32UVH4cIbUEPg5U+u1V7oDK0n82iw0qWmfFR47Yql4pxXttB+GrhFMzL0ipFD
 J9JNrY7DzgpIMIXl1vcqg9RHesdEFNDX7Gem0y8+xdccdolC9tqomYiCXRKqx5wBzsU3
 u2/XTAY2/euIdfOiaztnmLpghEgYWv8ficMqMZV6qxiY50Hr1pwHovR4r168HkXc9Ek0
 tKUk4TcgdiYyFZLCc+UVxK0dKy8KObY9Wv/R/AroJT0TzGdSunwlvye3yAztwbQ9o9wp
 P/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177783; x=1776782583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oPVV3v4VLtmByB3vAduvUEcC5XOVjKu7FaDLbHcwqQ4=;
 b=N42eyZEsZZrEVz0EVQ7xKNrMUKqlyQHunBzkt2VYE/irCieW4CfSuzg36DGkqFl4+3
 oEXvtN2aBu6ECVXqPvJldT4DW879rxuM1Yy/SKVdW6tx4QO6Aw2Y0+n18CsXHnrCymvy
 TOIv406ZL/rjJ/fkTlbwyuFrO5CpMTReWuiN8IX1FjWZn/ILp9IvoI8JAr45LrKZW0ag
 6hH3fMCXlnI5smMYcpEqyoOR0UhsClD9JLvAueC6/ThfTZvWK1+h5/DyWlmkrYnghGv6
 DqTRsszJza3tjb0GsdczoW79aXnavgGcWq2ANdDkdyNn3tntc/7UysAbZaVQqV/t5Yh2
 WyaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LTrNZ0nrydTO/TdM3TKqgL9jIruQRwcs9ZSeCLFbsIq0v04obD4JBV/BuuiLv662frL66589BXHM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxII+Hu8Zpn0RNg8BF2l0a4Bu9KRvUplxKVCxY+kLOYCWKTXfdp
 d/KB99tI0RVErn61tvSzKIEU30CEfY6+QE3ZYBXcCz2YfS3Q3ZEbMG/kNUHsSmamq+LNDhVbbcr
 OxogKNhw0pEYTAGgfIdbiDyohk/w3iJ9W9utLk8cooGdtBiGKvBz3UUBvAIp50P37NUzSOSA=
X-Gm-Gg: AeBDiesCfYvS7POyV2dUXs0YBy2K21tCyfQ/B/RHgzmTuoqKl/vOTYjKmr/J1+lMeR3
 H75pT6ZESE1LkhmgzflFi7Ksqd8ZB/gGSJWJ8khI9siH8v7Hchisg8L3KtVlreLhVPyi8g3nGuB
 g877cXYAekoLpjzzWIS4icZ0ISENSQ3Rshw7Qf4Boc6X//PHJRBDe/dXrfFQhTZEHRJ2OGm/3cg
 OFPhFxjwCOJyrfQwqHquKxFtaUnlozHTVvXU2ur9qff7N3hCwgyYGWLiRVPShsKJAax6wyMrCSK
 PSTyMmaMULbVFeJxpCkUbR6aPdV49faRKRh10mlbI1fTxxaqmTd7BbEaP/G+kiRoT+q+6ZKOzU3
 bxXONm45K1aKSYbUv4S9W0UQIQittRGU65g+Vnzuin2ntttALTjQ4vR0RGCQFNvY0ruHVu5CzY6
 aqScYIsJ3srZl+SA==
X-Received: by 2002:ad4:5cae:0:b0:8ac:a797:ba39 with SMTP id
 6a1803df08f44-8aca797bff7mr104569116d6.2.1776177782497; 
 Tue, 14 Apr 2026 07:43:02 -0700 (PDT)
X-Received: by 2002:ad4:5cae:0:b0:8ac:a797:ba39 with SMTP id
 6a1803df08f44-8aca797bff7mr104568256d6.2.1776177781912; 
 Tue, 14 Apr 2026 07:43:01 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d6e5c54d5sm413465566b.41.2026.04.14.07.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 07:43:01 -0700 (PDT)
Message-ID: <8d7baebc-db38-403e-b724-d4b214b5a51a@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] clk: qcom: common: ensure runtime PM suspend
 completes on probe
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-3-4bb5583a5054@oss.qualcomm.com>
 <c72e02c7-57d8-4353-a6d8-9dbf4f7a7e37@oss.qualcomm.com>
 <38aa8c0b-fb29-44c9-a346-363220264c7c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <38aa8c0b-fb29-44c9-a346-363220264c7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zkp-CsHanfCctNj2qBc5bN_f7kUU_9ZD
X-Authority-Analysis: v=2.4 cv=RoH16imK c=1 sm=1 tr=0 ts=69de5277 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=sSUgItNeZYVuX0SKOHkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzOCBTYWx0ZWRfX8l+I5ZCZLzbd
 yjiXrp7d9n9bu1VLhKNKNDNycPxy0cy5cud9K8IrRHgFwXQTOIK2JGqi9jAhmZMYNLgaOE6ZhXu
 bHzmUS0AxiBg21VrMqj4WLEvkQ2F0G2cAPDy5MCS1iZswc7dD7ZWXPXwLY/nAOafPgSScp+A6hM
 XsBB2KIb4vGGxzfQOfHy24D/koXS+Xi7zMb1Ly+A05tZ45Ty8k+5ZMQCLxj1Kw6/lIpkVXxKr+0
 j0+MFcRjvuoW5R1SqkT/ruwmsj4K5z6Q9xbbY781VijSp4tjEv/zJ2uGj07GmPbx4UzcR/5IVwj
 tsGvQC/h1mevPXKc7JMYdNFBqSxy4Q7BfSQAdW5jW5NeNY10b++fwXciKML/nWVSP/+un9i3KCn
 ioEHSwEdkF8z8lNT9nukSjWFSsz8WjST6yiE73EUpvyHBpfmxV1fJ83SSbR2c6vylIDlmMKIqXq
 I5LmndXQndfdSazEPvQ==
X-Proofpoint-GUID: Zkp-CsHanfCctNj2qBc5bN_f7kUU_9ZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140138
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

On 4/8/26 9:26 AM, Taniya Das wrote:
> 
> 
> On 4/7/2026 4:28 PM, Konrad Dybcio wrote:
>> On 4/7/26 11:30 AM, Taniya Das wrote:
>>> When the clock controller is probed with 'use_rpm' enabled, the
>>> runtime PM reference is currently released using pm_runtime_put(),
>>> which may return before the runtime suspend has completed. This
>>> can leave the power domain transition in progress while the probe
>>> path continues or returns.
>>>
>>> Use pm_runtime_put_sync() instead to ensure the runtime PM “put”
>>> completes synchronously during probe, guaranteeing the device is
>>> fully runtime‑suspended before returning.
>>
>> It's not immediately obvious why that's an issue, is there an
>> observable problem when the transition doesn't complete in time?
>>
>> Konrad
> 
> 
> Calling pm_runtime_disable() immediately after pm_runtime_put() prevents
> the runtime suspend from completing, leaving the clock controller active
> and the HW rails in the ON state.

Please mention that you want to do it on a clock controller device
registered through this function, because currently it doesn't seem
to have a functional impact on the existing paths

Konrad
