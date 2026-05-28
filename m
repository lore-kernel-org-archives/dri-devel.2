Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC59CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC13510F0C5;
	Thu, 28 May 2026 12:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KbM4Fwjo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DC710F0C5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:09:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC3E160123;
 Thu, 28 May 2026 12:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF12C1F000E9;
 Thu, 28 May 2026 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779970166;
 bh=6EsIe6+QcTk8dNWj4zK1Rd5fuD0TttLl9s4Yfx92BeY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KbM4FwjoMr5keIYGy7CsRrRWFBXa+scPxzlVNJs90A9xACLh8MwMhWzi6xtDEerQt
 4NWV6PEclMG36IGwGM/x41Wk26FbKE0kbplDFSdr76fyr9eoUfc+7k6Qpym+NHOkol
 liT1jwgNPTbzBlKnmGMHLOytmecI77kC1dI7stKni+WeSxvojO1RW31gKNKWlpbWLH
 Pm9+TjKfHZdLjS5It3cmbqpKgI0DdB/FNO9BvrG1Cxg0O+6qesFja9YfQ39KFew6DV
 JzEW9XzIky+1PGhY1uHTKIKvCg7sg8rRBQ1yVVzDVXxNOTQ7HA+dr6kRkc+3BCCOco
 Ip57rp+XdCr3Q==
Date: Thu, 28 May 2026 14:09:23 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/tegra: dp: use str_plural in
 drm_dp_link_train_{full,fast}
Message-ID: <ahgwaOX8TJlpZP0u@orome>
References: <20260521194658.366737-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tuovdn66hye2i6w4"
Content-Disposition: inline
In-Reply-To: <20260521194658.366737-3-thorsten.blum@linux.dev>
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


--tuovdn66hye2i6w4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] drm/tegra: dp: use str_plural in
 drm_dp_link_train_{full,fast}
MIME-Version: 1.0

On Thu, May 21, 2026 at 09:46:59PM +0200, Thorsten Blum wrote:
> Replace the manual ternary "s" pluralizations with str_plural() to
> simplify the code. This also corrects the "0 lanes" case.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/tegra/dp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Both patches applied, thanks.

Thierry

--tuovdn66hye2i6w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYMHMACgkQ3SOs138+
s6GZ9A/+NK7XAH7VW4nq1/fYZDrFrMsV1SkeL33baIKmphllBPJBmTRkJuCsUMvs
Va9CAR+GT93IQy9EhiFuFqndHf/T5o6vSFi/E/fsxCXcU9ss5/0VhPaq3Sa56TI0
vE4+FZoKv1kfD4YcJX/sGTl2tJy/998vPjOWbt0pJYe5I7q6/+xkS59a6OwcqNNW
JSV8nSgwf7L3TyO9uAVPE4RXYZHdFEc0nhWoLWDHB/o3h46vfzHrf3Tz0QmgfRUS
wKtAJGibDKV5DUAEHfA41PYek16aVimm8NiRLQ2eDjeZDKBJOY4oBXtMn1dNb+qw
bB6qtI3A69pniQqIjU3sOW9neZUGz0QLpJygTShtQgyrAE9pEiSE0T80dQE8qUdy
EJm3PtLpcOkqolkxONuwwyJFiJBn5WN7n8aQMaCNSKVhKHcwHTD9VfqugONaidbk
9qKMYZ3m+5uet1p9SfaQY5k7H3/RyGBebdLIy2Whesqy9Xk3Z0s4kqxvghwC42Ql
AXEOC91Vk79scoXt3DY2aM9mPW7N8nolNAl4QWzRaHq+lrzWS/K/k0cYgi6C8M17
JmPtQmPUGacvNU2J4uHmLuzPoZD6YEAf+L/87Zr8itnGNUYxfjoj8OvbOs3d+6Ec
x9SzlHNQ0MnQRpWeuJxamDZQ72l5P2tfkrb3IEuky93QJeLV1TE=
=mIBc
-----END PGP SIGNATURE-----

--tuovdn66hye2i6w4--
