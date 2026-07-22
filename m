Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9CEC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105EB10E3F8;
	Wed, 22 Jul 2026 01:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OOyBVgs7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199F310E3F8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:30:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B01DB406AB;
 Wed, 22 Jul 2026 01:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB41F000E9;
 Wed, 22 Jul 2026 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784683845;
 bh=uG4Kz4uliUZ5KVz+j/aepLp9XaY4xs8RaE90LkqBj5o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=OOyBVgs76bsXIjzqTECEkkcxjJTnlg052XBUnPuATmEhVkFxyHQhR1d04dOqAtIKg
 vhxL1t6En1dmL9qgJ70naRI1hPQw//SKtdumrR30iBszJIPRNuSuESoYdV/pxGdkh+
 u1VAj8PKIrhDyvB4Wz5FDHWyt+v220YFbMLXMhYyRaC30ec9YnwuCh9tLcii+/LThe
 AHiHpuOs44EYiOkmSU6S0hWaZIKJ/jYBKTxPsvC44ef+LS0C8n3G74T2hrHsnRYNbA
 96Y2dbOFG0lmuxRwEvlt5eYIQ4fPC4G/e1C44ZL1Ws7GM0ehxw0SUOeBz+q1YfLQF4
 1R7+3mPqUE0ow==
Date: Wed, 22 Jul 2026 02:30:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Lee Jones <lee@kernel.org>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel
 Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Helge Deller
 <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260722023037.776f4bcb@jic23-huawei>
In-Reply-To: <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-9-clamor95@gmail.com>
 <akeXAOpb13hupUGM@hovoldconsulting.com>
 <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 14 Jul 2026 16:57:01 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:03 Joh=
an Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Jun 17, 2026 at 11:00:25AM +0300, Svyatoslav Ryhel wrote: =20
> > > Since there are no users of this driver via platform data, remove the
> > > platform data support and switch to using Device Tree bindings.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for bac=
klight
> > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > -     iio_device_set_parent(indio_dev, pdev->dev.parent); =20
> >
> > Why are you reparenting the iio device here?
> > =20
>=20
> Because every cell has its own binding now and using phandle to parent
> when device has its own node is not a good practice.

It is however a good point.  So should at very least the ABI break should
be called out in the patch description with a brief mention of what the
path change actually is.

>=20
> > That's an ABI break.
> > =20
>=20
> This driver does not have any active users in the kernel and no
> activity for more then 2 years.

...

> > > +     u32 count =3D 0, reg, nchilds; =20
> >
> > Don't mix multiple declarations with initialisation like this.
> > =20
>=20
> Checkpatch does not complain on style issue, hence this is not prohibited.

Prohibition vs taste.  I fully agree with John on this one!  Those mixes are
messy and hard to read.

Checkpatch is a helpful tool but there are both rules and preferred style t=
hings
it does not catch.

Jonathan

>=20
> > >       int ret;
> > >
