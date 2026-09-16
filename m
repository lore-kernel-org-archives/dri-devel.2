Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99913C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEACC10E7AF;
	Wed, 16 Sep 2026 07:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kGTc1mHH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E039610E7AF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:45:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62D716020C;
 Wed, 16 Sep 2026 07:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886541F000FF;
 Wed, 16 Sep 2026 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789544741;
 bh=TKR7MTZf9BQYr7s2wrQTWr8Wv49tHd+l1QtU21QVJsE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kGTc1mHHiAz6khVZLjMIhZ2hgtQsLPwVt3D2iWvaaeOMc6U5AoTJW5OZZ0zWfdZQD
 FObtO8CJq3fHTAn/7W2ysXzSKZdXXDhuBrcy8A81768yx41XcV3D4WWrUt/yN7jKQ4
 Bomiyv5+ecH82rr8IXYivf3FQYdwRA9bRnSrddT1e6P+mvZWOCv9v8Vby+My8i3bEs
 SlOAVNbvP0D/Pyd7Fm3M0E2pGddhYCzHPwwpZtS45/wsGmZZHvDzmjXu7sxfDUg3o9
 KncRoLlYcxnhomkBgCyy17uXl43stOC1MzLHf+xPd/CVi42M0vfdBEeLlxgju5qm7d
 YrFutgKNARbyg==
Date: Wed, 16 Sep 2026 09:45:37 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 Javier Martinez Canillas <javierm@redhat.com>, Hans de Goede <hansg@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/11] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Message-ID: <aqpJCbC2mB8d8mvX@houat>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
 <b1cb8dfd-4ec8-4024-bcbf-d22b2f4cc55b@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="2gvbsxpflzciprdl"
Content-Disposition: inline
In-Reply-To: <b1cb8dfd-4ec8-4024-bcbf-d22b2f4cc55b@suse.de>
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


--2gvbsxpflzciprdl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 00/11] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 08:54:44AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 15.09.26 um 16:24 schrieb Maxime Ripard:
> > This is a follow-up to the plane reset removal series, and part of a
> > larger effort to remove the reset hook from all KMS objects.
> >=20
> > The CRTC reset hook is overloaded: it is called both at probe time to
> > create the initial software state and during suspend/resume to reset
> > hardware and software state. These two roles have different
> > requirements, and the reset hook is not fallible, making error
> > handling difficult for the initial state allocation path.
> >=20
> > While reset has the semantics to reset both the software and hardware
> > state, the vast majority of implementations and all the helpers only
> > reset the software state, making them equivalent to
> > atomic_create_state in practice. The atomic_create_state hook makes
> > this explicit: it only allocates and initializes a pristine state
> > without any side effect, and returns the state pointer or an ERR_PTR
> > on failure.
> >=20
> > This series converts all CRTC drivers tree-wide from the reset hook to
> > atomic_create_state, then removes the reset hook from struct
> > drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
> > hardware reset logic mixed into their reset hook; those are moved to
> > CRTC creation instead. The conversions were done using a combination of
> > Coccinelle semantic patches and manual adjustments.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> It might be my mail client but the formatting in patch 5 looks off. Besid=
es
> that, for the series:
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, I've fixed it while applying

Maxime

--2gvbsxpflzciprdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqpJIQAKCRAnX84Zoj2+
dtDQAX94/cBvzQ5Aq5QRIr1UJ/bOLyNuUMj4PdfWieKNJ70GkWP+4R+hk3pMTuQw
DmJkBwwBgIuVII9qJTL+nG2HU8OsXb26r5OWEdGlmvf8/KfuJ9J9uRpzO+Vg+fo0
0O+8z/HFIw==
=tUg7
-----END PGP SIGNATURE-----

--2gvbsxpflzciprdl--
