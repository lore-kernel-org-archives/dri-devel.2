Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17CCCD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A7910E542;
	Wed,  6 May 2026 12:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XW/qXrnb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550DD10E535
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+geGgtC29tPii/y0xORPdzxzZcUtJ2/stRBH9k/cNK8=; b=XW/qXrnb4pX3o9W+wGI0W1ifJ0
 NfQ+n+ZFMHfs6VA1ESmzMbKmE1LhTwYO6E5ioKclh1JV02ZMIgaDzq0GWDQGBY0gzF5M76ylnTxrC
 7E83xUP/BpozMsICavLB6ZnfU1OU6LKx0Wj5aunbLpYvtUEeeieIU3m/Gz6cMFp6EOwENrODXCbf3
 qOAhjJFrqtO3TTo1KdntZRMNWjDxPaXQbODeZrPCu7vO2kJTzJ2xG5HwK+Qr7Tfm/0zWjMzI9lyRr
 zfNSZ+lTmJAiOm3aESaWQv9TqyHj0lqJt/pwBZdfMkgX0LhFpjXGu24OPdJYs3yC349aEQjU01NgC
 TXGtBmgw==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKav4-006sxt-Ta; Wed, 06 May 2026 14:00:02 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 06 May 2026 08:58:24 -0300
Subject: [PATCH 1/2] mm/page_counter: decouple peak_reset from peak_write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dmem_peak-v1-1-8d803eb3449c@igalia.com>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
In-Reply-To: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
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

Create a new function of_peak_reset that resets the page_counter peak for a
given writer. This should allow it to be reused by other cgroups.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/cgroup-defs.h |  6 ++++++
 kernel/cgroup/cgroup.c      | 32 ++++++++++++++++++++++++++++++++
 mm/memcontrol.c             | 42 ++++++++----------------------------------
 3 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f42563739d2e..a85044cb0553 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -22,6 +22,7 @@
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup-defs.h>
 #include <linux/psi_types.h>
+#include <linux/page_counter.h>
 
 #ifdef CONFIG_CGROUPS
 
@@ -868,11 +869,16 @@ struct cgroup_subsys {
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
 extern bool cgroup_enable_per_threadgroup_rwsem;
 
+#define OFP_PEAK_UNSET (((-1UL)))
+
 struct cgroup_of_peak {
 	unsigned long		value;
 	struct list_head	list;
 };
 
+void of_peak_reset(struct cgroup_of_peak *ofp, struct page_counter *pc,
+		   struct list_head *watchers);
+
 /**
  * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
  * @tsk: target task
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 45c0b1ed687a..9b98a5cccf0e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1981,6 +1981,38 @@ struct cgroup_of_peak *of_peak(struct kernfs_open_file *of)
 	return &ctx->peak;
 }
 
+/**
+ * of_peak_reset - reset peak
+ * @ofp: open file context
+ * @pc: counter
+ * @watchers: list of other open file contexts
+ *
+ * This function updates all contexts in @watchers to the new usage of @pc.
+ * If @ofp is not in the list yet, that is, if its value is
+ * %OFP_PEAK_UNSET, it is added to @watchers list.
+ *
+ * A lock must be used to protect @watchers.
+ */
+void of_peak_reset(struct cgroup_of_peak *ofp, struct page_counter *pc,
+		   struct list_head *watchers)
+{
+	unsigned long usage;
+	struct cgroup_of_peak *peer_ctx;
+
+	usage = page_counter_read(pc);
+	WRITE_ONCE(pc->local_watermark, usage);
+
+	list_for_each_entry(peer_ctx, watchers, list)
+		if (usage > peer_ctx->value)
+			WRITE_ONCE(peer_ctx->value, usage);
+
+	/* initial write, register watcher */
+	if (ofp->value == OFP_PEAK_UNSET)
+		list_add(&ofp->list, watchers);
+
+	WRITE_ONCE(ofp->value, usage);
+}
+
 static void apply_cgroup_root_flags(unsigned int root_flags)
 {
 	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d466..8754927070d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4517,8 +4517,6 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
-#define OFP_PEAK_UNSET (((-1UL)))
-
 static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
 {
 	struct cgroup_of_peak *ofp = of_peak(sf->private);
@@ -4563,45 +4561,18 @@ static void peak_release(struct kernfs_open_file *of)
 	spin_unlock(&memcg->peaks_lock);
 }
 
-static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
-			  loff_t off, struct page_counter *pc,
-			  struct list_head *watchers)
+static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
 {
-	unsigned long usage;
-	struct cgroup_of_peak *peer_ctx;
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	struct cgroup_of_peak *ofp = of_peak(of);
 
 	spin_lock(&memcg->peaks_lock);
-
-	usage = page_counter_read(pc);
-	WRITE_ONCE(pc->local_watermark, usage);
-
-	list_for_each_entry(peer_ctx, watchers, list)
-		if (usage > peer_ctx->value)
-			WRITE_ONCE(peer_ctx->value, usage);
-
-	/* initial write, register watcher */
-	if (ofp->value == OFP_PEAK_UNSET)
-		list_add(&ofp->list, watchers);
-
-	WRITE_ONCE(ofp->value, usage);
+	of_peak_reset(ofp, &memcg->memory, &memcg->memory_peaks);
 	spin_unlock(&memcg->peaks_lock);
-
 	return nbytes;
 }
 
-static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
-				 size_t nbytes, loff_t off)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-
-	return peak_write(of, buf, nbytes, off, &memcg->memory,
-			  &memcg->memory_peaks);
-}
-
-#undef OFP_PEAK_UNSET
-
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -5611,9 +5582,12 @@ static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct cgroup_of_peak *ofp = of_peak(of);
 
-	return peak_write(of, buf, nbytes, off, &memcg->swap,
-			  &memcg->swap_peaks);
+	spin_lock(&memcg->peaks_lock);
+	of_peak_reset(ofp, &memcg->swap, &memcg->swap_peaks);
+	spin_unlock(&memcg->peaks_lock);
+	return nbytes;
 }
 
 static int swap_high_show(struct seq_file *m, void *v)

-- 
2.47.3

