Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FECCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9C510E246;
	Thu,  1 Oct 2026 06:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S2oAAim+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8C910E246
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:48:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BF65601F6;
 Thu,  1 Oct 2026 06:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA01F000FF;
 Thu,  1 Oct 2026 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790837301;
 bh=oTPiNK1ijgqqieTLDnk5gsI3qKTkeHbyJgaO+3TPCaM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=S2oAAim+ZNN1UcFWk7JwFJyWhJfmpAkwn9wIrUXnc9gDsyIOrLMMP59x1ylVtpqpG
 pTzdfwm1Uhh/acqjNDV1CVJMYuTJYmAjDf9E+SaTmVAb5hSpsIrSsnEH5/UHX3mkB2
 xFytObp+UzIjfucg0Wd4tDrA3T+ZnqzroP3taQyRabiYXpyzMfYmDpwFtpoSMEoWGb
 ixwuV70lKjFBRPQ+ayaT78Xkp/1CRw8RUvQUCWunq7zOc6OU9l/EEA+EdaVFg06I5p
 A/YT+UVWignazMIbm71xq98Jtz3/PTH/rV6rwOrMuEjSMz8mVSuk8M7xP56UdsDyez
 UDFp3UPZJuXEQ==
Date: Thu, 1 Oct 2026 08:48:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
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
 linux-arm-kernel@lists.infradead.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <ar4ADESgOoIx4F5d@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <artgrTe6wvKxnUOG@houat>
 <c75feb5d-055d-403a-8dba-3c187cdb8e7d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="xylhezw3t3zffshi"
Content-Disposition: inline
In-Reply-To: <c75feb5d-055d-403a-8dba-3c187cdb8e7d@linaro.org>
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


--xylhezw3t3zffshi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 03:46:04PM +0200, Neil Armstrong wrote:
> On 9/29/26 09:13, Maxime Ripard wrote:
> > Hi Neil,
> >=20
> > On Mon, Sep 28, 2026 at 06:39:58PM +0200, Neil Armstrong wrote:
> > > On 9/28/26 18:22, Maxime Ripard wrote:
> > > > Panels in general, and MIPI-DSI panels in particular, are pretty
> > > > difficult to support and require pretty much a panel driver for each
> > > > panel produced. Most of them are pretty simple, and require an opaq=
ue
> > > > initialization sequence that is usually poorly documented.
> > > >=20
> > > > This creates a tension between OEMs and distros because OEMs will
> > > > typically get a new panel to react to a sourcing issue during
> > > > production, and thus need some swift turnaround between getting the=
ir
> > > > new panel and it being operational in the OS. Distributions on the =
other
> > > > hand can take years to ship a kernel with that new panel driver.
> > > >=20
> > > > To solve this, I followed the example of HID-BPF and wrote a panel
> > > > driver that will rely on BPF programs to perform the panel
> > > > initialization. That way, we can ship the programs separately from =
the
> > > > kernel, and with a different lifecycle. If this driver is accepted,=
 the
> > > > plan is to have a userspace component started by udev to identify a=
nd
> > > > load the right BPF program for the panels found on the device.
> > >=20
> > > This is kind of late for serious applications except if we manage to
> > > solve the bootloader to Linux display engine transition.
> >=20
> > Virtually all "generic" distributions are shipping the panel as modules
> > today anyway, because anything else is nothing but impractical. But
> > maybe you don't consider them serious enough. Also, applications live in
> > userspace already, so can be ran after this driver would be initialized
> > anyway.
>=20
> So what would this exactly solve ? keeping out-of-tree BPF driver + bindi=
ngs
> driver forever and never upstreaming then ? Is this what we really want ?
>=20
> >=20
> > > > This driver is fully functional and works with both 5" and 7" Touch
> > > > Display 2 panels for the RaspberryPi. However, it breaks away from =
the
> > > > typical panel driver in multiple ways:
> > > >=20
> > > > - BPF programs can only be loaded by userspace. This leaves us with=
 two
> > > >     choices:
> > > >=20
> > > >     * We prevent the driver from loading until the script itself is
> > > >       loaded. This has the side effect of preventing any other outp=
ut to
> > > >       be used until the initramfs is ran at the earliest, and possi=
bly
> > > >       ever if the loader isn't installed for example.
> > >=20
> > > This adds a dependency on user-space behavior and if somehow the
> > > initramfs doesn't load for a reason we won't have a way to display
> > > an error.
> >=20
> > Yes, if an error happens before the DRM driver loads, it won't be shown
> > on the screen. This is already the case for any panel driver today on
> > any major !embedded distribution. And with built-in drivers, this can
> > also happen before or while the DRM driver loads.
> >=20
> > The solution is always the same though: load simpledrm first, move to
> > the proper DRM device once it's functional. It still works with this
> > solution.
>=20
> Module !=3D bpf programs, maybe one day it will change.

I have exactly zero idea what your point is here. You were saying that
it's bad because panels get to probe later now and you wouldn't see an
error. I'm saying it's already what happens today with a significant
part of the install base and doesn't seem to bother you.

I'm not talking about BPF programs themselves, I'm talking about your
double standard.

> > > >     * Or we probe the driver all the time, but only report it as co=
nnected
> > > >       once a program has been registered. This is somewhat unconven=
tional,
> > > >       but allows the other outputs to be functional, *and* allows t=
he user
> > > >       to force the output if their panel doesn't require any
> > > >       initialization or during debugging. I chose this solution.
> > >=20
> > > Both options are not really great...
> >=20
> > Feel free to make any suggestions
> >=20
> > > >=20
> > > > - It's not a panel driver, but a bridge one, which is also pretty
> > > >     unconventional. This is required because panel drivers don't ha=
ve
> > > >     access to a detect callback that is required for the above, but=
 I also
> > > >     think that the recent work from Luca blurs the line from panels=
 and
> > > >     bridges and we'll end up going that road anyway.
> > >=20
> > > On this point, DDIC _are_ bridges,
> >=20
> > I have no idea what a DDIC mean.
>=20
> The DDIC is the Display Driver Interface Controller, basically the
> IC which received DSI packets and physically drives the display.
>=20
> It's basically a bridge to the panel, and this is mainly what we program.

I've been writing panel drivers longer than you did, there's no need to
be patronizing.

> > > but in the current panel API we blur the line between the panel and
> > > the DDIC. So being a bridge is fine, but in a general way we lack a
> > > proper way to describe the display/panel/monitor independently of the
> > > DDIC.
> > >=20
> > > At first glance it's a nice driver, but moving the timings into a blob
> >=20
> > Let's not kid ourselves, it's *already* a blob. We just sugar-coated it
> > enough that we can be happy and call it GPL.
>=20
> It's the case for most drivers, but since we don't get proper
> documentation we're stuck using registers list and can't
> implement advanced features. And moving this to a bpf won't solve
> but enhance the problem by a large factor.

How? You keep saying those broad, alarmist statements. Look at the BPF
examples I provided. *How* is it "making the problem worse by a large
factor" exactly?

Just like I said to Rob, I don't mind changing that driver to accomodate
your fear or anxiety. But "this is shit" isn't a review, it's abusive
behaviour. If you plan on continuing that trend, don't.

> > > moves something into possible proprietary binaries with possible
> > > closed licence and distribution restriction so it's a downgrade for
> > > the same of bringing up a panel faster.
> >=20
> > We can already make a proprietary, out-of-tree, panel driver today. That
> > being said, the only license we allow for BPF programs here is GPL, so
> > if anything it would be less of a concern for this than it would be for
> > regular panels.
>=20
> So you're on to facilitate keeping panel driver out-of-tree and never
> upstream them ? this is awkward TBH.

Hahahaha, yeah, sure. I don't care about upstreaming anymore and just
want to scorch-earth the entire kernel to have an excuse to retire and
do goat farming. You got me.

However, given the current state of this discussion and the intention
you're giving me, it does sound appealing.

Maxime

--xylhezw3t3zffshi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4CMQAKCRAnX84Zoj2+
dsKJAYDegBJXjN+DAIL+zFTw7NMWESWe1rT4wG/kSYCXb2ykCFMpoNvFPAczuyY3
BveNkdgBgIbDXFAFc4WfspVAtEoMIh5QoJ6lGdHtAgVkVxhB2ZTLGnqTj1aS6ZvV
TMcKW9VWrA==
=Rwjh
-----END PGP SIGNATURE-----

--xylhezw3t3zffshi--
