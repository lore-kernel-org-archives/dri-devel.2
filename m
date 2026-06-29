Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4822C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B1A10E86F;
	Mon, 29 Jun 2026 12:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fd5BiYHC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE3F10E855;
 Mon, 29 Jun 2026 12:24:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1C6340472;
 Mon, 29 Jun 2026 12:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04E21F00A3A;
 Mon, 29 Jun 2026 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735868;
 bh=UswI5k7//YYDNP6iqjwarg/8WzpO9KqTZGGmEfuQG6Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fd5BiYHCPq/cwl+1+Rym0zfeZhvt61/icQWdqyx7O0AgVHpX6rG7cRfvIWQKJYLiy
 6qErxgde5LANsPwbWxQoFLWzItFL9+/3MgT4q4aG2pjB1QIVFnAvC5VhQLo6Z1U9Ff
 cc1fXpbP4ACrxn1/Y4WBFmBQ1Mvhev+NrKZtKhk10lAwVJptuB3wr9hYkm8H6kxCpu
 gWT/GhcgdmXEEsEuiz9+zSpVwvyGPWRp1cpftuT7zyqj9Z6Lk0gCr84K0B/UCYxI+2
 tcuhWfHHHHH4pZkRP6WPoUXVG1TO9EqruwVnGgaVU1IA0okQFLDNaBh/6Z5PQIPUiD
 0CfKR+Z6RNVMw==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Kees Cook <kees@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-sgx@vger.kernel.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: [PATCH 11/30] mm/vma: introduce and use vmg_pages(), vmg_[start,
 end]_pgoff()
Date: Mon, 29 Jun 2026 13:23:22 +0100
Message-ID: <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
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

In the VMA logic we often need to determine the number of pages in the
specified merge range, as well as the start and end page offsets of that
range.

Introduce and use helpers for these purposes.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/vma.c                        | 11 ++++-------
 mm/vma.h                        | 17 +++++++++++++++++
 tools/testing/vma/include/dup.h | 10 ++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 2be0dbd7bb7b..b60375c6c5c3 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -197,11 +197,9 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  */
 static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 {
-	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
-
 	if (is_mergeable_vma(vmg, /* merge_next = */ true) &&
 	    is_mergeable_anon_vma(vmg, /* merge_next = */ true)) {
-		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
+		if (vmg_end_pgoff(vmg) == vma_start_pgoff(vmg->next))
 			return true;
 	}
 
@@ -221,7 +219,7 @@ static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
 	if (is_mergeable_vma(vmg, /* merge_next = */ false) &&
 	    is_mergeable_anon_vma(vmg, /* merge_next = */ false)) {
-		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
+		if (vma_end_pgoff(vmg->prev) == vmg_start_pgoff(vmg))
 			return true;
 	}
 	return false;
@@ -759,7 +757,7 @@ static int commit_merge(struct vma_merge_struct *vmg)
 	 */
 	vma_adjust_trans_huge(vma, vmg->start, vmg->end,
 			      vmg->__adjust_middle_start ? vmg->middle : NULL);
-	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
+	vma_set_range(vma, vmg->start, vmg->end, vmg_start_pgoff(vmg));
 	vmg_adjust_set_range(vmg);
 	vma_iter_store_overwrite(vmg->vmi, vmg->target);
 
@@ -962,8 +960,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		 *    middle     next
 		 * shrink/delete extend
 		 */
-
-		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+		const pgoff_t pglen = vmg_pages(vmg);
 
 		VM_WARN_ON_VMG(!merge_right, vmg);
 		/* If we are offset into a VMA, then prev must be middle. */
diff --git a/mm/vma.h b/mm/vma.h
index 8e4b61a7304c..527716c8739d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -230,6 +230,23 @@ static inline bool vmg_nomem(struct vma_merge_struct *vmg)
 	return vmg->state == VMA_MERGE_ERROR_NOMEM;
 }
 
+static inline pgoff_t vmg_start_pgoff(const struct vma_merge_struct *vmg)
+{
+	return vmg->pgoff;
+}
+
+static inline pgoff_t vmg_pages(const struct vma_merge_struct *vmg)
+{
+	const unsigned long size = vmg->end - vmg->start;
+
+	return size >> PAGE_SHIFT;
+}
+
+static inline pgoff_t vmg_end_pgoff(const struct vma_merge_struct *vmg)
+{
+	return vmg_start_pgoff(vmg) + vmg_pages(vmg);
+}
+
 /* Assumes addr >= vma->vm_start. */
 static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 				       unsigned long addr)
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index bf26b3f48d3a..535747d7fee4 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1301,6 +1301,16 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+static inline pgoff_t vma_start_pgoff(const struct vm_area_struct *vma)
+{
+	return vma->vm_pgoff;
+}
+
+static inline pgoff_t vma_end_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_pgoff(vma) + vma_pages(vma);
+}
+
 static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
 	return file->f_op->mmap_prepare(desc);
-- 
2.54.0

