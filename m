Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QJu4I9ui
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489FB112109;
	Thu, 12 Nov 2026 12:58:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 98840112064;
 Thu, 12 Nov 2026 11:56:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3CE8153B;
 Thu, 12 Nov 2026 03:56:11 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF9343F632;
 Thu, 12 Nov 2026 03:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794484575; bh=jLwZvor016x+TzfEywYXeOWteUmG2ue9bXaXatigxyg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QJu4I9uiQFFvC3WPCjDRK/KwBHVWaMDKODaqCT5puw101H172umhqeXcWf8ceOhW/
 1DC/yi0K4CrY0pwYUNJGU3o9Ej8c61VepdlGN1xrZHlHb09BJS5/CjgaSjF6mKrdMP
 ReGobp5hWGzdQXEB3jNcrNOn8pypVnlWXrF8/obA=
Date: Thu, 12 Nov 2026 11:56:08 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: mpenttil@redhat.com
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
Message-ID: <avWpWBl1nPcRVmpQ@raptor>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:58:42 +0000
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mika,

I want to help getting this series merged, and I've been familiarizing myself
with hmm and device migration, please bare with me if the questions I'm asking
are obvious or downright silly.

On Tue, Nov 03, 2026 at 08:16:17AM +0200, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> Currently, the way device page faulting and migration works
> is not optimal, if you want to do both fault handling and
> migration at once.
> 
> Being able to migrate not present pages (or pages mapped with incorrect
> permissions, eg. COW) to the GPU requires doing either of the
> following sequences:
> 
> 1. hmm_range_fault() - fault in non-present pages with correct permissions, etc.
> 2. migrate_vma_*() - migrate the pages
> 
> Or:
> 
> 1. migrate_vma_*() - migrate present pages
> 2. If non-present pages detected by migrate_vma_*():
>    a) call hmm_range_fault() to fault pages in
>    b) call migrate_vma_*() again to migrate now present pages

Regarding both sequences, I'm trying to get a better understanding of what
the issue is. I assume the caller wants to fault in system memory, and then
migrate it to the device. Is that correct?

In my analysis I'm also not going to refer to THPs, since that would make
things even more complicated than they are. I think we can come back to
THPs later if we think it would be useful.

For the !pte_present() case:

Sequence 1: hmm_range_fault() -> .. -> hmm_vma_handle_pte() handles
!pte_present() pages in two ways: faults in swap pages and device private
pages belonging to a different device, and waits on migration entries. Then
the migrate_vma_*() flow is used to migrate the range.

Sequence 2: migrate_vma_setup() ignores !pte_present() page table entries
After this, the caller follows the same steps as in sequence 1 -
hmm_range_fault() faults in !pte_present() pages, and migrate_vma_*() is
called again to migrate the pages that were faulted in/waited on by
hmm_range_fault().

Now, for the CoW case that you mentioned, I'm going to assume that the
caller wants write permissions otherwise nothing needs to be done:

Sequence 1: hmm_range_fault() -> hmm_vma_handle_pte() records a fault
(hmm_pte_need_fault() returns HMM_NEED_FAULT | HMM_NEED_WRITE_FAULT),
handle_mm_fault() -> .. -> do_wp_page() breaks CoW and maps an exclusive
folio with write permissions, then the migrate_vma_* flow will take care of

Sequence 2, migrate_vma_setup() installs migration entries for the page,
then migrate_vma_finalize() replaces the migration entries with device
private entries.

Looks to me that for CoW pages, all that's needed is migrate_vma_*(), and
the subsequent calls to hmm_range_fault() and migrate_vma_*() are not
necessary. Is that your conclusion too?

> 
> The problem with the first sequence is that you always have to do two
> page walks even when most of the time the pages are present or zero page
> mappings so the common case takes a performance hit.

This is the first mention of the zero page. Is the caller specifying
HMM_PFN_REQ_WRITE? That makes a difference, because it triggers fault
handling for the zero page, and that's an extra walk. Can you give more
details here?

Let's count page table walks when a page is mapped with a valid entry, and
with the required permissions. Let's say N is the number of mappings for
the page (equivalent to the number of VMAs that map the page):

hmm_range_fault() -> .. -> hmm_vma_handle_pte() does one page table walk,
migrate_vma_setup() does N page tables walks, to replace all valid mappings
of the page with migration entries, migrate_vma_finalize() does N page
table walks, to replace the migration entries with device entries.

In total 1 + 2*N walks. Best case scenario, N == 1 (PageAnonExclusive()),
that's three walks.

Do you have any data regarding how often the best case scenario happens?
That's what you seem to be referring to in your comment.

Now let's count the number of walks for a !pte_present() page mapped in P
VMAs, where P != N: one from hmm_range_fault(), if the entry is not a
migration entry, another walk in the fault handler, then 2*P walks from the
migrate_vma_*() flow.

If it's a migration entry, it requires 1 + 2*P walks, PLUS waiting on
migration to complete, which cannot be skipped.

If it's a swap entry, it requires 2 + 2*P walks, PLUS waiting on swap.

If it's a device private entry belonging to a different device, it requires
2 + 2*P walks, plus waiting on the device to sync the memory with the
device in migrate_to_ram().

To summarize:

pte_present()	1 + 2*N walks
migration entry	1 + 2*P walks + waiting on migration
swap entry	2 + 2*P walks + waiting on swap
device private	2 + 2*P walks + waiting on device->memory sync

> 
> The second sequence is better for the common case, but far worse if
> pages aren't present because now you have to walk the page tables three
> times (once to find the page is not present, once so hmm_range_fault()
> can find a non-present page to fault in and once again to setup the
> migration). It is also tricky to code correctly. One page table walk

Valid entry, the page is mapped in N VMAs: migrate_vma_*() does 2*N walks,
best case scenario (PageAnonExclusive) two walks.

!pte_present, the page is mapped in P VMAs:

migrate_vma_setup() -> migrate_vma_collect() will always do one page table
walk, regardless of what it finds, valid or invalid entries.
migrate_vma_collect() ignores !pte_present() entries, and they will not
trigger new walks in the next steps in the migrate_vma_* flow. Worst case
is that all the pages are !pte_present(), that's one walk to find them all
which I would say it translates to zero extra walks for an individual page.

For hmm_range_fault(), it's the same situation as above: 1 + 2*P or 2 + 2*P
walks.

To summarize:

pte_present()	2*N walks
migration_entry	1 + 2*P walks + waiting on migration
swap entry	2 + 2*P walks + waiting on migration
device private	2 + 2*P walks + waiting on device memory->memory sync

I agree with you, this second sequence is better for the common case.

I think it would interesting to know:

1. Is there a relationship between N and P, and if there is, what is it?
Are they equal, on average? I doubt it. Is a !pte_present() page likely to
be mapped in more VMAs than a pte_present() page, or fewer?

2. What is the likelyhood of P being equal to 1 (PageAnonExclusive)? That
would be interesting to know because the larger P is, the contribution of
that extra walk (or two walks) to the total time becomes less and less
significant.

3. How does the time to do the walk compare to the time spent waiting on
migration, or waiting on swap, or waiting on device to memory sync? How
often each of them happen? I have a hunch that these will tend to dominate
the total time.

> could costs over 1000 cpu cycles on X86-64, which is a significant hit.
> 
> We should be able to walk the page table once, faulting
> pages in as required and replacing them with migration entries if
> requested.
> 
> Add a new flag to HMM APIs, HMM_PFN_REQ_MIGRATE,
> which tells to prepare for migration also during fault handling.
> For the migrate_vma_setup() call paths, new flags, MIGRATE_VMA_FAULT,
> and MIGRATE_VMA_WRITE are added to tell to add fault handling to migrate.
> 
> An extra benefit of migrating with hmm_range_fault() path
> is the migrate_vma.vma gets populated, so no need to
> retrieve that separataly.
> 
> This series avoids the problems in current collecting implementation,
> where racing MADV_DONTNEED could make the collecting arrays overflow.

Can you provide more details here? How does it happen?

> This is achieved mainly by having a rollback mechanism and
> populating the collecting array as the last step.
> 
> Tested in X86-64 VM with HMM test device, passing the selftests.

Have you tested that this series doesn't regress other architectures?

> The main goal of this patchset is to provide a new feature,
> migrate efficiently on fault, and not directly improve performance
> of current migrate_vma_setup() (which is now routed thru

I'm a bit confused by what 'on fault' means in this context? Userspace
accesses a device entry, access that causes a fault, or using
hmm_range_fault()? I assume the latter, but it pays to make sure.

Also, can you define efficiently? Usually that's related in some way to
performance, but immediately you say that the series doesn't aim to improve
performance.

> hmm_range_fault()) callers. That said, the migrate throughput tests
> from the selftests show that there is at least no regression for
> current migrate_vma_setup() callers.

If the premise of the series is to reduce the number of page table walks in
the !pte_present() case, then I think benchmarks that show a performance
improvement would make a compelling case for this approach.

Some thoughts, if I may:

- Perhaps the existing test is not the right test to highlight the
  performance gains?

- Perhaps there are other parts of the migration process that dominate the
  walks? If so, maybe we should be focusing our attention on those?

- Perhaps the series adds overhead that reduces or cancels the gains from
  reducing the number of walks?

Thanks,
Alex
