Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62ECCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 17:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E27610E2C7;
	Tue, 12 May 2026 17:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PgYYVw9L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1E310E2C7
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:13:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AE7BC43259;
 Tue, 12 May 2026 17:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51735C2BCB0;
 Tue, 12 May 2026 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778606000;
 bh=8dJ437SwzWerjVhp2FPxWDg3Khh2qq97aoIYw1v5qC4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PgYYVw9Ln1aTB+ILwFsfNGPuJv+Fr+qMEWe7B84d5OM/+cyn9Xc8HvsmLRXYmUXG8
 hZ1atECGinAhohzrV9wykd98LaCvDKwdAP33oEA+hJe2El5BbeTANxxJUFMNxuQZuz
 bRuOPQ/zpjOBtvFn/bfaSzD2RwFuWRNcwMKNq6hJEm6bLpozuytw3m2KbTcyLikvJz
 8kESW0dRPS8pdorYfn9hdCaBsdVHBgeTAASmzIK4/GqjkP3hMDt9NfgArQZnxTL5sM
 5bBhgl3/fSA44gTNlA+QAyQHqdu5uWoViuuvtWWP7u5IZXZsIbTPS5rQ0kLRF7wIBX
 3CyM5X2C7qlgg==
Date: Tue, 12 May 2026 18:13:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] dt-bindings: display: rockchip: analogix-dp:
 Add support for RK3576
Message-ID: <20260512-grandma-traverse-5dad619eaeb3@spud>
References: <20260512095644.1946084-1-damon.ding@rock-chips.com>
 <20260512095644.1946084-7-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DR4aWqEz4ku+XB0E"
Content-Disposition: inline
In-Reply-To: <20260512095644.1946084-7-damon.ding@rock-chips.com>
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


--DR4aWqEz4ku+XB0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 05:56:40PM +0800, Damon Ding wrote:
> RK3576 integrates an eDP TX controller compatible with the existing
> RK3588 hardware design, reuse the same binding configuration directly.
>=20
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--DR4aWqEz4ku+XB0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNfqQAKCRB4tDGHoIJi
0h8RAQCJTlZsXRmNLgBlSs928sr0deie257zWwDqaX3AsCGzkgEA0OcwIc3s0QD+
JJvyYNtUuzeP8VU4GtaHEx5Y25VqQgA=
=g0FX
-----END PGP SIGNATURE-----

--DR4aWqEz4ku+XB0E--
