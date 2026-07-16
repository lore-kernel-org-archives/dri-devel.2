Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A89C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2647910E3AE;
	Thu, 16 Jul 2026 18:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YU8sECwS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1E510E3AE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 18:52:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D25D60A5E;
 Thu, 16 Jul 2026 18:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFCB1F000E9;
 Thu, 16 Jul 2026 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784227977;
 bh=LaeiMEfaT45OOnmGBDreJm+Fw+G19mb/94F2DFNupX0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YU8sECwSod2VeXQiI1az1VlJihSIB40jx7JR84RC3pAtSkNFvZkSQtUbaFPq94i/j
 r7Co4ZdkpVUWwqtws4Tkl+jNl5RJ1aCJfBFk3cJZu9C8CtlHcTixm5tV8jGzVnrL56
 G7VdRIL99ihZ7fFuiV4sWMgNGUGll+XT0oMxnTjOrvDmvZ/eerIC0w93CIF+Cr9UxN
 HVABdxD4dr9fj635Askh8LA5bCq65WplzfC1xYwoPQ/3luVCYwqcaGubBVpK50p0TG
 nyDLQAg2DJwxKRG/dmAzPNkhxNMfbX0qqzrCuh6XC54MUEwiDTg1y5q1/KMg5OCKrt
 oBuidGO5qPFIQ==
Date: Thu, 16 Jul 2026 20:52:55 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Miscellaneous fixes for the Host1x driver
Message-ID: <alkodFCXR7fqj_X9@orome>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7plpwo6d7g5gq4wo"
Content-Disposition: inline
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
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


--7plpwo6d7g5gq4wo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] Miscellaneous fixes for the Host1x driver
MIME-Version: 1.0

On Tue, Jun 09, 2026 at 05:09:16PM +0900, Mikko Perttunen wrote:
> This series has a number of small miscellaneous fixes to the host1x=20
> driver.
>=20
> Patches 1 to 4 fix various logic issues that are unlikely to happen
> but technically possible.
>=20
> Patch 5 fixes a return type from unsigned int to int -- no functional
> difference.
>=20
> Patch 6 adds makes syncpoint value arithmetic explicitly wrapping,=20
> mostly to help static/dynamic analysis tools.
>=20
> ---
> Mikko Perttunen (6):
>       gpu: host1x: Wait for timeout worker completion on channel free
>       gpu: host1x: Avoid double device_add when clients already present
>       gpu: host1x: Fix offset calculation in trace_write_gather
>       gpu: host1x: Avoid stack over-read in debug output helpers
>       gpu: host1x: Change pin_job() return type to int
>       gpu: host1x: Annotate intentional syncpoint wrap-around
>=20
>  drivers/gpu/host1x/bus.c           |  2 +-
>  drivers/gpu/host1x/cdma.c          |  3 ++-
>  drivers/gpu/host1x/debug.c         |  4 ++--
>  drivers/gpu/host1x/hw/cdma_hw.c    |  2 +-
>  drivers/gpu/host1x/hw/channel_hw.c | 15 +++++++++------
>  drivers/gpu/host1x/intr.c          |  5 +++--
>  drivers/gpu/host1x/job.c           |  2 +-
>  drivers/gpu/host1x/syncpt.c        |  7 ++++++-
>  drivers/gpu/host1x/syncpt.h        |  3 ++-
>  9 files changed, 27 insertions(+), 16 deletions(-)
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260608-b4-host1x-small-fixes-a-081cfea2c073

Applied to drm-misc-next, thanks.

Thierry

--7plpwo6d7g5gq4wo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpZKIQACgkQ3SOs138+
s6FPvhAAmH6nr3iKPdhnASwRHNyOJfSVLgLtKAlSbG0Db06/7cfH0uK3xpGOE5iG
FCNPQ9O2RxCtutWhSOl+Fy9OchoOe/JxVqenzoF3UL+8DirxZtGQzV1HZ1tC8FQU
D2FU2oDNjNHYom6f3teFhljrsgEfi19VOURpS1EzJ2SkNRqQmRWqaUaBA+7OtKDE
6P17AaaTuKGPftrFDGMmwMqEYMosmEYNp/n6GfSBEpLVSB5vnTmBQpPujl1Xj7W3
pLZZtlk+BH/WJhnk7kVUcjHzkpKcxJ6hzD5dOa4Q5KQsiA+lJNvqwXsM/mJLfGOK
dG2cuxrv8oz2MLyWX2NEJKLpjLPCmJoAKXN+xZGtwc++VfU3nmxwhrAqksL8FdKa
MjEKgQQf8h+qZbtN2sADG8JYOjt4aA9vAYZxHJxD8nBL7C6jMZKscMjU4xHynHx3
Y43Lz49t5q5L9EYvDRE0LPWqphk5qjC04kUqOCDGQiEp4RrJfLy/Rs7QN04JreuA
5iInv7xJW3OEt4xdTl6ojbzYgAd+JMHHYInmG77FX/5eqtmHGHHsLGLk4oFLZJBU
1nh5rbXScClpRAci9SQe+ThlR8zAeRmwa7UggWLVnPlzsFQadBe8XBIi9+s8yjL3
Frpu8FuitEIrf282M2Etc49tZsMJFrTN/9OpT/1uxp+A3IUwgZs=
=8bVZ
-----END PGP SIGNATURE-----

--7plpwo6d7g5gq4wo--
