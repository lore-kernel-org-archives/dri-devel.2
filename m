Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D12AC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA4610E866;
	Mon, 29 Jun 2026 12:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U/U1oudd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F4D10E866;
 Mon, 29 Jun 2026 12:24:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFAB243A39;
 Mon, 29 Jun 2026 12:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C2B1F00A3D;
 Mon, 29 Jun 2026 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735850;
 bh=zVjmXpiPRDEuxz5eG83icMPmdk9wIBZlf3SL8DGVmHo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U/U1oudd2OHsamjeEZuCvVMXdEMpD/oNczijfmJk++UuSM0tp0M4bDoBkBnaZgEGX
 Rzmf5lgUCLOwf33ifMK/K2bot41pBldLuGDyqh4AHtCcQbq63vAXxJLsQhScbx1wjy
 pAmJsMiKpOZTiLamQJyBK0RuwzcIABdz8kvfm7lfq8NBus/l7rZHyqG7zzwotne8Nc
 GTXNJ+fbsxLNNKwRHR60RMPCFuyleSFo52WnA+wKgJklYu/E8UISfAtIT/7g6bzNml
 Dn0Xje1cMb8CoXoDrIYucp5qfkxy+YeGy+zN6IEHKnft2iA8dzEBICTockHkc/ttHS
 zMtueoMKRjIEA==
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
Subject: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Date: Mon, 29 Jun 2026 13:23:16 +0100
Message-ID: <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
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

Update the file comment to clarify that both file-backed and anonymous
interval trees are provided, referencing the relevant data types for
clarity.

Also add comments to indicate which parts of the file apply to each.

While we're here, convert the VM_BUG_ON_VMA() to VM_WARN_ON_ONCE_VMA().

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/interval_tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 344d1f5946c7..2d50bc6228c4 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/interval_tree.c - interval tree for mapping->i_mmap
+ * mm/interval_tree.c - interval tree for address_space->i_mmap and
+ * anon_vma->rb_root
  *
  * Copyright (C) 2012, Michel Lespinasse <walken@google.com>
  */
@@ -10,6 +11,8 @@
 #include <linux/rmap.h>
 #include <linux/interval_tree_generic.h>
 
+/* File-backed interval tree (address_space->i_mmap) */
+
 INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
 		     unsigned long, shared.rb_subtree_last,
 		     vma_start_pgoff, vma_last_pgoff, /* empty */, vma_interval_tree)
@@ -23,7 +26,7 @@ void vma_interval_tree_insert_after(struct vm_area_struct *node,
 	struct vm_area_struct *parent;
 	unsigned long last = vma_last_pgoff(node);
 
-	VM_BUG_ON_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
+	VM_WARN_ON_ONCE_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
 
 	if (!prev->shared.rb.rb_right) {
 		parent = prev;
@@ -48,6 +51,8 @@ void vma_interval_tree_insert_after(struct vm_area_struct *node,
 			    &vma_interval_tree_augment);
 }
 
+/* Anonymous interval tree (anon_vma->rb_root) */
+
 static inline unsigned long avc_start_pgoff(struct anon_vma_chain *avc)
 {
 	return vma_start_pgoff(avc->vma);
-- 
2.54.0

