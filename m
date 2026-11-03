Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CD606A330
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrcDoUyZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 286EC10E783;
	Tue,  3 Nov 2026 06:17:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC5110E783
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gobpz7G2pF8eCW6Qy4GETlwPpa8+u249lV/gCTCXtkw=;
 b=KrcDoUyZTKVjWsOP+p8Ad1g628ecTyaZDeoPfCbljEgyZxPIRY6aIc+kkYe/eP8j5SUc4+
 Z7djp/Y5Ubw+IhKkG5mamCo2iKBjD8JYvzs7iuHTq+ScP6LA1BhCy8VL3ipjWc1srHhIpX
 g3f1/AxhhhIp20G/Fx85DdOotbbXa0o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-_O4KUAlNM8Su7d0TKyGo_g-1; Tue, 03 Nov 2026 01:17:11 -0500
X-MC-Unique: _O4KUAlNM8Su7d0TKyGo_g-1
X-Mimecast-MFC-AGG-ID: _O4KUAlNM8Su7d0TKyGo_g_1793686630
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bfe13ad5f4so1725128e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686630; x=1794291430;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gobpz7G2pF8eCW6Qy4GETlwPpa8+u249lV/gCTCXtkw=;
 b=Iuv59pGdLWV57XBp2RxMeieIM8Wj89sj8dQEs6l5fQabw/Mzy53HKcVyuRYMR4k2+y
 SiZtD6Ak4NO9dau1W/SExrKpuGpQqAt0UPL//tNWUwtdkm+F6EuIP/dctEQskgPPkk2d
 qBzxTlD+lcFy7nprTYx5NAHyUwdMjc+5W7AxHXjWzVQ2SLj4HFMlWPZ1ahQA9N7ZiDfH
 xz3NhIvNVE9uaxLBmrg70SsuMa/+bmJFDZ9KTBVXhqNu4xNOCWAHOnjoLgoVUVqNWjpQ
 ZehSgV+Ks3rWCu5CWPvo11m1Zf05ysgJVa2u3KD5me6v+0fvAeGLJIphf1mfuDpCbN6O
 9amg==
X-Gm-Message-State: APuU4Z9omtUwcHHinplW/qE/OZs/4JsTgqqXwh+6WQSIMxlFMkb9qK+F
 yt56hXJ+axy6gi2Oc/sBwY46VKrj8V8O7E7fpzcUQBo1IHQZWS04K0HzhwFuSN0I+oDzWlaCpkX
 b4fWGT0Dy2OnI7IFm/JoaUTbk5uddUTHnsjyi0tD5uUs/FS0iKh1TxqcZ78PmFvTu4bBw
X-Gm-Gg: AYBFou12chYKuwGNKDkqpJ4nY6UiwPNOAJgc1ecBWgc50KyyBKG1O4i0c4udYmAXS5v
 C2fz3ju102RbzOOP9ruwyKtWqLBdwHuU33KPwbC2gH5lOeW0UlLwpJWPm+VsWUOsgLIxjYBJeCG
 zVBG7Y7d/d4kAQY/TxeMHKZrE2oxcpr5IPTwsu7rEpoAG0AuQouRnr2cfffTnWz4w/RDQMPln+c
 UdZEx9XFdw0K8kne3mSxMJllrlIotpIWgHb3mZ53gyeP0fvRIOYS4LcmGY/v5rYP9kDoCAT4hvF
 bweRCQCE375n7pl1f2/014AurAqYd/5y/syI6cvwLvEg62yE9X/1bE/3Rm4rKJAZkeCByeYVUIj
 wJifbsMoa5A1V7d5DvvFbObgckbxqv3yp/GN3d4OKPBw45jLRUjdJfzKhesuQuyMXTiGToA==
X-Received: by 2002:a05:6512:3f13:b0:5be:5dfc:864f with SMTP id
 2adb3069b0e04-5bfd9599012mr3965232e87.50.1793686629690; 
 Mon, 02 Nov 2026 22:17:09 -0800 (PST)
X-Received: by 2002:a05:6512:3f13:b0:5be:5dfc:864f with SMTP id
 2adb3069b0e04-5bfd9599012mr3965125e87.50.1793686621536; 
 Mon, 02 Nov 2026 22:17:01 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:17:01 -0800 (PST)
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
Subject: [PATCH v17 07/12] mm/hmm: add lazy MMU mode support for migration in
 HMM pagewalk
Date: Tue,  3 Nov 2026 08:16:24 +0200
Message-ID: <20261103061629.972669-8-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c3b15OiVBT2v0h66UP9PuaxYokcdUlyYD7BCnPPz1dQ_1793686630
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
index cbde004fd778..690b73908f34 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -377,6 +377,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		/* Report error for everything else */
 
 		if (hmm_vma_walk->ptelocked) {
+			lazy_mmu_mode_disable();
 			pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 			hmm_vma_walk->ptelocked = false;
 		} else {
@@ -400,6 +401,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			if (hmm_vma_walk->ptelocked) {
+				lazy_mmu_mode_disable();
 				pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 				hmm_vma_walk->ptelocked = false;
 			} else {
@@ -419,6 +421,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 
 fault:
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
@@ -548,6 +551,7 @@ static int migrate_vma_split_folio(struct folio *folio,
 	if (folio != fault_folio)
 		folio_get(folio);
 
+	lazy_mmu_mode_disable();
 	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
 	hmm_vma_walk->ptelocked = false;
 
@@ -1159,8 +1163,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 
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
@@ -1205,6 +1211,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		flush_tlb_range(walk->vma, start, addr);
 
 	if (hmm_vma_walk->ptelocked) {
+		lazy_mmu_mode_disable();
 		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
 		hmm_vma_walk->ptelocked = false;
 	} else {
-- 
2.55.0

