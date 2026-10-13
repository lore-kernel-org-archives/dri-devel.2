Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BE3CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4730A10E769;
	Tue, 13 Oct 2026 09:47:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664C810E769
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:47:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3401E41ABC;
 Tue, 13 Oct 2026 09:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866B1F000FF;
 Tue, 13 Oct 2026 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791884855;
 bh=2R4mHyXuGdBOFu9lYXxvIKp3/FCnxVHnd7qOef9FYHM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PFfy4fhOWb0g5ugH6yiiUGD1Z8G/ZsS54+aKKJDXfSv6y92odF5fY+l8Boh4TXdFU
 yuhpx+VpeY83o9n/8/FOXNrMjeJfupoZrTtOmDQIrcV2JKDcUWCY1wBeYkPuSB+tEH
 J2IHXQpMLEBddvPlrq3rXcCkrNDw2RbwKpBbc/k+WaWFxcQVpeeaa3Phtx5wmxXIyd
 exoGJmLuCW5WTKBZggZKnWItiWNb42qIqZtR/GON2S64CmKa/T1K/wSBiTmLlcMIme
 UssQgdTWucl9HnRkdn1jqPkQQjR7ond6oXf6l9m/FRpzZ95ToCHTIViqUhUk6nO9Zb
 rpOJEh0mZdx8g==
Date: Tue, 13 Oct 2026 11:47:31 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Erik Faye-Lund <erik.faye-lund@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karunika Choo <karunika.choo@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] odrm/panthor: fix immortalis condition
Message-ID: <as3-CKkuP54UMDKe@houat>
References: <20261013093150.4186117-1-erik.faye-lund@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ccqodx733gg6sx23"
Content-Disposition: inline
In-Reply-To: <20261013093150.4186117-1-erik.faye-lund@arm.com>
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


--ccqodx733gg6sx23
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] odrm/panthor: fix immortalis condition
MIME-Version: 1.0

Hi,

There's a typo in the patch title (odrm vs drm)

On Tue, Oct 13, 2026 at 11:31:50AM +0200, Erik Faye-Lund wrote:
> Exactly 10 cores is also valid for an Immortalis configuration,
> according to the public documentation:
>=20
> https://support.arm.com/compute-ip/immortalis-g715
>=20
> So let's report this G715 with 10 cores as Immortalis as well, as long
> as it supports the ray-intersection feature. This matches what we do for
> more recent GPUs as well.
>=20
> Fixes: 3b1dc21d6d80 ("drm/panthor: Add support for Mali-Gx15 family of GP=
Us")

And you're missing your SoB

Maxime

--ccqodx733gg6sx23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCas3+KQAKCRAnX84Zoj2+
diiaAYDtVd6e9fmMvaDNOQzVc8TLZMSt64qS35o2m1q5YEZq8xeTJgySrnH4tIZd
9vZHybwBfR41HAgDxMI1+EXEbepalMhJBFXBe7KwTuCSna6MUon7n0+tJnqmvNtK
y9qFuBuW9g==
=PEfv
-----END PGP SIGNATURE-----

--ccqodx733gg6sx23--
