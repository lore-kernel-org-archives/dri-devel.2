Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E7606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ct+tEHLc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=atS5ulgc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC15010E26C;
	Wed, 11 Nov 2026 07:24:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7590E10EE5A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:24:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KKhI2017370
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4wbtJKn4IxGskmQgOdo6faBAsmhd2cI7qV2Ob/EpzcE=; b=ct+tEHLc1bLztlOA
 7Nte8SPyllFfvGgbTINjrBO/npdO1dTNxAfSaXVUAMjIVJe/PV6PIfmJDq7KS4Rb
 GAuU9ZGtwUOc/K18T0g6m70Zt+O6/hi59f2umL3wFZJ1uCdD5v7iJbTHqM1hItNG
 6vtE9BC7afMP3qMc6Q1QAROO2tykB0b0e0LiWaLY1S7p3spiosyk4bCnh7dqtWay
 NJ2pD6NA3WhiktTEMxf2nattfyUSWTxLFG0jUIyq/9A9r4RjUSjPU3FD2795BZ0i
 59krfHwklKMMGuxhjcLZG+JYwBrnTT+F9NzYcXSftughWX7h7eb1nT74lRPLi0Ll
 lGcShQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cafx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:24:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b18741aaf8so246795a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 23:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794381863; x=1794986663;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4wbtJKn4IxGskmQgOdo6faBAsmhd2cI7qV2Ob/EpzcE=;
 b=atS5ulgck498LcJkh74XV5wxspCsFw3pGg2Gn3AT4Ps8kGFb8r7HehS3v5rZyRKYEK
 H5cyKaeUfci5STMk7RQ/GMALkGscU/TpLCW95TSiuBxIssIZPNiiBN52GZ+79fLXN698
 VQUryp8cXh7b7P4fpj3fh9pWcO/d1+P1jFyIcFr3+u2dFuXLpeYUkqebUvjeJkz60nQG
 /of4Cc+k8Su7m6oBYC8Cf1XtQGimHs2iIpOhVAdoSfM8/b7yUA0csnULGMBieAMjmRP4
 2z5X8WOjjAO6ka1WsbRJ4RhznqNOyuhq5WMqk90ILDbGP34PkUxqN2giTbOKo2aPQZ0E
 kyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794381863; x=1794986663;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4wbtJKn4IxGskmQgOdo6faBAsmhd2cI7qV2Ob/EpzcE=;
 b=Ub+l2OP2O4DHJpDpXylSrW8nQGj7Y6uwZKv/3azMrmi2fY3b7gCnWZ9+Kz9LtrdcND
 5k+qpwSlvk6oXt9W2RINLSbMywf9kpzqagkSrcdAMwVyPnK8ZoLgnKNr8BxhI6fZW/4M
 1glEkJDzIcLIWDZS/ERtJ51Ct2m5bKsUHy5OD9zxe9pOZP5CxUmII2k3VigwThmXlxRI
 ApZzyxtZgBEwDFDwkDAzoSFntLKE91+RX9qrGgT8AjYaXcxddoCuVqsv5Ig/3WQPoa2V
 6GoP/kumRY3EwFRlk6DAhJFodbPttTGUs9CJ1g9nIbFQBVZMQ0tdJ55DgIatiIwDXKAA
 K6LQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGIFSDwWFDBKOaspVbTm60ndf1Z8XOYwuhWU9K0k5Q+c7NFrhbcmS6VLJ4TTPtX3LrIVBXoMUm8ZsE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9VbG531xRGv2RgnIUm/Jocaq6YoqcHlD9l5AUlZqS+SEL01dGI
 xM2mtwozjuprpCDyANEE5c3YcVHIZQL2Fx/jmytj68+q0ZQ8QM4T3ugaeqx572DHO8XuIifTs+E
 ct/D8FDu2vmKvdAhoX2v709EhPc1tWxUhiN4+qUd4jD7x7kpIIZwLmg9T2dFQsuAoNGPxVEc=
X-Gm-Gg: AYBFou1nC0gtuRCMqb4VJ7O3I6fPAVFbOYSJwr6KLhWqRbnIH2+p9Oe9rRe/NOwqy1P
 v32CaB7qoe3qFIzmK6AW8pujiSNx6suundSo0VBbnxELo9kHCG/A/1De5nF2wWf6KvkpL+CjZGH
 2SMQ3zQMd5uzdCQaUAAMSnCqkaSIsR+KzQCa0To2ew8G/XYgJybXmLQEnV850OkNc3ubqxa6YNE
 1CRrh+gJIfCyAFF8H1y+Errv7eN/7+dba+3r1Q+dTw7zZRuPur2IfsnEcltq3vyg7baHQRvH7w3
 odt+x6DPNETXY0x61t2ktzJ/23V2hAlI21h6RSmWMOmVFpkZiKaa5WbpD8AJsNQE5YaeHGt8quS
 mAno+cfcVn9Gq6o48Ts1NYmASVMglzW0xvOISyG9g5EVu0wsqyVflC+U68TS3nLeBRERoNydRgl
 7SQcrU6kM=
X-Received: by 2002:a17:90a:da8b:b0:3b0:9e2c:9b57 with SMTP id
 98e67ed59e1d1-3b182df3037mr1802835a91.4.1794381862949; 
 Tue, 10 Nov 2026 23:24:22 -0800 (PST)
X-Received: by 2002:a17:90a:da8b:b0:3b0:9e2c:9b57 with SMTP id
 98e67ed59e1d1-3b182df3037mr1802795a91.4.1794381862393; 
 Tue, 10 Nov 2026 23:24:22 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b17dba5ed0sm3269267a91.17.2026.11.10.23.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 23:24:21 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <9e17c97d-0596-430b-87c7-63099174128d@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:54:09 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/23] drm/msm/dcp: Add DCP VirtIO driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-20-7cf014efdee1@oss.qualcomm.com>
 <lruitisknk6mnkqxa7dxzib4cw3uh3ts2gypetiek4eu6muebd@rl5oyi4kfali>
Content-Language: en-US
In-Reply-To: <lruitisknk6mnkqxa7dxzib4cw3uh3ts2gypetiek4eu6muebd@rl5oyi4kfali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOSBTYWx0ZWRfX4DD8Bc/1WpD5
 5DSXLjebMS3VcF240+cQZvRPxl5Sv/mnWleZN17/C4F+hLFF3GzkceNe8Q4F5qxEEnajeIAUKLO
 jVufw0GLuFskjBDeE/tAVm2BhzO+xO0fu5O0+LVcp8rLAwyexxJcxdXjvfhyX9P1KsDiw4Zw6Na
 /OTM/wb0/o+JLEF2GulN/yLPvAHTRB74aElPCcx8k2qIm/uwa/9qqlDaT1f63zq5wcRJ51+CHe8
 A+7SY+iWG4myqhcrOJ+je5xj1vtaFQ4SDWbODJLFy8+nW1onja7WDB0umPSFOpwf99whQLQoeW4
 sRq856ET8GMo61sCLfctZYd5bCuK7P/ySGvQVNH60LugAUaa9ybzn+Hy52k9dEduYNgrgaw6awG
 vBiU9tRMGDz06JwG3FWC1D0MXccUwyxjZ6xrNmN8h6tdalrqqarwvBAgv0oY1KLoTzrP66Trm1v
 EcfDWOp6vV2xxulJKmw==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af41828 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=j3k-TtDDKKjoNXzRS48A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: _fwephSnAE8KhivQB5YtvUZScJWRJ_t1
X-Proofpoint-ORIG-GUID: _fwephSnAE8KhivQB5YtvUZScJWRJ_t1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOSBTYWx0ZWRfXzJEr4dl+w1Hy
 Q8w0KMTsAwLEjV0f3yf5wNSXPpF72ra223Ut9kOhHzdSfpfLgoxWXIUfwLKoeSZq+WDHSsU8ITU
 bekk5z2CXTwi43bq4IzFEEZoLTwmVEU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110029
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26-10-2026 15:45, Dmitry Baryshkov wrote:
> On Mon, Oct 26, 2026 at 11:51:30AM +0530, Jayant Shekhar wrote:
>> Add the DCP function driver that binds the VirtIO device to MSM
>> DRM. Without a function driver, Linux cannot establish HFI queues,
>> discover firmware capabilities, or register the firmware-owned
>> display backend.
>>
>> Set up the DCP DMA and IOMMU identity, initialize VirtIO and HFI
>> transport, register the MSM DRM component, and synchronize suspend,
>> resume, remove, and shutdown with in-flight HFI activity.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/Makefile         |   2 +
>>   drivers/gpu/drm/msm/dcp/dcp_drv.c    | 191 ++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dcp/dcp_drv.h    |  17 +++
>>   drivers/gpu/drm/msm/dcp/dcp_virtio.c | 258 +++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dcp/dcp_virtio.h |   2 +
>>   drivers/gpu/drm/msm/msm_drv.c        |   6 +-
>>   drivers/gpu/drm/msm/msm_drv.h        |   2 +
>>   7 files changed, 475 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
>> index e1a995a8c980..ffdb159dd9ad 100644
>> --- a/drivers/gpu/drm/msm/Makefile
>> +++ b/drivers/gpu/drm/msm/Makefile
>> @@ -85,6 +85,8 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>>   	dcp/dcp_hfi_plane.o \
>>   	dcp/dcp_ipcc.o \
>>   	dcp/dcp_encoder.o \
>> +	dcp/dcp_drv.o \
>> +	dcp/dcp_virtio.o \
>>   	dcp/dcp_virtio_transport.o \
>>   	dcp/hfi/hfi_packer.o \
>>   	dcp/hfi/hfi_unpacker.o \
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/dcp_drv.c
>> new file mode 100644
>> index 000000000000..8c38de883bf6
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * DCP VirtIO driver.
>> + */
>> +
>> +#include <linux/component.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/panic_notifier.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
>> +
>> +#include "dcp_drv.h"
>> +#include "dcp_dpu_kms.h"
>> +#include "dcp_hfi.h"
>> +#include "dcp_ipcc.h"
>> +#include "dcp_virtio.h"
>> +#include "msm_drv.h"
>> +#include "msm_kms.h"
>> +
>> +int dcp_subsystem_dev_init(struct dcp_drv *drv)
>> +{
>> +	struct virtio_device *vdev = drv->vdev;
>> +	struct device_node *dcp_subsystem_node;
>> +	struct platform_device *pdev;
>> +	struct device *dev;
>> +	char busid[32];
>> +	bool iommu_mapped;
>> +	int ret;
>> +
>> +	dcp_subsystem_node = of_node_get(vdev->dev.of_node);
>> +	if (!dcp_subsystem_node) {
>> +		dev_err(&vdev->dev, "no DCP subsystem DT node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	snprintf(busid, sizeof(busid), "dcp-subsystem.%s", dev_name(vdev->dev.parent));
>> +
>> +	/*
>> +	 * DCP is discovered through VirtIO, but display/HFI buffers must be
>> +	 * mapped through the dcp-subsystem node's DMA/IOMMU identity. Create a
>> +	 * platform device for that DT node so DMA API and msm_kms_init_vm() use
> Does DMA API require platform_device or would it work with the generic
> struct device? In the latter case, should the MSM layer be changed to
> pass struct device instead of struct platform_device?
>
>> +	 * the display function's IOMMU domain.
>> +	 */
>> +	pdev = of_platform_device_create(dcp_subsystem_node, busid, vdev->dev.parent);
>> +	if (!pdev) {
>> +		dev_err(&vdev->dev, "dcp_subsystem_dev creation failed\n");
>> +		of_node_put(dcp_subsystem_node);
>> +		return -ENODEV;
>> +	}
>> +	dev = &pdev->dev;
>> +
>> +	dev->dma_parms = &drv->dcp_subsystem_dma_parms;
>> +	dma_set_max_seg_size(dev, UINT_MAX);
>> +
>> +	ret = of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
>> +	if (ret) {
>> +		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
>> +		goto err_destroy;
>> +	}
>> +
>> +	iommu_mapped = device_iommu_mapped(dev);
>> +	if (!iommu_mapped) {
>> +		dev_err(dev, "no IOMMU group attached\n");
>> +		ret = -ENODEV;
>> +		goto err_destroy;
>> +	}
>> +
>> +	dev_dbg(dev, "dcp-subsystem: iommu_mapped=%d iommu_group=%d\n",
>> +		iommu_mapped,
>> +		dev->iommu_group ? iommu_group_id(dev->iommu_group) : -1);
>> +
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, DCP_DPU_AUTOSUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(dev);
>> +
>> +	drv->dcp_subsystem_dev = pdev;
>> +	drv->dcp_subsystem_node = dcp_subsystem_node;
>> +
>> +	return 0;
>> +
>> +err_destroy:
>> +	of_platform_device_destroy(dev, NULL);
>> +	of_node_put(dcp_subsystem_node);
>> +	return ret;
>> +}
>> +
>> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
>> +{
>> +	if (!drv->dcp_subsystem_dev)
>> +		return;
>> +
>> +	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
>> +	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
>> +	of_node_put(drv->dcp_subsystem_node);
>> +	drv->dcp_subsystem_dev = NULL;
>> +}
>> +
>> +int dcp_pm_prepare(struct device *vdev_dev)
>> +{
>> +	struct dcp_drv *drv = vdev_dev ?
>> +		dev_to_virtio(vdev_dev)->priv : NULL;
>> +
>> +	if (!drv || !drv->dcp_subsystem_dev)
>> +		return 0;
>> +
>> +	return msm_kms_pm_prepare(&drv->dcp_subsystem_dev->dev);
>> +}
>> +
>> +void dcp_pm_complete(struct device *vdev_dev)
>> +{
>> +	struct dcp_drv *drv = vdev_dev ?
>> +		dev_to_virtio(vdev_dev)->priv : NULL;
>> +
>> +	if (!drv || !drv->dcp_subsystem_dev)
>> +		return;
>> +
>> +	msm_kms_pm_complete(&drv->dcp_subsystem_dev->dev);
>> +}
>> +
>> +int dcp_component_register(struct dcp_drv *drv)
>> +{
>> +	struct device *dev = &drv->dcp_subsystem_dev->dev;
>> +	struct component_match *match = NULL;
>> +	int ret;
>> +
>> +	ret = dcp_dpu_kms_init_dsi_bridges(drv->kms, &match);
>> +	if (ret) {
>> +		dev_err(dev, "DSI host initialization failed: %d\n", ret);
>> +		dcp_dpu_kms_cleanup_bridges(drv->kms);
>> +		return ret;
>> +	}
>> +
>> +	/* A GPU is optional for the DCP display-only DRM device. */
>> +	msm_add_gpu_components(dev, &match);
> Missign error handling.
>
>> +
>> +	ret = component_master_add_with_match(dev, &msm_drm_ops, match);
>> +	if (ret) {
>> +		dev_err(dev, "component_master_add_with_match failed: %d\n",
>> +			ret);
>> +		dcp_dpu_kms_cleanup_bridges(drv->kms);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void dcp_component_unregister(struct dcp_drv *drv)
>> +{
>> +	struct device *dev = &drv->dcp_subsystem_dev->dev;
>> +
>> +	component_master_del(dev, &msm_drm_ops);
>> +	dcp_dpu_kms_cleanup_bridges(drv->kms);
>> +}
>> +
>> +static int dcp_panic_notifier_cb(struct notifier_block *nb,
>> +				 unsigned long action, void *data)
>> +{
>> +	struct dcp_drv *drv = container_of(nb, struct dcp_drv, panic_notifier);
>> +
>> +	if (drv->hfi)
>> +		atomic_set(&drv->hfi->shutdown_in_progress, 1);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +void dcp_panic_notifier_register(struct dcp_drv *drv)
>> +{
>> +	drv->panic_notifier.notifier_call = dcp_panic_notifier_cb;
>> +	atomic_notifier_chain_register(&panic_notifier_list, &drv->panic_notifier);
>> +}
>> +
>> +void dcp_panic_notifier_unregister(struct dcp_drv *drv)
>> +{
>> +	atomic_notifier_chain_unregister(&panic_notifier_list, &drv->panic_notifier);
>> +}
>> +
>> +void __init msm_dcp_register(void)
>> +{
>> +	dcp_virtio_register();
>> +}
>> +
>> +void __exit msm_dcp_unregister(void)
>> +{
>> +	dcp_virtio_unregister();
>> +}
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
>> index 16f87035cb9a..3adc5855a9a2 100644
>> --- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
>> @@ -14,6 +14,7 @@
>>   #include "dcp_ipcc.h"
>>   
>>   struct dcp_dpu_kms;
>> +struct component_match;
>>   
>>   struct dcp_drv {
>>   	struct virtio_device	*vdev;
>> @@ -24,6 +25,22 @@ struct dcp_drv {
>>   	struct dcp_dpu_kms	*kms;
>>   	struct dcp_caps		 caps;
>>   	struct notifier_block	 panic_notifier;
>> +	struct dcp_ipcc		*ipcc;
>>   };
>>   
>> +int dcp_subsystem_dev_init(struct dcp_drv *drv);
>> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv);
>> +
>> +int dcp_component_register(struct dcp_drv *drv);
>> +void dcp_component_unregister(struct dcp_drv *drv);
>> +
>> +int dcp_pm_prepare(struct device *vdev_dev);
>> +void dcp_pm_complete(struct device *vdev_dev);
>> +
>> +void dcp_panic_notifier_register(struct dcp_drv *drv);
>> +void dcp_panic_notifier_unregister(struct dcp_drv *drv);
>> +
>> +void __init msm_dcp_register(void);
>> +void __exit msm_dcp_unregister(void);
>> +
>>   #endif /* __DCP_DRV_H__ */
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
>> new file mode 100644
>> index 000000000000..15d5caf02ff5
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
>> @@ -0,0 +1,258 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * DCP VirtIO device driver.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/err.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +#include <linux/slab.h>
>> +
>> +#include "dcp_drv.h"
>> +#include "dcp_dpu_kms.h"
>> +#include "dcp_hfi.h"
>> +#include "dcp_ipcc.h"
>> +#include "dcp_virtio.h"
>> +#include "msm_drv.h"
>> +#include "msm_kms.h"
>> +
>> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv);
>> +
>> +static const unsigned int dcp_virtio_features[] = {
>> +	VIRTIO_F_VERSION_1,
>> +	VIRTIO_F_NOTIFICATION_DATA,
>> +	VIRTIO_F_RING_RESET,
>> +	VIRTIO_F_ACCESS_PLATFORM,
>> +};
>> +
>> +/*
>> + * The VirtIO core owns transport discovery. This driver owns HFI setup and
>> + * creates the DRM component only after firmware capabilities are available.
>> + */
>> +static int dcp_virtio_probe(struct virtio_device *vdev)
>> +{
>> +	struct dcp_drv *drv;
>> +	struct virtqueue *vqs[DCP_NUM_VQS];
>> +	struct virtqueue_info vqs_info[DCP_NUM_VQS] = {
>> +		[DCP_VQ_CMD]  = { .name = "cmd",  .callback = dcp_hfi_cmd_callback },
>> +		[DCP_VQ_RESP] = { .name = "resp", .callback = dcp_hfi_resp_callback },
>> +	};
>> +	struct dcp_dpu_kms *dcp_kms;
>> +	struct msm_drm_private *priv;
>> +	int ret;
>> +
>> +	dev_dbg(&vdev->dev, "DCP VirtIO probe started\n");
>> +
>> +	drv = devm_kzalloc(&vdev->dev, sizeof(*drv), GFP_KERNEL);
>> +	if (!drv)
>> +		return -ENOMEM;
>> +
>> +	drv->vdev = vdev;
>> +	vdev->priv = drv;
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> +		dev_err(&vdev->dev, "VIRTIO_F_VERSION_1 not negotiated\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	drv->ipcc = dcp_virtio_get_ipcc(vdev);
> Here you are breaking the abstraction boundary. The DCP is a VirtIO
> device. You should not use IPCC to communicate with it.
>

Will be addressed in v3.


>> +	/* Access-platform is required for the firmware-visible IOVA mappings. */
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM)) {
>> +		dev_err(&vdev->dev, "VIRTIO_F_ACCESS_PLATFORM not negotiated\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = dcp_subsystem_dev_init(drv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = virtio_find_vqs(vdev, DCP_NUM_VQS, vqs, vqs_info, NULL);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "virtqueue allocation failed: %d\n", ret);
>> +		goto err_fn_dev;
>> +	}
>> +
>> +	ret = dcp_hfi_init(drv, vdev, vqs[DCP_VQ_CMD], vqs[DCP_VQ_RESP],
>> +			   vdev->dev.parent);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "HFI init failed: %d\n", ret);
>> +		goto err_del_vqs;
>> +	}
>> +
>> +	dcp_ipcc_set_resp_vq(drv->ipcc, vqs[DCP_VQ_RESP]);
>> +
>> +	/*
>> +	 * Keep the device unready until HFI state and virtqueues are initialized.
>> +	 * KMS registration below depends on synchronous firmware initialization.
>> +	 */
>> +	virtio_device_ready(vdev);
>> +	virtqueue_kick(drv->hfi->resp_vq);
>> +
>> +	ret = dcp_hfi_send_device_init(drv->hfi);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "HFI DEVICE_INIT failed: %d\n", ret);
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "HFI GET_CAPS failed: %d\n", ret);
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	/* Register the display resources before exposing the DRM component. */
>> +	ret = dcp_hfi_send_resource_register(drv->hfi);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "HFI RESOURCE_REGISTER failed: %d\n", ret);
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	dev_dbg(&vdev->dev,
>> +		"DCP caps: %u displays, max %ux%u, %u planes\n",
>> +		drv->caps.num_displays, drv->caps.max_width, drv->caps.max_height,
>> +		drv->caps.max_planes);
>> +
>> +	dcp_kms = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dcp_kms), GFP_KERNEL);
>> +	if (!dcp_kms) {
>> +		ret = -ENOMEM;
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	dcp_kms->drv       = drv;
>> +	dcp_kms->pm_dev    = &drv->dcp_subsystem_dev->dev;
>> +	dcp_kms->hfi       = drv->hfi;
>> +	dcp_kms->caps      = &drv->caps;
>> +	dcp_kms->dpus_np   = drv->dcp_subsystem_node;
>> +	dcp_kms->iommu_dev = &drv->dcp_subsystem_dev->dev;
>> +	drv->kms        = dcp_kms;
>> +
>> +	ret = msm_kms_init(&dcp_kms->base, &dcp_dpu_kms_funcs);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	priv = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv) {
>> +		ret = -ENOMEM;
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	priv->kms      = &dcp_kms->base;
>> +	priv->kms_init = dcp_kms_init;
>> +	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
>> +	dcp_kms->rpm_enabled = true;
>> +
>> +	/* Component binding now sees initialized HFI, capabilities, and IOMMU state. */
>> +	ret = dcp_component_register(drv);
>> +	if (ret) {
>> +		dev_err_probe(&vdev->dev, ret, "component register failed\n");
>> +		goto err_hfi_deinit;
>> +	}
>> +
>> +	dcp_panic_notifier_register(drv);
>> +
>> +	dev_dbg(&vdev->dev, "DCP VirtIO probe complete\n");
>> +	return 0;
>> +
>> +err_hfi_deinit:
>> +	dcp_virtio_hfi_cleanup(drv);
>> +	goto err_fn_dev;
>> +err_del_vqs:
>> +	virtio_reset_device(vdev);
>> +	vdev->config->del_vqs(vdev);
>> +err_fn_dev:
>> +	dcp_subsystem_dev_deinit(drv);
>> +	return ret;
>> +}
>> +
>> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
>> +{
>> +	struct virtio_device *vdev = drv->vdev;
>> +
>> +	if (!drv->hfi)
>> +		return;
>> +
>> +	dcp_ipcc_set_resp_vq(drv->ipcc, NULL);
>> +
>> +	dcp_hfi_stop(drv->hfi);
>> +	virtio_reset_device(vdev);
>> +	virtio_synchronize_cbs(vdev);
>> +	dcp_hfi_quiesce_queues(drv->hfi);
>> +	vdev->config->del_vqs(vdev);
>> +	dcp_hfi_deinit(drv->hfi);
>> +}
>> +
>> +/* Remove DRM users before tearing down HFI, IPCC, or the VirtIO queues. */
>> +static void dcp_virtio_remove(struct virtio_device *vdev)
>> +{
>> +	struct dcp_drv *drv = vdev->priv;
>> +
>> +	dev_dbg(&vdev->dev, "DCP VirtIO remove\n");
>> +
>> +	dcp_component_unregister(drv);
>> +	dcp_panic_notifier_unregister(drv);
>> +
>> +	dcp_virtio_hfi_cleanup(drv);
>> +
>> +	dcp_subsystem_dev_deinit(drv);
>> +}
>> +
>> +/* KMS shutdown must complete while the firmware transport is available. */
>> +static void dcp_virtio_shutdown(struct virtio_device *vdev)
>> +{
>> +	struct dcp_drv *drv = vdev->priv;
>> +
>> +	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
>> +	msm_kms_shutdown(drv->dcp_subsystem_dev);
>> +	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
>> +}
>> +
>> +static const struct virtio_device_id dcp_virtio_id_table[] = {
>> +	{ VIRTIO_ID_QPSFI, VIRTIO_VENDOR_ID_DCP_HFI },
> What exactly does it mean? Are you using Vendor ID (which should be
> Qualcomm) to distinguish between possible QPSFI devices?
>
>> +	{ 0 },
>> +};
>> +MODULE_DEVICE_TABLE(virtio, dcp_virtio_id_table);
>> +
>> +static const struct dev_pm_ops dcp_virtio_pm_ops = {
>> +	.prepare = dcp_pm_prepare,
>> +	.complete = dcp_pm_complete,
>> +};
>> +
>> +static struct virtio_driver dcp_virtio_driver = {
>> +	.driver = {
>> +		.name  = "qcom-dcp-hfi",
>> +		.owner = THIS_MODULE,
>> +		.pm    = &dcp_virtio_pm_ops,
>> +	},
>> +	.id_table           = dcp_virtio_id_table,
>> +	.feature_table      = dcp_virtio_features,
>> +	.feature_table_size = ARRAY_SIZE(dcp_virtio_features),
>> +	.probe              = dcp_virtio_probe,
>> +	.remove             = dcp_virtio_remove,
>> +	.shutdown           = dcp_virtio_shutdown,
>> +};
>> +
>> +int dcp_virtio_register(void)
>> +{
>> +	int ret;
>> +
>> +	ret = dcp_virtio_transport_register();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = register_virtio_driver(&dcp_virtio_driver);
>> +	if (ret)
>> +		dcp_virtio_transport_unregister();
>> +
>> +	return ret;
>> +}
>> +
>> +void dcp_virtio_unregister(void)
>> +{
>> +	unregister_virtio_driver(&dcp_virtio_driver);
>> +	dcp_virtio_transport_unregister();
>> +}
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
>> index a9c3b9aff61d..3ded8293ab18 100644
>> --- a/drivers/gpu/drm/msm/dcp/dcp_virtio.h
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
>> @@ -8,9 +8,11 @@
>>   
>>   #include <linux/device.h>
>>   #include <linux/virtio.h>
>> +#include <linux/virtio_ids.h>
>>   
>>   struct dcp_drv;
>>   struct dcp_ipcc;
>> +#define VIRTIO_VENDOR_ID_DCP_HFI		1
> Squatting the ID?
>
>>   
>>   struct dcp_ipcc *dcp_virtio_get_ipcc(struct virtio_device *vdev);
>>   
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>> index 5e8f3ce26b32..5816c64d7ce7 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -1093,8 +1093,8 @@ static const struct of_device_id msm_gpu_match[] = {
>>   	{ },
>>   };
>>   
>> -static int add_gpu_components(struct device *dev,
>> -			      struct component_match **matchptr)
>> +int msm_add_gpu_components(struct device *dev,
>> +			   struct component_match **matchptr)
> Separate commit.
>
>>   


Comments to be addressed in v3.


>> {
>>   	struct device_node *np;
>>   
>> @@ -1153,7 +1153,7 @@ int msm_drv_probe(struct device *master_dev,
>>   	}
>>   
>>   	if (!msm_separate_gpu_kms_components()) {
>> -		ret = add_gpu_components(master_dev, &match);
>> +		ret = msm_add_gpu_components(master_dev, &match);
>>   		if (ret)
>>   			return ret;
>>   	}
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index 2840e8a5052d..aa5dfd82ac6f 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -523,6 +523,8 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
>>   /* Driver helpers */
>>   
>>   extern const struct component_master_ops msm_drm_ops;
>> +int msm_add_gpu_components(struct device *dev,
>> +			   struct component_match **matchptr);
>>   
>>   int msm_kms_pm_prepare(struct device *dev);
>>   void msm_kms_pm_complete(struct device *dev);
>>
>> -- 
>> 2.43.0
>>
