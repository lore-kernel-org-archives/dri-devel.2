Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7FDCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FBE10E1DD;
	Mon,  5 Oct 2026 10:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="laR//Kh3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E65110E1DD
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 10:57:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E20D441832;
 Mon,  5 Oct 2026 10:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7FC1F000FF;
 Mon,  5 Oct 2026 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791197839;
 bh=6xLLwLidZgnUe0TMCSO79E3gVqVzuOWFlmH7vOndOy4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=laR//Kh3gts/XdkBM8E/qd6ZYaMswfoVRAemzc6WBQhlRiKAvZbRscwDn3Qp5CT/V
 bRBM2seDLsiQzoqLIWGl07tKGZUaQ3GGOFpon6LH5yYXnjgRAo+2vQcNeyvi2TmFWh
 +If1B+gU10dkaMdyXo4ks4QEs0BPWHbShle+qhrfQpY1PjWpq2DH0IuhQjovzL+1t4
 EuSf5LVhEAzv7E/OX6wKAMUXPPvWAefnCZ64TbIP8P2zYBjaSt4iWZhrwTdyO5rojK
 AI2AViODoMRvNJP/aHmzmOTgWdw1fB8oSgxwCDTEW22VtaIvSNshtMIyW3wUszMapO
 5bzekvd9DHI8g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 51E621AC57CE; Mon, 05 Oct 2026 11:57:17 +0100 (BST)
Date: Mon, 5 Oct 2026 12:57:17 +0200
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Ray Wu <ray.wu@amd.com>, Sasha Levin <sashal@kernel.org>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: Re: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <asOCjVMZtOsKzobZ@sirena.co.uk>
References: <asOByBk2DUB9J4qI@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MFXQkl1fDPAmXANa"
Content-Disposition: inline
In-Reply-To: <asOByBk2DUB9J4qI@sirena.co.uk>
X-Cookie: You will forget that you ever knew me.
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


--MFXQkl1fDPAmXANa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 12:54:00PM +0200, Mark Brown wrote:
> Hi all,
>=20
> Today's linux-next merge of the drm tree got conflicts in:
>=20
>   drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
>   drivers/gpu/drm/amd/display/dc/dml/Makefile

>   ifneq ($(CONFIG_FRAME_WARN),0)
> -     ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
>  -    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
> ++    ifneq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
>           ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)

This is wrong - it needs the spaces.

--MFXQkl1fDPAmXANa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasOCjQAKCRAv73Ows9A4
iRNXAQDBaUhGupjkH4IzKMRv7gP00M7xRgmsytzxV/Wjiya1OgD/aJxeSfDz9FHX
FArJq6Q0VlKYdEBYGeykwrx9rpl8OwM=
=qVb2
-----END PGP SIGNATURE-----

--MFXQkl1fDPAmXANa--
