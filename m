Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06B6CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171A910ECBA;
	Thu, 11 Jun 2026 05:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mk9z2rIm";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB0A10ECBA
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:47:05 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-6f0a59f3f2dso2291811137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781156824; cv=none;
 d=google.com; s=arc-20240605;
 b=FMhoe9ys/SPYQuv7gV3+6IjI+Yy13urmK0qB42eTpW0SDOmNec77sJIw8nYD/KEKTr
 V8N3vT/xYXf5551xLcobSEVnLYDcYjNkHWAR8XEeNhE7Myhlk/zT2/oDvp65VI8jiwX/
 fUYZiij+TE1E373yzCGSAg26jAkGlhAhtwQ4GSXL3f+qzkun/g3zHw9S33E98uR/JOut
 yhNagwCDN3kVgDH+K9TlMVZAtnN70XP8tK7rWf7HUrG6kDLQLXVP05AeuyvlicF56qBF
 4B9mucju4rcK0csrycfPt/eWe+s4yZj46oTkOeVhirfGs3p72iC6gGYkbuzmyQZYdVDv
 UsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dydAG4Kp/furYWpjUKbXSKvzV/lHaP5XQaTw5PF/fbg=;
 fh=70aWnbS2jVG8e4L4PCGEYeRItv4BtgihwaWgHpVXQ/Y=;
 b=jCEKViWB4vcHJdmOvZmt5cZGOJlOf3H95oEmbIOA8l47VKUxWFLOE4PkzogidSgW/3
 xTqyxik+WhPtza91g1A4TRspxEze0gsRSsUMuk96tWI/USKuus2jkkJrqAdAGdRScjy2
 +YRTWs5gPxjiJtm9k7Ud6GraWBJLOVTVGPzSlDxKHIy9nFKKComfc6kGi96BaxqhOTUv
 qwU36WTd8UjCQAPeVKWaSbiQ+GOkYecQ4pQR0HI8SA6i1KIHOMTcVe3TmN4K5gGwSCqP
 Jk38Y9wbrS6VhkcoeHwB+GwVZxomLcyw/h/afps+SXzXz3AC1zJ1OllP14DdeQusqk5r
 8dGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781156824; x=1781761624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dydAG4Kp/furYWpjUKbXSKvzV/lHaP5XQaTw5PF/fbg=;
 b=mk9z2rImw5DAAJjdoU4Q8tOOQHlsKIYWn8lZc21CdnxyqnIK8Ac/mqj3dfZY3LN2sW
 n49AywsFJwb3p23FKKf61a3GAh9Sf3i2K2y+9LA6GyBRVdpGFdLR2vW2kVpwP5TOb0g8
 kdC0hpJxXmn2tdt/xJ/93A3MMPz8rhBz5pD1YZZf+O28WyvxrxDoU17w3rTZ64w7gpFi
 sYyNdwPXeNGhGitWzs0xdMToEKS8+GBCvUJLDYwB0cZSzHT1VTfCb2aHYbcKnpzgTR97
 xDgu2U+Ms9/2r9KrGpBcEoY6iNY2br4kQhs1z2gZCEKkq/WmAgaPpT2GBkhhEpjoqmUj
 VV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156824; x=1781761624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dydAG4Kp/furYWpjUKbXSKvzV/lHaP5XQaTw5PF/fbg=;
 b=k5/zH6UeSQIZBBPbVwOPhW/DzMBdLL3zKyDzG56085Nz9A7Q7GGhxp8Qta2DTrUKvP
 ikb99XxT/2+b3QYT+F9m4BrXt9c3z0fFEVzICyFT2Z6uwWVBtKln5pCyMrNLYD8g5zPb
 3YDaV9zfBTuk3o5rzg67jmk1z4xGjIEiGmBxVe8+2rUTggyo8MJNl05e377q0T/bz0eL
 Cs8oUKn5XiGds584h/6XDe7C2plr3keD+uJR1n/Drt/5wmIb+8WxkRpOBTQKOmpZpVVm
 mQBEdtwQQQXQtTC1ye729ITRJi5nb4/ZiCrU7PUBfZQNMKaI/QTrFDqpaOg0meuZx4Vs
 G2uA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+j0X/cfQbLM5J4neK7NKMqFenorMsZLOAIGSQ14TqUjZ7iRwayvHTzxUG58km4wzabQ6KZ9g4HeVo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq7TOZxMaWpKGKdHRzZ2fLVwSJdpu0JepUVwp2/Jb4K0dsvkOl
 nLAZ4knyKUD1ZWYYUtICd2H32SZXf6KUf4cOeWBASukGmrTQCuEU4b9dZ86IeRzHD/SG5Xhbq3Q
 QVPCKimzeWw+eBbUZc+b3lDchXkuMKH4=
X-Gm-Gg: Acq92OFyA7MAJVwBnXCqNjfJtGhQFGty8fMfnEWcAOesxGHn0ZOkEioQra5q84d7/aU
 y+EljCGlPkGz8Z1APjz4Oiz6oHsCpRQrShpQNWjtHqw/W9MwZd33Ly90xIjRYh0Ji8HCYtdDc9f
 4tPOa2d2SEOJTpMn6C9w4RvP5WtCW2Eb6bZVEPQ/JvtdjYTK5aTIxRJ1iW2+HFcFiN3muLrJYIU
 JsdgUec54+R3lSyZtDkfTb7NbRZGMJQBdqZ0rp9PCOtht2RoCZrv0Ro5kUE2wgtsoYnoxML58yv
 /UOS4JkkO4ZtYcd1wslpdZO9CIaNUfyybt1951BJBi0DyT45OA==
X-Received: by 2002:a05:6102:2c85:b0:631:26f6:7016 with SMTP id
 ada2fe7eead31-71d5fdbe2aamr306752137.28.1781156824074; Wed, 10 Jun 2026
 22:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
 <178115560756.199930.11183711627429440356.b4-review@b4>
 <2877375c4efee4b4e816b418c965da7bd7d60992.camel@iscas.ac.cn>
In-Reply-To: <2877375c4efee4b4e816b418c965da7bd7d60992.camel@iscas.ac.cn>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Thu, 11 Jun 2026 13:45:45 +0800
X-Gm-Features: AVVi8CftH9gMkFhhJCSYeMYPI9Vx02SeuLOR5XN8R3F715RhJ4bH_68mrqI5Ug8
Message-ID: <CAH2e8h7oDLO4isyPOY3syEQLMrcCGiGmkKsAYvtEz+qoT9-N_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: himax,hx83121a: add
 optional bl supply
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

On Thu, Jun 11, 2026 at 1:36=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-06-11=E5=9B=9B=E7=9A=84 13:26 +0800=EF=BC=8CPengyu Luo=E5=
=86=99=E9=81=93=EF=BC=9A
> > On Tue, 09 Jun 2026 00:26:20 +0800, Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > > When the backlight is managed by the panel controller IC, an
> > > external
> > > power rail might be powering the backlight.
> > >
> > > Add an optional `bl-supply` property to describe such power rail,
> > > thus
> > > allow disabling the backlight.
> > >
> >
> > Please add it as a hwen pin, this will simplify your code later.
>
> I am not sure whether this should be a pin or a regulator -- the DT
> binding should reflect the HW fact, and LCD panel backlights usually
> require a high voltage (or even a current source) that is driven by a
> dedicated regulator.
>

Most backlight ICs use a hwen pin to enable the supply, afaik, like
ktz8866, ktz8868, aw99706, etc. We don't touch the VIN. (My disclaimer:
I am just an amateur, know less about the circuit)

Best wishes,
Pengyu

> Thanks,
> Icenowy
>
> >
> > >
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > > ml
> > > b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > > ml
> > > index e067a2f6d0b2..aeca3c9a599c 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > > ml
> > > +++
> > > b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > > ml
> > > @@ -40,6 +40,9 @@ properties:
> > >    vddi-supply:
> > >      description: power supply for IC
> > >
> > > +  bl-supply:
> > > +    description: power supply for backlight, in case it's managed
> > > via DSC
> > > +
> >
> > s/DSC/DCS/
> >
> > Best wishes,
> > Pengyu
>
