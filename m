Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1171BC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BD110F4BA;
	Thu,  3 Sep 2026 09:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gmN9K4bM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579DC10F4BA
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:59:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2551F417A6;
 Thu,  3 Sep 2026 09:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FDE1F000E9;
 Thu,  3 Sep 2026 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788429545;
 bh=9XVO5Ta0IlwuGw85TjZzFhxUBR2MtdsWEcDSl8od1G8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gmN9K4bMBCw6stpsDmiWobIxQ0RvDJfhDW+32XVV1v8CkVtMzM+T29kPYpSM4s5Qr
 nUyOZRHo5VoOs7iZ5sYNMCceKd0xlqhj7kgTUpWt+ePe5BCNfRpsp7ZslfVWip7DbW
 mH9pEW5/7kDWFbfgJm0umLQxqW4auboR+KbIVH+GgBQlhsgMAUQ/TAjDqkQ+P5UQQE
 6a9MNt8vJrQXUoASjZrtA+hYHmkHEKTFl33RkzgxOO+y5Z9BqIkY87fxc2WU5MlZDr
 dABQNJEkC1n1uUL+1g3GbYJp0TD6/o6gX4cPs2Z18+UndVDAf9cHOHJCc2JGIf6kLx
 p9r/j05v4r3ZA==
Date: Thu, 3 Sep 2026 11:59:01 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 02/19] drm/bridge: panel: move to a new module
Message-ID: <aplEZFfrpnRZ7U4O@houat>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-2-2ab8ee24538e@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="e35cytbik5skmzlj"
Content-Disposition: inline
In-Reply-To: <20260903-drm-bridge-every-panel-v2-2-2ab8ee24538e@bootlin.com>
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


--e35cytbik5skmzlj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 02/19] drm/bridge: panel: move to a new module
MIME-Version: 1.0

On Thu, Sep 03, 2026 at 10:11:05AM +0200, Luca Ceresoli wrote:
> Work is in progress for every drm_panel to embed a drm_bridge, which will
> make the drm_panel code (currently in the drm module) depend on the
> drm_kms_helper module.
>=20
> However that would create a dependency loop:
>=20
>  * the panel_bridge code in bridge/panel.c [drm_kms_helper module]
>    already depends on the drm_panel.c code (it manipulates a drm_panel)
>  * additionally, the drm_panel.c code, in order to create a drm_bridge,
>    will depend on the helpers in drm_atomic_helper and drm_probe_helper
>    code [drm_kms_helper module]
>=20
> Prevent the loop by moving the panel bridge out to its own module.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Again, in the previous discussion, I suggested that you moved the
drm_panel code into its own module. If you're doing everything at once,
it will break, but the only source of breakage you're talking about here
are introduced by *future* patches, not the current state.

So, what prevented you *in this patch* from moving drm_panel into its
own module?

Maxime

--e35cytbik5skmzlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaplE5QAKCRAnX84Zoj2+
dvtvAYDnKu6rquhu1DCTz6Cy0wciLrh0AbLIZ0A/WZT/0I2QkHpX9Vp7+m8lw4AL
TTy4eqkBf0MIQFG44WvI5gIAYH73n10n2JvmboWwp48OVdWuleRQpOF67iCt7ZEQ
hkRvB7679g==
=Fv9N
-----END PGP SIGNATURE-----

--e35cytbik5skmzlj--
