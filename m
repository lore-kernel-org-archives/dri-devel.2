Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2951606D805
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LcAwLQJS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F5810E3E3;
	Tue,  3 Nov 2026 06:17:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238C310E78A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4p39RZoowMOxt9+KNmCTQhPcx47symeLsQa59zTEfM=;
 b=LcAwLQJSeHNr2Qr0E3jZ4/iQOUT1jM3PLbYge2MxtGbFPuYoIgmp5HxvDvFPs1w6YT0EUs
 zp5JS5cwuh5dj67caCLyGvIQmVjw6R57mAp0yGrOGCDpg1nAtAninc3NPc5k4Kp00Gjdjg
 UdGGPoyfxnVNap5NKU4FfVgz2rkQeuI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-Ud38bMoQO9iuNVzSc2Wg1g-1; Tue, 03 Nov 2026 01:16:52 -0500
X-MC-Unique: Ud38bMoQO9iuNVzSc2Wg1g-1
X-Mimecast-MFC-AGG-ID: Ud38bMoQO9iuNVzSc2Wg1g_1793686611
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5be3e17e9ddso1448517e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686610; x=1794291410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v4p39RZoowMOxt9+KNmCTQhPcx47symeLsQa59zTEfM=;
 b=IQsa5P6sHOdbenr2eDEwwFtm6Pj4iA4nz8IMVVGT9CX5sien2dtBdkqLlYGPGuqM1L
 pFdslyOJT2WCV5mfyMoHbSR8e/tMYS1VQ81DkfLv9YFk3GKos5KZKXM7HX9+nwVYH+Pk
 ViqdgM5X2t8hiaYAh0gkZksdBDeqKjbYLHZsOKzTXDQtLYIpGhCqxNy2RTPlkuuH1Ur4
 Y5GCiHYQhgoas8VDfz+uuuqQlAMwXjqsT0qpiJnoSeMSb9nvYAodXI1L1xzMFZHrDGuC
 YwC0nGgmFMgWZLODj0GYzBAVZvLNToJfaPtCtHFHk377jBTYBC+NFFRhqt0dzgMGLdX2
 UFOg==
X-Gm-Message-State: APuU4Z9LTW4x4GPkjApqOzrhodU3Rp5cAdnkNjod4UfaxzckaJuNMHfa
 OC9PQLssL6m207Tw7UJHo313N8XtITCC+Z84AHI1fGhIb/FSQ3cz7qHqTtDFySaCX0MHcQzitDY
 Fjk/SmTLLsBKicMHQeNRM66nmys+B7iwm3As80q/g7Q+Qquc56Hu+e2EbCGbyrCpmhy/8
X-Gm-Gg: AYBFou12gakmo538LI7oFkMf36MXZEgKzEJsdX/o1ObiPIHFGi87z67nSwXbLQNc2e7
 TrlVtl6LabjK+q6jYSMgYYdpG2Z2bPn0SzpMrGmry/6JS7lJ5wgzQNZYIpjT1sT9wSqgcgiUEHH
 xt8Q924EJMfthJkMRCGym8tZkXAyMssIPeOp4bsVf+pKS5nNhulQ/qP7njDvntKxsGnC44w9cGL
 FDekS2UBlCBHSblQ6mnySZ1xtZorBZoudESTBkBV2ih3L7vPNDwAFV+5kF3daYnd6KM1c+fzQpy
 /BGF9peVXqshntjcHzhRkQ4ymvZFdzFu4q+ITfSFrQRn9/G8REDk9g5O2BrQMpJEjiYdcAmWBW5
 yycSt6aI0wj20DemKE4VFfgu77gnaWyh8k+4Z5gSwtKeU6iuNxkD3fH1OcHXrsjbLl9WTwg==
X-Received: by 2002:a05:6512:4607:b0:5bf:dc20:c3dc with SMTP id
 2adb3069b0e04-5bfdc30084cmr3195644e87.6.1793686610514; 
 Mon, 02 Nov 2026 22:16:50 -0800 (PST)
X-Received: by 2002:a05:6512:4607:b0:5bf:dc20:c3dc with SMTP id
 2adb3069b0e04-5bfdc30084cmr3195615e87.6.1793686610027; 
 Mon, 02 Nov 2026 22:16:50 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:16:49 -0800 (PST)
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
Subject: [PATCH v17 02/12] mm: add helper to convert HMM pfn to migrate pfn
Date: Tue,  3 Nov 2026 08:16:19 +0200
Message-ID: <20261103061629.972669-3-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2_tnnmxx6jA9pqH4HqLI8Xf4AAaz9B7M3h0fhMvepew_1793686611
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
 include/linux/hmm.h     | 29 +++++++++++++++++-----
 include/linux/migrate.h |  3 ++-
 mm/migrate_device.c     | 55 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 6f04e3932f5b..4f56f3419cb4 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -13,6 +13,8 @@
 
 struct mmu_interval_notifier;
 
+struct migrate_vma;
+
 /*
  * On output:
  * 0             - The page is faultable and a future call with 
@@ -27,13 +29,22 @@ struct mmu_interval_notifier;
  * HMM_PFN_P2PDMA_BUS - Bus mapped P2P transfer
  * HMM_PFN_DMA_MAPPED - Flag preserved on input-to-output transformation
  *                      to mark that page is already DMA mapped
+ * HMM_PFN_MIGRATE    - The entry is to be migrated. Note, HMM_PFN_MIGRATE
+ *                      alone without HMM_PFN_VALID denotes the
+ *                      empty page.
+ *                      This flag optionally together with HMM_PFN_COMPOUND
+ *                      are indicators for migrate_hmm_range_setup() to
+ *                      setup the migrate pfns.
+ * HMM_PFN_COMPOUND   - The entry represents a > 0 order page
  *
  * On input:
- * 0                 - Return the current state of the page, do not fault it.
- * HMM_PFN_REQ_FAULT - The output must have HMM_PFN_VALID or hmm_range_fault()
- *                     will fail
- * HMM_PFN_REQ_WRITE - The output must have HMM_PFN_WRITE or hmm_range_fault()
- *                     will fail. Must be combined with HMM_PFN_REQ_FAULT.
+ * 0                   - Return the current state of the page, do not fault it.
+ * HMM_PFN_REQ_FAULT   - The output must have HMM_PFN_VALID or hmm_range_fault()
+ *                       will fail
+ * HMM_PFN_REQ_WRITE   - The output must have HMM_PFN_WRITE or hmm_range_fault()
+ *                       will fail. Must be combined with HMM_PFN_REQ_FAULT.
+ * HMM_PFN_REQ_MIGRATE - For default_flags only, request to migrate the range,
+ *                       according to hmm_range.migrate.flags
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
index 78424b3824c2..280ec9a866c7 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -3,6 +3,7 @@
 #define _LINUX_MIGRATE_H
 
 #include <linux/mm.h>
+#include <linux/hmm.h>
 #include <linux/mempolicy.h>
 #include <linux/migrate_mode.h>
 #include <linux/hugetlb.h>
@@ -202,7 +203,7 @@ void migrate_device_pages(unsigned long *src_pfns, unsigned long *dst_pfns,
 			unsigned long npages);
 void migrate_device_finalize(unsigned long *src_pfns,
 			unsigned long *dst_pfns, unsigned long npages);
-
+void migrate_hmm_range_setup(struct hmm_range *range);
 #endif /* CONFIG_MIGRATION */
 
 #endif /* _LINUX_MIGRATE_H */
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c..ba6775a0d37e 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1530,3 +1530,58 @@ int migrate_device_coherent_folio(struct folio *folio)
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
+		if (pfn & HMM_PFN_VALID)
+			migrate->src[i] = migrate_pfn(page_to_pfn(hmm_pfn_to_page(pfn)));
+		else
+			migrate->src[i] = 0;
+
+		migrate->src[i] |= MIGRATE_PFN_MIGRATE;
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
2.55.0

