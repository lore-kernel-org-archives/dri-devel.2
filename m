Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFD8CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 17:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B8F10F565;
	Thu,  7 May 2026 17:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gF5k7064";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E862B10F561
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:08:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 13BCD60181;
 Thu,  7 May 2026 17:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A0C2BCB8;
 Thu,  7 May 2026 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778173710;
 bh=suyPfzFWG3JWdV6ioIa954aqyOij9B/xQZK9I1fmViI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gF5k7064XgRa3oooRTrG3aYRFbr/JA3bl7v0SSF6MvdfhO3WVX8PiEPs5+ychW6oy
 iukQ/9HuRuL1v7wMEVrOTv6kAPGLLVB9uP4pP4RY6UNumahTLrqTeXaSNTqS3PO5c6
 7/ZGStoPYABSzg9Btg5tGfjHFXtpY/AR2kHj8WUhvTvvSQRZPckvRy8vZ+BT4UIBkk
 66CovsxT9dU6FTPo2zjNWM+5vl9N+qAxq+V1uYcWNIXIY0ZECsnQXlNWNs7o5uodHz
 kws72mj6uJN5lmHUw/bjAHaGHL3DMjuSIYTVbgm1bw11S5vk1UaHTbnEkRCOJsf9cn
 k9dbTwjU0+bOw==
Date: Thu, 7 May 2026 18:08:25 +0100
From: Conor Dooley <conor@kernel.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, onlywig@gmail.com, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 1/2] dt-bindings: display: mayqueen,pixpaper: add
 pixpaper-426m
Message-ID: <20260507-bannister-bobsled-741e2b1e8451@spud>
References: <20260506-clique-safely-6dd507d0593f@spud>
 <20260507023234.3655616-1-zaq14760@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a6wA4fy6ikIU0vAC"
Content-Disposition: inline
In-Reply-To: <20260507023234.3655616-1-zaq14760@gmail.com>
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


--a6wA4fy6ikIU0vAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 10:32:34AM +0800, LiangCheng Wang wrote:
> Hi Conor,
>=20
> Thanks for the review.
>=20
> You're right on both points.
>=20
> The new panel uses the same DT properties as the existing Pixpaper
> panel, but it requires a distinct compatible because the driver
> selects a different panel-specific initialization and update sequence.

Can't see what you're replying to, but please note this in the commit
message on your v2.

>=20
> The second example is also redundant, so I'll drop it.
>=20
> I'll fold these fixes into the next revision and wait a bit longer
> for any driver-side feedback before sending v2.
>=20
> Thanks,
> LiangCheng

--a6wA4fy6ikIU0vAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzHCQAKCRB4tDGHoIJi
0uwEAP9CjXoJzpH3TBT6wrxo6eZlAognceKFmQ0dDe+VPyzmIgEA3gC5m598PlVw
4L/C4evW/mJd0XIcpZ7cQiFnf0QdBQk=
=bGWX
-----END PGP SIGNATURE-----

--a6wA4fy6ikIU0vAC--
