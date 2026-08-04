Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF63C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DF010E856;
	Tue,  4 Aug 2026 04:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UpOic/8A";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF6A10E853
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785817656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxWvLz6f1rN1o4scxqJnXGGSQRdc4CCCHPneXFEhe/4=;
 b=UpOic/8AhDoGeW6KLHSDTR4Qt5ReYuZDi6jN9hqU24d8QLICqulAeZHe6sgTsS2G13/Apa
 Yrs1qU+2NCZ2c7t475mNFURWOYrWbj7ppzLR2nLkNTIQ8Ru2v/RqwzCaTOxwfWm4GHJbqE
 TQRkj+MjlPrgo2U74rnzZT4+hLoKqX0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-BNONstS1O_GZgdJIZR0u_Q-1; Tue, 04 Aug 2026 00:27:30 -0400
X-MC-Unique: BNONstS1O_GZgdJIZR0u_Q-1
X-Mimecast-MFC-AGG-ID: BNONstS1O_GZgdJIZR0u_Q_1785817649
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aebd5e989cso2670922e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 21:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785817648; x=1786422448;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxWvLz6f1rN1o4scxqJnXGGSQRdc4CCCHPneXFEhe/4=;
 b=kK4/afIshqKDHRVnD5hszqRcratLEitsIUfewN8kknEt9w8mdLBzMxpk8DOCX2ctdP
 dtNGY6gOnNAeAUq21v6VukA0Ie9mjKsvq1aG919QrjBBiRBNQpv6HEAizk+YiJ6/nrto
 Z3L8dP8WpbvNOtM/TaLRDDsRkVVWzGUI+qSx7+di256zbmPHqTrVQ70JOGRLHiTgdaUD
 mLVpuoy9Lru02ZRk7my3B+ZXvnFLPmXn/KVGPZCGJyIH7raCJCB9Hs7KV+2uL0JeS3xX
 c4MYpUQKLWDVFNmoRlCmx8ce1vCCQVtRAyqU8z4KCAwQYtYSAZs9rnDNzq0y9uUAZjnl
 zi6A==
X-Gm-Message-State: AOJu0YzAalhHKQZNuSZtDPSFE5LGj6fNugo57vOwY9yZKLa5HCwamsa1
 WXbebWQCYtS5b84xFO4jLT+Xe81Mq6MZeTP8XZ/mtT5foliC0mCjyAc/jGBsK/2tkjDrSVrKHOs
 DwgpE5fghF6C8SIvjNB7iGE2jGlDUkmS7Vqh74p4wEsjK2K52YvTlHZCzPjf2yED4GZ3h
X-Gm-Gg: AR+sD10lVOLxryJcvwqT5EXTV6hCab2x9sG1f/ugNsb5wCn9nePZaUP/kf4fwbBBhwU
 AiloD1c1USCVI9jYaoP+3nPedy0GIRz4uh1L8smKbrBqkf4VcbFXCFSpaKxzO1yXGrcAV7TWeZA
 0vWW0otndXKzP8ddISc26LXmnJc8xsF/ehtsOcqrsdux7L/km2EJ5gn6z9SOHMtcQM22SDovZ4n
 y7KcJgDRkcKEduf2ztLhOLod4+3YoRGPzzoOFnnO+GNSU6SdawnCgBG2f8BriSxdLqJFcOtjCv5
 5hSk0gg8jK5pTgiBuRalemJQ9jLRfA3DDHJTe81WKgZdDpf1uVgEXLZ5E+3gPmwvkMAqfZh3PDe
 D5H+ePHM+xQK5vh8A
X-Received: by 2002:a05:6512:8051:b0:5ae:b86b:71ee with SMTP id
 2adb3069b0e04-5b2e4f6d5c4mr1858474e87.38.1785817648613; 
 Mon, 03 Aug 2026 21:27:28 -0700 (PDT)
X-Received: by 2002:a05:6512:8051:b0:5ae:b86b:71ee with SMTP id
 2adb3069b0e04-5b2e4f6d5c4mr1858457e87.38.1785817648175; 
 Mon, 03 Aug 2026 21:27:28 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e23c46c4sm2311351e87.17.2026.08.03.21.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 21:27:26 -0700 (PDT)
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
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v13 08/11] mm/hmm: add lazy MMU mode support for migration in
 HMM pagewalk
Date: Tue,  4 Aug 2026 07:26:28 +0300
Message-ID: <20260804042631.2175585-9-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804042631.2175585-1-mpenttil@redhat.com>
References: <20260804042631.2175585-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lT4m3f9gdoJMUSWWjwnmUHR483ztuVUSOjZY7C_HjXs_1785817649
X-Mimecast-Originator: redhat.com
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

From: Mika Penttilä <mpenttil@redhat.com>

Add calls to lazy_mmu_mode_enable() and lazy_mmu_mode_disable()
while doing migration.

Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 mm/hmm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 61b9147fd8ed..631f6b4d52fc 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -368,6 +368,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		/* Report error for everything else */
 
 		if (hmm_vma_walk->ptelocked) {
+			lazy_mmu_mode_disable();
 			pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 			hmm_vma_walk->ptelocked = false;
 		} else {
@@ -391,6 +392,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			if (hmm_vma_walk->ptelocked) {
+				lazy_mmu_mode_disable();
 				pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 				hmm_vma_walk->ptelocked = false;
 			} else {
@@ -410,6 +412,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 
 fault:
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
@@ -507,6 +510,7 @@ static int migrate_vma_split_folio(struct folio *folio,
 	if (folio != fault_folio)
 		folio_get(folio);
 
+	lazy_mmu_mode_disable();
 	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 	hmm_vma_walk->ptelocked = false;
 
@@ -1132,8 +1136,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 
 	if (minfo) {
 		ptep = pte_offset_map_lock(mm, pmdp, addr, &hmm_vma_walk->ptl);
-		if (ptep)
+		if (ptep) {
+			lazy_mmu_mode_enable();
 			hmm_vma_walk->ptelocked = true;
+		}
 	} else {
 		ptep = pte_offset_map(pmdp, addr);
 	}
@@ -1169,6 +1175,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		flush_tlb_range(walk->vma, start, addr);
 
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
-- 
2.55.0

