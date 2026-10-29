Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393C606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE0Dhn1I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FDA112080;
	Thu, 29 Oct 2026 08:36:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B61112079;
 Thu, 29 Oct 2026 08:36:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26FD543DE4;
 Thu, 29 Oct 2026 08:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4094C1F01828;
 Thu, 29 Oct 2026 08:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793262970;
 bh=BqE9F7QHM9W2/QNtBufRNQmznh5NnDhMEtUPQb5xb70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bE0Dhn1IMt6VsMx5LMilyofuecH4nFB14QMQ/6h/vPnj/2C7gAt+npJjDIXKPQvRI
 +/HFdeuId/FdGXWgmB2JMO9a/STDDut3KSQ+gw5wUiW+OULcsf7AZjJG30+cTGA2Oy
 DE+dNlnQAU9BVewFKYi5wWxlVAQGeojtt2zXpkVfPkX95Vmh5bcN+OYUKZwyWrvy4u
 w1a7yQKPndAKCHznQv7wKQ0yVXz21IHsN+Nikaws0HnabpfiCWCKGsGwsDiQ/KZ7bb
 gD4y3nAguwcbGPAwreUnLK98qoqMBta7qn2QZ/HJ18003Rk2NAgHQu0MZ2MRaddzOg
 bdatkhCCkXKUA==
Date: Thu, 29 Oct 2026 09:36:05 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: yaolu@kylinos.cn, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, 
 tursulin@ursulin.net, simona@ffwll.ch, chris@chris-wilson.co.uk, 
 lionel.g.landwerlin@intel.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gem: Reset err for each fence entry
Message-ID: <auMDxbKZ-XmRbaUH@zenone.zhora.eu>
References: <20261027072832.726435-1-yaolu@kylinos.cn>
 <auHeqGZ-hm2lS7Nk@zenone.zhora.eu>
 <179325911095.16507.8295053984620715316@jlahtine-mobl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179325911095.16507.8295053984620715316@jlahtine-mobl>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Joonas,

On Thu, Oct 29, 2026 at 09:31:50AM +0200, Joonas Lahtinen wrote:
> Quoting Andi Shyti (2026-10-28 13:39:14)
> > Hi Lu,
> > 
> > On Tue, Oct 27, 2026 at 03:28:32PM +0800, yaolu@kylinos.cn wrote:
> > > From: Lu Yao <yaolu@kylinos.cn>
> > > 
> > > If dma_fence_chain_find_seqno() failed once, 'err' will store val in
> > > the following loop. May causing returns '-EINVAL' even though that
> > > entry never called dma_fence_chain_find_seqno() at all.
> > > 
> > > Fixes: 13149e8bafc4 ("drm/i915: add syncobj timeline support")
> > > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > 
> > pushed to drm-intel-gt-next.
> 
> This was pushed without any R-b, DIM should have given you a warning
> when applying the patch.

I forgot to add it, or rather, I remembered it too late. Since
it's a simple and straightforward patch (most likely LLM
generated), I didn't want to make a fuss about it.

> I've reverted it for now, please use DIM and check the warnings before
> merging stuff.

I used dim and apparently dim is not enforcing it.

I'll push it again with my r-b.

Thanks,
Andi
