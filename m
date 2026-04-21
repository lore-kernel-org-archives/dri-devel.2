Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DD4F89256
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EC610E0CC;
	Tue, 21 Apr 2026 10:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nS7jfthG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/k2ScXB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E7310E0CC
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:48:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9U04x046055
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C4t45Lgn7dwXMmmKVbWR/ZBMaXSGMvVAOUfQkfld2OU=; b=nS7jfthGZHNXb7Mh
 Vdch+YKiQiidV8NXIWqdapD0YxAw49paKjfW7S5WhjOwn7AKEwjt+h4J/uO2A/Ov
 9sCqLS7ZYmabip9y8r2m5xU2pN72vWX5u5L33mFpDjNRtiuy28OQ7yheL4B5fmKh
 9NJ2oPoDUspp36TYCEiZgCb8TZKqjEKaRsc+XIfPy0eWRr+x3LrbyI7tNWQh1oUa
 rcgeVsu2nJEvY2w5RKd1WyoXTnpg/xPsnS88H27Ygkua409P206rDH/7uO7oxsrz
 TKUZMX0B9AviOjdbEhK7er1jmSK2oidb1xcRQqKi6FQXfRXk9BoSZCsgElyhGgHb
 IDWDFQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1skxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:48:46 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-61002acc895so2044983137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776768525; x=1777373325;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C4t45Lgn7dwXMmmKVbWR/ZBMaXSGMvVAOUfQkfld2OU=;
 b=c/k2ScXBE/M+lyyUd+dj0bh9vE6a+1KXHFdDHSstETfvZx9EG/swEFguAbrF6q+0B2
 6nodNtWFpWwf2UIju04DOMtZ6J/L+JuO+VobR1ENYgsFNgV8iS7KwEDc9Lnqsw4gMxpK
 8/LcB+hl4dm0wfkEKY1geuxZpFsN1UeciB5nyR89D73dXL8KHt2j3HnG61BbPsbD5UXM
 6ZgnL1J1+vKGF1kbhwEpj2aYkWggh9IK5r9pTPAP2VmgdfKBSOx/yJKa+LzJbdPpZXyW
 HZvNgehOOh5rJiJdgdQ3tHf/zvY/v2G1Aozz8+AHF6s/z52tp7/azDthMjL1CZ5hb8NC
 ZYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776768525; x=1777373325;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C4t45Lgn7dwXMmmKVbWR/ZBMaXSGMvVAOUfQkfld2OU=;
 b=HBxBfkoeQukoov59evgWZoDYBFWdtFjBntGQ3dBkzKGVNVl1vqfaXCgtmL2yPDEK74
 ANrK1o3+8OrPbNkB5QbE+LYV5sl7e/HTkgLQ6cXPS/tugFq1uOlzIwA+vII24tCqFK1Q
 KNoNmqYsgux6ltaQClEfsjhq0WaqTIshyZgEklh6QCApXcT0V2x5ASP5Ed/ls8mwTUq4
 2INmNEgjsKqJO/N2kcjlJDhVLG8wsRLWuViacrz1yhcPL6h+qbuGc0MfZvlTFr+nqgpq
 JrimfdGsj2+kNYPpy/eQ0+vwvWi+D9xBJ6pBA1GKR/dbJ5f38je7VPvNlJNILrJd/ICq
 elOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9SwN0hebjG8LaL6fiHp42Q6yiciulzyQXnfqutJ9TQUZfCs+Er6ghXKdDGYWrc82vgrRLHR+UOAY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMRxqelpR45XDzipmc6tm8dA9MktyxnaAjNvxl0IpB7LSkyAre
 mIbm1WQ5MBK4LTxhy+3vnF8dVMiUjOtKt/H/dB/bQnThr9oai+Z0ssa9FqFKQ0mT50/0F0Thhu3
 6GSFA18AG29Z5Bc14YWyaUas7TULv8CRMqc2O1nBphmurTNUHAHAyTmqk/mQfcKKsPUwSZyI=
X-Gm-Gg: AeBDietfCkbFszcoldqcJ/kq69ANE03K8ZlO9PXE+VKCJuWFUYy+vi8t23QGjcSK5X/
 N7bd114+cCf+mkB610E+uK2nWqggzn7HWiC41937Xiza2TD8t50JQAUVIDf0V96+rVQGa+dYIDS
 JuBQZhNDFW4lxh9RFhcb+rhj7SWVs+7QXdWp9R2hbQxS0fUo1zXgCaMvJMGlvu6UR0H0iMsb5xD
 4IazATk5Y/Ibu/SZe+2kIMFvP1FWPL0ek/qK0NhAcTtel8Ep5SE1EpIP4GQBioaT4eJ4oDgsnhf
 p5MjDbZO9Fy99D82l9V8m8NBLSinTB8z38jD4uSz4cE2Gc69SZdHX67G/k6OxVshZRFAb9eNtUa
 p7PokSv0/vQUBMdk+D2HhptqZNT+IlvbAWVMYvDGLzQ9tlgp/E0lCBlCzlFkGtJLo1sMqlvnmcZ
 gQVn8Gmwm3LYabl+CqkDSFRpUzV8boD5NWk6m5oyzzz6qB5A==
X-Received: by 2002:a05:6102:5124:b0:609:2cf6:51d8 with SMTP id
 ada2fe7eead31-616f4546f50mr7665100137.3.1776768525083; 
 Tue, 21 Apr 2026 03:48:45 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:609:2cf6:51d8 with SMTP id
 ada2fe7eead31-616f4546f50mr7665075137.3.1776768524453; 
 Tue, 21 Apr 2026 03:48:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f5591sm28516331fa.5.2026.04.21.03.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 03:48:43 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:48:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v3 2/2] drm/bridge: This patch add new DRM bridge driver
 for LT9611C(EX/UXD) chip
Message-ID: <mvthlwcekj6i2h7bi5lns7ycictafjjyninvubp6adgaqxchkz@372c36cxon5t>
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-3-syyang@lontium.com>
 <stkoeboxioodtki3nyksdglihgze243u25ui7dbyac4tuuobgx@ncl4j6l4vfqh>
 <CAFQXuNYXP1fiJtUiMb5iBL=jVXTB8HX8JLzto_eGOZvUaeZkfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNYXP1fiJtUiMb5iBL=jVXTB8HX8JLzto_eGOZvUaeZkfw@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e7560e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=QNpe9V7w-6MnJwGHkaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEwNSBTYWx0ZWRfX1DWKmlPwTPK9
 eKE2yEIoefUYwU5toLLEaHPCS7soIJRxqL++1AMvs/i2arcXGaLSIqsGKPz9CH8TAQTXlaB2xCV
 2RFts49E1oFP1WeVCAhu+11hmeM3fnd9gEzV7etCvp2nD8ot/jgFd4v4LqQJsEulXxjIuZOgxKJ
 L68Dfg10ccx6aZETGII4YQqMgMoDxXObtnO00AaUcNJTOjknNS7Jcaxc6Jy0YyYlsD48t1GNvwy
 3lwYwhMJfN7cc6U5RE/snQpdu/kvqkCSOWmRmd1Vi7n2gVSCxaQSU4kHLyMFJka9AsmNiFsTS7K
 iS28AHjLe6yxlr/SOc2GblhBq1CchJ2Se3s/jEA1JVszcZOyR1IRUlY1DZQiu1VwShOURGsSUaX
 pDUOAcxOG7zzRPJUCo/kWzpIpFHmV7XAz+rjFDLdY80vwv4WnDJbN7KLmygW9yIyy29oumXOg7T
 80HV2Wm9Q/NPq5uGvPg==
X-Proofpoint-ORIG-GUID: Hh568f1aI5WRKesSrT9krolQV_D6cK1e
X-Proofpoint-GUID: Hh568f1aI5WRKesSrT9krolQV_D6cK1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210105
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

On Tue, Apr 21, 2026 at 03:37:52PM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月20日周一 20:18写道：
> >
> > On Mon, Apr 20, 2026 at 02:16:44PM +0800, syyang@lontium.com wrote:
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > LT9611C(EX/UXD) is a high performance Single/Dual-Port MIPI to
> > > HDMI 1.4/2.0 converter:
> > >
> > > -Single/Dual-port MIPI DSI Receiver
> > >  1. Compliantwith D-PHY1.2&DSI-2 1.0
> > >  2. 1/2configurable ports
> > >  3. 1 clock lane and 1/2/3/4 configurable data lanes per port
> > >  4. 80Mbps~2.5Gbps per data lane
> > >  5. Support RGB666, loosely RGB666, RGB888, RGB565,16-bit YCbCr4:2:2
> > >
> > > -HDMI 1.4/2.0 Transmitter
> > >  1.Data rate up to 6Gbps
> > >  2.Support HDCP1.4/2.3
> > >  3.Support CEC,HDR10
> > >  4.Support lane swap
> > >
> > > -audio
> > >  1.sample rates of 32~192 KHz and sample sizes
> > >    of 16~24 bits
> > >  2.SPDIF interface supports PCM, Dolbydigital, DTS digital audio
> > >    at up to 192KHz frame rate
> > >
> > > -Miscellaneous
> > >  1.CSC:RGB<->YUV444<->YUV422
> > >
> > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > ---
> > >  drivers/gpu/drm/bridge/Kconfig           |   18 +
> > >  drivers/gpu/drm/bridge/Makefile          |    1 +
> > >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1365 ++++++++++++++++++++++
> > >  3 files changed, 1384 insertions(+)
> > >  create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
> > >
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index c3209b0f4678..32b85a2a65d9 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> > >         HDMI signals
> > >         Please say Y if you have such hardware.
> > >
> > > +config DRM_LONTIUM_LT9611C
> > > +     tristate "Lontium LT9611C DSI/HDMI bridge"
> > > +     select SND_SOC_HDMI_CODEC if SND_SOC
> > > +     depends on OF
> > > +     select CRC8
> > > +     select FW_LOADER
> > > +     select DRM_PANEL_BRIDGE
> > > +     select DRM_KMS_HELPER
> > > +     select DRM_MIPI_DSI
> > > +     select DRM_DISPLAY_HELPER
> > > +     select DRM_DISPLAY_HDMI_STATE_HELPER
> > > +     select REGMAP_I2C
> > > +     help
> > > +       Driver for Lontium DSI to HDMI bridge
> > > +       chip driver that converts dual DSI and I2S to
> > > +       HDMI signals
> > > +       Please say Y if you have such hardware.
> > > +
> > >  config DRM_LONTIUM_LT9611UXC
> > >       tristate "Lontium LT9611UXC DSI/HDMI bridge"
> > >       select SND_SOC_HDMI_CODEC if SND_SOC
> > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > > index beab5b695a6e..92688be9692f 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> > > +obj-$(CONFIG_DRM_LONTIUM_LT9611C) += lontium-lt9611c.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
> > >  obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> > > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > > new file mode 100755
> > > index 000000000000..a6d11d0bddf5
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > > @@ -0,0 +1,1365 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > > + */
> > > +
> > > +#include <linux/crc8.h>
> > > +#include <linux/firmware.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/media-bus-format.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of_graph.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_bridge.h>
> > > +#include <drm/drm_connector.h>
> > > +#include <drm/drm_drv.h>
> > > +#include <drm/drm_edid.h>
> > > +#include <drm/drm_mipi_dsi.h>
> > > +#include <drm/drm_modes.h>
> > > +#include <drm/drm_of.h>
> > > +#include <drm/drm_print.h>
> > > +#include <drm/drm_probe_helper.h>
> > > +
> > > +#include <drm/display/drm_hdmi_audio_helper.h>
> > > +#include <drm/display/drm_hdmi_state_helper.h>
> > > +#include <sound/hdmi-codec.h>
> > > +
> > > +#define FW_SIZE (64 * 1024)
> > > +#define LT_PAGE_SIZE 256
> > > +#define FW_FILE  "LT9611C.bin"
> >
> > lt9611c_fw.bin
> >
> will use lt9611c_fw.bin in the next version
> 
> > > +#define LT9611C_CRC_POLYNOMIAL 0x31
> > > +#define LT9611C_PAGE_CONTROL 0xff
> > > +
> > > +struct lt9611c {
> > > +     struct device *dev;
> > > +     struct i2c_client *client;
> > > +     struct drm_bridge bridge;
> > > +     struct drm_bridge *next_bridge;
> >
> > Use drm_bridge::next_bridge instead.
> >
> it will be fixed  in the next version.
> 
> > > +     struct regmap *regmap;
> > > +     /* Protects all accesses to registers by stopping the on-chip MCU */
> > > +     struct mutex ocm_lock;
> > > +     struct work_struct work;
> > > +     struct device_node *dsi0_node;
> > > +     struct device_node *dsi1_node;
> > > +     struct mipi_dsi_device *dsi0;
> > > +     struct mipi_dsi_device *dsi1;
> > > +     struct gpio_desc *reset_gpio;
> > > +     struct regulator_bulk_data supplies[2];
> > > +     u32 chip_type;
> >
> > Define a enum. Having if (chip_type == 2) doesn't help readability.
> >
> it will be fixed  in the next version.
> 
> > > +     const struct firmware *fw;
> >
> > Please drop it from the global struct. It is not necessary once the
> > bridge is up and running.
> >
>  Remove from struct.
>  I need use fw  to calculate CRC8 and update the firmware.
>  Can I use a global variable for 'fw'?

Of course not. You need the struct firmware and CRC only when reflashing
the firmware. Pass them within those functions as arguments.

> 
> > > +     int fw_version;
> > > +     u8 fw_crc;
> > > +     bool hdmi_connected;
> >
> > You've lost the imortant comment here.
> >
> comment about hdmi_connected ?

Yes.

> 
> > > +};
> > > +
> > > +DECLARE_CRC8_TABLE(lt9611c_crc8_table);
> > > +
> > > +static const struct regmap_range_cfg lt9611c_ranges[] = {
> > > +     {
> > > +             .name = "register_range",
> > > +             .range_min =  0,
> > > +             .range_max = 0xffff,
> > > +             .selector_reg = LT9611C_PAGE_CONTROL,
> > > +             .selector_mask = 0xff,
> > > +             .selector_shift = 0,
> > > +             .window_start = 0,
> > > +             .window_len = 0x100,
> > > +     },
> > > +};
> > > +
> > > +static const struct regmap_config lt9611c_regmap_config = {
> > > +     .reg_bits = 8,
> > > +     .val_bits = 8,
> > > +     .max_register = 0xffff,
> > > +     .ranges = lt9611c_ranges,
> > > +     .num_ranges = ARRAY_SIZE(lt9611c_ranges),
> > > +};
> > > +
> > > +static int lt9611c_read_write_flow(struct lt9611c *lt9611c, u8 *params,
> > > +                                unsigned int param_count, u8 *return_buffer,
> > > +                                unsigned int return_count)
> > > +{
> > > +     int count, i;
> > > +     unsigned int temp;
> > > +
> > > +     regmap_write(lt9611c->regmap, 0xe0de, 0x01);
> > > +
> > > +     count = 0;
> > > +     do {
> > > +             regmap_read(lt9611c->regmap, 0xe0ae, &temp);
> > > +             usleep_range(1000, 2000);
> > > +             count++;
> > > +     } while (count < 100 && temp != 0x01);
> >
> > read_poll_timeout()
> >
> will use  read_poll_timeout() in the next version.

Or a more suitable definition from <linux/iopoll.h>. Please check those
and find the most suitable.

> 
>  > > +
> > > +     if (temp != 0x01)
> > > +             return -1;
> >
> > -ETIMEDOUT
> >
> return value of -1 means the chip did not receive the operation to
> write 0x01 to 0xE0DE.
> Below:
>      if (temp != 0x02)
>             return -2;
> means the chip did not receive the operation to write 0x02 to 0xE0DE.
> 
> -1 and -2 help us determine where in the code the error occurred.
> If both return -ETIMEDOUT, it would be less friendly for debugging
> when we encounter issues.

Inside the kernel it is expected to use drm_dbg instead of returning a
case-specific return codes.

> Please confirm whether I should change all of them to return -ETIMEDOUT.

Yes

> > > +
> > > +static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
> > > +{
> > > +     return 0;
> >
> > Hmm? What if we need to clear the infoframe?
> >
> don't need to clear the infoframe.
> 
> can remove.

No. We need to be able to stop sending the infoframe. Please implement
those.

> 
> > > +
> > > +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> > > +                                   struct drm_connector *connector,
> > > +                                   struct hdmi_codec_daifmt *fmt,
> > > +                                   struct hdmi_codec_params *hparms)
> > > +{
> > > +     struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> > > +     u8 audio_cmd[6] = {0x57, 0x48, 0x36, 0x3a};
> > > +     u8 data[5];
> > > +     int ret;
> > > +
> > > +     /* Validate sample rate and width (LT9611C auto-detects but we still check) */
> >
> > What for? You don't trust ASoC / ALSA core that the rates would match
> > HDMI_RATES?
> 
> Chip has limitations on sample_rate, sample_width, and fmt, and cannot
> support all formats.
> The validation here is to ensure that only the formats supported by
> the chip are used.

Again, for sample rates, is it different from HDMI_RATES? If not, it is
useless protective coding.

> >
> > > +     switch (hparms->sample_rate) {
> > > +     case 32000:
> > > +     case 44100:
> > > +     case 48000:
> > > +     case 88200:
> > > +     case 96000:
> > > +     case 176400:
> > > +     case 192000:
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     switch (hparms->sample_width) {
> > > +     case 16:
> > > +     case 18:
> > > +     case 20:
> > > +     case 24:
> >
> > and no support for 32?
> >
> no support for 32

Then check for that rather than listing all the widths. If you check the
hdmi-codec, you can't get 18-bit samples at all.

> > > +MODULE_LICENSE("GPL v2");
> >
> >
> > I think, checkpatch.pl should have flagged this.
> >
> yes,  it is need use GPL?

If it flagged the line, why didn't you fix it? What did checkpatch say?

> I see that many of the latest code still use GPL v2.

-- 
With best wishes
Dmitry
