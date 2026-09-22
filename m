Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D376DC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA6210E3E1;
	Tue, 22 Sep 2026 05:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VZv8OKbp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3242210E608
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qu0BSxnttTs+uKLg/qx0GDVYgMyi2m2Up9fDq2tLMMQ=;
 b=VZv8OKbpcf/tSWFr73LbODQ3xsX+pNIXLgBqh3ISkQzwqalw9VqTuO4N9JmQuU9k9WM/so
 fcuwhISSzSLFE9G5SPJgFD+C4dsBp8NjNmwdx/FDd3Ix34QLrL96TB7nlkuHSplI41svmo
 eMnlnerIqilVxgR3Dc/EzHfLGyapHsI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-cHiXqwoKNQi5VT7JNpjgag-1; Tue, 22 Sep 2026 01:34:55 -0400
X-MC-Unique: cHiXqwoKNQi5VT7JNpjgag-1
X-Mimecast-MFC-AGG-ID: cHiXqwoKNQi5VT7JNpjgag_1790055294
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b767214d60so283474e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055294; x=1790660094;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qu0BSxnttTs+uKLg/qx0GDVYgMyi2m2Up9fDq2tLMMQ=;
 b=rXJmn+R/p4+CbLJu1hU97wz2bM2r6fUbkCg+RXguhkx+le9GrJQNjJvOwL0JCg8VB4
 6b7wvZiDQ3D78AnqyRgNw7qqvawzDpwY0LYLAE3Bcu2d/9n2w5H8YZ3iL/IW2AmqO1Ye
 ly2kFqUievcXCCmNdqOMWV8o63qAYFsm3h6XabdrkFlBkIOqV/AR8ZtS4zX+jDjpC0HA
 OYMxmLNfmVjhOCi4tJt/ytEmvWJwMtjOApfsZC9/1c0hVnm6YI72RPEhPxayhQWBhEUL
 VlOHYMeVUPqyvwiM45UZZDXnf1HCFnOcHy+g7EYSBNAmkTxVU0RM5aEjP/qgp+lyr6gO
 0wSw==
X-Gm-Message-State: AFuF++mjCstoQZkh56UMiwqug0guejShT9lUMU4S4j6ZvFd2NC+oA988
 NhzqWbpH9o6zp8TcypBvNfmyIXPwtkklwCi8h+1jtqGMaYLDmDKV7m5WRBPIMdPtsHDRF6dSnUH
 G3i8tcl7oPxHRybdr1tB3tOV/hOfyevsLvJjvGMRrt/UBp8/26GkxStGO349Tm3ipfl1Y
X-Gm-Gg: AYBFou3tJYLQNAs0U99RSEp6q+qid8R6YtbewoNpPD9PZTFb9fGviI6xw36wmsmNL9/
 tttPOD2hUq6CVa1SzJRMSh6Aak9oEdzR3QUz5IPTOo4Uy3zlvLn7SITRwce3gHEqVqmJ61y+YAH
 UHG/c7aG8sQNVgxynJI95qqwUgenfYM5VPdk4c+N/bRA0LnKWwHBaYERKK2HolP04/6eHLR+cJK
 zzWCJ4kxrWwikX2E8fJzzTi5D1U+SiXuVIVmJg930moR00PpASPdvff55rwEb6rTmN/8+g2QqQA
 ZOIXIH/XyLwuOfH3ll2wqFiVdFw7iX7pqxwDeF+4NPIJNCQzUG2Zuii2OG9OGhutH0BWpMiFXRc
 QkuX8bpODzbuTqFKJ03Xa
X-Received: by 2002:a05:6512:aca:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b8d28fbc51mr474019e87.17.1790055294089; 
 Mon, 21 Sep 2026 22:34:54 -0700 (PDT)
X-Received: by 2002:a05:6512:aca:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b8d28fbc51mr474009e87.17.1790055293609; 
 Mon, 21 Sep 2026 22:34:53 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:34:52 -0700 (PDT)
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
Subject: [PATCH v14 05/12] mm/hmm: implement folio split for migrate needs in
 HMM pagewalk
Date: Tue, 22 Sep 2026 08:34:14 +0300
Message-ID: <20260922053421.4092027-6-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ZloaFY1Oax5OxsRPXLK-A2F-O1xSmS5ViBg-yjYENc_1790055294
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
index 4805c88347e6..e6469ef4ae6a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -514,10 +514,51 @@ static int hmm_vma_walk_split(pmd_t *pmdp,
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

