Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D50C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DF810E6F0;
	Thu, 16 Jul 2026 13:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="C1ksQY2w";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB26310E6F0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784209253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbCYVb6YiEiOlXJDDZ3OmuPdrZmKseoP1YhaSGPcZ4s=;
 b=C1ksQY2wjJboGVw2Xl7RDqw8etHIR9kOpWV/uCl9y1m+sPOD2qW3ePuZKt2lzO+uYJ04bj
 UB+En3RId3CI6uiy9CPnbNWr1roU0bzgZbZEIrbGh4tmTfydAF1GLdXS48ZkSU9GWUDDyt
 ESK+ILio9EGkhP2S2O7dddsqqMHRdWg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-N6zzb590Nvuz4b3AycYIHw-1; Thu, 16 Jul 2026 09:40:51 -0400
X-MC-Unique: N6zzb590Nvuz4b3AycYIHw-1
X-Mimecast-MFC-AGG-ID: N6zzb590Nvuz4b3AycYIHw_1784209249
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39abd6b0c78so3861271fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209249; x=1784814049;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JbCYVb6YiEiOlXJDDZ3OmuPdrZmKseoP1YhaSGPcZ4s=;
 b=hYknapSTasb2iyspKnNTD9IL1DFDpYMVwjbS4fXxbqfkb5VPfL6NSkSoAtYuShgNa/
 ABFNjYq9P6+14qSICw/DSXL09A6essq9cz2bSgopqYlO7hP3QlThmScxHShbkOy2ISrh
 cVyJw5+ZHU67F7VxrHBw9Ww+2RvOMRI511l4ulsTNtN5eK0rmtLvj5msfxMZuk7Qb6Nr
 JvNizBwyRetvA2K5yPS7l1CBgK4jXjEoXVRtgePJsBLQpf+f28MAdYep3Op9eo8QJBA8
 X+d6H8qig+sENOvNg84rxaw3pwRgsVTE5+oEkl1Ox9iY4zohLkIE0VEAlhfntFwjEPkD
 8g1Q==
X-Gm-Message-State: AOJu0Yz3GQlgFYxQP466HyMOzZ08a6O3bXwkjgTtb9Locw9mQ5ZzkzxN
 sIdiBKym3obJbSC9STAOf1c1tX1Z3h08UKfLxBHbzfergc3YseWID0UvGJ2Acv0lIVAttRw294N
 Ayz50luk/wIZeYiJLcMBZbPzkwghNfVoIYz2B/wr6fmFiNA5ZmKAQAMGsZYFUHkrFFiS5
X-Gm-Gg: AfdE7ckXmWEvOGUU8rsksRHJf1ZcNViNXkXVmQfRy806dYDR3e1vTLdyXWVMOIIglS1
 KRK6t4FHlvT1VFWwJq3Xmd2cwRjbHtlGrhzWgkMslbD+mjGjSy36vGQWR7N6B8zbM6sMgU8SspO
 ZuDTwcKWr6rJ0QcNEeghZaZformVWa3ojIX5lUEIZQ8CYKSFLLKAIOr9ewkzZmGTqkoFyHhepgX
 CEWMfA8XXFQnBbLtDAjWokK9uIpDxNeXhqh/mNHNMvXhQPg3EYUuK+LL0kmYZUnMeg3qRfSB0OW
 yi+cQUWWqttnVUIphoQa3ECLirYqNpyTzab+vVNZFuIYuXjbFeAj/O1/ClGM12utXuCfZ6KVpuC
 3E7vClxUn3xgdVQtwFaiEpzJx9A==
X-Received: by 2002:a05:651c:b22:b0:39c:9bae:d990 with SMTP id
 38308e7fff4ca-39ea015810emr5209921fa.10.1784209249281; 
 Thu, 16 Jul 2026 06:40:49 -0700 (PDT)
X-Received: by 2002:a05:651c:b22:b0:39c:9bae:d990 with SMTP id
 38308e7fff4ca-39ea015810emr5209811fa.10.1784209248770; 
 Thu, 16 Jul 2026 06:40:48 -0700 (PDT)
Received: from [192.168.1.86] (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c8489aebasm46328461fa.0.2026.07.16.06.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 06:40:47 -0700 (PDT)
Message-ID: <72e2bdfd-c883-47a8-b121-42a1fe160d9d@redhat.com>
Date: Thu, 16 Jul 2026 16:40:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] Migrate on fault for device pages
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260525084524.139868-1-mpenttil@redhat.com>
 <1612d4cf-b725-4ecf-8618-51a33537f59d@kernel.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <1612d4cf-b725-4ecf-8618-51a33537f59d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uzbYrXTzzfvF-dtxQL9sWJ36L2l4skzppzav2GJFacc_1784209249
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 7/16/26 16:15, David Hildenbrand (Arm) wrote:

> On 5/25/26 10:45, mpenttil@redhat.com wrote:
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
>
> The problem with the first sequence is that you always have to do two
> page walks even when most of the time the pages are present or zero page
> mappings so the common case takes a performance hit.
>
> The second sequence is better for the common case, but far worse if
> pages aren't present because now you have to walk the page tables three
> times (once to find the page is not present, once so hmm_range_fault()
> can find a non-present page to fault in and once again to setup the
> migration). It is also tricky to code correctly. One page table walk
> could costs over 1000 cpu cycles on X86-64, which is a significant hit.
>
> We should be able to walk the page table once, faulting
> pages in as required and replacing them with migration entries if
> requested.
>
> Add a new flag to HMM APIs, HMM_PFN_REQ_MIGRATE,
> which tells to prepare for migration also during fault handling.
> Also, for the migrate_vma_setup() call paths, a flag, MIGRATE_VMA_FAULT,
> is added to tell to add fault handling to migrate.
>
> One extra benefit of migrating with hmm_range_fault() path
> is the migrate_vma.vma gets populated, so no need to
> retrieve that separataly.
>
> Tested in X86-64 VM with HMM test device, passing the selftests.
> For performance, the migrate throughput tests from the selftests
> show similar numbers (within error margin) as unmodified kernel.
> Tested also rebased on the
> "Remove device private pages from physical address space" series:
> https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
> plus a small patch to adjust with no problems.
>
> Changes v11-v12
>   - Fix for issue found by Intel CI in patch 3
>
> Changes v10-v11
>   - Fix nested mmap_read_lock in test suite
>   - Addressed review comments from David
>
> Changes v9-v10
>   - Fix for issue Intel CI found, forgotten pte_unmap() before
>     migration_entry_wait()
>
> Changes v8-v9
>   - rebase on drm-tip
>   - fixed uaf around  migrate_vma_split_folio() usage
>   - added missing pmd unlock
>
> Changes v7-v8
>   - rebase on 7.0
>   - fixed subject in two patches
>   - enhanced commit messages
>   - squashed patch 6 into patch 4 to fix kernel test robot warning
>   - readded dropped Cc block from cover letter
>   - fixed white space
>
> Changes v6-v7
>   - rebase on 7.0.0-rc6
>   - added documentation and comments
>   - denote to be migrated zero page as HMM_PFN_MIGRATE alone
>   - got rid of HMM_PFN_INOUT_FLAGS movement in patch 2
>   - picked up Acked-By from David for patch 1
>   
> Changes v5-v6
>   - rebase on 7.0.0-rc4
>   - use range based TLB flushing while unmapping ptes
>   - gate migration behind HMM_PFN_REQ_MIGRATE for fault and
>     migrate paths
>   - always infer migration flags from migrate->flags only
>
> Changes v4-v5
>   - rebase on 6.19
>   - fixed David's email address
>   - fixed link issue without CONFIG_TRANSPARENT_HUGEPAGE
>   - refactored into smaller commits
>   - added more comments to code
>
> Changes v3-v4:
>   - rebase on 6.19-rc8
>   - fixed issues found by kernel test robot with random configs
>   - fixed typos
>
> Changes v2-v3:
>   - rebase on 6.19-rc7
>   - fixed issues found by kernel test robot
>   - fixed smatch issues reported by Dan Carpenter <dan.carpenter@linaro.org>
>   - fixes to lock handling (pmd/pte) on errors
>   - added assertions for pmd/pte lock states
>   - other issues discovered by Matthew, thanks!
>
> Changes v1-v2:
>   - rebase on 6.19-rc6
>   - fixed issues found by kernel test robot
>   - fixed locking (pmd/ptl) to cover handle_ and prepare_ regions
>     parts if migrating
>   - other issues discovered by Matthew, thanks!
>
> Changes RFC-v1:
>   - rebase on 6.19-rc5
>   - adjust for the device THP
>   - changes from feedback
>
> Revisions:
>   - RFC https://lore.kernel.org/linux-mm/20250814072045.3637192-1-mpenttil@redhat.com/
>   - v1: https://lore.kernel.org/all/20260114091923.3950465-1-mpenttil@redhat.com/
>   - v2: https://lore.kernel.org/all/20260119112502.645059-1-mpenttil@redhat.com/
>   - v3: https://lore.kernel.org/all/20260126111939.1332983-2-mpenttil@redhat.com/
>   - v4: https://lore.kernel.org/all/20260202112622.2104213-1-mpenttil@redhat.com/
>   - v5: https://lore.kernel.org/linux-mm/20260211081301.2940672-1-mpenttil@redhat.com/
>   - v6: https://lore.kernel.org/linux-mm/20260316062407.3354636-1-mpenttil@redhat.com/
>   - v7: https://lore.kernel.org/linux-mm/20260330115611.347988-1-mpenttil@redhat.com/
>   - v8: https://lore.kernel.org/linux-mm/20260414041226.1539439-1-mpenttil@redhat.com/
>   - v9: https://lore.kernel.org/linux-mm/20260505051658.2219537-1-mpenttil@redhat.com/
>   - v10: https://lore.kernel.org/linux-mm/20260505184421.2324798-1-mpenttil@redhat.com/
>   - v11: https://lore.kernel.org/linux-mm/20260525050830.100254-1-mpenttil@redhat.com/
>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
>
> Mika Penttilä (5):
>   mm/Kconfig: changes for migrate on fault for device pages
>   mm: Add helper to convert HMM pfn to migrate pfn
>   mm/hmm: do the plumbing for HMM to participate in migration
>   mm: setup device page migration in HMM pagewalk
>   lib/test_hmm: add a new testcase for the migrate on fault
>
>  include/linux/hmm.h                    |  19 +-
>  include/linux/migrate.h                |  26 +-
>  lib/test_hmm.c                         | 118 +++-
>  lib/test_hmm_uapi.h                    |  19 +-
>  mm/Kconfig                             |   2 +
>  mm/hmm.c                               | 843 +++++++++++++++++++++++--
>  mm/migrate_device.c                    | 583 +++--------------
>  tools/testing/selftests/mm/hmm-tests.c |  54 ++
>  8 files changed, 1086 insertions(+), 578 deletions(-)
> What's the status of this?
>
> Patch #3+#5 are extremely hard to review, I wonder if there could be a better
> way to split this up better so we get smaller changes that can be more easily
> reviewed.
>
I will send V13 with few fixes/improvements in couple weeks when back from PTO.
I will also address the recent "pmd becomes huge or cleared" affecting mainline migrate_vma_collect()
Not sure about the split though, patch 4 is mostly move over from migrate_device.c and patch 5 testcase.
But I try to see if there's some sensible way.

Thanks,
Mika

