Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA73CF588EC
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478F710E6D8;
	Mon, 20 Apr 2026 16:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JzYk9Yj7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B698510E6D8
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:01:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 77CD740810;
 Mon, 20 Apr 2026 16:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A534C2BCB6;
 Mon, 20 Apr 2026 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776700911;
 bh=TFfvYyf8eNA1jMBa/chl/2ph4XTsgB6/URx9v/wsFQY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JzYk9Yj7Pnrv3DBUSzMOK7bC+dzLeYnjE39rK9y52m7xyOo8T2iglPOxBsvTVLEPb
 A0WWrcGtXro5COv7MJwumpvo7PtsOjXC+cleU2gnih1ujR07VBJXO5kuQ0G+oQsjgL
 Ta5jChXy7xPsv+lHl85AMLm/uWPLtRyH2JJavUkXkRE3DV/CRrp8iOVREZOz3fKt/6
 R8H6//El6n0fvBxMx9LKih+27JQObszl2cZZliIHJCem3sJNiSjObZpewA4DQSkCeK
 wNOs25/T/fzam6qv7HUoIKd2NELsCb/FZW1yyno1wcxl52O2NBRohbfam1ef0avxSj
 5EkvIJKRVPyKg==
Date: Mon, 20 Apr 2026 17:01:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Raspberry Pi 7"
 DSI Display module panel
Message-ID: <20260420-elaborate-sulphate-45df36ab62ab@spud>
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-1-e68d5c9c44bc@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RueKeo7KxlAH4OXJ"
Content-Disposition: inline
In-Reply-To: <20260420-rpi-7inch-v1-1-e68d5c9c44bc@ideasonboard.com>
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


--RueKeo7KxlAH4OXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 04:13:35PM +0300, Tomi Valkeinen wrote:
> Add compatible string for panel used in Raspberry Pi 7" DSI Display
> module. The different display module versions have panels from multiple
> undisclosed vendors.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--RueKeo7KxlAH4OXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeZN6QAKCRB4tDGHoIJi
0oXnAP0aCo7RyHP7ZGVmtD6z3YTxQRmzy8Q17uHI3tw72fuG+gD8DgdiCX84T1YB
ENrbLPayE67iUaoCK7YHtvDGiLa3Kgw=
=FLqb
-----END PGP SIGNATURE-----

--RueKeo7KxlAH4OXJ--
