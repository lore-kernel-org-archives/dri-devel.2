Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0325DCD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631D210E9B1;
	Tue, 23 Jun 2026 07:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aRgdPpnd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8E510E9BE
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:55:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F05DD434F3;
 Tue, 23 Jun 2026 07:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E6B1F000E9;
 Tue, 23 Jun 2026 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782201321;
 bh=uuDiLL3rWdYC9eTaYQ267+USP5fq+tG1tEtS4TluUqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aRgdPpndYJzf46s8QpLYBy5AOGXx9hwsclV7j3ShiFtDg8SPMVkLcSXHceu7gVA12
 7dcY5tzY4mM797HofjCHmJrl0b8gFTq7+NoleBUPrQeuX72s54fnsA/tcYMu9HUe4N
 NXJ7VRy+7sJ1LrRqZVprFJ/ix6Vv4xs0lvwiAjsvQfFB9oregY8H+nG/i5/Yr8AHX1
 aNjM6zMbCLBT5j3Zp7PU/fxlDqCc5vD//EybmnOnxdnVsMk6A1F40PHGYbS2t1L8iF
 zVC9tEfK0BcB49o/8Y+/yd7nFzE3DNDbt9c6Z71Yuo1uRE0VKinOMKaPbAja4Le9fl
 mIH3pLZdGjg4g==
Date: Tue, 23 Jun 2026 09:55:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, 
 deller@gmx.de, azuddinadam@gmail.com, chintanlike@gmail.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
Message-ID: <20260623-silent-dramatic-crayfish-970cdd@houat>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-5-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gw7ljox4iins6cyc"
Content-Disposition: inline
In-Reply-To: <20260622152506.78627-5-amit.barzilai22@gmail.com>
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


--gw7ljox4iins6cyc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
MIME-Version: 1.0

Hi,

On Mon, Jun 22, 2026 at 06:25:06PM +0300, Amit Barzilai wrote:
> The SSD1351 support was added to the ssd130x DRM driver. To avoid
> confusion and irrelevant updates, the staging fb_ssd1351 driver is
> removed.
>=20
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>

fbtft uses a different dt binding iirc, and has a different uABI, so we
should probably keep it around.

Maxime

--gw7ljox4iins6cyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajo74QAKCRAnX84Zoj2+
dnmXAX9P+PJBYkVuU9e3AolV5ij1GbfkoFUpN0wN60OCuslj4w/fGr3BYEMXqoYD
b41D4yEBgLBDEfa8uCc5AlDq4yYn4UgEjNwttY0JaZRx4btU/jCkbEOf54AUNVMb
ZqzRxMu2+A==
=K+pu
-----END PGP SIGNATURE-----

--gw7ljox4iins6cyc--
