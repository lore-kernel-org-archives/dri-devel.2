Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E6F10BA435
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70A810ECDD;
	Fri, 27 Mar 2026 08:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EEvE81ep";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644C210ECEB;
 Fri, 27 Mar 2026 08:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774599405; x=1806135405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Sffc1FnB7aLC90BrXNdUZA1BmIxr98g2Izx7ogRry0=;
 b=EEvE81epPJS+S1Q7dA5jLkiomh51vsxq3unZLbup5UpxpfdStOzeqrS2
 SNgsQpMAlKH0u+str/nih28hYF1Kd5uW6l2SP5Ztz8ZrFAzshSrSy4Hem
 Gy1g9ZVVAsWjVNw6WrQ1zzh6YWswnReP3U/302WjsYAvLJ6ycvSw8wV4K
 85YlHp2lJ9f2CqVDFTOKMPgALAgE8XiBLD76qdB3qlNTl/YgIos4n6y9D
 1Y/d2DhDh8KhHhml9iPuLKXx548uUF3ZZNkJs4ez4fdEhA2edNsX+NUr5
 /3Rx92Ihr3GINgxzA/laBTbCP8HFqnMmoeHwAsUKp5BP/HhrydFp2E6nD w==;
X-CSE-ConnectionGUID: cw8r5HxgQU64vrFJLaAEew==
X-CSE-MsgGUID: 9TmHSyp5TAmHYmZdePd8RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75784054"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75784054"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:16:45 -0700
X-CSE-ConnectionGUID: z9ayDlz1Qce3tvLAo25+iw==
X-CSE-MsgGUID: +20jAXVHSBWHzwq2DEln3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255747905"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora)
 ([10.245.244.146])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:16:39 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max below
 current usage
Date: Fri, 27 Mar 2026 09:15:57 +0100
Message-ID: <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add an optional reclaim callback to struct dmem_cgroup_region.  When
dmem.max is set below current usage, invoke the callback to evict memory
and retry setting the limit rather than failing immediately.  Signal
interruptions propagate back to the write() caller.

RFC:
Due to us updating the max limit _after_ the usage has been
sufficiently lowered, this should be prone to failures if there are
aggressive allocators running in parallel to the reclaim.
So can we somehow enforce the new limit while the eviction is
happening?

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/cgroup_dmem.h | 11 +++++
 kernel/cgroup/dmem.c        | 94 +++++++++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736..61520a431740 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      bool ignore_low, bool *ret_hit_low);
 
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
+void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+						   u64 target_bytes, void *priv),
+				    void *priv);
 #else
 static inline __printf(2,3) struct dmem_cgroup_region *
 dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
@@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 { }
 
+static inline void
+dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+			       int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+					      u64 target_bytes, void *priv),
+			       void *priv)
+{ }
+
 #endif
 #endif	/* _CGROUP_DMEM_H */
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 3e6d4c0b26a1..f993fb058b74 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -51,6 +51,18 @@ struct dmem_cgroup_region {
 	 * No new pools should be added to the region afterwards.
 	 */
 	bool unregistered;
+
+	/**
+	 * @reclaim: Optional callback invoked when dmem.max is set below the
+	 * current usage of a pool. The driver should attempt to free at least
+	 * @target_bytes from @pool. May be called multiple times if usage
+	 * remains above the limit after returning.
+	 */
+	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64 target_bytes,
+		       void *priv);
+
+	/** @reclaim_priv: Private data passed to @reclaim. */
+	void *reclaim_priv;
 };
 
 struct dmemcg_state {
@@ -145,23 +157,59 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 }
 
 static int
-set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
+		 struct dmem_cgroup_region *region)
 {
 	page_counter_set_min(&pool->cnt, val);
 	return 0;
 }
 
 static int
-set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
+		 struct dmem_cgroup_region *region)
 {
 	page_counter_set_low(&pool->cnt, val);
 	return 0;
 }
 
 static int
-set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
+		 struct dmem_cgroup_region *region)
 {
-	return page_counter_set_max(&pool->cnt, val);
+	int err = page_counter_set_max(&pool->cnt, val);
+
+	if (err != -EBUSY || !region || !region->reclaim)
+		return err;
+
+	/*
+	 * The new max is below current usage.  Ask the driver to evict memory
+	 * and retry, up to a bounded number of times.  Signal interruptions are
+	 * propagated back to the write() caller; other reclaim failures leave
+	 * -EBUSY as the result.
+	 */
+	for (int retries = 5; retries > 0; retries--) {
+		u64 usage = page_counter_read(&pool->cnt);
+		u64 target = usage > val ? usage - val : 0;
+		int reclaim_err;
+
+		if (!target) {
+			err = page_counter_set_max(&pool->cnt, val);
+			break;
+		}
+
+		reclaim_err = region->reclaim(pool, target, region->reclaim_priv);
+		if (reclaim_err) {
+			if (reclaim_err == -EINTR || reclaim_err == -ERESTARTSYS)
+				err = reclaim_err;
+			break;
+		}
+
+		err = page_counter_set_max(&pool->cnt, val);
+		if (err != -EBUSY)
+			break;
+	}
+
+	return err;
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -186,9 +234,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
-	set_resource_min(rpool, 0);
-	set_resource_low(rpool, 0);
-	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_min(rpool, 0, NULL);
+	set_resource_low(rpool, 0, NULL);
+	set_resource_max(rpool, PAGE_COUNTER_MAX, NULL);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -570,6 +618,32 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
 
+/**
+ * dmem_cgroup_region_set_reclaim - Register a reclaim callback on a region.
+ * @region: The region to register the callback for.
+ * @reclaim: Callback to invoke when dmem.max is set below current usage.
+ *           Called with the pool that needs reclaiming and the number of
+ *           bytes to free. Returns 0 on progress, negative on failure.
+ * @priv: Opaque pointer passed back to @reclaim.
+ *
+ * When dmem.max is lowered below the current usage of a cgroup pool, the
+ * dmem controller will call @reclaim with a target number of bytes to free.
+ * After @reclaim returns the controller retries setting the limit; if usage
+ * is still too high it calls @reclaim again, up to a bounded retry count.
+ */
+void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+						   u64 target_bytes, void *priv),
+				    void *priv)
+{
+	if (!region)
+		return;
+
+	region->reclaim = reclaim;
+	region->reclaim_priv = priv;
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
+
 static struct dmem_cgroup_pool_state *
 get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 {
@@ -728,7 +802,8 @@ static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 int (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 int (*apply)(struct dmem_cgroup_pool_state *, u64,
+					      struct dmem_cgroup_region *))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
 	int err = 0;
@@ -775,7 +850,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		err = apply(pool, new_limit);
+		err = apply(pool, new_limit, region);
+
 		dmemcg_pool_put(pool);
 
 out_put:
-- 
2.53.0

