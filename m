Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759D8C98307
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CC710EB65;
	Tue, 22 Sep 2026 05:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VQS5CPWR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409F910EB55
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3/indgfaSaWc6lWBv7sZZH36jWcDt4waMnqUjoKZgQ=;
 b=VQS5CPWRqzGS58O82hPZzXW8492UTAchvT4Ny4pzwxjXnEzTb/XEbe5YjFk4Adl9WSdhP/
 1cNoyEPGNxHz3Ej8Lar+4Kunw8DFDdnKryzYF5opBAjC5d9baDoxJGRD01Vrg8AkjcDRmb
 GdkC0qUaBDpLEuzonmayUSm5UXRwtxI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-lq0Lz_fSPq6Mqov9hl0isA-1; Tue, 22 Sep 2026 01:35:05 -0400
X-MC-Unique: lq0Lz_fSPq6Mqov9hl0isA-1
X-Mimecast-MFC-AGG-ID: lq0Lz_fSPq6Mqov9hl0isA_1790055304
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b609be5e96so2237458e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055303; x=1790660103;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j3/indgfaSaWc6lWBv7sZZH36jWcDt4waMnqUjoKZgQ=;
 b=EemhEgYUQ8TVDINQG2IupqS5MAec+qEV4UBommp2cMIhAQ7irf+NeODOrjCAtI16pj
 J493gqV54C9lkDpZT8/s9LBZb9NbYuageo0rQUzfcIDvgcPZT2r2wUboCHf9PMU84rEQ
 hopLcVqAIUOXs514hyjvFbIqVjrkNpcABBw4tjFYNrXGJo5vc+CtW/4NhZ0hnECZWYQp
 F2WAlDWNVRyzx6hWwuoUb0mhR96cvG8+5oazCb0wEgADXzTQhsPVDBiAQbnsCQYGc7+c
 z05sU0BGVM23C4Xitai/f+iUnBhwfLSqoIp4fFWo6wyHvBtBOTRCd7TDZ6ILQgTZz6gz
 gi9Q==
X-Gm-Message-State: AFuF++mWEPsPwk/U2+N/uC8Z974dhz3GliX7UEzXaxHrXad3B0oTZFfS
 rr1zZ94Fchj7QlTweulKR+agyFdcqHBy7SRUGb6sl9FMUKLbCVjWePEDRmUUBkZxpdP0q3ulRmy
 eNz2OzLjTjqV8F2afCRmYaQIGE2HKN+kP/gVM1aAyJJ2pMG/vsi/rdMJ6+gy5ww9UuEwE
X-Gm-Gg: AYBFou1nL5jm8HwgeegKjsS8LAB39Fo/miS/I0BrWOqMqDJ1lFNCQB7YIdIWOXfb3f3
 kpPmM85O2XvRCXGP6Y72dz2F9huEp3RFRt/1lAft46blFYhxZTsbPZcHGjeEvDgeRxxCT8m7OBf
 jy9IJIW+U5uaoiKhUimSl/kG3X+IWYE6eFNbVSwzPf1BwxKTeeO5GvUc2HTEBTpKqpXVHAF/DaV
 2X6ljvr9ztVhcNBOAbKscQY7qrPF8n47acLnOQwIYNfWIyIg/MHsm2DkxyhYZuTzTdkyjUayALA
 Hz8XMReCiuLEqE/G8DX9e7LD/o06LaoDhHHzxfQpeQ9yzEfejpBZA6FiAVhy/kg8QZTjRz6wYQb
 6p5RY4USkc8uPoZ6oXqcb+1Yn/rePfb0=
X-Received: by 2002:a05:6512:110b:b0:5b6:183b:d215 with SMTP id
 2adb3069b0e04-5b8c195af81mr3584659e87.60.1790055303498; 
 Mon, 21 Sep 2026 22:35:03 -0700 (PDT)
X-Received: by 2002:a05:6512:110b:b0:5b6:183b:d215 with SMTP id
 2adb3069b0e04-5b8c195af81mr3584632e87.60.1790055303030; 
 Mon, 21 Sep 2026 22:35:03 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:35:01 -0700 (PDT)
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
Subject: [PATCH v14 08/12] mm/hmm: add lazy MMU mode support for migration in
 HMM pagewalk
Date: Tue, 22 Sep 2026 08:34:17 +0300
Message-ID: <20260922053421.4092027-9-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hm_szFhQXmEUAGCB3lU0Ys4KQOwuhANxoxkgiFOdluM_1790055304
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
index a1459bd34c04..a67a23e54551 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -371,6 +371,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		/* Report error for everything else */
 
 		if (hmm_vma_walk->ptelocked) {
+			lazy_mmu_mode_disable();
 			pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 			hmm_vma_walk->ptelocked = false;
 		} else {
@@ -394,6 +395,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			if (hmm_vma_walk->ptelocked) {
+				lazy_mmu_mode_disable();
 				pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 				hmm_vma_walk->ptelocked = false;
 			} else {
@@ -413,6 +415,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 
 fault:
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
@@ -510,6 +513,7 @@ static int migrate_vma_split_folio(struct folio *folio,
 	if (folio != fault_folio)
 		folio_get(folio);
 
+	lazy_mmu_mode_disable();
 	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 	hmm_vma_walk->ptelocked = false;
 
@@ -1135,8 +1139,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 
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
@@ -1178,6 +1184,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		flush_tlb_range(walk->vma, start, addr);
 
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
-- 
2.55.0

