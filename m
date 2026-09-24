Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4983C98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2DD10F330;
	Thu, 24 Sep 2026 06:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Sl23vWiK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65ECE10F328
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vz+W5yHAoWI5ZxzvIYZX65gg07ZvreXTcI/Y7c3cDnc=;
 b=Sl23vWiK1SlrSeVkszoxOCTdUzwfOSoLlgVwHCcRdZtGbic/c8a9RcLBoeLAqQIHuHOqjA
 +Q84cYwobS+/ZYsFIYK2Si7sgsRidcEpL9p0JtC2HE8Zatx/5ldJndVoG3fR6chhPm6bbs
 vTjlTUJCUJFS8RkXTfI+hdXZAuGEvf0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-GJHyxEqNO9-Ik-e7TdYzVg-1; Thu, 24 Sep 2026 02:54:00 -0400
X-MC-Unique: GJHyxEqNO9-Ik-e7TdYzVg-1
X-Mimecast-MFC-AGG-ID: GJHyxEqNO9-Ik-e7TdYzVg_1790232839
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a6442413adso1038171fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232839; x=1790837639;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vz+W5yHAoWI5ZxzvIYZX65gg07ZvreXTcI/Y7c3cDnc=;
 b=BpplHM+4NQxvnKeZYhYoZVKsMjmGxzXNOX38pnXtv9ejpPM5BmXaVudpPS9tZXDVtL
 //YITvzQQf47dAIOVpqmBGvjR15Cfd7CiS46jAsr6bXxbaFsyuGJh+zmYmPQcK+l47ZG
 PTqicOfdIfEmqV3X4U+K6FtXMBbWJdsTTg4U1ldMLpvS0sbfmJupHK/CKpJVBH7lrgs0
 AnC/zMbFd5+SszKMxG0B2EM35dUFQbOPW2jDtBw48G07rpiKHIS+aMu8RlSjKui3U9Rg
 VtwC/B4F+ZhnmVUmU7ZOHnQOsFtTeWICVFLFMZoxueCh8s3+UKOO8hH+8lg6c4Ea6QNs
 bKhQ==
X-Gm-Message-State: AFuF++m42zxQgxQBgFTbyUeGB9Rurbe/OakVPLjjFFGSVazblh0LNFA4
 KPvdo8JKLofv1h67ZXiyC6+p76ET1LhjGaug/HQ6ggDR2qd8cxw0ie1FJkcwsV8m+soImqu44+0
 lQ5N29J4Ph1OnjJfifxtLuP1FGzAnu3KO7QHgA4TQcAPBViS3rJc++/NqDLs77vZl9khk
X-Gm-Gg: AYBFou02TuUJO4cvbCDtArXvbxvcIcmlFmSPser6qAdH+AjreWTbNVARO4bU5HemNXH
 wRHlp1SYM/Jr5+/r4oTS9j+89iMPilSPqzPzOHRBjuuU+6BwIkLsYVuHiMVJuN6xNhA8PaEGpFA
 QLOhXQNPChzFQJttHKRG0UGHEG03AMtwAT+eydiKwCOxSXczRMJYPxygv5nTB5CS4cntLfQxWfT
 SY3uYWrCN7HH9TM1Vlg8YjDycPjOp5w+zwnmPJ49QVThBUkkvhjcuuFFY3NIIOn+Mfod0iwZO+0
 NIDY3n3K/ZyG2Pi1f3VhhUnTuAEkaOXngco+sh9HtFp9mgiRQz28n3ZeqwBrHeNE9barNLobGiB
 rwUktTXDhCkLu0qjPG2aQ
X-Received: by 2002:a05:651c:a209:20b0:3a3:7680:67fc with SMTP id
 38308e7fff4ca-3a63c2ffcbemr2308811fa.27.1790232839176; 
 Wed, 23 Sep 2026 23:53:59 -0700 (PDT)
X-Received: by 2002:a05:651c:a209:20b0:3a3:7680:67fc with SMTP id
 38308e7fff4ca-3a63c2ffcbemr2308741fa.27.1790232838723; 
 Wed, 23 Sep 2026 23:53:58 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bf57909sm4803141fa.29.2026.09.23.23.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:53:57 -0700 (PDT)
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
Subject: [PATCH v15 07/11] mm/hmm: add lazy MMU mode support for migration in
 HMM pagewalk
Date: Thu, 24 Sep 2026 09:53:09 +0300
Message-ID: <20260924065313.899730-8-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924065313.899730-1-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9qKh8LLE4v6dIzz1Z8n9ds6naCaLXFZ6hukWecEsvLA_1790232839
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
index ea77429c5178..9fdd945cc026 100644
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

