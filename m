Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43566C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6977B10E38F;
	Tue, 11 Aug 2026 20:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KwQgchvM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DD510E38F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:58:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 585234011A;
 Tue, 11 Aug 2026 20:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D411F000E9;
 Tue, 11 Aug 2026 20:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786481919;
 bh=2rrGNigU9Pd9C7p6y0tGWqpZ8hDKayZinSXL/Op9m30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KwQgchvMaKvI4rkLcdtWtdU9N4Xh/HlyFVd0OmcX0RqL2/b017RXIm3xoAu/slPRq
 iamtujzy1JFdCZS1OoCYbXcGeKHDYwqF0WbvEc7fQl0bAA8s3i2f4KYdquv4C5V4NC
 p97GLyOZ1VeH8FGKfIllPH75jHwxY81KBE30xUjkrkqBsFuuaRgndKv32RliUm2CgD
 msFdPnVP48+IrHh1Fqtr5u4WhpBYf3pxkHaA8yyjUoHPaReMTcxgrqBof0LkiwgrAh
 xR71Rhfqz5+NU6BL060IDLj8CM1Ggj+IQSagJSJZIPenOItL+46PEPbSVlKscksySs
 wgAXKpnsecJjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] accel/amdxdna: add a quiet variant of
 amdxdna_gem_vmap()
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260811204556.875037-3-taimuraz@kaitmazov.com>
References: <20260811204556.875037-1-taimuraz@kaitmazov.com>
 <20260811204556.875037-3-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 20:58:38 +0000
Message-Id: <20260811205839.03D411F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accessing `abo->client->xdna` in the error logging path of `amdxdn=
a_gem_vmap()` (and in job execution paths like `aie2_init_exec_req()`) caus=
es a NULL pointer dereference if the user closes the GEM handle concurrentl=
y.
--

--- Patch [2]: [PATCH 2/3] accel/amdxdna: add a quiet variant of amdxdna_ge=
m_vmap() ---
commit d54f02782d28a33a9fbd50ba981aaddfeb1cebb5
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()

This commit splits amdxdna_gem_vmap() into an inner function that returns
an error code and an outer function that retains the logging behavior. This
allows callers who expect mapping failures to avoid spamming the log.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index b66ec9e482894..d0c846b02694b 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -210,13 +206,28 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>  	if (!abo->mem.kva) {
>  		ret =3D drm_gem_vmap(to_gobj(abo), &map);
>  		if (ret)
> -			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
> -		else
> -			abo->mem.kva =3D map.vaddr;
> +			return ERR_PTR(ret);
> +		abo->mem.kva =3D map.vaddr;
>  	}
>  	return abo->mem.kva;
>  }
> =20
> +/*
> + * Obtains a kernel virtual address on the BO (usually of small size).
> + * The mapping is established on the first call and stays valid until
> + * amdxdna_gem_vunmap() is called.
> + */
> +void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
> +{
> +	void *kva =3D __amdxdna_gem_vmap(abo);
> +
> +	if (IS_ERR(kva)) {
> +		XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %ld", PTR_ERR(kva));

[Severity: High]
This is a pre-existing issue, but could this access of abo->client risk
a NULL pointer dereference?

If an unprivileged user submits a job referencing a GEM BO and immediately
closes the BO handle via DRM_IOCTL_GEM_CLOSE, amdxdna_gem_obj_close() gets
called and sets abo->client to NULL:

amdxdna_gem_obj_close() {
    ...
    abo->client =3D NULL;
}

The DRM scheduler still holds a reference to the GEM object itself. When the
job runs asynchronously, it may call amdxdna_gem_vmap(). If the mapping fai=
ls,
we reach this error logging path.

Because the patch splits the function and __amdxdna_gem_vmap() releases
abo->lock before returning, does this widen the race window and allow a
concurrent handle close to nullify abo->client exactly before it is
dereferenced here?

> +		return NULL;
> +	}
> +	return kva;
> +}
> +
>  /*
>   * Free mapping established through amdxdna_gem_vmap()
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811204556.8750=
37-1-taimuraz@kaitmazov.com?part=3D2
