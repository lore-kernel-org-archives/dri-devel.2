Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMQFItjt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F061128AB;
	Fri, 27 Nov 2026 09:10:27 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F251128C8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:10:21 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3869f03af6aso6954665eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:10:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795770620; cv=none;
 d=google.com; s=arc-20260327;
 b=HqR8pyOCwmELPWXeeEGRh17OebbRSwMWwTRL/7VfzSO/QCcdXhedhyydzhvu57a6yU
 HKh5BU2f7sAq95dU2J3trMRItDhnYSG/A336mK2sMrfL9R6I62y5y3uyeXOOg3F57nt+
 w2RmrBMlKHnhWS0PbIOycv+wJf60s0vl6YvewDTMJJ/nhHTHVPXmaM8qCxEcM6/rOZLc
 LMcD6yuYD5dxCDKf3C0oqkC34jg8fC8niRYPr/oOI5OlXtlbyLe5Yi48sRUeRq/ArcRv
 R/VzzeZ8G0oaxYLWlNhXKX+bnviWhhXdh5bnYWvO1ty32FkG+EOVh2V6/FxX9xTaO2IH
 /SGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DJZqyiXYJp/ORTQv62jnN7SBWTU5iRS+KZCY7pRd8ZI=;
 fh=efeVkZIfos2JWu9A+HAObcZbPVUvyIbijSdYCRx+LY4=;
 b=ocM4OwxXd0PNJki2puHAP8TzRB+/qrStUFocNjNfTehm2GCbCikxz948mOCKdU5Z08
 HNwLd4Pc85gFviIoBwIzrQ823ItXkYlLFIkFCOSE0ul2MvQCtfkvlC+kUaiIN7Jr8/7j
 p1dbJ+5yXX5hcUDSJUcVH9TR3ewDDCIPjeaw163qSWS5tIK8Dl3q2P49phWU1Lon2f6O
 n6wGP7ljUo8FLhJL8rczuerQyl1kvcpoax3z+Np+aUWcSNecGqP816njhrkS2/6nR7Bo
 kQCAofQ5yQLyiG5YEJcH9IWDzbVMhu9/o3EBVyA5j6HTdO9k3UHQaGSZ0wM5OHTn+laJ
 T8pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795770620; x=1796375420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DJZqyiXYJp/ORTQv62jnN7SBWTU5iRS+KZCY7pRd8ZI=;
 b=MMQFItjt8HxicYaeK8Ka4Jnke4O4wKB54DiAE9Ew7/yiVeeekgItTHKeNIKRq7BfKO
 tnH99qyZX/IEhCHmkFNFPBHiL8quqOgXPD6r4r8L6rMfJRfE3jUbpYMMlvwKDg/5Sxt0
 YRN8fbXB4YpfD0r7aV17OUldGHXCQSAXszHmcx5QQSnS1dxyIfr7w/mjJODKeEkq4l49
 mSpoI3R9o3n0LswW0uPHU8PpCBjP/J2BrVMjsquD0CLD+hHGRkm9OOvFHnHneJw/C9aN
 BESgh40YvoEuWFJgiC/nM2Iglt2Rk+teoPDh1PcjJJiSMbxE67XYPIOFUjMdUMyU+aFU
 5Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795770620; x=1796375420;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DJZqyiXYJp/ORTQv62jnN7SBWTU5iRS+KZCY7pRd8ZI=;
 b=BW/FNf7QKCLLpff1g2ufvxpc+g4LaYXlR3oaB7GceiSqBI7P6XHAHkQQKeUIgYVQgh
 OOQmdfNUw/SgxeYdd9eGEOJXHQRanrvq7dXuQG4Ofk9icrt+MgWmT58+tjclPfZgOMW3
 eqy525LnyTFZbIAhmRT7zJNYHJgk5nDVOh+KjREYahnf4nR2BNInmMz4XbDUnuJpepps
 o5JOf88N8C5UI1tZU8oDjJyhDAZsGjegwfmEKtGuCD/iiFkAN7vsIGNcfDWC/rYYCDh8
 2ta2OBiTTwenfl0+gFDo5nqtDn0dI2XT0kRdjw1iwuTH51QXEx1FXMJ4A+VHhdfv3cd6
 Ot3w==
X-Forwarded-Encrypted: i=1;
 AL+hErER4i2F9uZQ59TcL7/ELsACFtSHrmax7hZgeT0RgIHy/ZNFFT90vwdzHiCAqx/k42csbWV5wm0hcc0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z83T6OyHdLfPeqKsIfDSJya/tbIfWsQ74rvz2L2FL0O7DdQ1K49
 F6WhD01CypqU96COeUfMWQ5fjHVYTIopJAs3OmXJFuZAgUMtZlI6nLg6WALA9OATvJhJ0dIoOku
 NwjVsV4gtWVohsOQFaaiqWLFLgJy0mQ4=
X-Gm-Gg: AZFdTZc1UbBLQ3KZA+VL3iEhBqnOGicBY6zT+7Xx1LtcfXtTSltO7bC8UIh86nHGv5+
 2/Z1b2SPsXJIdqpGigkMI51ssnL2iQarDXcsxCsHIqMN8XZhvMFcPBzY58cM6ZXwQoSlNHEvwgD
 mUwozCxfZM6nm3IFYiUrgaSzDA9lfsOcHkyLLTGXh3BA1Oi3oKX1f5Tx9OvKSY74wBHCOVGkrg/
 HX1RqXWVocoYfvrW7piSLvzHSXTWzsXXZBGseqa26K71D6NOv+TKT21Xd2de4G82mujw33sefnt
 ETv+g100TnMkB3FCChT3RFO35y3p41K1xIb+Hc807NrCeewC/kYTXPYEHPvkhOMDh58I4eCrNqH
 h6jTAJrw6OFKL8xaiSVyq01N8ALRxgm1EvJl5CqH1BWwpjdEFaOFQUzjiAm4rsioG2oU37Gvcna
 j+sYJyxXFntPiYercqO6ACn26mIbqCFFAEXkmUCFzNOzPP7qW3+LE=
X-Received: by 2002:a05:7300:a228:b0:386:6685:1492 with SMTP id
 5a478bee46e88-386668523cfmr22742277eec.12.1795770620255; Fri, 27 Nov 2026
 01:10:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-3-clamor95@gmail.com>
 <hlO8KiQKSi62yShZAIyhpw@nvidia.com>
In-Reply-To: <hlO8KiQKSi62yShZAIyhpw@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 11:10:08 +0200
X-Gm-Features: Aa3M54rkyrHWlpK4-CIwvCUcDLkbHyRjNHzHood9SyBQos7xlCctA1vsn6y0klI
Message-ID: <CAPVz0n0Qyekm7qUyCVFMTDSuVSw=1my4x-rgiafp3+mQ_sgk3Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert
 to use MIPI DBI bus
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 06:2=
3 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Switch from a generic platform driver to a dedicated MIPI DBI Type B
> > driver.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 25 +++++++++----------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driv=
ers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > index 83c2af1be9755..318ece68b7806 100644
> > --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > @@ -14,6 +14,7 @@
> >  #include <video/mipi_display.h>
> >
> >  #include <drm/drm_mipi_dbi.h>
> > +#include <drm/drm_mipi_dbi_bus.h>
> >  #include <drm/drm_modes.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
>
> You should now be able to get rid of includes of of_platform.h
> (replacing with of.h) and platform_device.h. Agent says drm_of.h and
> property.h are also unused.
>
> > @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_tx10d=
07vm0baa_supplies[] =3D {
> >
> >  struct hitachi_tx10d07vm0baa {
> >       struct drm_panel panel;
> > -     struct mipi_dbi *dbi;
> > +     struct mipi_dbi_device *dbidev;
> >
> >       struct regulator_bulk_data *supplies;
> >       struct gpio_desc *reset_gpio;
> > @@ -40,9 +41,10 @@ static inline struct hitachi_tx10d07vm0baa *to_hitac=
hi_tx10d07vm0baa(struct drm_
> >  ({ \
> >       const u8 d[] =3D { seq }; \
> >       struct drm_panel *panel =3D &(priv)->panel; \
> > +     struct mipi_dbi_device *dbidev =3D (priv)->dbidev; \
> >       struct device *dev =3D panel->dev; \
> >       int ret; \
> > -     ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE=
(d)); \
> > +     ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SI=
ZE(d)); \
> >       if (ret) \
> >               dev_err_ratelimited(dev, "error %d when sending command %=
#02x\n", ret, cmd); \
> >       ret; \
> > @@ -54,10 +56,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm_=
panel *panel)
> >       struct device *dev =3D panel->dev;
> >       int ret;
> >
> > -     priv->dbi =3D dev_get_drvdata(dev->parent);
> > -     if (!priv->dbi)
> > -             return -ENODEV;
> > -
> >       gpiod_set_value_cansleep(priv->reset_gpio, 1);
> >
> >       ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_su=
pplies), priv->supplies);
> > @@ -243,9 +241,9 @@ static const struct drm_panel_funcs hitachi_tx10d07=
vm0baa_panel_funcs =3D {
> >       .get_modes =3D hitachi_tx10d07vm0baa_get_modes,
> >  };
>
> Unnecessary semicolon here.
>
> >
> > -static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
> > +static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbidev)
> >  {
> > -     struct device *dev =3D &pdev->dev;
> > +     struct device *dev =3D &dbidev->dev;
> >       struct hitachi_tx10d07vm0baa *priv;
> >       int ret;
> >
> > @@ -264,6 +262,9 @@ static int hitachi_tx10d07vm0baa_probe(struct platf=
orm_device *pdev)
> >               return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> >                                    "Failed to get reset gpio\n");
> >
> > +     priv->dbidev =3D dbidev;
> > +     mipi_dbi_set_drvdata(dbidev, priv);
> > +
> >       ret =3D drm_panel_of_backlight(&priv->panel);
> >       if (ret)
> >               return dev_err_probe(dev, ret, "Failed to get backlight\n=
");
> > @@ -272,9 +273,7 @@ static int hitachi_tx10d07vm0baa_probe(struct platf=
orm_device *pdev)
> >       if (ret)
> >               return dev_err_probe(dev, ret, "Failed to add panel\n");
> >
> > -     platform_set_drvdata(pdev, priv);
> > -
> > -     return 0;
> > +     return devm_mipi_dbi_attach(dev, dbidev);
> >  }
> >
> >  static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] =3D =
{
> > @@ -283,14 +282,14 @@ static const struct of_device_id hitachi_tx10d07v=
m0baa_of_match[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, hitachi_tx10d07vm0baa_of_match);
> >
> > -static struct platform_driver hitachi_tx10d07vm0baa_driver =3D {
> > +static struct mipi_dbi_driver hitachi_tx10d07vm0baa_driver =3D {
> >       .driver =3D {
> >               .name =3D "panel-hitachi-tx10d07vm0baa",
> >               .of_match_table =3D hitachi_tx10d07vm0baa_of_match,
> >       },
> >       .probe =3D hitachi_tx10d07vm0baa_probe,
> >  };
> > -module_platform_driver(hitachi_tx10d07vm0baa_driver);
> > +module_mipi_dbi_driver(hitachi_tx10d07vm0baa_driver);
> >
> >  MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> >  MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA MIPI DBI Type B panel driver=
");
> > --
> > 2.53.0
> >
> >

I agree that your suggestions are ok, but they are out of scope of
this patch. They would require either dedicated commits or can be sent
as followups later on since they do not cause bugs.
