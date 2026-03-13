Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A87105F79A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741AB10EB7A;
	Fri, 13 Mar 2026 11:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o196izQj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhEZpBY3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A666010EB7A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:08:07 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9Tqkn1499093
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=e36oZbKohafb7XeQZtpNepWi
 ozZ4hMeiBqXvtRWVqgQ=; b=o196izQjMSB7dRp2utfm0eg9A1vgd91ajK0hoPWO
 VjxXAXmOlfZVFoH9jIVF+shxOEVm/0CliQp/pZgJQvU+iNi9YTIPONFXwViQ9i0c
 qteIlXu7jpDy1bYt/sddglAWa1MWur+paVXAKF9FsMiATqZjNRBytxG0CFB370SR
 9/mWKeVh0AHaaW2r3pXcZMHS64os7C2d6atYW6RXUc490RD8F+9bCmEdHKxK4oCv
 sKoe7I7uOapQgiQVqZCRCZdqMsVzRDowFQl45aGX2S6vY1qO9oW9/hg1Xukg5IsC
 sqyW/qYJ2+ZG3JkYimTObHSyBNRlYxRMRU3c3gBvM7Fpcw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hga9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:08:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ae57228f64so21035555ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773400086; x=1774004886;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e36oZbKohafb7XeQZtpNepWiozZ4hMeiBqXvtRWVqgQ=;
 b=hhEZpBY3wE1wS8xVVPII8EM7M8mDEksguC42dUkJVQRnEd2MVtXnnnl3bHhzy6Pl6U
 vSdHA3xzwHnvAerHTHGXlfFoJU/oLBjrk4WnImWWOAhvu1SG4RgdD42cXX6++BQ7c4Xm
 GNinlSH/Y4fXaeOI15G4PUlGw7EKiw+GX6mx0Saw5umfYP6thhQ3MmIBmfcfBnLf4hrs
 5Ugey0kEBIB4SRvYfkb+UH8wpoEeV5ndnyVxqqP+1VhBkldxi7zNRCl6QX25Pn+OwVKY
 L5dc8RGiz2WaEjtoD3z8ctN+M8onPV0+5pbg6rSnut8kAK830gFs7EG1O/cARTHUvmWx
 /Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773400086; x=1774004886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e36oZbKohafb7XeQZtpNepWiozZ4hMeiBqXvtRWVqgQ=;
 b=nRcuIRlfXGPlNXV6ibjHSKs4gWdiMzNFACnwzviEvO+3Y0azrwGJYYCJE07PNLyJ/2
 85tfpoNzaMO8nJBDyCWpUEJ/28LP8SX3oedNzZ+6u/cBrAK6+6s1IPiktixPV6xdUF3Q
 u91O0RweXgxdbT94WZgStZw7rTCEv0U7TAELCz6Qa3BZhEjAvo8JDk/0qRbPxlb4ca9+
 uvaoNk9rdaxu8rjEVGC1dm3x1QM3JXEkUbNStPqKImBfY788H9TkzFXmKu548B17uHNL
 RMjQkpEBizoqDPJJJu7ZeS5Mi1HwTi7aafG6xOrujATRHqDxGxMSgv6AyJP/3wtMnMFU
 bLpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAJSpObr4qct+Y44DSpAy7MSYNicoI6IOCIvnFjQaE8vVodQuHzbEdjsZW4sGCnEo1lDaJPTch4tU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3FtO2gE6oQTB9goo4JntiA34fKzyFq/+Q2mU2nClZkoEQHdtg
 0UDQ1bSPfw0fGmKgMvm7NXFKg9MZ1+V3s3q1GJRZJaofEoenKkgSPdOFfCHXq5XeMdwK8kfJ8Fk
 KulEGW8B7XdUIAgEwer0B6/gx/BKwVBIXb/LMkaZ3T3iynKGD0VXowkvzpsqtovEZKHvlAzc=
X-Gm-Gg: ATEYQzxkdHCIShGMCdp2BwDRRGSY5Jc9Ekcv8wTsk7X9yw09+30slRVGSlFqz6Iu+3v
 NCHxC75aaDC2ab3myYDsFiEblCw6/czOl89To91mezHvDO6piVxsQ0DDvBNllVDXEBKfiIBLmRb
 +ecpSzRIoSR5Qqy6pk/UQ5992WLItg1MwCIparj9xzk+hx2InrubOFjSfdtuAAf2Hu2i1uaLxZe
 esHougH/Mu53gcQIP7DpOKMpdGJO291H3WjOyShYxbpVUst3n4OIpWpIie2H3lmQEdkQ5uaIRZN
 zT96ReTQm9eKg8V3x6ChYQrDC5CtG836uBWCY8CuoCjiSOPPzWUn4OhqQYPE0NnCNpQkqA7vUS9
 mpDUQyGsBz+Qf6rfKXv5rlyf9mds4DOZyYdfGOGII1uGfoDVi
X-Received: by 2002:a17:902:ce11:b0:2ae:c34d:8c4e with SMTP id
 d9443c01a7336-2aecaa9e9c0mr28257335ad.38.1773400085349; 
 Fri, 13 Mar 2026 04:08:05 -0700 (PDT)
X-Received: by 2002:a17:902:ce11:b0:2ae:c34d:8c4e with SMTP id
 d9443c01a7336-2aecaa9e9c0mr28256505ad.38.1773400084516; 
 Fri, 13 Mar 2026 04:08:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece56c56csm25454045ad.7.2026.03.13.04.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 04:08:04 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:37:47 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <20260313110747.v5bx2snpbtyja3ur@hu-mojha-hyd.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-5-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312062756.694390-5-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b3f016 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JHwwdyD97BAlXG7hVn4A:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: SVh0HjRiNyBlwuVJJufUAgESaAf1PrJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4NyBTYWx0ZWRfXxz3r/C5eMBWF
 3qc5gE9LxX18CyeoYD04W9OKiAVp2k9XDvNSM/FkWfLyS9ASQFCHnWoaeA5MhZE2iTHW0ZDTOH9
 +NveT6mrG2ldTyK6hs5YbdiJD2Z3aYP4IVd9LKP6aOlLfrk0rSW6U8cfoc4I7PT2qanfM4wzHQY
 cXrf55aGp5K5tqNjBQX2k6SP2f7PjA1wbtMPqwxmbnLQm1XFh2kutlFsL5k5cYUmgvp7DBYGTV8
 pkoaL3tkSJXgLJiI5l3R+nESusfuMVYrX4scbHYjG+0TcIXIv8sPNmeZfDgab/75Z5C/w9Ow4vm
 7TACrrpb6jC2sHQTYulVkZu/hV4d0gQbACF+wPVl/ta5eqNrHvspWY1yXzrxnEvj7LAWEUsj0ly
 bQdEunHp6zg3xKoszEbKZXFZ5HUCVpPHlFvhj83tLmzPLtIorvQaHm5nBM/Qrtg827DBERtgKOb
 CQJx1s0SNtZvUFF+5Xg==
X-Proofpoint-GUID: SVh0HjRiNyBlwuVJJufUAgESaAf1PrJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130087
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

On Thu, Mar 12, 2026 at 11:57:45AM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |   9 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 477 +++++++++++++++++++++++++++
>  3 files changed, 487 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 9a12ae2b639d..fff47abdaafd 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -14,6 +14,15 @@ config QCOM_PAS
>  	  backends plugged in whether it's an SCM implementation or a proper
>  	  TEE bus based PAS service implementation.
>  
> +config QCOM_PAS_TEE
> +	tristate
> +	select QCOM_PAS
> +	depends on TEE
> +	depends on !CPU_BIG_ENDIAN
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware TEE implementation as the backend.
> +
>  config QCOM_SCM
>  	select QCOM_PAS
>  	select QCOM_TZMEM
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index dc5ab45f906a..48801d18f37b 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> +obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> new file mode 100644
> index 000000000000..7db9fd736369
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +
> +#include "qcom_pas.h"
> +
> +/*
> + * Peripheral Authentication Service (PAS) supported.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define PTA_QCOM_PAS_IS_SUPPORTED		1
> +
> +/*
> + * PAS capabilities.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [out] params[1].value.a:	PAS capability flags
> + */
> +#define PTA_QCOM_PAS_CAPABILITIES		2
> +
> +/*
> + * PAS image initialization.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[1].memref:	Loadable firmware metadata
> + */
> +#define PTA_QCOM_PAS_INIT_IMAGE			3
> +
> +/*
> + * PAS memory setup.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Relocatable firmware size
> + * [in]  params[1].value.a:	32bit LSB relocatable firmware memory address
> + * [in]  params[1].value.b:	32bit MSB relocatable firmware memory address
> + */
> +#define PTA_QCOM_PAS_MEM_SETUP			4
> +
> +/*
> + * PAS get resource table.
> + *
> + * [in]     params[0].value.a:	Unique 32bit remote processor identifier
> + * [inout]  params[1].memref:	Resource table config
> + */
> +#define PTA_QCOM_PAS_GET_RESOURCE_TABLE		5
> +
> +/*
> + * PAS image authentication and co-processor reset.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Firmware size
> + * [in]  params[1].value.a:	32bit LSB firmware memory address
> + * [in]  params[1].value.b:	32bit MSB firmware memory address
> + * [in]  params[2].memref:	Optional fw memory space shared/lent
> + */
> +#define PTA_QCOM_PAS_AUTH_AND_RESET		6
> +
> +/*
> + * PAS co-processor set suspend/resume state.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Co-processor state identifier
> + */
> +#define PTA_QCOM_PAS_SET_REMOTE_STATE		7
> +
> +/*
> + * PAS co-processor shutdown.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define PTA_QCOM_PAS_SHUTDOWN			8
> +
> +#define TEE_NUM_PARAMS				4
> +
> +/**
> + * struct qcom_pas_tee_private - PAS service private data
> + * @dev:		PAS service device.
> + * @ctx:		TEE context handler.
> + * @session_id:		PAS TA session identifier.
> + */
> +struct qcom_pas_tee_private {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	u32 session_id;
> +};
> +
> +static bool qcom_pas_tee_supported(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_IS_SUPPORTED,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS not supported, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int qcom_pas_tee_init_image(struct device *dev, u32 pas_id,
> +				   const void *metadata, size_t size,
> +				   struct qcom_pas_context *ctx)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_INIT_IMAGE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	struct tee_shm *mdata_shm;
> +	u8 *mdata_buf = NULL;
> +	int ret;
> +
> +	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);
> +	if (IS_ERR(mdata_shm)) {
> +		dev_err(dev, "mdata_shm allocation failed\n");
> +		return PTR_ERR(mdata_shm);
> +	}
> +
> +	mdata_buf = tee_shm_get_va(mdata_shm, 0);
> +	if (IS_ERR(mdata_buf)) {
> +		dev_err(dev, "mdata_buf get VA failed\n");
> +		tee_shm_free(mdata_shm);
> +		return PTR_ERR(mdata_buf);
> +	}
> +	memcpy(mdata_buf, metadata, size);
> +
> +	param[1].u.memref.shm = mdata_shm;
> +	param[1].u.memref.size = size;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS init image failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		tee_shm_free(mdata_shm);
> +		return -EINVAL;
> +	}
> +	ctx->ptr = (void *)mdata_shm;
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_MEM_SETUP,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(addr),
> +			.u.value.b = upper_32_bits(addr),
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_FREE(shm_free, struct tee_shm *, tee_shm_free(_T))
> +
> +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> +					struct qcom_pas_context *ctx,
> +					void *input_rt, size_t input_rt_size,
> +					size_t *output_rt_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_GET_RESOURCE_TABLE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = ctx->pas_id,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +			.u.memref.size = input_rt_size,
> +		}
> +	};
> +	void *rt_buf = NULL;
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);

What is the purpose of this function ? looks like, this is for, how
much Linux need to allocate for output buffer ?

> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> +			ctx->pas_id, inv_arg.ret);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (param[1].u.memref.size) {
> +		struct tee_shm *rt_shm __free(shm_free) =
> +			tee_shm_alloc_kernel_buf(data->ctx,
> +						 param[1].u.memref.size);
> +		void *rt_shm_va;
> +
> +		if (IS_ERR(rt_shm)) {
> +			dev_err(dev, "rt_shm allocation failed\n");
> +			return rt_shm;
> +		}
> +
> +		rt_shm_va = tee_shm_get_va(rt_shm, 0);
> +		if (IS_ERR_OR_NULL(rt_shm_va)) {
> +			dev_err(dev, "rt_shm get VA failed\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		memcpy(rt_shm_va, input_rt, input_rt_size);
> +
> +		param[1].u.memref.shm = rt_shm;

Here, you are passing only one buffer for both input and output ?

Like, you are allocating of buffer of size returned from qtee which I
assume includes both input + output rt size and copying the input_rt
and calling invoke and in return you will get combine table in return ?

> +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +		if (ret < 0 || inv_arg.ret != 0) {
> +			dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> +				ctx->pas_id, inv_arg.ret);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		if (param[1].u.memref.size) {
> +			*output_rt_size = param[1].u.memref.size;
> +			rt_buf = kmalloc(param[1].u.memref.size, GFP_KERNEL);
> +			if (!rt_buf)
> +				return ERR_PTR(-ENOMEM);
> +
> +			memcpy(rt_buf, rt_shm_va, *output_rt_size);

rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);

https://lore.kernel.org/lkml/20260310140255.2520230-1-mukesh.ojha@oss.qualcomm.com/


> +		}
> +	}
> +
> +	return rt_buf;
> +}
> +
> +static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
> +					 phys_addr_t mem_phys, size_t mem_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_AUTH_AND_RESET,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = mem_size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(mem_phys),
> +			.u.value.b = upper_32_bits(mem_phys),
> +		},
> +		/* Reserved for fw memory space to be shared or lent */
> +		[2] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS auth reset failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
> +}
> +
> +static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
> +					       struct qcom_pas_context *ctx)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, ctx->pas_id, ctx->mem_phys,
> +					     ctx->mem_size);
> +}
> +
> +static int qcom_pas_tee_set_remote_state(struct device *dev, u32 state,
> +					 u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_SET_REMOTE_STATE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = state,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_shutdown(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_SHUTDOWN,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret = 0;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pas_tee_metadata_release(struct device *dev,
> +					  struct qcom_pas_context *ctx)
> +{
> +	struct tee_shm *mdata_shm = ctx->ptr;
> +
> +	tee_shm_free(mdata_shm);
> +}
> +
> +static struct qcom_pas_ops qcom_pas_ops_tee = {
> +	.drv_name		= "qcom-pas-tee",
> +	.supported		= qcom_pas_tee_supported,
> +	.init_image		= qcom_pas_tee_init_image,
> +	.mem_setup		= qcom_pas_tee_mem_setup,
> +	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
> +	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
> +	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
> +	.set_remote_state	= qcom_pas_tee_set_remote_state,
> +	.shutdown		= qcom_pas_tee_shutdown,
> +	.metadata_release	= qcom_pas_tee_metadata_release,
> +};
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	return ver->impl_id == TEE_IMPL_ID_OPTEE;
> +}
> +
> +static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data;
> +	struct tee_ioctl_open_session_arg sess_arg = {
> +		.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL
> +	};
> +	int ret, err = -ENODEV;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> +	if (IS_ERR(data->ctx))
> +		return -ENODEV;
> +
> +	export_uuid(sess_arg.uuid, &pas_dev->id.uuid);
> +	ret = tee_client_open_session(data->ctx, &sess_arg, NULL);
> +	if (ret < 0 || sess_arg.ret != 0) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		err = -EINVAL;
> +		goto out_ctx;
> +	}
> +
> +	data->session_id = sess_arg.session;
> +	dev_set_drvdata(dev, data);
> +	qcom_pas_ops_tee.dev = dev;
> +	qcom_pas_ops_register(&qcom_pas_ops_tee);
> +
> +	return 0;
> +out_ctx:
> +	tee_client_close_context(data->ctx);
> +
> +	return err;
> +}
> +
> +static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +
> +	qcom_pas_ops_unregister();
> +	tee_client_close_session(data->ctx, data->session_id);
> +	tee_client_close_context(data->ctx);
> +}
> +
> +static const struct tee_client_device_id qcom_pas_tee_id_table[] = {
> +	{UUID_INIT(0xcff7d191, 0x7ca0, 0x4784,
> +		   0xaf, 0x13, 0x48, 0x22, 0x3b, 0x9a, 0x4f, 0xbe)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, qcom_pas_tee_id_table);
> +
> +static struct tee_client_driver optee_pas_tee_driver = {
> +	.probe		= qcom_pas_tee_probe,
> +	.remove		= qcom_pas_tee_remove,
> +	.id_table	= qcom_pas_tee_id_table,
> +	.driver		= {
> +		.name		= "qcom-pas-tee",
> +	},
> +};
> +
> +module_tee_client_driver(optee_pas_tee_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TEE bus based Qualcomm PAS driver");
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
