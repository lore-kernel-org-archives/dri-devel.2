Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D756CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010C810E042;
	Mon,  5 Oct 2026 08:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nJOnsvUU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0014910E042
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 08:07:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B34E44400E;
 Mon,  5 Oct 2026 08:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D401F000FF;
 Mon,  5 Oct 2026 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791187631;
 bh=pfHW3K5w13Dkio99Zn3/wVEATo3Ndc3O152LdPxJdVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nJOnsvUUQdb6Wx362HMhtoXW9DFoKE9CCIukGK2zMmoxR4DsKElNx1TMaxSZ7qglB
 NrR0cpYD03ZsPZ8W7pUG5lcjsGaLl5kQZcwEFOC2soOavPjFpkebt1RxxpxCQUo8me
 88ELUiHvazikTOV/XyQBiJbhmVqg2WKYBUDw/BeGoXLJKvAgTMGmkg9VSe3qzs9bJO
 TwHjVJ/9yx4Z7DnyGnWQljYvui+IadUlc9raED2+FwnscbybBLer9lZVYgbCYDDlPp
 RAJ0kdvJEvWAHAEoK5t3ckkLkpr+eEnruXbUWTWeR/cF/Vh9gIFimaiIbSQ1ATf0JE
 K6tSEBXibbcGw==
Date: Mon, 5 Oct 2026 10:07:02 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Rosen Penev <rosenp@gmail.com>, Kees Cook <kees@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 "moderated list:ARM/SAMSUNG S3C,
 S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
 "open list:ARM/SAMSUNG S3C,
 S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, 
 "open list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
Subject: *allocflex() (was: [PATCH] drm/exynos: fimc: allocate formats as a
 flexible array member)
Message-ID: <asNWiJT4Io2R7xGt@debian>
References: <20261005001118.576198-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cd4qmvxj2ervr6g5"
Content-Disposition: inline
In-Reply-To: <20261005001118.576198-1-rosenp@gmail.com>
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


--cd4qmvxj2ervr6g5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Rosen Penev <rosenp@gmail.com>, Kees Cook <kees@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: *allocflex() (was: [PATCH] drm/exynos: fimc: allocate formats as a
 flexible array member)
Message-ID: <asNWiJT4Io2R7xGt@debian>
References: <20261005001118.576198-1-rosenp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261005001118.576198-1-rosenp@gmail.com>

Hi,

> Date: 2026-10-04 17:11:18-0700
> From: Rosen Penev <rosenp@gmail.com>
>
> The formats array is allocated separately with devm_kcalloc() and only
> referenced through the fimc_context. Make it a flexible array member at
> the end of the context and allocate both in one go with struct_size().
>=20
> Annotate it with __counted_by(num_formats) so the array accesses can be
> bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
>=20
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fimc.c
> index 09e33a26caaf..079d24d0671c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> @@ -99,7 +99,6 @@ struct fimc_context {
>  	void		*dma_priv;
>  	struct device	*dev;
>  	struct exynos_drm_ipp_task	*task;
> -	struct exynos_drm_ipp_formats	*formats;
>  	unsigned int			num_formats;
> =20
>  	void __iomem	*regs;
> @@ -108,6 +107,7 @@ struct fimc_context {
>  	struct fimc_scaler	sc;
>  	int	id;
>  	int	irq;
> +	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
>  };
> =20
>  static u32 fimc_read(struct fimc_context *ctx, u32 reg)
> @@ -1273,20 +1273,16 @@ static int fimc_probe(struct platform_device *pde=
v)
>  	if (exynos_drm_check_fimc_device(dev) !=3D 0)
>  		return -ENODEV;
> =20
> -	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	num_formats =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_format=
s);
> +	ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats), GFP_K=
ERNEL);

Unrelated to this patch, but this has triggered my attention.

I have been recently researching into allocation of FAMs, trying to make
them more type safe, and found it safer to have a specialized API for
such allocations, whose pseudo-prototype would look like this:

	T *mallocflex(typename S, size_t n, flex);

A devm_kzallocflex() could then have an extra 'dev' parameter at the
front, and the usual 'gpf' one at the end.  It could be used here as:

	n =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
	ctx =3D devm_kzallocflex(dev, struct fimc_context, n, formats, GFP_KERNEL);

Kees, do you think we could add something like this?

Here's a small program showing how it could be implemented:

	$ cat fam.c=20
	#include <errno.h>
	#include <stddef.h>
	#include <stdint.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/param.h>

	#define typeof_typename(T)      typeof(*(typeof(T) *){_Generic(0, T: NULL,=
 default: NULL)})
	#define memberof(T, member)     ((T){}.member)
	#define sizeof_flex(T, n, fam)  MAX(sizeof(T), offsetof(T, fam[n]))
	#define ptr_cast(T, p)          rvalue((typeof_typename(T) *){(p)})
	#define rvalue(lv)              ((void)0, (lv))

	#define reallocflex_T(p, S, n, flex)   reallocflex_T_(p, typeof_typename(S=
), n, flex)
	#define reallocflex_T_(p, S, n, flex)                         \
	(                                                             \
		_Generic(p, S *: (void)0),                            \
		ptr_cast(S, reallocflex_T__(p, S, n, flex))           \
	)
	#define reallocflex_T__(p, S, n, f)                           \
	(                                                             \
		reallocflex(p, sizeof(S), offsetof(S, f), n, sizeof(memberof(S, f)[0]))\
	)
	#define mallocflex_T(S, n, flex)                              \
	(                                                             \
		ptr_cast(S, reallocflex_T__(NULL, S, n, flex))        \
	)


	void *
	reallocflex(void *p, size_t headsize, size_t off, size_t n, size_t eltsize)
	{
		if (n !=3D 0 && eltsize > SIZE_MAX / n) {
			errno =3D ENOMEM;
			return NULL;
		}
		if (off > SIZE_MAX - n*eltsize) {
			errno =3D ENOMEM;
			return NULL;
		}
		if (off > headsize) {
			errno =3D ENOMEM;
			return NULL;
		}

	#ifndef NDEBUG
		printf("%zu (%zu, %zu, %zu, %zu)\n", MAX(headsize, off + n * eltsize), he=
adsize, off, n, eltsize);
	#endif

		return realloc(p, MAX(headsize, off + n * eltsize));
	}

	struct s {
		long a;
		char b,c,d;
		int f[];
	};

	int
	main(void)
	{
		struct s  *p;

		printf("s: %zu\n", sizeof(struct s));
		printf("o: %zu\n", offsetof(struct s, f));

		p =3D mallocflex_T(struct s, 2, f);
		p =3D reallocflex_T(p, struct s, 0, f);
		p =3D reallocflex_T(p, struct s, 1, f);

		bzero(p, sizeof_flex(struct s, 1, f));

		free(p);
	}


Have a lovely day!
Alex


>  	if (!ctx)
>  		return -ENOMEM;
> =20
> +	ctx->num_formats =3D num_formats;
> +	formats =3D ctx->formats;
>  	ctx->dev =3D dev;
>  	ctx->id =3D of_alias_get_id(dev->of_node, "fimc");
> =20
> -	/* construct formats/limits array */
> -	num_formats =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_format=
s);
> -	formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats),
> -			       GFP_KERNEL);
> -	if (!formats)
> -		return -ENOMEM;
> -
>  	/* linear formats */
>  	if (ctx->id < 3) {
>  		limits =3D fimc_4210_limits_v1;
> @@ -1320,9 +1316,6 @@ static int fimc_probe(struct platform_device *pdev)
>  		formats[j].num_limits =3D num_limits;
>  	}
> =20
> -	ctx->formats =3D formats;
> -	ctx->num_formats =3D num_formats;
> -
>  	/* resource memory */
>  	ctx->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ctx->regs))
> --=20
> 2.56.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--cd4qmvxj2ervr6g5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrDWp8ACgkQ64mZXMKQ
wqndww/8CDDAAm5f2tvfl0SP7UHg8H1zYS8pI0IPC5gQvEXr78/43DWG87YRfZEn
XLhyDfxCJgWC6OlTTR3mgp31+zNRCwuG7kzPSxxx/LsO528gPWajhkHsS0zdjgc8
+aGeJEMHRnBCkCLHLJFjgISSaCxseWGd4147RZYe5TxhDCUlM32g3UJCb3otvRMa
RgqkFYMGCZ0mXbipj/PCzbSqy+QQPDw/1b3AKs+2NG1yOEKfQtyVmYCKRrWNPebb
qSJIDdYIV5p2EcUTudH96Em+WaEC4lFklggB6YhNRvEmI6cAlAmlfRAHByTe6S9S
aU7o5ExRfSrtuG63opsDafOL8hCHQqaoiZi7JfzO8dFFa6CxLDQOejz7rolHlqTB
OvN+ppiVr+ehocq/IZmBdCWRQnjL2VM6WpgeyVPU0fImqTR12oHtxNUbnE2w17Wc
dbUPhKLJh4eGwFQiBugdXXBzW0CBCaFS8Wrmm2zdxNv9CzbwD9NowZMHBx43/CDs
naJIVnK2y+SOOz63AEIkaeqpSC1z7mxbHM0skWvu49MQEqSye5MWsDjqz71/4zQe
mB185gQyBsY4Hw0jM0AZj47G6B5S6l4i/LDfyfRS/Mqqv912n+dTZWdC3N1M9KMR
auNLd06e/+X6tIgz4lnMHtaJ64cPgmEThP0lME+bF3qhblsZM8A=
=xQu8
-----END PGP SIGNATURE-----

--cd4qmvxj2ervr6g5--
