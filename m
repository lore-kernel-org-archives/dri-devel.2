Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9756CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB8F10F843;
	Wed,  3 Jun 2026 05:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1HVuScF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ROnSeZam";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CCA10F843
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 05:28:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652NoRdq3302790
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 05:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eXGduTCF9StMe/W/R1Pp9AQqLYpxIS0I136uVj0AkSI=; b=Y1HVuScF3MC8OaMd
 5TEcIIX7BNLmavVFc4+pBYhu5ujFcjxD20ZbENmoNIqDPk8KkAVWPrSOXgmCY1IB
 SwANjLXUXktvtjk1zO7BTaF8iMxeJ+tEkqf+cYkNufK+qEtzrXyPaxH7n3w9Mzdu
 6oY1Piv/HdG2i4bS9U9aPZh6X+lL+zEvQbFn9v4tWho7XbxyPbfsXLVcZBXV712Y
 l/uNR083CCin5IV0zKpoL6QFh5G7tvai3VbmiAfwNI7NfocCnyqBD4bmqisCdmnd
 jhgmgrhRfbLK9D7EcTMgvxEEdMa6yz5a6Qq1viwMcMjEuIsEvQs2Dhu1l/h/nVUE
 lG5/Qw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu18mvac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:28:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8596e4272aso4236594a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 22:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780464499; x=1781069299;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eXGduTCF9StMe/W/R1Pp9AQqLYpxIS0I136uVj0AkSI=;
 b=ROnSeZamjvzgYvKMjaDJI6QTbMSAYqOgpS5wnFdsLhxv6/KtK67yWciXkOm8GIbcDq
 s0uQ+6HPEA0FrYSvej7zGhNVdFUHeLMeGFVDO0qyEnCNCspdNZcuVVuTuwy65B65AIhq
 xP52ILx1cs9ehuBjKtqb4SD6TM4wnmZzj0Qfu2M1O4nXB7DTuXBYak0DyfODkCTZfyis
 9TeC7SVFONAC8uTk4IL+JNqxGeUCwWHSsM0RS8obzsvfxzVkmTS37Sie0MHeq3PaEd5b
 QF4pgGHx0ULQ69H7QzrSIZfLRuxGURowZYptrk7u4pz8JzqMzvG86XbsJSNCUv+rnHEc
 bnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780464499; x=1781069299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXGduTCF9StMe/W/R1Pp9AQqLYpxIS0I136uVj0AkSI=;
 b=qzB8K3Q2SnisD/EKzIHY4VpQdOf4HTjCP+0ykbfFxanncDwQrhoAAu+f5AYfFNDPy5
 8nmYaUc3E9ZxeOMgX1Q7yv5MVPguGUCdJhKDLRMCK3JPjMVxmWfZPpZ207CMtuvABZjw
 +/bDjNTfUs9nqnHVGP17YjLXGSLnN+LkeRjAiWaGW1L/Foole5SQfo4mSNNGq3qMY3C0
 sqRHUN9MW1P417f0qucoQ0vlprksLgKQQEf44x81DmMHR81gkkMQQ57s2dwd8PPxyJ6F
 uBgIAo8L66AhgH6o3ezHeRNjTpizqDYjSvl8RbBOclhpLWykYJf05k//i9RiwXXP6rBW
 PPXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+5R6Z5mZ6mJRy6doFkoqJQtlA8/5nGAoKRGchw61ai2kRJgC0JR/Mya3+rnfv8bq2tXXidkdcOH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxh8agVr+LNcASWPxdTjhUDFOQZCHlGUYmKETYxhL0D5LGt4kh+
 JkrG652B/HQzAAcxFmYeWRidCGEqjtTGHUWqLCcPvPxag+yEx/tyvu6BRPzLv4cWjH/CQNB+9Ax
 4yEDqo+Yv8tb1QU+9wQeIZXmbeUGv96Blb9ZRX7PbQhbEfYMRha5i5wvQIueHoSDkDP9FHas=
X-Gm-Gg: Acq92OF3V6a+2Jw1lsji+KNavlqTabrD3WiyvvJ9FTxXC9QYakgwgrcSPeeIckiVf/h
 N5lx5txOPrrgosVsTpMrvuL5XBLoFAZ45lcuKXj7wpS6qTX4f4/msOyl8EyaF47JHiBKl5Nm7b8
 Vxud41ymHFI5oCZKFNv8DpFwZwnAf0b+39/EW47mQ5bp9jdWwfyOyId4axIWQzMQk6VKF/cQN43
 t/J8EOBkwG3SRB/sNQ65Iqyo7k2w9G3ptF2Ix8+F8VuWcyKEu5/N+cLOw/yB9HAgLbpZTKS5i+8
 Dl1nYjGGNSJ/7HJhMzSRtJCQQdITCp2RotctuEYX9bWPZW9qyPHofDxPITGJjWuaC9Sk2b3sHCN
 Rku6ox1ogbIv+xL8yiZAESaYQsnO7FI+mFX6LvgEvcVxTGO3xTMy/ztHw/cc7
X-Received: by 2002:a05:6a20:748a:b0:398:6ea8:21d8 with SMTP id
 adf61e73a8af0-3b49759433cmr2261513637.15.1780464499503; 
 Tue, 02 Jun 2026 22:28:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:748a:b0:398:6ea8:21d8 with SMTP id
 adf61e73a8af0-3b49759433cmr2261470637.15.1780464498951; 
 Tue, 02 Jun 2026 22:28:18 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a624fsm986006a12.18.2026.06.02.22.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 22:28:18 -0700 (PDT)
Message-ID: <587b450c-c527-4c6a-b48b-8a7a266bd673@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 10:58:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] accel/qda: Add compute bus for QDA context banks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-4-b2d984c297f8@oss.qualcomm.com>
 <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a1fbb74 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=fSmyMkXI2XJwL8L7xYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA0OSBTYWx0ZWRfX55kvTkWTUJAr
 4uQkvpEJQE9Kgl6INbeRjS10EsCm5IXe06ti/jbBpFYTsa00bzmejvZUZRkF8xWvVY38DbSfDOj
 YttJ3W0lhtAFdye0EYl+qBFcjw2lGFViIaFLVZojBnhI/p/Rr8+o3gn/RpVGy5z+Oqb1cS6l/zR
 dBRHn7+VZNKwyBICbTXA0o829UnoA2uQH+AJiIUIFWe39sAZ1GHU+LtnT8v+kk+O/NC5iZlwvZN
 0pBxJQhe6E8uw/ki99/p38U8jXrMBrkqUTG1ym33EtJlEXOX1o086UL1wrToyKKd83s/BpHTQMq
 qLPQbiUWP6cFfe+u6V7cJhvHH7DCA1rP/pkk6owebJSgqt+0KveXToQjY1w7m5SY0Lqf0XRz6vE
 dX+QpWQS9MgGwMRSFboGpbDZjCb1oFzD6GIup025s2ALNloBQs8FnFMvFNb599LcdGoL3gkRoLI
 /FWqJ6/Wsk0eCXMVcsA==
X-Proofpoint-GUID: 9D0cOrk6nbGnqCv6jB7eUL62b6wULdfs
X-Proofpoint-ORIG-GUID: 9D0cOrk6nbGnqCv6jB7eUL62b6wULdfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030049
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

On 20-05-2026 19:49, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:54AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce a custom virtual bus (qda-compute-cb) for managing IOMMU
>> context bank (CB) devices used by the QDA driver.
>>
>> IOMMU context banks are synthetic constructs — they are not real
>> platform devices and do not appear as children of a platform bus node
>> in the device tree. Using a platform driver to represent them was
>> therefore incorrect and introduced a probe-ordering race: device nodes
>> were created before the RPMsg channel resources were fully initialized,
>> and because probe runs asynchronously, user-space could open a CB
>> device and attempt to start a session before the underlying transport
>> was ready.
>>
>> The qda-compute-cb bus solves this by allowing the main QDA driver to
>> create CB devices explicitly and under its own control, making their
>> lifetime strictly subordinate to the parent qda_dev. The bus provides
>> a dma_configure callback that calls of_dma_configure() so that each CB
>> device gets its own IOMMU domain derived from its device-tree node,
>> enabling per-session memory isolation.
>>
>> The bus type and the CB device constructor (create_qda_cb_device) are
>> exported for use by the QDA memory manager.
>>
>> A hidden Kconfig symbol (DRM_ACCEL_QDA_COMPUTE_BUS) is introduced and
>> automatically selected by DRM_ACCEL_QDA so that the bus initialisation
>> runs via postcore_initcall before any QDA device probes.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/Makefile              |  1 +
>>  drivers/accel/qda/Kconfig           |  4 +++
>>  drivers/accel/qda/Makefile          |  2 ++
>>  drivers/accel/qda/qda_compute_bus.c | 68 +++++++++++++++++++++++++++++++++++++
>>  include/linux/qda_compute_bus.h     | 32 +++++++++++++++++
>>  5 files changed, 107 insertions(+)
>>
>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
>> index 58c08dd5f389..9ed843cd293f 100644
>> --- a/drivers/accel/Makefile
>> +++ b/drivers/accel/Makefile
>> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
>> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
> 
> Ugh. The previous line should be enough (but don't trust me).
I was seeing build failures if I don't add this. Took it as a reference
from host1x driver and recent iris patch.>
>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
>> \ No newline at end of file
>> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
>> index 484d21ff1b55..2a61a4dda054 100644
>> --- a/drivers/accel/qda/Kconfig
>> +++ b/drivers/accel/qda/Kconfig
>> @@ -3,11 +3,15 @@
>>  # Qualcomm DSP accelerator driver
>>  #
>>  
>> +config DRM_ACCEL_QDA_COMPUTE_BUS
>> +	bool
>> +
>>  config DRM_ACCEL_QDA
>>  	tristate "Qualcomm DSP accelerator"
>>  	depends on DRM_ACCEL
>>  	depends on ARCH_QCOM || COMPILE_TEST
>>  	depends on RPMSG
>> +	select DRM_ACCEL_QDA_COMPUTE_BUS
>>  	help
>>  	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
>>  	  This driver provides a standardized interface for offloading computational
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index dbe809067a8b..424176f652a5 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,3 +8,5 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_drv.o \
>>  	qda_rpmsg.o
>> +
>> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>> diff --git a/drivers/accel/qda/qda_compute_bus.c b/drivers/accel/qda/qda_compute_bus.c
>> new file mode 100644
>> index 000000000000..c59d977e924d
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_compute_bus.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/qda_compute_bus.h>
>> +#include <linux/slab.h>
>> +
>> +static int qda_cb_bus_dma_configure(struct device *dev)
>> +{
>> +	return of_dma_configure(dev, dev->of_node, true);
>> +}
>> +
>> +const struct bus_type qda_cb_bus_type = {
>> +	.name = "qda-compute-cb",
>> +	.dma_configure = qda_cb_bus_dma_configure,
>> +};
>> +EXPORT_SYMBOL_GPL(qda_cb_bus_type);
>> +
>> +static void release_qda_cb_device(struct device *dev)
>> +{
>> +	of_node_put(dev->of_node);
>> +	kfree(dev);
>> +}
>> +
>> +struct device *create_qda_cb_device(struct device *parent_device, const char *name,
>> +				    u64 dma_mask, struct device_node *of_node)
>> +{
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = kzalloc_obj(*dev);
>> +	if (!dev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	dev->release = release_qda_cb_device;
>> +	dev->bus = &qda_cb_bus_type;
>> +	dev->parent = parent_device;
>> +	dev->coherent_dma_mask = dma_mask;
>> +	dev->dma_mask = &dev->coherent_dma_mask;
>> +	dev->of_node = of_node_get(of_node);
>> +
>> +	dev_set_name(dev, "%s", name);
>> +
>> +	ret = device_register(dev);
>> +	if (ret) {
>> +		put_device(dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return dev;
>> +}
>> +EXPORT_SYMBOL_GPL(create_qda_cb_device);
>> +
>> +static int __init qda_cb_bus_init(void)
>> +{
>> +	int err;
>> +
>> +	err = bus_register(&qda_cb_bus_type);
>> +	if (err < 0) {
>> +		pr_err("qda-compute-cb bus registration failed: %d\n", err);
>> +		return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +postcore_initcall(qda_cb_bus_init);
>> diff --git a/include/linux/qda_compute_bus.h b/include/linux/qda_compute_bus.h
>> new file mode 100644
>> index 000000000000..90bf248c7285
>> --- /dev/null
>> +++ b/include/linux/qda_compute_bus.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_COMPUTE_BUS_H__
>> +#define __QDA_COMPUTE_BUS_H__
>> +
>> +#include <linux/device.h>
>> +
>> +/*
>> + * Custom bus type for QDA compute context bank (CB) devices
>> + *
>> + * This bus type is used for manually created CB devices that represent
>> + * IOMMU context banks. The custom bus allows proper IOMMU configuration
>> + * and device management for these virtual devices.
>> + */
>> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
>> +extern const struct bus_type qda_cb_bus_type;
>> +
>> +struct device *create_qda_cb_device(struct device *parent_device, const char *name,
>> +				    u64 dma_mask, struct device_node *of_node);
>> +#else
>> +static inline struct device *create_qda_cb_device(struct device *parent_device,
>> +						  const char *name, u64 dma_mask,
>> +						  struct device_node *of_node)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +#endif
>> +
>> +#endif /* __QDA_COMPUTE_BUS_H__ */
>>
>> -- 
>> 2.34.1
>>
>>
> 

