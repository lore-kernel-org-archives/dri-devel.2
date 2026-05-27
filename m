Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EB7CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 05:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A0C10E236;
	Wed, 27 May 2026 05:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bIpjyl69";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8AD10E236
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 05:55:15 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4903974854dso49649185e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779861314; x=1780466114;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c50mz8/OMleInqbX4ArLESamRXgTiGj9hU87miF2NLk=;
 b=bIpjyl69ZDMCZ8cVDO+IYTiWxEL4W8UpBk7cVktN1ecNEULvE+31S4rjW56lMEOTW3
 MqcnsBK86/nCbWrfGVFL0dOaxJI9uYfAn38kT0rMgZ2BNVrk63braJacJvM2dDG9fil2
 gqHrGTp9VxkrIDH54/0PR0yCFPGSqSFfbyxq/OJZnkRVNaUWMJKHcGDz3FPU3dLBUi07
 mEJTtCUAapIxfduR4UfHjjQakjSlNVRu16+prjDfmXpXpIAUy0951inFD2Pf1Ceu+EXF
 tny8vNOHtHk07d9wzxIse2KQPYpyoO4AHs1nDZcbb/8p+GN13d96AY+hqBMVtBARVDdw
 qdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779861314; x=1780466114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c50mz8/OMleInqbX4ArLESamRXgTiGj9hU87miF2NLk=;
 b=TONWH+GC/MLZN+RxP7DhlFXrbX3FBEPBXPJnjwNR7CSwPBTWPctlF1qmN3bcuN30ev
 tbEEzn7J8miWNm87oVS8rvbq6FdwG1o5X/SmJ7s8uGxE3xE/eYxrJ6tfMe99OBtmw5OL
 Lbr6ulXQ81FeIlONUiqJ7su43PtNyT3nicoUah9WlOuq23G3XlxncZiw76jp1CWqWsjK
 FYO58QumBAa2C1IhMq/OKDAN4jk9j5v1dBV10Z2w0MkKKRK3KnIOCUiLbLLeLjbKN+aF
 s/a4ePodWGuAwST6xJi3exv7GBQ5KBQ1eDoIw6N0uXtndR2E8oiW+Dl8YUotbYHJ+qSq
 oPtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gdu5Ho4fZ69U1yGIf5w5Ut/wveCnd8l0Z02eocUel7IcSzOD5SAUudk2g5K53YSBfUdwVheVvR98=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVsCW2zzoc7R0BVmnd8mKJAYAmedb+1guLblAkuP2HcD6ck/L7
 6xXSCdxmh21zix1nmZwliqmi2qZjqsA25fQxUxvQ4o4FerdSyCYQq3iw6dQ47uyKrOI=
X-Gm-Gg: Acq92OGliD6nyAhQGtQ2qYuK3MPsbZ19zzxFO3+f/xbAausgtgqmEIMl7lspxSKesPa
 I1Qc7+NBA7GxRgZc8eqHGzgh5IKwM1Ilogmp+v/eS2ExFrS/twHY9+NVMKRA6rNkNooOvNXi9G9
 59Lu9fysOJWl0UEhN+araroVb7llL1EOLAUMQks1mJGzaKnvnnMl4PDc5IE3YjiaffLM5lSVDyZ
 bUKu+CWN9yzYQIlyfR4+j793jXR7CrPTnF5VECs4u92VyCAeb5fwiLAPF3AtZh4i5wQxmkY6t96
 xzb4jx1U+UFwY0Dg3FJs1qnxwkhNlppswRYolbA4VevWU5ENeXrWRs20vPGOWLuOh0QwDP6mF6E
 j+tq/JhFeZb6CFwFXAHpjvIvRBSOHT3El/RU5wNwbejI/JwBtip+JDg5mH6CITKa9Lb4qv5dqWl
 n8dZ4pKwSlRrykh+1IGRezXL69ddxWh9gRS5jP46VWuWdBaeqOLa57L5eSRS3T+vAuaHvYnSzfW
 U22MMUvlV44rtA=
X-Received: by 2002:a05:600c:8599:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-490424acb4cmr286306315e9.8.1779861313464; 
 Tue, 26 May 2026 22:55:13 -0700 (PDT)
Received: from localhost
 (p200300f65f47db041edccd9970843bb8.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:1edc:cd99:7084:3bb8])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4907e69dc39sm11042195e9.4.2026.05.26.22.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 22:55:12 -0700 (PDT)
Date: Wed, 27 May 2026 07:55:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/exynos/gem: Fix printk specifier for gem_object.size
 and dma_addr
Message-ID: <ahaGfhW81fcW7h2u@monoceros>
References: <20260408064936.1342321-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="matup4lkrscj23am"
Content-Disposition: inline
In-Reply-To: <20260408064936.1342321-1-wenst@chromium.org>
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


--matup4lkrscj23am
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/exynos/gem: Fix printk specifier for gem_object.size
 and dma_addr
MIME-Version: 1.0

On Wed, Apr 08, 2026 at 02:49:34PM +0800, Chen-Yu Tsai wrote:
> In the recent change to use the GEM base object's size field instead of
> the exynos_gem object's additional field, the printk format was not
> adjusted for the change to size_t type. This causes a new warning on
> platforms on which size_t is not unsigned long.
>=20
> Fix this by using the correct "%zx" type.
>=20
> While at it, fix the specifier for dma_addr so that the cast to unsigned
> long is not longer needed.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604081331.jSJQSVmg-lkp@i=
ntel.com/
> Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This is only compile tested. Build for ARM 32-bit confirms the warning
> is fixed. Sorry for the noise.
>=20
> The commit hash used in the Fixes tag is the current one seen in
> exynos-drm-next.
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gem.c
> index d9d42809a1a9..f264e170bc26 100644
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
> +	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(%pad), size(0x%zx)\n",
> +			  &exynos_gem->dma_addr, exynos_gem->base.size);
> =20
>  	dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem-=
>cookie,
>  			(dma_addr_t)exynos_gem->dma_addr,

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Still fixes a build warning in s390 allmodconfig builds as of
next-20260527. I can haz this patch applied please?

Best regards
Uwe

--matup4lkrscj23am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoWhzwACgkQj4D7WH0S
/k4YJAf/Sa0klbijQQ3e2afYyNHdRBpeOnuHnt7DkXbXMETQbXPOVvHKTlQXDYOk
j8FttwSGQyKq70nn3di59M5IaFgKtvg4ZH+9ZdN86PBdvz1vYjE8YOKpPQo1NvaU
u71+tkIZr10dm4lqwrFQOLz9wKtVpGWcwLOJOx35dE4AhqDZ2t7d4qF9aX2E+M5K
nSCcuxYGYW9PQ3JOqjhP2DYAkFspPYKTF8ekZiEoPBxYQI8AQtzanH5urgTL5yPD
MMLOIYjAeD1LxDUfUx6uxATzDvYTSAA0ZG8iuOIAALaYa5j3M0GlQGeOZotyr9Pi
NWZH725YiRLgpEpNRqbc5hhIji3Eaw==
=AuW5
-----END PGP SIGNATURE-----

--matup4lkrscj23am--
