Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809BCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDB810ED92;
	Tue, 19 May 2026 16:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OHsoqrYc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED86D10ED92
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779206488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cipZ17JT05Ge5l1VfUm/NtrMByICdVG7S5/ux07qG+4=;
 b=OHsoqrYc6LStIhtFd9UBKj/r9rjDGhsk1iIIFvsQs42ctR9zIhLgOrg7hHBj4sr4HKDnSk
 beSF8Np4Kfwq0z2N/T5GLJTzefDwJzHZA/lUnsnvBPUI5QbGpQhbTdtXK6mYrKuYMMpO+G
 9/bH/tSxDWmYdwJZ9woIS51Uw9AbSgs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-XVK3oWqHPbKWykFsbdfVMw-1; Tue, 19 May 2026 12:01:26 -0400
X-MC-Unique: XVK3oWqHPbKWykFsbdfVMw-1
X-Mimecast-MFC-AGG-ID: XVK3oWqHPbKWykFsbdfVMw_1779206485
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-90fbc9782c9so753790385a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206485; x=1779811285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cipZ17JT05Ge5l1VfUm/NtrMByICdVG7S5/ux07qG+4=;
 b=ILPxVSOPBOCQbGAK/UNWNcFtESQ3/MpHCYXhSzFQNo92KCLfIBNiGRBc98flOtVyiE
 Au92J5kJi0FkTPKtzCnDMh6BYKewmdxxYchckWDQBKX5VgNgVpuSbCwklGw8qll3sNRS
 Y3jJvTsQ+t4ToHaAylwJzoBSXjLpsBaOVzTgHpiWjcL4vLlINPZ3PtB0CqKjFJ8mfcfh
 fE7PeasHyxsMxmCd89wdyelCQ+jbowIICPQD2Et9A6ZfG6yOY09lbj4l/so/NqVZqAqE
 i4Xrtfp5ii0O6vfK77EHWiCBiUO3lYL8NzzUEeJF4EhHJf5DmZLpGdRFq0uNlNL2cN69
 pvDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tHqGutK7ZDjiWIEK0zqv6TmnKP3Z8+tuiCneDLm0DkXLYHu2VawFqcwxp5ZzhZ4nENUtbMp8/kUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbWi91kDEWJyW9cMYwBhLKTwUuh+sJAJb9dXMNeIcGz/eXLLwS
 OLyiQrUVQ3zZvcJNEgzY/OXrGcmUwP4769wn9VwttY+iJrao5vxV5UQu/9wnxceljweJvuqYa63
 cpssl1WY0MGPvl5h/nBcdabDIwdWrpOuS+MGXYyH/LTzEpSTG9rUqAnCNjSsmVhpqqzGFJA==
X-Gm-Gg: Acq92OFbYTy9Oowdi0aegqhqLpZNnk8DPrAHRMgEtKnspbAr8txeOndMFePV1YK+08z
 u6CvWAGImEpFRChi6U2s1AJcEXO8PKhNJerbCK5clv2PpNxC3ebzFF7ytlouQKwGOybIRO7d5MP
 M/y1S3U91kyNAnM+ak/OfTXPtkxp9uP+nEZm8/B2sP3WGzsRHPCpaXoj6TxSeLNYbjFnCEP7PUg
 puX/oYMZ50PrGgwHRASr9TYHtU1pXuxP+JJirRtuHUShh3yd1sd+wHiVVBOM6NeMtoGB6jASW+m
 Wcyv4IhDJUd0odTH5EGGyLGBTmUiJIy3ChWdD6Qef7InD1yGG3bJlIi0NDmNrrAgigQuBRlkKDJ
 lqLrcR0kRABOg3jqM7LaBquAXiB8lNfNujvrfSmPMigRty/La0swZtqFOLXXI0Be3fQ==
X-Received: by 2002:a05:620a:7116:b0:90a:708c:e6d9 with SMTP id
 af79cd13be357-911d10425e9mr3114784985a.56.1779206463321; 
 Tue, 19 May 2026 09:01:03 -0700 (PDT)
X-Received: by 2002:a05:620a:7116:b0:90a:708c:e6d9 with SMTP id
 af79cd13be357-911d10425e9mr3114014285a.56.1779206432003; 
 Tue, 19 May 2026 09:00:32 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net.
 [100.17.21.205]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bd62e233sm1876151185a.45.2026.05.19.09.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:00:31 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Tue, 19 May 2026 11:59:01 -0400
Subject: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
MIME-Version: 1.0
Message-Id: <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org, 
 Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ASlse5f40Tyk7aemnWDzDLZYZaCIahAZVyTDQZyqZg_1779206485
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Add mem_cgroup_dmem_charge() and mem_cgroup_dmem_uncharge() to allow
dmem pool allocations to optionally be double-charged against the memory
controller. Take the struct cgroup from the dmem pool's css as there is
no convenient object exported to represent these allocations. These will
resolve the effective memory css from that cgroup and perform the
charge.

Introduce a MEMCG_DMEM stat counter to memory.stat to make the cgroup's
dmem charge visible.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 include/linux/memcontrol.h | 16 ++++++++++++
 mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b45748b2acee6d7f43da325eb50c1..8e1d49b87fb64e6114f3eb920293e14920290fe7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -39,6 +39,7 @@ enum memcg_stat_item {
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
+	MEMCG_DMEM,
 	MEMCG_NR_STAT,
 };
 
@@ -1872,6 +1873,21 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 }
 #endif
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_CGROUP_DMEM)
+bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
+			    gfp_t gfp_mask);
+void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages);
+#else
+static inline bool mem_cgroup_dmem_charge(struct cgroup *cgrp,
+					  unsigned int nr_pages, gfp_t gfp_mask)
+{
+	return true;
+}
+static inline void mem_cgroup_dmem_uncharge(struct cgroup *cgrp,
+					    unsigned int nr_pages)
+{
+}
+#endif
 
 /* Cgroup v1-related declarations */
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d466803db49cdaa90e6d6ba426b7afe2..91a7ac16b6eac2d6c3700b6885a068bf8b640706 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -433,6 +433,7 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
+	MEMCG_DMEM,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -1606,6 +1607,9 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
 #endif
+#ifdef CONFIG_CGROUP_DMEM
+	{ "dmem",			MEMCG_DMEM		},
+#endif
 };
 
 /* The actual unit of the state item, not the same as the output unit */
@@ -5909,6 +5913,67 @@ static struct cftype zswap_files[] = {
 };
 #endif /* CONFIG_ZSWAP */
 
+#ifdef CONFIG_CGROUP_DMEM
+/**
+ * mem_cgroup_dmem_charge - charge memcg for a dmem pool allocation
+ * @cgrp: cgroup of the dmem pool
+ * @nr_pages: number of pages to charge
+ * @gfp_mask: reclaim mode
+ *
+ * Charges @nr_pages to @memcg. Returns %true if the charge fit within
+ * @memcg's configured limit, %false if it doesn't.
+ */
+bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
+			    gfp_t gfp_mask)
+{
+	struct cgroup_subsys_state *mem_css;
+	struct mem_cgroup *memcg;
+
+	/* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
+	mem_css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
+
+	/* Use the memcg, if any, of the dmem cgroup. */
+	memcg = mem_cgroup_from_css(mem_css);
+	if (!memcg || mem_cgroup_is_root(memcg)) {
+		css_put(mem_css);
+		return false;
+	}
+
+	if (try_charge_memcg(memcg, gfp_mask, nr_pages)) {
+		css_put(mem_css);
+		return false;
+	}
+
+	mod_memcg_state(memcg, MEMCG_DMEM, nr_pages);
+	css_put(mem_css);
+	return true;
+}
+
+/**
+ * mem_cgroup_dmem_uncharge - uncharge memcg from a dmem pool allocation
+ * @cgrp: cgroup of the dmem pool
+ * @nr_pages: number of pages to uncharge
+ */
+void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages)
+{
+	struct cgroup_subsys_state *mem_css;
+	struct mem_cgroup *memcg;
+
+	/* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
+	mem_css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
+
+	memcg = mem_cgroup_from_css(mem_css);
+	if (!memcg || mem_cgroup_is_root(memcg)) {
+		css_put(mem_css);
+		return;
+	}
+
+	mod_memcg_state(memcg, MEMCG_DMEM, -nr_pages);
+	refill_stock(memcg, nr_pages);
+	css_put(mem_css);
+}
+#endif /* CONFIG_CGROUP_DMEM */
+
 static int __init mem_cgroup_swap_init(void)
 {
 	if (mem_cgroup_disabled())

-- 
2.52.0

