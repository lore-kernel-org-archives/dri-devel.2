Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175A8C98304
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AAE10E5BA;
	Tue, 22 Sep 2026 05:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ccXPWX4u";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C0D10E3E1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Dwb+61ZiIhZrjnlVPFK1XZrDSM5l5u6qowPzm9WLF0=;
 b=ccXPWX4uvzF6Wa1aba6tsfuJuT0R0Yz+PeoDGBs9Yd3nMnEJWn5g9gXx8wtoK5pLaMzs8C
 IgidwsNpXmtHeNSh3iTId1THLd4OxgJyoL6vzyx0wQoQoUhXoZ/4t7Rny4shBfBWgX8U4l
 4JhrROQypMpzi4FqbG98+fN2Pq422jI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-xUQEWKRNOGyGPo7LWoTGyw-1; Tue, 22 Sep 2026 01:35:02 -0400
X-MC-Unique: xUQEWKRNOGyGPo7LWoTGyw-1
X-Mimecast-MFC-AGG-ID: xUQEWKRNOGyGPo7LWoTGyw_1790055300
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b4b009f0e7so2587743e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055300; x=1790660100;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Dwb+61ZiIhZrjnlVPFK1XZrDSM5l5u6qowPzm9WLF0=;
 b=ymCjBcQzMDKlh4ocy3sDOHbTBhv/knZitvY1woyvcEOmEztWgqcIDXWhAQd8oXAjf6
 P6vrThUvk4rmsK64W9G/398Cx0XPIeIGNpN/KaRsPeObI0k4iC/3x9+oBvZDXJQ6M+Sy
 96OcpgrIfarjyljswKuLMKeplP2MHPvRPCJOVkV7z2ZTUgEAF8s7u37nzA7CRYivW3fh
 xPfP8fHF1WVhJrqWIss5f8Uj3a8ulUh9xNQCH2gNnNq9Xkd8AmTqtqyaa/h+g7rt54iG
 dnLzd2DZa97h4QFzVU5NiOjg5bM7t4+p+HNpSn7+Lk9xUWyV7ciHF6lAfwJfcVkAFfVY
 whGA==
X-Gm-Message-State: AFuF++mwV6v5Ys2laTSr8G/Arg7uHUMy1oEQXEN1KVGlcZR3g3yGz1yU
 btTqy86QqHmU3HrTzTqR2dHjkmXm/7XfgdnEFn8ZyOL9YxP/nv4gAzBBGIQ+dpye86doqgRSj2O
 Ysv1wYZfGxAFvTfe2IwvXV6vA3GNh4KpJASuAIzeRrcVStFKJQNl1gmdUU4CQXS39oTO9
X-Gm-Gg: AYBFou37lMfJi2rDSQe9WiJkqLfi6Uvt6x8rvV6TMeiQRPhqdoh55TuVqa5LvxMiz1C
 T91ER1sBIAltW7/mE8G8DkCsWbevBrd6qvUpQD4iZ7PQqYkj+RvP1Nowh/yMIQl/usmtAESjpbt
 UmchgX/y0o58xLpzyMUVHF8OCjbOcrR85oEg5pfFlv36C7tJ4Jm20Vm7kukLy5S7CSBK4bFpKkq
 UZsNECzr9OC+j5kaXh1jbtA1XVgLVP8cbH4yM+G4Pzh1pXV3OzKJgPfl4hWa38SBA7lrIg86i3G
 vt8/zylmxCqK1R4MEePBVZpItykyB5FarnzkR/IwW4xm1PByjIATP3U8eSuEDD1eLxGDaJxA+3O
 xWg5UNDA7ecr5KMvwYhQ7
X-Received: by 2002:a05:6512:3a85:b0:5b6:186e:b79d with SMTP id
 2adb3069b0e04-5b8c194df51mr4033227e87.57.1790055300369; 
 Mon, 21 Sep 2026 22:35:00 -0700 (PDT)
X-Received: by 2002:a05:6512:3a85:b0:5b6:186e:b79d with SMTP id
 2adb3069b0e04-5b8c194df51mr4033212e87.57.1790055299969; 
 Mon, 21 Sep 2026 22:34:59 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:34:58 -0700 (PDT)
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
Subject: [PATCH v14 07/12] mm/hmm: migrate collection in HMM pagewalk - pmd
 level
Date: Tue, 22 Sep 2026 08:34:16 +0300
Message-ID: <20260922053421.4092027-8-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xw8xRIMEiNL5nNLI5ixmviRTDq9WN_pg4kQbWR6dXro_1790055300
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
index b3b79d13c797..a1459bd34c04 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -552,8 +552,100 @@ static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
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

