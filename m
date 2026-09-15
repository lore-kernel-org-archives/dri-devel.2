Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE00C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABD510E249;
	Tue, 15 Sep 2026 08:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IEXmmSeJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB63410E249
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:06:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8C12600D1;
 Tue, 15 Sep 2026 08:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15061F00898;
 Tue, 15 Sep 2026 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789459584;
 bh=Z0cnMVxCNzR3EOUmNSrlqeyEoOkE+dLkVF2dLXhSXNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IEXmmSeJQZMLV+Mn/c6joZw5NpNfGjiCF5V1FDNy+mmVxS8OnQrBV/AoJpnVBnAmc
 vCuJ6sx1paSCR3MoeFI0Sp40hwxNifyUJUsigyBj9PRsJ/fqrKVbNGx5ytlGVVOv/h
 3FO+1sex4WOzMNuH8oGxfTr+fO70PV97bFmheuO7EkvTapOq+o0zV4VJwVJAdyukTc
 o+Yef2zC3l9XkjO2fYFz+gvaXrcYMk4ctYLOCUxCLwoKOCrTNxfNl9HaHeEhWkuLPa
 QLpYS7kOkDLRb7TFEPwx7n+ldX7tGsDaj1ZKV9aas4wBIA+zsL2KrKBy7FLAMx2OYN
 v7rg0qbgLLwbw==
Date: Tue, 15 Sep 2026 10:06:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Simona Vetter <simona.vetter@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v5 00/33] drm: Implement state readout support
Message-ID: <aqj8YCPnLRhjmqoa@houat>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="lx2lx4yqr5n3kiub"
Content-Disposition: inline
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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


--lx2lx4yqr5n3kiub
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 00/33] drm: Implement state readout support
MIME-Version: 1.0

On Mon, Sep 07, 2026 at 03:23:36PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Here's a series that implement what i915 calls "fastboot", ie,
> initializing the initial KMS state from the hardware state at boot, to
> skip the first modeset if the firmware already set up the display.
>=20
> This series creates the infrastructure in KMS to create that state by
> relying on driver specific hooks. It also implements some infrastructure
> to check during non-blocking commits that the readout helpers work
> properly by reading out the state that was just committed and comparing
> it to what was supposed to be committed.
>=20
> This relies on another set of driver hooks to compare the entities
> states, with helpers providing the default implementation.
>=20
> It then implements the readout support in the TIDSS driver, and was
> tested with the SK-AM62 board. This board in particular is pretty
> interesting, since it relies on an DPI to HDMI bridge, and uses the
> drm_bridge_connector infrastructure.
>=20
> So the readout works with the current state of the art on embedded-ish
> platforms.
>=20
> Unlike the earlier RFCs, it now works fine: the state is picked up
> properly, doesn't trigger a modeset if what was programmed is the one
> the first modeset tries to pick as well, will switch properly if it
> isn't, etc.
>=20
> Let me know what you think,
> Maxime

Merged patch 1, 2, 6, 8 and 19 to drm-misc-next

Maxime

--lx2lx4yqr5n3kiub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqj8ewAKCRAnX84Zoj2+
dkFHAX0aBMTSiUukZRNhU907KVKaCtn7kIFHqz2b9N+dtnJoAJSecKuVCy5FuwXb
ElzuCqABfihXK6MBbO7WRt+DNyVQtswfJfn7qDdhKxJ0UmJ7U30m/Ehx29RAOPGq
jmQYQWT2WQ==
=zfwQ
-----END PGP SIGNATURE-----

--lx2lx4yqr5n3kiub--
