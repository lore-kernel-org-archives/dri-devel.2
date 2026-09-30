Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6203CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBC010F29C;
	Wed, 30 Sep 2026 09:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0XcirBS";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AD410E238
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:08:53 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-34abf779ac9so1452703eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790759333; cv=none;
 d=google.com; s=arc-20260327;
 b=UOFvvEY0cI9eJNXbnU7w89PNCST6VCTf8rAFxw/uXtavIGLKtH1S5iZJK2skqY8rpp
 7hFgACFTuHFMC+1XLYxvJ+G1UrkrC712HwkaUYuhUAjTD/q4evHKCL0FiXw5J9ncEB8i
 laX4JwdM33fmQibGTvIfg9usq98bNwvd3SAs8/SuzCk9HZID8RuWf6jqzmht8ngj0xkl
 kuQ1WrREhV6Wv9nimwFDjso5rsuo/hOT2AcrrsDL65OOBkDnpsMs+PoG4VYORBFBV7KX
 AyIBVIkWc4v6oLrmj5dy95Y3NZmGkfVzRPtSjJfh07czx+gKVdY1Gp+YK5stqHptPp/M
 34Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V7p6Z4nnBygY3IGhowKUKWBqT1Jl8ZZYivkVdoMSSWE=;
 fh=6YC0BeJ6QWa1FJgptP2ISOBsH1svIx1LiXbse3a5uvI=;
 b=PYFeiOVlw2QRT0N86ILkklC8HsS5maQq65Kg+/8JceykkRHRKuYOsnY0ZEBVduq97+
 ZX28lDrQNyRmOyxvzYcyMqGPrBHhDmqg3l0P4LtABWshAV1q5grNMNoPKUI70D4k1WlT
 W24m/gK9AhiP8Bin24AVg6sFqPZy3Yy1ExNkJ2bm/BYVMqlbqwnwXseWUTnKDHQehW5i
 60O2yK1wqHXH9/gddzxCQWk0IJtL2BZXMjtisg+Judg6fipfuxM44iIYB78qn0SW0bpl
 jJtFlrJzdzG/XQj2LYNHrH5TfDBWm5DKfUjtzix/MqXAPrQaVrrgH7Cndsy0DL0ds0AO
 vxkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790759333; x=1791364133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V7p6Z4nnBygY3IGhowKUKWBqT1Jl8ZZYivkVdoMSSWE=;
 b=d0XcirBS2EveLwmEbGw2QVbSYeJ/L2MsiCaSu/t4DSi9Qffl06sK2svSaIo3YtWD0V
 zxZtOH5wl6FLDBJYsDXA007QX5NthsYmdX04vABLkc5ZZyWQCqOpqlWEulDux0HSoyyE
 PsIO9Rj3qZjGaa5rWi+8JwMLqMwEPlgxbhzmroNWkaO80S5Cmryxxk1Lu66rI9MXXcwE
 1cvN8CFbrYBNU8/C1J8eO+j+hNgteZzFXAgNdynEgm5/fPWIWs02tpxI0dj5LomlJYBc
 Y4xorVM8CcpMr4UJPE+4ak6O3usBGfI4sxX0kU/gJd1J05TlSYjWTRKblmz6suUDhT5g
 lc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759333; x=1791364133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V7p6Z4nnBygY3IGhowKUKWBqT1Jl8ZZYivkVdoMSSWE=;
 b=shyUJfea0TMaw7KYv36oLUAPcXXORGql20dWOmetrgD42ArWAPPxbN2z+qteXPr7e4
 QT+felNl/scWlXFB9By0Ljy/P+rPhxUoc2IZKuDHbB2EW4g9vCz6YUMngiwA+mg/G+Fi
 I7l8oRUXxRr2rgDmzrhM0dL2OIdz0rNPOIEtncgZKWLncdgSrLfj7FJro86Njm4YK/am
 I1lQiwp75cXYUXzQyhMxOsRTdDXWBCoapXwKUG5WFokUO9NlUqsZ3jtukbYECPDpGNST
 3oXYuTZ/4c1WLj2mRFqykJ7AyUrwB5UPuSofpPHE+er1pEYc+rD4yuqjPkuVs9D2E5Gk
 a9qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0D8nI2U+OreclBKQIrmuTMqLchbU61Y5bYoUMP88DTMmZZsDrUUdIsjE86x/u+NfFZ26JPSjsTVg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIRHL5mmzvl5ZISjmrKi+pgTF1JQwqbHSWBlxd6UUf3yUX44jcw
 70RAxfyi5HWwZKuYFOeRufefcTFjCnCowiFDRlZixDfS20Hs1TGEFa4NSFVn33GqFCz0eSztn0b
 CLA5GQr8b1eszQw+y2WrC8qRMuWXKzX8=
X-Gm-Gg: AYBFou2hLbslxVTlYM0nz8D3xFnkeQXczc9kRN1IrLzNWzOsw0QtKarXn36hCTCK1Si
 MYIqWyaCfxmx6Q5pMlaJP7LAWXeZ96kHZUAN379t5wL/N1IeeU4oOWqaiMrvuCkLWoGV3lXGl5m
 TNAWoFcm7VvfutEzcSfWoazM6XZHRJbQlnYocVtKw9pmu0+lMjqpjDinuYLcPaYuJ6ZpVyawoud
 FtxRk4dfbImamhEURZQCwFVbrLXEyStHjUaBf1Y4INjENc+n9pnMHFw1DclZtlBekcIfip1RpJT
 FjWEum3afv8ni1bupATZAZkoW2nY7KoUef1jYusOSwXYip28hyIwC8EJQ+a93r1p6WM+Gx5RKa7
 28QsPb9RwtbNK
X-Received: by 2002:a05:7301:9a93:b0:341:fd68:89ce with SMTP id
 5a478bee46e88-34cdc6bd821mr1056387eec.23.1790759332923; Wed, 30 Sep 2026
 02:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
 <arzNgbx465QIKYdX@orome>
In-Reply-To: <arzNgbx465QIKYdX@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 12:08:41 +0300
X-Gm-Features: AclHuK_GrgB1ybpXzB5TqGoO9XwCnkq9EQsObVGEae8urTG4uQ6PfBurcWJJG5Q
Message-ID: <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:02 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrote:
> > Add a driver for panels used in LG Optimus 2X P990. Both panels are 4"
> > WVGA MIPI DBI Type B linked to DRM encoder via RGB to DBI bridge.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/Kconfig                 |  14 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 396 ++++++++++++++++++
> >  3 files changed, 411 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index 747f47347521a..47962197a9c76 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -273,6 +273,20 @@ config DRM_PANEL_HIMAX_HX8394
> >
> >         If M is selected the module will be called panel-himax-hx8394.
> >
> > +config DRM_PANEL_HITACHI_TX10D07VM0BAA
> > +     tristate "Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI panels"
> > +     depends on OF
> > +     depends on BACKLIGHT_CLASS_DEVICE
> > +     select DRM_MIPI_DBI
> > +     select VIDEOMODE_HELPERS
> > +     help
> > +       Say Y here if you want to enable support for the HITACHI
> > +       TX10D07VM0BAA and LG LH400WV3 MIPI DBI panels found in the
> > +       LG Optimus 2X P990 smartphone.
> > +
> > +       To compile this driver as a module, choose M here: the module w=
ill
> > +       be called panel-hitachi-tx10d07vm0baa.
> > +
> >  config DRM_PANEL_HYDIS_HV101HD1
> >       tristate "Hydis HV101HD1 panel"
> >       depends on OF
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Mak=
efile
> > index f2c9c80a218f0..414267a49d922 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) +=3D panel-him=
ax-hx83112a.o
> >  obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112B) +=3D panel-himax-hx83112b.o
> >  obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) +=3D panel-himax-hx83121a.o
> >  obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) +=3D panel-himax-hx8394.o
> > +obj-$(CONFIG_DRM_PANEL_HITACHI_TX10D07VM0BAA) +=3D panel-hitachi-tx10d=
07vm0baa.o
> >  obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) +=3D panel-hydis-hv101hd1.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) +=3D panel-ilitek-ili7807s.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7836A) +=3D panel-ilitek-ili7836a.o
> > diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driv=
ers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > new file mode 100644
> > index 0000000000000..d2c3b63649288
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > @@ -0,0 +1,396 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/media-bus-format.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +#include <drm/drm_mipi_dbi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_panel.h>
> > +#include <drm/drm_probe_helper.h>
> > +
> > +enum panel_dbi_id {
> > +     PANEL_DBI_NONE,
> > +     PANEL_DBI_TX10D07VM0BAA,
> > +     PANEL_DBI_LH400WV3,
> > +};
> > +
> > +static const struct regulator_bulk_data panel_dbi_supplies[] =3D {
> > +     { .supply =3D "avci" }, { .supply =3D "iovcc" },
> > +};
> > +
> > +struct panel_dbi {
> > +     struct drm_panel panel;
> > +     struct mipi_dbi *dbi;
> > +
> > +     struct regulator_bulk_data *supplies;
> > +     struct gpio_desc *reset_gpio;
> > +};
> > +
> > +static inline struct panel_dbi *to_panel_dbi(struct drm_panel *panel)
> > +{
> > +     return container_of(panel, struct panel_dbi, panel);
> > +}
> > +
> > +#define panel_dbi_command(priv, cmd, seq...) \
> > +({ \
> > +     const u8 d[] =3D { seq }; \
> > +     struct drm_panel *panel =3D &(priv)->panel; \
> > +     struct device *dev =3D panel->dev; \
> > +     int ret; \
> > +     ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE=
(d)); \
> > +     if (ret) \
> > +             dev_err_ratelimited(dev, "error %d when sending command %=
#02x\n", ret, cmd); \
> > +     ret; \
> > +})
> > +
>
> [...]
> > +static int panel_dbi_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     const struct drm_panel_funcs *panel_dbi_funcs;
> > +     struct panel_dbi *priv;
> > +     enum panel_dbi_id id;
> > +     int ret;
> > +
> > +     id =3D (uintptr_t)of_device_get_match_data(dev);
> > +
> > +     switch (id) {
> > +     case PANEL_DBI_TX10D07VM0BAA:
> > +             panel_dbi_funcs =3D &hitachi_tx10d07vm0baa_panel_funcs;
> > +             break;
> > +
> > +     case PANEL_DBI_LH400WV3:
> > +             panel_dbi_funcs =3D &lg_lh400wv3_panel_funcs;
> > +             break;
> > +
> > +     default:
> > +             return dev_err_probe(dev, -ENODEV, "Unknown device %d\n",=
 id);
> > +     }
>
> This is a bit pointless. The only reason you need that default here is
> because you have an enum that is "none" but that PANEL_DBI_NONE is never
> even used.
>
> > +
> > +     priv =3D devm_drm_panel_alloc(dev, struct panel_dbi, panel,
> > +                                 panel_dbi_funcs, DRM_MODE_CONNECTOR_D=
PI);
> > +     if (IS_ERR(priv))
> > +             return PTR_ERR(priv);
> > +
> > +     ret =3D devm_regulator_bulk_get_const(dev, ARRAY_SIZE(panel_dbi_s=
upplies),
> > +                                         panel_dbi_supplies, &priv->su=
pplies);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to get supplies\n"=
);
> > +
> > +     priv->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
OUT_HIGH);
> > +     if (IS_ERR(priv->reset_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> > +                                  "Failed to get reset gpio\n");
> > +
> > +     ret =3D drm_panel_of_backlight(&priv->panel);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to get backlight\n=
");
> > +
> > +     ret =3D devm_drm_panel_add(dev, &priv->panel);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to add panel\n");
> > +
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id panel_dbi_of_match[] =3D {
> > +     { .compatible =3D "hit,tx10d07vm0baa", .data =3D (void *)PANEL_DB=
I_TX10D07VM0BAA },
> > +     { .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *)PANEL_DBI=
_LH400WV3 },
>
> Why the detour through that PANEL_DB_* enum? You could just pass the
> panel funcs pointers directly via .data here.
>

Passing API/OPS via .data is discouraged.

> Also, looking at the enable/disable sequences these are in fact two
> different drivers, with the only commonality being that they happen to
> be used in the same device. Rolling them both into one driver seems a
> bit odd.

I did this to simplify maintainance. Both panels are used in the LG
Optimus 2X. My assumption is that LG switched one to another at some
point, hence they share same timings, controls and supplies, but
differ in en/disable sequence. Additionally, these are the the only
DBI Type B-only panels in the kernel, from what I can see.

> If you really want to avoid duplication, maybe they should go
> into some kind of "simple" or "generic" DBI driver.

DBI Type B is not well supported in the kernel.

>
> Thierry
