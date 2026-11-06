Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9F606A334
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SE0jKswu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB82112DE3;
	Fri,  6 Nov 2026 14:01:03 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F42112DE3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:00:58 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso940800eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973657; cv=none;
 d=google.com; s=arc-20260327;
 b=HnOFcmofQyP9pbRchQrwKtASQ2fenVTp9oscJo2bmNxfr8nC2qy3QQLslcBguV1eL8
 Vfx+HuI2+nw6Yol93LFwrZWRp4FVhkoXYjCBUpa/zUAxX/Vy52CpnA8y0ftTC2bK6g6O
 Y6ijqfcPUf/kLN5eMf9aygXF4F+mUTEIHyFdHgGqajv/xSY4SL/InVVYxjireRDJP0u4
 iZmi32xhJiw4TDUuNJQkseGlhH8hBTaODc4FLPGVo3mp8La8GyB4Db0TlQCGP5xlepNA
 7tZ5B+PbiN0bBOq9Ddg1UVD5vh8o8EKetAShOWL15HJ/30Q50Cu+MKcj6DD9NlUBC9kl
 OnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N4ROuVU9vfjyHzDgItD3nKZQjrXj2RH+3oWdZlQA3tg=;
 fh=7+bogMKmwxLQR2OjBzVAPXmNZptNKJ3tsAedpjL3cHw=;
 b=gA3eEGvK8aCX1o99NSyVJSpV6AJo5lFlYEaWHMmfOgRD9m63MTyIBzqch6oK39hYwe
 vZCsqQW4pfgyUb1dxFToJN2wTFmUUtTw/6F5DxzMqUUDOMaFOBHlvefvMYcfyvB1Lm+B
 3mm9AIjg6oXm4HQw0LQzTuXqI+CIvEdy+gR6xaD3Kbg49H9gT/17cfDst1Fnjum7dpBO
 1UVhALsPcyzMJwEmF7DtnSdDyNIoDwrd/c1QIMeWYWb6AIMY4nHAr/EAmX6lCBy2VnKU
 6gDXoIWnmj9O4Wvxw/OZ7Fi8m69/pISNBsk+KR68UbulllDBWjbJYGaOgzgZld6UwWJs
 lk6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793973657; x=1794578457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N4ROuVU9vfjyHzDgItD3nKZQjrXj2RH+3oWdZlQA3tg=;
 b=SE0jKswu7JitJIh/8mr4XLLOyBFRUEB6c0NyVR04agBwYJA2Oba8lrN1F/kbdBCZi4
 zTlJda6qbYT3HnxvUIhDBts23nUiLtRETSrqEcr0C2Z4I+lgpGiCChHjP/e8V6VRt80Z
 jf4RSeq3GTAZDBbBxlqnCMmyTFIlBG+dFri8RPlLevXwrYBI6NUXiDOS5/UWtSgetUj9
 ePOnzwqEE7Vd5QT0trVwRX38VGzB8vLwsH1at5q3//s8c3gOu5GKU4ZvnXi8IXDMPhqp
 Uq/KvKBKycD7uIoCGFO/qlBT+uU/U2/oI0PsFObSuSuc+sE1+rL8hf6A5NHv/say6jBI
 Sc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793973657; x=1794578457;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N4ROuVU9vfjyHzDgItD3nKZQjrXj2RH+3oWdZlQA3tg=;
 b=jwf+4q85gsRhND6lsrJof9X4TOG9gbSBi2u7wLCjT2COLYLotjctvpbpWECtl34Ag+
 bo11J5lGWKemVWwnGjVo4jQF8HLB7QvskrXpgtYPD7//0JyLx0fA1A8lgxKKHzf9FrWT
 oCAAEuqQfW1zeuonbuoVpmOlZAdBBjz0dH2Z8UtGJ2dthREY4H2TYhDPnJ0UEZTachjp
 xb6EU3X6Xphx1+bdD9vYRjNYLi+D5jLI7YP9alE4qJ2psgX+sGlEkITtYdGuBJIQNoPT
 sAEmuJmewdhfB3c2DOvcP451tTQZW7ecTXjAMRPEWk8JBQruQmYAPcyMd29OVm7tOXfb
 bHYw==
X-Forwarded-Encrypted: i=1;
 AL+hErF2r9Qc2+aiieQ2pJ1jmPMP0IQIH8xslVUgx5wTkL8HS1W94fVSxVdvhsm8JyFkTCkotauoftUCKtU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9EA5tVQNvm+aVg7cU+rR8pPv22mW0kyeoXPYopBOCbjboDlsiw
 YXyn0M8G2VNaGgBKV5S7s+NYofpbs4NxcJb70jCv/YqHhsFG8SzlTzoGr/eU7HPHn5WuOSl/A9f
 a5NUa8y5b5wd/aFwFUhxrkXIYBZZ8ksg=
X-Gm-Gg: AYBFou2Z9Vba3Zx8xaqowooRUoyRN7bqzfD1F7gJDjv8vcUd9u6kZr+kiIUuyzOHcMj
 1+/rVbjX5uY5A/nB9jdMPyLAnlAExgywWyOMUqotNzgsiyKzTww6nmUUiKBrFA9ZGg1CvQnw88J
 5BVAhppCUaFEgMFxDfxk+fspS1I5nmbAgad0102OjmTEf69haLiwbYHE/4hgagyE+LHS6fX1Ovk
 xuGONYN3VXSGzIHvqgj6lfyjio9W30NWLQo0d3u8Dunsis6CXWTmtllFh9dmtUrh52tSAO87tIx
 XIfaO7B2tmwUduGQu4/0Y0dw1RZzUhL7hcNduPDXmuvNaMLwn70PycD6m0zGvxSDYM50nYSxxpS
 8EUAq/2pVj7je/CVfYlv3mB7R/4qeGzHooEhjNmIpzMSsVDroXcH8B/Hz3+5o9dlj5ctP87ukyq
 sdPm+KbPdL75NAeK+YyvXkcPjPEIQURg==
X-Received: by 2002:a05:7301:c88:b0:36e:1fbe:357a with SMTP id
 5a478bee46e88-36f75443c1cmr3326733eec.13.1793973656931; Fri, 06 Nov 2026
 06:00:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-3-clamor95@gmail.com>
 <au3TcHXFt5Yhs_V8@orome>
In-Reply-To: <au3TcHXFt5Yhs_V8@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 16:00:45 +0200
X-Gm-Features: AclHuK_Yq17ZZfT-X8-aPL0HIpgqp80MKKwHsNn8Kpc_N4CDrvvxE70OSsxRMSo
Message-ID: <CAPVz0n0ngn4nf9uTOsM6OKB9jgTnJN1FrPp0UyeHwuAwoL5_tA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] drm/panel: Convert Hitachi TX10D07VM0BAA to use
 MIPI DBI bus
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
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

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:19=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Nov 05, 2026 at 04:05:02PM +0200, Svyatoslav Ryhel wrote:
> > Switch from a generic platform driver to a dedicated MIPI DBI driver.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 167 ++++++++----------
> >  1 file changed, 78 insertions(+), 89 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driv=
ers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > index 83c2af1be9755..d5d7ba2096608 100644
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
> > @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_tx10d=
07vm0baa_supplies[] =3D {
> >
> >  struct hitachi_tx10d07vm0baa {
> >       struct drm_panel panel;
> > -     struct mipi_dbi *dbi;
> > +     struct mipi_dbi_device *dbi;
>
> It's somewhat difficult to exactly see the difference between mipi_dbi
> and mipi_dbi_device. Maybe that should be explained better in the cover
> letter of patch 1? Or the documentation added in patch1.
>

It is already documented in detail in the drm_mipi_dbi.h

> >
> >       struct regulator_bulk_data *supplies;
> >       struct gpio_desc *reset_gpio;
> > @@ -36,13 +37,12 @@ static inline struct hitachi_tx10d07vm0baa *to_hita=
chi_tx10d07vm0baa(struct drm_
> >       return container_of(panel, struct hitachi_tx10d07vm0baa, panel);
> >  }
> >
> > -#define panel_dbi_command(priv, cmd, seq...) \
> > +#define panel_dbi_command(dbidev, cmd, seq...) \
> >  ({ \
> >       const u8 d[] =3D { seq }; \
> > -     struct drm_panel *panel =3D &(priv)->panel; \
> > -     struct device *dev =3D panel->dev; \
> > +     struct device *dev =3D &(dbidev)->dev; \
> >       int ret; \
> > -     ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE=
(d)); \
> > +     ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SI=
ZE(d)); \
> >       if (ret) \
> >               dev_err_ratelimited(dev, "error %d when sending command %=
#02x\n", ret, cmd); \
> >       ret; \
> > @@ -54,10 +54,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm_=
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
> > @@ -79,123 +75,116 @@ static int hitachi_tx10d07vm0baa_enable(struct dr=
m_panel *panel)
> >  {
> >       struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(p=
anel);
> >
> > -     panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x=
03, 0x1f);
> > -     panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x0=
3, 0x20,
> > +     panel_dbi_command(priv->dbi, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x0=
0, 0x03, 0x1f);
> > +     panel_dbi_command(priv->dbi, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00=
, 0x03, 0x20,
> >                         0x00, 0x00);
>
> The majority of the changes in this file are s/priv/priv->dbi/, so maybe
> just make it so that priv =3D priv->db and keep the changes to a minimum?
>

I will consider this.

> Thierry
