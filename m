Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5C606A338
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vmmyrz6u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED1110E5FD;
	Sun, 22 Nov 2026 17:00:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E2210E5FD
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ACE361120;
 Sun, 22 Nov 2026 17:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0C71F000C0;
 Sun, 22 Nov 2026 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795366829;
 bh=uEqI+Hp2ezJcINVPIUjY03p8JSLOYnYNaqnNBkjZ3rE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Vmmyrz6uK/hYFVidaN2kK+me23a5dUvyk0Op1qeTqHLVqOB88p979QDWelJLt4iap
 Q1sC8F5zSKZsnUF8J+6xDtlQUU5jID1AtgIYKPRDH4joDHKoOdZ9Z0UEKeZAtS4hQx
 yvEnCcbrfkkVFn4UA1Xad0pMG9ZT2em9iF5BDDR36qpKsYiSWqPFlFM2EpWLlPWNni
 AFqo/CI+7GxHabb1n9Gz8W7wZ8CkJ7YkvELRNntoSdhJ45I8dnGf7IW2mmXqth+sBq
 QNCUJ+JztoZssg7tPc2aSRqkemJ25EJPdIv0x9dG+NYWgEVGBcV1LmZgxEIEXdKLDK
 1svDrLaa66c8A==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
Subject: Re: (subset) [PATCH v6 0/4] mm/huge_memory: copy PMDs at fork like
 the PTE path does
Message-Id: <179536682240.11318.5673184071692513568.b4-ty@b4>
Date: Sun, 22 Nov 2026 18:00:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 14:44:01 +0100, Konstantin Khorenko wrote:
> v6 is rebased onto mm/core for-next, as David asked, and patch 2 was
> finished on the way: it now checks the page cache refcount limit before
> it copies a file folio, as copy_present_ptes() and copy_huge_pud() do
> since the refcount overflow fixes. So patch 2 changed after the
> Reviewed-by tags it carries.
> 
> copy_huge_pmd() decides what to copy at fork by its own rules, apart
> from copy_present_ptes(): a lockless check for special PMDs, and a skip
> of every file THP. Following David's review of v3, this series makes it
> decide the way the PTE path does, under the page table lock, with
> vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
> patches:
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: thp-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm/rmap: duplicate a PMD mapping as one in folio_dup_file_rmap_pmd()
      https://git.kernel.org/mm/core/c/4d47d354
[2/4] mm/huge_memory: copy file THPs at fork like copy_present_ptes() does
      https://git.kernel.org/mm/core/c/e21c5cf9
[3/4] mm/huge_memory: read a special PMD under the lock in copy_huge_pmd()
      https://git.kernel.org/mm/core/c/39b0669b

-- 
Cheers,

David

