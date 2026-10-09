Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70505CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B616F10EA95;
	Fri,  9 Oct 2026 15:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TP8RuDRh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815B710EA8A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 15:42:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51B6843354;
 Fri,  9 Oct 2026 15:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65251F000FF;
 Fri,  9 Oct 2026 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791560530;
 bh=HW59q6Yn0OslPF3Els2Dkx+G+MOVrvpGDU0AOpiMs5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TP8RuDRhfHpTVUdPOYlk0cIai3NHcEJgnKN6+dQM5aM4V2sN0c1RJn+LEudiFDrkx
 dxScbsVCXK/W/4tJ088RvzIyIV4tcX65/nuH9IbLVfzP1O0w/fPilJaufUYPI5Fg5C
 OeGTmYEozM6KgPwCKm1yctQX089jK86OD+Q6445gfjut+OH+ojDM0OJ9+2wQdQttII
 ea4mSor3ZZPSpSlPWNsGESj4hSjJ+7W/nhqBdJXGVeYuAY49DAOltFhqV0oMpSh0p4
 aNrSJHhvyLXiCcTuidBjxn3JMDSlIw3uS5sa/2sm7OfmUhh7PfK5uelxDHP4XYiGk2
 3dTzg8vgb7Q7A==
Date: Fri, 9 Oct 2026 16:42:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Quchaosheng <quchaosheng000406@163.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009-db35f1d74028d0d0a34f1106@squawk>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
 <20261009-2f34bbada2c463c78b2c05a7@squawk>
 <20261009144434.GD622105@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+lGluAYOQ0yvN+I2"
Content-Disposition: inline
In-Reply-To: <20261009144434.GD622105@killaraus.ideasonboard.com>
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

--+lGluAYOQ0yvN+I2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 04:44:34PM +0200, Laurent Pinchart wrote:
> On Fri, Oct 09, 2026 at 03:25:49PM +0100, Conor Dooley wrote:
> > On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> > > From: Chaosheng Qu <quchaosheng000406@163.com>
> > >=20
> > > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > >=20
> > > The TI TPD12S015 is an HDMI companion chip that combines a level shif=
ter
> > > and ESD protection circuitry. Document the two ports it exposes betwe=
en
> > > the HDMI transmitter and the connector.
> > >=20
> > > The tpd12s016 is software compatible with the tpd12s015 and is listed=
 as
> > > a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> > > fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only=
, so
> > > a board using the tpd12s016 must list both compatibles.
> > >=20
> > > Assisted-by: LLM
> > > Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> >=20
> > No idea if the sashiko reply is valid, because I have no clue if
> > providing a subset of the gpios is functional. Really this should have
> > multiple different gpios properties,
>=20
> Definitely.
>=20
> > but this binding is really old and
> > not worth changing IMO.
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
>=20
> I'm getting annoyed be the LLM-assisted individual conversions. Can we
> start requiring people who convert text bindings to YAML to at least
> handle whole groups in one go ? If they're going to do a bad job, I'd
> rather have to review it once only.

Or do one, and take the learnings into all the remaining patches - but
with LLM conversions I don't think there's really much learning going on
at all.

I guess bunching them is fine, provided it is for one subsystem. I
definitely don't want to see a set of 15 patches across 9 subsystems,
at least with one subsystem it's likely to be the same common problems
across the bunch.


--+lGluAYOQ0yvN+I2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaskLSQAKCRB4tDGHoIJi
0oOqAP9/cjJoHwDyuvhTJ9sGUQQFM7+QGVx4YCXrySUHlraVRgD/awI23g7lMVjK
P89dAe3GuVNwufd8hjuhcHxiA7qK/g4=
=bjaF
-----END PGP SIGNATURE-----

--+lGluAYOQ0yvN+I2--
