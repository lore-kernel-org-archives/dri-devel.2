Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABFC61DC2
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D5510E1DA;
	Tue, 25 Aug 2026 13:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MnRhtGXF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E212910E1DA;
 Tue, 25 Aug 2026 13:44:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB7DA60A5C;
 Tue, 25 Aug 2026 13:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D651F000E9;
 Tue, 25 Aug 2026 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787665484;
 bh=DkTn0eYyAXDRxvwSqgg0PBN5TH68oAOpRj68mw2xuxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MnRhtGXFgQQuiajgEJ6xF+kLWcwLEfjiNk8uA1f6zKX0mg48n3/uNM/Umhw5yFb0u
 YFV+O/mNYel9XMe0Pr8Ui5B56fgG9K1StqvAjFxxseRy6VU8zK2md1OS2OSl6gjdDe
 n+wKzinXMY6Dn1da34X7BpAOScT8OQPdJVJGm25IfbzYingxl8+h4loSdHDE8xHnhG
 GBeBMYxieMxUnAEkykLkXl6faeNdLpjLIHfVcHpOuav7pDPQnMn5iqDBRVjrQVhMjj
 sZeQYhWsgQZzwp5QQrVvMKCAeM/u+eVJsbcm/Md8ttiQdthr47ae3FwTuU+PnNfVFv
 8HllCvZkmCSwQ==
Date: Tue, 25 Aug 2026 15:44:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/i915/gem: Use simpler versions of min*()
Message-ID: <ao2bfCVRT8LuOJCb@zenone.zhora.eu>
References: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
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

Hi Andy,

On Tue, Aug 25, 2026 at 11:35:52AM +0200, Andy Shevchenko wrote:
> Instead of harder to read min_array() and prone to mistakes min_t()
> use min3() and min(). No functional changes intended. The types of
> the values are unsigned, no side-effects are expected.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index ef9440166295..bf9e7480f0f5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -153,11 +153,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  			}
>  		} while (1);
>  
> -		nr_pages = min_array(((unsigned long[]) {
> -					folio_nr_pages(folio),
> -					page_count - i,
> -					max_segment / PAGE_SIZE,
> -				      }), 3);
> +		nr_pages = min3(folio_nr_pages(folio),
> +				page_count - i, max_segment / PAGE_SIZE);

thanks for your patch, but there is another patch involving (and
fixing) this line of code[*]. You are welcome to join the review.

Thanks,
Andi

[*] https://patchwork.freedesktop.org/patch/746877/?series=172332&rev=1

>  
>  		if (!i ||
>  		    sg->length >= max_segment ||
> @@ -168,8 +165,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  			st->nents++;
>  			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
>  		} else {
> -			nr_pages = min_t(unsigned long, nr_pages,
> -					 (max_segment - sg->length) / PAGE_SIZE);
> +			nr_pages = min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
>  
>  			sg->length += nr_pages * PAGE_SIZE;
>  		}
> -- 
> 2.50.1
> 
