Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FD60A2629
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=I51Wzs14
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA22310E068;
	Thu, 19 Nov 2026 18:32:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9962310E7B8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:32:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8599E61810;
 Thu, 19 Nov 2026 18:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB8F1F000C6;
 Thu, 19 Nov 2026 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1795113132;
 bh=rnpSKrnFQmYg+ietBlmwBi39cYR0OhHgd0OQTIatyVs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=I51Wzs14XbAG4qsckU/kwl6HJ858CxkZd8Rp3hB5PXisfTLMvM35ZoKvjH++juonX
 AL35Xk4tz1hhVpn9MtlJe0CUC+dxBvx6wMLVyxPSbVNqCySeMu/oKGY6gfD+0PY32E
 Ko4FR8GzYJBzLWe5QJX14zKR7S65A6HAY0c6Ypaw=
Date: Thu, 19 Nov 2026 10:32:10 -0800
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
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Yeoreum Yun
 <yeoreum.yun@arm.com>
Subject: Re: [PATCH v6 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
Message-Id: <20261119103210.24a7612ee26c3ffc3db49451@linux-foundation.org>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-4-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
 <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-4-efa7817a2bb3@virtuozzo.com>
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
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 14:44:05 +0100 Konstantin Khorenko <khorenko@virtuozzo.com> wrote:

> Fork a process that maps shmem THPs with PMDs, in a VMA whose page
> tables fork copies: a private mapping with an anon_vma, and a shared
> one with a guard region. The child must find the PMDs before it
> touches the mapping, and its exit must leave the parent's mapping and
> the system-wide ShmemPmdMapped counter as they were.
> 
> With folio_dup_file_rmap_pmd() adding PTE mappings, the child's exit
> takes the parent's share off ShmemPmdMapped while the parent still maps
> the folios. Unmapping them drops it once more, so every mapping stays
> until exit, where the kernel reports "Bad page cache", or hits a
> VM_BUG_ON with CONFIG_DEBUG_VM. A kernel that leaves file THPs to a
> refault in the child skips the test.
> 
> ShmemPmdMapped is system-wide, and reclaim or NUMA balancing can take a
> PMD from the parent while the test runs. So the test makes up to three
> attempts, each on a fresh file, and fails only if all of them see the
> counter drop by exactly the parent's share: the bug does that on every
> fork, other processes only by chance. It passes on the first clean
> attempt and skips when none is clean.
> 
> The test mounts a tmpfs with huge=always over /tmp in a private mount
> namespace, so it leaves the THP settings and the host's mounts and
> files alone.
> 
> ...
>
> +static void test_fork(bool shared)
> +{
> +	const char *desc = shared ? "shared mapping with a guard region" :
> +				    "private mapping with an anon_vma";
> +	long before = 0, after = 0;
> +	enum result res = NO_THP;
> +	int i, drops = 0;
> +	char *mem;
> +
> +	for (i = 0; i < ATTEMPTS; i++) {
> +		mem = map_file(shared);
> +		/* Make fork copy the page tables; the last PMD gets zapped. */
> +		if (shared) {
> +			if (madvise(mem + size - pagesize, pagesize,
> +				    MADV_GUARD_INSTALL)) {
> +				ksft_test_result_skip("%s: MADV_GUARD_INSTALL: %s\n",
> +						      desc, strerror(errno));
> +				return;
> +			}
> +		} else {
> +			mem[size - pagesize] = 'p';
> +		}
> +
> +		res = pmds_ok(mem) ? fork_once(mem, shared, &before, &after) :
> +				     res == NO_THP ? NO_THP : LOST_PMDS;
> +		/* Later children get only their own mapping. */
> +		madvise(mem, size, MADV_DONTFORK);

autobot want the return value checked:

: If this fails, the next child inherits an earlier test mapping too. 
: Its exit can then change ShmemPmdMapped by more than the expected
: amount, causing the test to skip a real failure.

which seems ignorable - MADV_DONTFORK failures are super unlikely at present.

>
> ...
>
> +int main(void)
> +{
> +	ksft_print_header();
> +	pagesize = getpagesize();
> +	pmdsize = read_pmd_pagesize();

This is going to ruin Mark's day again, thanks to "kselftest: mm:
rename read_pmd_pagesize() to pmd_psize()".

I think I'll alter Yeoreum's above patch like this (presently untested):

--- a/tools/testing/selftests/mm/vm_util.h~kselftest-mm-rename-read_pmd_pagesize-to-pmd_psize-fix
+++ a/tools/testing/selftests/mm/vm_util.h
@@ -93,6 +93,8 @@ unsigned long pagemap_get_pfn(int fd, ch
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t pmd_psize(void);
+/* temporary cross-tree compatibility thing: */
+#define read_pmd_pagesize() pmd_psize()
 unsigned long rss_anon(void);
 bool check_huge_anon(void *addr, size_t len, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, size_t len, int nr_hpages, uint64_t hpage_size);
_

and we can clean that up later.

