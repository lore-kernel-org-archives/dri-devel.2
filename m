Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890E3FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B9610E0B9;
	Tue, 28 Apr 2026 12:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqCSj7QM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="byX1PGRQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91AA10E0B9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:50:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SAFtft2111973
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2zv7YjboLNX5OIPh/Lp4HnJi1K9lh7I+BCrXXl8Atq8=; b=VqCSj7QMgVw245+v
 uVaVAvzSCkXtWwWt4a/+jaMqjNcIzp69jqP0mTZmZU+WGuxIsoeFQI/PJUAX1GCj
 SlYISJh44WI5tVwMNuC+XAj+wCxEz5genVNd4VLDN3G+6C3wm3UTUG+WlBTvE+53
 z13o/vssK0eBxH7Wmsev9oHPwkyNG6kaEWXIPhuGSv67TSCeatzRly5y/4+o+ppY
 gUEmPNMB/ZCwvCSedJPb9W3eIk/BXiW2hMvUIpNmZqkuvpPJGh8sq5vIk888soHG
 63UdiXEqX84v19jDt+o4wIEwVoxbVVxybaQvxFxyP5XXGrVDjXpOmQKsbPTruFwL
 vEj2Ew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbkjuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:50:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso102012371cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777380640; x=1777985440;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2zv7YjboLNX5OIPh/Lp4HnJi1K9lh7I+BCrXXl8Atq8=;
 b=byX1PGRQoiMjBjl1USI1h4nI5NbJS+fS6QirtflaGKiJWzFxE5nYvfsa97Z4MadVyt
 ojbieEY17UXeD5E1r1cEB9zDjTmXrzjg+YrjXPBewakYwC9X0QLPK1hEYPPpdUUJ/8Uf
 Nw0I4TZ4GrrEFRGmRMKnmfPYnleFFbgYvcjEOql67DGvNpZxSG2ZeOYMNYrS/Z3woxi+
 oicHbVoOpXJSVBQ97MOL2J9CnMhxJKFeVSjZQr6Of7QvCi/YLKMZ685mDq1AgmZ4Bhcd
 GdI0p2Lmhjaag6VOrgAE8W9bAi+nrOBOWSIW8tT8QP5rz9GwKxiSMwCqhIso/jkuUkLL
 YSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777380640; x=1777985440;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2zv7YjboLNX5OIPh/Lp4HnJi1K9lh7I+BCrXXl8Atq8=;
 b=XPOUNXVGK5yc/RUtvhd3Q4PHwdddw/8ZOroCslbWKqUOlifeshHk/tPkuIV8RillhS
 MHhmiqbD9tSVevB0FmTMxNtVbR7LK3h+4XKEkiQNhkPlIjMk/bLcrCw6GgADx7Hk5uqd
 9Hx+6RB5+MAccJJYjabgUAr7xbYTxoHl5EaQnT/GsjvjtrSZRg7TXcK68JwqwiuqT14P
 vixag2fYjwsGWXKTCZE9jdHgPG4tH0pWi/WlAGPcar7ksv7bRkxrDFXDhmkhKmeJxCiv
 XrymMjiF+1tyPabHXXErgWkAWSQrd7mA5yPDDskO/Zr63SaZ07u8o+N5ayvk5ZVKz/kQ
 I1zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r32OAIQHVYjeVY5sDl7ftB1SFkvLi4xYFG+W5WQkPGs+DBs9sCX/SWSCEfzQuhCUcAJInw1d2as8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuesLk0cF5I+stMhi5v65CPcg39/QcGrxgcF2Ymn1cYeL9y2JK
 huNUUEH5OaPVIUxcO9OWfi+igG92DS2OIBbwyrhk84MRMGwQanH32r51r3V+3/BazIlM9CI08Dq
 rgav7iTJvy1uRgb86TqeaWCmj9lOD3NNXHzqga62PdbVebbKl5MEgNAvHH+71H07vU0iFcz8=
X-Gm-Gg: AeBDiesUIY3/nWpsLEn0tCOW9YYzcn1d6kyb/ayvaxUZG5gXu9ct3GQmKMJR5poplI7
 Xcw0p+BFidBtV1mOATpK+GtNUhY6EHoFT9VpK+uWTboKs8STJtQnhW/OKlFSgD3ymEbSKUl4dwR
 3Li0JfOKwXxBVHzQCt5/3xDLXridRUJixIkviSPK7Tt33J3GBQ5xP/Q6eQYt8xuEp9Snj4xvx2H
 PkJqsQniIzkBzYW0RF809+DTifaOrDG57tyd0svtaxuBd3xRiHDuT4QqPjfUL3xOWGqzexO8LGP
 Gfc7fgwDXDoyKMkqO8HAVvGRL/RzZcIK4dagnjRzS2Sd5dw/omTfRlVVhAb7jeYNq+r4c1sb/Zn
 acl8u+SoWnR70l5mKsnj3Vgpxn1GPVt7MJ+h77CY4cTIXoV5AI4DQf7J8ouWVVSo27f35NKVi4n
 /5pcWaXGxttN6z4Evqp78xxfOCOGr+zLFlR+WMqjPr6WUJQw==
X-Received: by 2002:a05:622a:996:b0:50f:b494:7887 with SMTP id
 d75a77b69052e-5100e20201bmr35852391cf.51.1777380640242; 
 Tue, 28 Apr 2026 05:50:40 -0700 (PDT)
X-Received: by 2002:a05:622a:996:b0:50f:b494:7887 with SMTP id
 d75a77b69052e-5100e20201bmr35851781cf.51.1777380639579; 
 Tue, 28 Apr 2026 05:50:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f5f03sm593888e87.51.2026.04.28.05.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 05:50:38 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:50:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v1 2/2] drm:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI
 bridge
Message-ID: <pwwozhtttczv56bekqjl4vxrueqfblvjjjnnjnvuqlw2qahqlh@2yhvlnjsiqrv>
References: <20260428063224.3316655-1-syyang@lontium.com>
 <20260428063224.3316655-3-syyang@lontium.com>
 <ygxqqtql2puvej5bkmac3vhlwd4lv2f4mcjim2ornq5gj7rsoo@6zfnqckp2d7a>
 <CAFQXuNYV_Jzi26FN23b8zgw-UEsgheo8R4OVzz2TG4YZnJoYcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNYV_Jzi26FN23b8zgw-UEsgheo8R4OVzz2TG4YZnJoYcw@mail.gmail.com>
X-Proofpoint-GUID: b_nokn-zAER_p20zBC_j1C3ZEM8mvJrU
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f0ad21 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=9OX4YJtEninwzQWm1icA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: b_nokn-zAER_p20zBC_j1C3ZEM8mvJrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNyBTYWx0ZWRfX02cgavcvV3z1
 JShXm9qCOOfy3EjXZ8hUkGMZbPrLsE+QnsGfMLO8CDAXUqykjtCfrgdAeJXPVHpanwLycP15WeO
 sF25TbPuWTCsrggyAipt8a/ztqsEjjW080CqLE/XRT/rpS555YcIcopyzOOUxbRfJpT6Jw4Qcub
 CrIwkp7OMgY+SI1HbrWV7bxnKZH1rjdulTppDiI3pPiAuJDaW5gCKDN0KYjORYFzrHDstakS0FU
 /xxYNYVD6pe5h++/rxeOMqXcI58pd24H+oFnTXrNv9/kseRRGcGxTR8NhVIslvqsAVREMl/zb9d
 kfMXNKD4WYZfnnZEGU2Higiy/avyWqNjrVFE8vZU5fTec83v68MDwmO6i6E3cogKs5zAgKxunIg
 aQiiUEHtk4X6ye2K2R0RWl9wNVJVrfYcn/FIH+b5sacFMlFQAwvQDpZAXKd4U5Gx+D7hsLXL+YS
 w1XBjoxuo/r/1x4Ll3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280117
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

On Tue, Apr 28, 2026 at 04:12:40PM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月28日周二 15:49写道：
> >
> > On Tue, Apr 28, 2026 at 02:32:24PM +0800, syyang@lontium.com wrote:
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> > > and output signal/dual port mipi.
> > >
> > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > ---
> > >  drivers/gpu/drm/bridge/Kconfig             |  13 +
> > >  drivers/gpu/drm/bridge/Makefile            |   1 +
> > >  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 497 +++++++++++++++++++++
> > >  3 files changed, 511 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > >
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index c3209b0f4678..8cff2bf15b09 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -132,6 +132,19 @@ config DRM_ITE_IT6505
> > >       help
> > >         ITE IT6505 DisplayPort bridge chip driver.
> > >
> > > +config DRM_LONTIUM_LT7911EXC
> > > +     tristate "Lontium eDP/MIPI bridge"
> > > +     depends on OF
> > > +     select CRC32
> > > +     select FW_LOADER
> > > +     select DRM_PANEL
> > > +     select DRM_KMS_HELPER
> > > +     help
> > > +       DRM driver for the Lontium LT7911EXC bridge chip.
> > > +       The LT7911EXC converts eDP input to single/dual port
> > > +       MIPI DSI output.
> > > +       Please say Y if you have such hardware.
> > > +
> > >  config DRM_LONTIUM_LT8912B
> > >       tristate "Lontium LT8912B DSI/HDMI bridge"
> > >       depends on OF
> > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > > index beab5b695a6e..70ddca75dd3a 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
> > >  obj-$(CONFIG_DRM_INNO_HDMI) += inno-hdmi.o
> > >  obj-$(CONFIG_DRM_ITE_IT6263) += ite-it6263.o
> > >  obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
> > > +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) += lontium-lt7911exc.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> > > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > > new file mode 100644
> > > index 000000000000..85cb6cedbfa3
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > > @@ -0,0 +1,497 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > > + */
> > > +
> > > +#include <linux/crc32.h>
> > > +#include <linux/firmware.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of_graph.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include <drm/drm_bridge.h>
> > > +#include <drm/drm_mipi_dsi.h>
> > > +#include <drm/drm_of.h>
> > > +
> > > +#define FW_SIZE (64 * 1024)
> > > +#define LT_PAGE_SIZE 32
> > > +#define FW_FILE  "lt7911exc_fw.bin"
> >
> > Do you plan to submit the referene image to linux-firmware?
> >
> I want to submit it, but I don't know how. Please help me.

Read the README in that repo.

> 
> > > +#define LT7911EXC_PAGE_CONTROL 0xff
> > > +
> >
> > [...]
> >
> > > +
> > > +static void lt7911exc_remove(struct i2c_client *client)
> > > +{}
> >
> > If it's empty, it should be dropped. .remove is an optional callback.
> >
> it will be fixed in next version.
> 
> > > +
> > > +static const struct i2c_device_id lt7911exc_i2c_table[] = {
> > > +     {"lontium, lt7911exc"},
> >
> > Drop  the "lontium, " part. The I2C ids (unlike OF ids) don't have the
> > vendor part.
> >
> it will be fixed in next version.
> 
> > > +     {/* sentinel */}
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
> > > +
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
