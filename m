Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7A3C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B87E10E3AE;
	Fri, 26 Jun 2026 15:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OX75Ja8h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1F910E3AE
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:32:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A2B2411C8;
 Fri, 26 Jun 2026 15:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8331F000E9;
 Fri, 26 Jun 2026 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782487935;
 bh=jEXv67plAeVKc6QOySkiZG6EvVm3ies2+IuJZc70bPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OX75Ja8h+amfCkMWdtZjJQ5D3OvRV4W7FHsSwodm0faSlEY/zzuUp852MUPzfrhRn
 rBbHe2EdODCh8YCFZVli3AfZviO7UAIGkVeS9+5LezYYbDCGeYXclhQjLQYNzMXKQM
 uyGhtAggy6VexVb6QDlycMRYiqvq+qlpU/ZQh/eXrYXIJ8UoI2ER4lLgAFttjl9rUL
 +5Kgl4i9/O2etX35euhHtJZF2lcjwcmqa4z25Cu15sggp4vOq62v5PKfC3TzG8W1FA
 C2/T56M7j3LEPoJGklbCdcEuM3XurQAp0UlwIMlT5GmfPJ1qVFXE6PYadWu6e8c5IO
 oTpAtoVYvTs5A==
Date: Fri, 26 Jun 2026 16:32:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 yclu4@nuvoton.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
Message-ID: <20260626-predator-purity-fb6bd90e7237@spud>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-2-a0987203069@gmail.com>
 <20260625-bobbing-annotate-d1c4d6874ee2@spud>
 <e3fe23ddbc504879bd797bbaa595d3653fa139ff.camel@iscas.ac.cn>
 <20260626-astrology-mural-853d3860e048@wendy>
 <c0731801729713d35f97bec40ebc21cef31b72b5.camel@iscas.ac.cn>
 <20260626-everybody-epilogue-8fb298a54981@wendy>
 <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Ve3lgpxDSyp290p"
Content-Disposition: inline
In-Reply-To: <9456bde5059bea3aac1ed64355e3f017dd9bd3e5.camel@iscas.ac.cn>
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


--7Ve3lgpxDSyp290p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 05:33:26PM +0800, Icenowy Zheng wrote:
> > > >=20
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 resets:
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 minItems: 1
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 maxItems: 1
> > > > > > > +
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 reset-names:
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 items:
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: core
> > > > > >=20
> > > > > > This is just maxItems: 1.
> > > > >=20
> > > > > Well the implicit rules of DT binding schemas are quite
> > > > > weird...
> > > >=20
> > > > I don't think it is that strange, as the binding has
> > > > =A0 reset-names:
> > > > =A0=A0=A0 items:
> > > > =A0=A0=A0=A0=A0 - const: core
> > > > =A0=A0=A0=A0=A0 - const: axi
> > > > =A0=A0=A0=A0=A0 - const: ahb
> > >=20
> > > Ah does the list constraint the order of items? If it constrains
> > > the
> >=20
> > It does, yes.
> > Alternatively, using an enum permits free ordering.
>=20
> Ah in this case this should be converted to an enum, I think.
>=20
> Should I send a patch for converting it?

Why do you think it should be an enum? We don't currently have any users
of this that only provide no core or no axi reset.

--7Ve3lgpxDSyp290p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6beQAKCRB4tDGHoIJi
0gbBAQD2qYmeU3dXPFzN/2vp9UGyLPNTpngsvAFylyCo+L5IOQD6A5ZqJBiSI8Xk
pHlYwjodYrAF8Ufa6WCA/5GANwLhwQk=
=EVAO
-----END PGP SIGNATURE-----

--7Ve3lgpxDSyp290p--
