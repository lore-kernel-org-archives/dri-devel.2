Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08E5CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2150910F22C;
	Wed, 30 Sep 2026 08:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QJ1Jkh88";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA89610F229
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:04:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00C5360258;
 Wed, 30 Sep 2026 08:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A8A1F000FF;
 Wed, 30 Sep 2026 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790755483;
 bh=lAhm/IRtE5TnsstmivWqwHlXEeHp6zXLoKL6Dpf/08M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QJ1Jkh88NS099T5XThWkiHUyHFMuaUi05aDIb0DuSfK6cbpnRq28RDtuRmH0kFGSv
 NZBn9sJRMspdyRlciqW7jBwuSJhhmVl+ihgUSFAiPw2uKl7PbI1UZnfLJPikMcnOyU
 ovoPJtoyeUD0pBgYjEK81upp+9g5hXAzTVbnwNByddsnhUHGbTh4oyjWwPnTpHoiyE
 W+veZ7MG2gdJLu5Tu2tBbHeKkaorg36xo5setYHOfmWCoJ7iQrrSg5BXX6WjPsfC16
 p8iXs5bEn9clABquAKOv4qGbKnFg2BCrgrFqzkP/nj5meGWrDZhxZks/v9wThWHD3f
 jOxH1OsmTZDig==
Date: Wed, 30 Sep 2026 10:04:39 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
Message-ID: <ary8IdL9zVXfS2fA@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
 <20260929222822.GA2933878-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="k3ccvqemgn4avxba"
Content-Disposition: inline
In-Reply-To: <20260929222822.GA2933878-robh@kernel.org>
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


--k3ccvqemgn4avxba
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 05:28:22PM -0500, Rob Herring wrote:
> On Tue, Sep 29, 2026 at 10:39:24AM +0200, Maxime Ripard wrote:
> > On Mon, Sep 28, 2026 at 03:40:59PM -0500, Rob Herring wrote:
> > > On Mon, Sep 28, 2026 at 06:22:01PM +0200, Maxime Ripard wrote:
> > > > Most MIPI-DSI panel drivers follow an identical pattern: acquire
> > > > regulators and GPIOs, perform a reset pulse with specific timing,
> > > > send a vendor-supplied sequence of DSI commands, then enable the
> > > > display. The only truly panel-specific part is the init sequence
> > > > and power-on/off timing.
> > > >=20
> > > > The panel-mipi-dsi-bpf driver replaces per-panel kernel modules
> > > > with a single generic driver whose panel-specific behavior is
> > > > provided by BPF programs loaded from userspace at runtime,
> > > > following the HID-BPF model. This enables new panel support
> > > > without kernel patches.
> > > >=20
> > > > Panel DT nodes use a two-entry compatible with the panel-specific
> > > > string first and "panel-mipi-dsi-bpf" as fallback. The generic
> > > > driver matches on the fallback, while the first compatible is used
> > > > to identify which BPF program to load.
> > >=20
> > > If you need the 1st compatible anyways, what is the point of the
> > > second one?
> >=20
> > The whole point of this driver is that you don't need to modify the
> > kernel when you add support for a new panel.
>=20
> What reads the most specific compatible?

The BPF loader, so either in kernel loader or userspace loader through
uevents, depending on how the driver discussions are going.

> > > Also, I assume there is at least some panel supported in the kernel
> > > you might want to convert to this. That panel would not have the
> > > fallback (and the DT is fixed).
> >=20
> > Yeah, that's true. I'd still need to identify the parts though. I guess
> > using a generic compatible but a specific model would work?
>=20
> What? You can't add a generic compatible in these cases.

generic-*hci all have a generic component *and* a platform specific part
for quirks, and yet none of them require a platform specific compatible
to be added to work. PCI has that too.

This driver has a generic part and a platform specific part for quirks.

> > > And I agree with Neil's comment. At least until we start embedding BPF
> > > into DT directly. ;)
> >=20
> > And from Neil:
> >=20
> > > I don't see how this can be a valid hardware description, bfp is a
> > > software implementation and has nothing to do in the bindings.
> >=20
> > I'm quite a bit surprised by that argument though.
> >=20
> > We have in the main dt-schema repos bindings like:
> >=20
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
options/u-boot.yaml
>=20
> Self contained in a node that's specifically not h/w.
>=20
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
bootph.yaml
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
post-init-providers.yaml
>=20
> Extra hints that are safe to ignore.
>=20
> >=20
> > Or, in Linux:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
>=20
> Virtual h/w which tends to have special needs.

How is that not a description of the binding we're discussing?

> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>=20
> Shrug. Weird Qcom shit...

Cool. What can I do to add this binding to the list of "weird Maxime
shit" or is this kind of exception only for Qualcomm?

Or should we do it the other way and ship the binding anyway, and in two
years, when it will have been in device tree in the wild and
we-cannot-change-it-we-swear, we will be able to upstream it?

And in the process reward the ones *not* playing the upstream game.

> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/sound/simple-card.yaml
>=20
> Just a container... Though I can't say I really like any of the audio=20
> bindings.
>=20
> All really irrelevant to this discussion other than the panel binding...

Not really. The discussion was "but you're describing something that
isn't hardware". And none of the above are. And were acked. Some
recently.

> > All of them have been reviewed or acked by you, and yet none of them
> > relate to any hardware description.
>=20
> There are things which aren't h/w, but this is h/w and we've already=20
> made decisions about how panels in particular are represented. We of=20
> course have some remanents of how we don't want to do things.
>=20
> > panel-mipi-dsi-spi is a generic panel that will load a firmware, and
> > quite similar to this one. google,android-pipe and qcom,fastrpc don't
> > attach to anything and will just open a tunnel to userspace, which is
> > somewhat equivalent but more dramatic than what this driver is doing.
> > simple-card or its variations will just instantiate a kernel driver from
> > the DT and is used pretty much everywhere.
> >=20
> > I reused the binding from panel-mipi-dsi-spi for this. It was reviewed
> > by rob, and acked by a panel maintainer, and 4 years ago, so we're way
> > past the "oh but we didn't know what we were doing back then" argument.
> >=20
> > So, let's phrase this differently: what's different about the
> > description than panel-mipi-dsi-spi, or any other binding already in
> > tree?
>=20
> There's all of 3 panels supported. Compared to all the other panels we=20
> have, hardly the rule over the exception. You can always fine "bad"=20
> examples or exceptions.
>=20
> That one defines a single supply. Any other MIPI SPI panel with=20
> different supplies or GPIO controls probably has its own binding. Trying=
=20
> to parameterize that in DT doesn't work. We've rejected trying to do=20
> that in DT over and over. What's your story here for that?

Sigh... Look, I really don't care about an argument DT maintainers use
at their discretion for this. We both know full well that it's been and
still is inconsistenly applied, and you also know that it's not like
I've been playing the DT game since pretty much the beginning (on ARM
anyway). So it's not like I don't want to make it work, I do. But what I
care about is enabling that driver to work.

I reused exactly the same binding than the last major binding that was
merged for panels, and support about the same number of panels. I guess
that was a mistake, so sorry for that.

I'm fine with reworking the binding any way you want as long as it still
allows for the same use-case, but I would have hoped for a better
feedback on how to do so than "oh what a huge pile of shit this is".

Maxime

--k3ccvqemgn4avxba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarzCkwAKCRAnX84Zoj2+
dpc3AYDOB9XdH/2zapSanqxE4H56ffYrbVAeb+qx5XxwVM0vnMt7lzv9vg5HaAOo
S/xSzu0Bfi/5SfsSXC39fs4ZPIdQyMs+eNZexW71Ze0mJnl6LF6ImBE4OXEw7pa4
QGknAZNTfg==
=jVxm
-----END PGP SIGNATURE-----

--k3ccvqemgn4avxba--
