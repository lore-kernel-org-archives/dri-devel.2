Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CDC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F319610E87A;
	Mon, 29 Jun 2026 12:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZPSzgbYB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280DA10E87F;
 Mon, 29 Jun 2026 12:25:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8947A60008;
 Mon, 29 Jun 2026 12:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701AB1F00A3A;
 Mon, 29 Jun 2026 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735904;
 bh=jCNlejeASmhB4AgyuEzIBYYbjpZ4n/egy8owgCzIJlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZPSzgbYBaZMkgFXpVO4lcjIhSYifNVCkFnCoukwkUexEpxFU1zMgEeJ1WzF0iQe8G
 nflqvEp2qQsUkNArN92n8VHhtGfhHn+6iUhiMxzzJJJ7SZXcRgEr1nCbY+/elRw+Ah
 zSnB7Azkiovus8+WkUKAjckexf8zlkyqxvryRskDyfAIp1bnaSD5ki+zg2uUN1KNn+
 7TTD7jzbKN7+khnHRVfJs1NOkm+rEq/0bN1OjRt/R8ER/L0u7tEvPT97eyxEJtymI1
 nWpqxrYVQsa8IYABDoMNC/4V+mXkdTfDEZ3SxdJqtpi4OpAP/MPlU26nLVy9Japjwe
 PNuQvpANXUgjw==
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
Subject: [PATCH 23/30] mm/vma: make vma_set_range() static,
 drop insert_vm_struct() decl
Date: Mon, 29 Jun 2026 13:23:34 +0100
Message-ID: <62efd70f9f39570724c9552cc7f2aeb5c322b2ff.1782735110.git.ljs@kernel.org>
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

With __install_special_mapping() moved to vma.c, vma_set_range() can be
made into a static function there and is now completely isolated from the
rest of mm.

While we're here, we can also remove the insert_vm_struct() declaration
from mm.h - the function is implemented in vma.c and already declared in
vma.h, and has no users outside of mm.

Also update the VMA userland tests to reflect this change.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mm.h         | 1 -
 mm/internal.h              | 9 ---------
 mm/vma.c                   | 8 ++++++++
 tools/testing/vma/shared.c | 9 ---------
 tools/testing/vma/shared.h | 5 -----
 5 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf2d42747064..868b2334bff3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4103,7 +4103,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *avc);
 
 /* mmap.c */
 extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
 				 unsigned long addr, bool write);
diff --git a/mm/internal.h b/mm/internal.h
index 89e5b7efe256..e127dfea9c0f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1720,15 +1720,6 @@ extern bool mirrored_kernelcore;
 bool memblock_has_mirror(void);
 void memblock_free_all(void);
 
-static __always_inline void vma_set_range(struct vm_area_struct *vma,
-					  unsigned long start, unsigned long end,
-					  pgoff_t pgoff)
-{
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-}
-
 static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 {
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index f4de706a2728..b16c5b20862f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -70,6 +70,14 @@ struct mmap_state {
 		.state = VMA_MERGE_START,				\
 	}
 
+static void vma_set_range(struct vm_area_struct *vma, unsigned long start,
+			  unsigned long end, pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
+
 /* Was this VMA ever forked from a parent, i.e. maybe contains CoW mappings? */
 static bool vma_is_fork_child(struct vm_area_struct *vma)
 {
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
index 2565a5aecb80..bea9ea6db02a 100644
--- a/tools/testing/vma/shared.c
+++ b/tools/testing/vma/shared.c
@@ -120,12 +120,3 @@ unsigned long rlimit(unsigned int limit)
 {
 	return (unsigned long)-1;
 }
-
-void vma_set_range(struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   pgoff_t pgoff)
-{
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-}
diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
index 8b9e3b11c3cb..ca4f1238f1c7 100644
--- a/tools/testing/vma/shared.h
+++ b/tools/testing/vma/shared.h
@@ -125,8 +125,3 @@ void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
 /* Provide a simple dummy VMA/anon_vma dummy setup for testing. */
 void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
 			    struct anon_vma_chain *avc);
-
-/* Helper function to specify a VMA's range. */
-void vma_set_range(struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   pgoff_t pgoff);
-- 
2.54.0

