Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C966082BFC
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1420DWV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B26C112DE2;
	Fri,  6 Nov 2026 14:00:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7DD112DE3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:00:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8C2660D07;
 Fri,  6 Nov 2026 14:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16201F0089F;
 Fri,  6 Nov 2026 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793973641;
 bh=wRVjIXy9TGBWTWpR1Rc+WZB3zQiqe4/4/J3dFtbs9zY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R1420DWVifmxmagNdoRxzZEgs/x2BPuX22tsR4ydJOJE6YHtmhXAJzuBQcwEb5i6z
 vyT3GFCozyBOdeA98m3xe70KhUAzyuc8GUyWYUlyDntqf355llVRiXcdbDF4laC0q8
 S8ah/xRCakntFQnqXwWIm0TpQT4wGxwa+jHDm8RMFqGgI+k2XixOfWoDGHvObjzsj1
 aOSze9h0zcQQvykGTKj5nCC4tUPzgCBOKrFZlJyxldUxzaJhykzDNXAS0pmT011gfv
 fypKx+hvGJkRIPrTVkstJE3TB3VuxCFFhIsf+1y2qxhX4dYseD8P9E0of6o4HdZKIF
 5wyrZYbqBtbiQ==
Date: Fri, 6 Nov 2026 15:00:39 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/10] drm/tegra: Make panel parsing by
 tegra_output_probe() optional
Message-ID: <au3dMlmsLEOUqan9@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-7-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n7bv3uwiurpn2o3g"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-7-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--n7bv3uwiurpn2o3g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 06/10] drm/tegra: Make panel parsing by
 tegra_output_probe() optional
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:06PM +0200, Svyatoslav Ryhel wrote:
> The tegra_output_probe() performs panel parsing unconditionally, even for
> devices that do not require it (such as HDMI) or that handle panel parsing
> on their own (like DSI). Make panel parsing configurable.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/drm.h    |  2 +-
>  drivers/gpu/drm/tegra/dsi.c    |  2 +-
>  drivers/gpu/drm/tegra/hdmi.c   |  2 +-
>  drivers/gpu/drm/tegra/output.c | 52 ++++++++++++++++++----------------
>  drivers/gpu/drm/tegra/rgb.c    |  2 +-
>  drivers/gpu/drm/tegra/sor.c    |  2 +-
>  6 files changed, 32 insertions(+), 30 deletions(-)

Does it break anything to try and parse this even when it's not needed?
In all cases we error out early, so there shouldn't be a whole lot of
extra overhead either.

Adding this extra parameter just adds extra complexity for seemingly no
benefit.

Thierry

--n7bv3uwiurpn2o3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt3YcACgkQ3SOs138+
s6E8exAAiH/mHZ9cuL6ulrpqerIySRaZiLUbRbSebdUEExACTAtEOTvyEZ56IQq6
cR/IkBzw3iJ9JwIqPZzGa06Vn0PxjKspBQZvo07AaB7TlFEHMG6YHG0TVg3ZNWDs
lRvkYey20lYjg8TlxyTsQYcbp4W0u61hauzvEXSLlLvKRNcJPeW6imxriMpdwlVB
BAgE3r06ECHjirSDRS+ezIe6jtnB5ptx3lzPK1LZRoTXk2zAX0R8ccSKF/zWK6cp
frsXwwOrobyjPdqx19tIAQmvGkyO60BYshMxX+zpoZnNkoaIoErgnZcqXZFoDw95
I2VGZdJMEQmSH1At8ArHttea380qBSLTuPUs7D7U1xnlmSL7gk/3NwYa+/79B7ns
66llAQNwxNSqiukjVBbKe8mTIXKWmTwWmcg6aAL+CrvajG13qbJW9mhQ5mX/Xh86
y6I7PhQCuWiJ7iexFW+/4v6SF6T74d3aqa66EHPbu/dZmxQ71BZEn2Mu2e8hWK0e
scMT6kYp557q63t68kUt8+9AvphY1seWA9EuDe36DxrmcuDSJh+dFO+53XbVGum9
CuYXpEd0O8NRShfAYRbW6cWgekWhgq58ywU/dGxwNOgz2F7JBrMTa9919dXsVe7t
te9UHAL/6gzYA6n1+3FYpoeefVIBL3TZar28SuKEY5mMxv2z98o=
=Z25q
-----END PGP SIGNATURE-----

--n7bv3uwiurpn2o3g--
