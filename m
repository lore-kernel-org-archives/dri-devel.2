Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271160A260E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TD3I+IMX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A320F112A47;
	Fri, 20 Nov 2026 13:17:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843EB112A47
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CD1146B63;
 Fri, 20 Nov 2026 13:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ED01F000D4;
 Fri, 20 Nov 2026 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180659;
 bh=1r2RPLiYFSIogaEoUkz4XwYUZKQoUko/pKRdi08cxM0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TD3I+IMXRD+9btMqjG+8B3kJTvc6/N3FGTiOQW0DBF8szaAbfyT3rdoeRLPEztlhd
 1fkasb/JgYhFktdnsYQr/hbjy8ZgctD2oCPodj+EcxdWF0TgHkODd7sFnXKKDQLPq8
 5ASnbC5RngYAvXnPAqtilUTGTnCIjoJva8uNteQehr3AeEwKXuZJgY2lgewq1DJ9PS
 VwJ+/gaSErGpmwEF865LUS3VM1nLS3oOqHLTAYvriEXuxCXfiWnPIsOBBpItHfM9Qy
 SlI1Q3+bLjypHspK7ZlbPfJeomFf2OJXl+Xuxt7f6hr2LyAcAONIPxsaFe381p00kt
 3qa5gmkswFQ8Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.ams.internal (Postfix) with ESMTP id E3EF41980047;
 Fri, 20 Nov 2026 08:17:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 08:17:36 -0500
X-ME-Sender: <xms:bUgAa0Ss467GVnDhyoa5GLJvJ3Qkb6jHpBysa7UtJwMHKBxrb5rknQ>
 <xme:bUgAa_Jn5SAa9Gm26aQ6PCluN4Igj4Xbu-1eShGyKxR4qD4s9mbJsthGMUuBhDiiJ
 DvPsGIIO4AzG_TK8e7R8mLHjv9E9hWIE1EgDfNtY4sRYb_WfmuVqNFO>
X-ME-Received: <xmr:bUgAa92iCqHJb79UKYNhTmSvtYLPj7oT62s31rdeiXpMYGt1_RtpnZNe0lI>
X-ME-Proxy-Cause: dmFkZTEMslbIUNDm8LIh02IXJPPGaz8x9nStkoY2McUqfXdvc0zDAMNuwAdNk567GWqWFb
 Ue01QIrqSlGhLD7aTRxcawP+AUSNewklEcq6PMC9JP8w32Vkz0EAbVZ2QFm6NbbycGqrOT
 4Vb8re4U7agTXekt+mqlS2xCpK9NpzTwr+ErpQ3XVKIL+uqfYPpDVYCLRwfuz8aG4ZROa7
 Xd1wxnnT9IcNmrmTW/L61gTt77vLm2hbvmmHDGa2LHM3iddXj9bf/9phFNGmR4hUZZM7Uc
 ZJ9oEFeNgt22uQRjW3Wdih7LGzmvCPCrT/2DICvgDeLsnE5QRBd6+NlZnMM7O7XfT7q9Do
 MkQJtlimT0MHz0XKCwD/pqeSVQTF9nQB6fmaRrIBniyooZx48Wp+fOdjkpjjfy1M74AB0h
 vS3M9aDC5BqCGS+vBnYumDdMEN6m0xvfiEIP84KP4vUCXEzzfRXpY0HUEEr7Ux+TLE0CvM
 8mfzIpvGacxcLQSZU2/0i1GMY7jfN3hn3SzrJ9D9XCXiD5LzrcLQeHCkaf88rKLabxTIfx
 MK6n/B4O2fmC0h6UK+8FsX8/QUZPhtXvSb6VY/dDu82xZH1mgNTNYlAD8mYnORC1N2N/Kt
 9BSKREudmnRmc0072qjsdqwInnjVlm+WtP0N1OdHG4S5m3ZYPrjrL8R/k2Sw
X-ME-Proxy: <xmx:bUgAa7toYIuLcOc32pRwV-nsWDZX_L4XKKyWqDVC59SHUuoImBWT_A>
 <xmx:bUgAa5HlJOmSY7P5WSFjnY6uqz8LobY_WUwzQM8wba5A2rgz9WGBCA>
 <xmx:bUgAa1Jqwm68KOU2wpFhGSlDAH1XL0GVrygZ1G3sIJWJupOyMB2yEw>
 <xmx:bUgAa0GHctFKPFG36KsYueFTUiK1wxmIM_ROA7NlIGuYWQMr6gettQ>
 <xmx:bUgAax7INTnv3udfOUXtVTWi3rt4nW4moV6FhuG_CrgEs7tK_rv3kZad>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 08:17:32 -0500 (EST)
Date: Fri, 20 Nov 2026 13:17:31 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] drm/i915/gem: Skip writeback of shmem folios with extra
 references
Message-ID: <awBIB3vjr_o-gfCn@shutemov.name>
References: <20261119134243.3745282-1-kas@kernel.org>
 <av8n42vx3Q7zvQK8@zenone.zhora.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av8n42vx3Q7zvQK8@zenone.zhora.eu>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 06:43:08PM +0100, Andi Shyti wrote:
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index bf9e7480f0f5..748772c358ac 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -316,9 +316,15 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
> >  	 * leaving only CPU mmapings around) and add those folios to the LRU
> >  	 * instead of invoking writeback so they are aged and paged out
> >  	 * as normal.
> > +	 *
> > +	 * The same goes for a folio with references beyond the page cache
> > +	 * and writeback_iter(). A folio that was just unmapped can still be
> > +	 * written through a stale TLB entry until the unmapping side flushes
> > +	 * the TLB and drops its reference. pageout() checks the same.
> >  	 */
> >  	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
> > -		if (folio_mapped(folio))
> > +		if (folio_mapped(folio) ||
> > +		    folio_ref_count(folio) != 1 + folio_nr_pages(folio))
> 
> I don't think we need this fix in the current tree. The i915
> writeback iterator already skips the shmem folio in the case you
> describe, so the new refcount check doesn't change the outcome.

Oh. It took me a while to see why.

__shmem_writeback() asks writeback_iter() for PAGECACHE_TAG_DIRTY
folios, and shmem never sets that tag, its ->dirty_folio is
noop_dirty_folio(). So the loop body never runs for any folio, and
hasn't since 776a853a43c9 ("i915: Use writeback_iter()").

That makes me question the whole writeback thing. What's going on
there, and what's the plan?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
