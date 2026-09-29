Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B252CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D2110E462;
	Tue, 29 Sep 2026 12:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDgs52RD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7986F10E462
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:28:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41171412B1;
 Tue, 29 Sep 2026 12:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E61F000FF;
 Tue, 29 Sep 2026 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790684927;
 bh=Rya2/xvwmnG+LUNaAktFCoDG7sJ7+awgSLfG71+jbJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KDgs52RDTx6mh31I7eMF9UWgZiSg1uUMHsWF7NmqCu8jGXUdqsG5RRco4NAQ1yybk
 xQ+m+bbw1/UwtG3KjfgwVgTA5CaoLUfvpIS8lFDoTctzuu7VSyBxeowIx5ueXoinnE
 8tKck5octUTdRzH9FOQQ5rKCVgLBSz3czzpqXIl3DCc+gA8SVFh5ujozuK/cQlWlr3
 laRfPA3ooCYxIdbhJVJPI51VwDjiItiCpStTQWukUYuWtEtyJAROcrFDWye7LIwjKJ
 BEx8eFAfDOOrw/HeBkx0lBbtw4Jx8mATUrz9BoFpYrTbqm0g4vGPopfAaieDMB8Iyg
 sD/aDTz9tWV9g==
Date: Tue, 29 Sep 2026 14:28:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <arut8kWzqX5YW5wE@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
 <aruD5kwOEsvFhW2e@beelink>
 <42cfa3fb2246c66d69e45d7d9b8d6aaadc0da4c4@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="tn7gfu35hmfimxib"
Content-Disposition: inline
In-Reply-To: <42cfa3fb2246c66d69e45d7d9b8d6aaadc0da4c4@intel.com>
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


--tn7gfu35hmfimxib
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 01:16:41PM +0300, Jani Nikula wrote:
> On Tue, 29 Sep 2026, Benjamin Tissoires <bentiss@kernel.org> wrote:
> > Ouch. This immediately raises the "let's implement a parser in the
> > kernel" flag, or "let's create a new langage".
>=20
> Fair.
>=20
> > You'd still need a dedicated driver for your new blob parser, with far
> > fewer people who had had a look at it than BPF who has been working on
> > for several years.
>=20
> Fair.

Also, it's kind of what we had with panel-mipi-dbi:
https://github.com/notro/panel-mipi-dbi/wiki

It didn't really take off.

> > The integration of BPF and the kernel is honestly transparent nowaday:
> > calling a struct_ops BPF function is just a function call away, and from
> > the bpf calling anything in the kernel is also just a call away.
>=20
> I don't know if I'm just being overly conservative here, but it seems to
> me BPF provides too much flexibility for the use case. But maybe the
> point is completely moot, and you should just ignore me. ;)
>=20
> > See Maxime's answers: yes, falling back to dedicated driver is still
> > encouraged.
>=20
> [Moved the above to go with below.]
>=20
> > Isn't that what Maxime wants to have? One driver for a plethora of DSI
> > panels, with the same ability the BIOS has to also do function calls to
> > set things up?
>=20
> I suppose this is something that could use some clarification. Is the
> idea that most (simple) dedicated panel drivers eventually get converted
> to BPF?

I don't think most of the existing panels will be converted, if only
because it would require a different DT binding for most of them. We
should totally fix the "what happens the panel is supported by a driver
and the bpf driver" situation Rob (I think?) pointed out though, because
I do think some will be converted still.

> Or is the idea that BPF is easy for prototyping and development
> using stable kernels and short time to market, and most of them would
> eventually get converted to dedicated panel drivers?

Even though it does make prototyping easier, I totally expect this to be
a production-grade driver, just like any other panel driver.

> The story wrt display before userspace is up and running also needs
> clarification.

Yeah, I'll work on an in-kernel loader for v2.

Maxime

--tn7gfu35hmfimxib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaruu+wAKCRAnX84Zoj2+
dvaDAYDbgFmn3VTPnwMmRkcBxrTVtKlQ2i2nTFTQqsY6+h83dQfdgZBSKyv4PaD8
t21q8pIBgLJeTlsC72CRcfaSgL7zPCcpR02uuJQEdtsW57i6k17jJYgTCB0r9j+y
8X+t6kZwEw==
=GOdP
-----END PGP SIGNATURE-----

--tn7gfu35hmfimxib--
