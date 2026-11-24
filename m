Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE040606A331
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTG23Kou
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED37610E27F;
	Wed, 25 Nov 2026 08:41:19 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C27710F0D3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:29:10 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-996eeadfbeaso2866012241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795559349; x=1796164149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zrnW76Gzs90HtZ7/PtOyDoPE6/B6VxQRo6W3vp/Iitg=;
 b=vTG23KoudKMZO3eCl2PLP+rpkt9ptaH/VCLcSHUaWD8fHon+/0qeg0H5B7EjZlHgFf
 x6+OkF5l0+9K3VszJz0Q8wkpmevnz+fbF8Ko5Fhcead0f/r8QU4qKA3ON28doDQlvTVT
 uS4GciDdAOzOuzyv1HEiN32xZ+VNiMCpykxFukXFDPZQoicBquGUDaFeEgeOHBzDjz2Z
 oltesgPZ1dyrg2mESuS7felz53FCbbOsZst7GHKQcPB0anVGPWLRMhAaeXX0+yindYTT
 Dd5OfTCe6BHvRDOP+pgdqrMxL+akYyw4C0KlQ18FOKPe8K04ApLP3SQ/OO1IMx8i/fI4
 8J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795559349; x=1796164149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zrnW76Gzs90HtZ7/PtOyDoPE6/B6VxQRo6W3vp/Iitg=;
 b=1rRn4iVb5RMbm0/hQofGhaBdczGRkbKLDJgIFnfAzww+3jANQlTQ6bgWgYXPBVx+XN
 1A+by4VE39PBOyctE0FPXcXHklMIJGV5BgV4tflFl0NaHOtSONnvyeJPgc0nIt6Aa1KW
 AN+BrolhPhXNWKzsHIwxBhja4LXE3Wd+Xx7fqTmRABJMU1meq/8oV4uO+yIL2OLUObtB
 pRmw0HUhV0pfrOHrqoEoZEaQfi1Aq0AqLBas7piY47O1VuBN91rXYF91rO371UxaBgTH
 WT/J/kmyFqBHC9LMacHQoTKDntsR5/4eW12jAym55uHgP0S2njEAzxCso+ocrkCNOCx+
 Kg0w==
X-Gm-Message-State: APuU4Z/EfNTxT+pAXeVKPuBT9AO3KYPWGj11+SRm7kUR3PRZElRgg0pN
 3SFDxWGBixz0uO+jUe6cv0ceY8uVS0S3oTVqfMnox+ICGTx7lT4ruDdC
X-Gm-Gg: AZFdTZcuoBwo2S5Np7I8zwU1xe4Tpn1+ymWo90ikK9IeBsP4/T0ehrr+Tllm2FNYgga
 5ROLLMFP7+fj5X3LrciZ//SibSwPKGeZZZDXoqNiTte45F5FTxnfYxzs2Ffdw5IxcZNLl6AsO2y
 eUT+ovtoaR/EQ6BBF3gi07nCuYZtR7/z+lgFMWsOSjiHSfCuTnr9lbNgn6D/ZfHAlX//fOJ6eyG
 47iMFe9cLagr9JgMUDD88bCYWEr89fPKk87YO5xFkIVxhoNEna16IGCMiYQPP3UA2hWlBToB66R
 cLOm1qfWY9kgvHRDx+8oFOvBX+bHBfxMFIB8uYrvXBixQf1Try7qVfBphCqapfwEXPNZDhaBe2L
 rWCcAU84l5MatFUp7xMcpcL68XYt8McYpDtNmJp1Sz+JKV9y7glxaNDwwoqpRJOOjv4B1Ccaf/n
 +dTUxWbXwRroNo0OSHuRx7bPVavdm7Puh7eUu6xeZss5Bqaat3wNQWzBQYDC09uYUPGvsALMqpm
 xRpjbykguQ4LJpRzlihdiO2amQmdhWRlCg/aNOMYUq9d+y8hLPqbE62ZGatgtYGL5bOQ9YVxbPf
 kIBI2bxO8aZKM9hz6t3zRBvIAY1uMOTj5qZq6mmo27Fj
X-Received: by 2002:a05:6102:3e8d:b0:7d2:da60:d0f7 with SMTP id
 ada2fe7eead31-7d73957a273mr8934345137.28.1795559349456; 
 Tue, 24 Nov 2026 14:29:09 -0800 (PST)
Received: from eduapps.lan ([2804:f04:9074:7a00:92e6:2643:ce63:2792])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e822a085sm16403831137.10.2026.11.24.14.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 14:29:09 -0800 (PST)
From: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
To: nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Subject: [RFC PATCH 2/2] drm/ttm: retain a reserve during idle pool reclaim
Date: Tue, 24 Nov 2026 19:28:12 -0300
Message-ID: <20261124222812.511867-3-eduardoprocopiogomez@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Draining the idle pool makes the next burst pay the cold allocation
cost again. Retain a configurable 128 MiB reserve per NUMA node, capped
by the node's existing pool limit. Reclaim under memory pressure can
still use the reserve. A zero reserve restores the full idle drain.

In QEMU, idle reclaim reduced the pool from 768 MiB to 128 MiB, leaving
pages that the next allocation could reuse after the timeout.

Signed-off-by: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 6af8a9c89..3aad264fa 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -38,6 +38,7 @@
 #include <linux/highmem.h>
 #include <linux/jiffies.h>
 #include <linux/sched/mm.h>
+#include <linux/sizes.h>
 #include <linux/workqueue.h>
 
 #ifdef CONFIG_X86
@@ -141,6 +142,11 @@ static unsigned int page_pool_idle_ms = 5000;
 MODULE_PARM_DESC(page_pool_idle_ms, "TTM page pool idle timeout in ms (0 disables it)");
 module_param(page_pool_idle_ms, uint, 0444);
 
+static unsigned long page_pool_idle_reserve = SZ_128M / PAGE_SIZE;
+
+MODULE_PARM_DESC(page_pool_idle_reserve, "Target pages to retain per NUMA node after idle reclaim");
+module_param(page_pool_idle_reserve, ulong, 0444);
+
 static unsigned long pool_node_limit[MAX_NUMNODES];
 static atomic_long_t allocated_pages[MAX_NUMNODES];
 static struct delayed_work pool_idle_work;
@@ -485,7 +491,8 @@ static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
 }
 
 /* Free pages using the per-node shrinker list */
-static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
+static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free,
+				    unsigned long page_budget)
 {
 	LIST_HEAD(dispose);
 	struct ttm_pool_type *pt;
@@ -497,6 +504,10 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	list_move_tail(&pt->shrinker_list, &shrinker_list);
 	spin_unlock(&shrinker_lock);
 
+	/* A list entry represents a whole compound allocation. */
+	if (page_budget)
+		num_to_free = min(num_to_free, ((page_budget - 1) >> pt->order) + 1);
+
 	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
 	num_pages *= 1 << pt->order;
 
@@ -513,7 +524,12 @@ static void ttm_pool_shrink_idle(struct work_struct *work)
 	int nid;
 
 	for_each_node_state(nid, N_MEMORY) {
-		while (atomic_long_read(&allocated_pages[nid]) > 0) {
+		unsigned long reserve = min(page_pool_idle_reserve,
+					    pool_node_limit[nid]);
+		long pages;
+
+		while ((pages = atomic_long_read(&allocated_pages[nid])) > 0 &&
+		       pages > reserve) {
 			unsigned long now = jiffies;
 			unsigned long expires = READ_ONCE(pool_last_return) +
 						pool_idle_delay;
@@ -524,7 +540,7 @@ static void ttm_pool_shrink_idle(struct work_struct *work)
 				return;
 			}
 
-			ttm_pool_shrink(nid, batch);
+			ttm_pool_shrink(nid, batch, pages - reserve);
 			cond_resched();
 		}
 	}
@@ -1040,7 +1056,7 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
 
 	while (atomic_long_read(&allocated_pages[nid]) > pool_node_limit[nid]) {
 		unsigned long diff = atomic_long_read(&allocated_pages[nid]) - pool_node_limit[nid];
-		ttm_pool_shrink(nid, diff);
+		ttm_pool_shrink(nid, diff, 0);
 	}
 }
 EXPORT_SYMBOL(ttm_pool_free);
@@ -1366,7 +1382,7 @@ static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 	unsigned long num_freed = 0;
 
 	do
-		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan);
+		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan, 0);
 	while (num_freed < sc->nr_to_scan &&
 	       atomic_long_read(&allocated_pages[sc->nid]));
 
-- 
2.55.0

