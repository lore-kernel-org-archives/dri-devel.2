Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B74CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275DC10FA5F;
	Fri, 29 May 2026 07:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="N8hYFQQW";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C117010FA5D
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:55:02 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so42132035e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780041301; x=1780646101;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rwrPCj2IqJEcRJugk6Ecz2xdcmK5e89mwdODai47RFE=;
 b=N8hYFQQW+Mp3m8rwEf97j5RgZ/CpWvyivGoDpyU0a42NtnIlCgcCz0XnBfgBaWs4uI
 l3pU3LTa96DXYCYAcGUcqJrEGrFDFoy8tyelzUn72KsRoUKvVf6lypLpEnj9AdmVd0jG
 xZu+TMEWxrZwtxBIrkoBFoFPXyxKqqUfoGwBranA5Q9P8+f55GE4ZxQuguhmJ0kltIUB
 pxkbQ8AofGlWIJfEaiXuWH9iqCKgT/KH8niRY46Phw+VSlGf/yZgdykrAPk/PhWsdgPa
 RVAzMcZzRlEu5kPQDvBlhZ3zHOTs0vK1rs8hqJWSOGAHhQTa+TbrG6LK1hbT3+hSpDyM
 Q12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780041301; x=1780646101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwrPCj2IqJEcRJugk6Ecz2xdcmK5e89mwdODai47RFE=;
 b=eg2GVwkQepTv6xZ4m4p9dagHVDvuF9YrTGwcnZIUXxHUyIqZWlLNNbF865/8nxbhW5
 vr9vVdipaJ2ZfC+XJr+2JbuU620oQMj3594qrwY1x6xjBwQmZHtIzZgV5LgHITegmbe0
 zY22v0UR/nACgml46lctVztFY/UU+WSJ6POaI8fsHIHtkiiDxlcKA4CHlU8Q0G3RtXoo
 lvp9XwsZ4EvxqA/p+9xEfrLPQ6buHjmeIde/NMQEpVZxOFrqkNYPqaGj4do52g4UKMeJ
 +RhqYrZr/xzxqG0WYKaPZ7eKUNZF9nQG/23Hlmz9a1pxysDGWkSBZJrXzYU8YN9vXOH4
 Qk/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w31mttyGu3NRJbPyvoTO6cUQDrd7ehUaZkvKQsBHqjmn7f/PY4IOv6xHLX6UY7sTuiaKKsQ41zx4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYKfCRzeDDcFdZCKNvjY50RkX/jJxAENsTL8KC5NE8a5ATJYyc
 bF02O8OgV2B7DRarJG2+HXPWu3J47qUxg8c+2tTMXDXrZInj5yMLTHm9wLS8lKYscnA=
X-Gm-Gg: Acq92OFT8uZoCSJmjc/8E8JEFtbS6nn7pd+xFBcEvwa7wZ6xIn96l/rvSUHs6dcGNO8
 B82Cf/dhoLdnUgaKb11Bg0tH2/bXOjOA6fwOVoPiF7wa406Wxn2efQjC2TaK4UnAE/c9hWcrB/o
 NtYmPjHvaJSY83RRwa22V+pI3qI+rj4EyYxTkee8mIIYdquwpRhH6a42qCIR7JcXC3jLILW6b3v
 pzos9H7wX8+NKKNtwkUgOrtMiZllO0Be0v12YZjK+kCLelHhy/bqBSFD2MWKmqRCEB54VkT21hj
 vNf7hrnrP8+EY4pKIUDrEPg5fae/2duWzzkUSP/Gmng8ovPaRZAZaoWDNDcxh/CoO5pnm1LtJFn
 hcZdEi9KrkHwr+pgIRgn4yS8mFr090qSr7R+gsmHVEuiiZJnsifVuxKzKJ5nEX6hdlkkT87DGqM
 SzcF4hPjJsmVzB8Lwk3YfSEgmCMB56waPSfRRrcJsUjO1/rleX/TbzkvzIhfp+qtyMKPwbUxVQs
 mLTr5m30rNH83w49pqKPkw677NWArzBoAtd
X-Received: by 2002:a05:600c:4504:b0:48f:be94:d82c with SMTP id
 5b1f17b1804b1-4909c0b33fcmr30600785e9.19.1780041300797; 
 Fri, 29 May 2026 00:55:00 -0700 (PDT)
Received: from localhost
 (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4909ca65f54sm27221465e9.5.2026.05.29.00.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 00:55:00 -0700 (PDT)
Date: Fri, 29 May 2026 09:54:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: fix size_t format string
Message-ID: <ahlFfp-kIqpdPGZd@monoceros>
References: <20260527194525.45762-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jnujdylfqv2kbd66"
Content-Disposition: inline
In-Reply-To: <20260527194525.45762-1-arnd@kernel.org>
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


--jnujdylfqv2kbd66
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/exynos: fix size_t format string
MIME-Version: 1.0

Hello,

On Wed, May 27, 2026 at 09:45:07PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The exynos_gem->base.size argument is a size_t rather than an
> unsigned long, so adapt the printk() format string accordingly:
>=20
> In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc_bu=
f':
> drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: error: format '%lx' expect=
s argument of type 'long unsigned int', but argument 6 has type 'size_t' {a=
ka 'unsigned int'} [-Werror=3Dformat=3D]
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx),=
 size(0x%lx)\n",
>       |                                                 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
>    70 |                         (unsigned long)exynos_gem->dma_addr, exyn=
os_gem->base.size);
>       |                                                              ~~~~=
~~~~~~~~~~~~~~~~~
>       |                                                                  =
            |
>       |                                                                  =
            size_t {aka unsigned int}
>=20
> The dma_addr in the same line is already printed using a cast
> to unsigned long, so change that similarly to use the correct
> %pad format.
>=20
> Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gem.c
> index 297a93b087cd..8e357f2beb9e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -66,8 +66,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *=
exynos_gem, bool kvmap)
>  	if (kvmap)
>  		exynos_gem->kvaddr =3D exynos_gem->cookie;
> =20
> -	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n=
",
> -			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> +	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(%pad), size(0x%zx)\n",
> +			  &exynos_gem->dma_addr, exynos_gem->base.size);
>  	return 0;
>  }
> =20
> @@ -80,8 +80,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *=
exynos_gem)
>  		return;
>  	}
> =20
> -	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
> -			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> +	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%pad), size(0x%zx)\n",
> +			  &exynos_gem->dma_addr, exynos_gem->base.size);

Inconsistent formatting. The first hunk used dma_addr(%pad), the second
adds "0x". Chen-Yu Tsai's patch[1] was better in that regard.

Best regards
Uwe

[1] https://lore.kernel.org/all/20260408064936.1342321-1-wenst@chromium.org/

--jnujdylfqv2kbd66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoZRlAACgkQj4D7WH0S
/k4uLAf8CDNBSWkI/8nW1u/hhrBYD4t2URn0LO0re8mpGRHjxAyA2ted0Ag3jvDa
8F55jr1ySezFOkOTycAdA+yW6AiferDGR6YbeeJURQtgw6/OR0QQ/iHO+PC2ZyjC
9q6ls8fHy2K99TM2nwUh2SjbucVfCUhCXYL8iK88guLXcWdOfAyFJMT5Q1iQEhAU
qW8lFER+hwe6VMeTZQk5CyqPhsUcYz0Pt+qVkGs3hOBbIL505NlsnPzSDgsE6kC/
GnmGyW63GGoVoyA6J1C6ybt/geR4ilr12gm+rZqKDU9Wydfwz/kfmA3sc5JzWVZT
xF6rNWt7febUyDzSmbvzndFdKi1DcA==
=vHrt
-----END PGP SIGNATURE-----

--jnujdylfqv2kbd66--
