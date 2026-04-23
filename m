Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA60F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0980510F07F;
	Thu, 23 Apr 2026 10:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MykLjWxj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D6810F07F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:21:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F415260052;
 Thu, 23 Apr 2026 10:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F35C2BCAF;
 Thu, 23 Apr 2026 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939670;
 bh=YvpGXcAIq/ELedWMUycPOJmoW9ohYVn+So3dnxCtPMQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MykLjWxjvHKSw7G21j7POMOEV+Y5P9LS5JmvjH/CsGdPF6yd1Ttu6z/q2LdTCht7j
 TpOJQGZIq6tALSkaVSL0TFbHwy4GQPIzfv2Yf5uiziobWoRVcYYOFi9eBULxHnkfs+
 FKTO15KAaWw3LJATCqT090pCd1aREp0/AYoDMCfE37ckvpZq1sX2xc7zl9Su84s4Rs
 S1EQLMPJtv+XLJKhLJTDCZ41S9Vc+zLgz2fhgnNl7wOnCe9IJrGenmpMSh4whRD5g1
 Oem0/ldyVl8dksyl7XN199E79SrUclv7y3oUA4uQejDAcd+RT/RbkBFsCI+kj1YMWW
 IGJQL4GomZPeA==
Date: Thu, 23 Apr 2026 12:21:07 +0200
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
 linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 00/28] drm: Implement state readout support
Message-ID: <20260423-modest-polite-jaguarundi-f53cce@houat>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="flfzdlmjtvn42spd"
Content-Disposition: inline
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
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


--flfzdlmjtvn42spd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/28] drm: Implement state readout support
MIME-Version: 1.0

Hi,

On Thu, Apr 23, 2026 at 12:06:38PM +0200, Maxime Ripard wrote:
> Here's a series that implement what i915 calls "fastboot", ie,
> initializing the initial KMS state from the hardware state at boot, to
> skip the first modeset if the firmware already set up the display.
>=20
> This series creates the infrastructure in KMS to create that state by
> relying on driver specific hooks. It also implements some infrastructure
> to check during non-blocking commits that the readout helpers work
> properly by reading out the state that was just committed and comparing
> it to what was supposed to be commited.
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
>=20
> It's now in a much better state than the v1 was, but there's still some
> notable things broken:=20
>=20
>   - Bridges do not read their input and output bus formats and flags
>=20
>   - The tidss_crtc_state fields are not read properly at the moment
>     either.
>=20
>   - It looks like, when left unattended, we get some atomic_flush
>     WARN eventually, maybe because of something broken around
>     hotplugging and the monitor shutting itself down?
>=20
>   - If readout is disabled for any reason, the hardware isn't reset
>     anymore.
>=20
> The main thing works though: the state is picked up properly, doesn't
> trigger a modeset if what was programmed is the one the first modeset
> tries to pick as well, will switch properly if it isn't, etc.

Sorry, my smtp server spuriously failed halfway through sending the
series. I just resent it.

Maxime

--flfzdlmjtvn42spd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaenykwAKCRAnX84Zoj2+
dj2BAX4tppgQeYFSoA6GxRsc2QG/piIpuUuPCN1zSS6Fj+Pn52mWjBNXp8inlWPK
05n+ZIIBf2ltlFOQIgAtka71M+gksfkCwK+YCyLgGvIcfflqYBBlJEJVXwWrAvaU
2Zpl1FZysA==
=/RTo
-----END PGP SIGNATURE-----

--flfzdlmjtvn42spd--
