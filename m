Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D1C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D5B10E871;
	Mon, 29 Jun 2026 12:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RgZY26GF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A054110E871;
 Mon, 29 Jun 2026 12:24:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AAB041A2F;
 Mon, 29 Jun 2026 12:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B261F000E9;
 Mon, 29 Jun 2026 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735874;
 bh=g8hFMC27gURJNhB6p0eY8jCsWeWrDR4QrXmiBvTta7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RgZY26GFPwRTB1pZ7k8Hjrkht1yhlMQPpzLMXpSHyJE/iJGDN7j65pJ81hC/gtgLX
 TIXGR9Pmq2Hxctix/kWtNogsZ/VpxS9rEtLqkjyg+2gCc64vbLA1kjiihuPpSGgVqn
 5JE/+voej08NE9+VTMp/13Hp/4FeI8UWueVZot/5DzUfLHtSYw42SyKNlH2Be9bcXj
 S5L9pNn+ueyRVBev/leVYE6cKXlQlFTi7KLCH/hDrN51Ijk2orVDyg60yHbU+yCkn0
 GD8zPsNv+frXWvkaGHFxjbjgZFYsSeY3aqb2c33rePaO6yVCRySC9q7kmsMnG53f98
 8frGbDucBM2cA==
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
Subject: [PATCH 13/30] mm/vma: refactor vmg_adjust_set_range() for clarity
Date: Mon, 29 Jun 2026 13:23:24 +0100
Message-ID: <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>
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

Add comments with ASCII diagrams to describe what we're doing, avoid
dubious use of PHYS_PFN(), and use vma_start_pgoff().

The most complicated scenario represented here is vmg->__adjust_next_start
- when this is set, vmg->[start, end] actually indicate the range to be
retained, so take special care to describe this accurately.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/vma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 6296acecf3b7..1e99fe8aa6ef 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -704,11 +704,54 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 	pgoff_t pgoff;
 
 	if (vmg->__adjust_middle_start) {
-		adjust = vmg->middle;
-		pgoff = adjust->vm_pgoff + PHYS_PFN(vmg->end - adjust->vm_start);
+		/*
+		 * vmg->start    vmg->end
+		 * |             |
+		 * v    merge    v
+		 * <------------->
+		 *         delta
+		 *        <------>
+		 * |------|----------------|
+		 * | prev |    middle      |
+		 * |------|----------------|
+		 *        ^
+		 *        |
+		 *        middle->vm_start
+		 */
+		struct vm_area_struct *middle = vmg->middle;
+		const unsigned long delta = vmg->end - middle->vm_start;
+
+		pgoff = vma_start_pgoff(middle) + (delta >> PAGE_SHIFT);
+		adjust = middle;
 	} else if (vmg->__adjust_next_start) {
-		adjust = vmg->next;
-		pgoff = adjust->vm_pgoff - PHYS_PFN(adjust->vm_start - vmg->end);
+		/*
+		 *                Originally:
+		 *
+		 *            vmg->start   vmg->end
+		 *            |            |
+		 *            v    merge   v
+		 *            <------------>
+		 *            .            .
+		 * merge_existing_range() updates to:
+		 *            .            .
+		 * vmg->start vmg->end     .
+		 * |          |            .
+		 * v  retain  v            .
+		 * <---------->            .
+		 *             delta       .
+		 *            <----->      .
+		 * |----------------|------|
+		 * |    middle      | next |
+		 * |----------------|------|
+		 *                  ^
+		 *                  |
+		 *                  next->vm_start
+		 */
+		struct vm_area_struct *next = vmg->next;
+		const unsigned long delta = next->vm_start - vmg->end;
+
+		pgoff = vma_start_pgoff(next) - (delta >> PAGE_SHIFT);
+		adjust = next;
 	} else {
 		return;
 	}
-- 
2.54.0

