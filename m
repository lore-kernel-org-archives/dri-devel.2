Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E9606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=q0ovCD7x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B676F10E94F;
	Fri,  6 Nov 2026 05:18:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6D610E94F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:18:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E62443CC8;
 Fri,  6 Nov 2026 05:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8BD1F0089F;
 Fri,  6 Nov 2026 05:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1793942301;
 bh=w/aL1sjxZAD4jPRBmObfPh4EoB+Er0nYqQkFKEvP8dI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=q0ovCD7xIiR0+ANf/raivI4OhRAQOY6dX6Pc57lH4HPcSvDIuQJ3knVapFQmGtx5L
 RcTkRAX3SqUxY4Q6SCFu12gdGRAQ88bWqEZUPiRcnOFZFeJ928jqdsddLogK7ZrlCA
 85oG4mh8tHfOEMRS42hc30LZfmiSJv2AgWPj1LD0=
Date: Thu, 5 Nov 2026 21:18:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Peter Xu
 <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, =?ISO-8859-1?Q?Lo=EFc?= Molinari
 <loic.molinari@collabora.com>, Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 0/4] mm/huge_memory: copy PMDs at fork like the PTE
 path does
Message-Id: <20261105211819.2a6a349b2edc077784ca52f9@linux-foundation.org>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 21:40:54 +0100 Konstantin Khorenko <khorenko@virtuozzo.com> wrote:

> copy_huge_pmd() decides what to copy at fork by its own rules, apart
> from copy_present_ptes(): a lockless check for special PMDs, and a skip
> of every file THP. Following David's review of v3, this series makes it
> decide the way the PTE path does, under the page table lock, with
> vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
> patches:
> 
> 1. folio_dup_file_rmap_pmd() duplicated a PMD mapping as HPAGE_PMD_NR
>    PTE mappings. It had no caller until patch 2.
> 2. File THPs are copied at fork instead of being refaulted by the
>    child, as their PTEs would be.
> 3. The special-PMD read moves under the lock. That closes the race with
>    a driver zap (vfio-pci, panthor) and the missing page table deposit
>    on ppc64 hash that Sashiko found in v1.
> 4. A selftest for 1 and 2.
> 
> ...
> 
> Cost
> ====
> 
> fork() now copies file THPs instead of leaving them to a refault, which
> costs fork() a reference, an rmap update and a counter per huge PMD and
> saves the child a fault per huge PMD it touches. fork() of a process
> with 4 GB of shmem THPs mapped MAP_PRIVATE and an anon_vma on the VMA,
> medians of 2000 forks:
> 
>   +-----------------------+------------+-------------------------+
>   | kernel                | fork()     | fork(), child reads all |
>   +-----------------------+------------+-------------------------+
>   | 7.3-rc7               | 86-129 us  | 2380-2620 us            |
>   | 7.3-rc7 + this series | 230-355 us | 820-930 us              |
>   +-----------------------+------------+-------------------------+

The second column assumes that the child touches all the file THPs,
yes?  If the child touches only a small proportion of those mappings,
or just does fork+exec, that changes the "Cost" comparison?

And on ppc64 hash-mode setups this also allocates deposited page tables
for mappings which the child might never touch?  So a modest increase
in memory use is to be expected?  I can't say I care about this
(sorry!).

But I worry that this change is not an overall win for thp-file
mappings, which are the common case.

I'm not understanding why we need to mess with thp-file behavior at all
in order to address a special-PMD bug?

> Notes
> =====
> 
> - drm_gem_shmem and mshv_vtl map special PMDs with
>   vmf_insert_pfn_pmd() as well.
> - copy_huge_pud() still differs from the PMD tail in that it does not
>   mark a shared PUD clean in the child or handle uffd bits.
>
> ...
>
> Reproducer.

Changelog is soooo long.  I replaced this Reproducer section with simply

	- A reproducer is at the Link;

So interested people can still find it.


Anyway, bugfixes come first so I'll fix the selftest pmd_psize thing
and I'll toss this onto the pile, thanks.


I'm attempting to runtime test this on local LLM-driven live kernel
test setup, but it keeps on kicking me out and calling me a
cybercriminal.  Sigh.  Giving up.

