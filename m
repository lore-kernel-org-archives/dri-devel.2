Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D81C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBBF10E954;
	Mon, 29 Jun 2026 15:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EgKVZsNX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E3810E954
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:02:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F2396001D;
 Mon, 29 Jun 2026 15:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5641F000E9;
 Mon, 29 Jun 2026 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782745361;
 bh=8nHH4gBN/s7IeS6y/9S8TpBtfSijBrQ1/bmAkV3Z6gE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EgKVZsNXSvXhmSCt1BVSoodDMvOemtG6Pw16rwqHRrmg1dK6X4ggf1FRqNQX2R0ZC
 PKawziiOHdwf53YIsMGoxtg7qptV9jJfE2D0/6NVHg2BGfMftzhO2ESVEegipqp8zr
 aAIru5612INZcMIMmIwFJAg7bdXMQUfX8m730cCXmGaAWhOuSyEk7STEwoNpm6AQGz
 A55ZKEfZKm9+VwuPrxhYAVP/Qk7Bpks1JwJcrYMFOwOt7fo1X3QgDoK6IcibPyCz5I
 V8lENQTcRCYaim9Z1ABEGrnxWezJ0YDgckPUfS8E8uv9nIhz5Ll0X/e7ajIVZbgOwT
 B0IouTn4WLtUg==
Date: Mon, 29 Jun 2026 16:02:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Joey Lu <a0987203069@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
Message-ID: <20260629-chevron-awhile-7cf456a768a0@spud>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <e3fe23ddbc504879bd797bbaa595d3653fa139ff.camel@iscas.ac.cn>
 <20260626-astrology-mural-853d3860e048@wendy>
 <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
 <20260626-everybody-epilogue-8fb298a54981@wendy>
 <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
 <b3b7a0f8-93a8-4965-a2f3-3ca1552a25d6@gmail.com>
 <80ae28925a67b7bee3b8873db3c113111437e717.camel@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IgfcEfDUK/kmfpjk"
Content-Disposition: inline
In-Reply-To: <80ae28925a67b7bee3b8873db3c113111437e717.camel@iscas.ac.cn>
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

--IgfcEfDUK/kmfpjk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 01:31:46PM +0800, Icenowy Zheng wrote:
> > > > > > > > > +
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 resets:
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 minItems: 1
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 maxItems: 1
> > > > > > > > > +
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 reset-names:
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 items:
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: core
> > > > > > > > This is just maxItems: 1.
> > > > > > > Well the implicit rules of DT binding schemas are quite
> > > > > > > weird...
> > > > > > I don't think it is that strange, as the binding has
> > > > > > =A0=A0 reset-names:
> > > > > > =A0=A0=A0=A0 items:
> > > > > > =A0=A0=A0=A0=A0=A0 - const: core
> > > > > > =A0=A0=A0=A0=A0=A0 - const: axi
> > > > > > =A0=A0=A0=A0=A0=A0 - const: ahb
> > > > > Ah does the list constraint the order of items? If it
> > > > > constrains
> > > > > the
> > > > It does, yes.
> > > > Alternatively, using an enum permits free ordering.
> > > Ah in this case this should be converted to an enum, I think.
> > >=20
> > > Should I send a patch for converting it?
> > >=20
> > > Thanks,
> > > Icenowy
> > Thank you all for the detailed review and discussion, it really
> > helped
> > clarify the right approach.
> >=20
> > Since I will supply all four clocks with the same phandle for
> > core/axi/ahb,
> > and only one reset "core" for MA35D1, the ordering constraint in the
> > `items` list is not a problem, "core" is already the first entry.
> > There
> > is no need to convert to an enum.
> >=20
> > Regarding the clock situation for the MA35D1: I agree with supplying
> > all
> > four clocks (core, axi, ahb, pix0) in the devicetree, even though the
> > MA35D1 clock controller gates core/axi/ahb with a single bit. The DT
> > will
> > use the same clock phandle for core, axi, and ahb:
> >=20
> > =A0=A0 clocks =3D <&clk X>, <&clk X>, <&clk X>, <&pix_clk Y>;
> > =A0=A0 clock-names =3D "core", "axi", "ahb", "pix0";
> >=20
> > This correctly models the hardware topology. Since all three names
>=20
> No, this doesn't correctly model the hardware topology -- this will
> lead to clk_get_rate() return the rate of DC core clock when checking
> the AXI clock rate, which is problematic because both clocks are
> limiting the performance of the DC.
>=20
> > resolve
> > to the same underlying clock node, the CCF's standard enable
> > refcounting
> > handles the shared gate correctly without any custom implementation
> > needed.
> > I will also revert the change in patch 4/7 that made axi and ahb
> > clocks
> > optional, since they will now always be provided in the devicetree.
> >=20
> > Regarding moving `resets` and `reset-names` to the top-level
> > `required:`,
> > I will wait for Icenowy's patch to land before sending v6 to avoid
> > duplicating the work.
>=20
> The patch is sent.
>=20
> >=20
> > In v6 I will update patch 1/7 with:
> > - Update the subject to "dt-bindings: display: verisilicon,dc: add
> > =A0=A0 support for nuvoton,ma35d1-dcu"
> > - Lower `clocks`/`clock-names` `minItems` to 4 at the top level
> > - Remove the `thead,th1520-dc8200` conditional block entirely
>=20
> I think this conditional block will still be needed, because it will
> need to constrain the minItems to ensure all clocks / resets are
> populated.

Correct. When the outer constraints are relaxed to deal with the new
device the conditional block for the th1520 becomes required. Or having
an else, but if all devices are likely to be different in terms of
configuration specific conditional blocks is better.


--IgfcEfDUK/kmfpjk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakKJCwAKCRB4tDGHoIJi
0h7GAQCJb5feu4xl6yYVBQwiVZOZChwL0Lr7y5z363AQ+EVV9AEAmL++SyuqhNBW
SKNJ/viml8vWj6f91Cb4O/UlhqZT8gY=
=uZpY
-----END PGP SIGNATURE-----

--IgfcEfDUK/kmfpjk--
