Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D7606A334
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZ5aB4fV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B7310F83F;
	Tue,  3 Nov 2026 20:47:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B1610F83F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:47:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AC46431CC;
 Tue,  3 Nov 2026 20:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219691F0093A;
 Tue,  3 Nov 2026 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793738850;
 bh=WA4JldT6jZkiRqUOUhymd9+bMbgaai5DPTFvHOVFxkY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MZ5aB4fVto6FbxRg77AGVx0jiXNVhH38K6sxyQ4CgLc3S9lJLQH7InuTEYv8lfOaf
 5uoad99J7Yo66MZORzU1SueYppREaWAp7DnLjMArd/bw7llqmgjA7QeRkN0TecqOjw
 mgPYGDAwQqwyEL4ByoiIyUJS5Ynf7UPLyKjtpGQBMTUIJCZtNDazrMWwmoLIPejkIK
 R4yBtwITyXNn68MPxARx6qpkmGIeYtFfjYSs2zxU7gR3nB0yXltF941REAJYSVQAZs
 JOShTK4Swr6Tw/lPkD7UPNQLTdL9bwzUWCtu2lgQU5SbFGQKMkCODHWkdfiTaQncQD
 tHuce+fkMYTgw==
Date: Wed, 4 Nov 2026 07:47:09 +1100
From: Dave Chinner <dgc@kernel.org>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 brauner@kernel.org, cmllamas@google.com, aliceryhl@google.com,
 nat@pixelcluster.dev, arunpravin.paneerselvam@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 viro@zeniv.linux.org.uk, agruenba@redhat.com, trondmy@kernel.org,
 anna@kernel.org, cel@kernel.org, jlayton@kernel.org, cem@kernel.org,
 akpm@linux-foundation.org, david@fromorbit.com, david@kernel.org,
 hughd@google.com, hannes@cmpxchg.org, yosry@kernel.org,
 nphamcs@gmail.com, matthew.auld@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, jack@suse.cz, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 qi.zheng@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
 kas@kernel.org, mhocko@kernel.org, shakeel.butt@linux.dev,
 ljs@kernel.org, kasong@tencent.com, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] mm/list_lru: Account node removals in isolation helpers
Message-ID: <aupITfr9pBKPrU20@dread>
References: <20261103045053.59548-1-kaitao.cheng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103045053.59548-1-kaitao.cheng@linux.dev>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 12:50:53PM +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Successful writeback calls zswap_entry_free(), which removes the entry
> from the LRU and decrements both the sublist and node item counts.
> shrink_memcg_cb() then returns LRU_REMOVED_RETRY, causing the LRU walker
> to decrement the node count again.
> 
> The affected call path before this change is:
> 
>   __list_lru_walk_one()
>     shrink_memcg_cb()
>       zswap_writeback_entry()
>         zswap_entry_free()
>           zswap_lru_del()
>             list_lru_del()
>               __list_lru_del()
>                 atomic_long_dec()  /* first node count decrement */
>       return LRU_REMOVED_RETRY
>     atomic_long_dec()              /* second node count decrement */

That's a bug in the zswap code. You shouldn't be calling
list_lru_del() from __list_lru_walk_one() context.

Walker callbacks are supposed to use list_lru_isolate() or
list_lru_isolate_move() to remove the item from the LRU under the
lru lock. i.e. the walk and remove are a single atomic operation,
accounted by the walker infrastructure.

LRU_REMOVED_RETRY is for walkers that need to do work -after- the
item has been removed from the LRU (e.g. reclaim work that can't run
under the lru lock). i.e. the pattern for the callback code is
remove-unlock-reclaim-LRU_REMOVED_RETRY.

What the zswap code is doing is
unlock-reclaim-lock-remove-unlock-LRU_REMOVED_RETRY. That's
problematic, as we can have concurrent walkers, and so it's possible
that two shrinker invocations try to remove the same item at the
same time....

.... oh, what a nasty hack.

The zswap code is doing a list_move_tail() on the LRU object to
rotate it to the end of the LRU list before dropping the LRU lock,
in the hope that a concurrent scanner won't trip over it. That 
doesn't fix anything...

> During the mailing list discussion, Johannes Weiner suggested making
> users of the isolation interface responsible for maintaining the item
> counts, rather than having the walker decrement the node count based
> on the callback's return value.

urk. How is smearing the LRU NUMA abstraction into all the isolation
interfaces an improvement?

It seems to me that that this LRU hacking is all because of this:

         * 2. Usually, objects are taken off the LRU for reclaim. In
         *    this case this isn't possible, because if reclaim fails
         *    for whatever reason, we have no means of knowing if the
         *    entry is alive to put it back on the LRU.

And so to work around this inability of zswap to handle failure
sanely, the LRU list the reclaim code is being abused. And now the
abuse of the lru list code is triggering problems with the LRU
infrastructure, the suggestion is to push internal LRU structures
into all LRU list walkers to allow racy (and IMO broken) walker
behaviour?

I'd much prefer the zswap code get fixed than to have to modify a
dozen other subsystems to enable zswap to work around broken reclaim
code...

-Dave.
-- 
Dave Chinner
dgc@kernel.org
