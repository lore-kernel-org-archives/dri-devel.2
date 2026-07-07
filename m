Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B33C44503
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E14010EBA8;
	Tue,  7 Jul 2026 07:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3q2zXhZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FE310EBA7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0E1B40DA8;
 Tue,  7 Jul 2026 07:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE2D1F00A3F;
 Tue,  7 Jul 2026 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409637;
 bh=Gqc0yN61dyCXr/xyiFPr3e6FB9CwzZnnYzAryFZHZZI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l3q2zXhZmhnLU2y29JqHesS6snhI0xQccelW1TDTBABNOcZoH2srgJ30kyYp01Gfn
 hFT1bkHEUIE48Vt99HyrHGAohaC8SBC8fXs6B/KCf74fZqdsORgb6ywZQGHh88BMKV
 i6t+gU5t92lGxSzjiN2vkxEHXQK8/KdNgrDkqB7G8nZEApKNYMEA0r/Fmnfb2x0rOQ
 QQ53XKjISK+yQLKBAb/31aj6gcML7zHGzpGVAJJGbuV71gbK3k1o+wRDBmZgS8GzBG
 mrYWYuIaFfeRpN9Eu6N0zSipmj3Q5xXWHDr1FclAUi5+CMbY20OQ4ITRpGWJuiztcl
 btf5YPeYTEqXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 38/40] mm: percpu: increase
 PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large PAGE_SIZE
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, ojeda@kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-kernel@vger.kernel.org, cassel@kernel.org,
 linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260706061928.66713-39-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-39-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:56 +0000
Message-Id: <20260707073357.1DE2D1F00A3F@smtp.kernel.org>
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
- [Medium] The patch addresses a compile-time BUILD_BUG_ON failure that no =
longer exists, referencing a deleted structure (`struct kmem_cache_cpu`) an=
d function (`alloc_kmem_cache_cpus()`). Both have been removed from the ups=
tream kernel. The only remaining BUILD_BUG_ON checking `PERCPU_DYNAMIC_EARL=
Y_SIZE` in SLUB is in `alloc_kmem_cache_stats()`, which evaluates `sizeof(s=
truct kmem_cache_stats)`. Because `struct kmem_cache_stats` consists solely=
 of an integer array, its size is entirely unaffected by `CONFIG_DEPT` or `=
local_lock_t`. Thus, this patch needlessly increases the dynamically reserv=
ed per-CPU memory based on an obsolete and misleading justification.
--

commit 279fb8fb2919a407c18ab625ec67d2a3430b7b4d
Author: Byungchul Park <byungchul@sk.com>

mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large PAGE_SIZE
   =20
This commit increases PERCPU_DYNAMIC_SIZE_SHIFT to 11 when both CONFIG_DEPT
and a PAGE_SIZE larger than 4KiB are enabled. It aims to prevent a build
failure related to the size of struct kmem_cache_cpu.

>     Yunseong reported a build failure due to the BUILD_BUG_ON() statement=
 in
>     alloc_kmem_cache_cpus().  In the following test:
>    =20
>       PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *=
 sizeof(struct kmem_cache_cpu)

[Severity: Medium]
Are we referencing structures and functions that have been removed from the
upstream kernel?

Both alloc_kmem_cache_cpus() and struct kmem_cache_cpu no longer exist
upstream. The only remaining BUILD_BUG_ON() checking PERCPU_DYNAMIC_EARLY_S=
IZE
in SLUB is in alloc_kmem_cache_stats():

mm/slub.c:alloc_kmem_cache_stats() {
	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
			sizeof(struct kmem_cache_stats));
}

Since struct kmem_cache_stats consists solely of an integer array, its size
is entirely unaffected by CONFIG_DEPT or local_lock_t. Does this mean the
increase in dynamically reserved per-CPU memory is no longer needed?

> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 85bf8dd9f0874..dd74321d4bbd0 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -43,7 +43,11 @@
>  # define PERCPU_DYNAMIC_SIZE_SHIFT      12
>  #endif /* LOCKDEP and PAGE_SIZE > 4KiB */
>  #else
> +#if defined(CONFIG_DEPT) && !defined(CONFIG_PAGE_SIZE_4KB)
> +#define PERCPU_DYNAMIC_SIZE_SHIFT      11
> +#else
>  #define PERCPU_DYNAMIC_SIZE_SHIFT      10
> +#endif /* DEPT and PAGE_SIZE > 4KiB */
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D38
