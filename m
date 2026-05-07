Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94FECD3446
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81EAF10EFEE;
	Thu,  7 May 2026 10:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fnfAPSzI";
	dkim-atps=neutral
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F1B10E236
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:03:11 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-6967080e6c0so176218eaf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778115790; cv=none;
 d=google.com; s=arc-20240605;
 b=gMegphzkaKaDQ98qnZpyJM/5WvoxXZZYkSHEivKVa0ed+LNdPYz2pFa+Q4PWFbJl54
 mYOixQYK2B65pAwEOwIx3IZ3JFJC9fYGdTfBP67P5KhbijxAcvnZyPKYJ9tvqjKUfx3y
 8sS6hwadXSSfdhIpp11BY+TWq1rrpvjTLWGDIEs9SXfJystRmuiEONcxETXacS9FQyp+
 s6vCs4LlFDHRsSOtwSxqzsIOXT//aqw93nrsHAmffbknzrtni2KqDPMtfEVLh05khzGR
 J+q8ntd5ZnO8Rl4K5KeH9qmlwgAVUDgMacxKUgyziQrgNKGWHjnOLSOdOgDRRaZar6Jy
 uLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BjCezK8EDBdoyp0R3o6exrU7QV1NCQnuUfyShKygXeQ=;
 fh=U5pwa7sw6A9FlX5h5iPFxO9l/IFAG+onz4PjEOE1LNs=;
 b=N97gjszY0nkRK0F0NIiLObUjxDbiqK+2SOSwx0o5Cd5cgom3b84BpJE7q8wMUMU0p0
 qemTViKzfLqb0XqXSBM8QpUWLn338PPpqQOyHWPPlgCTwb3RC5XfXFYXbyY0694/JQ+t
 soFSMsqT2RLns8GHrGlv1WX7gP0URwMfb+dG2G9R7YKoeddxwT3PO7TvlyFJ7zZhbtFL
 J/2AnooQexMs3meEv/Q55hYKVoEkJf2S4L76TVPoKUoLD3S08mZStU6k+WYR33GCE7Ra
 j//v9W5Rx/701K6DZK+EmIBGJgcKl76a17SEPKZIDc5fIO7YzpIG7BG5taSccH5kw8Ab
 7JBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778115790; x=1778720590; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjCezK8EDBdoyp0R3o6exrU7QV1NCQnuUfyShKygXeQ=;
 b=fnfAPSzIkpZ4tbpL+8PoLzAxA7w5XipgnBDsFe4xJTiHugu98jyAy0fA8bxZTzOdYo
 G/arXJCU99w7n5WGd6zy1RhlbDuPUcTCkYzXaQH8DRQWid8bZVUGDdSlqKundL9Lpp6f
 D0mjswvUhK8zOKBgN6NK2iAoMampim8Wpmvycz8N89j7TIVeZUlTxyWyPdTmvL47ToLQ
 n/hGNfKBuCUNp/AYBlaRs16rE7bCj7G7713wiBSCGLSqk10cwBveUa+eLBWV8X9khbFI
 2q7lDvvyx1Oh/ST5o0/vh9yvWn9p2JQo/rdMsKvMYytHi21nPlO4DW2z3qQEEeYmsVhh
 +NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778115790; x=1778720590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjCezK8EDBdoyp0R3o6exrU7QV1NCQnuUfyShKygXeQ=;
 b=rJRHgLB2atZfyOlHA1Ax8txeiakj95dacoD7/B8aDVszMYZX+j+1IyvB9Cv4p7z0be
 cOXGTZi/OWj1FMUDMm1t2rgEX5Aq6AStQuAMSBsKBGtKMMQjoivYum217Zd9mvATrSKe
 /pn4Yh9gl7NL2mhFlxF6oLtW6NBy3MgkYDbU1rrlZFT0pG6KltF7WRJdbXGQl7guE53B
 4Xn4efJehu/UEJu5LL9HYD6NSd77MFzPGQnUMt7rOSZEXMlb+xko2T6k6WBerCG3GgMX
 3aNV2XtQYTh9fRY59w90bsSu8gXexNO0RzUReGd2AK/TJxfGYKUVSzzShetT2Nj0kB95
 pK0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ864yX3GCKmau77PZKRRymCdUbNDHc+pxEwKnV6uFosX8qe4epNMg3uT3EdRk2iskH5yvRAYNNZMcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrIbCvc6yPaAhGi0ctz811L2vZKJoA73yhfHaKZHfrlu57JYJd
 CGT/xAFiCCiAopYVTos29Hbfyc6ZxaIM6RCl3LzBZuk933VwzmL7FepoSlIXXMlZYHB/vmNzfku
 4K9SS7HZzF0clv0lemDGVUOXxrigXkWc=
X-Gm-Gg: AeBDietDksb1X2Oqpwy74LNwlPNZeAj4ehwGLIh5KimqxVPTYiuVZVQEYLdJwI51RDQ
 Y+2P/pb7u1wptRAeG2Uy/nh0OIOldc/Obv/+vskNgWk53FmGZP4U9HO45dafkzTPKa+qojOWdDr
 BrTx6cwbtYQInwoat5l4gMusWXkU2xAHyg5NO3Vf7lxOnMZFestn94nJsNteumbHx5yCKFcFYlc
 vIObd6RrVwn/CKERm0p3V7C7pVInMejFE69I2hFBM+fRat1wicys6nKBq8sgvRV9etQuo9ypKcW
 TtMNSsO3Gc9xh7hRYg==
X-Received: by 2002:a05:6820:c2d0:10b0:699:a28b:18ed with SMTP id
 006d021491bc7-699a28b1f15mr1399631eaf.48.1778115790055; Wed, 06 May 2026
 18:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260506095100.78998-1-syyang@lontium.com>
 <20260506095100.78998-3-syyang@lontium.com>
 <zcteqdnovguyiae22jnittje4au5pcohdcyga5l5wk42v5rczk@5x2qs7x5tfq7>
In-Reply-To: <zcteqdnovguyiae22jnittje4au5pcohdcyga5l5wk42v5rczk@5x2qs7x5tfq7>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 7 May 2026 09:02:58 +0800
X-Gm-Features: AVHnY4L319oQnDxPhs9arzb739HJx0OKlznkXMgo9epR6XZx-sxEJjzfi2uAB9w
Message-ID: <CAFQXuNYLZrMCzneK3Lk827vExheBmjzoAw=Wm+u34RxWfFXLdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:17 +0000
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
5=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 04:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 06, 2026 at 05:51:00PM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual por=
t
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig           |   18 +
> >  drivers/gpu/drm/bridge/Makefile          |    1 +
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1211 ++++++++++++++++++++++
> >  3 files changed, 1230 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611c.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index c3209b0f4678..32b85a2a65d9 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> >         HDMI signals
> >         Please say Y if you have such hardware.
> >
> > +config DRM_LONTIUM_LT9611C
> > +     tristate "Lontium LT9611C DSI/HDMI bridge"
> > +     select SND_SOC_HDMI_CODEC if SND_SOC
> > +     depends on OF
> > +     select CRC8
> > +     select FW_LOADER
> > +     select DRM_PANEL_BRIDGE
> > +     select DRM_KMS_HELPER
> > +     select DRM_MIPI_DSI
> > +     select DRM_DISPLAY_HELPER
> > +     select DRM_DISPLAY_HDMI_STATE_HELPER
> > +     select REGMAP_I2C
> > +     help
> > +       Driver for Lontium DSI to HDMI bridge
> > +       chip driver that converts dual DSI and I2S to
> > +       HDMI signals
> > +       Please say Y if you have such hardware.
> > +
> >  config DRM_LONTIUM_LT9611UXC
> >       tristate "Lontium LT9611UXC DSI/HDMI bridge"
> >       select SND_SOC_HDMI_CODEC if SND_SOC
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index beab5b695a6e..92688be9692f 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) +=3D ite-it6505.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) +=3D lontium-lt8912b.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT9611C) +=3D lontium-lt9611c.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> >  obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm=
/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 000000000000..3131f4a32dfd
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -0,0 +1,1211 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
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
> So, this file doesn't have any subdir (like all other Lontium firmware
> files), but then you submit a file to linux-firmware with the Lontium/
> subdir. Could you please settle on one location?
>
In the next version of the driver (v5),
I will use  #define FW_FILE "Lontium/lt9611c_fw.bin".

> > +#define LT9611C_CRC_POLYNOMIAL 0x31
> > +#define LT9611C_PAGE_CONTROL 0xff
> > +
>
> [...]
>
> > +
> > +static const struct drm_bridge_funcs lt9611c_bridge_funcs =3D {
> > +     .attach =3D lt9611c_bridge_attach,
> > +     .detect =3D lt9611c_bridge_detect,
> > +     .edid_read =3D lt9611c_bridge_edid_read,
> > +     .atomic_enable =3D lt9611c_bridge_atomic_enable,
>
> There is .atomic_enable, but no atomic state management here. Was it
> actually tested?
>
we will fix in next version.

> > +
>
> --
> With best wishes
> Dmitry
