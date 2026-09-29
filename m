Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14069CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7407210E07F;
	Tue, 29 Sep 2026 07:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U+BO6Q9/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C9C10E07F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D50B660210;
 Tue, 29 Sep 2026 07:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D911F000FF;
 Tue, 29 Sep 2026 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790666823;
 bh=c2C/eVtAJPpjMYDLNwQibSrOlOhibS0dGw/VMLKUe3Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U+BO6Q9/X08aLazZhmJKUWRGrmjj+Snm4vmwY09KdDXNKy0CeH88HD15e/T1wMBOV
 35UauizxtojbWrKfrEFN7w+FfGso44H61e35C7lMDcGAtssEtKbbfEQ4nrUTd3eXVD
 gLf8fXYqi1N+UaXw93NJzh/e73uY0W5hB7RFpG4e5KiaRvKnkB1Q7fPie1Qw0C7HFC
 NiawgI8jEPDocDiE3T7sUTqwZcAqNzg5v99hVtNFiSrfQTvdPI8gyvQrA2RGg05+vr
 z2UTwUB4fW60fzsg8yPP29R6BttDkBiQz56CL1Lxf1Y+KfgSJV6jeKlt9OlvMLrTV4
 5e+4XWjij65Zg==
Date: Tue, 29 Sep 2026 09:27:00 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
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
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <artlIYhgbskRJXDQ@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="nstt4rbbt4m4mdpf"
Content-Disposition: inline
In-Reply-To: <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
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


--nstt4rbbt4m4mdpf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 09:20:12PM +0200, Neil Armstrong wrote:
> On 9/28/26 19:24, Benjamin Tissoires wrote:
> > On Sep 28 2026, Neil Armstrong wrote:
> > > Hi,
> > >=20
> > > On 9/28/26 18:22, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
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
> > >=20
> > > >=20
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
> > >=20
> > > >=20
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
> > >=20
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
> > > On this point, DDIC _are_ bridges, but in the current panel API we bl=
ur the line between
> > > the panel and the DDIC. So being a bridge is fine, but in a general w=
ay we lack
> > > a proper way to describe the display/panel/monitor independently of t=
he DDIC.
> > >=20
> > > At first glance it's a nice driver, but moving the timings into a blo=
b moves something
> > > into possible proprietary binaries with possible closed licence and d=
istribution
> > > restriction so it's a downgrade for the same of bringing up a panel f=
aster.
> >=20
> > Quick answer on this, because I had the very same questions regarding
> > HID-BPF:
> > - in BPF, you can require (and by default it does) that only GPL
> > 	compatible BPF programs are loaded, closing the argument of "closed
> > 	licence and distribution restriction"
> > - also, a BPF program can be disassembled much easier than a binary
> > 	blob, and I remember Alexei showing me an example where you get almost
> > 	the source code from the BPF object in just one pass.
>=20
> Right, it "solve" one of my question, but doesn't really solve the issue
> of vendors providing "GPL" bpf programs with source available "somewhere".

Would you be ok if I was to make a tool to decompile a BPF program into its
source file equivalent?

> Another big issue is the API, I don't want to keep the current API as-is,
> we plan to support more advanced panel features and use try to use the
> atomic states to support rate switching for example, and I'm not confident
> it's a good idea since there's no "simple" and "forever valid" API
> to initialize panels...

So, a couple of things here. First, I really don't think we should
extend the panel API, like at all. But let's discuss that at Plumbers, I
don't think it's very relevant to this discussion anyway.

Second, you don't have to use this driver, like, at all. For anything
more complicated than what this driver can provide, I totally expect to
still merge dedicated panel drivers if it makes sense. I also expect
that this driver would be enough for 90% of our panel drivers and
would allow us to support most of the cruft.

Finally, the BPF API is flexible. You can extend it later on and old
programs would still work. The verifier would fail only if a program
uses a new function in a kernel that doesn't support it. I was kind of
expecting to put drm_display_mode in there at some point, if the state
makes sense then why not.

Maxime

--nstt4rbbt4m4mdpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCartoQwAKCRAnX84Zoj2+
dtp2AYDqEryYzoPxdZ0pP0QpPZFfX3gKsTQtb0FXlWyICU6KGPBCCAuKMYFJRLHL
EXEyYZYBgNINSL3vSxMjOnTdTOBwGIGO7iXBZhJuZPS9DZO3C/TaZk7LCjj9P+uG
pQo0MpI0BA==
=BzAp
-----END PGP SIGNATURE-----

--nstt4rbbt4m4mdpf--
