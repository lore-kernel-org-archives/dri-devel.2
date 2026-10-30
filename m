Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F2606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Njy3M6el
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8261126C3;
	Fri, 30 Oct 2026 09:29:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64B11126C3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:29:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97B3E434CD;
 Fri, 30 Oct 2026 09:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F261F000C1;
 Fri, 30 Oct 2026 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793352576;
 bh=JE2Z6jsS2IrzYo7G8NPWpMa0q9fIt8haCNz10tvF5ec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Njy3M6el+TKht2rHSOwWZIZCSp6SuLvXo1Y4YF6EaOKBnGUNFlH41isWyap9K4XRc
 aYLpViO9wVelb53Xbh4pO7grML4KzjDWd2cMD8khehVquisLFHQcAuvSFy6v/gRfHw
 gw4rGVS+/DRH4qGxMAyNlA248D0xKcBXnpgnmzE+B9fifQwipkxJU5vt8dZDAFtEXP
 CZq1dpdRzeiZcT+LN4jrPWOo4gky4MVmGubjMXvM21pFGbqM6A7YtM4EROC6e2t0ka
 OQ+txcBHxKEJ5ktcff4aZm323d96nlGeZOH3ZfTk7QPKt9E4whDTsx7CN8ykH4mGKS
 2hZlFuOZWyWcA==
Date: Fri, 30 Oct 2026 10:29:32 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
Message-ID: <auRjGM7briuvXDEg@houat>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-2-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="obui6kiykwkqqmel"
Content-Disposition: inline
In-Reply-To: <20261029152909.234584-2-clamor95@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--obui6kiykwkqqmel
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 05:28:59PM +0200, Svyatoslav Ryhel wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> The MIPI DBI bus allows modeling DBI hosts and peripherals using the Linux
> driver model. DBI hosts are registered by their respective drivers. During
> registration, DBI peripherals are created from the device tree nodes
> provided by the host.
>=20
> DBI hosts expose operations that can be used by peripheral drivers to
> access associated devices.
>=20
> The original code was authored by Mikko Perttunen; I have aligned it with
> the existing MIPI DSI implementation.
>=20
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

The SoB situation isn't right here. The author is allegedly Mikko
Perttunen, but you don't have their SoB, and yours isn't there either.

Aside from that, which MIPI-DBI type is this supposed to support, and
how do you intend to support Type C panels we already support through
SPI?

Maxime

--obui6kiykwkqqmel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauRjeAAKCRAnX84Zoj2+
dswoAX4ra2Q81kXA1DbFkC4tPY6X14by01GbUUlx6j/YMBKNzGv+0UiRjW+r+qyN
p43Di2EBf29qbXNvycMurCZaRKUxPTjSvl9+Bk3BHys3GriT5iH8UCJdva57/eNe
XPZpOdQpeg==
=YMzq
-----END PGP SIGNATURE-----

--obui6kiykwkqqmel--
