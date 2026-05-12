Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88292CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA95C10E9DD;
	Tue, 12 May 2026 09:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dagEqF3h";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D8110E9DD
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778577105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69pT9UAP5R9xquwF2RKvirwNK1KU0UnlPuHZxmUkf4A=;
 b=dagEqF3hlNBlrQI+ELPH8BMtWn0H//hUj82TEK+nJxgM76Nwg32rJI4Ie2/jgErKChrrkq
 IhxVztVK0SW2d3m/eeo6nqmfp3KXtz+XQr0IgEqiM7859eDxjG2r2kisTtiy+kx+THVtHM
 1YHMYbQQw9nIiTc2BMmrkMRimMcxJrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-vy73IfUBOTK7lruahCTuTQ-1; Tue,
 12 May 2026 05:11:40 -0400
X-MC-Unique: vy73IfUBOTK7lruahCTuTQ-1
X-Mimecast-MFC-AGG-ID: vy73IfUBOTK7lruahCTuTQ_1778577097
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F41519560B3; Tue, 12 May 2026 09:11:36 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 892D630001BE; Tue, 12 May 2026 09:11:27 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 May 2026 11:10:43 +0200
Subject: [PATCH RFC 1/5] memcg: Track exported dma-buffers
MIME-Version: 1.0
Message-Id: <20260512-v2_20230123_tjmercier_google_com-v1-1-6326701c3691@redhat.com>
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778577077; l=6992;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=oou5iyCLUb+b0Qe4gUEVdhshhWFEpNmREb+AjCRYjno=;
 b=r7PwA2z7A/J9T79UMaV88RnWGnyTSrgj2zIcGA5GTSkyL3i6+SlqXmDk74SRRLEW2d+MkWy5W
 cGGTgqCSg5KDj2SIirNvpK+EY77CTVf5/h67q1O5yMm4cOivk3ZurNR
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: V0xGOzxvxVb-wyiA7VTXIUUPfRONySk21S6owgKIOgs_1778577097
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

From: "T.J. Mercier" <tjmercier@google.com>

When a buffer is exported to userspace, use memcg to attribute the
buffer to the allocating cgroup until all buffer references are
released.

Unlike the dmabuf sysfs stats implementation, this memcg accounting
avoids contention over the kernfs_rwsem incurred when creating or
removing nodes.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++++
 drivers/dma-buf/dma-buf.c               | 13 ++++++++++++
 include/linux/dma-buf.h                 |  4 ++++
 include/linux/memcontrol.h              | 37 +++++++++++++++++++++++++++++++++
 mm/memcontrol.c                         | 19 +++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed995..8bdbc2e866430 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1635,6 +1635,10 @@ The following nested keys are defined.
 		Amount of memory used for storing in-kernel data
 		structures.
 
+	  dmabuf (npn)
+		Amount of memory used for exported DMA buffers allocated by the cgroup.
+		Stays with the allocating cgroup regardless of how the buffer is shared.
+
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
 
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c61..ce02377f48908 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
+#include <linux/memcontrol.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/anon_inodes.h>
@@ -180,6 +181,9 @@ static void dma_buf_release(struct dentry *dentry)
 	 */
 	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
 
+	mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
+	mem_cgroup_put(dmabuf->memcg);
+
 	dmabuf->ops->release(dmabuf);
 
 	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
@@ -760,6 +764,13 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 		dmabuf->resv = resv;
 	}
 
+	dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
+	if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
+				      GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_memcg;
+	}
+
 	file->private_data = dmabuf;
 	file->f_path.dentry->d_fsdata = dmabuf;
 	dmabuf->file = file;
@@ -770,6 +781,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	return dmabuf;
 
+err_memcg:
+	mem_cgroup_put(dmabuf->memcg);
 err_file:
 	fput(file);
 err_module:
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5f..d9f1ccb51c60e 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -27,6 +27,7 @@
 struct device;
 struct dma_buf;
 struct dma_buf_attachment;
+struct mem_cgroup;
 
 /**
  * struct dma_buf_ops - operations possible on struct dma_buf
@@ -429,6 +430,9 @@ struct dma_buf {
 
 		__poll_t active;
 	} cb_in, cb_out;
+
+	/** @memcg: the cgroup to which this buffer is currently attributed */
+	struct mem_cgroup *memcg;
 };
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b4..10068a833ad9e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -39,6 +39,7 @@ enum memcg_stat_item {
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
+	MEMCG_DMABUF,
 	MEMCG_NR_STAT,
 };
 
@@ -649,6 +650,24 @@ int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 
+/**
+ * mem_cgroup_charge_dmabuf - Charge dma-buf memory to a cgroup and update stat counter
+ * @memcg: memcg to charge
+ * @nr_pages: number of pages to charge
+ * @gfp_mask: reclaim mode
+ *
+ * Charges @nr_pages to @memcg. Returns %true if the charge fit within
+ * @memcg's configured limit, %false if it doesn't.
+ */
+bool __mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages, gfp_t gfp_mask);
+static inline bool mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages,
+					    gfp_t gfp_mask)
+{
+	if (mem_cgroup_disabled())
+		return true;
+	return __mem_cgroup_charge_dmabuf(memcg, nr_pages, gfp_mask);
+}
+
 void __mem_cgroup_uncharge(struct folio *folio);
 
 /**
@@ -664,6 +683,14 @@ static inline void mem_cgroup_uncharge(struct folio *folio)
 	__mem_cgroup_uncharge(folio);
 }
 
+void __mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_dmabuf(memcg, nr_pages);
+}
+
 void __mem_cgroup_uncharge_folios(struct folio_batch *folios);
 static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
@@ -1142,10 +1169,20 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
+static inline bool mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages,
+					    gfp_t gfp_mask)
+{
+	return true;
+}
+
 static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
 
+static inline void mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+}
+
 static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d4668..15cee13d3ccd6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -433,6 +433,7 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
+	MEMCG_DMABUF,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -1580,6 +1581,7 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	{ "hugetlb",			NR_HUGETLB			},
 #endif
+	{ "dmabuf",			MEMCG_DMABUF			},
 
 	/* The memory events */
 	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
@@ -5399,6 +5401,23 @@ void mem_cgroup_flush_workqueue(void)
 	flush_workqueue(memcg_wq);
 }
 
+bool __mem_cgroup_charge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages, gfp_t gfp_mask)
+{
+	if (try_charge(memcg, gfp_mask, nr_pages) == 0) {
+		mod_memcg_state(memcg, MEMCG_DMABUF, nr_pages);
+		return true;
+	}
+
+	return false;
+}
+
+void __mem_cgroup_uncharge_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
+	if (!mem_cgroup_is_root(memcg))
+		refill_stock(memcg, nr_pages);
+}
+
 static int __init cgroup_memory(char *s)
 {
 	char *token;

-- 
2.53.0

