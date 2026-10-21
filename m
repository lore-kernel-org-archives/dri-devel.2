Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC66606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IM1dwIjH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9C110F90B;
	Wed, 21 Oct 2026 06:06:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0E910F913
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792562752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRp11JQAq7GQu9HIl0KlaLyGmrFE0h6wJDEFiX0LaJY=;
 b=IM1dwIjHDjKDEXaw0pxEDfV8sJZjmTAISYmkp64tLOpbeztqtT1c1eJagGtuWmJMZj28QE
 bqT4DUzQnDsNxBitHCwH3bmTyQjuG5Z29fS2vcKMkL51SO4b3QOGxquOww8jSrMVClLCJ3
 L8AdqmFINCpskR1PZEloPDWWCiUQv3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-WJeAiR3pODilMuSH8FW_oA-1; Wed, 21 Oct 2026 02:05:45 -0400
X-MC-Unique: WJeAiR3pODilMuSH8FW_oA-1
X-Mimecast-MFC-AGG-ID: WJeAiR3pODilMuSH8FW_oA_1792562743
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e17d30a79so185136f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562743; x=1793167543;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cRp11JQAq7GQu9HIl0KlaLyGmrFE0h6wJDEFiX0LaJY=;
 b=Fj660Wunzs8EZir7ZXCMUaXOOT9NPnHHOkoZkzfcWBhmr6HxaM33tbQG+WS0zPQrQF
 PaNN8amujqhl/TIPZGN26IyU67dfQpd7RZizKODAyvrvrGha+aiU7QYgjUPsr1K67+mY
 duLSBlHIsmhUCf7TGUvvZQetzIE1GcZS5sgcIr3/znM1FkheEDQxV5yThAIyB36/BlU4
 G+F4d+PO+ZIC1LyTAo2KUozeookzX0CV8XsceIIyMLVMG5oMCt2lClCxFjJkoU8duHYW
 kNkux4TSZCtmWX6/mDOKrqp9lsKOaJhksDwO+BtKAKsao7zy8jcroT2fE5HmibQX19iO
 6EUQ==
X-Gm-Message-State: AFq9FYLElOSAaVXdFF5PcJuTlcHlzywPc2tRwJxqIxHAhjEk2MkWgfNq
 gVNnzAFKxJPZDFHs5VmAriHU1Ik6n18JugXJMvwXyClGal/X9RRRhMzW1529cbgdYMvtCCaR9Gd
 hgtnyIr8S8rM6MwvspuhiY1NYVcHItPTUJK5xOi3a6bZ1AHwzcSpipZUoMeYnHETEreg6
X-Gm-Gg: AYBFou2wXIZJDijqs+HjtajuERNS2yfUYtTsEK8wKOn0jr+pTlH2SSFcOe37uD3+hSV
 7u3LfZTG+3JyGs/J54naJkaaBnsn0X4jSpFQFF38YHMXlTrFHe6iib0MJFTxAucda8FE1z3/7uu
 /q3MPYXbISIzIYccvSALZettKB6g6sYFhD3Ozl1e3YXkrABlSCRiIw8DtLnR9rXFffv6h6Z3Fnu
 IVlc+6xqUL9hV0ubQ1xbsyUaW/YSES6+al7nW8cmAOzf7LbP5rmF7UCCEz5XZVRuKxc98TW+i64
 KyzwNbbBAMEzHNXqVfVPif4mUy8I71SZz+d8+8nBjz6b77ZLW3gTzQZOVcANb6EPtYyuf3W/953
 6bvCOfjQolTc7vdsfjbyH3aSPjQlWOu9XrLQz
X-Received: by 2002:a05:6000:2612:b0:48d:f9a4:bd68 with SMTP id
 ffacd0b85a97d-48e264e3068mr1528353f8f.27.1792562743453; 
 Tue, 20 Oct 2026 23:05:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2612:b0:48d:f9a4:bd68 with SMTP id
 ffacd0b85a97d-48e264e3068mr1528301f8f.27.1792562743063; 
 Tue, 20 Oct 2026 23:05:43 -0700 (PDT)
Received: from fedora.redhat.corp (89-27-86-246.bb.dnainternet.fi.
 [89.27.86.246]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm3413741f8f.3.2026.10.20.23.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:05:42 -0700 (PDT)
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
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v16 07/12] mm/hmm: add lazy MMU mode support for migration in
 HMM pagewalk
Date: Wed, 21 Oct 2026 09:05:01 +0300
Message-ID: <20261021060506.2377545-8-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021060506.2377545-1-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SDBg-U4uhq0Mn9udorN6Ap-vfTxFfgb5cTHzf1kAp6c_1792562743
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 5891efee3e18..36a4edde9823 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -373,6 +373,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		/* Report error for everything else */
 
 		if (hmm_vma_walk->ptelocked) {
+			lazy_mmu_mode_disable();
 			pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 			hmm_vma_walk->ptelocked = false;
 		} else {
@@ -396,6 +397,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			if (hmm_vma_walk->ptelocked) {
+				lazy_mmu_mode_disable();
 				pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 				hmm_vma_walk->ptelocked = false;
 			} else {
@@ -415,6 +417,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 
 fault:
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
@@ -555,6 +558,7 @@ static int migrate_vma_split_folio(struct folio *folio,
 	if (folio != fault_folio)
 		folio_get(folio);
 
+	lazy_mmu_mode_disable();
 	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 	hmm_vma_walk->ptelocked = false;
 
@@ -1110,8 +1114,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 
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
@@ -1155,6 +1161,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		flush_tlb_range(walk->vma, start, addr);
 
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
-- 
2.55.0

