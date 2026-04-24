Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A986FE5204
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D94110F523;
	Fri, 24 Apr 2026 10:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6JWbiHr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QCpP29tZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B4A10F4EE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:31:29 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O91VbL2709808
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fkq8FSSmqZ+BgpWN2pN52kgGZ+J4MmKi/hhUikJKRsM=; b=R6JWbiHr1Hws4KFD
 P9EShqlovtNlSf0AByxhdLPJUa4yZ+U1z93tuKKYXReXUOh1Ohhj0F+mt6flshwR
 /tF0rSAvddvM7tnnRNYDFv3A9iHf1kV53PboqvNmAtcE591LZnrza8MHeK7UtcNz
 7ZOsi/JRnOGYSR7FEDqRo30aq6g1dO6aqVzP4lJDQtaHtAmCoHR2NBnkWM9ZsnaH
 jp4+B05Y44J3DavygqvO8iGPet00xALCA+r31AZfZC8hIbuVWCLFIeWfApqtVG2/
 v9sxRb5TtsM4rnbuuWDe01yfk7PpNWDZWXSqhooweWZSAg3Fseq3PT6bCsIOiDrn
 5FvXyQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqqu9umwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:31:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa6c3a77cso4429142b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777026688; x=1777631488;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fkq8FSSmqZ+BgpWN2pN52kgGZ+J4MmKi/hhUikJKRsM=;
 b=QCpP29tZCxOxHXY+cEMitCHlp6veCN2bvV+Ciq8xcKLvwe3dnySeDuMyIL1q6Hai9r
 taxqUhrvbh1GQmwL3MNSK/lqk6wQp6eyMVy/ZscvADkbWbdzKXvXoHXNpS3xUWjdYCnp
 RySOsa8HqUkQacHrfumEZKqVK7vsQB8PhIexVesycKOXZYUwNdvoIafDPm5yWkd+/nAa
 k4gPdFFtWcjDL2DTGz7eGy/hhPbUx51G2MdNUIXj8TujsB2SahRp5N9Z+KXHBIPZooyi
 +Kq6Nh/PXHMktun8Sqa+B/PvV9dzmr4OLFbW3HfI3K1/FbwznDS2uh0R2qJAJMBytcNy
 MKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026688; x=1777631488;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkq8FSSmqZ+BgpWN2pN52kgGZ+J4MmKi/hhUikJKRsM=;
 b=l9y5Nnm9qt4sN4GbO6TSnR0EUU5k946JHDDSBt+Z4DVN4BJvACsuScuqEo1mrGXW85
 4lQML3pXYe5LG0EhfAvNrFqa8hcyMrcJAjqR5tZjJHViRzKthJDrGX5neNcxDBnn9n/e
 URY6OExSFdrSHofnBT4kQyBHv2Ipix3pcSigzfBDu5KN6Z9tY+Bs7lAwJUfywcaX30LW
 UoEb5oaD4g7DoMjPPiOUVaf9V/aWCm2XFg91rZTtEeOI50sllSWrgfXvWjLQGBeHebeG
 EyKKeJEyYRpEH7hNsfxgLz9dDEKda0D2pNWnhZLHgl4Q6Eod3cNVgUx51Zmadei8hzgI
 CAwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KmlicUFop1kktPgJmWb6YaNk60iY98a5pNGR9Ztui3/0+NgQMkSYLD1/84mJ1WelGi5H0m2nqQV0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsAVkSKyy1dm97zENtxZtx7/cXU77PRhmWsPJ6GNeik0T8SNIV
 OlOHUK5F3kLDYTGmwZcCwcYgMvmJwM5S7pJRLjjAM45+47tOOtXBle/wl1fs4v9+T+/rF13+5D4
 FwUhvsCaSM47OJ+IxyCWHWFyv9Vn6NO8voFHKVM73Pj8C7yzizDREaOCL+05Rvji6ObVUygY=
X-Gm-Gg: AeBDievaTCy+ZhQw5uxDl5fhgxQWulc95smF6yejIBpGwTLFjH0UpKbPZxw26NvRpA5
 XLQlnp5Lf2wGWFOdT89AkwTxuoq3Bq6ap3e1T+tC3uXaK+X25qnvzvSZlnypkDyb6IPPjVd0XE8
 myM5v6fELsbSWgFW0PNqR7GjKaoG+5NffBTdjCD3lmWm7WVs3YWSYLxkgMQkiXlKz9psGzBLJxc
 NJOrJztm4RFjJNAZjzkGrRoSO9RSc6RG364AL85abM9sEqO+ygbDGJ+G7WfduTsuazrmX/ySVqg
 Vukw2EuZrKUiBCaW23e+WTWPWsjUlcCbNcP3iPt9kc2TKoaWogaIjKksz6u5cIqxk/qdSRj8LF/
 4c5mESt3HNKk6T8PNAe07J+aGD5brkzD8SJrqxay7RhgOgSish+/CLIK0z5wj5zXO
X-Received: by 2002:a05:6a00:2e9c:b0:82c:e1a0:3447 with SMTP id
 d2e1a72fcca58-82f8c962033mr34808628b3a.23.1777026687567; 
 Fri, 24 Apr 2026 03:31:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9c:b0:82c:e1a0:3447 with SMTP id
 d2e1a72fcca58-82f8c962033mr34808559b3a.23.1777026686919; 
 Fri, 24 Apr 2026 03:31:26 -0700 (PDT)
Received: from [10.239.60.18] ([106.192.26.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb1dsm25153536b3a.14.2026.04.24.03.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 03:31:26 -0700 (PDT)
Message-ID: <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 16:01:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
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
Content-Language: en-US
In-Reply-To: <2026042346-trustable-register-095a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j08OWXgkRmoHZn6tEH7fTcaRyXcq_mzN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5OSBTYWx0ZWRfX+12sQcZdzgxF
 XgMrIgLLVGZNwwWsXyxiskQvNPTN9RyU29kpTRjmymAzSIhfWcZqDhkFOQsAKVun0EdggewreIi
 vzi3GZ4cuPifuH4NCLw4qqBpebAjzVlYUnEknIuP8I5y2wWekUVkydANaaCtCgdAFkkOsTnmKVl
 dYSTy8PiwJVSJyGRPb5QyR8mAcFA8PosMkPimxltkNnwAB57hE8vxEjV7xvJaUDWq0tf/2XG4br
 IZ7Ej3QPqiL0QXCMJDUXcQZhezhWWj9kilLyj5XIxexxsrOLMM9jyhvESq8t9qaDtRZ0l8y5edZ
 d6UZnIfuO/CFEayL8PAhdA35/2INHhkHpCias6iWGt7EPaIsQ7KeUi0pEeFynlH7av8aMLpKGZs
 YiKTLb1RWt/MdAGTffEdLeAGyMK2aTmIvU+OVatX4boQ1wHd57/cMH7uixfWa5TwspbWsXeSuL5
 EWIF86AQ4YEBVx2zgPg==
X-Proofpoint-ORIG-GUID: j08OWXgkRmoHZn6tEH7fTcaRyXcq_mzN
X-Authority-Analysis: v=2.4 cv=QJNYgALL c=1 sm=1 tr=0 ts=69eb4680 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=K3jt3zD9TrcZs+Uyli2v9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=5Qc4mBPHLNQQZN8o19QA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240099
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


On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> When a driver needs to create virtual device at runtime and map it to
>> an IOMMU context for memory isolation, there is no common bus available
>> for this purpose. Each driver ends up implementing its own bus type,
>> leading to duplicated logic across multiple drivers.
>>
>> host1x driver implemented its own bus type to attach an IOMMU context to
>> a dynamically created device. The Iris VPU driver now has the same
>> requirement. Rather than duplicating the same bus logic again, a shared
>> bus type is introduced under drivers/base that multiple drivers can use
>> directly.
>>
>> The bus takes care of creating a device and attaching the IOMMU context
>> to it based on the client inputs.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  drivers/base/Kconfig            |  3 ++
>>  drivers/base/Makefile           |  1 +
>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
>>  4 files changed, 107 insertions(+)
> as you can not have a device on multiple busses at the same time, this
> makes no sense to me at all.  "dma context" is a bus-specific thing, so
> please add it to the bus that you are wanting it for.  It can't be a
> generic bus as that just doesn't work.
>
> Or what am I missing here?
>
> And why is DMA somehow "special" here from any other hardware attribute?

Let me give brief information which was discussed, in the initial series,
the iris VPU used platform bus for dynamically created devices and we got
the comment/suggestion from Robin to implement a proper bus_type with a
.dma_configure callback.

https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/

based on the discussion, implemented the dma_context_bus and used for iris
VPU devices instead of platform bus.

Here, the device have only one bus (dma_context_bus), not multiple buses.

Regarding the "DMA" naming, the core operation of this bus is its
.dma_configure callback, which calls of_dma_configure_id() to map the device
to a corresponding IOMMU stream ID. The name "dma_context" reflects this
purpose.

I am open to suggestions from you or Robin or anyone else, if there is a
better or preferred way to achieve this, I am happy to consider it and
rework the implementation accordingly.

Thanks,
Vishnu Reddy.

> thanks,
>
> greg k-h
