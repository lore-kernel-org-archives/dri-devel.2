Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDFEFE520D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C903410E3CA;
	Fri, 24 Apr 2026 11:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEErPifd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LQP3oDLa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E29ED10E3CA
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:45:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O88H5o4012159
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vKD+oIXo8r5i+72tQbUpEkekMjtbIYtq2yZlf7mfgso=; b=KEErPifdYn4zic/W
 +0SI2Cxb09hK+xb2nh4J1gZerJ3aNlQnxYHaQlbgVa08VCXZ+4T54lQTHE8E487F
 cCSzG0BcBokq8YT3neEZg7zNGhuQlxJR8iVdmo92VrP6mRait0WrN0DJmPMuFfaH
 yjSA4GIed25xK5BkjbDiwWinSrGkrsqst/ZysXd0TZoXuXNBO0hKyZxC9t1JcGL/
 OEQxmiKBTTihMWypvZa9l+Be22bVLesE2xCwtkcIokiB0+B+CY5Y2piY9RdblTSI
 GGmX0WB879Um7NO/Q+CnSgas3JjafGv3s2uw0iEA27A59O2a5BNOU8pikUrxggCf
 QzzUEA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpq9v8uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:45:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c79281bd14cso3086706a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777031118; x=1777635918;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vKD+oIXo8r5i+72tQbUpEkekMjtbIYtq2yZlf7mfgso=;
 b=LQP3oDLaV9ATKOcGbzsIZEHb8KENfvx0v6W2qRkw/TpwAuoB9X6yBZyXGO/yao3zrW
 vCezhx5S5TR1VzYVoVXTc05tNZZH4nVyC8OEjkMon7dY90sL3Ggs0xSesAe3Jdt22rOO
 MpoAiCjE84sjfKqcxFPnLq3lYOeVUFOJvqZAQqA0eL2fePDBULN82UHVrIv6dhaJtYWq
 ZqTfgEJdQiKcEKqhwQTXD38pEL9IvpG82VusnhjXPdnPKs4mR5RJSYGAZ5qbmS3B+cry
 OL+92OsQxmqZgm76aBSPHSaT2Lhof71040yq8Zqbh7q2o2/Ovm9hVXMv8T/EW34O4Q3r
 3tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777031118; x=1777635918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKD+oIXo8r5i+72tQbUpEkekMjtbIYtq2yZlf7mfgso=;
 b=Lv/mjnw8ig5VvMJSoAOOJPm/s0044Uxj4MG11nHei6Twe4y0KWN5lesiLaDxHGqJcI
 fM29WOongk/zp1lA9E7y3rpUY+xXbzdhyaec79Az1OKp/Lz6lKRHLRLVG39erXohzNHD
 DCTECQh+VvDUhRnSoKBcHZ9i+TQXGUhv97zBFNHjQowbL4aOSqxLRGSbqb3kGLjH724d
 3N77EbMDpM/zZDxaWkvuvMWaDGBiYCTTl7z9bFjTIIqMPCRMgFyJyZEqX/vUn8w4/2TC
 N0mVnJbHK3e9C9bjJjUNMt8q6lAjXlrjUpilSmJQKWnQWDlt7S1COiZoL5UYHOGXzIa0
 3/zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uxAAJ2JHeb1wWMFT7IMFIzWwatFBcrTKfNKqO3LGoplUQNRSfklqlDf/xwDZLSvqbILKPJYKrYks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwCzRrWPuaT+0rIgUPrl4i6TTFLOj46mqG76WWd9prb0a4+86W
 p7HbxglIzAr8wq49iitY1yituw+DpS8vGhgE2SuvQVEzMZJQaGes/qZxz8kqLREv+x0JyHIvCvt
 blD9Tuu6NRjSGADONtI7pECi5jCBJuMWcEKBMS5ANZiBcDqlR+QdA3F6gntFg7qjTyaXas6I=
X-Gm-Gg: AeBDiesjQtNG/nGrcbG1RNmLd9x87NyCMP2W7K5QsLnoysAWUZBlg4fZRsjUfVvmlGK
 iEDSj7zfP8u/YJ3lxVIA5B3uFg5asfPPl0GcItXaxT9sbkvJJ84DXBF++tPGPJL98hw3tlRvMeZ
 0xaTu1JjXGIM2WKvqBIzLyKrurAu4DQsffFyQV5yUVufpu0HAV0m44oO4NCcx4mjodXf7DdL8h8
 6I0BBVWvLURQ1lubnzBx18V1D93RWuLVS/8Nc3LcNECC+9Jig0RIhxHI/fJqq7FwL6yeb/EBWKh
 tNESPLGCkDKMNAFB7T7laSCa9xcziL9QoAzsiB5q5YyLzm3kVHRoFdcCjsrRO4H6spyYE/Q19Ep
 DjFguHHBj1DhX1DNGNR7YBX2VaklQSSVBvRQhdX1iXkXQeYJ9QHSSXw5hmSxm7L9s
X-Received: by 2002:a05:6a00:27a8:b0:82f:18fa:1668 with SMTP id
 d2e1a72fcca58-82f8c91e3cbmr31091392b3a.44.1777031117657; 
 Fri, 24 Apr 2026 04:45:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a8:b0:82f:18fa:1668 with SMTP id
 d2e1a72fcca58-82f8c91e3cbmr31091150b3a.44.1777031115048; 
 Fri, 24 Apr 2026 04:45:15 -0700 (PDT)
Received: from [10.239.60.18] ([106.192.26.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec04448sm27904931b3a.55.2026.04.24.04.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 04:45:14 -0700 (PDT)
Message-ID: <4c3fa710-f61a-4aad-622d-54909190cb9e@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 17:15:02 +0530
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
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2026042422-deem-chemist-8d0f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMSBTYWx0ZWRfXxncBJ6H6fLBG
 KcB1RckVjvsgXIOM/wgMaNocc8r6/1XkTA/AXf7z3RcK5SjGnKLtGsvNZqW3/9/RAH8WbxWrbk1
 6LAaS/yVQrgdj/gwBB9FKecJ0eSZq9e/zUR7cAdFR9GP0pBAcnBsN2oIB2l9Klo1sGDoLnweSKF
 JOYWWwe05f/veElJVUUmxzRtxuQoVTb/+Sqqd5VjwuWZvMgCtqlrv34oeMepbpkHT3BYZ5t/kkt
 yKdAPjSpGbi9ysEr/MdqTY2MA9lgsLUdkcOqdGJGpUQXFov2ufkGtUaT9afVxIObRFM6t3Vfqn7
 8HYgPOCsbNICzVXL4dxaumJIlVIXjs+Yarme4m5AGsXqOH/TtZ4HhQjmyQwRunQuVCyI5XLcdsn
 JudmzVlyaMEdQ4cv6rfRO6NI8MlVkeuV937Uy51DRP7EroZZkWKB1VfQJ1npi3BatgHzM+P7MfW
 Qr4/JbDI9g6YHgMwJCQ==
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=69eb57ce cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=K3jt3zD9TrcZs+Uyli2v9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=qtrQGJdHBaugJqU6AYUA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: FqZgzrJEvgKa6YkX0E8AUYKUlhZywSKi
X-Proofpoint-ORIG-GUID: FqZgzrJEvgKa6YkX0E8AUYKUlhZywSKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240111
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


On 4/24/2026 4:43 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
>> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>
>>>> When a driver needs to create virtual device at runtime and map it to
>>>> an IOMMU context for memory isolation, there is no common bus available
>>>> for this purpose. Each driver ends up implementing its own bus type,
>>>> leading to duplicated logic across multiple drivers.
>>>>
>>>> host1x driver implemented its own bus type to attach an IOMMU context to
>>>> a dynamically created device. The Iris VPU driver now has the same
>>>> requirement. Rather than duplicating the same bus logic again, a shared
>>>> bus type is introduced under drivers/base that multiple drivers can use
>>>> directly.
>>>>
>>>> The bus takes care of creating a device and attaching the IOMMU context
>>>> to it based on the client inputs.
>>>>
>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>  drivers/base/Kconfig            |  3 ++
>>>>  drivers/base/Makefile           |  1 +
>>>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
>>>>  4 files changed, 107 insertions(+)
>>> as you can not have a device on multiple busses at the same time, this
>>> makes no sense to me at all.  "dma context" is a bus-specific thing, so
>>> please add it to the bus that you are wanting it for.  It can't be a
>>> generic bus as that just doesn't work.
>>>
>>> Or what am I missing here?
>>>
>>> And why is DMA somehow "special" here from any other hardware attribute?
>> Let me give brief information which was discussed, in the initial series,
>> the iris VPU used platform bus for dynamically created devices and we got
>> the comment/suggestion from Robin to implement a proper bus_type with a
>> .dma_configure callback.
>>
>> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
>>
>> based on the discussion, implemented the dma_context_bus and used for iris
>> VPU devices instead of platform bus.
> Why not make a irus_vpu_bus where you can do what you want?
Initially iris_vpu_bus was introduced, and it was made generic based on the
discussion,

https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
>> Here, the device have only one bus (dma_context_bus), not multiple buses.
>>
>> Regarding the "DMA" naming, the core operation of this bus is its
>> .dma_configure callback, which calls of_dma_configure_id() to map the device
>> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
>> purpose.
>>
>> I am open to suggestions from you or Robin or anyone else, if there is a
>> better or preferred way to achieve this, I am happy to consider it and
>> rework the implementation accordingly.
> As there is only one user, just make this your own bus please and do all
> of the needed bus operations for your devices there (i.e. don't hang an
> "empty" device off of it.)
The reasoning behind to make it generic was to have more users - host1x,
Iris VPU, QDA on the generic context bus, instead of each of them having
their own. Let me know if you suggest to have the iris_vpu_bus.

QDA -
https://lore.kernel.org/all/20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com/
Iris VPU -
https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
> thanks,
>
> greg k-h
