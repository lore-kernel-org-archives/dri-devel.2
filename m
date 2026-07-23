Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6654C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7ED10F1B8;
	Thu, 23 Jul 2026 17:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GGR5f6Zr";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E7010F1B7
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:36:55 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso969626b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828214; x=1785433014; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hwr2PA6k/yzOHBkhyRcV60oQVyvCsFMHOEQ+QEbH+Ag=;
 b=GGR5f6ZrpEI+Q5fY42W2c1c4S5ZLLZ5s1pld2eBHRo/Dj1SsWu4DdJKnYyPoAaBx9e
 kZa0MNGPCXA+p2jTiBkYogfNKmZP0UCX0Xat4EJqf5hyOxjuZ+D8KWw4rW/Symb9CXlD
 g2QJRpY5yn7On+ArcfJRZZnlA69aQdIGfXyzTDInPBUnR/IF6W2O8X1HnzZwC2KCnBFt
 czS2SthIQj1XCqGbKLqhHnZY/UFdjreGZIputSJv0S+JpGF69YQrZVR+RqjaXDVEJm8b
 5129XyavmVecfMadkmUQbFkDKLbgkBvQhnh9aphpUIOY6obmLLTrlElm717auvPQnL57
 pjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828214; x=1785433014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hwr2PA6k/yzOHBkhyRcV60oQVyvCsFMHOEQ+QEbH+Ag=;
 b=pyTIBoE3zDrA4rJOPTVFlEllnAXx5NuQAw/82VNRJ8j7vb62cn99ZuVv7jD8d/Zcl7
 /XyH55n+LBViVuru3pxiM3FkbhdumZfX94TeQfz6w84IwktDsSm/OYbgbkhLLTjDMYvi
 aClI7JTxZnCFlyfCZHdkEY5qP5KYZIv0cSqiYtv2xgaDlKK6jnDjVlctwy0gUXZsG9Ly
 DZ99xuBVrK2Zh+4IrT2CM9DUggZ4ig5+XP22+N4zqb2MGjPtybMKvzyqMbPyw35OmS7Z
 xyATTEwppwRDNraYubI1LIQVLdMYGs9SWX/Go2eqtpEAINVlT5L+eqrPNaxadMufQZ+o
 at8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUiO5+lnz4EMapmJQpW0KjHxb3AgT5vYLPURxegcubul++GnrC0w88JG6+nwkcSi5sRPZZ8/DX7K8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDW6f0JvyOZQ5IwBs5jjGT94MT7B6hOfsaEt1Tv90HtlgbgRo3
 2+X9Xj4P5ZVumGx7BnRmoLLE5rbu32d2XKM1sA5+ESFMG1+1a4XYNfMV
X-Gm-Gg: AR+sD12HvBAAXoNkOqaExDBY4J9gyaKqmack5q8moS2EXrgS7AOZi0VBKmscl7YYkj+
 Gtvp+hYMhCNyUinArR7XnnTyD26nAq2om8kWItbuSIwTZMSk6Vy5cLJtRvaGnK+fMBxQNo/5Q5w
 Rb0Mh5ZnVzyvkM1hA5xRkTjLFm79BwVY821v2O/fxtPR6/zQaXbd4UbtwBqxvD6LftzLpPQxDA0
 yMLoymYiaXavvXQnsRRCXv0rVGIyNDDTTzpEIw1D0bGRajYNaAujcs8xmRtHZjnetFfwc8XnWqi
 cuBj+Cclu0DMrPxAkpqdvACaxizyrSEK2E1j7ikk2sM8Qr/lKsgVPVhRp2N06n85/Tqnf61SguK
 Ba6HpbETPHzl34cEP+pPgFQUZhx4aytJa5sFF8SJ/K6f0yt7/MJjMY9CvV64mnDe6hOQugJasX6
 pwXBfk2xUZnIAPk+0ZjBAw8R/jmjFPAgtBzhPvIY9P3CONYkUa
X-Received: by 2002:a05:6a00:e88:b0:847:b16b:46d9 with SMTP id
 d2e1a72fcca58-84e2b8aa77bmr4617793b3a.34.1784828214639; 
 Thu, 23 Jul 2026 10:36:54 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:36:54 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:38 -0700
Subject: [PATCH v11 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout()
 for ODP faults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-6-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
In-Reply-To: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Oded Gabbay <ogabbay@kernel.org>, skinsburskii@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=2457;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=wCDSwsZ/5jgwWzEqFja4q7w3SxWPNbitK21qCohy6H8=;
 b=gezzOLTGQ+6T3Wy5w3nFtel93rrT2Kd9eeZ0n6f5FEQw8Beb0IrNif+mDyjnRhH39tdmJbOsG
 yXEZFknqYwdCOt8awUKVwHYE2B6xTW+3MpwtLFeYQDVzLwrWkfuTvq6
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=
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

ib_umem_odp_map_dma_and_lock() takes mmap_read_lock() only around
hmm_range_fault(), then retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT
expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
ODP keeps using HMM_RANGE_DEFAULT_TIMEOUT for each HMM fault attempt,
while interval invalidation retries continue to be handled by the existing
outer loop.

ODP still validates the interval notifier sequence while holding umem_mutex
before DMA mapping pages.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/infiniband/core/umem_odp.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 404fa1cc3254..9cc21cd762d9 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -329,7 +329,7 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
 	int pfn_index, dma_index, ret = 0, start_idx;
 	unsigned int page_shift, hmm_order, pfn_start_idx;
-	unsigned long num_pfns, current_seq;
+	unsigned long num_pfns;
 	struct hmm_range range = {};
 	unsigned long timeout;
 
@@ -363,26 +363,18 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	}
 
 	range.hmm_pfns = &(umem_odp->map.pfn_list[pfn_start_idx]);
-	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 
 retry:
-	current_seq = range.notifier_seq =
-		mmu_interval_read_begin(&umem_odp->notifier);
-
-	mmap_read_lock(owning_mm);
-	ret = hmm_range_fault(&range);
-	mmap_read_unlock(owning_mm);
-	if (unlikely(ret)) {
-		if (ret == -EBUSY && !time_after(jiffies, timeout))
-			goto retry;
+	ret = hmm_range_fault_unlocked_timeout(&range, timeout);
+	if (unlikely(ret))
 		goto out_put_mm;
-	}
 
 	start_idx = (range.start - ib_umem_start(umem_odp)) >> page_shift;
 	dma_index = start_idx;
 
 	mutex_lock(&umem_odp->umem_mutex);
-	if (mmu_interval_read_retry(&umem_odp->notifier, current_seq)) {
+	if (mmu_interval_read_retry(&umem_odp->notifier, range.notifier_seq)) {
 		mutex_unlock(&umem_odp->umem_mutex);
 		goto retry;
 	}

-- 
2.43.0

