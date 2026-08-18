Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633B0C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B808110E039;
	Tue, 18 Aug 2026 21:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8PTKP+u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L+hrUYjO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB3210E039
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 21:50:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ILbfY92073525
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 21:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=P7BPpuyOAx/6G4Ser6+Spcf7
 5yZCb3TK3+4BU1JJ8sw=; b=m8PTKP+uoPf28BKwFVEPaZACdGfC1JG0lYxtMX5M
 VUdEthTZTTwB/p0lDcBx5VuPtR74dDaMZj5TPbTLr+sQwHLtrW0b0poVrAJHWO3t
 /nQLFy4m+TN6FCLudcaHGld7FvqHyRSy6jHH8qupq4uCkHCNtyC/3pLhRnhWaxeC
 ufqYDztxEGVdckiSlOQeAe5BKiByD8AUm9dg8/vp7Bn3/SlhgJaIc+GVBFZZD6ti
 rxUhPOwL4pqXbUTjYomA0PkMaeeHN+Q2lL6M8AWKQ765irYdjky08JI7iOOPXtuY
 nVTA7yoIzua3aV+tOJIKX3BS65YFEpql5M7ztGx3pP2c0w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm81gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 21:49:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso48710085a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787089799; x=1787694599;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P7BPpuyOAx/6G4Ser6+Spcf75yZCb3TK3+4BU1JJ8sw=;
 b=L+hrUYjOCaLTau2VE2VWYfXaJjjgMp4bZFZtATWILGyhNHugxyOKQfPFoeWDS7FkBj
 +jY/HG3VbJRxTT5pXFuhHRyoTpTYlds3u+Q0RqyqJ7WyOzybPsODafDcrI5VokO6pBis
 7CJyYy7wdL9VMaKFvbq7Z0nUGK4V78Kza9aSVR95Agac6Qoh888K/yRPrZC/2n7w0X/G
 K31+QZqTSTWQTq1RmOUuFESP3f0nh9bcWjv60Cr+zowMLlXSfo9bcLTsjVnXWii4QEne
 Xo+BvvtvvSuxE/3v5HZtCllyKXl3fpiTFxOMzI6PvJg9jGOlYXrKz95AGCkznhqQr7S8
 KirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787089799; x=1787694599;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P7BPpuyOAx/6G4Ser6+Spcf75yZCb3TK3+4BU1JJ8sw=;
 b=k4gJvDCtepQZzk75DAqtUtZU9WZ8HLQT7PX874V5wkRuyIeBJpqM0ZOMtg80mHcJSC
 STqDjxh4CpiafGiUQTsELajK7mkmP2mM2tXCIm2AH1oj1G/NPSDsMfbHntU0RR4AWEVx
 tZlDF2nZHL4932oxSdl6yCGa5ATme3GYT9PYmF+eIO3/EOjRRk3vpxddNT5uN6IjwF9g
 0yftqjE0GQ0OY0Pr8/5qqVxRwX9Zv5pBk/e7315YuUtkcnAXcV99Ndo21xxF73dJwZ6e
 vcjZ1etLKNFLspaVyzQMY35zB6IEKJTLqNv0mSrihc93/GX0hCWiSecDkNnIzSS+O614
 r2bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoklW2YpISyNlQ72HGMPa345d10SiARWYkVBzq1YIZhWauMqykNzAALBRTgA8ayBTCTZWIWMaLPUqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHFqtrm4le9BMX5QnsD2lQy31yJgJpoxTnYvkMb3t1tHrHiUaV
 07SAub3PVDw7PUbggcUGvW6JJ2uw4dh2Em2tE+mk92YeXm600n4xocZjzc+5JDAPv1KPhqjHUIF
 IU9GyNzRf8FHg6JNWsLdHYJHBaZuNTADl0dwb6jFSCXSbvnBVWh7XoDz3ccP5Cqs5ARFvGS0=
X-Gm-Gg: AR+sD11Pvs/fDoTA8tIPBfTuO+mUZeax+4ZGr6sV13aPu18e8LYRAAxqM16L6fR9o/Q
 uwW/40jDq8BxqNrJ9096xeVUUjIYIM6PtZIzHQuBncl5Jc3Svvy2xazYycCceo5t2dMRVTmpKTk
 mdhzxhBhHeQP2+XaeAeXbMTqKAq+I7pwmqSpaTBke9dSb1x07pCxzR/7xZfsR7lRWRs6iS1K5St
 L1HkLqs2mKvtl9Vnq1DEJpHtZT+sKuzWzWzoOk7nsCysMhgRmH7STsa40cxycVdXhje5fGIGt6b
 P6tK3Pcvi8IRWSFUMyCF6UOogMidatu8mJhom9FGrbgOgZphA0w5OutSFUhrEZv4DqThegIeqNJ
 L7sb21TLC+Jl2eUoYEMitSQAEg7KE/yvfUgCmCkEg/ChWiwtewwnKgKrpCdClkkhz03IzCGQeYa
 ibvhT9MC1/55rE
X-Received: by 2002:a05:620a:600a:b0:930:b4f9:f327 with SMTP id
 af79cd13be357-9371e316b8bmr44562285a.33.1787089798625; 
 Tue, 18 Aug 2026 14:49:58 -0700 (PDT)
X-Received: by 2002:a05:620a:600a:b0:930:b4f9:f327 with SMTP id
 af79cd13be357-9371e316b8bmr44556785a.33.1787089798036; 
 Tue, 18 Aug 2026 14:49:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a16b1f31c0sm15151191fa.40.2026.08.18.14.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 14:49:56 -0700 (PDT)
Date: Wed, 19 Aug 2026 00:49:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: mohit.dsor@oss.qualcomm.com
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 vishnu.saini@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v10 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <uuuph37ftuyuqpbayqbotnsqgqn367ytdam627jl3cqcxkzana@xq2pky3dobyx>
References: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
 <20260808-lt9611c-v7-v10-2-ee90a136d82a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808-lt9611c-v7-v10-2-ee90a136d82a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE2MCBTYWx0ZWRfX98MkPTsXm+Om
 WVgfRfNbarFCgvqH05vE1Y+ii8vOSKaYS9GcX/0XFqcLTjXY/bxVg4oDe8zyf6kANqYhswoLTPl
 aQbyKQt2qn1KX1Y8+yXZhBaD6OY4g4oSMacVTpJSGZMGBU05xwM9S5GRIGCLFyy7CL1k7IlnMgF
 0o7CiytXq3F6vcrYfFZ8a7QRQUD0PeKKL6FwI3IyZIRDTD/Wq1deeZcHt1I9WvYU4AcM3mRzNSZ
 GUxd4nGTT/JYWKfh5hCAaT6QOZwvqgY1hlLjgEppWFiG7zqDEA61oCNBLm+OOk4Kyqo+CfPb6vq
 G5LZFyTPAlt+5wLcH+t38QAr4esVMSGCD8BbqQoxymi4RzuE7PdKHqU26i7sgLVmbRTIl3vnenA
 AvxxvKq1aD89ApeheP0M2XDl0xw+UT5r9/Z+pGrxNXStwrN8Jy/Jj02QJkY9B8LGkmRu7/ZaKR3
 oGjnwr/6NxBtyBOQ/sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE2MCBTYWx0ZWRfX7kZEPtMmb7ZX
 MwWGXPZV5P1ZSSKuHF+jSMdyJV9xn2H/tM2+DVAwEsyigVI1G/72/crzFg4B+gPFPfga/9bfPwa
 ltdxhMSIwnXHMOZKJ8ZZKplxGfvrR8o=
X-Proofpoint-GUID: Bi5JIyqqaZjPO3q_ZWmqsq867opI1wkN
X-Proofpoint-ORIG-GUID: Bi5JIyqqaZjPO3q_ZWmqsq867opI1wkN
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a84d387 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=6b6BgIowys52Drpq0AoA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180160
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

On Sat, Aug 08, 2026 at 01:37:51PM +0530, mohit.dsor@oss.qualcomm.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> ---
>  Documentation/ABI/testing/sysfs-lontium-firmware |   10 +
>  drivers/gpu/drm/bridge/Kconfig                   |   18 +
>  drivers/gpu/drm/bridge/Makefile                  |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9611c.c         | 1283 ++++++++++++++++++++++
>  4 files changed, 1312 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-lontium-firmware b/Documentation/ABI/testing/sysfs-lontium-firmware
> new file mode 100644
> index 000000000000..8700933ba0f0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-lontium-firmware
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/i2c/drivers/<driver>/.../firmware
> +Date:		July 2026
> +KernelVersion:	7.3
> +Contact:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> +Description:
> +		Read: Returns the current firmware version loaded on the
> +		Lontium bridge chip in hex format (e.g. "0x0105").
> +
> +		Write: Triggers a firmware upgrade of the chip using the
> +		firmware file loaded via the firmware loader.
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 4a57d49b4c6d..d1597548e578 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
>  	  HDMI signals
>  	  Please say Y if you have such hardware.
>  
> +config DRM_LONTIUM_LT9611C
> +	tristate "Lontium LT9611C DSI/HDMI bridge"
> +	select SND_SOC_HDMI_CODEC if SND_SOC
> +	depends on OF && I2C
> +	select CRC8
> +	select FW_LOADER
> +	select DRM_PANEL_BRIDGE
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_DISPLAY_HELPER
> +	select DRM_DISPLAY_HDMI_STATE_HELPER
> +	select REGMAP_I2C
> +	help
> +	  Driver for the Lontium LT9611C(EX/UXD) DSI to HDMI bridge chip.
> +	  It converts single or dual MIPI DSI and I2S signals to HDMI
> +	  output. Supports HDMI 1.4 (LT9611C/EX) and HDMI 2.0 (LT9611UXD).
> +	  Say Y if you have hardware using this chip.
> +
>  config DRM_LONTIUM_LT9611UXC
>  	tristate "Lontium LT9611UXC DSI/HDMI bridge"
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 15cc821d85b7..f322f3f89f6b 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
>  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> +obj-$(CONFIG_DRM_LONTIUM_LT9611C) += lontium-lt9611c.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
>  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
>  obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> new file mode 100644
> index 000000000000..e6887f2c89a6
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/display/drm_hdmi_audio_helper.h>
> +#include <drm/display/drm_hdmi_state_helper.h>
> +#include <sound/hdmi-codec.h>
> +
> +#define FW_SIZE (64 * 1024)
> +#define LT_PAGE_SIZE 256
> +#define FW_FILE  "lt9611c_fw.bin"

Lontium/lt9611c_fw.bin

With that fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
