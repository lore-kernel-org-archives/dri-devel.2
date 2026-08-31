Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95939C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623BF10E3A7;
	Tue,  1 Sep 2026 07:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XIYV1Jk1";
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA87210E9AA
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:38:02 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-6b127c88220so1389925eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194282; x=1788799082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KCEcxBXECIK58MqzfUHKxW4lG6L2Egx8+PoUClZnYOs=;
 b=XIYV1Jk1UhAkpX/RLyqATZxeKm5h+id3QqlBJtAtLqpTvIzbbpFALBwKQO88zz4sJS
 xZVPllUQxAiuBe/UAa3KyzMJfyc0Dt/o0glFRKE46Oy1xqvM30mD3BW25v14XLiY1yPT
 rULSXyitfPKYwaLzLhmFMuIrxJgHGLDIgL+JiaTgam2NS42qiINKeT2t1GrBKVSc15xs
 NhL77vJ8a6cupHdIRytIQsinzjVdse+f7FY1ysm78mAtrs2c3sJPhwzkVBx3NWBAi+Mu
 PvR9GxU1OtlVMKSlrXwz0FdT/RkdjqWUs7HjDvaO1/5kpTbs9it0vDiOpG/uHn0kAM0h
 OMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194282; x=1788799082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KCEcxBXECIK58MqzfUHKxW4lG6L2Egx8+PoUClZnYOs=;
 b=KDOdSurJU2g8KlrtJ6wuQ3esLDgDiYuVdlsirSuMgWDoUq4ahim9bf0aTJmzItzb33
 DGxFCbK4EBoWwJ3PEUIdgd/lPObpJ0hz1C2ykoRuHkUgZ4MvTjxvf6sa+PLE1c5Oy5gt
 skZ1iLE2RAkIq4XmNDxdy8OdLj/RpyzbA9UsRGSuTD1F/yXkeDtI+9YNHD9r8OXjwxr3
 uBkDlPSQPTRCnL4+j147NY9vxngDAf7d90XAJJkbbtx0aj0k9r6k/mHQ+TgwD7RMVcJO
 NOgfNzn/j9x2/Z/4doDnKLvpSSTgrQDBV3MUuGRMd1x6EnMi2rhfS/o20BLNg30QP5vL
 vjhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSFV59ZKjWoV/4KjmWL0yMF/+pJ/IMNJ/zZLl8CzHuPPJTo21pSfQSYaKVnTVdzzk85VUhMxkA+k0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNG6CFKQIMx4IWy1aMkB+cercykh12jgEHuxjnWOihQxTRKGeH
 PKr1/1KJhYlEIoyD79ufzqJtzvXYoWBlu7mkpzzWrDK9lL/rZ8Iz4+6x
X-Gm-Gg: AR+sD13lCj44h2FCT7UA7EgjculhnieY6bXwPll2V6eh4hBFjmEecQDdq72YI/7robt
 lziVAwCbbQLQHLOyrArRhOH+uMEhxLq5Qid6q4MwPBZuKzYCIO4SV5LQOXbdn+5J4GSuBMip2jZ
 JVDkwq6V1RB9DTIp5E2i56VFiG/8acwPMmnsjD00lv4/BTvmKymIMjejZpddbeKUr5jT8KY7C+I
 k/h18X70HXnZzCuygcovJHWZ/y+0SARLbBQ+UdS+XqtRP9eVRbU+J8yLbuqMcIye1AFVHdAOc1p
 m8mgu+MceqLJ+nSL5aII8GxdVRBgafy4XfvYgkwb/ZOlmCpLjbNOwwGaZNYPVhVyMmNS1cbcRr9
 ioV5/T4wmob4h/BA5ixjbPSAfNQATJYfX0QD/5ASaHdRQP8wPBFibasqj5QjbpwM7UX1B8lo6T5
 oJFTR73kmANhRMch2nogDrIeMfhJIyyns5/cImOhYGmCUWzTAg45ygDuJxUsT/0HMWhgpH1njfl
 7WXfHgO+twWnBhiWA==
X-Received: by 2002:a05:6820:1791:b0:6b1:d18b:4048 with SMTP id
 006d021491bc7-6b372d21358mr2106016eaf.10.1788194281822; 
 Mon, 31 Aug 2026 09:38:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:e::])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa7e97d5sm8453832a34.10.2026.08.31.09.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:38:01 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, dev@lankhorst.se, mripard@kernel.org,
 nat@pixelcluster.dev, tj@kernel.org, mkoutny@suse.com, osalvador@suse.de,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: [PATCH v5 7/7] mm/memcontrol: add stock to the memsw page_counter
Date: Mon, 31 Aug 2026 09:37:51 -0700
Message-ID: <20260831163752.2193337-8-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Before this series, each memcg had one stock shared by all its
page_counters (memory + memsw). Now that the memcg stock was folded
into the page_counter level, give memsw its own page_counter_stock
so that it can benefit from caching charges as well.

Note that while the allocation is conditional on do_memsw_account(),
the freeing is not; the freer will only free non-NULL stocks. This
matters because do_memsw_account() could have changed in between the
allocation and the free.

This narrows the memsw skew introduced by the previous patch. memsw is
now charged in the same batches as memory, so the two no longer diverge
systematically, but can still see transient drifts since each keeps
its own per-cpu stock. The drift is bound by
MEMCG_CHARGE_BATCH * nr_possible_cpus.

In the unlikely scenario that one of the stocks does not get allocated,
there will be different granularities of charging for the cgroup's
lifetime (one charging in batch granularity, the other just in
nr_pages).

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5678486cc55b0..33e4ffbd48a8b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2127,8 +2127,10 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 	if (!mutex_trylock(&percpu_charge_mutex))
 		return;
 
-	for_each_mem_cgroup_tree(memcg, root_memcg)
+	for_each_mem_cgroup_tree(memcg, root_memcg) {
 		page_counter_drain_stock_async(&memcg->memory);
+		page_counter_drain_stock_async(&memcg->memsw);
+	}
 
 	/* Hotplug races are OK; workers only touch their own cpu's obj_stock */
 	migrate_disable();
@@ -2159,8 +2161,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	/* no need for the local lock */
 	drain_obj_stock(obj_st);
 
-	for_each_mem_cgroup_tree(memcg, NULL)
+	for_each_mem_cgroup_tree(memcg, NULL) {
 		page_counter_drain_cpu_stock(&memcg->memory, cpu);
+		page_counter_drain_cpu_stock(&memcg->memsw, cpu);
+	}
 
 	/*
 	 * A drain work queued before the CPU went away is executed by an
@@ -2467,7 +2471,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto check_high;
 
 	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
+		page_counter_refill_stock(&memcg->memsw, nr_pages);
 	mem_over_limit = mem_cgroup_from_counter(counter, memory);
 
 reclaim:
@@ -2926,7 +2930,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_refill_stock(&memcg->memory, nr_pages);
 		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, nr_pages);
+			page_counter_refill_stock(&memcg->memsw, nr_pages);
 	}
 
 	css_put(&memcg->css);
@@ -3930,6 +3934,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	page_counter_free_stock(&memcg->memory);
+	/* memsw and swap are the same counter; only memsw is ever stocked */
+	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
@@ -4098,8 +4104,12 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	css_get(css);
 
 	/* stock allocation failure is nonfatal; fall back to direct charges */
-	if (!mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_alloc_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+		if (do_memsw_account())
+			page_counter_alloc_stock(&memcg->memsw,
+						 MEMCG_CHARGE_BATCH);
+	}
 
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
-- 
2.53.0-Meta

