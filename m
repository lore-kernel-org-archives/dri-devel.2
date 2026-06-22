Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CADCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CE810E779;
	Mon, 22 Jun 2026 16:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="E5OBftOJ";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547AE10E0C1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 16:15:45 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so50093015e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782144943; x=1782749743;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zRncht//PInKMEuS4sg5fyC0BItulGq5pVMOQvZq4OQ=;
 b=E5OBftOJeqAEtY+9eMOCZM8bNobGr8f+uaS/Sy+xcMFNLMi9vpWsYL9VOqS/OSgJUc
 HM0TvReTjoamqb6O85Ic+pIrRvvQtmnfx+hrnmxlxx22T5M8ONvBJLX90m8LF8hGScAw
 DpWojL+DVXc6eXb/lbklMGye882lsSXQID82h/byL1iHNuOSdH1lgHD92xcExO9nXzMK
 P0D43qSqO+9JCeWe6V/gG98DpxctNB3l4EmSLjUN5T0Um23RKrfmVMFPZ3c5+FIcz29V
 Fzh6CPhyvdszGDjtlX+BPsFeTKOZTSomzsS8sndkKwTDSx4nXEUR6nEgrkHwJYtD7Rcc
 g6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144943; x=1782749743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRncht//PInKMEuS4sg5fyC0BItulGq5pVMOQvZq4OQ=;
 b=RGSHaa8Gjjo3mDORY34/3nASUmvYRPn9RfRDxVqhmrqAmhwcoAHou+SytKpmb3qrSL
 0dtzikxszGyJTLuqR0yGRm0Jr80wmr0ZLBI9gkWTlwCi0yIuIiz3ZwQR1XSIAk7kFATv
 LgMruEifo8waNxIYg1nrYi6I/n4CfJR/+r9vXHYOeGpZWDEIq2T3CfXIOy1FdbDtcttZ
 kfarA/eBPdkx0nxmx/Q0yYf3Kl6JuR6DewDxtMnMT+7nwLsxbeT0Yl+z01ds71fvA4f8
 UEhPEfNXZfqIGth2q7MXBziCZlnqmBHDw6K0nJEWsGVsV+fm1DPPryKVaMJ3aMVJ0+tb
 VmlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kkso3LIzBg4eXUJV+XBzocwsoswVp6jK/7GYVo3OOcZ517eyyzHWhUkYAkCvgcictGXDYb3XQODY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5QkI2icp4J4NC8e6GK/8g/EisbMm62mhc0XG9CEsqJNzyYsVG
 SJD523QaFhC+fscj3Pri9Z7Pfz47nV5uDD5uzBkA7PgayBdlFEaks0xD/oSYmtGPXkc=
X-Gm-Gg: AfdE7cnuL/5PBuuHmYLmF3WkHWn6qjHPXh91pDcJbVq9zBN1kQrFk7u/wdDBW+JDzmN
 kSfLV95DxVLVNwmmVdv9dtQ+ArPfyA99p0yr36ceFOTdravcIG4reOFsIQkjpHOC1j7c8vFSZWH
 WnUZeYuUHzO0gFl1EOjXr1ZV7o6A8TxIFbpOq1dR2xp5YjO6l7FwIs7BJpWECs3W5FwcU3+5JWm
 8KZuvQj4sY68gEK0B0a4SevU9SgZVKiyAohdFnD51PSYhWTaeN6t7VXLm853Ln9cpEz+dw+KCld
 r2a2H/EHB/IrJJ2WNQzdWQ1DXwPJBdgYW5My8XMXD5058xow8kX4XrpVEZWMI+naqnNPnaESS5g
 5YxZ+zt0QrNKUzM8mmASkRuk2TC+8QlTHr8Qb9R0p+sxygdSk0hxmNHn1J7vv5HqefU5yKVFbCL
 dZfOftTsnpIs3GxAq5J9gdC5lcgmu+nA+X/XfMWwPq5/UErV4W533QaYL8uTEroC9uT6uCrFiC/
 IE=
X-Received: by 2002:a05:600c:628f:b0:490:bd66:e522 with SMTP id
 5b1f17b1804b1-49240e72434mr246625255e9.29.1782144943295; 
 Mon, 22 Jun 2026 09:15:43 -0700 (PDT)
Received: from localhost
 (p200300f65f47db040ad79c14d83edb3c.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:ad7:9c14:d83e:db3c])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-46667221da1sm27127062f8f.36.2026.06.22.09.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 09:15:41 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:15:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, Liu Ying <victor.liu@nxp.com>, 
 Adrien Grassein <adrien.grassein@gmail.com>,
 Peter Senna Tschudin <peter.senna@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Russell King <linux@armlinux.org.uk>, 
 Douglas Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Xin Ji <xji@analogixsemi.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Fei Shao <fshao@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <kees@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Message-ID: <ajlfiTxD8TwCu_1l@monoceros>
References: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
 <aimbWuKkPZdKuO5f@monoceros>
 <DJFNU4L6YNVS.2OXF28HEUNZO3@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y646ypfl4vteiwwb"
Content-Disposition: inline
In-Reply-To: <DJFNU4L6YNVS.2OXF28HEUNZO3@bootlin.com>
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


--y646ypfl4vteiwwb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
MIME-Version: 1.0

Hello Luca,

On Mon, Jun 22, 2026 at 04:50:06PM +0200, Luca Ceresoli wrote:
> On Wed Jun 10, 2026 at 7:15 PM CEST, Uwe Kleine-K=F6nig (The Capable Hub)=
 wrote:
> > On Mon, May 18, 2026 at 12:04:01PM +0200, Uwe Kleine-K=F6nig (The Capab=
le Hub) wrote:
> >> While being less compact, using named initializers allows to more easi=
ly
> >> see which members of the structs are assigned which value without havi=
ng
> >> to lookup the declaration of the struct. And it's also more robust
> >> against changes to the struct definition.
> >>
> >> The mentioned robustness is relevant for a planned change to struct
> >> i2c_device_id that replaces .driver_data by an anonymous union.
> >>
> >> While touching all these arrays, unify usage of whitespace in the list
> >> terminator and drop trailing commas there.
> >>
> >> This patch doesn't modify the compiled arrays, only their representati=
on
> >> in source form benefits. The former was confirmed with x86 and arm64
> >> builds.
> >>
> >> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> >
> > who feels responsible to pick up this patch?
>=20
> The affected files are mostly in drm-misc so I could apply it, but I think
> we'd need an ack from files belonging lsewhere (should be just nouveau and
> sitronix at quick glance).
>=20
> >> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> >> prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
> >> prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
> ...
> >> prerequisite-patch-id: 915b7a2276c5a38944107c84bb282271d0bf28f4
> >> prerequisite-patch-id: 76d499a624150588f7ef07dc087e70eca6f33419
> >
> > FTR: These are bogous, there are no dependencies, I just wasn't
> > attentive enough to drop these lines.
>=20
> And 'b4 shazam' messes up because of these lines.
>=20
> Overall I think it's better if you resend after splitting by tree, and
> removing the prerequisite-patch-id lines. You can keep my R-by on all the
> patches if you just split them without further changes.

Thanks for considering to merge, will rework as suggested.

Best regards
Uwe

--y646ypfl4vteiwwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo5X6oACgkQj4D7WH0S
/k7aZAgAgxwaByetfG1d2X9atyXsHeGlCD55Pa/o1ew5duFQnVUaJvcNEbVOSZz+
v0V/9dVyvNdjtGDK5wSDDEBle2RShIvlf03cFHzxv5+2JujQYFFyL9KdAfPzgD4F
u4JUNJ2tRoP8FKGjRrXfssn1nYDjF7CNf0uO7gBiA+gLqxixduOncPUKGDZ6aFyr
vM4ndnOVMHZODdxv5jMZmpOfHDccoTViPQTaIo5B+/z7P36XleQvKA5rXc5lZDOK
/rK3pfF/ns3LNa8qnfBbE415HX4DQT5KjLfETJjhxDUMrwQWZrcjGXqQuNscdIjY
MXDXgyQ87eH6Os6E/yY2h51+U5vUlw==
=YE6V
-----END PGP SIGNATURE-----

--y646ypfl4vteiwwb--
