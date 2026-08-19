Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D24C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E18D10E07F;
	Wed, 19 Aug 2026 23:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lybIcI01";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73EF10E07F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 23:57:03 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so2026312a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787183822; cv=none;
 d=google.com; s=arc-20260327;
 b=Wcy175P9qAhgJeMnxqbJkBq5xsHhD+LQQ2wBv2spFzQn+HJHY750HqzZtddv7wDWjW
 NbVTYhW8E09RoCQJ+06w21mfG8TavaatOHbcF0E/m8cu5EtAIwK9ODnrfpf6bnRTR+9Q
 2gwg8YlUVnHP2Bc+D4CVOU4Pz2HGEFZ39H2BYwwmpwe1MOmUjoZscobezggsSyEvPkxW
 gZ2tRageYXWJcxr32wy1pZZib6dC7Dpe1d8f6orM/+VyRt9lRl8odLJiAbkB1AyhZ4Ub
 OC2wtWhPPa6dPJMsBI5i/jpLdYfhRptiGgB+PwGYrpUrS5TfM/QQ0TgHeC1t3vLweK2J
 hiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
 fh=DLT6olK+GPyBCPEun888rJZuPjNhRvGNGunDycJz7bA=;
 b=B4gw9wm7Fv8+qMNfb0Hb9H0EuHVIgSrZUz3e5wrUZp8o2R3SUvj//fGUuKzy71Q+1v
 AOkMvePZfIkk8FMalEUGIFkrNVo9c4xuPM6x8gwcvT+K+1dl10WJD6ZgAsM2s754ayF8
 UF1JL+vR+EC34wCi5cKoNUjlHz8Cgco9cCAlaTCiTiK2RQo/r8HoEgn4la1IIHC4Kkvr
 YN8aJTDlYTMroLB7qv5bZLaEyT6Ar2Rv69r/+wXX6uGb2rpQ58g7cEj+0b+tNINVB571
 DtZSm2ZsaILKnmSASqNW2nMCIOGey905y+QnjUUwHnMI/EVXEh0aBkuH7yI37X1XchPB
 AGig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787183822; x=1787788622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
 b=lybIcI01UHvIjDt2WEJjXzMHJ9/8tkLPz526ACjNWMfI9eez7MtAGnUyxA+VtMtN0T
 AKyVpWdgDGIy7BrCw+t1ttDXVzfYw6VgEnbty9INrd+qq8JfBxwUq5aBPvYBlTf6YqUf
 NGNmaqik5Uyl0Y3mKLF/11CLDT9JADhf4aBa3VZ2fxkoF+HgK1uAFZdikZNoHdY2iWH5
 uUiLNr74D3o0RqCkOb1OcW4tZrrJSj7GTJHc+zJIFCdTTdDdhCtsU8ooDhUvAQMPtbF2
 9kdUnneEptcOZC409NlDZ/R/81moXsHLU8ntr/hKi1O+4StBZhNfB/8zzL+h4IVshL2S
 ih9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787183822; x=1787788622;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wgjj8WuiZYUMY2UUr+Q1Kyng/gQMuV8XXaYN9VqOJR0=;
 b=iMAFreDl3lAzl2CZaja9blzeN33OamFD+/wcpdLHxweIo6VBuCVUVwb4Klv9fOi3F6
 WNF19RkeNwz4wzavDqHE11g5gZZ65GwAv0dG1Sn4aPbhcaOAVf0COx/4MRkBkTkW5dvi
 1WIFVNyjfGgsRs3p0pTNsS7HqD8MKQa/8NLsbgURu9WtxKxG8poL50CXjUYIcm3gGteN
 15HO1b9nSybBkLQnkQLEZaja+VwbLRNrxZaJG+NGXHCeC44eWawjuzH/ypRi60tr1oh3
 F7+fwh6I0SKDnpAG4/43dVDYl3UIp5PKTWIi0fSonV0ajzXnOmZrghMMAcCXgikbHd0Y
 VMlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrkgm3ah/j1+a/w28BoxEJVgjhFm/sCiY6GaRsTUdGIkADvVX4izBeoA6VhOnKGHByGsCUdKFyKfAo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nv7DSS38wW00FGYj2q8zrsoKicQQqQe9+OwUhb8c5hNHIv7ZyJ
 XFBi3vwY+J66tX2aKrizOwDHPcLjhIpur6dzc1tF+68dFpdNjujbwhkMPxPQSD3UyJC4dPdGP2+
 9QhQRl6+NeZR5mLAp8rG3JdKYqt/NMC0=
X-Gm-Gg: AR+sD10V6pUojRZ9nKSOkRtRXTdQFiNXmVA50ABQb/TCZgtA48zSXAOsecchv/OwEdj
 rsq7aYXVQ78lpDrD3d1V5vuAom5EAqgchDoiO1Ru7VIGwKxwPdDpX5F0wb/RIwfhAwAO8DXGP2Y
 WLJEzhb46S8y0qkpUExHigWiGf1dRKvLnVC6WCr0YQKwx0TPuzXCceUUWnq5l3c66rMUMng8W+z
 udNYico2SB3pLVgq219Xh8XkTIOVjjN8kYQGPV6uEVbFQTXyjOuotQUWG+zR6utMveYeOMU0LWC
 vIB4a6eNQfYkDLhyAiUSM8LsgfKtH0YGMokWq689+w==
X-Received: by 2002:a05:6402:44d3:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6a4032961bemr4544062a12.1.1787183821720; Wed, 19 Aug 2026
 16:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org>
 <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
 <aoSygH8JSXFrivOA@bywater>
In-Reply-To: <aoSygH8JSXFrivOA@bywater>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 20 Aug 2026 01:56:48 +0200
X-Gm-Features: AcwNN1VNx4GsAKqd8z0hu2r6Vk3bBmJ_vBla6bGBHBSguaKITunj7iojs8USPhQ
Message-ID: <CAEUXW=HHJve+NDwkzhC5sWwqWbBwAAyxLUdp0e1tK4NP2=1Dqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Francesco Valla <francesco@valla.it>
Cc: Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
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

Hi Sam, Francesco,

Sam -- thanks, and you're right that it's doable. One honest nuance on
where it would live: CLUT224 isn't a DRM fourcc, it's the kernel logo's
own container -- a palette plus one index byte per pixel. drm_format_helper
converts between pixel formats, which is a symmetric operation; turning
CLUT224 into RGB is a palette decode, not a reformat. It can certainly sit
there, but it's worth calling it what it is: a decompression step in front
of the scanout, not a format conversion next to the xrgb8888->rgb565 helper=
s.

Francesco -- that's exactly the crux, and I think we agree completely. The
palette expansion is cheap for me only because the image is small and
low-resolution: one lookup per pixel at 800x480 costs nothing, so I get the
17 KiB on flash for free at boot. But that's the "low-resolution sweet spot=
"
you describe, not the general case -- at a generic resolution the per-pixel
decode stops being free, and boot time is the whole point. So I don't think
paletted input belongs in a client whose goal is to stay generic; it's a
trade that only pays off when the image is deliberately small.

For the case where nothing lights the panel before Linux -- Falcon boot,
or a handover where the buffer doesn't survive -- I do have to draw, and
there I'd rather build on your series than start from scratch. I can't use
it unchanged, since my logo isn't a BMP: it's a small CLUT224 (paletted)
blob carried in the device tree, so I'd add a source alongside your BGRT
and firmware-BMP ones that recognises it by a magic and decodes the palette=
.
But the client structure, the drm_client_setup() hook, the scanout path --
that's all your groundwork, and I'd be leaning on it. Thanks for the offer
to help on a respin, and for the series, which is what made the distinction
clear to me.

Max

El mar, 18 ago 2026 a las 21:39, Francesco Valla
(<francesco@valla.it>) escribi=C3=B3:
>
> Hi M=C3=A0xim,
>
> On Tue, Aug 18, 2026 at 12:48:21AM +0200, M=C3=A0xim Pedraza Padilla wrot=
e:
> > Hi Sam,
> >
> > Thank you -- that's a useful pointer, and it settles the question of ho=
w
> > a splash should be drawn without fbcon: a DRM client at
> > drm_client_setup(), next to drm_log, not a drm_fb_helper hook.
> >
> > Francesco's series is genuinely inspiring work, and it would be very
> > useful to me if it could take a CLUT224 image -- unfortunately it can't=
.
> > It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
> > paletted, which is what keeps it small: 17 KiB for 800x480 rather than
> > around a megabyte. So as it stands the format doesn't line up with what
> > we carry.
>
> Format concerns are - in addition to lack of time to work on it - what
> is keeping me from sending a new revision. Any kind of compression would
> need to be unwinded - probably on a per-pixel basis - making the
> required CPU time unreasonable for large images (at least if boot time
> optimization is the ultimate goal - linke in my case).
>
> Of course, on "low-resolution" displays the size-vs-time tradeoff might
> be the sweet spot - but the target here was to being as much generic as
> possible.
>
> >
> > Reading it did make the distinction clearer to me, though. drm_splash
> > *draws* an image into a fresh buffer, which means a first modeset and t=
he
> > blanking that comes with it. What our hardware leaves us with is a
> > framebuffer U-Boot has already drawn and a CRTC still scanning it out, =
so
> > for our case the natural thing is to *adopt* that state rather than
> > redraw it -- which is what hardware state readout does, with no redraw
> > and no flicker.
> >
> > Where drm_splash is the right tool is the case with no state to adopt -=
-
> > Falcon boot, where U-Boot proper never runs, or a handover where the
> > buffer doesn't survive. I'll follow Francesco's series for that.
>
> My typical embedded setup is exactly that one - Falcon boot, a simple
> boot logic inside the SPL, and possibly no initramfs. I find this to be
> the most portable solution, as it does not require complex drivers and
> handover logic in the bootloader.
>
> In case you decide to take my series for a re-spin, feel free to ask if
> something is unclear.
>
> > Thanks again -- it helped me draw the line between the two.
> >
> > Max
>
> Reagrds,
>
> Francesco
>
