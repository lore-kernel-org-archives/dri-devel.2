Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0CBC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D79810E9AF;
	Fri, 18 Sep 2026 19:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gm6qzNfW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA2110E9AF
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 19:52:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51E9744512
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 19:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D581F0089C
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789761129;
 bh=2aZ2SRdSwMAy6l7corBl6TSn3cdYhbUcwCmUTuq+Lz0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Gm6qzNfWy5SaEaZiWboTlhe73I5Y3sKUdV6dA1lzHfVwoETVwe+9hP7CmVBl37W43
 X8HruD8sWl9SRDFkfNmCHKrzypv+Oh0peVFrVCV026JEEP8+eguYm8Yy+gakSLDM+e
 h+m+fv9lnjTbvJ0rf5+NYRXRuQ5NW4+Vjc2dCMAq2MKfiznZQPeqnMlra/QJxE3iaC
 KzUnoA71jnKCeftkRbab5KjOcfPHnTV4eVW8WJUJwQFgArkQpF4yQyg/dR7XURkReL
 1QIjIi01Po7Ajp4zITvll8Yj5PdiraLijx4XpY+89UhP1uEzsw2oSatYZ9aWf2cc/X
 F/+VsHDt6R/cQ==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b899413537so1620589e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzAQPrZdw/FFvOOFwh2cOzf3IoinnhYcY/25ghEOb83f9w28sjqUPzrqhAKAFFl2+QMJozkqMOu/2Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kriqrcHMpA8svbYwb1ENkJxTH6ZJUW/3IsThXCP4YU6A05Zkic
 /mcVYTCCBdBUjiVjMQca+T7cUPN4Gc0EZ3gZMG62Y77s5R5g1xkNad6N5fwjCCzb3RFIDjViflS
 u6NdAuAVVlOJrK/1EYL27YiEciIcDod8=
X-Received: by 2002:a05:6512:a94:b0:5b6:183b:d1fb with SMTP id
 2adb3069b0e04-5b8c184918cmr1248231e87.34.1789761127739; Fri, 18 Sep 2026
 12:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-17-9d0c17e1f816@kernel.org>
 <aqhg8fCuVBqDvRrh@lizhi-Precision-Tower-5810>
In-Reply-To: <aqhg8fCuVBqDvRrh@lizhi-Precision-Tower-5810>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 21:51:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-_-a1ROYBYPo96Tp+qdUr2Ka=F1H0O=ngoqJ9wrqyqg@mail.gmail.com>
X-Gm-Features: AcwNN1VfgwBXDgi6e_-s2oKD27ppfBOu9eGlZ28XYdT8IngR0jAuGkn-SUSGs0s
Message-ID: <CAD++jLm-_-a1ROYBYPo96Tp+qdUr2Ka=F1H0O=ngoqJ9wrqyqg@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
To: Frank Li <Frank.li@oss.nxp.com>, Saravana Kannan <saravanak@kernel.org>
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

On Mon, Sep 14, 2026 at 11:02=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
> On Mon, Sep 14, 2026 at 01:54:45PM +0200, Linus Walleij wrote:

> >       if (base->plat_data->use_esram_lcla) {
> > +             np_lcla =3D of_parse_phandle(np, "sram", 1);
> > +             if (!np_lcla) {
> > +                     dev_err(dev, "no LCLA SRAM node\n");
> > +                     ret =3D -EINVAL;
> > +                     goto destroy_cache;
> > +             }
>
> sram is used at many place, is it good to put into
> drivers/of/property.c DEFINE_SIMPLE_PROP to avoid set up device link by
> each driver?

I have absolutely no idea if that is a good idea or how to
even use that macro.

But Saravana will know, so let's ask him!

Yours,
Linus Walleij
