Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E7DC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B54D10EF91;
	Wed,  9 Sep 2026 08:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IxMdyjOD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8493E10EFA8
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:08:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 594C844795;
 Wed,  9 Sep 2026 08:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D460C2BCFB;
 Wed,  9 Sep 2026 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788941334;
 bh=bGStaMYU8yIvPfBkyTgjETA7IHiwhxaw5cb0hq+LHYU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=IxMdyjODlodjPzETN0ZlTlWGQwo1BDrgoaRYlv+FQ6s3kEotmNPwNfdrAryO9JNFd
 PmF3eUBC8xARPcWNJDdAK2WkIWwHzpHNjHMoCxIOrzwftFYbl0cBEdb/KhzeJgJRWB
 YdWJjnmvsnMnbBhfYkWGO6eZPCi2GOQQA+2tp+bL4ptYoPHhDxCDuPzYE52re2tRPm
 kGy2mFaZz6fvEoxKw5BtwZOQfReE/pDGCtNmrhciwJUGkY1hRfeNosMb1JxLEOZ4zz
 no0sbkZF2Bh49F53Vb8ilWVud1xJM/L4xqR+TAsiIV8WruXvRLeos0QSsgUfNZbBla
 XUdySNqJ60IXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1A84DC79FB8;
 Wed,  9 Sep 2026 08:08:54 +0000 (UTC)
From: linuszeng via B4 Relay <devnull+linuszeng.tencent.com@kernel.org>
Date: Wed, 09 Sep 2026 16:08:53 +0800
Subject: [PATCH 3/3] mm: page_counter: drop protection fields from struct
 page_counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-descriptive-name-v1-3-1828961cb01a@tencent.com>
References: <20260909-descriptive-name-v1-0-1828961cb01a@tencent.com>
In-Reply-To: <20260909-descriptive-name-v1-0-1828961cb01a@tencent.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <nat@pixelcluster.dev>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linuszeng <linuszeng@tencent.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788941332; l=1787;
 i=linuszeng@tencent.com; s=20260909; h=from:subject:message-id;
 bh=shz9WUAjddH3Alsemp6w1PbzeLYHyRzk5zeGNg7NEjM=;
 b=2xbTnqKMfvIkkyGThb5sZPBIowVjmF2rt6clRF6E2moyVUbPwRWuAbXWnddNr77RCDf9wUlxB
 Bi7dxyJ1ndxAb4B78hc5cPxuy0anDb/3ZihIS8QvYsge+PRe+X+8kCI
X-Developer-Key: i=linuszeng@tencent.com; a=ed25519;
 pk=6K54xRzYIRWqatrAPy86M4E0MsI92BVJBhXwz5NdC74=
X-Endpoint-Received: by B4 Relay for linuszeng@tencent.com/20260909 with
 auth_id=1017
X-Original-From: linuszeng <linuszeng@tencent.com>
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
Reply-To: linuszeng@tencent.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: linuszeng <linuszeng@tencent.com>

The protection state now lives in struct page_counter_protection, so
remove the emin/min_usage/children_min_usage, elow/low_usage/
children_low_usage, min, low and protection_support fields from struct
page_counter.

swap/memsw, kmem, tcpmem and hugetlb counters no longer carry this
unused state: on 64-bit the structure shrinks from three cache lines to
two, saving one cache line.
---
 include/linux/page_counter.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index b81f16702764..a4dd461523af 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -43,27 +43,11 @@ struct page_counter {
 
 	CACHELINE_PADDING(_pad1_);
 
-	/* effective memory.min and memory.min usage tracking */
-	unsigned long emin;
-	atomic_long_t min_usage;
-	atomic_long_t children_min_usage;
-
-	/* effective memory.low and memory.low usage tracking */
-	unsigned long elow;
-	atomic_long_t low_usage;
-	atomic_long_t children_low_usage;
-
 	unsigned long watermark;
 	/* Latest cg2 reset watermark */
 	unsigned long local_watermark;
 
-	/* Keep all the read most fields in a separete cacheline. */
-	CACHELINE_PADDING(_pad2_);
-
-	bool protection_support;
 	bool track_failcnt;
-	unsigned long min;
-	unsigned long low;
 	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
@@ -73,6 +57,9 @@ struct page_counter {
 	 * support memory.min/memory.low (swap, memsw, kmem, tcpmem, ...).
 	 */
 	struct page_counter_protection *prot;
+
+	/* Keep all the read most fields in a separete cacheline. */
+	CACHELINE_PADDING(_pad2_);
 } ____cacheline_internodealigned_in_smp;
 
 #if BITS_PER_LONG == 32

-- 
2.43.7


