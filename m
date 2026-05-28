Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4E8CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DA210F1D0;
	Thu, 28 May 2026 13:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQZLWfQo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CA210F1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:46:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 287F96055B;
 Thu, 28 May 2026 13:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB6D1F000E9;
 Thu, 28 May 2026 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779975971;
 bh=vLsnfRAsWknOTtYGDlhCmX8HlRYciNFtxaGdwI3lvC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AQZLWfQo30IbMmECOBqe0IWz/L4umlFg0+V5uPpn9AqNqAAH2MlcpB5g2cezO4GB1
 e5jDagmwH/Vc5wjIBEl70mLw/lUkHAGfXRdbqHT7tSm99odei2KSu80qUYI2AKhfMH
 14Af44OtKxQVlOrhC+nTGrhx6dodFfSntUdGTX9fHGX9gLSBn9+y6WNAftpToytYBf
 prf8Ib0/Cf7IGKFOPW8B3GZz5sDl1f2qKRMtTPrNKcDk4aiEhkB16fJd6MJUns6ro3
 akWFNVrhFZE3yqQgypOApuW4NMjZxjNwQZQEpf62hd1ix1XlJ81GUFBil1jTRbWWxC
 ZkqwmHvWQeOcA==
Date: Thu, 28 May 2026 15:46:09 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2] drm/tegra: dp: fix kernel-doc warnings in dp.h
Message-ID: <ahhHGN9mwdXETznN@orome>
References: <20260427184442.693768-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zmagl3xmb7z73b7t"
Content-Disposition: inline
In-Reply-To: <20260427184442.693768-1-rdunlap@infradead.org>
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


--zmagl3xmb7z73b7t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/tegra: dp: fix kernel-doc warnings in dp.h
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 11:44:42AM -0700, Randy Dunlap wrote:
> Use correct kernel-doc format and add missing nested struct entries to
> eliminate kernel-doc warnings:
>=20
> Warning: drivers/gpu/drm/tegra/dp.h:28 Incorrect use of kernel-doc format:
>  * tps3_supported:
> Warning: drivers/gpu/drm/tegra/dp.h:54 struct member 'tps3_supported'
>  not described in 'drm_dp_link_caps'
> dp.h:73: warning: Function parameter or struct member 'apply_training'
>  not described in 'drm_dp_link_ops'
> dp.h:73: warning: Function parameter or struct member 'configure'
>  not described in 'drm_dp_link_ops'
> dp.h:160: warning: Excess struct member 'cr' description in 'drm_dp_link'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2: rebase & resend
>=20
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/tegra/dp.h |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--zmagl3xmb7z73b7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYRyEACgkQ3SOs138+
s6GaTRAAryfYrhDPGzjjcmITEuaH43kfKmC0sjgE+A5DBnaDzEncnGQa5v6OLiby
dq4/XBFkR3NDKewE12uCYFB+bjFupbMaerXYgqp3XvNbXm2CdGb6sJyPui292av7
RYEhWw7hEQxsYubL1ky9HXPXc3kRtuUkECl8M12vAI2R0/34RFYFV/zBk+A8w2YT
k4tzmkycjph0nXTGwdpKTiVX3UR6JytIhy7vlL6jBoCfDLEILpjzIpQsI8pHbF1d
fF3zUREJBc/ZpevErObf0crUue/iTqwlQ6kS9gCXpQx2Npi+3cXrken20fZNLY+d
EznozHcgqIeU9Ws86z8rS75bOS6YMkDt4WWVdwJAOG7mgBefs8D0n3pA9rcVdCd4
6qnpYNcxn4KtDwfiZPMido3z+Gdfzylf4TRFv0Y+Gp2+1euvCOeSl6Fz5QOE/xi1
w4JmjWxCyYoLhqBHvouMk+VUArr3GhrA8vuRI3HMn0Wab20yxDxWtmKLWDcKsuXE
GRaYWebeYO5/Y5iZd3mnf3d6RevrGVhdACEFDIR2N9G5LP7XUDxtpwN15EF9hbKX
ROIgwB7T9K7EMdtDmEeYOif8vAPGv/gSt1Rms+EprzwMbCRNlzF55NfIEqEzCh5p
O8u3m0VeFEtzMrmE0ss19A4LEGfF5toUSWQhWMdbXTGpYVg64d4=
=20yL
-----END PGP SIGNATURE-----

--zmagl3xmb7z73b7t--
