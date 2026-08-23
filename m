Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF749C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1948D10E029;
	Sun, 23 Aug 2026 12:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfBe743C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QYAYa2QZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EC610E029
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:55:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NAAQGu2852926
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rWtDIrQYEyI6JicjlZo1CV9b
 6jk+qjMeQz26se4HqAY=; b=TfBe743Cs+W1oBb77dg0jwDuip5GwO7na2ocqDX2
 cgdkBmLKpqwgPzbmijLZ58YEDkux5/lSo6YWhldinYkaeP1cEwC2IdL86NiwXKCu
 JXbPmAa8PaAEzoe8EbfVLgLNuR4Y/HOzWV3kN40Eh86u9VVy3dha5PjYn4BznVeP
 HA7+4k8PmTN8ROvdbpg0kE3K1QjhZMQegTbx3mfGAlmoDa7hlzZIcY21Viat3Dqs
 L+3MdxYYtpcymSWlcQffRBEeL3sWRaglVaMKbpaAfJ2fJ3geyjG/w3FEgredWzG3
 XxC/nSGyCvpRApwaqncIfw+YnjEPK4mfADgBae86ybCzNQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhbf0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:55:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso4417410a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787489722; x=1788094522;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rWtDIrQYEyI6JicjlZo1CV9b6jk+qjMeQz26se4HqAY=;
 b=QYAYa2QZ66s1Mwr1+/bbGc8/i78Au5RU5Po14cL06RsSB42YIy2/EbgCfa2A/LjXxr
 J86pk0fcBYGb+g6vRIS1mo/xe2aEfjg51a5gyvZ4Fy2JOSb3E8VQgw1VAwzE7ux/N9Qi
 DUL6S+YuvNv0isI9pHMnLiFtN1Scuwf1s9NJPd6255WB5RGACT9BrmM8t0jMLNWFGq2p
 rx6bWZDdeOsymlzE0U4ZTU5lTqcnWKbNNbwJnrMxrroG6RGXABPs+Ntrzt1yPuVgP6Bn
 5k5bhtpguACL80KXJU2ZLkfV+cydkLLp7SiCwkz4RxqIxp8NQQ4MYAaIk4FBNEb8bSP3
 wv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489722; x=1788094522;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rWtDIrQYEyI6JicjlZo1CV9b6jk+qjMeQz26se4HqAY=;
 b=YQSQkweXl6HmIrTsidAJ2vWPN+58y8yHn/R28ygqYNOvXifnMQRXoccnS9td43AYnM
 LGQAPWd4qeHrUG6euWDXAP0cTye4YulT+a66NMQGEkVKRI2U3VSSOSxP4H9BJjRIfF4h
 Izhqs6q5sjaFTRYqoV8M352XiS1ZpafI/mzh0LPN0CnOiQnfW5eGC8Yed8KB5j4aoO9b
 ab2WG6vqJcwDrR5Rk7gHrZP+4dobrNAsCXVFC7IGpGdZdXO5WQJ1zwa0s4mnBz9ys30l
 77cN3kUAKS4xkA9ogK9qsTHovSgP0Dn2CACAbg/kXY6DbDylwDH+dcd1L8ywshvW3/fX
 oHKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4AzA1txtAvL5NMzXnJ99i6dSkJroXJ/Np47ZiYVvU/4N59EMFAtdsxCvHRfFNy1PrTcKVt8JoMkk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nguvYq7qbYC6KoWRYesCUUFSgf94s7J2Mu2b+z/H2ulhCkuE/B
 4Dm0rY0q+naKJerwgwXS/HcaeOtVSgFz2K4oKKIgbV2kZv8QkAwNE9e3elWojI9nYpae4sIyI0I
 uphxqw3+cmLMnKTm1FzYI3ZoOFyhY8UhPlAeNejMxxUGNs+/saHNDjgUSGue3LRAMrZmxeKk=
X-Gm-Gg: AR+sD11xu3oH+RDgyrzEM+q/tBkn3sbBqez9dipC8acl1pZag6dtjdr8V4P0+M9UWHP
 bGln5ZzB1Ir9NoxOoqoW7CPVGJGUCYwXXjegX4LG7gPKGiroeHBM6XVjxDCklrBguFugCZuh51W
 ncPjNw2jXyk9ZjxUXE/J5hezFCedfQyiW8tkoNdxMUiw8IMG5JcaQyu2Ko7YaCs9bUaGdTxWUOp
 CZH+WUhuD+tbcDCCEa0j6AUgIRUT8CvEyZ23rsD/xVKmQEEEiG3jL96WXc+VetLIZpJ/arTuwEh
 mT/CBHnCLyCly0haej5jjP7bp4erG5NG2v3rK3IC04tNhnzBrKGrWn/+oayGZxUKiuKZ6I7UF1e
 uOy2iyFfh89XYO+xpMNTcPVTLUw==
X-Received: by 2002:a17:90b:4b02:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395df2595femr18223909a91.10.1787489722285; 
 Sun, 23 Aug 2026 05:55:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4b02:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395df2595femr18223837a91.10.1787489721847; 
 Sun, 23 Aug 2026 05:55:21 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186173199sm15411282c88.9.2026.08.23.05.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 05:55:21 -0700 (PDT)
Date: Sun, 23 Aug 2026 18:25:11 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <aortr3FLsAMxcVXs@hu-mdsor-hyd.qualcomm.com>
References: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
 <20260808-lt9611c-v7-v10-2-ee90a136d82a@oss.qualcomm.com>
 <uuuph37ftuyuqpbayqbotnsqgqn367ytdam627jl3cqcxkzana@xq2pky3dobyx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uuuph37ftuyuqpbayqbotnsqgqn367ytdam627jl3cqcxkzana@xq2pky3dobyx>
X-Proofpoint-ORIG-GUID: Xpymjjx-Ug1MXOxSmI0mmKNt5XuOdWpN
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8aedbb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=pMoGBK1uSPhNkBhojBIA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDExNiBTYWx0ZWRfX6IXTi2oIiebq
 0GtgZR0mizrCs26Bg9eIzIkzkU7kt1VIHC4NEKGs9gllNrfU6DoMeVJNluWHCNc6uNhHvJNOr3/
 kQkKVWA6y3LdFFtsAKhTR5zg1ppTa+N50CrVXTFc3pS5MNC9uMTMc2oLTZ9C+T1Depgfq5aGRcq
 9gecf/ozs+oFAXL47fZQbzu2IbxoIY7DHIiqtPQMUsEcgbM48dLqHlxLKX1YoFoG8jUs1rGqukr
 EcBjc65V6KB/RF5oZDei8NOf8nOlGBfyZzLO7NNC690SdzM1WVCU30sTLtn4et9fukdgncmPbLx
 LvJetT4UiMKjMv02XZ75EJ1EJP20Ei7EL56pPikp9I6QJp3VP69wJw6k2fYE8oykJuU0FgYGeDS
 lAUsKaVpT4JKdAnhlIRPwc02lj2ujjqzsInxrIcRgXer/Rpyo2O3H6Y8ViiKXRN7i98mexAhJAt
 IiuJiPhPg+QaTEsVdYQ==
X-Proofpoint-GUID: Xpymjjx-Ug1MXOxSmI0mmKNt5XuOdWpN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDExNiBTYWx0ZWRfX8V1pLm8fuMa4
 KTDh0Dny2NsklPjqeb+T2gJ3aIMtrBKrrGqbfYHyS0Nwk8cu/iQim+DLiIPEhlUwSIdSD5OJvDB
 QubeCoVU+6L3YJCZYoLsFHDMr9Rtuwk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230116
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

On Wed, Aug 19, 2026 at 12:49:53AM +0300, Dmitry Baryshkov wrote:
> On Sat, Aug 08, 2026 at 01:37:51PM +0530, mohit.dsor@oss.qualcomm.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> > 
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > 
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > ---
> >  Documentation/ABI/testing/sysfs-lontium-firmware |   10 +
> >  drivers/gpu/drm/bridge/Kconfig                   |   18 +
> >  drivers/gpu/drm/bridge/Makefile                  |    1 +
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c         | 1283 ++++++++++++++++++++++
> >  4 files changed, 1312 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-lontium-firmware b/Documentation/ABI/testing/sysfs-lontium-firmware
> > new file mode 100644
> > index 000000000000..8700933ba0f0
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-lontium-firmware
> > @@ -0,0 +1,10 @@
> > +What:		/sys/bus/i2c/drivers/<driver>/.../firmware
> > +Date:		July 2026
> > +KernelVersion:	7.3
> > +Contact:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > +Description:
> > +		Read: Returns the current firmware version loaded on the
> > +		Lontium bridge chip in hex format (e.g. "0x0105").
> > +
> > +		Write: Triggers a firmware upgrade of the chip using the
> > +		firmware file loaded via the firmware loader.
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 4a57d49b4c6d..d1597548e578 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> >  	  HDMI signals
> >  	  Please say Y if you have such hardware.
> >  
> > +config DRM_LONTIUM_LT9611C
> > +	tristate "Lontium LT9611C DSI/HDMI bridge"
> > +	select SND_SOC_HDMI_CODEC if SND_SOC
> > +	depends on OF && I2C
> > +	select CRC8
> > +	select FW_LOADER
> > +	select DRM_PANEL_BRIDGE
> > +	select DRM_KMS_HELPER
> > +	select DRM_MIPI_DSI
> > +	select DRM_DISPLAY_HELPER
> > +	select DRM_DISPLAY_HDMI_STATE_HELPER
> > +	select REGMAP_I2C
> > +	help
> > +	  Driver for the Lontium LT9611C(EX/UXD) DSI to HDMI bridge chip.
> > +	  It converts single or dual MIPI DSI and I2S signals to HDMI
> > +	  output. Supports HDMI 1.4 (LT9611C/EX) and HDMI 2.0 (LT9611UXD).
> > +	  Say Y if you have hardware using this chip.
> > +
> >  config DRM_LONTIUM_LT9611UXC
> >  	tristate "Lontium LT9611UXC DSI/HDMI bridge"
> >  	select SND_SOC_HDMI_CODEC if SND_SOC
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > index 15cc821d85b7..f322f3f89f6b 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT9611C) += lontium-lt9611c.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
> >  obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 000000000000..e6887f2c89a6
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -0,0 +1,1283 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/crc8.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/media-bus-format.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/unaligned.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_edid.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/display/drm_hdmi_audio_helper.h>
> > +#include <drm/display/drm_hdmi_state_helper.h>
> > +#include <sound/hdmi-codec.h>
> > +
> > +#define FW_SIZE (64 * 1024)
> > +#define LT_PAGE_SIZE 256
> > +#define FW_FILE  "lt9611c_fw.bin"
> 
> Lontium/lt9611c_fw.bin
> 
> With that fixed:
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Thanks Dmitry, will fix it and add R/B tag.
> 
> 
> 
> -- 
> With best wishes
> Dmitry
