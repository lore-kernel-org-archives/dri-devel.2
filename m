Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9218CCCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DA010E20E;
	Fri,  1 May 2026 20:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qsXQoAe6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1807C10E20E;
 Fri,  1 May 2026 20:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xaMvyfhzCvlUTk9HYqljz7IrplwZLZCvDlnXs0RMPrI=; b=qsXQoAe6lip/+O9p//7+b6k42X
 tNvWKxcbTNFYuMGCcPp5qWcjdvTFsJlOouHvqifleN0xEJX1nVYxhKRirYdcn2ghrbtF43M0EFzyD
 4bKqWS83qbxARVZG8Ou7QT0mzHeEfZPjroAKKQc+/Tot5C4azU5OC6WYbbEQvnw71QT675GWejZB3
 z687ICuOGnZPksc63R23Wv5JOI2Z8TTWDyqDtNFVLcjv8kkDbQmZy1sMhDZElOqQd9IZecIXmNthY
 DmcN35PXV5w7y/uvxKu4tZSPVCyqsOjmlMCUNGA16vN7G1NjRG1idW2FSZzWeUW0YteEBPs/hHNLA
 XtEcMCyg==;
Received: from 179-125-71-251-dinamico.pombonet.net.br ([179.125.71.251]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wIu6W-00502f-BB; Fri, 01 May 2026 22:04:52 +0200
Date: Fri, 1 May 2026 17:04:44 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
Message-ID: <afUHXNzgcBOjIsIJ@quatroqueijos.cascardo.eti.br>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
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

On Wed, Apr 22, 2026 at 01:41:37PM -0700, Matthew Brost wrote:
> On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian König wrote:
> > On 4/22/26 09:32, Tvrtko Ursulin wrote:
> > > 
> > > On 21/04/2026 02:26, Matthew Brost wrote:
> > >> Triggering kswap at an order higher than beneficial_order makes little
> > >> sense, as the driver has already indicated the optimal order at which
> > >> reclaim is effective. Similarly, issuing direct reclaim or triggering
> > >> kswap at a lower order than beneficial_order is ineffective, since the
> > >> driver does not benefit from reclaiming lower-order pages.
> > >>
> > >> As a result, direct reclaim should only be issued with __GFP_NORETRY at
> > >> exactly beneficial_order, or as a fallback, direct reclaim without
> > >> __GFP_NORETRY at order 0 when failure is not an option.
> > >>
> > >> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > >> Cc: Carlos Santa <carlos.santa@intel.com>
> > >> Cc: Christian Koenig <christian.koenig@amd.com>
> > >> Cc: Huang Rui <ray.huang@amd.com>
> > >> Cc: Matthew Auld <matthew.auld@intel.com>
> > >> Cc: Matthew Brost <matthew.brost@intel.com>
> > >> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > >> Cc: Maxime Ripard <mripard@kernel.org>
> > >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > >> Cc: David Airlie <airlied@gmail.com>
> > >> Cc: Simona Vetter <simona@ffwll.ch>
> > >> CC: dri-devel@lists.freedesktop.org
> > >> Cc: Daniel Colascione <dancol@dancol.org>
> > >> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > >> ---
> > >>   drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > >> index 26a3689e5fd9..8425dbcc6c68 100644
> > >> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > >> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > >> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> > >>        * Do not add latency to the allocation path for allocations orders
> > >>        * device tolds us do not bring them additional performance gains.
> > >>        */
> > >> -    if (beneficial_order && order > beneficial_order)
> > >> -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> > >> +    if (order && beneficial_order && order != beneficial_order)
> > >> +        gfp_flags &= ~__GFP_RECLAIM;
> > >>         if (!ttm_pool_uses_dma_alloc(pool)) {
> > >>           p = alloc_pages_node(pool->nid, gfp_flags, order);
> > > 
> > > I missed this conversation so don't know if this was discussed -
> 
> I meant to CC you here, but missed including you.
> 
> > > having less of 64k pages is not a concern? I mean slightly higher TLB pressure etc on hardware which supports this PTE size.
> > 
> > At least for AMD GPUs 64k doesn't matter at all.
> > 
> 
> Same on Intel GPUs for system memory mappings - it is either 4k or 2M
> GPU pages. VRAM can we 64k pages but that isn't involved here.
> 
> > There was a large push from the Windows side to use that size, but we have more than enough evidence to prove that this size is actually completely nonsense for almost all use cases.
> > 
> > I have no idea how we ended up with that in the first place.
> > 
> > It could be that there is still HW out there which can only handle that size, but in that case such HW should just set beneficial_order to 64k.
> > 
> 
> Or we move to a table config if we find drivers have multiple
> beneficial_orders.
> 
> > > Also, does clearing __GFP_RECLAIM disable compaction completely and is that wanted?
> > 
> > Oh good point, most likely not.
> >
> 
> Without completely reverse engineering the core MM, I'm not sure here.
> 
> I just read the kernel doc for __GFP_KSWAPD_RECLAIM [1] and this to
> indicate if this is clear compaction won't be entered.
> 

AFAIU, clearing __GFP_DIRECT_RECLAIM will prevent direct compaction, but
kswapd might still start compaction. Since clearing __GFP_KSWAPD_RECLAIM
prevents the wakeup of kswapd, then clearing both will stop any compaction
(and shrinking) from those allocations.

I wonder if this change alone (well, with the other one setting the
beneficial order for Xe) would prevent the issue you are observing, as you
mentioned in the cover letter that this happens under kswapd.

By the way, that reminded me that GPU drivers trying to allocate high order
pages was one of the reasons __GFP_NO_KSWAPD (and thus
__GFP_KSWAPD_RECLAIM) were kept. See caf491916b1c1.

Cascardo.

> Matt
> 
> [1] https://elixir.bootlin.com/linux/v7.0/source/include/linux/gfp_types.h#L198
>  
> > Regards,
> > Christian.
> > 
> > > 
> > > Regards,
> > > 
> > > Tvrtko
> > > 
> > 
