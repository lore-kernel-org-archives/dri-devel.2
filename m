Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06441CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1F910F197;
	Thu, 28 May 2026 13:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dJhLFdkW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750FC10F194
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:27:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 523BD40592;
 Thu, 28 May 2026 13:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15301F000E9;
 Thu, 28 May 2026 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779974862;
 bh=CaLB5YbrnY0a8s58Pi+fW+011HIvbyL/i1pM2BIB7io=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dJhLFdkWDABa0Vgcnd82C5Dky2G1Gjclv23A4MgyEBBA6rpk35TqJOHXmXVr6Bd7N
 Z9zErq8OC9Kc5TiwiPyc2Qpl31KCgug4AxetEeuEltEV+o5044w1pwDRkrn3dSRqKq
 iC7X/dCViB3VhPvIsrcnO1ZB+mmwDN5/tCoT+Tf45fGDeSmi0PymxZgTRj3zaH1inS
 naKKgSKU8YiZf6Yv4t7m4oMoCJTIGwaxIjNnyz4QK0vlmE+eczwBtnqWwJutKRn5DD
 3cldGGvwMvsDNcjGPSJdTjImprCzcggaiQe4UctSgCs02Mnd/EqIH5QQ1aUYQwKBAs
 kqF81qf3fDotA==
Date: Thu, 28 May 2026 15:27:39 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Jacob McLemore <jmclemore.lkml@gmail.com>
Cc: tzimmermann@suse.de, Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: sor: Remove usage of drm_simple_encoder_init()
Message-ID: <ahhCnxgD99dovn7k@orome>
References: <20260523012824.81043-1-jmclemore.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4bzrbxr4qtkvnhq6"
Content-Disposition: inline
In-Reply-To: <20260523012824.81043-1-jmclemore.lkml@gmail.com>
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


--4bzrbxr4qtkvnhq6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: sor: Remove usage of drm_simple_encoder_init()
MIME-Version: 1.0

On Fri, May 22, 2026 at 08:26:24PM -0500, Jacob McLemore wrote:
> Remove the deprecated trivial helper drm_simple_encoder_init(). Inline
> the call to drm_encoder_init and add instance of
> drm_encoder_funcs.
>=20
> Signed-off-by: Jacob McLemore <jmclemore.lkml@gmail.com>
> ---
> Saw this was a good first task in Documentation/gpu/todo.rst.
> This is my first patch, so apologies if I've set up anything wrong
> in either my email client or gitconfig and the patch ends up invalid.
> ---
>  drivers/gpu/drm/tegra/sor.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, though I had to fix a few checkpatch warnings. Make sure to
always run that fix anything that it flags (though sometimes it can go a
bit overboard, so apply some common sense, too).

Thanks,
Thierry

--4bzrbxr4qtkvnhq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYQssACgkQ3SOs138+
s6H3hg//YlaM6RIBRDZ0rf/d48OzMsSWcBKgJDqtdVrUcfyGkCV4mkrV9BS3oLmG
KQtv9Wj8Gy05hlwMm9k/C1atmvtrQnX4HJmtUAFLorzk2NxbDQg4keVbqyzuwGX4
rrEYaGS7SOgFQC7Ol8q/EYkAPYVKSiJzjROLqZGoaKneQtHzNXysIej7k/DwXGK9
frx3hlnen53gIdC91c2lTQot1AE75HtS9HXMunVazEVDJHj+VFiQU/tZjrLWLbQq
2tbZxJnzXhYaJu3Dw5cqtLUiz2FTuC2ikOd/v0SzU42mkGnkd/9vJ9gOxrcOpjy0
8i5M5c+NTcVdSglcPcKGrw/1XtIqeClMb5WxBOEziAZ+ufng7Hs/zQTyC8wWxkF1
Qb47TjEkjGZL0eaq4H49BwqgdTgkS+HCKs+pchKZk7I2KrLfoh7QuuGj0oDN++xu
oyUvOrBF3CSuFBjXeYTpPy2vidgZ8nkCfje3dy0nI2j+DaJ61rY4XkIbGvdh8+09
YWGBENV52m6B0ewNJZDMoolJSlz0pqvzOt8l4BCzxeL7GjpwAxHxwqUVB6UPdEGf
+Zf/yaPatSXHmFEqhQVeqv1VnGZfHmkT16LQfd2MSbEINphrR9SFUFEzb+vzdCsN
3SiX6rNhCKRdr5MbbhmqsYnGL1kM3qMVGqGrrFPjNKGWPiGV8QA=
=MyuU
-----END PGP SIGNATURE-----

--4bzrbxr4qtkvnhq6--
