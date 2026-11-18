Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551C606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwMwW+xX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9645910FA40;
	Wed, 18 Nov 2026 00:51:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E546C10FA40
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:51:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A99DA43A86;
 Wed, 18 Nov 2026 00:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAA41F000C4;
 Wed, 18 Nov 2026 00:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794963083;
 bh=j8JuxxTxKt/6k9dfZV8E6ofZilA/b2soDeHfMeH+DyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BwMwW+xXM4K66NRQ8HaNM0EI7ey1wkHvo1ZOp8YlG/zBU0e5uCMmdoECmZSRkqN9U
 LWK7FHMlBcu+qTUHiM5+nhSPSNEoUc0YVfBo8DgL3dYE7C70hTB82D1W22zLKTv1Si
 BG55J5dpDYjZYw/JbX8HVT2El5tQAp668r9Nj3mVwR7tDQ7yWHU4xtEJfE88VjXUkb
 l5gOekPvPXTCZq9mqKV6bqdDNSjG7OwDtiQ/N7fALIDZxmDVq3j8k5Q9ENRJ58TiGT
 /sWQLt65nGyMij9n7dbts2ImqO33igu5rL3IJ5tjnOxH5Y2kZSNe8SXmc54cqgPkhs
 dhPBWHH/cvfXg==
Message-ID: <sashiko-outbox-219884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] drm/tegra: Fix device parameter to
 dma_get_sgtable
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-9-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
 <20261118-b4-arm32-iommu-dma-cookie-v4-9-0c5561288e22@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 00:51:22 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/tegra: missing Fixes trailers for dma_get_sgtable() device
  fix
--

commit a903e6b981ebb1374fcd8fe33c665795a2812ab8
Author: Mikko Perttunen <mperttunen@nvidia.com>

> drm/tegra: Fix device parameter to dma_get_sgtable
>
> The device parameter to dma_get_sgtable should match the allocating
> device, not the consuming device. Fix the calls.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

[Severity: Low]
Should this bug fix include Fixes: tags for the commits that introduced
the wrong device arguments to dma_get_sgtable()?

  Fixes: d81f3431e617 ("drm/tegra: gem: Use dma_get_sgtable()")
  Fixes: 80327ce3d4ed ("gpu: host1x: Overhaul host1x_bo_{pin,unpin}() API")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-b4-arm32-i=
ommu-dma-cookie-v4-0-0c5561288e22@nvidia.com?part=3D9
