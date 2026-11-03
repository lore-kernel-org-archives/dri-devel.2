Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03600606A337
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NdVLYk0f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC8210E771;
	Tue,  3 Nov 2026 06:17:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364B210F38E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVuWgoTT0NSjTET4nXrhDaEgg40Gfb3itKSJW0X7/Jo=;
 b=NdVLYk0fAuM7/GXgYcg+4TbujGBLdzFk76v8Aiet4s7AP2vLKQJFutsLbRDvf2hC/wtK0x
 diLuzQ2aPe+WJI3NR2oIQj2SOvabJimtYy9XwpKc3Z8bCzzxAtVUuQzzAPuYO7cBvWpFV/
 GqG637WZnRcnGAQfU0iPhjhe1CCLd9M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674--ig9uT8nOWSYPLQVAne6Gw-1; Tue, 03 Nov 2026 01:17:23 -0500
X-MC-Unique: -ig9uT8nOWSYPLQVAne6Gw-1
X-Mimecast-MFC-AGG-ID: -ig9uT8nOWSYPLQVAne6Gw_1793686641
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5be4b14ffd6so128863e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686641; x=1794291441;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TVuWgoTT0NSjTET4nXrhDaEgg40Gfb3itKSJW0X7/Jo=;
 b=CPpEQqjA5SYkWTUAQZ68BcuZiV7GmTSwN+ZiOh36YZ83VK35OYrCDi7YPKmZzi7MhU
 f8ORj+8nTfKgb6vaFcp972cZwqm4YSJAx6xpG0g6BGC3ELeW/sQotlEsX3WvPaeZQ9em
 cWHGZh0ICi+HrqHuMcXPrdfIss484aH+dZYmPk94Iw83zroT2OqwO+ik37ed2DmoaC4G
 O6mGPoBarKZk9FdSakAV4fAuyxDd4LGCEdg3ImaZv9rlGmYY8zkiynkdZ9stDwWvLZR3
 KMa729lvZYXWfnGyAZ65rnkdZIay4PpSAxQJuMY3iM+YKvbJPkWNbrT4NWHn9ZWktI4Q
 ZUOg==
X-Gm-Message-State: APuU4Z87SysIkVPXOOOdvOoh4xALtVTziuYlmVtK/9Tss0n06PwgwDfn
 tJWFDcNdrd72VjdXLbIPUpCmfsbKqI/lP4xES/Kf5238LcB47WfH2+4rA/8JzRnUOKf8Pv/yM0E
 cG86v3hI5a14bPLYgBZhOPlc/OzrH0ZiSbojjdGyco6PgTdqshU8Tu+rgTgM8xiFOCKrp
X-Gm-Gg: AYBFou15VkJVu6ZyLlFtaBQBeIpQ/0qwgOy+p3+OKGv2fzHsKYQMpM1tmoT2qNBFm4Z
 5Qf96X6Mwwawam39TweEmmf8csxbBAO6Zl3LdMFhaYF+cyQ+GQaO1YdPSbi1kVOe+4N3vXRU5MG
 rP4M1/slvR7kGCbSpgTRFD/O5HO77fk7PM/fz04E2e1Xui1Pc1jHc62IA7/gab/75uQlMUSzj4Q
 6PbFl2ZSQ0JASW5HRCSy9tiYlZK7lH94quB+63Xj3RKCsZcAGCgdzRUS8okegv9771OiKGtHcei
 rduejHo/mXxXm8h6yZKLX8uZb05VSh9dRzxRcHoqiFChL8RA+2Ewr9HaRHYu6K41oKNSbAuA3NR
 H8ztpT6ITHgqDZi0JQVYFUPLYQRiFrTPxAYIS1jZgDd2ZOrBxkUeymmvTKGX7wtbhHibljQ==
X-Received: by 2002:a05:6512:a83:b0:5ba:3e27:6a32 with SMTP id
 2adb3069b0e04-5bfd12073cfmr4453057e87.29.1793686641417; 
 Mon, 02 Nov 2026 22:17:21 -0800 (PST)
X-Received: by 2002:a05:6512:a83:b0:5ba:3e27:6a32 with SMTP id
 2adb3069b0e04-5bfd12073cfmr4453033e87.29.1793686640906; 
 Mon, 02 Nov 2026 22:17:20 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:17:19 -0800 (PST)
From: mpenttil@redhat.com
To: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v17 11/12] Documentation/mm/hmm: document migration through
 hmm_range_fault()
Date: Tue,  3 Nov 2026 08:16:28 +0200
Message-ID: <20261103061629.972669-12-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iNSC-HAGoAVA2wSNPKqvkqa5bwfxIoy7zj5Y-h814eI_1793686641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mika Penttilä <mpenttil@redhat.com>

Describe the two new MIGRATE_VMA_FAULT / MIGRATE_VMA_WRITE flags of
migrate_vma_setup(), and add a section on driving the migration
collection phase directly from hmm_range_fault() via HMM_PFN_REQ_MIGRATE
and migrate_hmm_range_setup().

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 Documentation/mm/hmm.rst | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index fc1b8dc19825..914ef6bfe848 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -348,6 +348,13 @@ between device driver specific code and shared common code:
    Currently only anonymous private VMA ranges can be migrated to or from
    system memory and device private memory.
 
+   By default only pages already present are collected. Two additional flags
+   ask migrate_vma_setup() to fault in missing pages first:
+
+   * ``MIGRATE_VMA_FAULT`` faults in missing pages with read access.
+   * ``MIGRATE_VMA_WRITE`` faults in missing pages with write access
+     (implies faulting).
+
    One of the first steps migrate_vma_setup() does is to invalidate other
    device's MMUs with the ``mmu_notifier_invalidate_range_start()`` and
    ``mmu_notifier_invalidate_range_end()`` calls around the page table
@@ -427,6 +434,44 @@ between device driver specific code and shared common code:
 
    The lock can now be released.
 
+Migration collection through hmm_range_fault()
+==============================================
+
+The collection phase of migration (steps 1 and 2 above) can also be driven by
+hmm_range_fault() directly, sharing its page table walk. This lets a driver
+fault in and collect a range for migration in one walk, which is useful for
+migrate on fault.
+
+To do so, the driver sets ``HMM_PFN_REQ_MIGRATE`` in ``range->default_flags``
+and points ``range->migrate`` at a ``struct migrate_vma`` it has filled in
+(``flags``, ``src``, ``dst``, ``pgmap_owner``). Usually ``HMM_PFN_REQ_FAULT``
+(and ``HMM_PFN_REQ_WRITE``) is set as well, so missing pages are faulted in
+before being collected. The mmap_read_lock() has to be held for the whole
+migration, since the vma must stay stable.
+
+Migration requests come only from ``range->default_flags``:
+``range->pfn_flags_mask`` must be 0 and ``range->dev_private_owner`` must
+equal ``migrate->pgmap_owner``. ``range->hmm_pfns`` is cleared at the start of
+hmm_range_fault(), so per-pfn input, including ``HMM_PFN_INOUT_FLAGS`` such as
+``HMM_PFN_DMA_MAPPED``, is not preserved across a migrating call.
+
+hmm_range_fault() collects the entries the same way migrate_vma_setup() does,
+taking a folio reference, locking it and installing a migration PTE. Collected
+entries are marked with ``HMM_PFN_VALID | HMM_PFN_MIGRATE`` in
+``range->hmm_pfns``. If the page tables change while locks are dropped the
+partially collected entries are rolled back automatically.
+
+After hmm_range_fault() returns, the driver calls::
+
+    void migrate_hmm_range_setup(struct hmm_range *range);
+
+to translate ``range->hmm_pfns`` into ``migrate->src[]`` (``migrate->dst[]`` is
+zeroed) and initialize ``migrate->cpages`` and ``migrate->npages``. From here on
+the ``range->migrate`` struct is ready for the rest of the flow (steps 3
+onwards), i.e. migrate_vma_pages() and migrate_vma_finalize(). This should be
+called even on error, since hmm_range_fault() may have collected part of the
+range before failing.
+
 Exclusive access memory
 =======================
 
-- 
2.55.0

