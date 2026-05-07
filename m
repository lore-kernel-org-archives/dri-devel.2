Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B3FCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E612D10F193;
	Thu,  7 May 2026 14:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l56QzxdB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D117710F193
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:58:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 15EFF6015B;
 Thu,  7 May 2026 14:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CE4C2BCB2;
 Thu,  7 May 2026 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778165881;
 bh=3p/GQpkMmyFcb+5cbWtULSyvjXHvqKU0BX5xnK9DDoo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l56QzxdB3EoXVtSmyV223W2jOWqei39bHytUw38H/G/9DSYZMIO1klatapxsD+5+0
 We0FnozAmVlTuBfOtBasUzJsXn6Nj4wLvo5LxKt36Klgo1NWezlFcGjRj64J4FXcdk
 C7h6hEb4RRN9EkJcpEOW5mT1XTvIIPzpiDdlfabmghXWdObK1sEnsrgs2CBU7A7GZ+
 fthDOruUzBvdL4It7skEEFxcTRoMHLWqW2HiGeC2JlYd2TFcjrQQaaxBMWjstcWOjN
 dTj/HrZjC7vfRVCyzRgSRyDGz7eYzocgFTeEhSdBnDnsW9fhbCycDDNysEE02SrE9g
 vNjg+/pq188ww==
Date: Thu, 7 May 2026 16:57:58 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Michael Tretter <m.tretter@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] drm/panel: Use refcounted allocation for remaining
 panel drivers
Message-ID: <20260507-frisky-spoonbill-of-defiance-dcb8cd@houat>
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="axdda5jrsphvlkw4"
Content-Disposition: inline
In-Reply-To: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
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


--axdda5jrsphvlkw4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/10] drm/panel: Use refcounted allocation for remaining
 panel drivers
MIME-Version: 1.0

Hi,

On Thu, May 07, 2026 at 01:52:58PM +0200, Albert Esteve wrote:
> This series converts 9 remaining panel drivers from the deprecated
> devm_kzalloc() + drm_panel_init() pattern to the refcounted
> devm_drm_panel_alloc() API. This follows the work by Anusha Srivatsa
> who introduced the refcounted panel allocation infrastructure [1] and
> converted a first batch of drivers [2] (the last part of a 5 sub-series).
>=20
> Reasoning:
> ----------
> The old allocation pattern is unsafe: when the panel device is
> unbound, devm frees the context struct immediately, but the DRM
> device may still hold a reference to the embedded drm_panel through
> the panel bridge, leading to a use-after-free. devm_drm_panel_alloc()
> wraps the allocation in a kref scheme, so the memory is only freed
> when the last reference is dropped.
>=20
> After this series, there are no remaining callers of drm_panel_init()
> under drivers/gpu/drm/panel/, and drm_panel_init() is entirely removed
> from the public API.
>=20
> [1] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-0-dad50c=
60c6c9@redhat.com/
> [2] https://lore.kernel.org/all/20250710-b4-driver-convert-last-part-july=
-v1-0-de73ba81b2f5@redhat.com/
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Aside from the minor comment on the doc in patch 10,
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--axdda5jrsphvlkw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCafyodgAKCRAnX84Zoj2+
dtAAAYDNPWTlga6y0Fxc4tlWyLoAE4rKE+OTQ3iJSTsZUnBTDUmhqatp6S6OqMrY
7w6ezFUBgPXKOvTFbC3BkHd0ZgI7FyRgRmGaCdEKmaHerzU0j7asKYwCqej7PfWo
Zr7BfCdzrA==
=rnFm
-----END PGP SIGNATURE-----

--axdda5jrsphvlkw4--
