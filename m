Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC23FED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FB510E408;
	Fri, 24 Apr 2026 16:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTSqdamw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i3/Gq4Ee";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AA710E408
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:41:15 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OCgk0B1822923
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eltpKz/vHGzdVltnYjt3RwZNW4ucKi/6/+2SCBIudcA=; b=dTSqdamwixelTx2H
 ATfV1RW82rZYb+yMxshg5gurfKGBenY2S+4490x+DvVDwjno5hT+bINhtZv2zuoa
 p4bcdkR0uUEO7w8JRUTXuJM+V12dn/3GD7bRVab9LrGH4IrbzLrmtTQ9qRh93+cJ
 YJFuTzbrYPF2155OeQXvoesjaP0q58uxifPK1za+Ir5D4a3/XGwGZN7tw9HBdrcv
 6I+DtZdenGYWnjAKYHNvgAENWGMNyHXFWayBdyFZxRDAm4C6XJIk1Kopu0jw3yDJ
 QbU+kCBkpiSDoYyO03JXXlrnvby0iizFtV0/mlrtBr0Mgbf1WwtnE/CGsC+bF1rV
 UjCBUg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5ruupt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:41:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35da86144daso7911665a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777048874; x=1777653674;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eltpKz/vHGzdVltnYjt3RwZNW4ucKi/6/+2SCBIudcA=;
 b=i3/Gq4EeoPmOPDNEJBhBo8mKNm++Y3ccJ7jmcLtrFM8QrmX7llRxviRd/SV3zJa85z
 z7bXCHJlOZS3s3RLSEfT/eBIhR21YZn1yLLCjMCIQ0soJjVMjV6raghBA/uOHp1HlrE5
 WSo4w1dLXs+X3leGnxNGMdGJFkDYcCx778NHszOZmTF1DMtY2a96d3vQbm2usd31Sp4+
 Kupdj+GTLXm/RKp4u5va/nzkkHrnaHDhgQ9In9IdGb5SwfRDsGIUf8eFEDcIulzeJmdS
 OJbvwSaBu6bB8xx2wzAqgVchblb95D+r3DJwpDYFesQYuL6tDMHBRJGTLhMzDEA7sNaP
 ohyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777048874; x=1777653674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eltpKz/vHGzdVltnYjt3RwZNW4ucKi/6/+2SCBIudcA=;
 b=NS27HxjosDyZZxWeTFPMeiKRBz3tsyeXgD684gOFPHNva2sZqwKLcfTedNuGZPnmiL
 IhFYsCGzrqSTL0lBwmIjwfdrp4drTjCyRsMn2gcevbxJySUm6MSpHNzwuk7dBIgDCIPl
 ZesM1AyoYjWH1+g4md3Cr+PA1il4B9SiKRsJQSlKZe9LVTP4XxOG2jIEeqVy2r07aj2J
 Aq6EoGFypZPYHwq4cSgnGORq53QACAutyCRKVYP0MDgxOtry6kT8cpAPATpSKVZyJJOH
 vYvGsTASmtM/Zy78LdXQw8rHnTlTT/kYankgvUsjqCeZsMUaWibJFvoPJYRwBrZPHPch
 mDyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RsSYLVCS4c3GA66YTedVuVAxYlfKhKCY21T+zwHp2G/13hcHcGwnibv7yyew5YeEfbWsy48RR0Ck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDWTEaG5Xp0Z4c3BBorij8jPDv5VVNU8iOpRi88+AO3vJDZECn
 xigxYKI4qqtD6tPevmW8c2/86dhxXH4kiQsKIqSgFeYdjZ3H8kOTUlfJz08UMWpYu4PEaY6z/+v
 ujleIwW2H6aXVYBYcpZbyFedacUN1izAe/9CB27O1Ngr4fQvk3QvTqlepjni0uZvCCrVneDo=
X-Gm-Gg: AeBDiesa00IeE97weYcLkXv+qfA6YcCoUqtd4kqiQMELhgGpliw+miUzxbwSNW9NS3W
 LSpdgMVIlZbLqDtC2L2mX6Tg9bP/VdPBmEI1FGiS2mxGMj/QD9cqGzejtu7gHyYs0ofiaf6cwpw
 aK733GNkh8OdqQ9GTFSA5wl7kbZc8XbGMbOObPly8eB0XSXFjZFp27c2s3hTc/EoZB2IAyubqEr
 nJk6Wv4U51VQD6/FyhsdbsTm+E5AchpUHf82rJCYt89CWo+ofimVpPBufxop+ujsC/+XrSNL2wP
 QHLJKWA64AZV94WdTygfiOaNTwxgmrWqtDsNRTASz+A0yXkcmz666zX4EoMbecwkBl0aaGRWeUm
 8CBtgvHqgJT4Y36Bb2cMIi0BkrhWrTIFd+6+9kmNjHErE5NewcyKYWZYRnI8JGtl+
X-Received: by 2002:a17:90b:3c0f:b0:359:87a8:e65c with SMTP id
 98e67ed59e1d1-3614046c9f7mr32840176a91.17.1777048874066; 
 Fri, 24 Apr 2026 09:41:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0f:b0:359:87a8:e65c with SMTP id
 98e67ed59e1d1-3614046c9f7mr32840139a91.17.1777048873514; 
 Fri, 24 Apr 2026 09:41:13 -0700 (PDT)
Received: from [10.239.60.18] ([106.192.26.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361418c3944sm30414672a91.8.2026.04.24.09.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:41:13 -0700 (PDT)
Message-ID: <eceae566-93da-a0e2-cac0-1f5abdbbe661@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 22:10:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>
 <2026042346-trustable-register-095a@gregkh>
 <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com>
 <2026042422-deem-chemist-8d0f@gregkh>
 <4c3fa710-f61a-4aad-622d-54909190cb9e@oss.qualcomm.com>
 <2026042428-blemish-helpline-7d8d@gregkh>
 <1e039dd5-da3f-19b2-ef98-29e64fdd925d@oss.qualcomm.com>
 <2026042442-luxurious-antonym-f20c@gregkh>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2026042442-luxurious-antonym-f20c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69eb9d2a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=K3jt3zD9TrcZs+Uyli2v9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=TCXhiZJuOe0p4lytgSYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: O3FTMss-WizWg5foaO0hQ1GlmZCNMwgv
X-Proofpoint-GUID: O3FTMss-WizWg5foaO0hQ1GlmZCNMwgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE2MiBTYWx0ZWRfXzDx9e2uu7sNi
 ZqmzYlmNDGhaMIrpC7UoY+pexftq40xkpV+H7Q9iInBJ17IbcN7SGXm7KmQ4uxEEgPXe/R4/RIy
 7GxK5DQZ7bNlwnSHNtPmdie2kDtqaRbseLMKnA7AeMiy5osmIKOrfCsN0PYyVoNb0RL5YNcxsPN
 a4CCyFvSrOWGEeQCboxsoQstPoh442LitiugmNbUV6YlPxiUioqwwRVuWX/u/uE82WCTzd9IpRj
 aQg0FizGH1JIRg7/URT1YnD1H/IQMEX56Rq+I3+4/IJM+xhQQ5ugWNG4eDgc6UVh2f0ii+wFqez
 GNnPQvR6ifuU/A6F91yzXUuWPrrI1rL3Ce/8wDF3bkS6k8t0rng/D9RcHJRmTmCE1RjlUgSbtYE
 HYsKsgemcSbQ6feOXhZinglKwvcEyu9uXoByZfIvpUKWDRsp+cXliLKGM4b+5ss7kJHSmiVH2cM
 6MeBt0Dh4EEFRYymG5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240162
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


On 4/24/2026 7:04 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 24, 2026 at 06:12:09PM +0530, Vishnu Reddy wrote:
>> On 4/24/2026 5:25 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Apr 24, 2026 at 05:15:02PM +0530, Vishnu Reddy wrote:
>>>> On 4/24/2026 4:43 PM, Greg Kroah-Hartman wrote:
>>>>> On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
>>>>>> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
>>>>>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> When a driver needs to create virtual device at runtime and map it to
>>>>>>>> an IOMMU context for memory isolation, there is no common bus available
>>>>>>>> for this purpose. Each driver ends up implementing its own bus type,
>>>>>>>> leading to duplicated logic across multiple drivers.
>>>>>>>>
>>>>>>>> host1x driver implemented its own bus type to attach an IOMMU context to
>>>>>>>> a dynamically created device. The Iris VPU driver now has the same
>>>>>>>> requirement. Rather than duplicating the same bus logic again, a shared
>>>>>>>> bus type is introduced under drivers/base that multiple drivers can use
>>>>>>>> directly.
>>>>>>>>
>>>>>>>> The bus takes care of creating a device and attaching the IOMMU context
>>>>>>>> to it based on the client inputs.
>>>>>>>>
>>>>>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>  drivers/base/Kconfig            |  3 ++
>>>>>>>>  drivers/base/Makefile           |  1 +
>>>>>>>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
>>>>>>>>  4 files changed, 107 insertions(+)
>>>>>>> as you can not have a device on multiple busses at the same time, this
>>>>>>> makes no sense to me at all.  "dma context" is a bus-specific thing, so
>>>>>>> please add it to the bus that you are wanting it for.  It can't be a
>>>>>>> generic bus as that just doesn't work.
>>>>>>>
>>>>>>> Or what am I missing here?
>>>>>>>
>>>>>>> And why is DMA somehow "special" here from any other hardware attribute?
>>>>>> Let me give brief information which was discussed, in the initial series,
>>>>>> the iris VPU used platform bus for dynamically created devices and we got
>>>>>> the comment/suggestion from Robin to implement a proper bus_type with a
>>>>>> .dma_configure callback.
>>>>>>
>>>>>> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
>>>>>>
>>>>>> based on the discussion, implemented the dma_context_bus and used for iris
>>>>>> VPU devices instead of platform bus.
>>>>> Why not make a irus_vpu_bus where you can do what you want?
>>>> Initially iris_vpu_bus was introduced, and it was made generic based on the
>>>> discussion,
>>>>
>>>> https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
>>> I don't really see that request here, I see a "make this better and more
>>> generic for other busses" but that does not mean "dump it into
>>> drivers/bus/ for someone else to maintain" :)
>>>
>>>>>> Here, the device have only one bus (dma_context_bus), not multiple buses.
>>>>>>
>>>>>> Regarding the "DMA" naming, the core operation of this bus is its
>>>>>> .dma_configure callback, which calls of_dma_configure_id() to map the device
>>>>>> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
>>>>>> purpose.
>>>>>>
>>>>>> I am open to suggestions from you or Robin or anyone else, if there is a
>>>>>> better or preferred way to achieve this, I am happy to consider it and
>>>>>> rework the implementation accordingly.
>>>>> As there is only one user, just make this your own bus please and do all
>>>>> of the needed bus operations for your devices there (i.e. don't hang an
>>>>> "empty" device off of it.)
>>>> The reasoning behind to make it generic was to have more users - host1x,
>>>> Iris VPU, QDA on the generic context bus, instead of each of them having
>>>> their own. Let me know if you suggest to have the iris_vpu_bus.
>>> But you did not add such users here, so how would we know this?
>>>
>>> And still, I have no idea what this bus really is doing.  Is it dynamic?
>>> Is it self-describing?  Why not just use aux-bus?  What is it supposed
>>> to be doing and used for?
>> This bus will allow users to create a dynamic device and map to IOMMU stream
>> ID via .dma_configure callback which calls the of_dma_confgure_id() based on
>> the user inputs. This bus is under the iommu_buses list to register for bus
>> notifier callbacks for iommu_probe_device() and iommu_release_device() during
>> add and remove.
> But a device is nothing on its own.  You can not just have a random
> 'struct device' hanging out there that does nothing but iommu, right?
> It should be doing something else that is very "bus" specific.
>
> Again, why not create a bus for your hardware type and have that control
> the bindings of drivers to the devices, like it should be done.  You
> better not be creating platform devices for these things :)

Creating a dedicated bus for iris_vpu is indeed possible, and we had actually
explored this direction in a one of the series. A patch implementing an
iris_vpu bus was posted earlier here,
https://lore.kernel.org/all/20260313-kaanapali-iris-v3-3-9c0d1a67af4b@oss.qualcomm.com/

I'll bring back that approach. Before that, I'll wait a few days to gather any
further opinions or suggestions from anyone else. Then, I'll proceed with
posting the next revision with the iris_vpu bus in place.

>> auxilary bus don't have the .dma_callback and bus notifier callbacks where it
>> can do iommu_probe_device() and iommu_release_device(). iommu_release_device(),
>> being a static api, need to be called from bus notifier callbacks which should
>> be under the list of iommu_buses.
> True, because aux bus devices don't do that directly, they are "sharing"
> resources with their parent device and something has to mediate for it.
> So yes, you are right, that is not a good idea.  Make a custom bus type
> instead please.
>
> thanks,
>
> greg k-h
