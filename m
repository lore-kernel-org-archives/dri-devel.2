Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8208BC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40C610E266;
	Thu, 16 Jul 2026 21:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KArvfXl9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CAA10E266
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 21:22:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B71E41A29;
 Thu, 16 Jul 2026 21:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEC51F000E9;
 Thu, 16 Jul 2026 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784236921;
 bh=PQAxKJampJ6BYjnx2tQU51KQl8X51MqlR83zG55ZGr8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KArvfXl9H4RoBsPCCXOF+k6eKVZITLKNR7uk5Cw5gKVsiwKkRgiVyhaauGx34K79G
 Orqq8A0WaxuRWNXmjKg9VTvKgK9lBltcG5WY/nPOsSoZZ7vOCK6NKBzDrmcfodz5J2
 LUlCS8WQOZL3jDgySOWedJJkr53+v5xopknnZWXR4lJUrZxQh51NRWVeeWjlzva+RI
 h+4LuPWG7WSmpJzGyF1sFg+IPKtecM1JLl3/2UJrdhj8Kclnw4m1yGQdy0uwWPO5oM
 aKGoVd9YfLch8z4Yhy/v9eGtKVJk40ZBk+j9DDcCdfNN3wMEujgMZc7ahwR3JvCeqf
 qUI8/r7vlV2Tw==
Date: Thu, 16 Jul 2026 23:21:58 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: tegra: Add Host1x and VIC on Tegra264
Message-ID: <allLaoy3uKyhIgs1@orome>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
 <20260622-t264-host1x-v2-7-ff7364d9ff7b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="expvlkcbwdbfsl3w"
Content-Disposition: inline
In-Reply-To: <20260622-t264-host1x-v2-7-ff7364d9ff7b@nvidia.com>
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


--expvlkcbwdbfsl3w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/7] arm64: tegra: Add Host1x and VIC on Tegra264
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:57:44PM +0900, Mikko Perttunen wrote:
> Tegra264 has a host1x instance with a VIC (video image compositor).
> Other multimedia engines have moved outside host1x. Stream IDs are
> now namespaced by device rather than being defined globally --
> however, the only engine we have using context isolation is VIC so
> we only define VIC's range of context devices.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 63 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)

Applied, thanks.

Thierry

--expvlkcbwdbfsl3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpZS3YACgkQ3SOs138+
s6FirQ//RkjggMzhEiiMStdAyRG34FXZLizVqFQy+9aXzk5WxBZV7vkpMK7em2Dm
wBmGzLoiHH+TYGw2R5k++U7D7zdg9EWtCIREGavtftZpSe4vkhFsCB3dM09ZD1Wi
BempOfPGJ99/QCBbsm+WYrKtB1tct0+/r+t1a4tQS/CvX4oQzb9Db6VtdwcLWGSj
h2YBSFiamk39UE24fOK1m9jplY152PecGBs0ogKcJ93MhsByUenJUwUh3EkOWa0D
HFQ+9YgTDUEIE6vV87qO+YRxAnBhsMue89ljTfluZNK4enFrMNvtjXVhZWxFupZB
4CF0mQ4beLHpZVlniEqMhM0hkPj6VFKHVekEcP1l3ZviOOFL828qqrx03PaxfM9s
o9P7czdtBfuXWzKRT/efnCwDVlM76KoVUUVHjtUtxwtZtOhk2KoGdLCUcvhKzFrw
iG796LIlnSk7d0jPMQpFHAQURrvjLLDsIkvMdNsBQfhM5pGu3/iskPN/YEkQd91J
YkN/cLLH7xAirey8cfn7ravnHroKFecg6w13pO/YjtnHdZqqMkxPaul/vVr4zRJr
nduN2TwJRX1WJIiKvDUGhRzkYNPuC+hPN0hzIuosYUOHH4He1rdKTZ4zI2Sf2OKJ
VOar/djvXVuyclin+QnbvWqGw9d+M9vuCH5ZycVBzKmM3OPkg5U=
=iUOG
-----END PGP SIGNATURE-----

--expvlkcbwdbfsl3w--
