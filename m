Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEE4CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 17:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA8210E476;
	Tue,  5 May 2026 17:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bymI5B2f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XE21gNhk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E8B10EBA4
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 17:32:50 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EZhrf4028315
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 17:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NktNNT+blem0C8DB93BySTft
 eXu91gdwwaZsrQR4k2s=; b=bymI5B2fLLzns/GkH6H2wcDxIwbGdyD2Y9jW0dC3
 AqLuVpoRQ5rhtwz+GMcmrpUNaWgUPh84wPSnhdtH957NJ0aytiKtxKGEOOLDgBJU
 cjL1FwOUYZlFv7DlWWiV/cLXjJyJxefWON860T9KyXrTwFPSuRgAjH58gIUjQLvi
 Hl4JlYTw/aLXdkXcPPMsyP1hmpq3p95Rrj5JeAM5ZiEu8mx4w4z4ZE6bmDvRBKfj
 MS8YALfHQlnbcyCv/d1aFFnOdsCDg+weY+OdQSMcIeT9IX1jYm36/yPQBlCCpmbo
 KdLn98K0VMh+1Sshjc8XML/QYu/aRItlaGIzXJICVRhj+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dydm6t336-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 17:32:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e06219cbso45611835ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778002369; x=1778607169;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NktNNT+blem0C8DB93BySTfteXu91gdwwaZsrQR4k2s=;
 b=XE21gNhkpn/JhI8V1XzLpNBR7WHgOcBZYLmTIr72B/KPBrzNox9NWwB+v1I0Y5mGlR
 gIaBgllEo2ASfEpLizAzJACf9NPwaOiNPofQW5Is8MSsFhC0GQ/R/7aUHxPjFmksLUQS
 slxboRAXiUDZVELlQbf4mhVog3+SG2IxrDbPtNH6gz8awiPXVgmry3XteVZyNeOkIv3c
 qBjIVSiRldjiwfA8FaD7x0/gY0aReFAy4X0knvWZOs/HFw+jlMTifh21dP8odvK1iUVC
 vOrw8fmBkiCUMXS1NPs+8qMbHIfpoRkIPA/CP0JVQ/0yUgsTdez25KkgyS79+NfIjzhF
 qmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778002369; x=1778607169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NktNNT+blem0C8DB93BySTfteXu91gdwwaZsrQR4k2s=;
 b=sZVIwWX+wLOcMRm4S/cfXmK0aEDwIa2+ZEBzHGrqMssQt7B6c9XsY/0RFBbEqgumjW
 z36YkBLeTvY7WqMov5aS79CiIB64Nnl4/hrtcmeztlXEYkE0qSHEfM1h57UuaZ7Oyn+f
 BY5/hpeaqfyN9m/JZcjsfj/YNnrpEFqVH3eJVq+rPUNKoT665z+9ki9mY6mhwz4WbuAA
 uxy6AwGwyIpXPJUpWzgghyInHUQtjvE9o//p2/Un0Qml+5RHv9djOkoNDJQa6k+RkQhM
 LtM0/+5ALiH4E3t9g/JuGBSeCFRwheb6MOypQcimFgjEdZcdpnWy9OOiT050O37v4g28
 rjVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q98qf0UhoBtx5BtPPGKIca3LoLVnX4BcJlKScRmRoF7D7m4eZbWz1Ir0rbB7cJgG28y0cLw2cDI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDPMZxIeA+O8es6j4NrmFoAluxJYZOCdxpuhmN9RA/XllP7zcF
 zZBKlS02dGNhEvybpyvaMkfj+/LSFPdKON8zd/7ocdWjqdg0WYrQxa1L9qC1JVDWdImT3ZBfFSu
 8tzlNdFPdRu2tsnntylhwqij8mnl3B0kjvR8E3Hte5Q9mMza1OoZb/ufO/q8L5vMRnYn4TV4=
X-Gm-Gg: AeBDieuu1Ot8emTTvfQ1X3TjRSxYRR1kggGI2+rN9JfBL/+Dz064Mr37BQ0e+rHseBo
 41//IkztpFlXLQCvYA8WWKHvOmjzuy3wKUj2cMphqGJfv4LIgBOFgRPV2MiYBgESJuRAf2cMCul
 KcG3LPbBJ+e+3i9MPaXSQMD/8/q+3fyDjfBw9W6G2Oe6+sr/tqC/CW0whBMzMltnt4knSH8F14z
 jK/eZLNqcWGiNzqCD8sTsjueZGS9LYlkMP6FTZ+w/HzbMbFyS2UuokHD3ue0O3uwlNxYfN2d/HT
 aJ43aLGarbjIuY5Q19NR0iDEkWVZ3kWhE2XuCv1fk6ANLp/v1O3OtArKhbNwSYBc4DpmJvVx0si
 WqylzCyXpaYbSlFtuGR3xN58o7iBV1wqryPofqzRa/3W+YCtcpH9gJwBx7WI=
X-Received: by 2002:a17:902:f54c:b0:2b4:5e7e:34ce with SMTP id
 d9443c01a7336-2b9f285cc57mr141237655ad.39.1778002369345; 
 Tue, 05 May 2026 10:32:49 -0700 (PDT)
X-Received: by 2002:a17:902:f54c:b0:2b4:5e7e:34ce with SMTP id
 d9443c01a7336-2b9f285cc57mr141237075ad.39.1778002368437; 
 Tue, 05 May 2026 10:32:48 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm146854565ad.24.2026.05.05.10.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:32:47 -0700 (PDT)
Date: Tue, 5 May 2026 23:02:32 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/16] firmware: qcom: Add a generic PAS service
Message-ID: <20260505173232.6bvtccowckwsatb4@hu-mojha-hyd.qualcomm.com>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-3-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504130603.1474043-3-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MCBTYWx0ZWRfX7J11iDanIyv1
 6X94x4v2MrshbDsWLzEcRFYWHUWajdhIHcVuVqz7FRP1w1a1aUwC+zcgpKW/l77Zj+HBQQY2LoP
 lBJVirt0NIlc7px9V7NRnN9BfnRohe6gTlbsACpYWM28kiMHVPbieQm6vC1kZDRipek7Cjg+yqj
 9OwxDs/pwn4+ZO0fdDam8FwZbyba/I90f3gEZ/ERpZkWB5JO/lI4Wj+9WdkhgRXepYH4C50Ap9v
 N7cTBOuOLFJV0U3nmRC/YepcAoUDa9esmHRFzQf6lvpbjOfuhDnSqk/i5LMnp1I8vUCMSDgjq3o
 A/q3TAbgorEt0pdO9uTIr2FpzUjTwn8NFc7LEowx/+ozLD1O9Xqv1Hijpywbpbsbu4UclC6StTG
 pX/KX9nrYJsp8YQKfL21VjYCUc/pAnEzzZiHYhvFkj1FO0bS44GKVIxcFkA8nNpQDJ/dR0tJ496
 fuCLRGEGSK4SMaYNcmA==
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fa29c2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=B9m6UvTZno2CEb395rQA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 502TA3Pv2cljMx5q_xqVNUeFmn23KhKX
X-Proofpoint-ORIG-GUID: 502TA3Pv2cljMx5q_xqVNUeFmn23KhKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050170
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

On Mon, May 04, 2026 at 06:35:49PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 291 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_pas.h       |  50 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  43 ++++
>  5 files changed, 393 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a..8653639d06db 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -6,6 +6,14 @@
>  
>  menu "Qualcomm firmware drivers"
>  
> +config QCOM_PAS
> +	tristate
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware. It acts as the common layer with different TZ
> +	  backends plugged in whether it's an SCM implementation or a proper
> +	  TEE bus based PAS service implementation.
> +
>  config QCOM_SCM
>  	select QCOM_TZMEM
>  	tristate
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 0be40a1abc13..dc5ab45f906a 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> new file mode 100644
> index 000000000000..025308adf553
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/device/devres.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "qcom_pas.h"
> +
> +static struct qcom_pas_ops *ops_ptr;
> +
> +/**
> + * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
> + *				   context for a given peripheral
> + *
> + * PAS context is device-resource managed, so the caller does not need
> + * to worry about freeing the context memory.
> + *
> + * @dev:	  PAS firmware device
> + * @pas_id:	  peripheral authentication service id
> + * @mem_phys:	  Subsystem reserve memory start address
> + * @mem_size:	  Subsystem reserve memory size
> + *
> + * Return: The new PAS context, or ERR_PTR() on failure.
> + */
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size)
> +{
> +	struct qcom_pas_context *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->dev = dev;
> +	ctx->pas_id = pas_id;
> +	ctx->mem_phys = mem_phys;
> +	ctx->mem_size = mem_size;
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(devm_qcom_pas_context_alloc);
> +
> +/**
> + * qcom_pas_init_image() - Initialize peripheral authentication service state
> + *			   machine for a given peripheral, using the metadata
> + * @pas_id:	peripheral authentication service id
> + * @metadata:	pointer to memory containing ELF header, program header table
> + *		and optional blob of data used for authenticating the metadata
> + *		and the rest of the firmware
> + * @size:	size of the metadata
> + * @ctx:	optional pas context
> + *
> + * Return: 0 on success.
> + *
> + * Upon successful return, the PAS metadata context (@ctx) will be used to
> + * track the metadata allocation, this needs to be released by invoking
> + * qcom_pas_metadata_release() by the caller.
> + */
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_init_image);
> +
> +/**
> + * qcom_pas_metadata_release() - release metadata context
> + * @ctx:	pas context
> + */
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
> +{
> +	if (!ops_ptr || !ctx || !ctx->ptr)
> +		return;
> +
> +	ops_ptr->metadata_release(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
> +
> +/**
> + * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
> + *			  for firmware loading
> + * @pas_id:	peripheral authentication service id
> + * @addr:	start address of memory area to prepare
> + * @size:	size of the memory area to prepare
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_mem_setup);
> +
> +/**
> + * qcom_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
> + *			      for a given peripheral.
> + *
> + * Qualcomm remote processor may rely on both static and dynamic resources for
> + * its functionality. Static resources typically refer to memory-mapped
> + * addresses required by the subsystem and are often embedded within the
> + * firmware binary and dynamic resources, such as shared memory in DDR etc.,
> + * are determined at runtime during the boot process.
> + *
> + * On Qualcomm Technologies devices, it's possible that static resources are
> + * not embedded in the firmware binary and instead are provided by TrustZone.
> + * However, dynamic resources are always expected to come from TrustZone. This
> + * indicates that for Qualcomm devices, all resources (static and dynamic) will
> + * be provided by TrustZone PAS service.
> + *
> + * If the remote processor firmware binary does contain static resources, they
> + * should be passed in input_rt. These will be forwarded to TrustZone for
> + * authentication. TrustZone will then append the dynamic resources and return
> + * the complete resource table in output_rt_tzm.
> + *
> + * If the remote processor firmware binary does not include a resource table,
> + * the caller of this function should set input_rt as NULL and input_rt_size
> + * as zero respectively.
> + *
> + * More about documentation on resource table data structures can be found in
> + * include/linux/remoteproc.h
> + *
> + * @ctx:	    PAS context
> + * @pas_id:	    peripheral authentication service id
> + * @input_rt:       resource table buffer which is present in firmware binary
> + * @input_rt_size:  size of the resource table present in firmware binary
> + * @output_rt_size: TrustZone expects caller should pass worst case size for
> + *		    the output_rt_tzm.
> + *
> + * Return:
> + *  On success, returns a pointer to the allocated buffer containing the final
> + *  resource table and output_rt_size will have actual resource table size from
> + *  TrustZone. The caller is responsible for freeing the buffer. On failure,
> + *  returns ERR_PTR(-errno).
> + */
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt,
> +					      size_t input_rt_size,
> +					      size_t *output_rt_size)
> +{
> +	if (!ops_ptr)
> +		return ERR_PTR(-ENODEV);
> +	if (!ctx)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
> +				      input_rt_size, output_rt_size);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
> +
> +/**
> + * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *			       and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
> +
> +/**
> + * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
> + *				       remote processor
> + *
> + * @ctx:	Context saved during call to qcom_scm_pas_context_init()

devm_qcom_pas_context_alloc()

> + *
> + * This function performs the necessary steps to prepare a PAS subsystem,
> + * authenticate it using the provided metadata, and initiate a reset sequence.
> + *
> + * It should be used when Linux is in control setting up the IOMMU hardware
> + * for remote subsystem during secure firmware loading processes. The
> + * preparation step sets up a shmbridge over the firmware memory before
> + * TrustZone accesses the firmware memory region for authentication. The
> + * authentication step verifies the integrity and authenticity of the firmware
> + * or configuration using secure metadata. Finally, the reset step ensures the
> + * subsystem starts in a clean and sane state.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_prepare_and_auth_reset);
> +
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_set_remote_state);
> +
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_shutdown(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->shutdown(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
> +
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: true if PAS is supported for this peripheral, otherwise false.
> + */
> +bool qcom_pas_supported(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return false;
> +
> +	return ops_ptr->supported(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_supported);
> +
> +bool qcom_pas_is_available(void)
> +{
> +	/*
> +	 * The barrier for ops_ptr is intended to synchronize the data stores
> +	 * for the ops data structure when client drivers are in parallel
> +	 * checking for PAS service availability.
> +	 *
> +	 * Once the PAS backend becomes available, it is allowed for multiple
> +	 * threads to enter TZ for parallel bringup of co-processors during
> +	 * boot.
> +	 */
> +	return !!smp_load_acquire(&ops_ptr);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_is_available);
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops)
> +{
> +	if (!qcom_pas_is_available())
> +		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +		smp_store_release(&ops_ptr, ops);
> +	else
> +		pr_err("qcom_pas: ops already registered by %s\n",
> +		       ops_ptr->drv_name);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
> +
> +void qcom_pas_ops_unregister(void)
> +{
> +	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +	smp_store_release(&ops_ptr, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm generic TZ PAS driver");
> diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..8643e2760602
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_INT_H
> +#define __QCOM_PAS_INT_H
> +
> +struct device;
> +
> +/**
> + * struct qcom_pas_ops - Qcom Peripheral Authentication Service (PAS) ops
> + * @drv_name:			PAS driver name.
> + * @dev:			PAS device pointer.
> + * @supported:			Peripheral supported callback.
> + * @init_image:			Peripheral image initialization callback.
> + * @mem_setup:			Peripheral memory setup callback.
> + * @get_rsc_table:		Peripheral get resource table callback.
> + * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
> + *				reset callback.
> + * @auth_and_reset:		Peripheral firmware authentication and reset
> + *				callback.
> + * @set_remote_state:		Peripheral set remote state callback.
> + * @shutdown:			Peripheral shutdown callback.
> + * @metadata_release:		Image metadata release callback.
> + */
> +struct qcom_pas_ops {
> +	const char *drv_name;
> +	struct device *dev;
> +	bool (*supported)(struct device *dev, u32 pas_id);
> +	int (*init_image)(struct device *dev, u32 pas_id, const void *metadata,
> +			  size_t size, struct qcom_pas_context *ctx);
> +	int (*mem_setup)(struct device *dev, u32 pas_id, phys_addr_t addr,
> +			 phys_addr_t size);
> +	void *(*get_rsc_table)(struct device *dev, struct qcom_pas_context *ctx,
> +			       void *input_rt, size_t input_rt_size,
> +			       size_t *output_rt_size);
> +	int (*prepare_and_auth_reset)(struct device *dev,
> +				      struct qcom_pas_context *ctx);
> +	int (*auth_and_reset)(struct device *dev, u32 pas_id);
> +	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
> +	int (*shutdown)(struct device *dev, u32 pas_id);
> +	void (*metadata_release)(struct device *dev,
> +				 struct qcom_pas_context *ctx);
> +};
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops);
> +void qcom_pas_ops_unregister(void);
> +
> +#endif /* __QCOM_PAS_INT_H */
> diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..65b1c9564458
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_H
> +#define __QCOM_PAS_H
> +
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct qcom_pas_context {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +	bool use_tzmem;
> +};
> +
> +bool qcom_pas_is_available(void);
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size);
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx);
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt, size_t input_rt_size,
> +					      size_t *output_rt_size);
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
> +int qcom_pas_auth_and_reset(u32 pas_id);
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id);
> +int qcom_pas_shutdown(u32 pas_id);
> +bool qcom_pas_supported(u32 pas_id);
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx);
> +
> +#endif /* __QCOM_PAS_H */
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
