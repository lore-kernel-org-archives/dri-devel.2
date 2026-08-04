Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1137DC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F8810E851;
	Tue,  4 Aug 2026 04:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PMHqxnmn";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A44C10E6CC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785817647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+Wrj+fEG23grALcs/D4e+T/chcmptdybXX8nN5bDvk=;
 b=PMHqxnmnaO0GZqN1I1AClAeIrRPY4UU+2HTIex7bGHXrhpkVDJY/bzlyCMt01eIKeVmOPY
 I2sgDZA1L6YaSTTbWUAAYZ/XByPrBBP5FCQHsn4UZUqiOUYsDvm4A2wwLvJa61zsxsIHjJ
 q9XmkGRZ34lAnNgWxmz38pIcBcOrNl0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-x9bki93LNUC7cHsFTjCevA-1; Tue, 04 Aug 2026 00:27:26 -0400
X-MC-Unique: x9bki93LNUC7cHsFTjCevA-1
X-Mimecast-MFC-AGG-ID: x9bki93LNUC7cHsFTjCevA_1785817645
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39c82feaaa3so2176961fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 21:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785817644; x=1786422444;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p+Wrj+fEG23grALcs/D4e+T/chcmptdybXX8nN5bDvk=;
 b=mkoxksPDDw1F9XD30+3Fy3A6u+VoA6qJ1n57zmjUH/xV8EWrWMYCUkU/n0uQhUjA0o
 y7YRH4FVmfEhGlsXXtluuOBx6MMo/FfMSadpActlviq5/sRyB+Un+Vwq56wFja1Cyied
 pcktTYGpJh4gJqDl3BqarexMN0fYrPKQAE38trJtTh9oicUOaXVEySPAo6kW60uBU45M
 iYzWxqDk8MmI6ceNUT2M4qJ7EsS/yi4t06EXqvbRqhTHXQNP93BgIyfZ+np6CmPK1/EU
 7XnwGJFDl9M/KkoMHeaCI4wv2ZCG27cekE3Ojr4L7vG7vFuoQkDH6TDXdriPqkzV+Atn
 wBpA==
X-Gm-Message-State: AOJu0YwwrIG9PnRTfLJeNHX7JRNWBo5BVEYA7dYmPSRqOezzZ066SlZZ
 yzgkN97M64KpXylmnn4S81cDQCVFaHNIgRm5egPE22VVY6Tk2gZNJ9j309X2jmEzi4oUpyhMhpR
 51n57oxINtkvRM/oD61DODv91Ne/etk21Ga/7mc4r126eOt3yqIzkumSAQOjZGb8zoLe2
X-Gm-Gg: AR+sD12Cm5Foc9WBUBtM+/mDC8BZgo0dE2cekwI94A5JlUy1PnAE3Sp7SIsToVM/oJp
 xNdsq32tz6Bgwq8e02Kctp8cSOVjvrvWbOW28QpLfgqa7Dskg6COMZ/08RpTXk4++5fZ9lfecuZ
 gedjCUBJ0dAe5L97DviXLcTeqiPbSa4BzvHSPiemM/HYVsXfMgoVGpVEsZ5fIfFkCOkes/FOWbU
 Co0Z58f3HJOB62kd2C0gOhfxLW06ZduU/X8yc+0Z97hwSLxT3Zbp/my4yMhGNeZP9clll40t9x3
 Wru0Ztg1F7KJJ3+yjh9Y5sGfYotWs4Hg/lbX6vPEm0X7/b7W93b1dsVU4RlbNJoY2ZDF+4q5jcc
 v67f/fCMgoXZIzaUA
X-Received: by 2002:a05:6512:400a:b0:5b2:aa73:ea5c with SMTP id
 2adb3069b0e04-5b2f282e27cmr151462e87.20.1785817644601; 
 Mon, 03 Aug 2026 21:27:24 -0700 (PDT)
X-Received: by 2002:a05:6512:400a:b0:5b2:aa73:ea5c with SMTP id
 2adb3069b0e04-5b2f282e27cmr151455e87.20.1785817644120; 
 Mon, 03 Aug 2026 21:27:24 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e23c46c4sm2311351e87.17.2026.08.03.21.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 21:27:22 -0700 (PDT)
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
Subject: [PATCH v13 07/11] mm/hmm: migrate collection in HMM pagewalk - pmd
 level
Date: Tue,  4 Aug 2026 07:26:27 +0300
Message-ID: <20260804042631.2175585-8-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804042631.2175585-1-mpenttil@redhat.com>
References: <20260804042631.2175585-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RosFlGwQMdOjk-LmPnOd7abFYugbCIiXkZyMoxttUu4_1785817645
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

Implement the needed hmm_vma_handle_migrate_prepare_pmd() function
which is mostly carried over from migrate_device.c's
migrate_vma_collect_huge_pmd() function.

With HMM pagewalk based migration, the idea is that
hmm_vma_handle_*() are responsible for faulting,
and the pfn collecting part. hmm_vma_handle_migrate_prepare*()
do the migration decisions (with HMM_PFN_MIGRATE), possibly split
folios, and insert migration ptes/pmds.

HMM pagewalk based migration is enabled in later commit, for now
now hmm_select_migrate() returns 0.

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
 mm/hmm.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 2d902b8bcd58..61b9147fd8ed 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -549,8 +549,100 @@ static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 					      unsigned long end,
 					      unsigned long *hmm_pfn)
 {
-	// TODO: implement migration entry insertion
-	return 0;
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct migrate_vma *migrate = range->migrate;
+	struct folio *fault_folio = NULL;
+	enum migrate_vma_info minfo;
+	struct folio *folio;
+	unsigned long i;
+	int r = 0;
+
+	// Do we want to migrate at all?
+	minfo = hmm_select_migrate(range);
+	if (!minfo)
+		return r;
+
+	WARN_ON_ONCE(!migrate);
+	HMM_ASSERT_PMD_LOCKED(hmm_vma_walk, true);
+
+	fault_folio = migrate->fault_page ?
+		page_folio(migrate->fault_page) : NULL;
+
+	if (pmd_none(*pmdp))
+		return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
+
+	if (!(hmm_pfn[0] & HMM_PFN_VALID))
+		goto out;
+
+	if (pmd_trans_huge(*pmdp)) {
+		if (!(minfo & MIGRATE_VMA_SELECT_SYSTEM))
+			goto out;
+
+		folio = pmd_folio(*pmdp);
+		if (is_huge_zero_folio(folio))
+			return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
+
+	} else if (!pmd_present(*pmdp)) {
+		const softleaf_t entry = softleaf_from_pmd(*pmdp);
+
+		if (!softleaf_is_device_private(entry))
+			goto out;
+
+		if (!(minfo & MIGRATE_VMA_SELECT_DEVICE_PRIVATE))
+			goto out;
+
+		folio = softleaf_to_folio(entry);
+		if (folio->pgmap->owner != migrate->pgmap_owner)
+			goto out;
+	} else {
+		hmm_vma_walk->last = start;
+		return -EBUSY;
+	}
+
+	folio_get(folio);
+
+	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
+		folio_put(folio);
+		hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
+		return 0;
+	}
+
+	if (thp_migration_supported() &&
+	    (migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
+	    (IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
+	     IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
+		struct page_vma_mapped_walk pvmw = {
+			.ptl = hmm_vma_walk->ptl,
+			.address = start,
+			.pmd = pmdp,
+			.vma = walk->vma,
+		};
+
+		hmm_pfn[0] |= HMM_PFN_MIGRATE | HMM_PFN_COMPOUND;
+
+		r = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
+		if (r) {
+			hmm_pfn[0] &= ~(HMM_PFN_MIGRATE | HMM_PFN_COMPOUND);
+			r = -ENOENT;  // fallback
+			goto unlock_out;
+		}
+		for (i = 1, start += PAGE_SIZE; start < end; start += PAGE_SIZE, i++)
+			hmm_pfn[i] &= HMM_PFN_INOUT_FLAGS;
+
+	} else {
+		r = -ENOENT;  // fallback
+		goto unlock_out;
+	}
+
+out:
+	return r;
+
+unlock_out:
+	if (folio != fault_folio)
+		folio_unlock(folio);
+	folio_put(folio);
+	goto out;
 }
 
 /*
-- 
2.55.0

