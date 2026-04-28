Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C656FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A5710EA3C;
	Tue, 28 Apr 2026 07:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvvo+9fH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ksOdDRA/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E8D10EA56
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:49:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S42qFV1329060
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uWuz92n86FxORmdDcAoKhR/R
 d5+JAjTjibu5p1/dF2I=; b=lvvo+9fHgS0xUl4yeN55ueCi1i89tVyxMf78aE5e
 Qqd9jsZH/bgfQSX/8fTmbjgTk9NQPJ+us8+rPfrom9oZ0lj+b3HQEc3WiRbQp2V8
 UMAhswQ58PMYWhkqNbBsiRUlGhpcD14Y7bazECp5SAlgwxJpjEXi5hmIi9NsS2zi
 hbpHcWo/In4piEaUNUbER2YS8pTNS7nNEb3QBJiDh1QGS2vwdUPbL6xVJYRXiBr/
 3o13Ni5uWgESmBL/0ASUmHGAuBc+RMq8Ew3/Ct4BRysSqFYBx13qimPjQO9r+MFC
 eGQjMUtqMXisMgWn3uM9lWLsdzEMgGUeqjSBjV9SUSgfKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhagryy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:49:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50e2592ea3bso118800851cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777362568; x=1777967368;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uWuz92n86FxORmdDcAoKhR/Rd5+JAjTjibu5p1/dF2I=;
 b=ksOdDRA/DwX04Xc0zYVKWKyJHY3cIF4+1D53cLrt4USh/pzvA7jNbiHHXxYOY6R9O+
 Ua7tWb8EvuU50KZEdC5C2HQ/HdePdBRaad/YNoaaMwafXA5o2rCB0VW0HXjn3o5HT/Hg
 LlnCkGaIEJM285yDplrzn5TukYQ8QzY99NIONzrhMcG7lSbtGSUbKZlo17BAWukleLQv
 Ho5YqXc+cN5y8dqe0ubyBWkWYdeNd3z3EiFCLlOLhx92ay63E3g/99zs0d0UGeTkRHC3
 zB9ei22Xx46Di20irl5thHuVQ2vK0PRIHcmUCjfN8MRqo17us6Zk8hI6u67guFudh0HG
 Pnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362568; x=1777967368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWuz92n86FxORmdDcAoKhR/Rd5+JAjTjibu5p1/dF2I=;
 b=X9zWndJwvxAltSxKUnMW6aWfGnVK5HqP1R56i2Q+duRs5KN+KhwL6Bputmkd0mDwrz
 S19y8dkX/GXYXPBkIZD6cVRprD33qXeLmt3pXmT4mT+qIEHtLNp9UuYT+UbnrQX8cczb
 fzvgMo/EIJeEn7RY2mjMz5IZ6jo8DEX6HloWJ1kOSfCUvGXA7fCWvUZWQ/9LiT3iinxj
 hxiRjI631zSneN2uHpGoJ/5TydTJPHP3b6lfMWHyAFy2cTf4s2jpHLTmHLOi2NfP0wFq
 sVa0hZ58VW4aiGeIPtlvaQipCxBNL6KnjSs1kYzaT7/gO4n04cOGIFK3pLogkr62hCmk
 zGCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JKJgs31SyWJuR0eq9C0r5jSFJL189DlciKrOSulSWCK+GCKx+YQy0M7owLhGQFZG3e52VO3V+k5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHMMR5PKH5AsrHvfZUuf/JEqSbYMp7tABDrt6txl9dOmxXf8WC
 nhGM/rMAJ6FFtl2xtDJYPn/uXJXibWwrZwXCXQn7IzYaJxN6cEcCrOQ5LC3m0SSrzVmxFi+URiR
 Z6quFxLb5XWioXeshiDvD3oB/1dVlaCzmkiXF+WaT6uBPVE/0HmQe+1NieFc9PqRDOMlWgds=
X-Gm-Gg: AeBDiev/J8cD6WnzwSfylFHjft5pTcV3+BNrOOfoiQtOE+8ZlvXhyLCWHfEzR4lYAbX
 zptxe0/48nUwz1zD3Ej/uFbJPvp4sYKWjkzTt+6G3ILz44D1Jhfmg3oKttznpC6PhF6gSAyApPy
 OhVynCqBJ7pLv4nFG7sVSBNjneyTM32aROiA6TbegPGc1YPLcXIlrT87TXmGjur/j/UaTqGU1t2
 qbBnuHcFk0cdJcj/5TCzZrtiyvn1MWCZSGxGYXw0qrtkQGsC4zTFPqjyloRvF8ULi4XbP7ae+eR
 U40OwOo+dduQL88+clwCTqWXq7/K1LIZJ56BuOjj2tmZUS7E7b9IihbvJOqU7J2ilvgXbsV4/zT
 SGjvud9Md0p9t+Y4bi0QCKX+3d6igEWP8kOWyYmT8DODjEcMwzXfPF4L8JI/uWVUVK2wXKjtpaZ
 QKo2R1eXRZUeeDnsbkHZzNgqODBOPINyM8x/MdIbH+6oBMpw==
X-Received: by 2002:ac8:5807:0:b0:50b:37a6:4f0a with SMTP id
 d75a77b69052e-5100e1ea433mr26199941cf.57.1777362567762; 
 Tue, 28 Apr 2026 00:49:27 -0700 (PDT)
X-Received: by 2002:ac8:5807:0:b0:50b:37a6:4f0a with SMTP id
 d75a77b69052e-5100e1ea433mr26199531cf.57.1777362567239; 
 Tue, 28 Apr 2026 00:49:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f5de1sm418871e87.40.2026.04.28.00.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:49:26 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:49:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yangsunyun1993@gmail.com,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v1 2/2] drm:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI
 bridge
Message-ID: <ygxqqtql2puvej5bkmac3vhlwd4lv2f4mcjim2ornq5gj7rsoo@6zfnqckp2d7a>
References: <20260428063224.3316655-1-syyang@lontium.com>
 <20260428063224.3316655-3-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428063224.3316655-3-syyang@lontium.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX4aXkRx290s/t
 l2RVyK+QlYP7v2XjfB1FwQGhTOP39dsqJkEDPPVRrnYs26f0u2wvjOsZ5WljZcUDNklP3+rdtw/
 j1fdU37n5nLWZM5TGeKAcNgQp8Umu8jgPLxAiI9pjhrLnWjaO/s73ewSfB1mraNeQrxwoSf8OKM
 xFhMC4y68C8TRw4EKRVrU5k4RMWL48/+u99IS62/7ZDk/NEgyM6zInxiJhd4II6+etkHZmsCFES
 3kkrSBMuxp+YzY9txfb9mhP62nW5MxQT3Upc8DUFO8iyUNvqf0ctPytoMhvDWbP7O8m3glfaZnv
 ip1ff0gymSn2KTi5/i1kb4zEx2QEQ9BeGAoZsqeMlUlfnXXY5+XPTDosw5ifiiS6GXnze2x/+qW
 yyHnhp9XltDW3uEpFF9D1hnZMdxn4HAMrQfrfzWGpk7qwGisU22gGRDGk74Mv2YMt9Z8z5MkyCE
 COZ/OPjY+hv0IhVaCbQ==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f06688 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=Kz8-B0t5AAAA:8
 a=w7maeejPXaM3MacE_7AA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: y32rTGGw_MNoPuXRj2JbBCwjrWMFL_h7
X-Proofpoint-ORIG-GUID: y32rTGGw_MNoPuXRj2JbBCwjrWMFL_h7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280071
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

On Tue, Apr 28, 2026 at 02:32:24PM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> and output signal/dual port mipi.
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig             |  13 +
>  drivers/gpu/drm/bridge/Makefile            |   1 +
>  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 497 +++++++++++++++++++++
>  3 files changed, 511 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index c3209b0f4678..8cff2bf15b09 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -132,6 +132,19 @@ config DRM_ITE_IT6505
>  	help
>  	  ITE IT6505 DisplayPort bridge chip driver.
>  
> +config DRM_LONTIUM_LT7911EXC
> +	tristate "Lontium eDP/MIPI bridge"
> +	depends on OF
> +	select CRC32
> +	select FW_LOADER
> +	select DRM_PANEL
> +	select DRM_KMS_HELPER
> +	help
> +	  DRM driver for the Lontium LT7911EXC bridge chip.
> +	  The LT7911EXC converts eDP input to single/dual port
> +	  MIPI DSI output.
> +	  Please say Y if you have such hardware.
> +
>  config DRM_LONTIUM_LT8912B
>  	tristate "Lontium LT8912B DSI/HDMI bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index beab5b695a6e..70ddca75dd3a 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
>  obj-$(CONFIG_DRM_INNO_HDMI) += inno-hdmi.o
>  obj-$(CONFIG_DRM_ITE_IT6263) += ite-it6263.o
>  obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
> +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) += lontium-lt7911exc.o
>  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> new file mode 100644
> index 000000000000..85cb6cedbfa3
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> @@ -0,0 +1,497 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> + */
> +
> +#include <linux/crc32.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_of.h>
> +
> +#define FW_SIZE (64 * 1024)
> +#define LT_PAGE_SIZE 32
> +#define FW_FILE  "lt7911exc_fw.bin"

Do you plan to submit the referene image to linux-firmware?

> +#define LT7911EXC_PAGE_CONTROL 0xff
> +

[...]

> +
> +static void lt7911exc_remove(struct i2c_client *client)
> +{}

If it's empty, it should be dropped. .remove is an optional callback.

> +
> +static const struct i2c_device_id lt7911exc_i2c_table[] = {
> +	{"lontium, lt7911exc"},

Drop  the "lontium, " part. The I2C ids (unlike OF ids) don't have the
vendor part.

> +	{/* sentinel */}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
> +

-- 
With best wishes
Dmitry
