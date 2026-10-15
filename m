Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D966CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6C010E6E5;
	Thu, 15 Oct 2026 13:06:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BDF10E571
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:06:44 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jTGW2809328
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nUrRKow716VLDkdUtBEZdLpuUza6F3nodlWQImDHgE8=; b=iVICmAu1oWEE9d4y
 4Z7NDQdxANtuzADVuyeyyMY0KPy5nkDV/E0rDMZLSv2xKWCPSyeo5vYZCYFTeZo1
 1V3/gylNDFX9MJLxijPOVsZrxvM6pKK2Xb9dBCURhSOKrDbZ79Ih+EaiYRLINkpM
 rJPnD73nNu7SflcV/zMNvwrOSqA6Az/q5ZPORDnwJDJWCSnb5ucyWDf4vwRIq0xa
 GXSfWDnlK6Q+XJJXyMmw2BRkWray+HDnm2kVVpsit2QFTMSTwoYPmdT3oSyCzaEW
 fAFCUTjekoHYTuawJQZIQ8pU0KG+hy9nVDaunAbNQw98zQ9mITuR6+uh7wUx0dS8
 AxqkVA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54tq6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:06:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5e9b3a3b849so780151e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792069603; x=1792674403;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nUrRKow716VLDkdUtBEZdLpuUza6F3nodlWQImDHgE8=;
 b=VWQ9hwjRRipZhueMewFSUwuLcpbtBp6y00gMFmKDtH5IpIw8xvpwe+pSC1okzUl2X+
 xy1z+S5pwkNwC+MFCpLQEazNvD7X2GUJcP2QaY6uIJgiikv6nXnkW8cwjS0I3jOB8996
 +D/vcumrAxwrUnWX6JWAi6jb9h3KDTbxCX12y4YEI32C2bkg/+rdNGNJvXGC7LFDsmmL
 dJPD+4Jp/sCwiae+mURcf+boW2wDdTUTebY4tG20E/KnqyIiwsiN1oMFU1Xzb23TFMv+
 8Cy/x7NYlrSPnFjuTvpb0Zb+tN83coSEMAmBWQpBqboK2O6Wl9GK3S0QLBBcrKKADBOr
 aibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069603; x=1792674403;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nUrRKow716VLDkdUtBEZdLpuUza6F3nodlWQImDHgE8=;
 b=witPTl4PxMggbQ2xExWw2GdEkXryxLw2SjI8yUCJEiP/BV/wfNgArvJ8uFp8Y09UAd
 ZLpgjxqigBJd5dsCehEFTEUpof2zA1zYtZv/9Hog1Sod70g5o8a8K8Gv69ybFMXbXPNU
 yUCEJ11lHHgYpCOt2/vqLmp/nmdcyLxYvAdYKzjPnskbxaHc2rL9ElWccPhZNMt9g7DU
 ZdBjZMBaseKEfO7GkIM6LVtSR1LRzd4+5LMoATkKL+kMoSRw/nmIFI7DwFlCyTbGywAi
 Wg0/r3SGwwyPf7G4PVA3szYH1nGsQj+UVAVICah7YMLIe70aWV4q88zRAXzvYOhB1fl2
 z1yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLgnfY+Ss9wG3TlVK30kdfB8lmISO3TbMv+bCgvCOmXvtitR4NOCsninPOyxtfSXmLSVSsruZwpRs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJEc/uMbknmokp/DdjAIOAXZHYeGlBPLK1CVuTTg8yJ+PbJ8HU/
 GWt5ZZitevRmCOeKq1OkNZh4XXE1ybWef9qroN4NMfghz2duAhj7IvaccHKWP5zQzA5CdfWJweu
 1lKS0oB09s16XF/lBZlck3pvXXvskfJQiFhcmudYbk81d9CyiWcJDlSg2A4romfD08x4F1zQ=
X-Gm-Gg: AYBFou1Y/jd/NP7kXXDXNJcrOyk8Zz7jMjUw/J5ernmwLgy+seo/jF/Lo79p085j3JN
 pmOGht+9Jv46aQODWafrYmbGsyyy1zlqntl/zzmeJxMzHhD5Q7+3adJYI8CDBHEu2Y+8LG90ASJ
 rSnmcGjudfkTr4Er9mKFlvrOUmFsE7IIwE82EPcU67W7lnMjzjecnH5nTYQHUybRft0NLEVc06a
 i0KaLJ7w8l/vpfSbK7s5ET1GXLnurRUrWDsH5i6hc8s8L+0s0oeDBYvWoEDFLZyTEkaZyctHrnf
 LTtF6g7iTugJuFTVd+pBGSkkWSde4QgsDxdcjCN1NNQgmsg2XnFWZG1u25pODwTFQPbV/2sInDD
 vg2NyH1d4azHYRl72x1uAlRZvefcOsRFBn4hqezUbuvapSqYh0RyThxagSbL/cGGVKd82g9B2um
 zruaqJzM1Tpr93
X-Received: by 2002:a05:6122:180c:b0:5ea:8f37:3063 with SMTP id
 71dfb90a1353d-5ea8f37349dmr372361e0c.17.1792069602950; 
 Thu, 15 Oct 2026 06:06:42 -0700 (PDT)
X-Received: by 2002:a05:6122:180c:b0:5ea:8f37:3063 with SMTP id
 71dfb90a1353d-5ea8f37349dmr372301e0c.17.1792069602282; 
 Thu, 15 Oct 2026 06:06:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be420bbbf0sm225187e87.79.2026.10.15.06.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 06:06:40 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:06:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 10/13] drm/msm/dcp: Add VirtIO transport and platform
 driver
Message-ID: <gegmh2qb7odywjesxlvrm6knjjwsx6g2xfif2s6wq5zn7y33q4@gpdwz2ajlm4i>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-10-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-10-48aad0fe4f72@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad0cfe3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8UvxyRjR-zxYBsYGV0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfXzZ5R4dYkVCpO
 t9ZbdDW8BEIcPJBPwcZCaVwSTeLlXITTcWSifsvUeR1ZyQauuxmVVKtxiyMdNeAT7CfnNBWfsvB
 GPWBJFAmZvL1CJSNb54Cpn/zdxXIS0NzO508K9lgX+f0E1c0DrLhPbIL3tHlwB99XRNVPwNhuY6
 QMonYfXEMwFVumS4xbhOnBRsYFqP7fhlf6LtUGJOOCStGNsMz2n/IgnJBfkh+lbGIP1x9FKhEPN
 6mGOlC+AUCJ3pjAuheZhME7U6kIgkLw7+EUDKx8jeB7BCQrVeG1YAR8lMQE+vndy8gG+rhi7tlW
 Ybi7R3MR/xkes5UrzBDpI2WWgqJhbF+I7ME+VhjIMHYj84BomKaEYziImc5JKlH8gjVjIXrzfRJ
 KQbMyPmLfvnsdENYNZh/flBHrZAWByqMydu8ulGxBIlXpUTHhz1+YKDBjVj7E3eDlN584/ye+yA
 YTicJzH7Vhw0kn23UYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX/Xy/VaAB+aQM
 BuSYKYXIxoLyedIw/YdE/u0tl3JMRoSzH+JjsHjMtruAhi3H3n1hqFghGCaeBM14GddcbqXqtQ0
 OIlrdobmLpWQCUP6X2c9z60vo5fo4Is=
X-Proofpoint-GUID: Tc3IY5dkJVZeOOsS-ZjXVhdtsDIdX8UT
X-Proofpoint-ORIG-GUID: Tc3IY5dkJVZeOOsS-ZjXVhdtsDIdX8UT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150052
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

On Thu, Oct 15, 2026 at 01:08:30PM +0530, Jayant Shekhar wrote:
> DCP display hardware is controlled by firmware and exposed to Linux as a
> VirtIO function. The MSM DRM driver needs a platform driver to establish
> the transport, DMA/IOMMU address spaces, power-notify path, and display
> component.
> 
> Add the VirtIO-MMIO transport and DCP platform-function driver. Set up the
> DMA/IOMMU identity, IPCC client, VirtIO queues, HFI transport, firmware
> capability handling, and MSM DRM registration. Synchronize suspend, resume,
> remove, and shutdown with in-flight HFI activity.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile         |   2 +
>  drivers/gpu/drm/msm/dcp/dcp_drv.c    | 245 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_drv.h    |  19 +++
>  drivers/gpu/drm/msm/dcp/dcp_virtio.c | 302 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_virtio.h |  22 +++
>  5 files changed, 590 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 9910bd4f306d..e57aee483137 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -83,6 +83,8 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_ipcc.o \
>  	dcp/dcp_plane.o \
>  	dcp/dcp_encoder.o \
> +	dcp/dcp_drv.o \
> +	dcp/dcp_virtio.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/dcp_drv.c
> new file mode 100644
> index 000000000000..e7016937a028
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP VirtIO driver.
> + */
> +
> +#include <linux/component.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/pm_runtime.h>
> +
> +#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
> +
> +#include "dcp_drv.h"
> +#include "dcp_hfi.h"
> +#include "dcp_ipcc.h"
> +#include "dcp_virtio.h"
> +#include "msm_drv.h"
> +#include "msm_kms.h"
> +
> +int dcp_subsystem_dev_init(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev = drv->vdev;
> +	struct device_node *dcp_subsystem_node;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	char busid[32];
> +	int ret;
> +
> +	dcp_subsystem_node = of_get_child_by_name(vdev->dev.parent->of_node,
> +						  "dcp-subsystem");
> +	if (!dcp_subsystem_node) {
> +		dev_err(&vdev->dev, "no dcp-subsystem DT node\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(busid, sizeof(busid), "dcp-subsystem.%s", dev_name(vdev->dev.parent));
> +
> +	/*
> +	 * DCP is discovered through VirtIO, but display/HFI buffers must be
> +	 * mapped through the dcp-subsystem node's DMA/IOMMU identity. Create a
> +	 * platform device for that DT node so DMA API and msm_kms_init_vm() use
> +	 * the display function's IOMMU domain.
> +	 */
> +	pdev = of_platform_device_create(dcp_subsystem_node, busid, vdev->dev.parent);
> +	if (!pdev) {
> +		dev_err(&vdev->dev, "dcp_subsystem_dev creation failed\n");
> +		of_node_put(dcp_subsystem_node);
> +		return -ENODEV;
> +	}
> +	dev = &pdev->dev;
> +
> +	dev->dma_parms = &drv->dcp_subsystem_dma_parms;
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
> +	ret = of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
> +	if (ret) {
> +		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
> +		goto err_destroy;
> +	}
> +
> +	if (!device_iommu_mapped(dev)) {
> +		dev_err(dev, "no IOMMU group attached\n");
> +		ret = -ENODEV;
> +		goto err_destroy;
> +	}
> +
> +	dev_dbg(dev, "dcp-subsystem: iommu_mapped=%d iommu_group=%d\n",
> +		device_iommu_mapped(dev),
> +		 dev->iommu_group ? iommu_group_id(dev->iommu_group) : -1);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, DCP_DPU_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	drv->dcp_subsystem_dev = pdev;
> +	drv->dcp_subsystem_node = dcp_subsystem_node;
> +
> +	return 0;
> +
> +err_destroy:
> +	of_platform_device_destroy(dev, NULL);
> +	of_node_put(dcp_subsystem_node);
> +	return ret;
> +}
> +
> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
> +{
> +	if (!drv->dcp_subsystem_dev)
> +		return;
> +
> +	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
> +	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
> +	of_node_put(drv->dcp_subsystem_node);
> +	drv->dcp_subsystem_dev = NULL;
> +}
> +
> +int dcp_pm_prepare(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return 0;
> +
> +	return msm_kms_pm_prepare(&drv->dcp_subsystem_dev->dev);
> +}
> +
> +void dcp_pm_complete(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return;
> +
> +	msm_kms_pm_complete(&drv->dcp_subsystem_dev->dev);
> +}
> +
> +static int dcp_pm_ipcc_notify(struct dcp_drv *drv)
> +{
> +	int ret;
> +
> +	if (!drv->ipcc_valid)
> +		return 0;
> +
> +	ret = dcp_ipcc_send_power_notify(&drv->ipcc);

An indirection just for the sake of indirection? Can we drop one-line
wrappers?

> +	if (ret)
> +		dev_warn(&drv->vdev->dev,
> +			 "IPCC power notification failed during PM: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int dcp_pm_suspend(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return 0;
> +
> +	return dcp_pm_ipcc_notify(drv);
> +}
> +
> +int dcp_pm_resume(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return 0;
> +
> +	return dcp_pm_ipcc_notify(drv);
> +}
> +
> +static int dcp_self_bind(struct device *master, struct device *dev, void *data)
> +{
> +	return 0;
> +}
> +
> +static void dcp_self_unbind(struct device *master, struct device *dev,
> +			    void *data)
> +{
> +}
> +
> +static const struct component_ops dcp_self_ops = {
> +	.bind   = dcp_self_bind,
> +	.unbind = dcp_self_unbind,
> +};
> +
> +int dcp_component_register(struct dcp_drv *drv)
> +{
> +	struct device *dev = &drv->dcp_subsystem_dev->dev;
> +	struct component_match *match = NULL;
> +	int ret;
> +
> +	/*
> +	 * DCP has no host-visible display subcomponents: firmware owns the
> +	 * underlying display blocks. The self component is only the minimal shim
> +	 * needed to enter the existing MSM DRM component-master init path without
> +	 * adding a DCP-specific entry point to common MSM DRM code.
> +	 */

And how does that work with the DSI probing sequences? The panel driver
might be not (yet) available when you probe the DCP. The driver should
register the DSI host, create DSI devices, but the DRM device
registration is only possible when the panel / bridge has attached to
the DSI host. See how it's handled by the mdp4/mdp5/dpu drivers.

> +	ret = component_add(dev, &dcp_self_ops);
> +	if (ret) {
> +		dev_err(dev, "component_add failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	component_match_add(dev, &match, component_compare_dev, dev);

Missing optional GPU match. I think I wrote that before...

> +
> +	ret = component_master_add_with_match(dev, &msm_drm_ops, match);
> +	if (ret) {
> +		dev_err(dev, "component_master_add_with_match failed: %d\n",
> +			ret);
> +		component_del(dev, &dcp_self_ops);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void dcp_component_unregister(struct dcp_drv *drv)
> +{
> +	struct device *dev = &drv->dcp_subsystem_dev->dev;
> +
> +	component_master_del(dev, &msm_drm_ops);
> +	component_del(dev, &dcp_self_ops);
> +}
> +
> +static int dcp_panic_notifier_cb(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct dcp_drv *drv = container_of(nb, struct dcp_drv, panic_notifier);
> +
> +	if (drv->hfi)
> +		atomic_set(&drv->hfi->shutdown_in_progress, 1);
> +
> +	return NOTIFY_OK;
> +}
> +
> +void dcp_panic_notifier_register(struct dcp_drv *drv)
> +{
> +	drv->panic_notifier.notifier_call = dcp_panic_notifier_cb;
> +	atomic_notifier_chain_register(&panic_notifier_list, &drv->panic_notifier);
> +}
> +
> +void dcp_panic_notifier_unregister(struct dcp_drv *drv)
> +{
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &drv->panic_notifier);
> +}
> +
> +void __init msm_dcp_register(void)
> +{
> +	dcp_virtio_register();
> +}
> +
> +void __exit msm_dcp_unregister(void)
> +{
> +	dcp_virtio_unregister();
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> index af2db3cf9066..ca8e5bd284e0 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> @@ -26,6 +26,25 @@ struct dcp_drv {
>  	struct dcp_dpu_kms	*kms;
>  	struct dcp_caps		 caps;
>  	struct notifier_block	 panic_notifier;
> +	struct dcp_ipcc		 ipcc;
> +	bool			 ipcc_valid;
>  };
>  
> +int dcp_subsystem_dev_init(struct dcp_drv *drv);
> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv);
> +
> +int dcp_component_register(struct dcp_drv *drv);
> +void dcp_component_unregister(struct dcp_drv *drv);
> +
> +int dcp_pm_prepare(struct device *vdev_dev);
> +void dcp_pm_complete(struct device *vdev_dev);
> +int dcp_pm_suspend(struct device *vdev_dev);
> +int dcp_pm_resume(struct device *vdev_dev);
> +
> +void dcp_panic_notifier_register(struct dcp_drv *drv);
> +void dcp_panic_notifier_unregister(struct dcp_drv *drv);
> +
> +void __init msm_dcp_register(void);
> +void __exit msm_dcp_unregister(void);
> +
>  #endif /* __DCP_DRV_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
> new file mode 100644
> index 000000000000..b2aeb03688c9
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP VirtIO device driver.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +
> +#include "dcp_drv.h"
> +#include "dcp_dpu_kms.h"
> +#include "dcp_hfi.h"
> +#include "dcp_ipcc.h"
> +#include "dcp_virtio.h"
> +#include "msm_drv.h"
> +#include "msm_kms.h"
> +
> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv);
> +
> +static const unsigned int dcp_virtio_features[] = {
> +	VIRTIO_F_VERSION_1,
> +	VIRTIO_F_NOTIFICATION_DATA,
> +	VIRTIO_F_RING_RESET,
> +	VIRTIO_F_ACCESS_PLATFORM,
> +};
> +
> +/*
> + * The VirtIO core owns transport discovery. This driver owns HFI setup and
> + * creates the DRM component only after firmware capabilities are available.
> + */
> +static int dcp_virtio_probe(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv;
> +	struct virtqueue *vqs[DCP_NUM_VQS];
> +	struct virtqueue_info vqs_info[DCP_NUM_VQS] = {
> +		[DCP_VQ_CMD]  = { .name = "cmd",  .callback = dcp_hfi_cmd_callback },
> +		[DCP_VQ_RESP] = { .name = "resp", .callback = dcp_hfi_resp_callback },
> +	};
> +	struct dcp_dpu_kms *dpu_kms;
> +	struct msm_drm_private *priv;
> +	int ret;
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO probe started\n");
> +
> +	drv = devm_kzalloc(&vdev->dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->vdev = vdev;
> +	vdev->priv = drv;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev, "VIRTIO_F_VERSION_1 not negotiated\n");
> +		return -ENODEV;
> +	}
> +	/* Access-platform is required for the firmware-visible IOVA mappings. */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM)) {
> +		dev_err(&vdev->dev, "VIRTIO_F_ACCESS_PLATFORM not negotiated\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = dcp_subsystem_dev_init(drv);
> +	if (ret)
> +		return ret;
> +
> +	ret = dcp_ipcc_init(&drv->ipcc, vdev->dev.parent);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			dev_err_probe(&vdev->dev, ret,
> +				      "IPCC not ready, deferring probe\n");
> +		else
> +			dev_err(&vdev->dev, "IPCC init failed: %d\n", ret);
> +		goto err_fn_dev;
> +	}
> +	drv->ipcc_valid = !!drv->ipcc.power_chan;
> +
> +	ret = virtio_find_vqs(vdev, DCP_NUM_VQS, vqs, vqs_info, NULL);
> +	if (ret) {
> +		dev_err(&vdev->dev, "virtqueue allocation failed: %d\n", ret);
> +		goto err_ipcc;
> +	}
> +
> +	ret = dcp_hfi_init(drv, vdev, vqs[DCP_VQ_CMD], vqs[DCP_VQ_RESP],
> +			   vdev->dev.parent);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI init failed: %d\n", ret);
> +		goto err_del_vqs;
> +	}
> +
> +	if (drv->ipcc_valid)
> +		dcp_ipcc_set_resp_vq(&drv->ipcc, vqs[DCP_VQ_RESP]);
> +
> +	/*
> +	 * Keep the device unready until HFI state and virtqueues are initialized.
> +	 * KMS registration below depends on synchronous firmware initialization.
> +	 */
> +	virtio_device_ready(vdev);
> +	virtqueue_kick(drv->hfi->resp_vq);
> +
> +	ret = dcp_hfi_send_device_init(drv->hfi);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI DEVICE_INIT failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI GET_CAPS failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	/* Register the display resources before exposing the DRM component. */
> +	ret = dcp_hfi_send_resource_register(drv->hfi);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI RESOURCE_REGISTER failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	dev_dbg(&vdev->dev,
> +		"DCP caps: %u displays, max %ux%u, %u planes, features=0x%x\n",
> +		 drv->caps.num_crtcs, drv->caps.max_width, drv->caps.max_height,
> +		 drv->caps.max_planes, drv->caps.features);
> +
> +	dpu_kms = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dpu_kms), GFP_KERNEL);
> +	if (!dpu_kms) {
> +		ret = -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	dpu_kms->drv       = drv;
> +	dpu_kms->pm_dev    = &drv->dcp_subsystem_dev->dev;
> +	dpu_kms->hfi       = drv->hfi;
> +	dpu_kms->caps      = &drv->caps;
> +	dpu_kms->dpus_np   = drv->dcp_subsystem_node;
> +	dpu_kms->iommu_dev = &drv->dcp_subsystem_dev->dev;
> +
> +	ret = msm_kms_init(&dpu_kms->base, &dcp_dpu_kms_funcs);
> +	if (ret) {
> +		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv->kms      = &dpu_kms->base;
> +	priv->kms_init = dcp_kms_init;
> +	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
> +	dpu_kms->rpm_enabled = true;
> +
> +	/* Component binding now sees initialized HFI, capabilities, and IOMMU state. */
> +	ret = dcp_component_register(drv);
> +	if (ret) {
> +		dev_err(&vdev->dev, "component register failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	dcp_panic_notifier_register(drv);
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO probe complete\n");
> +	return 0;
> +
> +err_hfi_deinit:
> +	dcp_virtio_hfi_cleanup(drv);
> +	goto err_ipcc;
> +err_del_vqs:
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +err_ipcc:
> +	if (drv->ipcc_valid) {
> +		dcp_ipcc_deinit(&drv->ipcc);
> +		drv->ipcc_valid = false;
> +	}
> +err_fn_dev:
> +	dcp_subsystem_dev_deinit(drv);
> +	return ret;
> +}
> +
> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev = drv->vdev;
> +
> +	if (!drv->hfi)
> +		return;
> +
> +	dcp_hfi_stop(drv->hfi);
> +	virtio_reset_device(vdev);
> +	virtio_synchronize_cbs(vdev);
> +	vdev->priv = NULL;
> +	dcp_hfi_quiesce_queues(drv->hfi);
> +	vdev->config->del_vqs(vdev);
> +	dcp_hfi_deinit(drv->hfi);
> +	drv->hfi = NULL;

What's the point of setting pointers to NULL? Won't this memory be
kfree()'d soon?

> +}
> +
> +/*
> + * Remove DRM users before tearing down HFI, IPCC, or the VirtIO queues.
> + */
> +static void dcp_virtio_remove(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv = vdev->priv;
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO remove\n");
> +
> +	if (!drv)
> +		return;
> +
> +	dcp_component_unregister(drv);
> +	dcp_panic_notifier_unregister(drv);
> +
> +	dcp_virtio_hfi_cleanup(drv);
> +
> +	if (drv->ipcc_valid) {
> +		dcp_ipcc_deinit(&drv->ipcc);
> +		drv->ipcc_valid = false;
> +	}
> +
> +	dcp_subsystem_dev_deinit(drv);
> +}
> +
> +/* KMS shutdown must complete while the firmware transport is available. */
> +static void dcp_virtio_shutdown(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv = vdev->priv;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return;
> +
> +	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
> +	msm_kms_shutdown(drv->dcp_subsystem_dev);
> +	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
> +}
> +
> +/*
> + * Firmware capabilities may change independently of the VirtIO transport;
> + * refresh them without rebuilding the DRM device.

And what does that mean? How can they change?

> + */
> +static void dcp_virtio_config_changed(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv = vdev->priv;
> +	int ret;
> +
> +	dev_dbg(&vdev->dev, "VirtIO config changed — re-querying DCP capabilities\n");
> +
> +	if (!drv || !drv->hfi)
> +		return;
> +
> +	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
> +	if (ret)
> +		dev_err(&vdev->dev,
> +			"config_changed: capability re-query failed: %d\n", ret);
> +	else
> +		dev_dbg(&vdev->dev,
> +			"config_changed: DCP caps updated: %u displays, features=0x%x\n",
> +			 drv->caps.num_crtcs, drv->caps.features);
> +}
> +

[...]

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
> new file mode 100644
> index 000000000000..fe244bc5b51a
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP VirtIO driver interface.
> + */
> +
> +#ifndef __DCP_VIRTIO_H__
> +#define __DCP_VIRTIO_H__
> +
> +#include <linux/device.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ids.h>
> +
> +struct dcp_drv;
> +
> +#define VIRTIO_ID_QPSFI		                52
> +#define VIRTIO_VENDOR_ID_DCP_HFI		    1

I think this was questioned by Bjorn. Is it described somewhere? Is it a
part of the VirtIO spec? If so, add these ids to the VirtIO headers. If
not... then it's squatting. We can't just randomly settle on the ID.

> +
> +int dcp_virtio_register(void);
> +void dcp_virtio_unregister(void);
> +
> +#endif /* __DCP_VIRTIO_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
