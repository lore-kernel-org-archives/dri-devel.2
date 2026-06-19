Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C0ACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD6D10F55B;
	Fri, 19 Jun 2026 12:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J5Sb6NDL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A87E10F55B
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:21:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41C9E42B1D;
 Fri, 19 Jun 2026 12:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB71F000E9;
 Fri, 19 Jun 2026 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871668;
 bh=ZaXy3j3i3/V/pewg36jgJ+tuXJkCriFz9gINNxtr/E8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J5Sb6NDL3MHukZNS8VKtP55KgVL9tjX0fvNgy9cV0j0B1Sn1PFuF+Zd5ikvhNmV60
 edBe/VGlvsLGy+ya/WGRfqjpeQseaG7K/9fD/3kK8Dnjuctao438Z1xMS4vswV4Dwp
 TXSYpH4ApH/9PFgEPgrzkCeY718PmbvSNi3eb6M5+qO9YpzAJRrfq0SHiBs9MGwfy2
 xZb8Et/4+nHwmyeMKIwtca/R2Wttr7HFIzxuBcO77XMD7rwdy+xMGdKhX8KJRQXE3Q
 Y8eKWpG6GEQhO/Ire8xMdF5/09Or1Mc2zvJq9wGC8MNbk2PklfkIfmTXjyqswLV30s
 G45UvE87D2xhg==
Date: Fri, 19 Jun 2026 14:21:05 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 74/78] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
Message-ID: <20260619-radical-zealous-carp-26de63@houat>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-74-0a91018bf886@kernel.org>
 <178186464480.2030423.10783457436815205173.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="52giv6x6vt4urvhf"
Content-Disposition: inline
In-Reply-To: <178186464480.2030423.10783457436815205173.b4-review@b4>
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


--52giv6x6vt4urvhf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 74/78] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
MIME-Version: 1.0

On Fri, Jun 19, 2026 at 12:24:04PM +0200, Luca Ceresoli wrote:
> On Mon, 08 Jun 2026 16:36:56 +0200, Maxime Ripard <mripard@kernel.org> wr=
ote:
> > All drivers have been converted to the atomic_create_state callback
> > and its drm_atomic_helper_bridge_create_state() helper.
>=20
> There are a 2 remaining users (in macros, which is perhaps why coccinelle
> didn't catch them) and a mention in the docs:
>=20
>   | $ git grep  drm_atomic_helper_bridge_reset
>   | drivers/gpu/drm/tests/drm_bridge_test.c:        .atomic_reset        =
           =3D drm_atomic_helper_bridge_reset,
>   | drivers/gpu/drm/tests/drm_bridge_test.c:        .atomic_reset        =
           =3D drm_atomic_helper_bridge_reset,                       \
>   | $
>=20
> Luca
>=20
> drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   =
=3D drm_atomic_helper_bridge_reset,
> drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   =
=3D drm_atomic_helper_bridge_reset,                       \
>=20
> drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   =
=3D drm_atomic_helper_bridge_reset,
> drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   =
=3D drm_atomic_helper_bridge_reset,                       \

Good catch, it came from ce1d0139adac ("drm/tests: bridge: Add test for
HDMI output bus formats helper") that was merged after I sent this. I'll
resend a new version.

Maxime

--52giv6x6vt4urvhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajU0MAAKCRAnX84Zoj2+
dm/XAYCMpDCV4Oo/xLSgxvL3zyBEAr7DNIN9YArjJJqbu0Wjqio5O0Bu+IDYCCxB
VLcuMJoBgIvVp2rQNC1r9gcJamytp/7+U1IAcXBI0Ux6XE30oSnGrP00Pe+137tY
b4pTQ5GQJg==
=JVW5
-----END PGP SIGNATURE-----

--52giv6x6vt4urvhf--
