Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294B6FF8873
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504F010F174;
	Wed, 29 Apr 2026 20:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cS5ZSkTn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE6C10E061;
 Wed, 29 Apr 2026 20:46:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5906E6015B;
 Wed, 29 Apr 2026 20:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBC3C19425;
 Wed, 29 Apr 2026 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777495601;
 bh=F70MUsM23vkCIM13pxF5Tha5sxcIj21SpuVSHYz6MC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cS5ZSkTn2/ybqBi1sQfuKxtBYuIZHehRk4/7UtLeVIy/Ks3oFeKEHVpBS7HCwiq3k
 kJFhhD8drEFzcb/h/uhY7ePh1JTndf+jt+zlsv+FXMxVtcFU7ormseKrq7HJRevfdQ
 tV4hOu1iDclJdtQMrtNq9oYhV4hmA+zKvwavI7HfNUIEY1ZbiDuuVu/nsx7oDPYSpn
 TbDG4SPMvWdzL7k3TQDRKQBQo3cY6Vx/HUtlFjjYAqbyr10V3g80tnsymh1A73T961
 fGJDS0mXbqpDa5FEZocYA3LanYMxW6P7YRVNky/n9GemQE9wOE2O+XwWlrv21UaJlX
 mRvN8bTqVC0mw==
Date: Wed, 29 Apr 2026 13:46:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v7 1/5] drm/gpusvm: Use dma-map IOVA alloc, link, and
 sync API in GPU SVM
Message-ID: <20260429204637.GA3588527@ax162>
References: <20260410205929.3914474-1-matthew.brost@intel.com>
 <20260410205929.3914474-2-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410205929.3914474-2-matthew.brost@intel.com>
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

Hi Matthew,

On Fri, Apr 10, 2026 at 01:59:25PM -0700, Matthew Brost wrote:
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 7993e85c0566..365a9c0b522a 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1544,13 +1554,33 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  				goto err_unmap;
>  			}
>  
> -			addr = dma_map_page(gpusvm->drm->dev,
> -					    page, 0,
> -					    PAGE_SIZE << order,
> -					    dma_dir);
> -			if (dma_mapping_error(gpusvm->drm->dev, addr)) {
> -				err = -EFAULT;
> -				goto err_unmap;
> +			if (!i)
> +				dma_iova_try_alloc(gpusvm->drm->dev, state,
> +						   npages * PAGE_SIZE >=
> +						   HPAGE_PMD_SIZE ?
> +						   HPAGE_PMD_SIZE : 0,
> +						   npages * PAGE_SIZE);

This patch is in -next as commit 37ad039fb367 ("drm/gpusvm: Use dma-map
IOVA alloc, link, and sync API in GPU SVM"), where it breaks the build
for certain platforms such as ARM.

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig drivers/gpu/drm/drm_gpusvm.o
  In file included from <command-line>:
  drivers/gpu/drm/drm_gpusvm.c: In function 'drm_gpusvm_get_pages':
  include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_361' declared with attribute error: BUILD_BUG failed
    699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
    680 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
    699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
     40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^~~~~~~~~~~~~~~~~~
  include/linux/build_bug.h:60:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
        |                     ^~~~~~~~~~~~~~~~
  include/linux/huge_mm.h:113:28: note: in expansion of macro 'BUILD_BUG'
    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
        |                            ^~~~~~~~~
  include/linux/huge_mm.h:120:35: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    120 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
        |                                   ^~~~~~~~~~~~~~~
  drivers/gpu/drm/drm_gpusvm.c:1560:52: note: in expansion of macro 'HPAGE_PMD_SIZE'
   1560 |                                                    HPAGE_PMD_SIZE ?
        |                                                    ^~~~~~~~~~~~~~
  make[7]: *** [scripts/Makefile.build:289: drivers/gpu/drm/drm_gpusvm.o] Error 1
  ...

I think use of HPAGE_PMD_SIZE is expected to be gated by
CONFIG_TRANSPARENT_HUGEPAGE ifdefs?

Cheers,
Nathan
