Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82826FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A7F10ECA8;
	Tue, 28 Apr 2026 19:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6hhO0Q1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtMPlcZC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE21210ECB3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:37:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SIuP7B3347507
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/v2MbDPTy9gk9OluevpeqWGn
 rf+zZgQf7rxJQUu5J4c=; b=O6hhO0Q1fGugTxYhCMSUUbDUN5t2Pdu/vKOlaThi
 H05CGGgHaQdwCuYOV3aP47RiijriQEj6C00oAGaMD+Fm7mDAtK1aQXGpI0PX9sWe
 kPdGM7eCACgtfV7xSphqQ+Ar+jTEq2fQMIL4tQe5rSsT8jeRo0eB3jvyilJ9qIOL
 AO4gllsWQN1CIqrPA421U9tED5JrR6lO3evdfyxNp3NOaBZSz6pn0EZMapUMptnI
 ukV9df2ig8AE28JNOW+I2an4sq7TnGa3FJ5K/Uq07rGAToyfFCw/VF2Kp3aI945B
 ZTBn7lq2+1SLRgpd9UiJ6hoFABuSnlSJYNjmA6jKVcsX1A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4r3vf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:37:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fd55bf6cdso5664206b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777405051; x=1778009851;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/v2MbDPTy9gk9OluevpeqWGnrf+zZgQf7rxJQUu5J4c=;
 b=OtMPlcZCOAcz4+PIOrYT+t6u4TZgCmeno1Jx5cqXZ07I1BhujTZJbiz2QpKtafXNTx
 YzsH5nhNOjwd4zg8OExTGWYQ6KdurMiRfpdAs85EcvUhlRHh0eBgiK1S6IIxlBUhiPfo
 /Dr4lnaxDnmu1LkeQQSekuuRyddjuOUNIILswG6W/0NcHOBFqVr8gJ+wtbgsRUf910uu
 u/i/qcVGrDpjoh+4rPcGiQkldpSmZBXkhCbImsgArdDrj6JWMSgbYfpiRN82kl2C/oQc
 BEQcZOM6O9of62t1GtmObPBFQPyOHIxt/VibkiFpbFxXhw2GuWbbDN9w/Fe3dO0/xXJo
 7W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777405051; x=1778009851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/v2MbDPTy9gk9OluevpeqWGnrf+zZgQf7rxJQUu5J4c=;
 b=mbxL1aBHLiIg6J9Kvpf/U0bPAjCoT0ijmVKrng+rpFA5CiYtpp+hS1jLNFwjgEAYP8
 gnF0KsBO38yUVodHtDSoUCuCkT2acQpXZx0mXL17fcCC2zg3LVka+JUfFKXlpqyczspt
 9LzwaC3XWK0oJVR+xdUqCLL3O0j16H7X9zJwTZnpfghHuykNPdK45RY5A48dNYtnAOcH
 AhME48t6WWbvPKMUS7VbbbVNWLFGCmlzWH+sno65v4WMc9ALyK2+RTDOBQTBIaoLIYgB
 Jmkj6wgsHEsh+7hC2F7o7ngL3RZnRYyvU/5R0T5Rt3vgZUpGfPzq+YxQngaTLXLd6vjr
 Ejbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+B3YB26qe78jBoN28ckQdAX/2/dM6HMMl5Wrl9Lqi90xvURFIJwLVthkAZ4r6KSFdM5QB32CdGIgU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNyE+lya8m3DmyZzGcJsY6cxdzF4YzADM9qzV1vlXL8juDrE/j
 5qj9/L7t4Rvyu4cMJkeKaS7iVvOKaOx7dztzeO6R4igMv4B7V7T23Wucv0XXPa82CU/b6oS+y81
 t1tVco6AU/8bgwT2f4svKbjeQguviRQ4x1Jx/ISbmD5HFkIcWV4fgNJ5sJkagwxx5NB4r+ck=
X-Gm-Gg: AeBDievbqXC0m7x8oU522XVUWymagSjUfrsGoNlOdTqtVpS9RtKgW+e07Lrk7XZC/Np
 jbkhEorn5XAl/kUaqDUbOwA7pv19XJ01GNREgkjeM+eun1XAWWmsY7zqxZ2SVvF5K72YrznsKDJ
 57AscPXxNefbFR6c6AqXUAGoZq4W5CDj6AmiKBqzVJrdTkYNZ533n5Rc5sPmtHUea69BeY2VCIo
 B5ywFG5ZgoZIhtLTFR2L6feyL3QfYbCZr8sBenb/2HHVDTHAcdaZYI/rHG26mZo4b35DVAZsQ4W
 bzyQqSHwDVHEZ+5MHaMAnST3sj2GJPmoW4Zp6xyS+b8/Cv10TKPm1A2w9N+MyCY6Mtt39jdgAX/
 od7RNlK7HirtdtdzWoOn075fu9f6WCRloMZt9xlsqgCGMTgD/HIAIsPLaAKY=
X-Received: by 2002:a05:6a00:a804:b0:82f:761:2b49 with SMTP id
 d2e1a72fcca58-834ea81252amr598148b3a.49.1777405050714; 
 Tue, 28 Apr 2026 12:37:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:a804:b0:82f:761:2b49 with SMTP id
 d2e1a72fcca58-834ea81252amr598078b3a.49.1777405049990; 
 Tue, 28 Apr 2026 12:37:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf35093sm3444849b3a.28.2026.04.28.12.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 12:37:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:07:14 +0530
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
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-12-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-12-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE5MSBTYWx0ZWRfX/AqtAUgC3q3m
 i3Y9Lun0sh1I0m1h31KriAoBZGrn/97h3R/E8pV7Mqzr6zAUcn07ceug5TYt4Xv05CN/PxvVCzb
 U9JsyQjCQJDxg3nooryMrRy4HYGxbUZsrXav1un4z1LRQjURaPP0xEr2ts/HP7AvwaIX01Yl2Ga
 k2yppxf6Q4a7ssHBDixtZp4QEsI2XWoEKI5A+F3yuC5MghgjdqzDfY+1uBuh1z0FBSbt9OA+0gz
 d0JQ0ejIN9Gk8rD8I1MlnkxKuhKBwuF3d1CVysfSiHkdMR94vYVFpP0K2QZSvjhgY/tYJrb0V4m
 wMchfTp5ulARqgqemVxexoBYK4bMKF/jCUcbMK59MvqR+JaI0DgdRLVJVYx5LRz5ewSOO3rOOKD
 mo6DnqlpaJw/L8PNH8mSXbFFFqkIgmstoj/Gbe77uPIFsFJRuxvFP5FBPcrxJoewE8Djo8ZKZP9
 nLHstIb4YmGSViKA7+Q==
X-Proofpoint-GUID: pZSJ1WGqM6opEWiI-NE18UoDU9dUISRH
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f10c7b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IA_ug8NyWMwr6sB50gwA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: pZSJ1WGqM6opEWiI-NE18UoDU9dUISRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280191
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

On Mon, Apr 27, 2026 at 03:25:59PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.

When we use 'Along with' or 'while at it', patch is doing two things and
not one.

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> index 3c803a05305a..f54b759c18aa 100644
> --- a/drivers/media/platform/qcom/iris/Kconfig
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -1,13 +1,14 @@
>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER if ARCH_QCOM
> -        select QCOM_SCM
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER if ARCH_QCOM
> +	select QCOM_SCM
> +	select QCOM_PAS
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  This is a V4L2 driver for Qualcomm iris video accelerator
> +	  hardware. It accelerates decoding operations on various
> +	  Qualcomm SoCs.
> +	  To compile this driver as a module choose m here.

Here, Space replaced by Tabs just for one line.., should be fine.


> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..856fa6a79064 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
>  
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  			return ret;
>  		}
>  	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>  
>  int iris_fw_unload(struct iris_core *core)
>  {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  }
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, core->irisi_platform_data->pas_id);


Should be a separate change for qcom_pas_set_remote_state()

>  }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index ffb731ecd48c..574172724e8f 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>  	select OF_DYNAMIC if ARCH_QCOM
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select QCOM_SCM
> +	select QCOM_PAS
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV
>  	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);

This too..

>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>  		return -EPROBE_DEFER;
>  
>  	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys = mem_phys;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>  	else
>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>  
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>  						     res->cp_nonpixel_start,
>  						     res->cp_nonpixel_size);
>  		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>  			dev_err(dev, "set virtual address ranges fail (%d)\n",
>  				ret);
>  			return ret;
> @@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
>  	int ret;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +		ret = qcom_pas_shutdown(VENUS_PAS_ID);
>  	else
>  		ret = venus_shutdown_no_tz(core);
>  
> -- 
> 2.51.0

with above change

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> 

-- 
-Mukesh Ojha
