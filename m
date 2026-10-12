Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C6810E6A0;
	Mon, 12 Oct 2026 21:35:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495B410E6A0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMplm080195
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ksiK0T4L7o5SFNFytJEd7y68wkigvQZU6mjV4dVdPM=; b=g0h3LdSmFr4e3N4W
 kWFQe6Z72oW7bYJwcLrMoI5ic9/ZrLHhXclKmvQO9d8Fy40NhuW9un2UqIgeyn2m
 wjdooOi6odu+gbyxNLMT5pSu+kT5BtAGsufB2oyu5O4K0jytMzNg7DexMv7EI3mj
 IsNCo06gBtnrBVxWMKZeSy6cg+l4u/bKHEOm/K+w0NX/NFHesjvl7xF/9sdLGarg
 MJqspBr5k3SNcbIO5NSZSYXcgccBiYswuymKqUV++qA22acWHvTMUHg+wYAFxWOT
 6bbX3AJ/lq90VXxgVHE7fgKdA8o/2DnPivnM5AXgvQ4w1yeT/VHNXuwGc5APpV8C
 +WovyQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3khfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so6536701eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791840924; x=1792445724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9ksiK0T4L7o5SFNFytJEd7y68wkigvQZU6mjV4dVdPM=;
 b=JHRBwc/+r8RYd3bV7DV4Zc1ByIrrXy7zKk3N4XCpS9AZ/C9hU4s9KXKsYMi9GFmuu0
 D65EKJsLDsbmb/9WsiK1KyTH5RtKB6sc8T/YlJz/ljgx17N7j3zpR3+SU2/Ga5WvtBo+
 BvY7uE1F8FpOp7F7Oe5zfSq+p3w+RKxf98EU8SbU9C4jeFNPLVE1u+i/U6wus7yIEAZJ
 bsGWn19pqsz1TA0SgVXSZb576yIedeBO231EE7v0yaJfFOdjOysOpJqfqbmGeJnXhkjf
 ffc4a6/eOY+fte8OehMOmby2elGr2bCsIKl8R7a+tMbfWDUAaIag8e47HZjw+lNHuMFx
 QZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840924; x=1792445724;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ksiK0T4L7o5SFNFytJEd7y68wkigvQZU6mjV4dVdPM=;
 b=RdHgp9ShsrEgeBk89k/hfSoQH+RD7GLlEShaMXasIhasmd0BBSyZkg8pQfgnmWrdUc
 Xbt/GIXwGJXJljXBWOtIQVRdw8qYrVb9asHkRsV7qUry3bjlKXK3Fpd3eem7Xgla3q0n
 H/lZslXZb0oTMpvDOKszU0+oB8Ljarqu7urrfeRWiVixmJczcRuXB55A9ZUJIRvOsFKS
 GG9O2/SgNBZCWbyAcyvBZKoonfaFnkADEblIe7kQuo++5yfMWm02CjbmrRzspqIj/2ZQ
 iVNDYvoxWjCCR45oc0l4ZZH7QrWmxiyBM3y/U3Tv2U015Ja54ZMJMW/WHiemIoDoL2NK
 gSNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9G2MPhs9Fm896GgQQp4UyshoBl83Gbp/bjG4DXT31DRJoIQirKRyaL4NwkrhAe/GVBifD2owoWNU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKx9Gw9//MhNZKU/Kf9UPdHftc+YJtecv3HyUnsBCbjBEh1532E
 8XYlLM2UrLWedP1+V9c8+OoPyarE+9rvYEqmKyHLcd6cwWYJBwSDqGKvd+ApLSPFbf74T3OEazE
 i9TtuLB0mkzlgHVUPfedYvk6jOWOeX5EilRdX/ZnBqnbz3N4/QmYf+TLPQAHklHiP08BozM4=
X-Gm-Gg: AYBFou3GjuxLTXTRCIVZJllSh+jSeA2pVCHlKczf3kVfiFTdjecxblwRHpGBEVZ26Xq
 +aiAiPUMfQ98A6fNfdMY2545LP4mWAA17xQe6PMD/WwKrqNwwF6ucebsHy+6bQHVfpRbx5fAd1Q
 v4hJPvnFRBihzIrx1iAb+VTxCP2tSYSFzzLAuOc3We3m3ribHrt8fkVbITJ1rHLTMdwIZjTSGJZ
 +5CV/81odmcBkn/fvr2h3/OcT8SOUDf+kRiw7hwJeszhkNBURsLWtqmGaIfq7i50VgxOh3BltYa
 rs3hvXRGblc7Po5S385gE/29MDsTWidxDBaP/3RT1+xOXH1kchSnG8KUTVa30zxGeMJIHuoaJ0S
 jYbu0axIXkRy6VYzHo1i56bCfD6IzNdnEprBwqQfzdeSZi8j9phJL
X-Received: by 2002:a05:7022:1581:b0:151:2e62:fe89 with SMTP id
 a92af1059eb24-16a60812c7fmr20204156c88.32.1791840923578; 
 Mon, 12 Oct 2026 14:35:23 -0700 (PDT)
X-Received: by 2002:a05:7022:1581:b0:151:2e62:fe89 with SMTP id
 a92af1059eb24-16a60812c7fmr20204104c88.32.1791840922795; 
 Mon, 12 Oct 2026 14:35:22 -0700 (PDT)
Received: from [10.73.232.100] (pat_11.qualcomm.com. [192.35.156.11])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a3f6186fsm34188115c88.14.2026.10.12.14.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 14:35:22 -0700 (PDT)
Message-ID: <2bf0a2e0-7466-4e90-b53d-f3fc0d26378c@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 14:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4NiBTYWx0ZWRfXzpodj4ibCic/
 i7EGufzj2KS9Vd0gNV+K6Q6tOikBCFfIdbSflmBfb/k0DJYFB9MfukA5WM4xOoQNXVCvSlJsotE
 rPUNk7FrWYjVSbwapmZqpA8oF6KJDIgFXQZCLGuYKH8SovpEAn2haIyNcsbzBvI+MS2qkx5bLpZ
 BqtaObPvzpzXguV2+pmmcTaHSIn37WrQb7K9WATGlYrmSUS696tv2/2vKmAgC93W34c6VRvV6Xo
 Ln4XZtYNbsh/Kn7KgMnAeb20OOPlMWDMNY369NS2Mq8bETMAMEbipQjFWqVo4kR6AZrL+dpvcy7
 GWCqIWsh0ZdsCdvdniwXq9kqCu+Wc1mjO91RiXgXZgIUg2o8DHmJMQBUIcEbSkkorwFNnFqlQFg
 alby4V01ctM16PDwReJ2iGvJ8SyXzlLba73bbIHK3dOXJZm4Z+YSLtAPP48b8YmIMYSz2SsCLvn
 ABF4cVVuvguGYFvYayg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4NiBTYWx0ZWRfXzLYvG82vkQMP
 toTRlvdHmng8Ir0zjR9eF/Wq4MLTWzR8cTdlFz1xMUcLxJwbQ7NuGY1jMPANiSTEjJj52gwOS60
 MMHWj8Ern5CBQbAkrvxyhdCYJK9RCek=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd529c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=EyST5JTptKXFtIIvUhkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: jpipv2ZPd2apXsn51o9z0qC3dv8Ywz-t
X-Proofpoint-GUID: jpipv2ZPd2apXsn51o9z0qC3dv8Ywz-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120086
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

On 10/12/2026 11:18 AM, Kishore Batta wrote:
> The Sahara protocol driver currently lives under the QAIC accelerator
> subsystem even though the protocol is transported over MHI and is used by
> multiple Qualcomm flashless devices. This makes Sahara appear QAIC specific
> and complicates reuse by other MHI based devices.
> 
> Move the Sahara protocol driver under drivers/bus/mhi as a host client
> driver and build it as an independent MHI protocol driver. This keeps the
> QAIC driver focused on the accelerator device while allowing other MHI
> users to enable Sahara without depending on QAIC.
> 
> As part of the move, add a dedicated Kconfig/Makefile hierarchy under the
> MHI host client drivers and convert the driver to use module_mhi_driver()
> instead of register/unregister hooks.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>  drivers/accel/qaic/Kconfig                          |  1 +
>  drivers/accel/qaic/Makefile                         |  3 +--
>  drivers/accel/qaic/qaic_drv.c                       |  9 ---------
>  drivers/accel/qaic/sahara.h                         | 10 ----------
>  drivers/bus/mhi/host/Makefile                       |  2 +-
>  drivers/bus/mhi/host/clients/Kconfig                |  6 ++++++
>  drivers/bus/mhi/host/clients/Makefile               |  1 +
>  drivers/bus/mhi/host/clients/sahara/Kconfig         | 15 +++++++++++++++
>  drivers/bus/mhi/host/clients/sahara/Makefile        |  2 ++
>  .../qaic => bus/mhi/host/clients/sahara}/sahara.c   | 21 ++++++++-------------
>  10 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
> index 116e42d152ca885b8c59e33c7a87519a0abc6bb3..af90fdfcf77eeb6dd5ad309b33d793d4fdc91b1e 100644
> --- a/drivers/accel/qaic/Kconfig
> +++ b/drivers/accel/qaic/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
>  	depends on DRM_ACCEL
>  	depends on PCI && HAS_IOMEM
>  	depends on MHI_BUS
> +	depends on MHI_SAHARA
>  	select CRC32
>  	select WANT_DEV_COREDUMP
>  	help
> diff --git a/drivers/accel/qaic/Makefile b/drivers/accel/qaic/Makefile
> index 71f727b74da3bb4478324689f02a7cea24a05c2d..e7b8458800072aa627f7f36c3257883aa56f4ce4 100644
> --- a/drivers/accel/qaic/Makefile
> +++ b/drivers/accel/qaic/Makefile
> @@ -13,7 +13,6 @@ qaic-y := \
>  	qaic_ras.o \
>  	qaic_ssr.o \
>  	qaic_sysfs.o \
> -	qaic_timesync.o \
> -	sahara.o
> +	qaic_timesync.o
>  
>  qaic-$(CONFIG_DEBUG_FS) += qaic_debugfs.o
> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 0acf6cdd44f81430ec52c7120b8b50c60721a615..64e87dfaa560376ecdf1e6f8bf7abf6153160926 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -32,7 +32,6 @@
>  #include "qaic_ras.h"
>  #include "qaic_ssr.h"
>  #include "qaic_timesync.h"
> -#include "sahara.h"
>  
>  MODULE_IMPORT_NS("DMA_BUF");
>  
> @@ -789,12 +788,6 @@ static int __init qaic_init(void)
>  		goto free_pci;
>  	}
>  
> -	ret = sahara_register();
> -	if (ret) {
> -		pr_debug("qaic: sahara_register failed %d\n", ret);
> -		goto free_mhi;
> -	}
> -
>  	ret = qaic_timesync_init();
>  	if (ret)
>  		pr_debug("qaic: qaic_timesync_init failed %d\n", ret);
> @@ -816,7 +809,6 @@ static int __init qaic_init(void)
>  
>  free_bootlog:
>  	qaic_bootlog_unregister();
> -free_mhi:
>  	mhi_driver_unregister(&qaic_mhi_driver);
>  free_pci:
>  	pci_unregister_driver(&qaic_pci_driver);
> @@ -845,7 +837,6 @@ static void __exit qaic_exit(void)
>  	qaic_ras_unregister();
>  	qaic_bootlog_unregister();
>  	qaic_timesync_deinit();
> -	sahara_unregister();
>  	mhi_driver_unregister(&qaic_mhi_driver);
>  	pci_unregister_driver(&qaic_pci_driver);
>  }
> diff --git a/drivers/accel/qaic/sahara.h b/drivers/accel/qaic/sahara.h
> deleted file mode 100644
> index 08037281c80e28f6c85b924c45ce2c2f9dc60c39..0000000000000000000000000000000000000000
> --- a/drivers/accel/qaic/sahara.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> -
> -#ifndef __SAHARA_H__
> -#define __SAHARA_H__
> -
> -int sahara_register(void);
> -void sahara_unregister(void);
> -#endif /* __SAHARA_H__ */
> diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
> index 2a16008aeb38127494782bbff4e1656428d2b776..2e8949f1a2fe6f3f3b2e1dc541f97d2c393d6a0f 100644
> --- a/drivers/bus/mhi/host/Makefile
> +++ b/drivers/bus/mhi/host/Makefile
> @@ -4,4 +4,4 @@ mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
>  
>  obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
>  mhi_pci_generic-y += pci_generic.o
> -obj-y += clients/
> +obj-$(CONFIG_MHI_BUS) += clients/
> diff --git a/drivers/bus/mhi/host/clients/Kconfig b/drivers/bus/mhi/host/clients/Kconfig
> index 8bb5715e61d0d6e64a51012b4e1594ba46e5bfc1..1932344157a5b1dc25c8d63f6d4ac38f896d08a7 100644
> --- a/drivers/bus/mhi/host/clients/Kconfig
> +++ b/drivers/bus/mhi/host/clients/Kconfig
> @@ -15,3 +15,9 @@ config MHI_BUS_LOOPBACK
>  
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called mhi_loopback.
> +
> +menu "MHI host client drivers"
> +
> +source "drivers/bus/mhi/host/clients/sahara/Kconfig"
> +
> +endmenu
> diff --git a/drivers/bus/mhi/host/clients/Makefile b/drivers/bus/mhi/host/clients/Makefile
> index 3811b6928f42b38f94b1167941cf3b0fe512d32b..67e70de280369870164b4808f39d9b3340f2589b 100644
> --- a/drivers/bus/mhi/host/clients/Makefile
> +++ b/drivers/bus/mhi/host/clients/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_MHI_BUS_LOOPBACK) += mhi_loopback.o
>  mhi_loopback-y += loopback.o
> +obj-$(CONFIG_MHI_SAHARA) += sahara/
> diff --git a/drivers/bus/mhi/host/clients/sahara/Kconfig b/drivers/bus/mhi/host/clients/sahara/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..f1fc7013a2dee0be645c50f32305659e591de7e7
> --- /dev/null
> +++ b/drivers/bus/mhi/host/clients/sahara/Kconfig
> @@ -0,0 +1,15 @@
> +config MHI_SAHARA
> +	tristate "Sahara protocol driver"
> +	depends on MHI_BUS
> +	help
> +	  Enable support for the Sahara protocol transported over the MHI bus.
> +
> +	  The Sahara protocol is used to transfer firmware images, retrieve
> +	  memory dumps and exchange command mode DDR calibration data between
> +	  host and device. This driver is not tied to a specific SoC and may be
> +	  used by multiple MHI based devices.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called mhi_sahara.
> diff --git a/drivers/bus/mhi/host/clients/sahara/Makefile b/drivers/bus/mhi/host/clients/sahara/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..fc02a25935011cbd7138ea8f24b88cf5b032a4ce
> --- /dev/null
> +++ b/drivers/bus/mhi/host/clients/sahara/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_MHI_SAHARA) += mhi_sahara.o
> +mhi_sahara-y := sahara.o
> diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
> similarity index 99%
> rename from drivers/accel/qaic/sahara.c
> rename to drivers/bus/mhi/host/clients/sahara/sahara.c
> index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..dc64beae06ada6915a506ed8f4ae4d71c03158bb 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -1,19 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -
> -/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */

Never delete the copyright lines please.  Is there any previous discussion on why we are doing it? 

---Trilok Soni

