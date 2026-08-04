Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905CC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5FD10E84A;
	Tue,  4 Aug 2026 04:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cztJJ0w1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6177110E83E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785817638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWLoSmzvlWrra6TV4DFt42DXFKEy+9KqLNEl12wX4Kg=;
 b=cztJJ0w1E4a7hk5M7vS691cGwYcuRCXYLZ5QEAUqVjzOMB742mDez/SXHas5sb9yeXw2JP
 FKUmAri1shp9BEcmLrey+mU1dKIrSbXzr1iGBhftBfjv6Dkgiuqh3n+8osrfTIlSLSKUvW
 xAYKTZxrztHs5m+Dm+AhRnGuX25rjM4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-K1KEZf8bMFyTdKD7vOAe-w-1; Tue, 04 Aug 2026 00:27:15 -0400
X-MC-Unique: K1KEZf8bMFyTdKD7vOAe-w-1
X-Mimecast-MFC-AGG-ID: K1KEZf8bMFyTdKD7vOAe-w_1785817633
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b01dc8a5bbso302653e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 21:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785817633; x=1786422433;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NWLoSmzvlWrra6TV4DFt42DXFKEy+9KqLNEl12wX4Kg=;
 b=ncdbplcEFMZja57XA7oc6SeCMwAf2SLGmoEnnpDGpPlwzxu3WvcS4ZK8zKOuj/JVkG
 GumcF7DjoJt1nKE+uAMJq4SigbS4TpHho7LK5TwVcmCWlEQ1FY0OMOM91Okc7nBBNVC0
 dbj9HYghynYkKYrr22ZmvqoARfpp9L+Pb2bmOru65JMroAbqnqssvTkdy5hg8K5J8FUB
 yNv3P7fPaCBbylzNYquD5GOHgWCNqYWql2VkDbQKnSgC5+e5IXs9xdLnHVgrm+Va1A56
 IWlMFxT3HURs6CMgiNlOD/KpbpvgsdzU43UhoXpYXXprHNPgorEHTK2e0s24kLuCJTMF
 hhbg==
X-Gm-Message-State: AOJu0YxyijRY669hOMwqf6YtTPfUkjxr5URfZbpG9AN7B1bval5gfz7x
 2b6C4H/7u5oluwY5vv+pj6gVXpPUrLc2KQShbbMZaKW1JoX6Dm4MMu8eBkweEvtwPlC/DLw8BgT
 m3In6/s7sPGyiwFZfcV21YuyBlPhDuL94DHE4B4qVYvE5sZ91Fj9P3J8GxfJtXoMATKJw
X-Gm-Gg: AR+sD12XiG7AvdXN2DfpbYzQkmLoOE8520v4lndWaSaoR/bteT1xn9ZxNQlzAVHDEdA
 qJvK+teYpRGZfIAflhGcnlPnq3NrqodrQO3Z+YcUz0dyo+qXrSx6/1TPOQSrzkoAI0dDRMtolEz
 Q7vg0md6K9Zu7z/Pfzsx6fy8icwY5O5WPqpI//YGbkRlOn1KST15hSwOPFfyU2MHWmjXPVzpDRK
 /TsMGAdjcCL+qubT3Bo2TcDRc3QFquERgq89auxnQkFgKBpwH3VqOfVh2q5+5O+rgvsE3lxFGTt
 ReWFipOWNIFOtJ39pbjrHPYH5uNfUHKOflF2PVVvkrrJX1KYJduE54Cw9YJBXofC5Ff1lnWUfal
 yVe4Kv94ADEpTCGri
X-Received: by 2002:a05:6512:6ca:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b2ee622c99mr384784e87.17.1785817633350; 
 Mon, 03 Aug 2026 21:27:13 -0700 (PDT)
X-Received: by 2002:a05:6512:6ca:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b2ee622c99mr384770e87.17.1785817632836; 
 Mon, 03 Aug 2026 21:27:12 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e23c46c4sm2311351e87.17.2026.08.03.21.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 21:27:10 -0700 (PDT)
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
Subject: [PATCH v13 05/11] mm/hmm: implement folio split for migrate needs in
 HMM pagewalk
Date: Tue,  4 Aug 2026 07:26:25 +0300
Message-ID: <20260804042631.2175585-6-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804042631.2175585-1-mpenttil@redhat.com>
References: <20260804042631.2175585-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IGaUomM0Fpa_dX93EWzAQpadaod6WkrBQuLaKJfUsyE_1785817633
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

Implement the helper to split PMD size folios during pagewalk.
Splitting is needed if the start and end addresses are
not PMD aligned, or setting up pmd migration entry fails.

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
 mm/hmm.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 75e19be6ef76..3621d1df51d3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -511,10 +511,51 @@ static int hmm_vma_walk_split(pmd_t *pmdp,
 			      unsigned long addr,
 			      struct mm_walk *walk)
 {
-	// TODO : implement split
-	return 0;
-}
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct migrate_vma *migrate = range->migrate;
+	struct folio *folio, *fault_folio;
+	spinlock_t *ptl;
+	int ret = 0;
+
+	HMM_ASSERT_UNLOCKED(hmm_vma_walk);
+
+	fault_folio = (migrate && migrate->fault_page) ?
+		page_folio(migrate->fault_page) : NULL;
+
+	ptl = pmd_lock(walk->mm, pmdp);
+	if (unlikely(!pmd_trans_huge(*pmdp))) {
+		spin_unlock(ptl);
+		goto out;
+	}
 
+	folio = pmd_folio(*pmdp);
+	if (is_huge_zero_folio(folio)) {
+		spin_unlock(ptl);
+		split_huge_pmd(walk->vma, pmdp, addr);
+	} else {
+		folio_get(folio);
+		spin_unlock(ptl);
+
+		if (folio != fault_folio) {
+			if (unlikely(!folio_trylock(folio))) {
+				folio_put(folio);
+				ret = -EBUSY;
+				goto out;
+			}
+		}  else {
+			folio_put(folio);
+		}
+
+		ret = split_folio(folio);
+		if (fault_folio != folio) {
+			folio_unlock(folio);
+			folio_put(folio);
+		}
+	}
+out:
+	return ret;
+}
 #else
 static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 					      pmd_t *pmdp,
-- 
2.55.0

