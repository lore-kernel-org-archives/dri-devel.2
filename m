Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06709CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D66910F596;
	Thu,  1 Oct 2026 07:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lp7ep3St";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7842410F596
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:01:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C74843987;
 Thu,  1 Oct 2026 07:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96BC1F000FF;
 Thu,  1 Oct 2026 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790838064;
 bh=KS0Ss/ffTJUp5L49rLpdU43wb6+7z7lGoeJJi6W0x3M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Lp7ep3StOohbLecY2bxsRKPlsyxwPZfsGjFriRa7GH7Nfor7FnoL75V0NjDj+zOvd
 Y9t9D6A7+m5aTs/Sqz9t9LWMcr5BcY0JM6d2NUmPsI2QTXaAOQfHJgPoslvv0/tNpx
 Cx39zhzVS8o1qi3wjpFQoxtVq64z+KgWcDXHC7zSI1OWkt+VD7g+GcxYlkP4Z9bwIV
 tVDvkYjaL/SDbQhOuIcNbi9HtP8RehenrFceEPX82uX36A313KnmeYWoXjaL2RqxTU
 +cZ7rFe4V9yoavp9cAp9Xl/NO7hI1ETfYBKgQowxS+PoVHPxJlnEfICZIDYTGxDumw
 +LkDLNqgJhpfQ==
Date: Thu, 1 Oct 2026 09:01:01 +0200
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
Message-ID: <ar4C329Cm5hzB3kH@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <artlIYhgbskRJXDQ@houat>
 <27bc999f-ef3a-450d-a4ea-57ac45508705@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="bnu55xk7ah7f6vwr"
Content-Disposition: inline
In-Reply-To: <27bc999f-ef3a-450d-a4ea-57ac45508705@linaro.org>
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


--bnu55xk7ah7f6vwr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 03:49:12PM +0200, Neil Armstrong wrote:
> On 9/29/26 09:27, Maxime Ripard wrote:
> > On Mon, Sep 28, 2026 at 09:20:12PM +0200, Neil Armstrong wrote:
> > > On 9/28/26 19:24, Benjamin Tissoires wrote:
> > > > On Sep 28 2026, Neil Armstrong wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 9/28/26 18:22, Maxime Ripard wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > Panels in general, and MIPI-DSI panels in particular, are pretty
> > > > > > difficult to support and require pretty much a panel driver for=
 each
> > > > > > panel produced. Most of them are pretty simple, and require an =
opaque
> > > > > > initialization sequence that is usually poorly documented.
> > > > > >=20
> > > > > > This creates a tension between OEMs and distros because OEMs wi=
ll
> > > > > > typically get a new panel to react to a sourcing issue during
> > > > > > production, and thus need some swift turnaround between getting=
 their
> > > > > > new panel and it being operational in the OS. Distributions on =
the other
> > > > > > hand can take years to ship a kernel with that new panel driver.
> > > > > >=20
> > > > > > To solve this, I followed the example of HID-BPF and wrote a pa=
nel
> > > > > > driver that will rely on BPF programs to perform the panel
> > > > > > initialization. That way, we can ship the programs separately f=
rom the
> > > > > > kernel, and with a different lifecycle. If this driver is accep=
ted, the
> > > > > > plan is to have a userspace component started by udev to identi=
fy and
> > > > > > load the right BPF program for the panels found on the device.
> > > > >=20
> > > > > This is kind of late for serious applications except if we manage=
 to
> > > > > solve the bootloader to Linux display engine transition.
> > > > >=20
> > > > > >=20
> > > > > > This driver is fully functional and works with both 5" and 7" T=
ouch
> > > > > > Display 2 panels for the RaspberryPi. However, it breaks away f=
rom the
> > > > > > typical panel driver in multiple ways:
> > > > > >=20
> > > > > > - BPF programs can only be loaded by userspace. This leaves us =
with two
> > > > > >      choices:
> > > > > >=20
> > > > > >      * We prevent the driver from loading until the script itse=
lf is
> > > > > >        loaded. This has the side effect of preventing any other=
 output to
> > > > > >        be used until the initramfs is ran at the earliest, and =
possibly
> > > > > >        ever if the loader isn't installed for example.
> > > > >=20
> > > > > This adds a dependency on user-space behavior and if somehow the
> > > > > initramfs doesn't load for a reason we won't have a way to display
> > > > > an error.
> > > > >=20
> > > > > >=20
> > > > > >      * Or we probe the driver all the time, but only report it =
as connected
> > > > > >        once a program has been registered. This is somewhat unc=
onventional,
> > > > > >        but allows the other outputs to be functional, *and* all=
ows the user
> > > > > >        to force the output if their panel doesn't require any
> > > > > >        initialization or during debugging. I chose this solutio=
n.
> > > > >=20
> > > > > Both options are not really great...
> > > > >=20
> > > > > >=20
> > > > > > - It's not a panel driver, but a bridge one, which is also pret=
ty
> > > > > >      unconventional. This is required because panel drivers don=
't have
> > > > > >      access to a detect callback that is required for the above=
, but I also
> > > > > >      think that the recent work from Luca blurs the line from p=
anels and
> > > > > >      bridges and we'll end up going that road anyway.
> > > > >=20
> > > > > On this point, DDIC _are_ bridges, but in the current panel API w=
e blur the line between
> > > > > the panel and the DDIC. So being a bridge is fine, but in a gener=
al way we lack
> > > > > a proper way to describe the display/panel/monitor independently =
of the DDIC.
> > > > >=20
> > > > > At first glance it's a nice driver, but moving the timings into a=
 blob moves something
> > > > > into possible proprietary binaries with possible closed licence a=
nd distribution
> > > > > restriction so it's a downgrade for the same of bringing up a pan=
el faster.
> > > >=20
> > > > Quick answer on this, because I had the very same questions regardi=
ng
> > > > HID-BPF:
> > > > - in BPF, you can require (and by default it does) that only GPL
> > > > 	compatible BPF programs are loaded, closing the argument of "closed
> > > > 	licence and distribution restriction"
> > > > - also, a BPF program can be disassembled much easier than a binary
> > > > 	blob, and I remember Alexei showing me an example where you get al=
most
> > > > 	the source code from the BPF object in just one pass.
> > >=20
> > > Right, it "solve" one of my question, but doesn't really solve the is=
sue
> > > of vendors providing "GPL" bpf programs with source available "somewh=
ere".
> >=20
> > Would you be ok if I was to make a tool to decompile a BPF program into=
 its
> > source file equivalent?
>=20
> Not really, I don't see the point TBH.

Cool, another moving goalpost then.

> > > Another big issue is the API, I don't want to keep the current API as=
-is,
> > > we plan to support more advanced panel features and use try to use the
> > > atomic states to support rate switching for example, and I'm not conf=
ident
> > > it's a good idea since there's no "simple" and "forever valid" API
> > > to initialize panels...
> >=20
> > So, a couple of things here. First, I really don't think we should
> > extend the panel API, like at all. But let's discuss that at Plumbers, I
> > don't think it's very relevant to this discussion anyway.
>=20
> It is, and I'll expose why we need to get out of this deprecated API
> as soon as possible, we are seriously keeping the ability to provide
> support for advanced panel features which are implemented in vendor
> kernels.

I guess I'm not the one working on out-of-tree panel drivers then. But
yeah, I don't dispute that statement.

> The API was ok when DSI was added and we didn't have generalized atomic
> modesetting, why would you not want panels to embrace atomic ?
>=20
> I don't understand, please elaborate.

Again, you're putting words in my mouth. I never said I don't want
panels to embrace atomic. I said we shouldn't extend the panel API, I
told you twice what I meant exactly by that:

https://lore.kernel.org/ksummit/20260604-grinning-determined-falcon-0e8b01@=
houat/

> I acknowledge it might sound a bit like "let's burn the whole thing to
> the ground", but what you just described sounds an awful lot like what
> the bridge API already does.
>
> Let's acknowledge that drm_bridge isn't just about bridge anymore, make
> panels bridges, and we're done.

https://lore.kernel.org/dri-devel/20260928-drm-mipi-dsi-panel-ebpf-v1-0-524=
4926aace4@kernel.org/

> It's not a panel driver, but a bridge one, which is also pretty
> unconventional. This is required because panel drivers don't have
> access to a detect callback that is required for the above, but I also
> think that the recent work from Luca blurs the line from panels and
> bridges and we'll end up going that road anyway.

So, yeah, my point is we already have an atomic API to support panels:
it's the bridge one. If your plan is to make the panel API an equivalent
to the bridge API, then it just makes no sense when all consumers are
handling bridges anyway. Just write a bridge driver for your panel IC,
and you're done. It works today, and you don't have to extend anything.
And you can embrace your atomic panel.

Maxime

--bnu55xk7ah7f6vwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4FLAAKCRAnX84Zoj2+
dkWqAX9zUZI4E7mxKZN1Y1GCLbXBhkAvgliVL8C1FEaYE4+MjOPRi3MnEf78Hsxk
/9MrBfcBgOofz+9iFoZkLYhZfn5hVc6U6621zAhtiqRzZNvaqK9allN+rkgXh1zN
RDrtanF4bQ==
=1Xtb
-----END PGP SIGNATURE-----

--bnu55xk7ah7f6vwr--
