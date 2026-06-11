Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5647DCD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D7310ECD0;
	Thu, 11 Jun 2026 05:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/4/nZxv";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D2B10ECD0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:52:54 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-59ccf81e74bso2714074e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781157173; cv=none;
 d=google.com; s=arc-20240605;
 b=GNnuIii9v4XcV+/PLYWfyIGxIWVzMGQm8tjRAh/VmGVkzVa09YNUcjIedw5UXYWMpm
 SH6DJMOh+QdL+YvEBPdheg6cn0cD6Z9F9JGJZepH6lCde80QRy9+yKmwKHHC0oJH0DDU
 6LVAT2BddKRoAENf0vudzU0EanP+UN4SVIU4R2zU0JxUlNApc3tyHwu1A+VVSDPh9gSZ
 fuD7RWpFAay2sVZfx3Wv44b6qQ7I4EBx5DbcLrVcoy7oN60kWTIQHtADAfFajVCeOoTu
 XO4sDVTpgmZBC7dwFe9SPlhgiVBbwktvGcEh2R2XrW7lTPTb5fAy8Eo4cnCt7yasi+LB
 SMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BEMiDPCD1Ibyc6I+MijVZ6I4dtevE+uqRF5A9n5w9rU=;
 fh=XM8B80GNvXZPi9xOHb5rLuUqi7mdx25MeY/X9dg73nc=;
 b=OnsdjVb1NbqgCdy5nzBriFZSgQbmmF/W6FX0QErFTi5KPsbiPUKcJHVyBd2VCwHKT0
 vGYIbQQeEnZrFt+u5NfPN0LepE2FOeOFPAuU73P6qLvT0U4RLo5EoBmvSyvp06I5GhGP
 +LwkPNQWTrfqkqIRTEVMXe37TNUKIyZQ3DAfp+t5FjC0bBsyJjqDs4VDiO1E3Rh+Tanf
 0FQALi7czJJok+NB2/iAQvE4wWOt0hf6PbgcLEk7UAKwF234JBJ/yrVTdAKFyNjoJx3E
 sy6UvZBZwJRJ3W5qda45c0j0Jv206bAKi8nKZsekqx4wO0Hc351ZeSGKH+Zr65PdlMzs
 DHXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781157173; x=1781761973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEMiDPCD1Ibyc6I+MijVZ6I4dtevE+uqRF5A9n5w9rU=;
 b=N/4/nZxv1+OFgFzon6kLGciOLTTeDjNFJR9Y4rez/SxO96UcXzug+91gNN/ANbEOH7
 tlTLHKF+fsyCpwaR1nP2wEuaBWg81uMfs11Fi52xBPiRZju34CR4Jb6+nq1g82PMD6X9
 JQbtzJ4sSPJBVJ8JoVcsSXnJ+V0Gb+LxMB65nD6SIi2OjmJ8Nl7yDp1gvbTutlNKOrgv
 wihW/QtFPuM22xGKhRWYREoHV5u3d5sfy5F/KwIq289+zrNc8SErtuMIoXdRS6JZ7wQq
 651zTRiB4ZGyppRMgSSNN5Msl3WAhus1nNf6UZvzrUFhBakX9E+ZnEq15s5tal+JR5dU
 /90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157173; x=1781761973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BEMiDPCD1Ibyc6I+MijVZ6I4dtevE+uqRF5A9n5w9rU=;
 b=hyiW6Qv4JLdn8Cm6+V6MFsYGjtfODe2Ukizec82uMFO9yOSaXDV2wx+Qt7aVZl+xCv
 ZrOSfdbY9mCgLsZbhV6MFgUsESb2aC2cpQ3RTWr3WGY8sV2BjDb0WXqYyb+QVLDr/jpV
 WPp9pMScVD8TIGrg/quvPSoJ+I95h4/JIsaD3O/iWqISffycZwSJjerM7WsN5csz2EF6
 tPl8nS5eJX0l76iSlNnCSW/ZNL8UipKbQmEOgidKmeGd7tBnwaG0TKlMXy/6Pq/IP99A
 s+Kn7KMWz+DPgO5AWuvUj/9WBuCpav/ok6cYj2HElIEd9zwO52ey3pg/7SkUqVwAQSSm
 lTpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uK/Mdc/te91hFDL+5n2sCkwISxQgJkp6gD6C75+5PxhVIV0wR6EXy+0OPHG1AQSv/ou1ZMLQfbro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN4j4T+Ji2iKuJ1kstyV0XKvLJMEkfprtE6JFqZX55h85cTVog
 78OGD00EwtXDGkgr9Cngv7+ADjBR84gf8b1o57SfXGJkWMOzCi/75Q4+mFmcN70kLzwjnJWFGLe
 TLMtfGK5YX/ahCmuJ+4Q+UY/wOt+O5IM=
X-Gm-Gg: Acq92OHat8DNUwrHEqrsghUkSqZ9G1PlInQEf1E8A5GQu1BkjkpfoDDj4B7vBnkeeHH
 jXVPLGYqlcyz+DPApCejaQrKeAegvz5wfzqJmL2NNWRdxXphhPK16vD+0Ec6VXvn+Luy3Vs1Gor
 WJ65sHYWOem0irycv59We9MpvI17GORpFzfg/nRjqtSKXS7p4HPnySK+hZjRB1u74FdPQd9Ruda
 vE5b4aqVBN2NzLLRnnaOLpfzsm5o8hay6Dnehq5y6dtLsDLbFa/J89zgzxNO5yIF+V7DA/ku5D2
 UQbMG0ggmTnsSlu0a5BX6EpN596dvSCkm/q0UMWdkWfLyr9tLw==
X-Received: by 2002:a05:6122:83e5:b0:5a0:afff:78a6 with SMTP id
 71dfb90a1353d-5bb02413694mr389666e0c.14.1781157173403; Wed, 10 Jun 2026
 22:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
 <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
 <178115560757.199930.5802398831559617564.b4-review@b4>
 <69a18fd1a1b9f375bbccfbe0d9e88ab31a01a188.camel@iscas.ac.cn>
In-Reply-To: <69a18fd1a1b9f375bbccfbe0d9e88ab31a01a188.camel@iscas.ac.cn>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Thu, 11 Jun 2026 13:51:33 +0800
X-Gm-Features: AVVi8Cc7LYQCwG-bWzkxGFR19dDpqNb_Uzf0FXIAKcUP6NkBobTDNj-Pgvcc6l8
Message-ID: <CAH2e8h7OhA=14KtkqxAJJWfPiLOAe44e5_Pw+DG9NOvN=-cGcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel: himax-hx83121a: add backlight regulator
 support
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Thu, Jun 11, 2026 at 1:43=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-06-11=E5=9B=9B=E7=9A=84 13:26 +0800=EF=BC=8CPengyu Luo=E5=
=86=99=E9=81=93=EF=BC=9A
> > On Tue, 09 Jun 2026 00:26:22 +0800, Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > > diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > > b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > > index 1a7e0125bced..e31e2fba0a78 100644
> > > --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > > +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > > @@ -195,7 +197,27 @@ static int himax_bl_update_status(struct
> > > backlight_device *bl)
> > > [ ... skip 18 lines ... ]
> > > +           ret =3D regulator_enable(ctx->bl_supply);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   ctx->backlight_enabled =3D true;
> > > +
> >
> > If you use a pin, (it is indeed a hwen pin as we know) you can
> > simplify it like this,
> >
> > bool bl_enable_now =3D !!brightness;
> >
> > if (ctx->bl_enable !=3D bl_enable_now) {
> >       gpiod_set_value(ctx->hwen_gpio, bl_enable_now);
> >       ctx->bl_enable =3D bl_enable_now;
> > }
> >
> > BTW, iirc, panel bias can be turned off too, although I don't think
> > this will save too much power.
>
> BTW during my test, it seems that DCS backlight 0 isn't turning off
> backlight.
>

Yes, there is a hwen pin to turn off BL. In the downstream, I added
it, no time to upstream it, I forgot to add display DT too. I meant
you can turn off panel bias too, if you turn off BL. In general, I
turn off it in drm_panel_unprepare()

Best wishes,
Pengyu
