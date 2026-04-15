Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A621F4385D
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2029C10E728;
	Wed, 15 Apr 2026 17:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIzZLNQr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bxy6CZwp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F289910E72C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:34:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FEl2ba579768
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vbR6uymC69o6Z8rsQWYUozstbIH9JlydsnIlYMif8rU=; b=gIzZLNQr3c5GZpCJ
 DAvLsiqk4yCnL+T32P+6t65uFnVeGd2BAl53FHVbbg2nXX57DxzV55EGKRtYNG69
 tUKwuIUPSddrCy95Aofs1v1BEhC+BJiX/rdMX06n+/4vv7GlsdJH2bQVycq62kKi
 0osILBVmxC4qNHfKWVjpniLeU+MiN18L25ako0u7QF+P0P9p16DBY0IJs8441zT9
 ADJ7dUgvDlK3Qh52UJGE3buGYoT9tMgzv/ugXRs4Tk5EJhrkXGfMXEEJVfMRojvZ
 2zezmIw0SvNZr69FLxes7jKlICbPW+dOc1xewDhjWlLgnjTJFMvMmuRnmjUqLb59
 K42vQw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcr8rkyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:34:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b241be0126so139979075ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776274476; x=1776879276;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbR6uymC69o6Z8rsQWYUozstbIH9JlydsnIlYMif8rU=;
 b=Bxy6CZwpCCntrQXgwwInDp7FhUuvknwF1nZ2siHVomLAKS7cAs1C4jhlTOE7UWqAxP
 gCKicMSElDY445XGiBCb856eDlRAVSCl3yh8D0B/rTX0dc9cM+TFLNga6Z+ccWVk8x3I
 dxNeTVovKS/CFkFoKHzXm2xzNlGqcIQVuV4J+ZdcvNyMomgT40c9byIxuvRz1Ac0TwtF
 MTnR9ehvgOcUUdxqV0FHev15XEQBGjr1KXa0O0sz3SzsI1oqwFVs0LRaKAQ/1Xr+hCcQ
 EFL6k3zacu8NultUcxwd4vzUbOMq/VQ4WLFLG9PdVXz4hOJIwbROGkO58BqA6jSatZo3
 ZP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776274476; x=1776879276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vbR6uymC69o6Z8rsQWYUozstbIH9JlydsnIlYMif8rU=;
 b=irKXMKV6/dc2kqODW8tBKW59+CMMD+wNGj+Dxj+lJ8pYjeH17L9W3m4l+D0RbGPYnc
 QFJ0rIrlrKvftUCMdELJLqd+tnOIdjSxM1CKspS4D+RFHjn8hJNnN5kHwFoyQN4tEa8Z
 /Pdgr1XsT9GfYk1RYj3dcEioPEcDNLJGuym96my9E6UzDCJEdGY9SFqZ0/6/0f2cK/AQ
 IPqufDElLqUoxm1Ue/k0Q8p3huj4juoomOh5hMVrkDrRRM9i5VmORItu6bnY1dW6CUrT
 3usLnI0sDR17wGBEzlQjErv+BBHpt8eqv2CWgsIgBK/MKok3v+sH/P2XOXofwc5IvBdy
 kNAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/owbq5D9hGp4hjx+nJECviyqDMXh7mF8zd2oIQ2GkYeNnKs+YQVSANwav+SCjRGT8rgi3BcE4AsVo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhREUGh/5cPYcOP4tYhH16kpHQ/TXv0aGbbOzvu1aJZdWcn/91
 t2tkTcuZEZvbEkUIOtQoj+5iJ9Ko3DxhMVf4JR7acO5hUh69ZeDom2cglMxTHHXnKA6286oyGyr
 lgHkz3poAkbZJTJ8NOux0H/ATQNgUEuj0FIi7u/G+6du0OMcAKrtU0Co7I5MSO0kbsoN70bs=
X-Gm-Gg: AeBDieuBXJxnHtsWEzddFrzlHOUebUN1rlqgCPx68sNHLfEInsurh91N2AYNM7W0jUS
 akDO1q9RQ9opTt436AMe9sbvNWy5d9eexro4V+9f21lzH4+k4wtiDCAYC0krYQF+yzHPIWdNHVD
 mTg4zlFpiFtXsKfbkC6Rjixcu+fPI2YUAsVGfnbjYMze5oT9K8aO2zDyGdrkNb2VFDQF9ZAIss3
 z2rDA2lLuAkaT5VG1XDIsYWDz4h+0J6W7hvcc1FetupkedV7PHdcCKRWCjb4P+jLyP3raZgG/Ur
 mAvEBhrdVIy5c6V638kwCXSsiz6hYgpi3q/p4bORBvAPytKMoTKidvo8MjSj4iW6/9Zj53r4AEq
 gh3lJK1VvCqvWFV6A4BuHldX9jt7rC9ytLpcudUoRF4DwQRUDFNvkAw==
X-Received: by 2002:a17:902:6949:b0:2b2:b117:1e16 with SMTP id
 d9443c01a7336-2b2d5a459ffmr160044755ad.20.1776274475849; 
 Wed, 15 Apr 2026 10:34:35 -0700 (PDT)
X-Received: by 2002:a17:902:6949:b0:2b2:b117:1e16 with SMTP id
 d9443c01a7336-2b2d5a459ffmr160044375ad.20.1776274475300; 
 Wed, 15 Apr 2026 10:34:35 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810b70csm25397215ad.23.2026.04.15.10.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 10:34:34 -0700 (PDT)
Message-ID: <c4f21420-c299-f161-2bf7-c9b79ca15037@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 23:04:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ekansh.gupta@oss.qualcomm.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
 <2026041418-volley-composer-6363@gregkh>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2026041418-volley-composer-6363@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gc8nWwXL c=1 sm=1 tr=0 ts=69dfcc2c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xRG3GzwA0ZaNjhFdG0MA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: bB0iISWyamNXrCPQPiVMQX8jigcDgOUI
X-Proofpoint-ORIG-GUID: bB0iISWyamNXrCPQPiVMQX8jigcDgOUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE2MyBTYWx0ZWRfX+4s4p6QYdbsf
 Y5ZIsU/9B3nXMfmamvSgXmV1KODDPsmlbFCGpQylp55A3W05fnFwvteEkCaZ0Wn9mUI2gHZCyOm
 ZMqXQ5hLsOn9vHiGLsH4v9ev0b5x7tbw2sWrLuMXZ0C2bqH5su+wWkojzk7ai8jjLVE3Lo2waTQ
 1EoS8bgjpnHfP9tZEnsRFB/Vy6Pv/+yqGGGldc9Ym5qYhNsBRuIrtY3Z8iIg9iZZ4PDFONiORaV
 AUsdKhNpeLE0vZe4TIS1fy1/jw0TsRdlDgX2WFECfwaQZNkB6LYheXBqs1nKab7bl8k9gMlIOo1
 ZDvq5SQpm5otkwJVf405xuGDcuX/CnxMcdjwxRBoPlV+ddxKfWJLRPNCsNnloi0STHDWgNmkwus
 YDEH5ZUD+AAd1+7E5GsP5JJ+8+6lw1LetT3zlkfSraWeMHaF1D+F+pk00+aKZXTo5Zlu+m7kWRk
 rVxDGou7p0CjFkNjctg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150163
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



On 4/14/2026 10:19 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2026 at 10:01:15PM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce a new generic bus type for synthetic context bank devices
>> that require IOMMU context isolation. This bus provides a shared
>> infrastructure for accelerator and GPU drivers that create virtual
>> devices representing IOMMU context banks.
>>
>> Currently, drivers like host1x implement their own bus types for
>> context devices. This generic implementation allows multiple drivers
>> to share the same bus infrastructure, simplifying the IOMMU subsystem
>> integration and reducing code duplication.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>   drivers/base/Kconfig        |  3 +++
>>   drivers/base/Makefile       |  1 +
>>   drivers/base/context_bus.c  | 24 ++++++++++++++++++++++++
>>   include/linux/context_bus.h | 15 +++++++++++++++
>>   4 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index f7d385cbd3ba..479bc4bb442b 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -4,6 +4,9 @@ menu "Generic Driver Options"
>>   config AUXILIARY_BUS
>>   	bool
>>   
>> +config CONTEXT_DEVICE_BUS
>> +	bool
> 
> So this is a context-free bus?  I.e. no documentation?
> 
> :)
> 
> This feels really odd, this "bus" isn't doing anything at all.  So why
> do you need it and can't use auxbus or faux?

Looks like the device have specific iommu configuration (via 
of_dma_configure()), then using the auxbus or faux bus types does not 
have the bus notifier calls to iommu_release_device(). Please correct me 
if I misunderstood?

> 
> You say something about an iommu, but yet this has no information about
> an iommu at all, so why are they somehow special?
> 
> You need to provide a lot more information here, sorry.
> 
> greg k-h
> 
> 
