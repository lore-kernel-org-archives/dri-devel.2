Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F7CD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31485897AC;
	Thu, 14 May 2026 18:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RZrWnNHB";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290A6897AC
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:24:33 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-393da8f389bso84035801fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778783071; cv=none;
 d=google.com; s=arc-20240605;
 b=L9hEWH+lNfEzKLuBVzSc0iyTCXWD9940dI850MopIQbXGLM3izARJU4XHOsAaDKqoO
 M1Ej6o29wH12ZeREPXYmI3qQXWovQGELI96nkthDjHQMPEbQKHM9ypIe0K7cIzsIZJi3
 KuEten8GlwjZw1sGfLt06ZnYGz+HL8RTIFEzMzETxygPqZZgmpQCnISXva81lLbxw18Z
 1x0HUfXWIzSQJsRAtDQr8R040ljNcgjQtksqMUDPOVVHGxMIzDpf/PpBxnBF/iLhQCdF
 V4t5IIVKAszZtG6e/0SLrdOhIdiEWTstTDezm0aRHUUJFvOqJStik9JGOTOUIiTYif2p
 YkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g/n7qmH+UjfqU3oZNtSb+ulfjY44x4tUNOP96fJ9Gp8=;
 fh=0mduObTPTNRiKpS8O7Rdeh8TDeROzdmxb6mXKQa6LF0=;
 b=dCsIw6SE+OnnaczlV1V7dmKS9cY0HH2hq+C2qSVY5LUhAUyuc+t/2ECHkSmUKBHqM7
 2tOSLDmUzY2MKAlFC3uowOPf2nQS07FUFGQlmT4unSPm3eDFv86aippAVrGWh9dVEpKh
 XZfHYPyDe7c98nwi3Tqd8GMLXRDXaxEQQmZGcanNsN3Fo7q+F150rY28JhJc/yTVp5ob
 qsj3WCAP0nhj8omskc18+gIPTrXH+l2sf70MZRlzdusOkPKIvQND8mlSFpFFTPp0Ah5/
 0bSrTZF6YxOTAANW4BA+3toqazWQiJe0gj1QATazJgJkdag6mhH/OGkv7eTfCM4JthOX
 Z/Mg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778783071; x=1779387871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/n7qmH+UjfqU3oZNtSb+ulfjY44x4tUNOP96fJ9Gp8=;
 b=RZrWnNHBiFwi0ZI36D2nzvIug3ZSjNDLGMb9yilRGPR1P5/uQ2e9eFUe7GUcBiG+3e
 konlKD0ggkjii0dJt6+IEkxLtON2tzLX77RR5C8qXBIWkopPiJgfLYCCH6NYsDAOGWd8
 EiPVeDc7QVIqAFn8ar5U+S09erZqfhCl53+lIqkyDfx9ptBzcuTZqIVKYfxOgwEDwI76
 WWGnohp8Vwk7Xirl/kes/mQnQUITN2Pt5ZfpoIQ98G/6Kd2UekcMZ26eP76LvOndI/e5
 VEpTtjFUv8+HLG2fsH2VL3K5dJQDr4/Urewi194fBWzy/C4spcg7Jepuv4VbWb8nPipY
 4MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778783071; x=1779387871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/n7qmH+UjfqU3oZNtSb+ulfjY44x4tUNOP96fJ9Gp8=;
 b=Q+ZS97KY0RIb8NiJtDjlVI+7hHbbmYEfKrhXf3l88W6X/z8NiLQ/DsqeMmxFUWeIpe
 33xkC0OWYpUzcUmodfsZMgZYDz31etfARO4B3KtAUyD7OLhG9w3qKq9SMRRiUThLyEFC
 qHFRqhE2qoaVwZTAvjHa0MxFL7Kw18ZeQUseg4S6GZ3cGm6yaxgbZlbKurMS+Ce+Nrpm
 bzdNWwv2dX83omvou29Nd9yN5pPKV0hsrhn46/gUgL3IBXWaF2KLwiBx/lowrdK+SdNr
 xZ9syKXKCcugqiVZSO61/8DXicD3NRoCbImlIy1e44QDY4sq5w3KJg+jMYaa4Phg/geo
 CO7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yBS+Di4kv3yuo7qxOOO2w6biF8D3hX2d9KuP8uCcKC6xW6SzKMy9o57UnAzy0DmHuUKIqRP6BYaE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYcD4h/mxoX9WyQr9zoE8SQO5Xgl2kJPn15QX7wf4jB0ofWWvs
 mldlOz0mNkitWpgiMDVCJKGl0J8w+HDoopwNx2uRbC2dFrHVIj0w8AntdY4/wJ0GwyVQsgA11hJ
 eXk/Y6bxGbqJNGv7OM4K7UxQ8G30vmZ8=
X-Gm-Gg: Acq92OHEk743901pLojRTGCuuc2D/xAqeEIfeI0+CIw5Uc72FteCfMdjzEsEnQfqWjU
 uIAZU1LztTValufQWRvoY5KcAtTcsombNlNn3Ytwm+dp4M3x1V1SGqWdx/48zQ8oeo2jB/0C+op
 Ig/69kftWbpUuHCtyPJ+tYPU69k9BGkXOMJkJDH+QVu4LN2OMJdJxynj5XQVhnwvPtwqS+juXsC
 RMtytRiMtlO5wAgxIfOhkylXnVJMxn2xUY16Q0BphzelibFzOfWbzb7uvfFG6jknZAWPpnEQRXn
 Q3spqbt5q+XMTzmTEwgHiK71LX3hoRTeMY45epYQqRHv5NT1IeM9Qui++95ZTR44me24
X-Received: by 2002:a05:651c:b0d:b0:38c:6b42:3d83 with SMTP id
 38308e7fff4ca-39561d884e6mr611691fa.15.1778783071177; Thu, 14 May 2026
 11:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-icna35xx-v2-0-45acd1dfa566@gmail.com>
 <20260514-icna35xx-v2-2-45acd1dfa566@gmail.com>
 <20260514-sphere-overstep-e564bf7ca609@spud>
In-Reply-To: <20260514-sphere-overstep-e564bf7ca609@spud>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 14 May 2026 13:24:19 -0500
X-Gm-Features: AVHnY4IjQHSroQwEIE5qXCkACNibttIrvT8hL7GmzRjoramD1sZbohpVjnGBbBM
Message-ID: <CALHNRZ_4aii1MTqd58zZ_1sFoxNZPPehuRauvExvQzzBBb7tKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: Add panel driver for Chipone ICNA35XX
 based panels
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
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

On Thu, May 14, 2026 at 1:05=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 14, 2026 at 12:24:50PM -0500, Aaron Kling via B4 Relay wrote:
>
> > +static const struct of_device_id icna35xx_of_match[] =3D {
> > +     { .compatible =3D "ayaneo,pocketds-panel-top", .data =3D &odin2po=
rtal_desc },
> > +     { .compatible =3D "ayntec,odin2portal-panel", .data =3D &odin2por=
tal_desc },
> > +     { .compatible =3D "ayntec,odin3-panel", .data =3D &thor_top_desc =
},
> > +     { .compatible =3D "ayntec,thor-panel-top", .data =3D &thor_top_de=
sc },
>
> This looks like you could be using the fallback compatibles instead of
> matching on the panel's. Why aren't you?

I'm uncertain if the panels are actually the same between these
devices or if the init sequences are just similar enough to share. I
am told that the thor top panel and the odin 3 panel are the same
model. But I don't know about the portal and the pocket ds, just know
that they both fire up and work as expected with the same init
sequence. I'm trying to follow the bindings idea that these might be
different physical panels that only share a ddic and thus driver
handling.

> > +     { /* sentinel */ }

Aaron
