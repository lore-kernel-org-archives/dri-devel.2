Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F060CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF2610EDA9;
	Wed, 30 Sep 2026 10:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MY0onT2s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3E710EDA9
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:50:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F408E40A90;
 Wed, 30 Sep 2026 10:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA731F000FF;
 Wed, 30 Sep 2026 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790765426;
 bh=RdDXoYNxFlrj1IuAAP2dqxH+gWSF6G6CSQehHf0sYrc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MY0onT2sZM1Sg1SZWZwfnyDEQpbv7eKoZJV4m4PWFiqmLOjdMWRr4cZF6NAK0mofp
 C2Ire7L4/GEtGFjWe/hUlXT6SjuGTRmacoWmrtIAXlYmcwFnvr6G9V+iCU73YBqjgG
 aCNVRSwJMnutihtXV/eQDY5WyQmAOm9L+0KNH7TsjC3v4ZIzpWlcTVqtfX8v0JC5/9
 5H6zeGDSWkFIewW/rac1ugJQkbGYRgsl3+Et4OS9T1AUM9sonSZ2G3VeWOUpE05PrO
 vnPrM3eY/w/8yy/hvTK2sio8Jha3TQUrC2e8URq+ilw8Os3G1niSz1fRFOcTuGPOeo
 FuM27LVw3RslQ==
Date: Wed, 30 Sep 2026 12:50:24 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <arzn-TNbOlqXqQgd@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
 <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="phflgpeigirgxuyc"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
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


--phflgpeigirgxuyc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 12:52:18PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:19 Mi=
kko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > Tegra20/30 SoCs display controller.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++=
++
> > >  1 file changed, 138 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/tegra/n=
vidia,tegra-8bit-cpu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra-8bit-cpu.yaml
> > > new file mode 100644
> > > index 0000000000000..f0dab608b2936
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8b=
it-cpu.yaml
> > > @@ -0,0 +1,138 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-c=
pu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description: The display controller in Tegra20/30 SoCs features an
> > > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > > +  protocol and is referred to as '8-bit CPU'. Each display controller
> > > +  provides two such interfaces, which can be used to send MIPI DCS
> > > +  commands to initialize and control the panel while image data is
> > > +  transmitted via 16/18/24-line RGB.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nvidia,tegra-8bit-cpu
> > > +
> > > +  dc-gpios:
> > > +    description: Data/command selection pin.
> > > +    maxItems: 1
> > > +
> > > +  rw-gpios:
> > > +    description: Read/write pin.
> > > +    maxItems: 1
> > > +
> > > +  cs-gpios:
> > > +    description: Chip select pin.
> > > +    maxItems: 1
> > > +
> > > +  data-gpios:
> > > +    description: Specifies a set of 8 gpio pins used to transfer dat=
a.
> > > +    minItems: 8
> > > +    maxItems: 8
> >
> > Based on my admittedly brief research, according to the TRM the display
> > controller can drive all of these pins - of which there are two fixed
> > sets as you mention - directly. So we'd need to describe which interface
> > the display is connected to in DT, but not any GPIOs (which they really
> > aren't).
> >
>=20
> I am perfectly fine to not expose any gpios in the binding, if this is
> preferred. Only question, which method of interface checking would be
> preferred. I assume if primary then nothing, if secondary - boolean
> prop "nvidia,secondary"? Feel free to share your vision.

The driver currently uses the GPIOs to program DBI commands, so I
suspect we do need some way of controlling those pins. Or is there a way
to have the display controller program the pins and send commands? That
would be much preferred because it would more accurately reflect the HW
design and possibly also simplify the driver because it doesn't need to
parse the GPIOs and then also not use the GPIO API to set the values.

As for selecting the interface to use, it could probably be just a
simple, single-cell value with two valid values. That's a bit clearer
than a boolean, because with a boolean you need to explicitly document
what happens when it is absent.

> > > +
> > > +  nvidia,init-sequence:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description: Device specific set of values used in DC DISP_SPI_I=
NIT_SEQ
> > > +      registers.
> > > +    minItems: 4
> > > +    maxItems: 4
> >
> > And AIUI this is panel-specific DBI commands the display controller will
> > transmit. So ideally the display driver should receive this data from
> > the panel driver.
> >
>=20
> This is not panel driver data, but it is panel or maybe even more
> interface itself specific. TRM has no clear method of generation of
> this seq I am aware of. Maybe I have missed smth. These 4 entries
> co-respond to DC_DISP_SPI_INIT_SEQ_DATA_A_0,
> DC_DISP_SPI_INIT_SEQ_DATA_B_0, DC_DISP_SPI_INIT_SEQ_DATA_C_0 and
> DC_DISP_SPI_INIT_SEQ_DATA_D_0 registers of DC. Maybe you have some
> info to shed some light onto method of generation of this seq. Then it
> could be simply removed from binding and calculated internally. Thank
> you!

Even if this is interface-specific data, it is still defined by the
panel that's being used, right?

As such it'd make sense to integrate it into the panel driver and have
some side-channel to feed it to the display controller. If there's no
good standard way of doing so, having the display controller read it
=66rom the panel node and programming it at the appropriate time could
work, too.

Thierry

--phflgpeigirgxuyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq86XAACgkQ3SOs138+
s6Hjzg//W7hkLOTBX+eR1J5oDtVdKzgpxK0Hb8m5HCnxvGsZTNFjcJLHGIRvQkNZ
jqMyCrkOQ8CJlik2IAuYKOuCoD8M6X7KWqIJezVPC8prb75C53m3AYTaAPjlcVtS
Q0baRmtlKmnSMwcZDaOqcEidT07F7x/7bgDOOvOKa0bVEoULDdBO9aYJGXelLfC+
7uf1/wItwaWD3e/tZePLVrD0YroKmoPCsE9R0jNpRdSa7GTkT05A2sDjN5yHFoa+
YAwSTphyC7Xp+YoO6pqKWamdfFvdoJ0Ojl/Yr3gZ6yC7VfDuAckCJybwoWt19VIR
TPg1+pvDK7lYYoAO0x8LSichnmi3cSeAIlviaMTy24JXLemD8zFujMUsIASu0YrX
kGb716hhW1c3P14UXt6caTCBWIjlwuuUy9kpe5ewt6R7G1cAs/qOoxzpQS2YDDUy
TIvwr5Wz3nIZKtssCKrrNGJt2oaDcoi0rxe7MmQHcNmALOBIHcR141GiahKLJt/O
cgLKtHSPPe+oTsUj3c5V+WA7/DztrnClcTEUGJ3EwUifyzD6HjZ93wv6Baip0JJX
RZl2nU5SDiSqHZkPmGA1AEeQ7EsJ8uWBn24yCKZtNY5SvZ/s8AS8J9AJFtjkSdNC
eu9bdJm69W4+Z462hpkXEieikDKfpGEzbsGI7BxhTKAhwLARXXM=
=E3gO
-----END PGP SIGNATURE-----

--phflgpeigirgxuyc--
