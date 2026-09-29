Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76669CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C699B10ED9C;
	Tue, 29 Sep 2026 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VyMSysAv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC8010ED9C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 08:39:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2E694033C;
 Tue, 29 Sep 2026 08:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC01F000FF;
 Tue, 29 Sep 2026 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790671167;
 bh=vHaUtZ3yE9ZiHYbJMJ7LMgQCwamNYBySvviYFUnXHXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VyMSysAvAo7ngdUGShaeaSS7dNAOWwUOlTJuYF0veHDkZPuwBGplCxkq3zYfmMXso
 /zwdaYLvq0ftT23TrtAk+3Q/V507oCqtKiCaTTa3dU+SPoJfI6z5TEMDwY4f2FboHw
 sLiQOF8ZyUV+QafHjHlodL/KuvuTwUt11h1537m7TDAiuUmK+N7DYsgklbj5HWVVdd
 qFKGSRvAvZFoogC74Yzbmqp4YKJ42qAt7YcwtMXwwNEDLY8WHX9fs1dB1x3Z2YlSxi
 DznitOMAhJeq5fTWgmuwINB1mdpeXesqzXKCKJgoYsc4bj4ZlorP346HLkA6U2tMSr
 YL3DYq2Kc+dMQ==
Date: Tue, 29 Sep 2026 10:39:24 +0200
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
Message-ID: <artyl8fD3zzng8Uh@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gzxryrlughoococo"
Content-Disposition: inline
In-Reply-To: <20260928204059.GA515872-robh@kernel.org>
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


--gzxryrlughoococo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
MIME-Version: 1.0

Hi,

I'll merge the two discussions in that thread.

On Mon, Sep 28, 2026 at 03:40:59PM -0500, Rob Herring wrote:
> On Mon, Sep 28, 2026 at 06:22:01PM +0200, Maxime Ripard wrote:
> > Most MIPI-DSI panel drivers follow an identical pattern: acquire
> > regulators and GPIOs, perform a reset pulse with specific timing,
> > send a vendor-supplied sequence of DSI commands, then enable the
> > display. The only truly panel-specific part is the init sequence
> > and power-on/off timing.
> >=20
> > The panel-mipi-dsi-bpf driver replaces per-panel kernel modules
> > with a single generic driver whose panel-specific behavior is
> > provided by BPF programs loaded from userspace at runtime,
> > following the HID-BPF model. This enables new panel support
> > without kernel patches.
> >=20
> > Panel DT nodes use a two-entry compatible with the panel-specific
> > string first and "panel-mipi-dsi-bpf" as fallback. The generic
> > driver matches on the fallback, while the first compatible is used
> > to identify which BPF program to load.
>=20
> If you need the 1st compatible anyways, what is the point of the
> second one?

The whole point of this driver is that you don't need to modify the
kernel when you add support for a new panel.

> Also, I assume there is at least some panel supported in the kernel
> you might want to convert to this. That panel would not have the
> fallback (and the DT is fixed).

Yeah, that's true. I'd still need to identify the parts though. I guess
using a generic compatible but a specific model would work?

> And I agree with Neil's comment. At least until we start embedding BPF=20
> into DT directly. ;)

And from Neil:

> I don't see how this can be a valid hardware description, bfp is a
> software implementation and has nothing to do in the bindings.

I'm quite a bit surprised by that argument though.

We have in the main dt-schema repos bindings like:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/opti=
ons/u-boot.yaml
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/boot=
ph.yaml
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/post=
-init-providers.yaml

Or, in Linux:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/sound/simple-card.yaml

All of them have been reviewed or acked by you, and yet none of them
relate to any hardware description.

panel-mipi-dsi-spi is a generic panel that will load a firmware, and
quite similar to this one. google,android-pipe and qcom,fastrpc don't
attach to anything and will just open a tunnel to userspace, which is
somewhat equivalent but more dramatic than what this driver is doing.
simple-card or its variations will just instantiate a kernel driver from
the DT and is used pretty much everywhere.

I reused the binding from panel-mipi-dsi-spi for this. It was reviewed
by rob, and acked by a panel maintainer, and 4 years ago, so we're way
past the "oh but we didn't know what we were doing back then" argument.

So, let's phrase this differently: what's different about the
description than panel-mipi-dsi-spi, or any other binding already in
tree?

If it's the BPF part, BPF is not Linux-only, and there's hardware with
direct BPF support these days, so it can be considered OS-agnostic and
not an implementation detail.

Maxime

--gzxryrlughoococo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCart5NwAKCRAnX84Zoj2+
dq+3AXsHKGDW5rCG290Y1fx+OohFSBUrfr+SjWPzYJbv3AsWDJ+tyk6pJ0aj+C5d
QReuRzgBf1XMASoAKO+JAW9hFCf/nZfVfklcUBc5TR6bE1h5DcpFLGIlYksltuZo
cQcGQ3gsrw==
=YrNa
-----END PGP SIGNATURE-----

--gzxryrlughoococo--
