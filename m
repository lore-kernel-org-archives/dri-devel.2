Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8613EF4EDE
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED0F210E23B;
	Mon,  6 Apr 2026 12:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZxTdZpNP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6DC10E23B;
 Mon,  6 Apr 2026 12:56:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 92E9E600AC;
 Mon,  6 Apr 2026 12:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43DC4CEF7;
 Mon,  6 Apr 2026 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775480218;
 bh=/gqPBpHI/Dqnmm0q5zZtq8gfBWK8tRIWRdnPie5+/64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZxTdZpNPlT24ktQ1DHuXs5pVEHWUtdLUhqp575cj5MBhhXOQT29+UPraloNK36Sm8
 qWBbI5pTGRuKtx8qK7UdSRFNHz2mBeoiy4oSqAsEs/luTI8pp8Gk+GVMpca1GMU9TC
 t7DXEm18qQEN/RpF0RQ3SOgT9cb2Kss8jmeuuPQ+/oVlBwfcYJs6BB/d39KLD5xrxu
 0lMIKwxBCu/8jPJHKFMim3AqQKJ2EAzgX/G2lJD2mOfuW+ltD4fbsXKRjgZun+ZqTm
 TUiYq/hxI9nYho8cYDtjdgn36W6z+QjdYBj18umTGufERACT2zTJW5zZuAhA8ppqlV
 PO8JKvoFaL+wg==
Date: Mon, 6 Apr 2026 13:56:49 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>, 
 Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
 Jason Gunthorpe <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-mm@kvack.org, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 
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
Message-ID: <adOtS_q1MuFOawGM@lucifer>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adOqU0UDzpxvQuwA@lucifer>
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

On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> I see John gave a tag (and he's great so that gives me confidence here),
> but we should really follow the procedure on this properly.

Oh and just noticed Alastair also :) so that adds further confidence, so this is
really a point about cc/M signoff requirement going forwards.

Thanks, Lorenzo
