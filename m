Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E9CC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD52B10ED84;
	Mon, 14 Sep 2026 11:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E/xLZGfl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59E410ED2A;
 Mon, 14 Sep 2026 11:15:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E169560142;
 Mon, 14 Sep 2026 11:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648711F000FF;
 Mon, 14 Sep 2026 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789384511;
 bh=7s3TyRVfMxHcVsaEEnBXAlJ4XvZz1pHUSiJ2lK3DtHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E/xLZGflU1XMZ2M5Q4uFw/wIBpw5tNVbgBbmh1C4NxNZA5559Osm6EB+lSPbikHLp
 64KKxoRTgOMnRCm8xuWyYUJ5JRrNGU4+jBrAykHVoe6PJ4OhqQ806DStymgZm8x7CU
 wpfDN4wIwqojfKF8UjeMJUC0MjK3qPv6kZgrkxUX9Iu7NqGOkTfJ/vuRvc1tjkIlSh
 wE231XpnMFAnlwLHPxiT4m0KQdMhGsH4c1+d02G4vSp6voh7IpIGyq9gk4rWGIuERf
 AYoAtpayg/ZnpzKf4/uIwrk2VHYgQ6Lv1DG6czWqSseO7Z8+QDWmRskLD4tcXuF0B5
 tO2Sev8tfkr7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915: unlock shmem folios after skipped writeback
To: "Matthias Goergens" <matthias.goergens@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260914105606.3997649-1-matthias.goergens@gmail.com>
References: <20260914105606.3997649-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:15:10 +0000
Message-Id: <20260914111511.648711F000FF@smtp.kernel.org>
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
- [High] __shmem_writeback() limits writeback to SWAP_CLUSTER_MAX (32) page=
s, ignoring the requested size, which causes the shrinker to severely under=
-reclaim memory while reporting full reclaim success.
--

commit bda67bb2ffdd195685542c6f27e5b602b16ff109
Author: Matthias Goergens <matthias.goergens@gmail.com>

drm/i915: unlock shmem folios after skipped writeback

This commit fixes an issue where shmem folios are left locked indefinitely
when writeback is skipped. It unlocks folios when they are redirtied or when
shmem_write_folio returns AOP_WRITEPAGE_ACTIVATE.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index ef94401662955..e7b18f7f9644c 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -322,10 +322,16 @@ void __shmem_writeback(size_t size, struct address_=
space *mapping)
>  	 * as normal.
>  	 */
>  	while ((folio =3D writeback_iter(mapping, &wbc, folio, &error))) {

[Severity: High]
This isn't a bug introduced by this patch, but does the hardcoded limit on
wbc.nr_to_write here cause the shrinker to severely under-reclaim?

In drivers/gpu/drm/i915/gem/i915_gem_shmem.c:__shmem_writeback(), the size
parameter is completely ignored and the writeback_control is initialized
earlier in the function with:

    struct writeback_control wbc =3D {
        .sync_mode =3D WB_SYNC_NONE,
        .nr_to_write =3D SWAP_CLUSTER_MAX,
        ...
    };

Because of this, writeback_iter() will terminate after 32 pages (128KB).
However, when the system is under memory pressure and i915_gem_shrinker_sca=
n()
delegates to i915_gem_shrink(), try_to_writeback() eventually reaches
__shmem_writeback().

i915_gem_shrink() assumes the entire object was successfully written back
and increments its freed count by the full object size. If the object is
large, the mm subsystem is misled into thinking massive amounts of memory
were freed when only 128KB actually was. This could degrade memory reclaim
under pressure and lead to system stalls or OOMs.

Should the writeback limit respect the requested size parameter instead of
being hardcoded to SWAP_CLUSTER_MAX?

> -		if (folio_mapped(folio))
> +		if (folio_mapped(folio)) {
>  			folio_redirty_for_writepage(&wbc, folio);
> -		else
> +			folio_unlock(folio);
> +		} else {
>  			error =3D shmem_write_folio(folio);
> +			if (error =3D=3D AOP_WRITEPAGE_ACTIVATE) {
> +				folio_unlock(folio);
> +				error =3D 0;
> +			}
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914105606.3997=
649-1-matthias.goergens@gmail.com?part=3D1
