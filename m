Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C5F10F007;
	Wed,  1 Jul 2026 15:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ktR4M2kx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFDB10F007;
 Wed,  1 Jul 2026 15:36:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECE9D6001D;
 Wed,  1 Jul 2026 15:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9531F000E9;
 Wed,  1 Jul 2026 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782920218;
 bh=7PMyPj49ff92f1DaqsDh3uAzfXfDvH/ocFqvDS3U5Sc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ktR4M2kx8zAi2arn+ibq69x76kDkmaMWw0nujrGJ0ZgnUjvN6n+VCsnXdyx4TBxqc
 y2Q//eJ7God84zRv3Orgod57tsmFoVMzQfoEDMms+XVkq0XXwIOJh8WqW+gXehTtB+
 Cjk03q6cKspXSJcv2K+LnLdnrR9o8h80yDFLX52Jq13FpDh9vzvIAmH2HNPAthbjkE
 gZS6ZDZfK1ZsJ0xWKN2dt8OpU5sdV+0A9wqfRZqwp7bGfJiot3fFpP22rzVdaTGCLB
 MxMh7rIrqu7M0fhNiwc2MXgEMrO8Dl1VMF/KH43+1SBAG7/S2jEvxlMca91OhC3b91
 sx5FA2P/PV5eQ==
Date: Wed, 1 Jul 2026 17:36:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 0/3] drivers: Improve memory management for large
 object allocations when i915/shmem is used with iommu
Message-ID: <akUzCar-MMOMGtGB@zenone.zhora.eu>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701104437.236979-1-krzysztof.karas@intel.com>
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

Hi Krzysztof,

> Krzysztof Karas (3):
>   drm/i915/gem: split shared memory allocation table logic
>   drm/i915/shmem: Count mapped pages in a folio

Please move the refactoring after the fix. We don't want to
create a dependency between a fix and a code refactoring, as
that makes it harder for maintainers to backport the fix.

Thanks,
Andi

>   drivers/iommu: Catch scatterlist length overflows
> 
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 191 +++++++++++++---------
>  drivers/iommu/dma-iommu.c                 |  14 +-
>  2 files changed, 129 insertions(+), 76 deletions(-)
> 
> -- 
> 2.34.1
> 
