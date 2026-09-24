Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682A5C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11A710F4C8;
	Thu, 24 Sep 2026 12:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nA1izpcF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2E510F4C8
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:36:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCB39601DE;
 Thu, 24 Sep 2026 12:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546901F000FF;
 Thu, 24 Sep 2026 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790253384;
 bh=D/9++Cm02APzQ2HrYsJmX6yY0vS3ycg8nWbqirpjGwg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nA1izpcFeLrC7kRFlPHt+2g0m/f/MIPyQ1HjIjqpjjV1g+kt7+ZTZZ5YN0kUv7azG
 iAHv6KY9oU5GhbcyHo7I8S5ykj4uHy87fFDfVcXwKHF7jsNIlwUhuMBtilK8u4gnm/
 xtfmc8frcYxBTkciMOdZcT1yGN+B4owpag6mJRvsPHbJXbnhslJWhQnE+JeHUmD1xd
 7gUe+k3l86gDeHXhPNWRzNIYj2bYjbmhmdsTo2ZH4Wpy55jnz//7mU4INjrU1Cr5en
 JrL7Hvwu6pCM/v+soW/n/eWG9RPvDY/b6HdCi50u1WTn3dEmOOcw+rPuLOESdV/0d4
 D23RewKTp8nyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Don't invalidate OTHER caches
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-panthor-mmu-fixes-v1-1-e25f9b106466@collabora.com>
References: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
 <20260924-panthor-mmu-fixes-v1-1-e25f9b106466@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:36:23 +0000
Message-Id: <20260924123624.546901F000FF@smtp.kernel.org>
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
- [Low] doc: comment contradicts code on RO cache invalidation
--

commit 97f084533582df463bbfd6d17bb8670c85068160
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Don't invalidate OTHER caches

This commit stops invalidating OTHER (L1 read-only) caches during MMU
operations to prevent issues with flush-elimination logic on v13 hardware.
The invalidation is deemed unnecessary as TLB invalidation prevents context
data leaks and the cache is read-only.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 9f63a048df61c..7e98084b9a1ed 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -1841,8 +1841,7 @@ static void panthor_vm_unlock_region(struct panthor=
_vm *vm)
>  		 * range is narrow enough and the HW supports it.
>  		 */
>  		ret =3D panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> -					       CACHE_CLEAN | CACHE_INV,
> -					       CACHE_INV);
> +					       CACHE_CLEAN | CACHE_INV, 0);

[Severity: Low]
This isn't a bug, but should the comment just above this call in
panthor_vm_unlock_region() be updated?

The comment still explicitly says "and invalidate RO ones", which now
contradicts the implementation since 0 is being passed for the OTHER (RO)
caches.

> =20
>  		/* Unlock the region if the flush is effective. */
>  		if (!ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-panthor-mm=
u-fixes-v1-0-e25f9b106466@collabora.com?part=3D1
