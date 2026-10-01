Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84883CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB3010E2BA;
	Thu,  1 Oct 2026 07:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VdNj1j0Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2D810E2BA
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:05:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D93EF601FE;
 Thu,  1 Oct 2026 07:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CEE1F000FF;
 Thu,  1 Oct 2026 07:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790838306;
 bh=fcQ2y1wc6VRCd4OgMADXevuJLq2I1HVoXkWDblKuYWU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VdNj1j0Z2VqDtl/ZO9MIS6QjdZKZpMIEE3F5hihWOY19PVAeBxcvRrd7Dhvy9N6Dr
 EMg4Vze/EWbPMklL96eMj9p7tWXCbE4ivn5EiWvUOK5pClViP+fdAMNI0mtjmI3gTI
 CHnBvUeZ2Q6gmlgKvg9KUmq/RzHjznaH3Bbdga/Ahc0rvFxAS+Jj+9DCOpjmZSraLz
 nVtDW2O+bzCRITrShZ+JpQQqXSrK8XOnfYnj7Tzo5N+Xc7EjjqQtDI4d1NGQdX5Wze
 LXbuvSmTtj/BEwiydFeRs3oPPYZgqiSFcURqC6rfAvvRvM6YMqhkDqSqtmgNJY9NR6
 5/VI+13AADiJQ==
Date: Thu, 1 Oct 2026 09:05:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
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
 linux-arm-kernel@lists.infradead.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <ar4FOkG58Efmyo99@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
 <6c581ae0-2480-47a2-b46e-97afadbc7c1f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="4fvfqvnrglbwmlpj"
Content-Disposition: inline
In-Reply-To: <6c581ae0-2480-47a2-b46e-97afadbc7c1f@linaro.org>
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


--4fvfqvnrglbwmlpj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 04:01:52PM +0200, Neil Armstrong wrote:
> On 9/29/26 11:03, Jani Nikula wrote:
> > On Mon, 28 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> > > Panels in general, and MIPI-DSI panels in particular, are pretty
> > > difficult to support and require pretty much a panel driver for each
> > > panel produced. Most of them are pretty simple, and require an opaque
> > > initialization sequence that is usually poorly documented.
> > >=20
> > > This creates a tension between OEMs and distros because OEMs will
> > > typically get a new panel to react to a sourcing issue during
> > > production, and thus need some swift turnaround between getting their
> > > new panel and it being operational in the OS. Distributions on the ot=
her
> > > hand can take years to ship a kernel with that new panel driver.
> > >=20
> > > To solve this, I followed the example of HID-BPF and wrote a panel
> > > driver that will rely on BPF programs to perform the panel
> > > initialization. That way, we can ship the programs separately from the
> > > kernel, and with a different lifecycle. If this driver is accepted, t=
he
> > > plan is to have a userspace component started by udev to identify and
> > > load the right BPF program for the panels found on the device.
> >=20
> > I'd think for most panels it would suffice to have a declarative
> > language describing what to do at what points in time. For example, at
> > poweron, enable this GPIO, wait a little, write this set of DSI
> > commands, etc. You rarely need actual programming, or even ability to
> > read-modify-write something.
>=20
> Yes we could have a similar panel-simple but with init tables, but
> in reality those panels offers much more features we don't handle because
> the DDIC vendors and panel integrators just don't care exposing those
> features, but they get handled by vendor implementation like for Phones.

It's kind of what we already do. It somewhat works, but doesn't address
my problem.

> > It could be, say, YAML converted to some binary representation. Maybe
> > that could be in the DT, or maybe you could override it with the
> > firmware loader. And obviously any vendor "blob" could be trivially
> > converted back to YAML and upstreamed.
>=20
> I don't think we want this, downstream vendors does that and we don't want
> to go there.
>=20
> >=20
> > Where that falls short, you could always have a dedicated driver, or
> > extend the declarative stuff.
> >=20
> > Now, the question is, how much more BPF solves over that, without
> > requiring a dedicated driver, and is the added complexity worth it?
>=20
> This is my global question, and this is what I'm evaluating here, and so
> far is created more problem that solutions.

Great, more judgmental stuff. It's a v1 that hasn't been merged yet.
What problems did it create exactly, and for who?

> > FWIW, on the Intel platforms that support DSI, all of the
> > initialization, poweron/poweroff, backlight on/off etc. sequences like
> > that are stored in the BIOS, defined by the OEM. A plethora of DSI
> > panels, one driver. Don't look at it for examples how to implement it,
> > but I think the basic idea is workable.
>=20
> For _some_ panels, here, as a general solution no because we really
> want to have full support for panel features.

The only one who claimed it was a generic solution was you. I've been
pretty clear from the very beginning that I wasn't expecting it to be a
one-size-fits-all solution.

So if you want to review your idea of what this driver is, fine, but
keep me out of the recipient list.

Maxime

--4fvfqvnrglbwmlpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4GHgAKCRAnX84Zoj2+
dn3UAX9cj8V5XOZnckDiSXI52zwz3hS723YGZhAt7H9G2vCH5gpnzt9rN3xy+o/5
NNhj5qoBgIw5OCgp6Tzq7BOrsSw2VfeymLcVpDw4SIUcWZ8fL19/9rqg1h7cxBiY
4UA1G5YUJw==
=rmnt
-----END PGP SIGNATURE-----

--4fvfqvnrglbwmlpj--
