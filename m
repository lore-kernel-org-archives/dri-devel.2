Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E446C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926A310E143;
	Wed, 19 Aug 2026 13:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aPUasIj9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBB510E143
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:30:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30DAF43D6E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F4B1F00ADB
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787146243;
 bh=Wy+D+ESTTq/dSV8mhmm+rhMC+Crd5u0rz0n4yla+hGs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=aPUasIj9J9ETAKkXY+xz3TK125/aXZYjKzFmuOkfbiiU6/19xiRkGoYKKBAsT8WxR
 QBKYCqbs49DV3cgMcXgHT6zGootPM+lszjhmfFD9fcpQYefWkk1lRr56QoIqqH6iEN
 rC6xB0mB9mkb1GOgRBaXc5IY5EMSRj8qW60VDICji5wM+RBJQog6XmfZXcVUfrNZVL
 tI0TyZHQ+3I+wgbDVL/bPi+wsJQha090rSdqoQfAnpwtw64dUr2Wd12xOYZ93ECvLT
 4oLbcbZ+qzeRb0Yb/VtQi4oH7EvFBO6jE2r5JxA6u49vhaerF/9ndVpaKe6aShnILS
 GQJEhWHiA5uGg==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b021916bd3so1526888e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:30:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RomC56fQEns1B5IkAC2zA/jounDgEAqNfzof9mWBW8CpP6Cv9casgywrw+83Sif6m5P8geKT6zVfTY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziwINOAF37UrTjfjQOira8H98iZfHYDxyDmycaRMfv/awzZFvm
 yL+uKy9bao9oxmJJ5ImpIYW5dEOc7n03WBq77f1sOp5L3x8akflzz4mjhcVa5RikAKP9IBisOFJ
 dfTiscweyDMM6qq7mxXM3t6E19iuA8vE=
X-Received: by 2002:a05:6512:6d1:b0:5aa:5ef9:a33 with SMTP id
 2adb3069b0e04-5b478bdb85fmr1801632e87.25.1787146241774; Wed, 19 Aug 2026
 06:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
 <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
In-Reply-To: <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 15:30:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
X-Gm-Features: AcwNN1VzmKR08mtjCfHfPMShMvTxNHeVOcLQxu2aSZ4UbCwVZegKiNNfpCmjf24
Message-ID: <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org
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

On Wed, Jul 8, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:

> On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org>=
 wrote:
> >
> > Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nod=
es.
> >
> > Back the regulator enable state with the corresponding power domains.
> >
> > This is done for off-chip consumers: the corresponding voltage rails ar=
e
> > routed out so they are used for powering different peripherals using
> > these voltages as supplies.
> >
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
(...)
> > @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
> >                                 // DB8500_REGULATOR_VAPE
> >                                 db8500_vape_reg: db8500_vape {
> >                                         regulator-always-on;
> > +                                       power-domains =3D <&pm_domains =
DOMAIN_VAPE>;
>
> Hmm, isn't this the other way around? The power-domains node should
> have a regulator supply?

They probably have that, but that is not what this is about,
it's the other way around.

> We may even consider to skip to model the regulator altogether and
> make the power domain operate directly on the prcmu instead.

That is what the series tries to do, as a whole. Sorry if that was unclear.=
..

What we do in this patch is to deal with the fact that two of the power
domains, when enabled, also turn on two external power rails outside
of the SoC.

Since external components such as I2C devices cannot really be
claimed as "being inside a power domain" they take a regulator.

This is based on my understanding that power domains is an
SoC-internal concept only, so there is a clear boundary if something
outside of the SoC starts to use such an externalized power rail.

All this regulator does is to make sure the corresponding power domain
is enabled when the regulator is enabled.

I will repost all the patches once v7.3-rc1 is out.

Yours,
Linus Walleij
