Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B9606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjjWPL4i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B7B10E5B4;
	Mon,  9 Nov 2026 05:55:13 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF6F10E125
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:55:03 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6774639a8a4so380577d50.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203702; x=1794808502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w28YU3TcGbtifUArrQMyr3dsAatXtLgdaewuzdZz0ZM=;
 b=fjjWPL4i5o4hdsZYcHxquk1+l9fxMbd3UrdgkeVxeX0U1IyKb9ptgtnEraLUUowJg1
 l0+4noH/J/Wa7bnACARQmtfhDYf4NCuHQTNHrObl/4kUvfJ05Yany25eR2IssrHE4dsp
 BOn4jckbiARHNHaoHimCG7PVL5V8sf5sv0vYmdDuWG4XGAzai0kMKiFhIrMrrt5GdH3J
 vnnugsFQrArce2v94E5VYPXhZiXNL9im4oxmqlqIld+zXecx4A8Nq5DoGMmzEI0xpzL4
 ux0z5nZ5+AkcvKk58QAAucvkIy5JSrA0Frpup0OQEriF5rYn89Ao+cDW9xyAaz0rdwjk
 qdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203702; x=1794808502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w28YU3TcGbtifUArrQMyr3dsAatXtLgdaewuzdZz0ZM=;
 b=FyuTKYdxzICcoop40x7pYFfQwp2qJhmfYbXWOmQp+2Eesb81i413efyfTfKfV/zpvW
 czP6FaFC3um8A3tcDe7olH1xMNUGI2/CfLmYHWHVes8OlgH+/rcMSVPu0sNxT2+by5W0
 G+5rA/UOYP72P7O3HbnXPnGCQyS8ZX94PQwjVSrPgHy8OExymltDyD3aFglL4PbI3jS1
 HslHs8Ze2gA41rkNondWrReSEu/jfco6G3s/q0KuPWtxd4oRM85JnI39nt0nv2M9jClE
 Woz2PUA3bDgcBXX4xLU1Ri2v1bhQqJsMhkGMu7WXXdfCRfBBdlC1WdeCc1K8uq6Y2DC+
 LTFw==
X-Gm-Message-State: APuU4Z+BfxKCdgShpBcdJ8aIqZPjX66+Nca7ddCXTZr10uySaXUI4Nk2
 lo+gAQfZWL1aj6Qh5N3idtxvl9N/gBkhtpks1gXBSApqZCKmIsGQZpLNdZLYo4SV
X-Gm-Gg: AYBFou0wyfGsU+84d3NsSF3r16znEmWBwOGerLsDfuYZEUu1GjJ3ZhuvnZLBFFIdMvI
 G1sZYX3odObRKCiHFQRP7/xX2aZTwlXdbyFbvHottOLOoyAbps8iyqkP0Va1k2j0bT11dx+lDCX
 8/cAOyNnvtZAm1MAAjWjXzWd9PBHEzMOMUCsL85oah+4dRBvwHmw96Q4YFG3LEoabGyunHkX7Ck
 TuHT3NxrTL4WJFbopfhgjVLOPJPQzHf7+4+w20/a222m+BKZ3Ljb17pcfLZn8A6VMWq6FojfhLp
 dDyy+JQs+sZMJ+GTuo7EIvKBYcNZHGviM1fFAnsG4GSVxBoi3BZcBUj66GWW3ZiNGQGHLPnnjkF
 6NPoRF2LsGxItkt7OU2KV8WEW97N2I7QqP5SsP4i9YtUQCgQq+odIfWqzYFIx00l1/KxyA7pRK4
 6Gc6FfztfxAtfhjsoUTg85uMv82avzdiP8DMQFZH+7bX23TZqQ67F42DzD07Kdgh6tL1zfCAwfn
 St7J4deKxtHYV9QUXZw9HjVO/6PqiMk6H3x2z/DKWC00Aad7qrtLoX60Zr9SwGNau2pGtevXhy1
 adknt2bl1CsLhyRjIN1g7VPtQFfxz6E7C1IXCGJN/Nj6P+X2xL2M3sncrOfN/dVnjzE=
X-Received: by 2002:a53:d807:0:b0:67a:8c43:753 with SMTP id
 956f58d0204a3-67c3da9cb86mr1358648d50.97.1794203702385; 
 Sun, 08 Nov 2026 21:55:02 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:55:02 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com,
 Gabriel Gama <operatingsystemsdepression@gmail.com>
Subject: [RFC PATCH 3/6] drm/gma500: Fix SGX page-table cache-flush mapping
 lifetime
Date: Mon,  9 Nov 2026 02:54:47 -0300
Message-ID: <20261109055451.17458-4-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Flush the modified directory entry before unmapping it. The old order
uses a kmap_atomic pointer outside its mapping lifetime, which DMA32
direct mappings can mask. Use kmap_local_page under the existing spinlock.

Also calculate the CLFLUSH iteration count only on the path that uses it,
avoiding division by an uninitialized cache-line size when CLFLUSH
is absent.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

---
 drivers/gpu/drm/gma500/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 4fbc22a59..34ae0f125 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -265,7 +265,7 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 	struct psb_mmu_pt *pt = kmalloc_obj(*pt);
 	void *v;
 	uint32_t clflush_add = pd->driver->clflush_add >> PAGE_SHIFT;
-	uint32_t clflush_count = PAGE_SIZE / clflush_add;
+	u32 clflush_count;
 	spinlock_t *lock = &pd->driver->lock;
 	uint8_t *clf;
 	uint32_t *ptes;
@@ -289,6 +289,7 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 		*ptes++ = pd->invalid_pte;
 
 	if (pd->driver->has_clflush && pd->hw_context != -1) {
+		clflush_count = PAGE_SIZE / clflush_add;
 		mb();
 		for (i = 0; i < clflush_count; ++i) {
 			psb_clflush(clf);
@@ -331,16 +332,15 @@ static struct psb_mmu_pt *psb_mmu_pt_alloc_map_lock(struct psb_mmu_pd *pd,
 			continue;
 		}
 
-		v = kmap_atomic(pd->p);
+		v = kmap_local_page(pd->p);
 		pd->tables[index] = pt;
 		v[index] = (page_to_pfn(pt->p) << 12) | pd->pd_mask;
 		pt->index = index;
-		kunmap_atomic((void *) v);
-
 		if (pd->hw_context != -1) {
 			psb_mmu_clflush(pd->driver, (void *)&v[index]);
 			atomic_set(&pd->driver->needs_tlbflush, 1);
 		}
+		kunmap_local(v);
 	}
 	pt->v = kmap_atomic(pt->p);
 	return pt;
