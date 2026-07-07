Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE761C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C74310E459;
	Tue,  7 Jul 2026 07:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a4uAEI0d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9458910E459
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:46:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 512DD402EB;
 Tue,  7 Jul 2026 07:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B587A1F000E9;
 Tue,  7 Jul 2026 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783410414;
 bh=OnpghKNBXuM5a1+lYcxPvTs2yNmaNmSBYDdKDW5xo7w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a4uAEI0dABLPn0hUPJJWyQNJ70Oa4414tjdc5SMVZIe2nR9Wlr9Vl00mhtpqix3ae
 l+vcafSCV6eu5bnZRGfa4Fa6gIaeiXZAdGbH7dXJdWAuWyRvfxhTfpc9rRwfm+a2cj
 tmDnEOSIwZHYxZUl6mtVa9txxPvQN06d4rCyHhikkwnWunlHLz2aEvO0YkB5M+JIOJ
 /zoi2xjyatyfxO/JhOg6H3pCh3sBfwzKcZSWyLeVBtcboLCpmvrB5J8wq0PREjvq+n
 BCW4gUg5ANzpve+xZAV5vRebff71OpPOQoIm8j9RROaeUFY3EcF/0ijDOguR2/YwiW
 9nzRYogRcDnNg==
Date: Tue, 7 Jul 2026 09:46:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
Message-ID: <20260707-meaty-chocolate-lemming-fa9ead@houat>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
 <20260706-capable-beaver-of-excellence-a3cf10@houat>
 <20260706094522.GA42740@killaraus.ideasonboard.com>
 <20260706-fancy-perch-of-satiation-0c220e@houat>
 <20260706160243.GB106045@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="uxuzu5uiypml7j3g"
Content-Disposition: inline
In-Reply-To: <20260706160243.GB106045@killaraus.ideasonboard.com>
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


--uxuzu5uiypml7j3g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
MIME-Version: 1.0

On Mon, Jul 06, 2026 at 07:02:43PM +0300, Laurent Pinchart wrote:
> On Mon, Jul 06, 2026 at 05:40:30PM +0200, Maxime Ripard wrote:
> > On Mon, Jul 06, 2026 at 12:45:22PM +0300, Laurent Pinchart wrote:
> > > On Mon, Jul 06, 2026 at 10:52:32AM +0200, Maxime Ripard wrote:
> > > > On Mon, Jul 06, 2026 at 12:35:39AM +0300, Laurent Pinchart wrote:
> > > > > Since DDC version 2, introduced in 1996, VGA monitors have expose=
d EDID
> > > > > data over an I2C bus. The bus is also used to detect the presence=
 of a
> > > > > connected monitor by trying to read the EDID data.
> > > > >=20
> > > > > Some devices where the VGA display is integrated in the device and
> > > > > always connected do not connect the DDC pins. Some development bo=
ards,
> > > > > such as the Renesas M3N Salvator-XS, also do not connect the DDC =
pins.
> > > > >=20
> > > > > To support those, add the ability to provide hardcoded EDID data =
in the
> > > > > device tree. This is mutually exclusive with specifying a DDC bus=
, and
> > > > > can only be done when the VGA display is guaranteed to be always
> > > > > connected.
> > > > >=20
> > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideason=
board.com>
> > > >=20
> > > > This feels redundant with the EDID firmware loading mechanism we ha=
ve in
> > > > KMS already. It should at least be mentioned why we would need to s=
et it
> > > > in the device tree at all.
> > >=20
> > > Very good question.
> > >=20
> > > I assume you're talking about CONFIG_DRM_LOAD_EDID_FIRMWARE, as the
> > > debugfs override_edid feature isn't meant for production. If there are
> > > other relevant mechanisms I'm not aware of, please let me know.
> >=20
> > No, that's indeed what I meant.
> >=20
> > > In the use case at hand, the VGA display is an integral part of the
> > > device, the same way an LVDS or DSI panel would be. Using
> > > CONFIG_DRM_LOAD_EDID_FIRMWARE, the manufacturer would need to set the
> > > drm.edid_firmware command line parameter, and provide EDID as a file =
in
> > > /lib/firmware/ (possibly in an initramfs). Beside the complexity, and
> > > the fact it won't be very friendly to people who run a different
> > > userspace on the device, I think EDID counts in this case as system
> > > description, the same way we support specifying panel timings in devi=
ce
> > > tree.
> >=20
> > It's *some* hardware description, but you have no idea whether it's
> > actually the hardware you're running from. What would be in that EDID
> > anyway?
>=20
> It would be the EDID corresponding to the connected display :-) I see it
> as identical to how a user of the simple panel driver is responsible for
> listing the timings corresponding to the hardware in the device tree.

What's the expected user-experience for someone with that board
unplugging a display and plugging another then? Update the device tree,
rebuild it, rebuild the firmware and / or resign it and reboot?

That doesn't sound very practical, and even impossible in some cases.

> > There's another alternative we've used several times already, in
> > simple-bridge for example: just register any VESA mode up to a given
> > resolution:
> > https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/bridge/s=
imple-bridge.c#L66
>=20
> I don't see how that would help. The goal is to provide the kernel with
> the data corresponding to the display integrated in the device.

How is that not helping? Your problem is that you have a display you
can't get the supported resolutions from. What I'm suggesting allows you
to create all the possible resolutions for that display, allowing the
user to use the display, which is what we did for multiple drivers with
the same problem.

You seem to be set on providing the EDID to the kernel, but it's a
terrible idea to begin with, so I'd rather discuss alternatives.

Maxime

--uxuzu5uiypml7j3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakyu2gAKCRAnX84Zoj2+
dttmAYDwAyDzsHH4BdK18Zg1snhvtmCOWF5mfpdzQr5B60t05sOH4JHRHhYDO62c
O0R+3mwBgLQ2v3BV/JvI3f56cwkgVA2l6vP/yfbZFMo+03DPC8zxTjP8fRZZmkqV
6IPIr/VIMQ==
=pNHu
-----END PGP SIGNATURE-----

--uxuzu5uiypml7j3g--
