Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0022CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 11:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1126A10E3C9;
	Thu, 14 May 2026 11:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ejb/PgHL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FW66UgUe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D96510E3C9
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:41:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeXPC2554582
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XN/svW0Jt+ncyOKlvvxZnVvpxXsVA9QC86tQ/FOEaIY=; b=Ejb/PgHL4Hh2Pyf1
 vLHN+/6ozUtuCdEpQMd9u4UOr8Kh5EHOCzn0MwqcUrMfF1KY1DfwLwQhvf0fOBmN
 K6qz1qRJQW/7HIfhRTqWXWJ5l5gxw6liZbpJ++KhhNssFQtj5lRz4rVOc65s67+U
 0NaDXs6dqMDYKSqJv2uUmMm4mbhbzHh7B2GIt/o7xyfoYxvUrnnaSkqy8TebPwrr
 NRFFRA/QI8az8+s+YIP1egAr53LTgGu1zaUkg8O8OEUUIQmq3qPBbsvqhUO6gMAa
 viClD+QsJeoZkuQrhA3ljtP3LhvZU/FSFnNWYUFgjq4kldA2KaspJpb4bn+/taxc
 b6ubig==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5b0brk88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:41:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b4654f9bb6so82254895ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778758910; x=1779363710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XN/svW0Jt+ncyOKlvvxZnVvpxXsVA9QC86tQ/FOEaIY=;
 b=FW66UgUeiJhzh5Tyx79wqlAaIjiJswH2dJbPiKQXgYVsMWvkR/ypNXrzG2ZgQ9tqg0
 LuNF6p4YjMFBZJdftTToNjM4U/mYk/lgUx2TKlvdzfOXOfLfdsLKxmL7UkAJeMkSTO6H
 ApQHzvAQ247N4C2k8G6ajXKceaInUPCtlXDQRS1hndredeSwnIlyWvvpkew9CHQYRmqx
 j87TmXSFMntJNZshuW25x514xGRw/RXPCRZ9UKGyKWIrEG07yZP+g9PNQ0glIhGntbZ2
 AWtq15S8Lp8U1SQX7Nl0oVoc8McitpMDQ7WtrLDOgUWiRSFgeMMx39zYFwNtv1EElWSv
 MT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778758910; x=1779363710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XN/svW0Jt+ncyOKlvvxZnVvpxXsVA9QC86tQ/FOEaIY=;
 b=QstdtLzf/+1/nKFloyBwRX833JI/TIzVWomLGEiGOkRhkMwnqU71dB/Wcg7BrUkycK
 1vdBOhhzMjpMLOBYYhaFyhXockbnSHFORrCl1CYDw0R40K06OEYp6CqXoOoBjDNynHdR
 A9hxZnEDs5p5jtVrBz1JJKLFHVV1hiorXjmYCDGJHSHEHI8yi/1MOY/xWoDKRXYsChcg
 qL7EGVZalDiRtjJ0iWbZ0+jcJvQzPqRGlGSFQ9UdzVDH1H8dz009hNKXnc/uoAVg/oaT
 DdZbOK23cwLDslNvSyuh6weeQVzZNziwYYq9QiGD9uSxe938vIWHfxZTY/DCzLYoCr9t
 S5fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z/xDwLKbd7DihmvsDNidVg/rJ+C0vioLpxA0OPEHNuu1NVMiIKhMmIgCjctPt7lEUyjcKI6k+/wU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO3CrZo86goW21MyuQFXaVhFfT9k5q81oPYwfGKQsvJ90c/iju
 ZXk98T4arf5PhgYKhuf73fpXRCPHjASqys6w+HcTmSPTQRlTciZK5CPaBs92R5iu9l5Z6GNIu3a
 qrY3vjFQBNQlLgJ/wz5H7CAQdj3NxsNmiyDrtzTCHfZG89Q5xSCXH61majmO/WdCIlCI3SlU=
X-Gm-Gg: Acq92OE2jcoPy4NHwy8xK/kYUdK3GIc3cnbZULEyVRhFrQ7Zy8LpUtvWRwGadh2+4WH
 VJjm3e/i7+3bPO+bFCguZ/Dqul1t+XonvXauOh/9JWG05Oza2noKzOYHikNJaRcCPoZEepR15j5
 PdIrCnRvMlHt/A7+7/InuVVOOoEoNwZJ/koilWXZM9bg+v5N8otGo/VjSpiMzpJgKZSCbcR4iSc
 4ISc3lofR+yvNcNPbl39kz3NFw8Ja564XVIbv6v9EIenXEQ3yaKnh/9EbSr7TLA5pzGZYhQ87Yq
 LafQ2QpGi8QV9T5KKzIcqvsgHF/tfV7iyq8HLXsZtTDBrUMcMGVtGp0Z/2Ds4JeZeMEGmj3qIbO
 IbaIqqUGRFVJAxQ/BanBW9O4bDUOMJOgXjDfX7joPJMG4hu+8BQ1Syp/DZ7SpuwTg3VWuCxnnVv
 bNq3OQDEnrbM70MlAUFZdUmeHN+4AP2GgSKsFBe1E=
X-Received: by 2002:a17:902:f54f:b0:2bd:7ca:e67d with SMTP id
 d9443c01a7336-2bd276dfda1mr85598225ad.29.1778758910267; 
 Thu, 14 May 2026 04:41:50 -0700 (PDT)
X-Received: by 2002:a17:902:f54f:b0:2bd:7ca:e67d with SMTP id
 d9443c01a7336-2bd276dfda1mr85597715ad.29.1778758909638; 
 Thu, 14 May 2026 04:41:49 -0700 (PDT)
Received: from [10.190.200.238]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0fd384sm24879805ad.65.2026.05.14.04.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 04:41:49 -0700 (PDT)
Message-ID: <5494a379-1e49-4551-a5f0-50d0bd7cd7d0@oss.qualcomm.com>
Date: Thu, 14 May 2026 17:11:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor Extensions
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 sudeep.holla@kernel.org, konradybcio@kernel.org,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, cristian.marussi@arm.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, jonathanh@nvidia.com,
 thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <436ce846-bd9e-45bb-bdc2-d2a0fd00dc25@arm.com>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <436ce846-bd9e-45bb-bdc2-d2a0fd00dc25@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDExNyBTYWx0ZWRfXxEjFvrhB0za/
 pvstYfgZGoD766EDo1HFudWXcUvUySjrHLEalIgTww6nfKvlExLQOY1+tiXMAsFWVy/88Jl97Go
 nrCNwY+voGmvguk1ZVDHAcd7eo7sLPP0AGG+kwO2XfOsVYaaxcIxZgF2B5aSkl1RUyLMsMGKAC1
 H2musfsq/yldkvxmsyCQPEh6N25szsdv17nIENbfbvMt95REYD6w+daft2L9enJ0p9saWCRHZjg
 gYO7fS+1HPoOPSjdGsz5nEp4M7crrbKI882qTVUF6MDN03VNUgFT+uz9zMx3TzDdUm7kvvmcpvC
 fMlB7ZZ/GfMKb34JuUoTI7f7WLGpsbqjBgTz0INzSciQgyBa3zBoStaoh3oNVC/At3fVCtGrdxs
 3bOVKINBtsLM0sfJr8vjSY8EtmfD956B5kmkw1jwYTngEqFA1Z5RqemMpGVoVz0RkO3EMzdLDd0
 mxCoD4mUHdaAGuIWtwg==
X-Authority-Analysis: v=2.4 cv=b+2CJNGx c=1 sm=1 tr=0 ts=6a05b4ff cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=2dUMNUc8cBhmsmHMSX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: gjQg41IOor11upeMibUgT7FFa5xUohD9
X-Proofpoint-ORIG-GUID: gjQg41IOor11upeMibUgT7FFa5xUohD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140117
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


On 5/13/2026 10:30 PM, Lukasz Luba wrote:
>
>
> On 5/7/26 07:22, Sibi Sankar wrote:
>> The QCOM SCMI vendor protocol provides a generic way of exposing a 
>> number of
>> Qualcomm SoC specific features (like memory bus scaling) through a 
>> mixture of
>> pre-determined algorithm strings and param_id pairs hosted on the SCMI
>> controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor 
>> and the
>> mechanism to control the various caches and ram is hosted on the CPU 
>> Control
>> Processor (CPUCP) and the method to tweak and start the governor is 
>> exposed
>> through the QCOM SCMI Generic Extension Protocol.
>>
>> This series introduces the devfreq scmi client driver that uses the 
>> memlat
>> algorithm string hosted on QCOM SCMI Generic Extension Protocol to 
>> detect
>> memory latency workloads and control frequency/level of the various 
>> memory
>> buses (DDR/LLCC/DDR_QOS). The DDR/LLCC/DDR_QOS are modelled as devfreq
>> devices, with the governor set to remote devfreq governor. This 
>> serves as
>> a way to get a basic insight into the device operation through 
>> trans_stat
>> and provides for ways to further tweak the parameters of the remote
>> governor.
>>
>> Transtat data for DDR/LLCC/DDR_QOS is now available in this series:
>>
>> #cat llcc/trans_stat
>>> From  :   To
>> 315000000 479000000 545000000 725000000 840000000 
>> 95900000010900000001211000000   time(ms)
>> 315000000:         0         3         6         6 6         
>> 7         0        30    143956
>> 479000000:         2         0         7         1 1         
>> 1         0         3       356
>> 545000000:         7         6         0         5 5         
>> 0         0        10      1200
>> 725000000:         3         0         5         0 6         
>> 1         0         6      2172
>> 840000000:         8         2         3         2 0         
>> 4         0        12      1188
>> 959000000:         3         0         1         2 2         
>> 0         0        13       272
>> 1090000000:         0         0         0         0 0         
>> 0         0         0         0
>> 1211000000:        35         4        11         5 11         
>> 8         0         0     21684
>> Total transition : 253
>>
>> QCOM SCMI Generic Vendor protocol background:
>> It was found that a lot of the vendor protocol used internally was
>> for debug/internal development purposes that would either be super
>> SoC specific or had to be disabled because of some features being
>> fused out during production. This lead to a large number of vendor
>> protocol numbers being quickly consumed and were never released
>> either. Using a generic vendor protocol with functionality abstracted
>> behind algorithm strings gave us the flexibility of allowing such
>> functionality exist during initial development/debugging while
>> still being able to expose functionality like memlat once they have
>> matured enough. The param-ids are certainly expected to act as ABI
>> for algorithms strings like MEMLAT.
>>
>> Thanks in advance for taking time to review the series.
>>
>

Hey Lukasz,

Thanks for taking time to review the series!

> Based on this description I have a few questions:
> 1. Why we don't use SCMI notifications for this purpose?


This is an attempt to retrofit firmware, that is already out in the wild 
running
on X1E laptops and Glymur which continues to use the same firmware, into
generic linux frameworks, so that it provides some useful information to 
user
rather than it being a complete black box. We already have a ton of firmware
changes suggested by Sudeep/Cristian that will be taken into account for the
next generation of SoCs, will make sure this is accounted for as well :)

> 2. Is it safe to assume that there was no extra frequency change
>    during that polling sampling period?

Yup, there is expected to be at most one transition of DDR/LLCC/DDR-QOS
per polling cycle.

> 3. Shouldn't we sample 2x faster than the changes that we try to
>    observe?

Yup, that makes sense. Will fix this in the next re-spin.

> 4. IIRC there was some extension in the SCMI protocol for performance
>    domains which allows to expose the stats like the one above but in
>    the shared memory. Why we couldn't use this? It would be more robust.

Same answer as the first point, since the current firmware provides to no
such provisions :(

-Sibi



