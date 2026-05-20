Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC2ECD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D07510E13A;
	Wed, 20 May 2026 14:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/FSlRFT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLuc/K2y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537B410E13A
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:18:19 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuXDK3680415
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WP9MtY8PpeA3BVDLSTnY8xx4
 g/DgRi3AAF8a/7DvDg8=; b=P/FSlRFTvTcvcco2O49bbM7wxYzHWNpQXafrBC2o
 pDyNRu9ZxvU2tFZ5AfztKPniYbHwgBrPuQV/c8RUG9jCAtghiap8rKbSAE2X1x7l
 3QDTDwvJCrb9dMRjZ3sEhE9ZboGcdg/9gRgOqSlU0X97tRGl+h+DMHyDWU3zm5oD
 K7ZWulABgfRWQFp5Xrel+5yCLU4etfSq9AcHSRmghysjRymq0y0Xi54Aco1wsc/Z
 AgM+Dbpaa0ukxZ87dwqQjkqcZgu6eDk95/cRyLuqyzGEx4ew8flbmULd4nNCBS15
 i7ii056JUDEsBo9A6FhuaS/hvnLptPrJuhO+AK66Pv3zZw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j02q2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:18:18 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e3a5fc58feso13863542a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779286698; x=1779891498;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WP9MtY8PpeA3BVDLSTnY8xx4g/DgRi3AAF8a/7DvDg8=;
 b=TLuc/K2yIelFOBHobnxGHwiADf7Q2bj9sQLNBWLqDNoMnpPyy+yQ8by3cn9KIaVnE3
 AOBW+2s1o+BC+1zjsHT9eZULHCC0q+00XVF1WYQvMTESA+U7dV56MULii4Jqf87NwQMA
 2zgx7GTvDlNok/tqG4yVKyhrcqnflVfe1iDlXFe8/yjO2kISDHPwI77KobPI/XAjXU/g
 qJoVZCrhJluSzOT+MSIzpC08PZkL/zjzuspnSKehUwLe7dsc9P+dMGVOvl2bWcfXF7DY
 M1yQuYpYd3mLqeV5DOK2iZCp7ukSV7jY3ViQbl1TzpQ0Xd5CJqbIGvUhCT+55hg6oPQz
 uEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286698; x=1779891498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WP9MtY8PpeA3BVDLSTnY8xx4g/DgRi3AAF8a/7DvDg8=;
 b=ChVc2619x57g5aCowkmoCdKx//cO5lcKGTOzTJj2WXKCVXc5lP/5VhvbpnXP8/iOl3
 aAOLtd8o5W3hWj0p9xQQbpDJKCtJbIwTkCXMePjvZ0vEZ97iSwEZkLwXCXyzLQfVE9OU
 EcpYRGVNKrjWNP80Yq0QNDPisUm3csC7n+HN4FFiiMJf5c8rMlf1O6KnVIWcBTMLimoC
 xmfwButPzz+FQLhQKuHg/26Ra0Rz17WFxh1M4wLucDC6D8dugtXrYEIhkAt7QmCQOR1r
 2+sV5roGZ0L7FCbR93ahSvZ/aMTIBt4w5RbBQOv9cCtcPgG3LQ3aR9dngx5c021t1pML
 VnwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eozzli4onjE9FQX2SbzPb+GxvbaKpi4bGJr9RAlM3gjVCdu/LXqLKVSlBhJkipJThytSCuxotDDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+Ix3aTb5/sLAM/U45LhlzYxjnaEf3+FxMYO1OvSC45w2of0u8
 XfPGjV9baYhzYoqHSeEuzM1j0AFlBuJpyxlXt642+w/WSw0oDW/lCiq43JXu8ittMtIGK5Plp9z
 cj7ilTzUnbiN9Eitnb+eroVKTdbhLuIBC/ge3+/64Ghi25tj3irCSWO/TLCaLo/ndgKWT67o=
X-Gm-Gg: Acq92OGPfiCJljf2CSdLLZ47Prj0Bm70Ij+WlwXrVifa87chLwkpYGWfnEGy+OJXDhR
 Aid1a9SkbhXLZvs9U6NdveaoTMvkB2r+ZJMoGPcRPJtn3NdL8DAXJRWPu7kw9BcixBL2tx1dn2w
 OGhlwlPdQCkiHdWSz/uvkRh/ycIzFkTuGLDF1UwC120lzqmq9VHFO/VKTE6bi8mEx6xSjI/cIwp
 Mh/XCV5zdo27ILtEIzGBd13u8SyoUUHmxFhaONvZV7syXcXfzOMVaH2xBuMONkutzmSe+eBpkbu
 ZjSdsf3V3kf5GPKuLbCtNS0P3qTV4BOQMq0ovoCM+6Zx5QHsCWgBZwNcOwwMgKAykUqSC3I/F/W
 6wvZPXcc43EJ+OVfANejQfiX9JY1uPrLyjpE7iY4ti4m1z6tufZEk/ZUlWARJSg897ERhORyc5D
 mGJCjiFo/22kMMALu97ytRqCrUSZxLmlhRpKI=
X-Received: by 2002:a05:6830:4394:b0:7dc:de56:d75a with SMTP id
 46e09a7af769-7e4ea04ccbemr17929224a34.4.1779286697767; 
 Wed, 20 May 2026 07:18:17 -0700 (PDT)
X-Received: by 2002:a05:6830:4394:b0:7dc:de56:d75a with SMTP id
 46e09a7af769-7e4ea04ccbemr17929163a34.4.1779286697219; 
 Wed, 20 May 2026 07:18:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cf803sm5080846e87.76.2026.05.20.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:18:16 -0700 (PDT)
Date: Wed, 20 May 2026 17:18:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 03/15] accel/qda: Add initial QDA DRM accelerator driver
Message-ID: <wbrrredwk2id5ntjlvxhk66uxxa6elwbqg2sj2jmrydz7ss4qz@hsvwcj4iocsu>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-3-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-3-b2d984c297f8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dc2aa cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=KxzzkAsT-b1q7BVvj_IA:9 a=CjuIK1q_8ugA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: 6MMJ2RpMN0HIi60E87HV7jQNBsly8BFj
X-Proofpoint-ORIG-GUID: 6MMJ2RpMN0HIi60E87HV7jQNBsly8BFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOSBTYWx0ZWRfX4smZ8J5lsEBc
 c8eLh4Y7fG4T+t4WfYGmj+82N2xetPHnze2ueJjB6uqnCQoAO5cFQaWyjrTiNtzH4FuW30uwMnX
 NVip3L1ALbLFYLVtY3JcjpKDIpru5aLcywBozNroeHXAUhHTxrIcEhG5R2alGmtg6IovCmcaE8a
 5P6I+LlkJz26bNL8D/8zpurgdnHKrJXwmTtBbrepcL6fPWP21OYXgw3GkS6uwL65zNswJyp49W7
 dNAUF7udN4eDIjn4UuTYR42HfSK4zqW4ay9FmjkxyTNTPf/p1tgwzVZg1KKKBROu1VcLpnYUEFr
 7vucSZYIXu6cppq66lpA5LzuRxhpDbPw50m8dNznVnqLbKTiUt8YIwlhezH3M2Pu8xEAszVWKd8
 0sXe7u3VTQ9C63KnlOgsliFABxqsaExl+1fNdc/rdagKii37GD07z/kJeGUphOraeENgQhBoP+l
 I0KJ1W8dMSa/RHyFhGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200139
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

On Tue, May 19, 2026 at 11:45:53AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Add the foundational driver files for the Qualcomm DSP Accelerator
> (QDA), a DRM accel driver for Qualcomm DSPs. The driver integrates
> with the DRM accel subsystem (drivers/accel/) and provides:
> 
>   - A standard /dev/accel/accel* character device node via DRM.
>   - GEM-based buffer management with DMA-BUF import/export (PRIME).
>   - IOMMU context bank management for per-session memory isolation.
>   - Standard DRM IOCTLs for device management and job submission.
> 
> qda_drv.c / qda_drv.h: Core DRM driver registration. Defines the
> drm_driver ops table, per-file private state (qda_file_priv), and the
> main device structure (qda_dev) which embeds drm_device.
> 
> qda_rpmsg.c / qda_rpmsg.h: RPMsg transport layer. Registers an
> rpmsg_driver matching the "qcom,fastrpc" compatible string. On probe
> it allocates a qda_dev, reads the DSP domain name from the "label" DT
> property, and registers the DRM device.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/Kconfig         |  1 +
>  drivers/accel/Makefile        |  1 +
>  drivers/accel/qda/Kconfig     | 30 +++++++++++++
>  drivers/accel/qda/Makefile    | 10 +++++
>  drivers/accel/qda/qda_drv.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_drv.h   | 62 +++++++++++++++++++++++++++
>  drivers/accel/qda/qda_rpmsg.c | 99 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_rpmsg.h | 13 ++++++
>  8 files changed, 313 insertions(+)
> 
> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> index bdf48ccafcf2..74ac0f71bc9d 100644
> --- a/drivers/accel/Kconfig
> +++ b/drivers/accel/Kconfig
> @@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
>  source "drivers/accel/habanalabs/Kconfig"
>  source "drivers/accel/ivpu/Kconfig"
>  source "drivers/accel/qaic/Kconfig"
> +source "drivers/accel/qda/Kconfig"
>  source "drivers/accel/rocket/Kconfig"
>  
>  endif
> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> index 1d3a7251b950..58c08dd5f389 100644
> --- a/drivers/accel/Makefile
> +++ b/drivers/accel/Makefile
> @@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> +obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> \ No newline at end of file
> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
> new file mode 100644
> index 000000000000..484d21ff1b55
> --- /dev/null
> +++ b/drivers/accel/qda/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Qualcomm DSP accelerator driver
> +#
> +
> +config DRM_ACCEL_QDA
> +	tristate "Qualcomm DSP accelerator"
> +	depends on DRM_ACCEL
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on RPMSG
> +	help
> +	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
> +	  This driver provides a standardized interface for offloading computational
> +	  tasks to the DSP, including audio processing, sensor offload, computer
> +	  vision, and AI inference workloads.
> +
> +	  The driver supports all DSP domains (ADSP, CDSP, SDSP, GDSP) and
> +	  implements the FastRPC protocol for communication between the application
> +	  processor and DSP. It integrates with the Linux kernel's Compute
> +	  Accelerators subsystem (drivers/accel/) and provides a modern alternative
> +	  to the legacy FastRPC driver found in drivers/misc/.
> +
> +	  Key features include DMA-BUF interoperability for seamless buffer sharing

Key features of what? Consider distro maintainers reading your help text
in order to identify whether to enable it or not.

> +	  with other multimedia subsystems, IOMMU-based memory isolation, and
> +	  standard DRM IOCTLs for device management and job submission.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called qda.
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> new file mode 100644
> index 000000000000..dbe809067a8b
> --- /dev/null
> +++ b/drivers/accel/qda/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for Qualcomm DSP accelerator driver
> +#
> +
> +obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
> +
> +qda-y := \
> +	qda_drv.o \
> +	qda_rpmsg.o
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> new file mode 100644
> index 000000000000..1c1bab68d445
> --- /dev/null
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <drm/drm_accel.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_ioctl.h>
> +#include <drm/drm_print.h>
> +
> +#include "qda_drv.h"
> +#include "qda_rpmsg.h"
> +
> +static int qda_open(struct drm_device *dev, struct drm_file *file)
> +{
> +	struct qda_file_priv *qda_file_priv;
> +
> +	qda_file_priv = kzalloc_obj(*qda_file_priv);
> +	if (!qda_file_priv)
> +		return -ENOMEM;
> +
> +	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
> +	file->driver_priv = qda_file_priv;
> +
> +	return 0;
> +}
> +
> +static void qda_postclose(struct drm_device *dev, struct drm_file *file)
> +{
> +	struct qda_file_priv *qda_file_priv = file->driver_priv;
> +
> +	kfree(qda_file_priv);
> +	file->driver_priv = NULL;
> +}
> +
> +DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
> +
> +static const struct drm_driver qda_drm_driver = {
> +	.driver_features = DRIVER_COMPUTE_ACCEL,
> +	.fops = &qda_accel_fops,
> +	.open = qda_open,
> +	.postclose = qda_postclose,
> +	.name = QDA_DRIVER_NAME,
> +	.desc = "Qualcomm DSP Accelerator Driver",
> +};
> +
> +struct qda_dev *qda_alloc_device(struct device *dev)
> +{
> +	struct qda_dev *qdev;
> +
> +	qdev = devm_drm_dev_alloc(dev, &qda_drm_driver, struct qda_dev, drm_dev);
> +	if (IS_ERR(qdev))
> +		return ERR_CAST(qdev);
> +
> +	return qdev;
> +}
> +
> +void qda_unregister_device(struct qda_dev *qdev)
> +{
> +	drm_dev_unregister(&qdev->drm_dev);
> +}
> +
> +int qda_register_device(struct qda_dev *qdev)
> +{
> +	int ret;
> +
> +	ret = drm_dev_register(&qdev->drm_dev, 0);
> +	if (ret)
> +		drm_err(&qdev->drm_dev, "Failed to register DRM device: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int __init qda_core_init(void)
> +{
> +	int ret;
> +
> +	ret = qda_rpmsg_register();
> +	if (ret)
> +		return ret;
> +
> +	pr_info("qda: QDA driver initialization complete\n");
> +	return 0;
> +}
> +
> +static void __exit qda_core_exit(void)
> +{
> +	qda_rpmsg_unregister();
> +}
> +
> +module_init(qda_core_init);
> +module_exit(qda_core_exit);
> +
> +MODULE_AUTHOR("Qualcomm AI Infra Team");
> +MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> new file mode 100644
> index 000000000000..7ba2ef19a411
> --- /dev/null
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_DRV_H__
> +#define __QDA_DRV_H__
> +
> +#include <linux/device.h>
> +#include <linux/rpmsg.h>
> +#include <linux/types.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +
> +/* Driver identification */
> +#define QDA_DRIVER_NAME "qda"
> +
> +/**
> + * struct qda_file_priv - Per-process private data for DRM file
> + */
> +struct qda_file_priv {
> +	/** @qda_dev: Back-pointer to device structure */
> +	struct qda_dev *qda_dev;
> +};
> +
> +/**
> + * struct qda_dev - Main device structure for QDA driver
> + *
> + * The DRM device is embedded as the first member so that container_of()
> + * can recover the qda_dev from any drm_device pointer.
> + */
> +struct qda_dev {
> +	/** @drm_dev: Embedded DRM device; recover via qda_dev_from_drm() */
> +	struct drm_device drm_dev;
> +	/** @rpdev: RPMsg device for communication with the remote processor */
> +	struct rpmsg_device *rpdev;
> +	/** @dev: Underlying Linux device */
> +	struct device *dev;
> +	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
> +	const char *dsp_name;
> +};
> +
> +/**
> + * qda_dev_from_drm - Recover qda_dev from an embedded drm_device pointer
> + * @dev: Pointer to the embedded drm_device
> + *
> + * Return: Pointer to the enclosing qda_dev.
> + */
> +static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
> +{
> +	return container_of(dev, struct qda_dev, drm_dev);
> +}
> +
> +/* Device allocation (uses devm_drm_dev_alloc internally) */
> +struct qda_dev *qda_alloc_device(struct device *dev);
> +
> +/* Core device lifecycle */
> +int qda_register_device(struct qda_dev *qdev);
> +void qda_unregister_device(struct qda_dev *qdev);
> +
> +#endif /* __QDA_DRV_H__ */
> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> new file mode 100644
> index 000000000000..6eaf1b145f8a
> --- /dev/null
> +++ b/drivers/accel/qda/qda_rpmsg.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/rpmsg.h>
> +#include <drm/drm_print.h>
> +
> +#include "qda_drv.h"
> +#include "qda_rpmsg.h"
> +
> +static struct qda_dev *alloc_and_init_qdev(struct rpmsg_device *rpdev)

Use the prefix uniformly.

> +{
> +	struct qda_dev *qdev;
> +
> +	qdev = qda_alloc_device(&rpdev->dev);
> +	if (IS_ERR(qdev))
> +		return qdev;
> +
> +	qdev->dev = &rpdev->dev;
> +	qdev->rpdev = rpdev;
> +	dev_set_drvdata(&rpdev->dev, qdev);
> +
> +	return qdev;
> +}
> +
> +static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
> +			void *priv, u32 src)
> +{
> +	/* Placeholder: responses will be dispatched here */
> +	return 0;
> +}
> +
> +static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
> +{
> +	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
> +
> +	drm_dev_unplug(&qdev->drm_dev);
> +	qdev->rpdev = NULL;
> +	qda_unregister_device(qdev);
> +	dev_info(qdev->dev, "RPMsg device removed\n");

Drop the spamming. And useless (where it is useless) drm_dbg() / dev_dbg() spamming too.

> +}
> +
> +static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +	struct qda_dev *qdev;
> +	const char *label;
> +	int ret;
> +
> +	dev_dbg(&rpdev->dev, "QDA RPMsg probe starting\n");
> +
> +	qdev = alloc_and_init_qdev(rpdev);
> +	if (IS_ERR(qdev))
> +		return PTR_ERR(qdev);
> +
> +	ret = of_property_read_string(rpdev->dev.of_node, "label", &label);
> +	if (ret) {
> +		dev_err(qdev->dev, "Missing 'label' property in DT node: %d\n", ret);
> +		return ret;
> +	}
> +	qdev->dsp_name = label;

Why not just of_property_read_string(...., &qdev->dsp_name)?

> +
> +	ret = qda_register_device(qdev);

return qda_register_device();

> +	if (ret)
> +		return ret;
> +
> +	drm_info(&qdev->drm_dev, "QDA RPMsg probe complete for %s\n", qdev->dsp_name);
> +	return 0;
> +}
> +
> +static const struct of_device_id qda_rpmsg_id_table[] = {
> +	{ .compatible = "qcom,fastrpc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, qda_rpmsg_id_table);
> +
> +static struct rpmsg_driver qda_rpmsg_driver = {
> +	.probe = qda_rpmsg_probe,
> +	.remove = qda_rpmsg_remove,
> +	.callback = qda_rpmsg_cb,
> +	.drv = {
> +		.name = "qcom,fastrpc",
> +		.of_match_table = qda_rpmsg_id_table,
> +	},
> +};
> +
> +int qda_rpmsg_register(void)
> +{
> +	int ret = register_rpmsg_driver(&qda_rpmsg_driver);
> +
> +	if (ret)
> +		pr_err("qda: Failed to register RPMsg driver: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +void qda_rpmsg_unregister(void)
> +{
> +	unregister_rpmsg_driver(&qda_rpmsg_driver);
> +}

Just use module_rpmsg_driver(), drop all the wrappers and module_init()
/ exit().

> diff --git a/drivers/accel/qda/qda_rpmsg.h b/drivers/accel/qda/qda_rpmsg.h
> new file mode 100644
> index 000000000000..5229d834b34b
> --- /dev/null
> +++ b/drivers/accel/qda/qda_rpmsg.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_RPMSG_H__
> +#define __QDA_RPMSG_H__
> +
> +/* RPMsg transport layer registration */
> +int qda_rpmsg_register(void);
> +void qda_rpmsg_unregister(void);
> +
> +#endif /* __QDA_RPMSG_H__ */
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
