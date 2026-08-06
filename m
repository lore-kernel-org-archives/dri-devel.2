Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD881C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328D610E398;
	Thu,  6 Aug 2026 20:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UcyLgppJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A8010E398;
 Thu,  6 Aug 2026 20:23:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDC8641A5F;
 Thu,  6 Aug 2026 20:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867231F00A3A;
 Thu,  6 Aug 2026 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786047792;
 bh=Dt36wRLymxRrIfWXpRPIqrPCDm+fFgCjzU1nKukhsXA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UcyLgppJvmOk1gAPp9vuuiCf6zIP9M82q/hU1r2AjcZWCGFyyhKTEXkQXe0owHBtG
 4p8OWMOPjQDkFUfSIJfMi0p4E0ewtDiX4gAGD417dxoA+UvVxeRM8yeNzdNB1Xw0jr
 iN4rV+dqhar2ncC1LBMh5HjTvXvCQAcJAe93Ne4OcL13S4OcUg2YgMzr7H2k0tmchl
 57U/RgrQRBqY83ZwoONnzJHfcZ1meHUQGlVWRNidXgnyzOwJwH1jQ3rPkeY1SQLDIf
 V5ncsDKBh7brcFZN/QHsT6bQ7A//i292YZpUwgsyY7OezAgE4RKB8OkCRvGdnHatkF
 tt3t8TH8Wa8Kg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:28 +0100
Subject: [PATCH v4 03/20] mm: introduce linear_anon_page_index()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5143; i=ljs@kernel.org;
 h=from:subject:message-id; bh=0osG5+4gGXbzb2uNb/Bi6pWK7THgxYoP0n4wymDnQXc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3pzfVJinXbJJy/nNQz53BgNrRh5Xa0VBh62eG1ReH
 6/zKSvuKGVhEONikBVTZHn+RXx/kEjYvM4L/m4wc1iZQIYwcHEKwERMzRn+Wb9/fIExmfVShC77
 Xv0U34SPQRGpZZ2T2O7t+lC/UHF6P8P/aPc1J6025vz/2lAxZVvO3Y0Ne/nv/zG4q6cZKtB/pqa
 AAwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
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

This function provides the anonymous equivalent of linear_page_index(),
instead offsetting based on the anonymous page offset of the VMA.

It is valid only for anonymous or MAP_PRIVATE file-backed mappings, in
other words CoW mappings.

For pure anon VMAs, this will be equal to linear_page_index().

Assert that both of these invariants are true In linear_anon_page_index()
and implement the algorithm in __linear_anon_page_index().

Note that MAP_PRIVATE-/dev/zero mappings will satisfy vma_is_anonymous()
but not fulfill this invariant, so when asserting this we check
vma->vm_file to account for this.

We do not update callsites yet, so no functional change intended.

Also const-ify vma_is_anonymous() to make it compatible with the
const-ified linear_anon_page_index().

While we're here, update linear_page_index() to be more succinct.

VMA userland tests are also updated accordingly.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              |  2 +-
 include/linux/pagemap.h         | 40 +++++++++++++++++++++++++++++++++++++---
 tools/testing/vma/include/dup.h | 25 ++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a3368c542947..da36a6cc907c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1556,7 +1556,7 @@ static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
 	desc->vm_ops = NULL;
 }
 
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
 }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c6fc783aaee5..0adfa6605653 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1094,10 +1094,44 @@ static inline pgoff_t linear_page_delta(const struct vm_area_struct *vma,
 static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
 					const unsigned long address)
 {
-	pgoff_t pgoff;
+	return linear_page_delta(vma, address) + vma_start_pgoff(vma);
+}
+
+static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
+		const unsigned long address)
+{
+	return linear_page_delta(vma, address) + vma_start_anon_pgoff(vma);
+}
+
+/**
+ * linear_anon_page_index() - Determine the absolute anonymous page offset of
+ * @address within @vma.
+ * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address resides.
+ * @address: The address whose absolute page offset is required.
+ *
+ * This returns the anonymous page offset of @address, which is the page offset
+ * the address possessed at the time the VMA was first faulted.
+ *
+ * For anonymous mappings, this returns the same value as linear_page_index().
+ *
+ * For MAP_PRIVATE file-backed mappings, this returns the anonymous page offset
+ * of @address, which is the page offset the address possessed at the time the
+ * VMA was first faulted.
+ *
+ * It is not valid to call this function for shared file-backed mappings.
+ *
+ * Returns: The absolute anonymous page offset of @address within @vma.
+ */
+static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
+		const unsigned long address)
+{
+	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
+
+	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
+	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
+	if (vma_is_anonymous(vma) && !vma->vm_file)
+		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
-	pgoff = linear_page_delta(vma, address);
-	pgoff += vma_start_pgoff(vma);
 	return pgoff;
 }
 
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 40ad83936b28..4c58487b764e 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1428,7 +1428,7 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
 	mas_set(&vmi->mas, addr);
 }
 
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
 }
@@ -1621,3 +1621,26 @@ static inline pgprot_t vma_get_page_prot(const struct vm_area_struct *vma)
 {
 	return vma_flags_to_page_prot(vma->flags);
 }
+
+static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
+					       const unsigned long address)
+{
+	pgoff_t pgoff;
+
+	pgoff = linear_page_delta(vma, address);
+	pgoff += vma_start_anon_pgoff(vma);
+	return pgoff;
+}
+
+static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
+		const unsigned long address)
+{
+	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
+
+	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
+	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
+	if (vma_is_anonymous(vma) && !vma->vm_file)
+		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
+
+	return pgoff;
+}

-- 
2.55.0

