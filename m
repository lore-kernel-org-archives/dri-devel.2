Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA19EFF885D
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 10:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BC310E12E;
	Sat, 25 Apr 2026 10:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGBFF5tT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aj3fMAlD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551B210E12E
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 10:35:42 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P4eVH51557621
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 10:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jxCmCQDJ+QKREcMZ2PcVDsOS
 3meXGSX8BjTm2djUMR8=; b=dGBFF5tTpOPFqq2QI4ayNBfnKhRP/k7EDxQIgTYF
 sGqNW5qPUHUXETkyh7iTM5vTeVm9lfUpClEKREr45gJneIbvw4kHmodwjLqqMHe+
 lBBwMGPTQWuzEgmWxoBk9Wi0UE21yKwWY997OZpr3nbrAqm0St4mgvR87fe6WSle
 vITCEfARKXWVSdbl2gUEAEljTKIR0F/ZeBRQ7JWsV+MJXV1I+YQPkAtwgVqWyFuB
 sl3EzPSs+264Drdh8r9xtX2gRqr6IxAuEstVGDGw8IZ6EocBU+dZxYt5DGv2pHrh
 YMbYTmEnSwJ5XvRbZTIKE+EM/htPgfVJF9WxWcBg5GPXuw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpsgrk7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 10:35:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad5fec175so122032135ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777113341; cv=none;
 d=google.com; s=arc-20240605;
 b=kUZUmdZZP6knVoWK9fyJAQK38jkQtUfVbmcFRLRJLasEk6VZUbWYmOsIPDZNPigvBn
 5oflltwse2LjcmLUJttLyNoP7vo21EG9lZ13+RTcQE0WHL73b6VK2ml8kgbdG2WD3ouz
 0Cpb0xvP9z2ZghdgAt3/j2YpwKAiI8l6NeEndJVfr+MktZLkQR0/J8ZjQyf1cqnXAV/s
 sKE2+RysRG2Nv+GNO7ZxHZJLlY3EnpdoZVih+RMEi9CBocWTWJSWRAdfGAHIYI/FYyjs
 efFVbkCBPCEzhe61M2zoBDB/nDbdxVPwJSba+QwnZ4tKNsCW12dDuO/Q7EpRbWOcvPBl
 /cAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jxCmCQDJ+QKREcMZ2PcVDsOS3meXGSX8BjTm2djUMR8=;
 fh=yHc0PORjA+USx2540RcOEQY8MTp/BO6WVAZJEjabu3g=;
 b=cdmfLg3yA4xjphWG4k3f7eUtbnOerrM/E4DCwJ+cJusdkk08o0XuKH9jzp7n+I708t
 utAW+CjB7kewrN3o/ePS3lI75um52jkeJ5BvNs/gqUp+DXzMb9gANkuQCMNwMkivQgi9
 Dz9hnEGmw3NnDfaNv6XBp4lfELMyoLhJn6ew2WFBpuIMPiDS332KkoH5QKtzGiVZoPbb
 ys6yXQE/NHo7YZQBlGinVuCjAgNaL2YjtN2b4+eBCbShzXxDwclUPInA0v2NHx7uOtz+
 Uw4ehVNRjucPC7jggEWrvDltxuD6GaQWvCGWHsnvuNS1ttB/3xsqiAKYRgV/zNNRusLF
 afdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777113341; x=1777718141;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jxCmCQDJ+QKREcMZ2PcVDsOS3meXGSX8BjTm2djUMR8=;
 b=Aj3fMAlDAIjKe1fxTILidhvb+ahlHXWkSeGgyM7li3hfZ/V8lee+xiAHlY0KBGVvBX
 ZJsqk5jg73IZb2106NDNYUr7X2BqJSYLaAQ40yIwCgGYsai17RvKmNesO4fC5W2whSOJ
 LtQwhqOPdAXdqEUsCsjNO4e/hs1rRzRUvvnkwlvhGZ7XwyrrtwJShwImbZgN1qZ53pzl
 AvdgWuzT1v7igTpEcnVGphH45BrT46NmXx0rjpX3jiKHntXKuNv2tDtoFR/AHGl3WOJk
 IBAQ646QwfPPscgca2fWxc/LcjaD5Z9myCTv9LJjGAISIFACzEeIvm150HD4s3Yb7az7
 J2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777113341; x=1777718141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxCmCQDJ+QKREcMZ2PcVDsOS3meXGSX8BjTm2djUMR8=;
 b=HXZg4au1VKizvAO/19R7pwsOv03yrk7JKNn1WNCz1grMNX+CVasvIOWKAbsSJSJxJR
 IIdVkDpyT8+1Z78ecdnn5JyKO+p6xSk92kCFdAA8OLqrqquJhyE5OTL4FcDs94guuA54
 05wRU7Klo2P1lWPRajwG/2MT2xlkwy5iiTiw/7sX+aF6JqJBXVpLaaaHK28enlnQoyve
 Nl41BL9efFc7Aw8qONchsABbLIn3ESP/fimqDiWrvH2NyZtQ/dW60+31pCo5Q3Y7Fz0t
 7fhQKKnzRMc7d/4qAAeUzv+zLjkhTQ57MbTkDAsKGGcIT8jWEarGx8singSJ8SzqaXFH
 GdaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eiW4+1XaD8PSJq9iOv0EnAuWgW8va9PE4hgrLpD2K6Pj4ar0PTdM/90DKhJ4WajFUr1E1pwIHujg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzhw2BCZj9/zMMiM3+Xt7IsVqzv7Tb7TwaREHKJ3R0z5j0fz7tH
 J5m4e/Q10WSofFvu9wLFjxhbVIcG2oh96RQ4PjUNkiOmzKKT0nlVuie5GJo1HkWtNSsQtcSJRTj
 2X3w3YB9n4hESYVN7YT9tabxci/lF7NlPHR9A1rr6TI4zXfQo7//Asw1ceiUtMiu7EN3WKGd7uC
 tTkjPnjd+qz4TEp6PQljqgA9JLsDcS0Kqft5ISWsFXqojosw==
X-Gm-Gg: AeBDies4wXaxMmmIBBr7dCDAatuNNnn7iWvFfi/R4OjbimE0yI1VBGUhulg5qlA7ESH
 ehxLX1a9CrisgohxvsFG+qWhEpKDAw2KSLB9phAKp/+d7oAUt4CYb7XwCvNlhlX1z+uicf94fZC
 M6+KOgZPwOzG5b3E7OPZgL2liMHYdIC+fc/azLX1r5IvXETBmrlKCer9f5k39aMB4jQTAGdkzH1
 WRW9CcRRV8xnXTfpnM=
X-Received: by 2002:a05:6a20:3ca3:b0:398:77ae:8d8b with SMTP id
 adf61e73a8af0-3a09d099c4dmr37413507637.10.1777113340987; 
 Sat, 25 Apr 2026 03:35:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca3:b0:398:77ae:8d8b with SMTP id
 adf61e73a8af0-3a09d099c4dmr37413465637.10.1777113340418; Sat, 25 Apr 2026
 03:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>
 <2026042346-trustable-register-095a@gregkh>
 <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com>
 <2026042422-deem-chemist-8d0f@gregkh>
 <4c3fa710-f61a-4aad-622d-54909190cb9e@oss.qualcomm.com>
 <2026042428-blemish-helpline-7d8d@gregkh>
 <1e039dd5-da3f-19b2-ef98-29e64fdd925d@oss.qualcomm.com>
 <2026042442-luxurious-antonym-f20c@gregkh>
 <xuitjl6tzfl6nl4ds4vdy3637i5cqtjuqntcpqt5fnkx2ogcws@iapcavrwhyzv>
 <2026042539-swab-active-21a5@gregkh>
In-Reply-To: <2026042539-swab-active-21a5@gregkh>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 25 Apr 2026 13:35:28 +0300
X-Gm-Features: AQROBzCbHZ9w70YTtp6TmSB59GwDi5IqmqQ6RzKXe3MebdTi8LTOo1dC7YaDYn8
Message-ID: <CAO9ioeXWM74DEa=SA2vSvN_cmXivDth2VSmv2c1SOWtdL2i=OA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
 linux-tegra@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: S2cmUAQsLj-F9pjDlCa0OTRsZJmm0TmN
X-Proofpoint-ORIG-GUID: S2cmUAQsLj-F9pjDlCa0OTRsZJmm0TmN
X-Authority-Analysis: v=2.4 cv=Y+fIdBeN c=1 sm=1 tr=0 ts=69ec98fd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=ag1SF4gXAAAA:8 a=G4jgJTYFYwyYmvXJBf8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEwNCBTYWx0ZWRfX5ZQpCGWyD43m
 EtA7HCptNP3NSzIAInmhPMb+Y7ifBjXYdtooS2Jz4jpDwMcZGgOJUtt0O6kZrM/OBjKjCwIfmvC
 s2XtOs60KGs5S3it1uR+j4Ux6J/LlF4OqaU9cZ4kxrSlh+U0cTR0BolwUJ0zP0eVKfxFMuhY5bW
 eYp4Fye+8bZq9dC2HU+yxVt1S7hGWAlTqYQqb4FOuqorXxOdlVutXj7qjh983OGQ7x5isOSWzDO
 WjewIgrtU+dEGyjruJy62dJIu4+kDyYo1G5HhOCX8P1co2dzVfPqWkxy5eJj8lhwOx9eYhjiEnz
 NaSM7SoSlv6ZNT2VPGvw4fXJXv/TsoIbaG7KPnUJFfRtf5jLIykkNlc7m1yfUXWRQyIa9kGzlie
 LLwV3YvEr6h0z2hI1V6MifhIyJTbBRK2ARmauoCINn5q9XIZtOkjhuyds1hjIhsXsvvQBK3hs4t
 lHwEH3N9KQZqNuuVQKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250104
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

On Sat, 25 Apr 2026 at 08:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 24, 2026 at 07:11:35PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Apr 24, 2026 at 03:34:38PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 24, 2026 at 06:12:09PM +0530, Vishnu Reddy wrote:
> > > >
> > > > On 4/24/2026 5:25 PM, Greg Kroah-Hartman wrote:
> > > > > On Fri, Apr 24, 2026 at 05:15:02PM +0530, Vishnu Reddy wrote:
> > > > >> On 4/24/2026 4:43 PM, Greg Kroah-Hartman wrote:
> > > > >>> On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
> > > > >>>> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
> > > > >>>>> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
> > > > >>>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > > > >>>>>>
> > > > >>>>>> When a driver needs to create virtual device at runtime and map it to
> > > > >>>>>> an IOMMU context for memory isolation, there is no common bus available
> > > > >>>>>> for this purpose. Each driver ends up implementing its own bus type,
> > > > >>>>>> leading to duplicated logic across multiple drivers.
> > > > >>>>>>
> > > > >>>>>> host1x driver implemented its own bus type to attach an IOMMU context to
> > > > >>>>>> a dynamically created device. The Iris VPU driver now has the same
> > > > >>>>>> requirement. Rather than duplicating the same bus logic again, a shared
> > > > >>>>>> bus type is introduced under drivers/base that multiple drivers can use
> > > > >>>>>> directly.
> > > > >>>>>>
> > > > >>>>>> The bus takes care of creating a device and attaching the IOMMU context
> > > > >>>>>> to it based on the client inputs.
> > > > >>>>>>
> > > > >>>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > >>>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > > > >>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > >>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > >>>>>> ---
> > > > >>>>>>  drivers/base/Kconfig            |  3 ++
> > > > >>>>>>  drivers/base/Makefile           |  1 +
> > > > >>>>>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
> > > > >>>>>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
> > > > >>>>>>  4 files changed, 107 insertions(+)
> > > > >>>>> as you can not have a device on multiple busses at the same time, this
> > > > >>>>> makes no sense to me at all.  "dma context" is a bus-specific thing, so
> > > > >>>>> please add it to the bus that you are wanting it for.  It can't be a
> > > > >>>>> generic bus as that just doesn't work.
> > > > >>>>>
> > > > >>>>> Or what am I missing here?
> > > > >>>>>
> > > > >>>>> And why is DMA somehow "special" here from any other hardware attribute?
> > > > >>>> Let me give brief information which was discussed, in the initial series,
> > > > >>>> the iris VPU used platform bus for dynamically created devices and we got
> > > > >>>> the comment/suggestion from Robin to implement a proper bus_type with a
> > > > >>>> .dma_configure callback.
> > > > >>>>
> > > > >>>> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
> > > > >>>>
> > > > >>>> based on the discussion, implemented the dma_context_bus and used for iris
> > > > >>>> VPU devices instead of platform bus.
> > > > >>> Why not make a irus_vpu_bus where you can do what you want?
> > > > >> Initially iris_vpu_bus was introduced, and it was made generic based on the
> > > > >> discussion,
> > > > >>
> > > > >> https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
> > > > > I don't really see that request here, I see a "make this better and more
> > > > > generic for other busses" but that does not mean "dump it into
> > > > > drivers/bus/ for someone else to maintain" :)
> > > > >
> > > > >>>> Here, the device have only one bus (dma_context_bus), not multiple buses.
> > > > >>>>
> > > > >>>> Regarding the "DMA" naming, the core operation of this bus is its
> > > > >>>> .dma_configure callback, which calls of_dma_configure_id() to map the device
> > > > >>>> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
> > > > >>>> purpose.
> > > > >>>>
> > > > >>>> I am open to suggestions from you or Robin or anyone else, if there is a
> > > > >>>> better or preferred way to achieve this, I am happy to consider it and
> > > > >>>> rework the implementation accordingly.
> > > > >>> As there is only one user, just make this your own bus please and do all
> > > > >>> of the needed bus operations for your devices there (i.e. don't hang an
> > > > >>> "empty" device off of it.)
> > > > >> The reasoning behind to make it generic was to have more users - host1x,
> > > > >> Iris VPU, QDA on the generic context bus, instead of each of them having
> > > > >> their own. Let me know if you suggest to have the iris_vpu_bus.
> > > > > But you did not add such users here, so how would we know this?
> > > > >
> > > > > And still, I have no idea what this bus really is doing.  Is it dynamic?
> > > > > Is it self-describing?  Why not just use aux-bus?  What is it supposed
> > > > > to be doing and used for?
> > > >
> > > > This bus will allow users to create a dynamic device and map to IOMMU stream
> > > > ID via .dma_configure callback which calls the of_dma_confgure_id() based on
> > > > the user inputs. This bus is under the iommu_buses list to register for bus
> > > > notifier callbacks for iommu_probe_device() and iommu_release_device() during
> > > > add and remove.
> > >
> > > But a device is nothing on its own.  You can not just have a random
> > > 'struct device' hanging out there that does nothing but iommu, right?
> > > It should be doing something else that is very "bus" specific.
> >
> > Unfortunately, it is a pattern of IOMMU-only devices. All the actual
> > programmig is done through IO region associated with the main device,
> > while subdevices are mostly used for DMA buffer allocation.
>
> Great, then you have a "host controller" for the devices, and children
> devices on that bus, with proper drivers binding to them.  Like all
> other normal busses.

I see your point.

>
> Yes, writing a new bus is a bit more pain than it should be, one of
> these days someone will get around to making that simpler...
>
> Along those lines, why aren't these new drivers in rust?  :)

:-D


-- 
With best wishes
Dmitry
