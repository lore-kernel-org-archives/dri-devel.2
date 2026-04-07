Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74961EDB7DF
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CF410E3B7;
	Tue,  7 Apr 2026 10:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nkumau9Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F4610E3B7;
 Tue,  7 Apr 2026 10:10:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 991BF600AC;
 Tue,  7 Apr 2026 10:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF52C116C6;
 Tue,  7 Apr 2026 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775556614;
 bh=uJwhrCZ5DVi1XGiVE85l7GZb0X3pCioNotmsUsRYefE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nkumau9ZkicHGxV91qxYWjPubXMFULLZk3pPmXQ7EZvc6i+zLYpzG1V+ahiER9OHH
 BR5AHjlnw6nKN9it8TN9PvZR63KdbXLwqng9rQ+UGRcVw8LeYS/qsFHwfRFzJQ54w+
 tYI+dvFq5PhS+fszRDxi4GsTLjolDl+T59NdJz/T7VqPArV9p/+waErCWpJZP8A1qc
 RqecKtM08KUOQRJihnsNRHncdPa1Th4gfCJZl3zKWr1gq/ZWljZIh3ouGYcehbBbto
 r2v6KzKZTzc5eTJTEOjYLm1TxZ6Wrbof2WBXKtY+FurfLniwKd/dPAW4Tpqi7LJXhV
 vGupcfnvlxl+g==
Date: Tue, 7 Apr 2026 11:10:05 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>, 
 Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
 Jason Gunthorpe <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <adTXtnJs_Rnl_pTD@lucifer>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer> <adOtS_q1MuFOawGM@lucifer>
 <adQFYAVGLqv6amZK@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adQFYAVGLqv6amZK@gsse-cloud1.jf.intel.com>
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

On Mon, Apr 06, 2026 at 12:11:28PM -0700, Matthew Brost wrote:
> On Mon, Apr 06, 2026 at 01:56:49PM +0100, Lorenzo Stoakes (Oracle) wrote:
> > On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> > > I see John gave a tag (and he's great so that gives me confidence here),
> > > but we should really follow the procedure on this properly.
> >
> > Oh and just noticed Alastair also :) so that adds further confidence, so this is
> > really a point about cc/M signoff requirement going forwards.
>
> +1.
>
> Andrew did ACK this via DRM here [1].
>
> When we take external subsystem patches through DRM, our merge script
> requires ACKs from an external maintainer, as determined by
> get_maintainers.pl.
>
> I’m not sure what happened here, but it looks like Andrew’s ACK was lost
> on the patch, and somehow our merge tool allowed it to go in regardless.
> We will be more diligent going forward.

ACK on that... ack :), but please make sure to cc- at least the relevant
maintainers on these series going forwards also.

I realise mm has changed somewhat in its approach with this so forgiveable you
missed it :>) but - at least for me - reading mailing lists is just out due to
bandwidth limitations.

>
> Matt
>
> [1] https://patchwork.freedesktop.org/patch/703183/?series=161082&rev=3#comment_1294670
>
> >

Thanks, Lorenzo
