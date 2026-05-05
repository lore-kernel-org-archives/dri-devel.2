Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E38CD343B
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 05:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0E810E936;
	Tue,  5 May 2026 05:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DuSY8ViO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4630910E92F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 05:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777958284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jjER583RBr0CQSaYsQDNT5myJivjc3r5S+eofqbfVjE=;
 b=DuSY8ViO16nvQd12ymKYRnag+O/uACxHqKWxTvdHQlUCSBCDy6VBL3KJafIMn3F/aHUXLd
 GD3vmRs/CSQqIgkdQjWy67t0L/HrFLBBfjD9YxGWEJazyZWwaXwvNs9IGfYx2QtwADADf7
 jn8vjbqz37uLS9XR7K+HeTheCsYcTYY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-rk7huvfLMDu-pOk_xSHujA-1; Tue, 05 May 2026 01:18:02 -0400
X-MC-Unique: rk7huvfLMDu-pOk_xSHujA-1
X-Mimecast-MFC-AGG-ID: rk7huvfLMDu-pOk_xSHujA_1777958281
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38e0ef48a2eso24417661fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 22:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777958281; x=1778563081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jjER583RBr0CQSaYsQDNT5myJivjc3r5S+eofqbfVjE=;
 b=bHS6f6EEaE5uGDsETDkq3o58EomvGDEt5VbaEOVOkc7OGlsayScCObzSlL19m7iSS/
 T9+9dWys72xQuKG0g9fjaADTLRmSqvCymGXh3ALAF1+42tk/SNIceOfRKnQwB2VQL6Gq
 7YYH7UjMxySd1EfYDxOgkDiFk+em5lkvqyuFpls9PE/nFCKUIQPcS5kNksGBgx9WQt9i
 Jsv94Q8O64LAGQXvBz8oPT2HpGVF8XKwMKXLq0LoLmIpfd+Svu/QF+ysnQAGuN7d4uGu
 zSFn4L0h8hzX1tFSAeRNx7JHK39RS4xeH9mTrLUm8wdUotTFNzh4tYZEHXP+KK+lTDD/
 FxMw==
X-Gm-Message-State: AOJu0Yx5bVWCAQbTUrj4Xn4RWvycMJ/5EjqCeU0KbFmzQq38/IeKKYEJ
 lXxqyzDgCFmXugwFD5Pqlh88I+HAiIPRTTi9amKjeTlCMcl8vgGLSxBe6xxYakvVYY6JWwR/mnL
 Km+TAW8vPtig3kW87bJIm8WyXo0t7leNUGcPyJkeR4LfwR1oCP92VCM33d68Vv5jP4uTy
X-Gm-Gg: AeBDiesQfQY7upRZGb8dA/W/nABqXsl28MoilldnIvDWuo4qFa84Jdm9WNzQUmnW5E9
 6rJ1gbkKZf/nO0qYAUd8PDBp/tovQbET8cUfFwNJ8z/gDkFgJFZdH5tkOiR8Gp4qVy06pWDF3kk
 5rnKZb04gFP+er/HDh8htwGjAckNryBZnbxW5kWCNXvFxdq6/M/S9p29Ltvn44C/yXUgjsLxbuQ
 77ac/Dewy1bl1VGmavTweNo+VSTBYVGiSrg++uGVll931bCDulDDzPBMdYv8gGYifzmI/O/9Rzl
 m40Z1CyiI76VqNMxwFEgAtHggD6pWigCNHYHPga8hQ9E+rTkgJbNTkfTYsQ5qFQx0kUZJTuiHQ7
 dXd6/CYKa9QK8o33U5o6Hnq2ZMOGf5JhZ+nmILD5NWGWNIIM=
X-Received: by 2002:a2e:a60b:0:b0:393:856d:168d with SMTP id
 38308e7fff4ca-393856d4ad6mr31366661fa.26.1777958281043; 
 Mon, 04 May 2026 22:18:01 -0700 (PDT)
X-Received: by 2002:a2e:a60b:0:b0:393:856d:168d with SMTP id
 38308e7fff4ca-393856d4ad6mr31366521fa.26.1777958280487; 
 Mon, 04 May 2026 22:18:00 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3936138935fsm37206141fa.41.2026.05.04.22.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 22:18:00 -0700 (PDT)
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v9 2/5] mm: Add helper to convert HMM pfn to migrate pfn
Date: Tue,  5 May 2026 08:16:55 +0300
Message-ID: <20260505051658.2219537-3-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260505051658.2219537-1-mpenttil@redhat.com>
References: <20260505051658.2219537-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QtgroR2g_wPmZzi634epLXh29AX4QS6biVrY0TMlc1U_1777958281
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

The unified HMM/migrate_device pagewalk does the "collecting"
on the HMM side, so we need a helper to transfer pfns to the
migrate_vma world.

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
 include/linux/hmm.h     | 19 +++++++++++++-
 include/linux/migrate.h |  3 ++-
 mm/migrate_device.c     | 55 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index db75ffc949a7..bfedafc1c143 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -13,6 +13,8 @@
 
 struct mmu_interval_notifier;
 
+struct migrate_vma;
+
 /*
  * On output:
  * 0             - The page is faultable and a future call with 
@@ -27,6 +29,13 @@ struct mmu_interval_notifier;
  * HMM_PFN_P2PDMA_BUS - Bus mapped P2P transfer
  * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
  *                      to mark that page is already DMA mapped
+ * HMM_PFN_MIGRATE    - The entry is to be migrated. Note, HMM_PFN_MIGRATE
+ *                      alone without HMM_PFN_VALID denotes the
+ *                      empty page.
+ *                      This flag together with HMM_PFN_COMPOUND are
+ *                      indicators for migrate_hmm_range_setup() to
+ *                      setup the migrate pfns.
+ * HMM_PFN_COMPOUND   - The entry is represents a > 0 order page
  *
  * On input:
  * 0                 - Return the current state of the page, do not fault it.
@@ -34,6 +43,8 @@ struct mmu_interval_notifier;
  *                     will fail
  * HMM_PFN_REQ_WRITE - The output must have HMM_PFN_WRITE or hmm_range_fault()
  *                     will fail. Must be combined with HMM_PFN_REQ_FAULT.
+ * HMM_PFN_REQ_MIGRATE - For default_flags, request to migrate, according to
+ *                       hmm_range.migrate.flags
  */
 enum hmm_pfn_flags {
 	/* Output fields and flags */
@@ -48,11 +59,15 @@ enum hmm_pfn_flags {
 	HMM_PFN_P2PDMA     = 1UL << (BITS_PER_LONG - 5),
 	HMM_PFN_P2PDMA_BUS = 1UL << (BITS_PER_LONG - 6),
 
-	HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 11),
+	/* Migrate request */
+	HMM_PFN_MIGRATE    = 1UL << (BITS_PER_LONG - 7),
+	HMM_PFN_COMPOUND   = 1UL << (BITS_PER_LONG - 8),
+	HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 13),
 
 	/* Input flags */
 	HMM_PFN_REQ_FAULT = HMM_PFN_VALID,
 	HMM_PFN_REQ_WRITE = HMM_PFN_WRITE,
+	HMM_PFN_REQ_MIGRATE = HMM_PFN_MIGRATE,
 
 	HMM_PFN_FLAGS = ~((1UL << HMM_PFN_ORDER_SHIFT) - 1),
 };
@@ -107,6 +122,7 @@ static inline unsigned int hmm_pfn_to_map_order(unsigned long hmm_pfn)
  * @default_flags: default flags for the range (write, read, ... see hmm doc)
  * @pfn_flags_mask: allows to mask pfn flags so that only default_flags matter
  * @dev_private_owner: owner of device private pages
+ * @migrate: structure for migrating a range of a VMA
  */
 struct hmm_range {
 	struct mmu_interval_notifier *notifier;
@@ -117,6 +133,7 @@ struct hmm_range {
 	unsigned long		default_flags;
 	unsigned long		pfn_flags_mask;
 	void			*dev_private_owner;
+	struct migrate_vma      *migrate;
 };
 
 /*
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index d5af2b7f577b..425ab5242da0 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -3,6 +3,7 @@
 #define _LINUX_MIGRATE_H
 
 #include <linux/mm.h>
+#include <linux/hmm.h>
 #include <linux/mempolicy.h>
 #include <linux/migrate_mode.h>
 #include <linux/hugetlb.h>
@@ -200,7 +201,7 @@ void migrate_device_pages(unsigned long *src_pfns, unsigned long *dst_pfns,
 			unsigned long npages);
 void migrate_device_finalize(unsigned long *src_pfns,
 			unsigned long *dst_pfns, unsigned long npages);
-
+void migrate_hmm_range_setup(struct hmm_range *range);
 #endif /* CONFIG_MIGRATION */
 
 #endif /* _LINUX_MIGRATE_H */
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index fbfe5715f635..3287053af00a 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1487,3 +1487,58 @@ int migrate_device_coherent_folio(struct folio *folio)
 		return 0;
 	return -EBUSY;
 }
+
+/**
+ * migrate_hmm_range_setup() - prepare to migrate a range of memory
+ * @range: contains pointer to struct migrate_vma to be set up.
+ *
+ * When collecting has been done with hmm_range_fault(), this
+ * should be called next, and completes range->migrate by
+ * populating migrate->src[] and migrate->dst[]
+ * using range->hmm_pfns[].
+ * Also, migrate->cpages and migrate->npages get initialized.
+ * After migrate_hmm_range_setup(), range->migrate is good
+ * for the rest of the migrate_vma_* flow.
+ */
+void migrate_hmm_range_setup(struct hmm_range *range)
+{
+	struct migrate_vma *migrate = range->migrate;
+
+	if (!migrate)
+		return;
+
+	migrate->npages = (migrate->end - migrate->start) >> PAGE_SHIFT;
+	migrate->cpages = 0;
+
+	for (unsigned long i = 0; i < migrate->npages; i++) {
+		unsigned long pfn = range->hmm_pfns[i];
+
+		/*
+		 * We are only interested in entries to be
+		 * migrated.
+		 */
+		if (!(pfn & HMM_PFN_MIGRATE)) {
+			migrate->src[i] = 0;
+			migrate->dst[i] = 0;
+			continue;
+		}
+
+		migrate->cpages++;
+
+		/* HMM_PFN_MIGRATE without HMM_PFN_VALID denotes the special zero page */
+		if (pfn & (HMM_PFN_VALID))
+			migrate->src[i] = migrate_pfn(page_to_pfn(hmm_pfn_to_page(pfn)))
+				| MIGRATE_PFN_MIGRATE;
+		else
+			migrate->src[i] = MIGRATE_PFN_MIGRATE;
+
+		migrate->src[i] |= (pfn & HMM_PFN_WRITE) ? MIGRATE_PFN_WRITE : 0;
+		migrate->src[i] |= (pfn & HMM_PFN_COMPOUND) ? MIGRATE_PFN_COMPOUND : 0;
+		migrate->dst[i] = 0;
+	}
+
+	if (migrate->cpages)
+		migrate_vma_unmap(migrate);
+
+}
+EXPORT_SYMBOL(migrate_hmm_range_setup);
-- 
2.50.0

