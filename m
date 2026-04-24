Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EA1FED3C0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767A210F576;
	Fri, 24 Apr 2026 12:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3e478bO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ObGHVm/Y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B840310F576
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:42:26 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OCNreY4167383
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3jUS4BVvtxQ4TlCKv27nqabFS5yyU+r3C8dzKt76/V0=; b=D3e478bOH4/C9Hs/
 7YNC7YynmUR3IOUxKYiQNOhjxmU2kEg/Y05Cvi23HXY3Hde/0KhOOvgdTU0BKIML
 9BmKynKnk0Fp8K8kDUCENN3sTMAXwyhP10WIXcIBE/iaiId0f89zp8d8L2cp5OUs
 d6xL2hxVU332SWAOwTxy0o/uqgzh3qahZ4H2gdoKsRv+TcyV/TnqIH8WYg6x18YU
 QdffqgDmPuwFFR2uHcnTqtYJg/ZjGRH+f0v8nUCEG1T3ByDTi5eEk492urWPMAzJ
 u6QkRkYfO56smaSauV8bAxpMejKEHOlRIEZlyImceOsP3xt7M+ajmRSygrrSRuB4
 yrL02Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n1eh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:42:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35641c14663so9425387a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777034545; x=1777639345;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3jUS4BVvtxQ4TlCKv27nqabFS5yyU+r3C8dzKt76/V0=;
 b=ObGHVm/YPQ8gqtmhhomIPQ9hZB0bY1+L/AI9CjNy/2yNp5BpW168mDc7aMBUO3IKq5
 I/VBSNTDqF+uFE54WvvZ/Aq9c8cYXPUujn+7OYdsWXtSKGL3W8qd8L+WiGEtLSWFJwzw
 6rMCpvY8Nn8aeX/pG3uw4f9+pIU3vQifek3lj/6x5KXCJ7X3i+wLjgIjsYETdNdjw4r5
 4gh8E5TRqnLZSc99DY6xIbGI/4N4iezSBR5r4sQmPhX1HHyDFGE5UZ5ThBBVf3hVHD2L
 IuV6dKmYor9n76eNGpX5vdRSK6SROalZoMhE3/ppVMoBDCaLOMkVTvowtBG1UlERgqDR
 zcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777034545; x=1777639345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3jUS4BVvtxQ4TlCKv27nqabFS5yyU+r3C8dzKt76/V0=;
 b=mzN+D0cvfxZIy/a5mQ6uinR4G7klScizirGp3v0MjZwLf6Sj56XcQKeXB8iqsPRu0x
 OneJshtUDTMn3JsCHQbd+g46juIXPL3/JXU2I8fZ0wJKI3gQS2lhOWG+zMmFz7J7ohWr
 ivtnc2/IA+J87GjIhCZspXU3YvVnnQr/Ie0YSkDwLtFTDnkmGFAtIS/r8mUGjI4eEP5T
 3p29l4M5Ikn0qeH40XkGBfMeCeavESWnrPkpCcwhH6KQEmWoHvpqnNgAnl+HdwMR08lN
 gVRZyJYqjWVS2WCD1SI/2LJWnzdX61nI+4crDjtb6Dd4nXzHF+B/k6UtpKwkhGNVd5WJ
 7Pow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qEtX/smCXyvrLKXq4TWMLbZYovumvW5HnQ4vuHQOMT7XwsCiOT8Dcfr+rRIEFX3685Zj1fJdAic0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyciVPOFz1KM99t+uPRjOUklV7OROy9wvo0ud13KBFKjSwAV8C6
 GmuJAqEw1GTZmA1MK5vFeKrzm7qu6f49Pfpxrcik4/yJTXBSEsnHoDrBL2WugY9wGSMxZ1SaA3K
 ith2rAH+2H/1+s8owKLckbC8ncTAd4vUdO+NCklJkXkO+jvvS+vKQR7IILm66Tg6ozKT9nJA=
X-Gm-Gg: AeBDietAx7AaQOL3TexPd3cBcXzLh1MczPLqQQLI2sla52EwaEbMMnSVHeTWq8WpfLJ
 C2bU3uwbRG/SbDH3dy7OWLJNy8+j/zpFr+ZJokB6DF1+PWmDmKC5gFd6NfzmTUqtfAuzDeKmk9y
 Iw9g4e9w9aQ0D5q49b+AIHz0CrZFCs9yTx1n2BTYGEhiPeMOyy70nL8uHNSpYQGeC5w7/359evf
 Yh0DB3LA/d18QZrldRwSF1ChS8yI34jbmATcxRPJnu7eKZXpVjlZz/oAF48/bJVeeRbVpHxVahZ
 ntnsqOA+CgyAF3bdroFpovJgOElFE19JEDZ+knxkH4/fmiwDBWzVwdpPu/HGO7a95uLbr8nCSWP
 QyP7cVHIPBV9+ei/66jRh7FyU0ENNtu+VVwniOkSe0U2tEGCBMsa0Af42A8wh53oR
X-Received: by 2002:a17:90a:da8f:b0:35e:594a:5b75 with SMTP id
 98e67ed59e1d1-361404c1034mr32348898a91.25.1777034545182; 
 Fri, 24 Apr 2026 05:42:25 -0700 (PDT)
X-Received: by 2002:a17:90a:da8f:b0:35e:594a:5b75 with SMTP id
 98e67ed59e1d1-361404c1034mr32348850a91.25.1777034544617; 
 Fri, 24 Apr 2026 05:42:24 -0700 (PDT)
Received: from [10.239.60.18] ([106.192.26.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410b998fsm23315385a91.13.2026.04.24.05.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 05:42:24 -0700 (PDT)
Message-ID: <1e039dd5-da3f-19b2-ef98-29e64fdd925d@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 18:12:09 +0530
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
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2026042428-blemish-helpline-7d8d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _DSQwzlS0ZnCA5YQfwKSDV-HH6JdEX5r
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69eb6532 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=K3jt3zD9TrcZs+Uyli2v9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=fZobZ8Dl1N5RqnsFfjAA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: _DSQwzlS0ZnCA5YQfwKSDV-HH6JdEX5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExNyBTYWx0ZWRfX3RSsmRLZ1k7k
 +t9i1AX440yJrx0G0VKHVbRdQByyfJQr4DfdA1Wke2A5dZoRwJMKVU3m9Itk325CrWLRzaWD2r4
 xH3L4zQQXcUDfaYLlxQ+K39l3olOXXbwxdt7CaacDw4EtsCiGzG+YmCDlIdOHpOyxhTWkXaP69u
 vtFbyDUfuYFjLBWQ+diYoiHz1zZ6d6B50aq4oRJF0LEXZ1uHEJEuYSe22NIC1HXUsOcSQpdP0Bz
 bf4dCofSsPUNHSuhgFVRhQlxjrijQi2Sdyrd016MySZ/BV0ogFTdkYzcriwJwrMgx2Nt+kEkR6c
 a/3OsTtG8rjR1HJOs9WRvwELj8ecAxUjkU6E6Y3YVUi2KWXFvUSUggUj+AHJFp2Tkf5j5apfEo9
 ahcleDFSpNaUjRp7CVqJ8QYMaIQeY7d2n5MVeD1FySpfnkgNQ4NqXt0pCkLhCLxw7fxxHMs6TP7
 qVC7Nrm93yG+DU3C1iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240117
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


On 4/24/2026 5:25 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 24, 2026 at 05:15:02PM +0530, Vishnu Reddy wrote:
>> On 4/24/2026 4:43 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
>>>> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
>>>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>>>
>>>>>> When a driver needs to create virtual device at runtime and map it to
>>>>>> an IOMMU context for memory isolation, there is no common bus available
>>>>>> for this purpose. Each driver ends up implementing its own bus type,
>>>>>> leading to duplicated logic across multiple drivers.
>>>>>>
>>>>>> host1x driver implemented its own bus type to attach an IOMMU context to
>>>>>> a dynamically created device. The Iris VPU driver now has the same
>>>>>> requirement. Rather than duplicating the same bus logic again, a shared
>>>>>> bus type is introduced under drivers/base that multiple drivers can use
>>>>>> directly.
>>>>>>
>>>>>> The bus takes care of creating a device and attaching the IOMMU context
>>>>>> to it based on the client inputs.
>>>>>>
>>>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/base/Kconfig            |  3 ++
>>>>>>  drivers/base/Makefile           |  1 +
>>>>>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>>>>>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
>>>>>>  4 files changed, 107 insertions(+)
>>>>> as you can not have a device on multiple busses at the same time, this
>>>>> makes no sense to me at all.  "dma context" is a bus-specific thing, so
>>>>> please add it to the bus that you are wanting it for.  It can't be a
>>>>> generic bus as that just doesn't work.
>>>>>
>>>>> Or what am I missing here?
>>>>>
>>>>> And why is DMA somehow "special" here from any other hardware attribute?
>>>> Let me give brief information which was discussed, in the initial series,
>>>> the iris VPU used platform bus for dynamically created devices and we got
>>>> the comment/suggestion from Robin to implement a proper bus_type with a
>>>> .dma_configure callback.
>>>>
>>>> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
>>>>
>>>> based on the discussion, implemented the dma_context_bus and used for iris
>>>> VPU devices instead of platform bus.
>>> Why not make a irus_vpu_bus where you can do what you want?
>> Initially iris_vpu_bus was introduced, and it was made generic based on the
>> discussion,
>>
>> https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
> I don't really see that request here, I see a "make this better and more
> generic for other busses" but that does not mean "dump it into
> drivers/bus/ for someone else to maintain" :)
>
>>>> Here, the device have only one bus (dma_context_bus), not multiple buses.
>>>>
>>>> Regarding the "DMA" naming, the core operation of this bus is its
>>>> .dma_configure callback, which calls of_dma_configure_id() to map the device
>>>> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
>>>> purpose.
>>>>
>>>> I am open to suggestions from you or Robin or anyone else, if there is a
>>>> better or preferred way to achieve this, I am happy to consider it and
>>>> rework the implementation accordingly.
>>> As there is only one user, just make this your own bus please and do all
>>> of the needed bus operations for your devices there (i.e. don't hang an
>>> "empty" device off of it.)
>> The reasoning behind to make it generic was to have more users - host1x,
>> Iris VPU, QDA on the generic context bus, instead of each of them having
>> their own. Let me know if you suggest to have the iris_vpu_bus.
> But you did not add such users here, so how would we know this?
>
> And still, I have no idea what this bus really is doing.  Is it dynamic?
> Is it self-describing?  Why not just use aux-bus?  What is it supposed
> to be doing and used for?

This bus will allow users to create a dynamic device and map to IOMMU stream
ID via .dma_configure callback which calls the of_dma_confgure_id() based on
the user inputs. This bus is under the iommu_buses list to register for bus
notifier callbacks for iommu_probe_device() and iommu_release_device() during
add and remove.

auxilary bus don't have the .dma_callback and bus notifier callbacks where it
can do iommu_probe_device() and iommu_release_device(). iommu_release_device(),
being a static api, need to be called from bus notifier callbacks which should
be under the list of iommu_buses.

>
> still totally confused,
>
> greg k-h
