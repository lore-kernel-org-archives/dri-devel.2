Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0406FCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5956210EF62;
	Mon, 12 Oct 2026 08:41:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB6110EF61;
 Mon, 12 Oct 2026 08:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1855A60DC9;
 Mon, 12 Oct 2026 08:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C31F0089B;
 Mon, 12 Oct 2026 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791794473;
 bh=v4LU2Skn1ASzRcKVP/AIgeyMb66m1+2QWIFqvNz6YFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IOoFiBimQJVyxTmKTEKiN75RbtEjYjscd3XiJMbTHhWPtETTOCj+BlUKj6M7pll24
 xtyITuzEEKj1Asb9HA3JokouR/N81zzb6HcohediPMAgIXTsjbtc+sBXrgvFTA1vZI
 adoA3H4o2cYuD6fyN+UdSMC9GdoiZegXS1Hxf+lQ5jOzG0ez1gu9UZvOUYp7DZpqPs
 l6skrSyDOUkDd6ryHoIW6YOYY14LDYlT68xwroRY/OSAI1lTduwUkDzlaD+MRvX4Nk
 tDop2a3VXInxC6fm6crgzH+jWm8+EWcbrXxKUj+7dszdCOKajL1VDHILgaCwMK4jnN
 sgUUTtxzjL01w==
Date: Mon, 12 Oct 2026 10:41:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v9 07/21] drm: add panel and bridge connector luminance
 forwarding
Message-ID: <asyc2ufs5fdpEYrp@houat>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-8-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="5jems2ytvzec5re7"
Content-Disposition: inline
In-Reply-To: <20261002190030.211356-8-mario.limonciello@amd.com>
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


--5jems2ytvzec5re7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 07/21] drm: add panel and bridge connector luminance
 forwarding
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 02:00:16PM -0500, Mario Limonciello wrote:
> Forward connector luminance operations through panel and bridge connector=
s.
> Allow bridges that own brightness control to expose luminance operations,
> and route panel bridges to the panel backlight backend.
>=20
> Attach the property only when a usable brightness backend is present and
> CONFIG_DRM_LUMINANCE is enabled.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This should be split into multiple patches: one to enable luminance
support for bridges, one to do so for panels, and then hook everything
into drm_bridge_connector.

Also, we still have some direct panel consumers, so I don't think we
can handle it at the bridge level yet.

Maxime

--5jems2ytvzec5re7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCasydIQAKCRAnX84Zoj2+
du2QAX9uZCdzUp2cNbQwRzpBto2/jKvvyd6Jft2QbnWTCwR1INhe9mtFeIHgMnda
I5+RyWgBfiwm7rMam6d8DCYVW1chUkYqZCa5veYoDqYhYNvEppdJRkpGZ/6xDJYn
PDN6LcliUw==
=o/yV
-----END PGP SIGNATURE-----

--5jems2ytvzec5re7--
