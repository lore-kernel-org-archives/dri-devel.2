Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13C606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TWZIjlDZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812CE10E5C1;
	Fri, 23 Oct 2026 08:26:58 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC53910E5C1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:26:52 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so1140971eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792744012; cv=none;
 d=google.com; s=arc-20260327;
 b=n/r9C8+R1NWQbLKn8iZTEq1adofVQAAOezwI83HpGJbBcOfKiC3eJSgbGBQU0pJlXy
 0AMknNUyqO3Mi4h3RGr8NUVj9uN/eXi0U7Y+Rkgifgo92V4fF/uXKlbURnTUu9jc4q7A
 eryzi6zeSIaaTxDUj3KltEM4LGQ73lVa9LGVfGipY1gNI9IZys4BgaUe0eTafRfmIWlA
 4oN9KBl/VeVumCc1z5/zINm+mho9gW5zyBIdLjV0B5A2XnCN41+ZfizV77XLzCAdWzV4
 rJGKBVNzEV27Co8YhOrQ8eCstg2N7b8ZpJOQToRQMIHj47sU4oPd+9PH+s+7SC7Lvavw
 Yxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4V6egZN5/90CzSDhsgsIUhgRpoFs6ecw55JHEFeiHFo=;
 fh=btXR7Ho+89HmtVPSpYmXiytYCLvxcgD8PbaiqfIi7lk=;
 b=kgB4g+kwOGV+gUKl3wt3u5sRk+JgE1c3u75/KVj3Iic6KXUtXwwi4dXFgrkYRPTzVK
 GiqfwEbCN2HM8LU0/7gJiT75GMh6Jq+WXvCGSLrTcqQIPSm/F3/vguRnLE4VahhX54n4
 8sOqVb8DUDZaz/HpJa+pf8S+Tb4QWzcd5ws/kKFvQqdzPSVTXM3fbPW5I1/wVeM9nag8
 uwMc+tlA09sBWjJEwnlvJl8KjoSQRbG74b8x3oj0PlbTJ3RwXPF5hvlsIxFUyA2TtQj1
 h+mHZmAEckMsNGU3Ij0KcwOVZbvn60RyqeA9B2LIptXVsvQZLgXWtigH6Eo5hlHwf6VD
 maYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792744012; x=1793348812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4V6egZN5/90CzSDhsgsIUhgRpoFs6ecw55JHEFeiHFo=;
 b=TWZIjlDZ8Jk5CQZxUURRpOvrDGxTf+XwQwk4C9/W/wPLTgSu9nSW0tOe6OEio/8QAt
 b7Cxo11Tvts9xc1FN4aA7mYghLiJkGO+7mEcuxG9NEXv//REgMEIem2QgWvORbbrLN1u
 aj37CtN08XzDcUEIX36kUJbNi6LxSNczsjIw1Dk2D3I8nbYBCE6ZaTr8A0DVM+wUYb37
 avlbfI5usoJ80f2gQHTB0Y1WP0Gr+iKdKWWNaNvdgC2OtWaFZdoOjZbeXH8wP3czM0kG
 SJtXTfToiKpu8FRV5+cWQi3U00cVzCgqFblwySHiAcLQr5jj77D+1aUNG8Nr52/mzlBB
 +54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744012; x=1793348812;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4V6egZN5/90CzSDhsgsIUhgRpoFs6ecw55JHEFeiHFo=;
 b=SsOYtkyaY+H1KOAHrvphT2MQ4TiHbRV7dNvMXJO5/dAJYAI6O+eR3pMZZKXjKXop5B
 KKDzrg2oGuOVqwDg4RL59zvHiO5HQCZgAObNgWDWfQUGwN+geOAv/TnLjwaF2MV440+C
 wAINIsiYD/Gq5N8AyjVleY06qYPH6VW0jwrv+4q7l+JYv7gpC2FQmZpvNLhi4nykg7xP
 mzJdX++/S/8salhP5fVKJD5OvKBpMBBeaHkFM7IOLLqvr9saNyzpbtQKjCmvUB7gl7q/
 +JL9+G1VX01eoUr7c5cna4aNLLFEXO4w5NcT7+Kl5XuYp5l5cxg+AUxhcxujn1O655um
 UaYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWko426jw/24egeLWHvNf/7/ui/6K79uX3G4hEPqpjq9GQHQ/+Oqp8RaxSCWILWvPHivWahSpOtRs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIL4rW6bv2oRCQqBlry9Zg4KgLE3u43nuIP9JRY/aSZTrWq4Qcv
 zysFiwv734vl6JvJCZ69bxgM/pmoAxHM2Xl3k7oWVlA3bh+P8EXQRFkltYcgTrW3tpW+76JN0Oo
 Km9XCHzhVMMf1/qaqE0U2UX7qOV3EqvE=
X-Gm-Gg: AYBFou2upFkCFwEAsX85YFv5oFsYN66NRLqSQ2GuivlsybJ8Q0Oeq709ItKh7CxsKER
 maMScf2WSw9p9yxn3VpaTpr0aNLQJMRcLUep8cpElpbqgoCmOyfC0KtCZVGvm63xHNK1TFfFPdp
 +uKyMpS+URtthCs0ApbTGT25fyx1RtNprAy6NnTHl65mgAydedgJGVhVJe3+IN3o5/UynfdvxfX
 eQF0ER8lD9m7EfeFccmX1zm6TyZ8HdTLSKBHHUPojq+RlLqUySZJaRgGHu/KI0U0Yp2bA7xUjOJ
 hZNuzVOkCPrx9wnn+fNcFGWqPLhSD8tbKyiFlltUA0xOVXn+nNQD97dVmN6XdlfB+chxUy1+MVL
 r+1cqeoF1USlxwzwJBnoR1Ru3XbAgyT7S/d+dnTGEH2GNqBuubooy+k/85S6mcvPxoYMMKA==
X-Received: by 2002:a05:7300:51f6:b0:365:cdcc:9f57 with SMTP id
 5a478bee46e88-369d90bafdbmr2435377eec.4.1792744011862; Fri, 23 Oct 2026
 01:26:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-8-clamor95@gmail.com>
 <Ot5qxntOTJ2QgFh6uZ0riA@nvidia.com>
In-Reply-To: <Ot5qxntOTJ2QgFh6uZ0riA@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 23 Oct 2026 11:26:40 +0300
X-Gm-Features: AclHuK_dH2zhheI1EgqNlArNiBm0hEzsJdmDh4JSQ9ndF-TZGjDXnQQYlJw0I1w
Message-ID: <CAPVz0n3Vrzb96iR5ZW8zvmruZ4aK0hKGKpJ2T9Ys+bSPCtLWHw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
3 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thursday, October 22, 2026 10:22=E2=80=AFPM Svyatoslav Ryhel wrote:
> > The display controller in Tegra20/30 SoCs features an 8-bit SPI interfa=
ce
> > that closely resembles the MIPI DBI Type B protocol and is referred to =
as
> > '8-bit CPU'. Each display controller provides two such interfaces, whic=
h
> > can be used to send MIPI DCS commands to initialize and control the pan=
el
> > while image data is transmitted via 16/18/24-line RGB.
> >
> > The '8-bit CPU', although being the DC interface, is modeled using a
> > bridge framework for flexibility and convenience. This implementation d=
oes
> > not change the existing codebase besides registering an interface and c=
an
> > be enabled/disabled without losing other Tegra DRM functionality.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/Kconfig  |   7 +
> >  drivers/gpu/drm/tegra/Makefile |   3 +
> >  drivers/gpu/drm/tegra/dbi.c    | 536 +++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/tegra/dc.c     |  29 ++
> >  drivers/gpu/drm/tegra/dc.h     |   1 +
> >  drivers/gpu/drm/tegra/trace.c  |   3 +
> >  6 files changed, 579 insertions(+)
> >  create mode 100644 drivers/gpu/drm/tegra/dbi.c
> >
> > diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kcon=
fig
> > index 8a3b16aac5d68..ce3a424398713 100644
> > --- a/drivers/gpu/drm/tegra/Kconfig
> > +++ b/drivers/gpu/drm/tegra/Kconfig
> > @@ -30,6 +30,13 @@ config DRM_TEGRA
> >
> >  if DRM_TEGRA
> >
> > +config DRM_TEGRA_DBI
> > +     tristate "Enable MIPI DBI type B communication protocol for Tegra=
 20/30"
> > +     help
> > +       Tegra20 and Tegra30 feature 8 bit CPU driver panel control
> > +       protocol (similar to MIPI DBI Type B). This option allows use
> > +       it to set up and control compatible panel.
> > +
> >  config DRM_TEGRA_DEBUG
> >       bool "NVIDIA Tegra DRM debug support"
> >       help
> > diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Mak=
efile
> > index e399b40d64a1d..d67e53248a082 100644
> > --- a/drivers/gpu/drm/tegra/Makefile
> > +++ b/drivers/gpu/drm/tegra/Makefile
> > @@ -33,3 +33,6 @@ tegra-drm-y +=3D trace.o
> >  tegra-drm-$(CONFIG_DRM_FBDEV_EMULATION) +=3D fbdev.o
> >
> >  obj-$(CONFIG_DRM_TEGRA) +=3D tegra-drm.o
> > +
> > +obj-$(CONFIG_DRM_TEGRA_DBI) +=3D tegra-dbi.o
> > +tegra-dbi-y :=3D dbi.o
> > diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> > new file mode 100644
> > index 0000000000000..7bd90d32053f2
> > --- /dev/null
> > +++ b/drivers/gpu/drm/tegra/dbi.c
> > @@ -0,0 +1,536 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/media-bus-format.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/property.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_mipi_dbi.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +#include "dc.h"
> > +
> > +#define TEGRA_DBI_COMMAND                    0
> > +#define TEGRA_DBI_DATA                               1
>
> I'd use an enum for COMMAND/DATA -- as is it's not quite obvious these
> are alternative values. It would also give a proper typing for the
> parameter to dbi_write.
>

Noted

> > +#define TEGRA_DBI_DATA_PINS_MAX                      8
> > +#define TEGRA_DBI_INTERFACE_MAX                      2
> > +
> > +struct tegra_dbi_output {
> > +     struct drm_panel *panel;
> > +     struct drm_bridge *bridge;
> > +};
> > +
> > +struct tegra_dbi_priv {
> > +     struct mipi_dbi dbi;            /* must be first */
> > +     struct device *dev;
> > +     struct tegra_dc *dc;
> > +
> > +     struct drm_bridge bridge;
> > +     struct tegra_dbi_output output;
> > +
> > +     const struct tegra_dbi_interface *index;
> > +
> > +     u32 bus_width;
> > +     u32 idx;
> > +     bool active;
> > +};
> > +
> > +struct reg_entry {
> > +     u32 offset;
> > +     u32 value;
> > +};
> > +
> > +/*
> > + * This is used to backup and restore COM pin state during
> > + * tegra_dbi_atomic_enable/disable.
> > + */
> > +static struct reg_entry com_pin_output[] =3D {
> > +     { DC_COM_PIN_OUTPUT_ENABLE(0),   0 },
> > +     { DC_COM_PIN_OUTPUT_ENABLE(1),   0 },
> > +     { DC_COM_PIN_OUTPUT_ENABLE(2),   0 },
> > +     { DC_COM_PIN_OUTPUT_ENABLE(3),   0 },
> > +     { DC_COM_PIN_OUTPUT_POLARITY(0), 0 },
> > +     { DC_COM_PIN_OUTPUT_POLARITY(1), 0 },
> > +     { DC_COM_PIN_OUTPUT_POLARITY(2), 0 },
> > +     { DC_COM_PIN_OUTPUT_POLARITY(3), 0 },
> > +     { DC_COM_PIN_OUTPUT_DATA(0),     0 },
> > +     { DC_COM_PIN_OUTPUT_DATA(1),     0 },
> > +     { DC_COM_PIN_OUTPUT_DATA(2),     0 },
> > +     { DC_COM_PIN_OUTPUT_DATA(3),     0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(0),   0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(1),   0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(2),   0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(3),   0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(4),   0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(5),   0 },
> > +     { DC_COM_PIN_OUTPUT_SELECT(6),   0 },
> > +};
> > +
> > +struct pin {
> > +     u32 reg;
> > +     u32 pos;
> > +};
> > +
> > +struct tegra_dbi_interface {
> > +     struct pin dc;
> > +     struct pin rw;
> > +     struct pin cs;
> > +     struct pin data[TEGRA_DBI_DATA_PINS_MAX];
> > +};
> > +
> > +static const struct tegra_dbi_interface tegra_dbi_idx[TEGRA_DBI_INTERF=
ACE_MAX] =3D {
> > +     /*
> > +      * Nvidia Primary 8-bit CPU interface configuration:
> > +      * DC =3D LCD_DC0/LDC; RW =3D LCD_PCLK/LSC0; CS =3D LCD_CS0_N/LCS=
N
> > +      *      DATA =3D LD0 - LD7
> > +      */
> > +     {
> > +             .dc =3D { DC_COM_PIN_OUTPUT_DATA(3), 6 },
> > +             .rw =3D { DC_COM_PIN_OUTPUT_DATA(1), 24 },
> > +             .cs =3D { DC_COM_PIN_OUTPUT_DATA(3), 4 },
> > +             .data =3D {
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 0 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 2 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 4 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 6 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 8 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 10 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 12 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(0), 14 },
>
> I'd like to see defines added for the bit offsets (in dc.h).
> Alternatively perhaps we could have an enum tegra_dc_pin with
> TEGRA_DC_PIN_... variants in the same order as the pins are in the
> various registers (I assume they are in the same order in all
> registers). Then we could refer to those enumeration values here
> and compute the register and bit from it dynamically.
>

That should be possible. I will include those in header rafactoring.
Thierry did not like my enums, so those will be definitions.

> > +             },
> > +     },
> > +     /*
> > +      * Nvidia Secondary 8-bit CPU interface configuration:
> > +      * DC =3D LCD_DC1/LVP0; RW =3D LCD_WR_N/LSC1; CS =3D LCD_CS1_N/LM=
0
> > +      *      DATA0 =3D LCD_D18/LHP1    DATA4 =3D LCD_PWR0/LPW0
> > +      *      DATA1 =3D LCD_M1/LM1      DATA5 =3D LCD_PWR2/LPW2
> > +      *      DATA2 =3D LCD_D22/LDI     DATA6 =3D LCD_D20/LVP1
> > +      *      DATA3 =3D LCD_D23/LPP     DATA7 =3D LCD_D21/LHP0
> > +      */
> > +     {
> > +             .dc =3D { DC_COM_PIN_OUTPUT_DATA(2), 8 },
> > +             .rw =3D { DC_COM_PIN_OUTPUT_DATA(1), 26 },
> > +             .cs =3D { DC_COM_PIN_OUTPUT_DATA(3), 16 },
> > +             .data =3D {
> > +                     { DC_COM_PIN_OUTPUT_DATA(2), 2 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(2), 18 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(2), 20 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(2), 22 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(1), 16 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(1), 20 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(2), 10 },
> > +                     { DC_COM_PIN_OUTPUT_DATA(2), 0 },
> > +             },
> > +     },
> > +};
> > +
> > +static inline struct tegra_dbi_priv *mipi_dbi_to_tegra_dbi(struct mipi=
_dbi *dbi)
> > +{
> > +     return container_of(dbi, struct tegra_dbi_priv, dbi);
> > +}
> > +
> > +static inline struct tegra_dbi_priv *bridge_to_tegra_dbi(struct drm_br=
idge *bridge)
> > +{
> > +     return container_of(bridge, struct tegra_dbi_priv, bridge);
> > +}
> > +
> > +static void tegra_dbi_pin_set(struct tegra_dc *dc, const struct pin *p=
in, int value)
>
> I would change this to 'bool value', and and have '!!(BIT(i) & value)'
> for more descriptive types.
>

I had similar idea but ended up making it look like gpio helper. Maybe
FIELD_GET macro would work here instead of !!

> > +{
> > +     u32 val;
> > +
> > +     val =3D tegra_dc_readl(dc, pin->reg);
>
> You don't need to read the register value -- the purpose of the unmask
> bit is that only the data bits that are unmasked in the write are
> modified.
>

I was cautious not to accidentally set wrong pins. I will test if
plain writing works and remove read if it is not needed.

> > +     val |=3D BIT(pin->pos + 1); /* unmask is 1 bit above position */
> > +     if (value)
> > +             val |=3D BIT(pin->pos);
> > +     else
> > +             val &=3D ~BIT(pin->pos);
> > +     tegra_dc_writel(dc, val, pin->reg);
> > +}
> > +
> > +static void tegra_dbi_write(struct tegra_dbi_priv *priv, u8 type, u8 v=
alue)
> > +{
> > +     struct tegra_dc *dc =3D priv->dc;
> > +     const struct tegra_dbi_interface *idx =3D priv->index;
> > +
> > +     tegra_dbi_pin_set(dc, &idx->dc, type);
> > +
> > +     tegra_dbi_pin_set(dc, &idx->cs, 0);
> > +     tegra_dbi_pin_set(dc, &idx->rw, 0);
> > +
> > +     for (int i =3D 0; i < TEGRA_DBI_DATA_PINS_MAX; i++)
> > +             tegra_dbi_pin_set(dc, &idx->data[i], BIT(i) & value);
> > +
> > +     tegra_dbi_pin_set(dc, &idx->cs, 1);
> > +     tegra_dbi_pin_set(dc, &idx->rw, 1);
> > +
> > +     udelay(10);
> > +}
> > +
> > +static int tegra_dbi_dbi_command(struct mipi_dbi *dbi, u8 *cmd, u8 *pa=
ram, size_t num)
> > +{
> > +     struct tegra_dbi_priv *priv =3D mipi_dbi_to_tegra_dbi(dbi);
> > +     u8 command =3D *cmd;
> > +
> > +     /* Blocks all commands when interface is not active */
> > +     if (!priv->active)
> > +             return -ENODEV;
> > +
> > +     tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
> > +
> > +     for (int i =3D 0; i < num; i++)
> > +             tegra_dbi_write(priv, TEGRA_DBI_DATA, param[i]);
> > +
> > +     return 0;
> > +}
> > +
> > +static void tegra_dbi_init_primary_interface(struct tegra_dbi_priv *pr=
iv)
> > +{
> > +     struct tegra_dc *dc =3D priv->dc;
> > +     u32 value;
> > +
> > +     /* Set LCSN and LDC to output enable */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_ENABLE(3));
> > +     value &=3D ~(BIT(4) | BIT(6));
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_ENABLE(3));
>
> We should use defines, or something like the enum tegra_dc_pin thing to
> calculate the parameter to DC_COM_PIN_OUTPUT/SELECT and the bit offset.
>

Macro to make mask of the pin. BIT already does this, but I can wrap
it into smth. Since I will add pin definitions this will look like
BIT(PEN_LCSN) end so on. If you have preferred naming or ideas, let me
know.

> > +
> > +     /* Set LSC0/LCSN/LDC output polarity HIGH */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_POLARITY(1));
> > +     value &=3D ~BIT(24);
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
> > +
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_POLARITY(3));
> > +     value &=3D ~(BIT(4) | BIT(6));
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
> > +
> > +     /* Select output for pins LD0 - LD7 */
> > +     tegra_dc_writel(dc, 0x11111111, DC_COM_PIN_OUTPUT_SELECT(0));
> > +
> > +     /* Select output for pins LSC0/LCSN/LDC */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(3));
> > +     value &=3D ~0x70000;
>
> Please write this as (0x7 << 16) for clarity, similarly below.
>

I will convert this into macro.

> > +     value |=3D BIT(16);
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(3));
> > +
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> > +     value &=3D ~0x7700;
> > +     value |=3D BIT(12) | BIT(8);
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
> > +}
> > +
> > +static void tegra_dbi_init_secondary_interface(struct tegra_dbi_priv *=
priv)
> > +{
> > +     struct tegra_dc *dc =3D priv->dc;
> > +     u32 value;
> > +
> > +     /* Set LPP/LDI to output enable */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_ENABLE(2));
> > +     value &=3D ~(BIT(20) | BIT(22));
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_ENABLE(2));
> > +
> > +     /* Select output for pins LSC1/LPW2/LPW0 */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(3));
> > +     value &=3D ~0x700707;
> > +     value |=3D BIT(20) | BIT(8) | BIT(0);
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(3));
> > +
> > +     /* Select output for pins LVP1/LVP0/LHP1/LHP0 */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(4));
> > +     value &=3D ~0x770077;
> > +     value |=3D BIT(20) | BIT(16) | BIT(4) | BIT(0);
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(4));
> > +
> > +     /* Select output for pins LPP/LDI/LM1/LM0 */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(5));
> > +     value &=3D ~0x7777;
> > +     value |=3D BIT(12) | BIT(8) | BIT(4) | BIT(0);
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(5));
> > +}
> > +
> > +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> > +                                 struct drm_atomic_commit *state)
> > +{
> > +     struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> > +     struct tegra_dc *dc =3D priv->dc;
> > +     u32 value;
> > +
> > +     value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> > +     value &=3D ~DISP_CTRL_MODE_MASK;
> > +     tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> > +
> > +     /* Disable all options except cursor if enabled */
> > +     value =3D tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
> > +     value &=3D CURSOR_ENABLE;
> > +     tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
>
> Just 'tegra_dc_writel(dc, CURSOR_ENABLE, DC_DISP_DISP_WIN_OPTIONS);'
>

If CURSOR_ENABLE is not set, it will be enabled unconditionally. Not good.

> > +
> > +     tegra_dc_commit(dc);
> > +
> > +     tegra_dc_writel(dc, V_PULSE1_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0=
);
> > +     tegra_dc_writel(dc, PULSE_POLARITY_LOW, DC_DISP_V_PULSE1_CONTROL)=
;
> > +
> > +     tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE1_POSITION_A);
> > +     tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_B);
> > +     tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_C);
> > +
> > +     value =3D 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
> > +             DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
> > +             INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
> > +     tegra_dc_writel(dc, value, DC_DISP_INIT_SEQ_CONTROL);
> > +
> > +     /* Generic sequence for DBI command panels */
> > +     tegra_dc_writel(dc, 0x2c, DC_DISP_SPI_INIT_SEQ_DATA_A);
>
> MIPI_DCS_WRITE_MEMORY_START
>

Noted

> > +     tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_B);
> > +     tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_C);
> > +     tegra_dc_writel(dc, 0x5000, DC_DISP_SPI_INIT_SEQ_DATA_D);
>
> (1 << 12) | (1 << 14), and comment above
>
>   /* Init cycle 1: WRITE_MEMORY_START, set LCD_PCLK and COMMAND */
>
> or something in that vein.
>

Noted

> > +
> > +     value =3D SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> > +             SC0_V_QUALIFIER(SC_V_QUALIFIER_VACTIVE) |
> > +             SC0_H_QUALIFIER(SC_H_QUALIFIER_HACTIVE);
> > +     tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
> > +
> > +     value =3D tegra_dc_readl(dc, DC_DISP_DISP_COLOR_CONTROL);
> > +     value &=3D ~BASE_COLOR_SIZE_MASK;
> > +
> > +     switch (priv->bus_width) {
> > +     case 16:
> > +             value |=3D BASE_COLOR_SIZE_565;
> > +             break;
> > +     case 18:
> > +             value |=3D BASE_COLOR_SIZE_666;
> > +             break;
> > +     case 24:
> > +     default:
> > +             value |=3D BASE_COLOR_SIZE_888;
> > +             break;
> > +     }
> > +
> > +     tegra_dc_writel(dc, value, DC_DISP_DISP_COLOR_CONTROL);
> > +
> > +     /*
> > +      * Backup registers before unshadowing since actual register valu=
es
> > +      * may differ and their state backed up now is the correct one.
> > +      */
> > +     for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> > +             com_pin_output[i].value =3D tegra_dc_readl(dc, com_pin_ou=
tput[i].offset);
> > +
> > +     /* Unshadow to set up command and data pins */
> > +     tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
> > +
> > +     if (priv->idx)
> > +             tegra_dbi_init_secondary_interface(priv);
> > +     else
> > +             tegra_dbi_init_primary_interface(priv);
> > +
> > +     priv->active =3D true;
> > +
> > +     if (priv->output.panel)
> > +             drm_panel_enable(priv->output.panel);
> > +
> > +     tegra_dbi_pin_set(dc, &priv->index->cs, 0);
> > +
> > +     priv->active =3D false;
> > +
> > +     for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> > +             tegra_dc_writel(dc, com_pin_output[i].value, com_pin_outp=
ut[i].offset);
> > +
> > +     /* Set LDC pin to V Pulse 1 */
> > +     value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> > +     value |=3D LDC_OUTPUT_SELECT_V_PULSE1;
> > +     tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
> > +
> > +     value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> > +     value &=3D ~DISP_CTRL_MODE_MASK;
> > +     value |=3D DISP_CTRL_MODE_C_DISPLAY;
> > +     tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> > +
> > +     tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> > +}
> > +
> > +static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
> > +                                  struct drm_atomic_commit *state)
> > +{
> > +     struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> > +     struct tegra_dc *dc =3D priv->dc;
> > +
> > +     for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> > +             com_pin_output[i].value =3D tegra_dc_readl(dc, com_pin_ou=
tput[i].offset);
> > +
> > +     tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
> > +
> > +     if (priv->idx)
> > +             tegra_dbi_init_secondary_interface(priv);
> > +     else
> > +             tegra_dbi_init_primary_interface(priv);
> > +
> > +     priv->active =3D true;
> > +
> > +     if (priv->output.panel)
> > +             drm_panel_disable(priv->output.panel);
> > +
> > +     priv->active =3D false;
> > +
> > +     for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> > +             tegra_dc_writel(dc, com_pin_output[i].value, com_pin_outp=
ut[i].offset);
> > +
> > +     tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> > +}
> > +
> > +static int tegra_dbi_atomic_check(struct drm_bridge *bridge,
> > +                               struct drm_bridge_state *bridge_state,
> > +                               struct drm_crtc_state *crtc_state,
> > +                               struct drm_connector_state *conn_state)
> > +{
> > +     struct drm_display_mode *adjusted_mode =3D &crtc_state->adjusted_=
mode;
> > +
> > +     /* Set safe default bus flags if panel does not specify them */
> > +     if (!bridge_state->input_bus_cfg.flags)
> > +             bridge_state->input_bus_cfg.flags =3D bridge->timings->in=
put_bus_flags;
> > +
> > +     /* Default to positive sync */
> > +     if (!(adjusted_mode->flags &
> > +           (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC)))
> > +             adjusted_mode->flags |=3D DRM_MODE_FLAG_PHSYNC;
> > +
> > +     if (!(adjusted_mode->flags &
> > +           (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
> > +             adjusted_mode->flags |=3D DRM_MODE_FLAG_PVSYNC;
> > +
> > +     return 0;
> > +}
> > +
> > +static int tegra_dbi_attach(struct drm_bridge *bridge,
> > +                         struct drm_encoder *encoder,
> > +                         enum drm_bridge_attach_flags flags)
> > +{
> > +     struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> > +     struct device *dev =3D priv->dev;
> > +
> > +     priv->dc =3D dev_get_drvdata(dev->parent);
> > +     if (!priv->dc)
> > +             return -ENODEV;
> > +
> > +     return drm_bridge_attach(bridge->encoder, priv->output.bridge, br=
idge,
> > +                              flags);
> > +}
> > +
> > +static enum drm_mode_status tegra_dbi_mode_valid(struct drm_bridge *br=
idge,
> > +                                              const struct drm_display=
_info *info,
> > +                                              const struct drm_display=
_mode *mode)
> > +{
> > +     if (mode->hdisplay > 800)
> > +             return MODE_H_ILLEGAL;
> > +
> > +     if (mode->vdisplay > 800)
> > +             return MODE_V_ILLEGAL;
> > +
> > +     return MODE_OK;
> > +}
> > +
> > +static const struct drm_bridge_funcs tegra_dbi_funcs =3D {
> > +     .attach =3D tegra_dbi_attach,
> > +     .mode_valid =3D tegra_dbi_mode_valid,
> > +
> > +     .atomic_enable =3D tegra_dbi_atomic_enable,
> > +     .atomic_disable =3D tegra_dbi_atomic_disable,
> > +     .atomic_check =3D tegra_dbi_atomic_check,
> > +
> > +     .atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> > +     .atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_st=
ate,
> > +     .atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> > +};
> > +
> > +static const struct drm_bridge_timings default_tegra_dbi_timings =3D {
> > +     .input_bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> > +                        DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
> > +                        DRM_BUS_FLAG_DE_HIGH,
> > +};
> > +
> > +static int tegra_dbi_probe(struct platform_device *pdev)
> > +{
> > +     struct tegra_dbi_priv *priv;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *np =3D dev->of_node;
> > +     struct drm_bridge *bridge;
> > +     struct drm_panel *panel;
> > +     struct device_node *ep;
> > +     int ret;
> > +
> > +     priv =3D devm_drm_bridge_alloc(dev, struct tegra_dbi_priv, bridge=
,
> > +                                  &tegra_dbi_funcs);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> > +
> > +     priv->dev =3D dev;
> > +
> > +     /* Default to primaty */
>
> primary
>
> > +     device_property_read_u32(dev, "nvidia,index", &priv->idx);
>
> Could we use the standard 'reg' property instead of this?
>

OMG, YES!

> > +     if (priv->idx)
> > +             priv->index =3D &tegra_dbi_idx[1];
> > +     else
> > +             priv->index =3D &tegra_dbi_idx[0];
> > +
> > +     /* Initialize MIPI DBI interface */
> > +     mutex_init(&priv->dbi.cmdlock);
> > +     priv->dbi.command =3D tegra_dbi_dbi_command;
> > +
> > +     ret =3D devm_of_platform_populate(dev);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to probe children\=
n");
> > +
> > +     ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &panel, &bridge);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (panel) {
> > +             bridge =3D devm_drm_panel_bridge_add_typed(dev, panel,
> > +                                                      DRM_MODE_CONNECT=
OR_DPI);
> > +             if (IS_ERR(bridge))
> > +                     return PTR_ERR(bridge);
> > +     }
> > +
> > +     priv->output.bridge =3D bridge;
> > +     priv->output.panel =3D panel;
> > +
> > +     /* get input ep (port0/endpoint0) */
> > +     ret =3D -EINVAL;
> > +     ep =3D of_graph_get_endpoint_by_regs(np, 0, 0);
> > +     if (ep) {
> > +             ret =3D of_property_read_u32(ep, "bus-width", &priv->bus_=
width);
> > +             of_node_put(ep);
> > +     }
> > +
> > +     if (ret)
> > +             priv->bus_width =3D 24;
> > +
> > +     priv->bridge.of_node =3D np;
> > +     priv->bridge.timings =3D &default_tegra_dbi_timings;
> > +
> > +     ret =3D devm_drm_bridge_add(dev, &priv->bridge);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to add bridge\n");
> > +
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver tegra_dbi_driver =3D {
> > +     .driver.name =3D "tegra-dbi",
> > +     .probe =3D tegra_dbi_probe,
> > +};
> > +module_platform_driver(tegra_dbi_driver);
> > +
> > +MODULE_ALIAS("platform:tegra-dbi");
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver");
> > +MODULE_LICENSE("GPL");
>
> No separate platform driver or device. If a separate struct device is
> needed for some technical purpose, we need to create a minimal separate
> virtual device, but unless there is a strong reason to have that we
> should be fine with just the dc device.
>
> Thank you
> Mikko
>

ATM, I use bridge framework to describe interface and I am attaching
it to RGB since it basically uses RGB to transfer video data. It works
pretty nice so far.

You propose to replicate how RGB works just for DBI?

> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index 5c67928bcabfa..8f12d30cd2d8b 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> > @@ -223,6 +223,7 @@ void tegra_dc_commit(struct tegra_dc *dc)
> >       tegra_dc_writel(dc, GENERAL_ACT_REQ << 8, DC_CMD_STATE_CONTROL);
> >       tegra_dc_writel(dc, GENERAL_ACT_REQ, DC_CMD_STATE_CONTROL);
> >  }
> > +EXPORT_SYMBOL_GPL(tegra_dc_commit);
> >
> >  static inline u32 compute_dda_inc(unsigned int in, unsigned int out, b=
ool v,
> >                                 unsigned int bpp)
> > @@ -3279,9 +3280,15 @@ static int tegra_dc_init_opp_table(struct tegra_=
dc *dc)
> >       return 0;
> >  }
> >
> > +static void tegra_dc_release_dbi_pdev(void *pdev)
> > +{
> > +     platform_device_unregister(pdev);
> > +}
> > +
> >  static int tegra_dc_probe(struct platform_device *pdev)
> >  {
> >       u64 dma_mask =3D dma_get_mask(pdev->dev.parent);
> > +     struct device_node *dbi_np;
> >       struct tegra_dc *dc;
> >       int err;
> >
> > @@ -3382,6 +3389,28 @@ static int tegra_dc_probe(struct platform_device=
 *pdev)
> >               }
> >       }
> >
> > +     dbi_np =3D of_get_available_child_by_name(pdev->dev.of_node, "dbi=
");
> > +     if (dbi_np) {
> > +             struct platform_device_info dbi_info =3D {
> > +                     .parent =3D &pdev->dev,
> > +                     .name =3D "tegra-dbi",
> > +                     .id =3D PLATFORM_DEVID_AUTO,
> > +                     .fwnode =3D of_fwnode_handle(dbi_np),
> > +                     .of_node_reused =3D true,
> > +             };
> > +
> > +             dc->dbi =3D platform_device_register_full(&dbi_info);
> > +             of_node_put(dbi_np);
> > +             if (IS_ERR(dc->dbi))
> > +                     return dev_err_probe(&pdev->dev, PTR_ERR(dc->dbi)=
,
> > +                                          "Failed to create DBI device=
\n");
> > +
> > +             err =3D devm_add_action_or_reset(&pdev->dev, tegra_dc_rel=
ease_dbi_pdev,
> > +                                            dc->dbi);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       err =3D tegra_dc_rgb_probe(dc);
> >       if (err < 0 && err !=3D -ENODEV)
> >               return dev_err_probe(&pdev->dev, err,
> > diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> > index 7005df32f485f..27dbee57f8f72 100644
> > --- a/drivers/gpu/drm/tegra/dc.h
> > +++ b/drivers/gpu/drm/tegra/dc.h
> > @@ -95,6 +95,7 @@ struct tegra_dc {
> >
> >       struct tegra_output *rgb;
> >       struct tegra_pmc *pmc;
> > +     struct platform_device *dbi;
> >
> >       struct tegra_dc_stats stats;
> >       struct list_head list;
> > diff --git a/drivers/gpu/drm/tegra/trace.c b/drivers/gpu/drm/tegra/trac=
e.c
> > index 006f65c72a344..3aeb3825e2100 100644
> > --- a/drivers/gpu/drm/tegra/trace.c
> > +++ b/drivers/gpu/drm/tegra/trace.c
> > @@ -1,2 +1,5 @@
> >  #define CREATE_TRACE_POINTS
> >  #include "trace.h"
> > +
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(dc_readl);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(dc_writel);
> > --
> > 2.53.0
> >
> >
>
>
>
>
