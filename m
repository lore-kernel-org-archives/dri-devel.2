Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF5DC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26BB10E7DB;
	Mon, 13 Jul 2026 07:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S1DwmzxW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F1110E242;
 Fri, 10 Jul 2026 20:23:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 491194148B;
 Fri, 10 Jul 2026 20:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751431F00A3A;
 Fri, 10 Jul 2026 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783714999;
 bh=8inNSEODGbyh/+vAWll7hEmDowJfY2XIaIfPLAyfMv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=S1DwmzxWKK/EvOlvmXiaNgzfe9uDLXmTCD+WOfUbIAIznmeNow2bwHsqtQNnJDz6P
 rqHs9qpnmDqZ7AXsBeyQzhFBN9oQXnRABs+LJNq40HsMI5lnNl+DSPJGinGwGnULCx
 78OgKDP4iyqp5wUZhtC+twh9ggQujW01mEbzw5nIUKY4aWS4GEh9yM5cAf3VYB8bQx
 mMyUoAKHPGwt0QsRpaNGnK2kAqbELgSA+bpm+oAZ4D8FAeyJdaN8Ea3X9Nm3YToX6X
 LgnaMPze03tseVbPBRg/fzdp8E+k83ZRinjxnRZ9sKzJ6gvhECaFRdAXhf2O5a1uOD
 zoICWtvDCZyZQ==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Fri, 10 Jul 2026 21:16:56 +0100
Subject: [PATCH v2 15/33] mm/vma: refactor vmg_adjust_set_range() for clarity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-pre-scalable-cow-v2-15-2a5aa403d977@kernel.org>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
 Peter Xu <peterx@redhat.com>, Kees Cook <kees@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Yishai Hadas <yishaih@nvidia.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usama.arif@linux.dev>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev, 
 iommu@lists.linux.dev, kasan-dev@googlegroups.com, 
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561; i=ljs@kernel.org;
 h=from:subject:message-id; bh=/OET8/zUpzsJ/XNmWkLK0gsvh8paST29XGIok8Z8NBo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLICg21eWBnkBU3wWsq2iz/TO8ZQcE3VnwrbFNZv12IU1
 viv6S/tKGVhEONikBVTZHn+RXx/kEjYvM4L/m4wc1iZQIYwcHEKwEQeuDEyfLi5azmfhOuak/Y7
 /x39eSMlunV7+X2dpoxbEw5qHn3m0MXI8NngWsiVLEV5+0l6Sf1f61cyr3mWXucy4WDe1De3LqV
 uZQMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/vma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 084afdf37385..7265a054cfa3 100644
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
2.55.0

