Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D76606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxiQkusU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBE610EA09;
	Thu, 12 Nov 2026 23:12:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC26C10EA09
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:11:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97B22608FA;
 Thu, 12 Nov 2026 23:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8171F000C4;
 Thu, 12 Nov 2026 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525117;
 bh=MkEXuIIGNcqSp49YUMTtf9VYfbSfkUF4TfyVyMsWUJM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oxiQkusU+hEbKohiIS6hoN0AS0TyHWZHFvpJyEBi9o2pK5Gu4G3v3HxIWKqBca0sc
 7LchGIjWm2t4IPbVnb4t+uypzVDK053u2LjTTzMJhMhIPvQQB0YlFXgWve8m0LiX6x
 SJEolA9hGjMF/ujFqccIE4c3RTphXl5mUH3NVpxre6PLXVF6KUKV3te3hrP6ukEH0M
 o1PCPvi4Spwc8mZ4R9a8fI1yIYzevO3g2TOg2LMKtvlprUVqqLNUZOWGP68zNRYA0+
 cG8LZa4AIhNz+vk3bvnNY1Z90w/e9IQuuGvEfutv8YM/pZOTJgrIMMMxfFvclAAI5c
 uNE9INSjbcqyg==
Message-ID: <sashiko-outbox-211933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/13] drm/gem-shmem: Map pages for the DMA device
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-1-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-1-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:11:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/gem-shmem: inaccurate commit claim on
  drm_gem_shmem_prime_import_no_map()
--

commit ab22341eb694926c9e7157138a1539d1ee8eaee9
Author: Joseph Telaak <joseph@telaak.dev>

drm/gem-shmem: Map pages for the DMA device

This commit updates the GEM shmem helpers to map, unmap, and attach
DMA-BUF objects using drm_dev_dma_dev() instead of drm_device.dev.

> Of those that do and use the shmem helpers (gud, udl,
> gm12u320, appletbdrm), none maps an object's pages through
> drm_gem_shmem_get_pages_sgt() or imports with
> drm_gem_shmem_prime_import_no_map().
>=20
> The first user is powervr_sgx, later in this series: behind gma500 its
> DRM device is an auxiliary device, and its DMA goes through the GPU's
> PCI function.

[Severity: Low]
Is this commit message claim about drm_gem_shmem_prime_import_no_map()
accurate?

Since commit e7a1cbca0b42 ("drm/gem-shmem: Do not map s/g table by
default"), DRM_GEM_SHMEM_DRIVER_OPS sets .gem_prime_import to
drm_gem_shmem_prime_import_no_map, and gud, udl, gm12u320, and
appletbdrm all use DRM_GEM_SHMEM_DRIVER_OPS.  This patch changes their
PRIME imports to attach to the USB host controller DMA device configured
via drm_dev_set_dma_dev() rather than the USB interface device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D1
