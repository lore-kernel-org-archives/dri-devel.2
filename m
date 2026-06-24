Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F67CCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D2A10EE28;
	Wed, 24 Jun 2026 09:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Wux0JzQd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7EE10EE28
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782292740;
 bh=UbFfQafZq6sBdbOyPZkrwg5hrZbp8Tvb3WKRWbqkRyo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Wux0JzQdrDmpxjr9HtQosDURIf4Z76zUI4I0Bw6QizM6aBn3VUUJtdxkelUFWRSj/
 F5cb+rzCZq7E700W7xKZjSagCIiyrIzvfA5ZmZlEPst0iO25pQq+OfE8R0HaPSVMgv
 MnqfmQQ0cI7lpit44S4/YvB4wUc29FJHTB07IEKLUp9RWR0Rz82lzMAFFhSd4A6GBy
 zBu9DBjiqKogByXEqnnVQtZyb96ANxAejP1n4xOxxd44XUUF+XsD5z4YFRFUg/F5ju
 8I2817BYOW6i6KK5wyxdS1U+qowAOh0qT2fQ7D+21I26A5EWQECmopqVU3YYu8kMw7
 0rM0uEjdsbjFg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 402AF17E0191;
 Wed, 24 Jun 2026 11:19:00 +0200 (CEST)
Date: Wed, 24 Jun 2026 11:18:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Check VMA boundaries for PMD mappings
Message-ID: <20260624111856.11210c19@fedora-2.home>
In-Reply-To: <20260623224421.56dba65d@fedora-2.home>
References: <20260623181942.1536598-1-lk@c--e.de>
 <ajrRhpVH6uhOABnV@casper.infradead.org>
 <20260623220341.7ad4a0e2@fedora-2.home>
 <20260623224421.56dba65d@fedora-2.home>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 23 Jun 2026 22:44:21 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Tue, 23 Jun 2026 22:03:41 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > Anyway, I'll try to get back to this map_pages() implementation, and
> > see how we can handle the fallback when locks can't be acquired in that
> > path (I assume this would mean no PMD mapping in the fallback path if
> > we get rid of huge_fault()).  
> 
> More on that. I had a brief look at map_pages()/fault_around(), and it
> seems it's only meant to populate PTE entries, not PMDs.

I was wrong, filemap_map_pages() clearly attempts a huge_page map if
the conditions are met (proper alignment of VMA, folio is huge, ...).

Now, I have several questions around how to implement map_pages()
properly in our case.

Ideally we would use a generic helper like filemap_map_pages(), which
basically all implementer of .map_pages() are using, because the loop,
checks and locking is far from trivial there. Unfortunately we can't
really use that one because
   a. in our case, the vm_file attached to the vma is a pseudo file that
      doesn't really back the data. Things are redirected internally to
      another file object that's backed by shmem, meaning the
      vmf->vm_pgoff and vmf->vma info are unusable as-is
   b. we use PFN insertion instead of page insertion since [1]

I'm sure we can hand-roll our own map_pages() implementation, but
again, we would need custom versions of the vmf_insert_pfn() to have an
optimal version that can batch multiple PTE updates (just like
filemap_map_folio_range() does). The pte/pmd locking also looks a bit
different too in map_pages(). These are all rather tricky details that
are hard to sort out when you don't know MM internals and the various
pitfalls around page table updates. Long story short, if you really want
us to move away from .huge_fault(), we're gonna need a bit of
hand-holding, because otherwise we're shooting in the dark.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.1&id=8b93d1d7dbd578fd296e70008b29c0f62d09d7cb
