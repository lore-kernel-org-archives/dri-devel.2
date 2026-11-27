Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB1606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dO348xGO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8B9112AC5;
	Fri, 27 Nov 2026 13:08:47 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5524112AC5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:08:40 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-386b8f2f671so4755907eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795784920; cv=none;
 d=google.com; s=arc-20260327;
 b=S2sljKTZzW/pTZWv1Bm0zh0dj56wMXCx3muKIJ0bDOvg5S1iSGVhO046Lk1Ncp5Lc8
 Vk945Cowli8s6dPVZfpgMvsBecQ8Jflxs9snn0yl5f7VxIsCtQNAoqzT4DTqq9lOonKJ
 BHX9Qusta3OqhM4IUYB9hx/WDB396nIrw/7L0vd9n4Lt49SNTesjyN7fWZ9KxDd1pkSi
 L0Y3uMW6QW/QzZwjJmOEeoJelgLjih4DHBwYJNB9hXeoyN7aumKHI0cbfNsYOTfNh5rf
 U+vb4JLZm9v5DMWxqqsIk5mKWhsc3CFHYc9qfqik6nU6WQcOkvHsIcaFgZ/+C1Qhz+Zp
 kriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C0gaW0T//VOtwOuwTFVY9WwABc2rEZBaWTGdLWhFohw=;
 fh=K0OCIwELYOQM/oQ937S+oIDInv2ERHvWt5dU9e6kxaw=;
 b=lpSrPB40lqHpReBFohwMFImHf8CxD96rHKU72ooAviGAKSauaSV/9nvyHdwTE5ziup
 HwNM3Ir/aQTkgshjWgD1byBydEjGDCv/DNjyrMIRrKcwLJEiF/7aASqCty5WUNNoYgej
 a8HWGVE7TOuVyRgPEedhRV7Y8ARSnMbzVn/Hdzibtg0I/7znoaHDwF0goCudLiKEYcLr
 sX1XmM2k5OuNO9HQpt/m+xyip2BQH0HA6fxhx4QCTZz5oMyUewLUZkbU7hAUe+VZJLiI
 ckMEYJeZZL91IRni8gPKuGGVUMMRcWUNN/kbEWfRa8+SthccbexMCOu/PYGIVVDcOs0E
 TGCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795784920; x=1796389720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C0gaW0T//VOtwOuwTFVY9WwABc2rEZBaWTGdLWhFohw=;
 b=dO348xGOlPjcTyVoV5mF213VkUdKxuFV/veGw3whchW+P32VGeRJBCQAX16HCULfFf
 Us8E8fxApTQztO+wOOfem6ycrMrdtPq+FAVDFT/6K9S0AcMxZK/cLQrl/WPRBhcYbD7b
 fi4ks4yFhrZtzdIp2a0l0PGOAwzhdNkfwQymFcIBGSNdRwftSbrtReGK53jkKOTqDhQN
 +my7q4+kxMeSjwMmrwMI7HU2XL3oDW77fHUI0d6HQWGbT5iPoXbk5hUAbGmYzTkkpNqf
 Yd3RrHUVaO0Q/yJOkz7SU5e9vb0bLf7ZF+xjMCqwyU1inN3qS01REWurRYUGF/YvOQs7
 IdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784920; x=1796389720;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C0gaW0T//VOtwOuwTFVY9WwABc2rEZBaWTGdLWhFohw=;
 b=dv0mney1NSIlUXQDqHmZConG9AyDqENUPqYU1DmQRYmfaI3uutg3o/lBy8rfuyb3FC
 lFeEsFL9LL5ce4gtRgLPJAQDxowiE2K8z+V6bKQ3fIEGP7eTA8Oaoc5r1BXvGQAIBMfC
 7RUPSvdA2HG22RXs2iNcyPlpDcr2Jr95UO1xX9IZOMXq52vane+HKiQhZy+1MFS7ZFNX
 bWOVP+IYAfsDe2MeHdrQozawyoJHgohrE6UgIVaWPDRrRmX0QhZb1XWydcsJoiahUO0k
 SLvyH6P49Awew6O8jiy6TpJM9onBAUUElFZqF7l471EgDHeHnxvROlIeRBCqNPWz6pZo
 d2oA==
X-Forwarded-Encrypted: i=1;
 AL+hErE4Xvs0oCe+pGhOfz4lfc5HeZrde+y+lvMLvLegntI2EIItfz6N0kEezLhvrr3hHHxKEdzKHDDiRCY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+JEwwCNXlbUiuQq+A8j9pHOWXFqjSv0+VlTRKb+vnYhxx2C26f
 msbCC9+jZdMISz3SQojpi6kDKKko2o9G38XnwYYlhSTIrNgiA0LB/6EPFBNNWuo78cMFKb31rNF
 PUwElUpRFqlsMQ/+vLi17G+ukCOxlL6Q=
X-Gm-Gg: AZFdTZcsLGj5npK8it+2joOvrBZ9BsIQWeRHxvC8eq37YgK4XKm4PBFGU0w0dJKdDZb
 O0yr/zGTQnq6PV7ND35qrh1+3V7iBEx0W5RU9CikzwloX9dWXdR4jtHQCzgqepGYdZBXUJbe2Mv
 Kxy2PvmJ+G2qEhw6P9O9oNxVmAFkptVgwRcwX9p1zC4mBhTHI5yo4fsxBk7u8OMwRhaozlFSmYi
 cNmDPT1yXOTchffcn8AHK4mptQdciaycRuCP05q3LU/B6rrg4dZpTz7Pv1NnI8YUICGbLiGCR6k
 HI7lULoHI5zmMf20y0MrCN0wN3fx2CeVlIQZzY/pGsZoturMb4qqYSzUujnZmN599Mlqn+P18I7
 s1SxQZGmVuwyZoidphih/5+oS9XmwTxfB0zcsTM/+hOiBSw9LGBHvaFtMAq80J7rAtk1nXdF51p
 gmDZlGCa+BesgoH9qjnQEtt3ems39nDvg=
X-Received: by 2002:a05:7301:10c4:b0:386:d310:4c1c with SMTP id
 5a478bee46e88-386d3104c52mr9700616eec.21.1795784919819; Fri, 27 Nov 2026
 05:08:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <hlO8KiQKSi62yShZAIyhpw@nvidia.com>
 <CAPVz0n0Qyekm7qUyCVFMTDSuVSw=1my4x-rgiafp3+mQ_sgk3Q@mail.gmail.com>
 <uQ14beL2SOumMxaLqMFc4w@nvidia.com>
In-Reply-To: <uQ14beL2SOumMxaLqMFc4w@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 15:08:28 +0200
X-Gm-Features: Aa3M54qgDXor0Xf9K6XHdCJ3yIc8SRM3BWawDQskrGgi0w7vMixGfnu5GIJLqUQ
Message-ID: <CAPVz0n3hT2qGag=CzH6JimHpWVqTC-B1p=7n5U9SPP7UHyeGdA@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert
 to use MIPI DBI bus
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:2=
0 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, November 27, 2026 6:10=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
06:23 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > Switch from a generic platform driver to a dedicated MIPI DBI Type =
B
> > > > driver.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 25 +++++++++------=
----
> > > >  1 file changed, 12 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/=
drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > > index 83c2af1be9755..318ece68b7806 100644
> > > > --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > > +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <video/mipi_display.h>
> > > >
> > > >  #include <drm/drm_mipi_dbi.h>
> > > > +#include <drm/drm_mipi_dbi_bus.h>
> > > >  #include <drm/drm_modes.h>
> > > >  #include <drm/drm_of.h>
> > > >  #include <drm/drm_panel.h>
> > >
> > > You should now be able to get rid of includes of of_platform.h
> > > (replacing with of.h) and platform_device.h. Agent says drm_of.h and
> > > property.h are also unused.
> > >
> > > > @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_t=
x10d07vm0baa_supplies[] =3D {
> > > >
> > > >  struct hitachi_tx10d07vm0baa {
> > > >       struct drm_panel panel;
> > > > -     struct mipi_dbi *dbi;
> > > > +     struct mipi_dbi_device *dbidev;
> > > >
> > > >       struct regulator_bulk_data *supplies;
> > > >       struct gpio_desc *reset_gpio;
> > > > @@ -40,9 +41,10 @@ static inline struct hitachi_tx10d07vm0baa *to_h=
itachi_tx10d07vm0baa(struct drm_
> > > >  ({ \
> > > >       const u8 d[] =3D { seq }; \
> > > >       struct drm_panel *panel =3D &(priv)->panel; \
> > > > +     struct mipi_dbi_device *dbidev =3D (priv)->dbidev; \
> > > >       struct device *dev =3D panel->dev; \
> > > >       int ret; \
> > > > -     ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_=
SIZE(d)); \
> > > > +     ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRA=
Y_SIZE(d)); \
> > > >       if (ret) \
> > > >               dev_err_ratelimited(dev, "error %d when sending comma=
nd %#02x\n", ret, cmd); \
> > > >       ret; \
> > > > @@ -54,10 +56,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct =
drm_panel *panel)
> > > >       struct device *dev =3D panel->dev;
> > > >       int ret;
> > > >
> > > > -     priv->dbi =3D dev_get_drvdata(dev->parent);
> > > > -     if (!priv->dbi)
> > > > -             return -ENODEV;
> > > > -
> > > >       gpiod_set_value_cansleep(priv->reset_gpio, 1);
> > > >
> > > >       ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0ba=
a_supplies), priv->supplies);
> > > > @@ -243,9 +241,9 @@ static const struct drm_panel_funcs hitachi_tx1=
0d07vm0baa_panel_funcs =3D {
> > > >       .get_modes =3D hitachi_tx10d07vm0baa_get_modes,
> > > >  };
> > >
> > > Unnecessary semicolon here.
> > >
> > > >
> > > > -static int hitachi_tx10d07vm0baa_probe(struct platform_device *pde=
v)
> > > > +static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbi=
dev)
> > > >  {
> > > > -     struct device *dev =3D &pdev->dev;
> > > > +     struct device *dev =3D &dbidev->dev;
> > > >       struct hitachi_tx10d07vm0baa *priv;
> > > >       int ret;
> > > >
> > > > @@ -264,6 +262,9 @@ static int hitachi_tx10d07vm0baa_probe(struct p=
latform_device *pdev)
> > > >               return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> > > >                                    "Failed to get reset gpio\n");
> > > >
> > > > +     priv->dbidev =3D dbidev;
> > > > +     mipi_dbi_set_drvdata(dbidev, priv);
> > > > +
> > > >       ret =3D drm_panel_of_backlight(&priv->panel);
> > > >       if (ret)
> > > >               return dev_err_probe(dev, ret, "Failed to get backlig=
ht\n");
> > > > @@ -272,9 +273,7 @@ static int hitachi_tx10d07vm0baa_probe(struct p=
latform_device *pdev)
> > > >       if (ret)
> > > >               return dev_err_probe(dev, ret, "Failed to add panel\n=
");
> > > >
> > > > -     platform_set_drvdata(pdev, priv);
> > > > -
> > > > -     return 0;
> > > > +     return devm_mipi_dbi_attach(dev, dbidev);
> > > >  }
> > > >
> > > >  static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] =
=3D {
> > > > @@ -283,14 +282,14 @@ static const struct of_device_id hitachi_tx10=
d07vm0baa_of_match[] =3D {
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, hitachi_tx10d07vm0baa_of_match);
> > > >
> > > > -static struct platform_driver hitachi_tx10d07vm0baa_driver =3D {
> > > > +static struct mipi_dbi_driver hitachi_tx10d07vm0baa_driver =3D {
> > > >       .driver =3D {
> > > >               .name =3D "panel-hitachi-tx10d07vm0baa",
> > > >               .of_match_table =3D hitachi_tx10d07vm0baa_of_match,
> > > >       },
> > > >       .probe =3D hitachi_tx10d07vm0baa_probe,
> > > >  };
> > > > -module_platform_driver(hitachi_tx10d07vm0baa_driver);
> > > > +module_mipi_dbi_driver(hitachi_tx10d07vm0baa_driver);
> > > >
> > > >  MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > >  MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA MIPI DBI Type B panel dr=
iver");
> > > > --
> > > > 2.53.0
> > > >
> > > >
> >
> > I agree that your suggestions are ok, but they are out of scope of
> > this patch. They would require either dedicated commits or can be sent
> > as followups later on since they do not cause bugs.
>
> I don't see why the include changes are out of scope. The platform
> driver was including platform includes but now it's no longer a platform
> driver so it shouldn't include platform driver stuff. The rest are minor
> enough that I think they can be included as well.
>

I can remove headers, sure. Regarding semicolon, here is a bigger code frag=
ment

 static const struct drm_panel_funcs hitachi_tx10d07vm0baa_panel_funcs =3D =
{
    .prepare =3D hitachi_tx10d07vm0baa_prepare,
    .enable =3D hitachi_tx10d07vm0baa_enable,
    .disable =3D hitachi_tx10d07vm0baa_disable,
    .unprepare =3D hitachi_tx10d07vm0baa_unprepare,
    .get_modes =3D hitachi_tx10d07vm0baa_get_modes,
};

- static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
+ static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbidev)
{
- struct device *dev =3D &pdev->dev;
+struct device *dev =3D &dbidev->dev;
struct hitachi_tx10d07vm0baa *priv;
int ret;


>
>
