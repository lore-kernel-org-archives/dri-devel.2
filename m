Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DF4C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F04210E880;
	Mon, 29 Jun 2026 12:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SjKzPFOR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA79410E876;
 Mon, 29 Jun 2026 12:25:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67AC0600AB;
 Mon, 29 Jun 2026 12:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EF81F00A3A;
 Mon, 29 Jun 2026 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735910;
 bh=mS4FmeICQJ9Ywkxd+EfahpDdy7CpZ1ZHvCipweuqRKE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SjKzPFORFyyoIvxCVewGH6aMd/sKD/EoO7d5JdR5wogbwAZoUOXibHP65k2LlCA/8
 BiDr50glG3uwY1H1vA+mRYMF2MDP+QL5rXkWVgySzfCrIQhyGB+8gR4/GVBcPxj4qt
 DOvEa+0b0ihViJqYaZgKrywdAJzpEMJNG8Eb9Wa7BKWu8xy7A1vgegH8mqEYdTsSyy
 bT5ire25TKtLfGZBmMyi2ykzbXuONvUTuRmDOh+vr1tbwvuWufGO7Tn9tHB231p/iB
 1ssVMlvXkA/VVtOMvemMEKzl/DQy4jsIfz1JJ1pJKCxelkDTcCYThwtdLAEzJUM4u8
 0vd3tGQPSCpEw==
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
Subject: [PATCH 25/30] mm/vma: update vmg_adjust_set_range() to offset pgoff
 instead
Date: Mon, 29 Jun 2026 13:23:36 +0100
Message-ID: <910f7b5be78232304dc7ca01cd57c6f5ca8f3d13.1782735110.git.ljs@kernel.org>
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

We are calculating the pgoff as an offset, since we have vma_add_pgoff()
and vma_sub_pgoff() available, just offset this value directly and use
__vma_set_range() for vma->vm_[start, end] values.

We take care to update the range before offsetting the page offset, so the
adjusted VMA's vm_start and vm_pgoff are mutually consistent at the point
the page offset helpers operate - this matters once vma_set_pgoff() comes
to assert invariants which relate the two.

Doing so lays the foundation for future work which allows for use of
virtual page offsets for MAP_PRIVATE-file backed mappings.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/vma.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index e3355eab11f2..0579fc8c9bd5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -714,9 +714,6 @@ void validate_mm(struct mm_struct *mm)
  */
 static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 {
-	struct vm_area_struct *adjust;
-	pgoff_t pgoff;
-
 	if (vmg->__adjust_middle_start) {
 		/*
 		 * vmg->start    vmg->end
@@ -735,8 +732,8 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 		struct vm_area_struct *middle = vmg->middle;
 		const unsigned long delta = vmg->end - middle->vm_start;
 
-		pgoff = vma_start_pgoff(middle) + (delta >> PAGE_SHIFT);
-		adjust = middle;
+		__vma_set_range(middle, vmg->end, middle->vm_end);
+		vma_add_pgoff(middle, delta >> PAGE_SHIFT);
 	} else if (vmg->__adjust_next_start) {
 		/*
 		 *                Originally:
@@ -764,13 +761,9 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 		struct vm_area_struct *next = vmg->next;
 		const unsigned long delta = next->vm_start - vmg->end;
 
-		pgoff = vma_start_pgoff(next) - (delta >> PAGE_SHIFT);
-		adjust = next;
-	} else {
-		return;
+		__vma_set_range(next, vmg->end, next->vm_end);
+		vma_sub_pgoff(next, delta >> PAGE_SHIFT);
 	}
-
-	vma_set_range(adjust, vmg->end, adjust->vm_end, pgoff);
 }
 
 /*
-- 
2.54.0

