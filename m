Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EF5C44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D9E010F3F1;
	Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pT0OoEJp";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE3A10E29A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:47:32 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc891373e0so28359825ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783453652; x=1784058452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MurgedTImf2dmSaSEEivYoY5j30SVqg6Is/CYFnqB6k=;
 b=pT0OoEJpVs/vqCJllNkPFjOcESTuWYdGWFCGsdCemP9+llP9zceihiVKaMBtanLaeL
 57sI+CNyZYIHaDtJfh9Hc+WIYutNLbgVviIzbPAg1PIiw7xYCVnzGyCcL3qrt5YyWPq0
 ZBznLkUISlZezrno6nGObM1tkaPl9yxsBXFQff3Gyk6G79JxmxlmLsOKYWM34o59euSS
 c9S6sKHKotCQtW1F5n1W4dwMcD+HN4noat4aMpz302JbSE6SvLtHQ4uSB2IHOGS1qyus
 80OTA9HVdG3INdZeptnqQJepUz/DVb4yJZyMcQKTZIqfV+08TyLLvO74euXlX4DkvwRd
 Zsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783453652; x=1784058452;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MurgedTImf2dmSaSEEivYoY5j30SVqg6Is/CYFnqB6k=;
 b=WjOHsu7ZS71B9L2uyr7gggrbek75rkJpA1lDZKj/xhIjnPEkhmyVqP8MUUtszlwcb1
 XrUFrxQ/B5Ffkb85zigeL5Mk28OpnAM4Irix+JDbs+XwWn0KKsSGeYZVKiUpwVS/hY2c
 gXEWlWK+aqJtaPSgK+/O8KkSMh1/BO7ZihxUbN5/MNqvEp3BlpgiFirJt+bknJDXuVzS
 p4vXHS3igvqBq2ke/HfvHa2b9gVCakXAXVnO9t1te6tTW/fzPK9F2CMCg10aKE1bNAT8
 klhgS6Qea7rjKFcrJdS7c3p5lQdHwIHf0vz5jSt1RGzcGnD9BPHIcLB+ZsqftUKwDxOf
 LpaA==
X-Gm-Message-State: AOJu0Yx+FYkI7z1ll2PEveyWTaGegDDDcOaNiz3CfhsOJqGHT/ueqgNg
 eYRuSdL57jVdbQDREKtA0fOvBp857uAw9Tir0DafCcXdjPFq9VGUbwY3
X-Gm-Gg: AfdE7ckfzLHvUC+Az0tyQBunTWzPWEJkWwcTIAJexzapojicNZJ2ryqkkIN2rv4eC4R
 Aa0AAo7KUS2CiBpOIUfSN86dIDku5RTqNeBL1T2OFVMfcJyPBdeHy/WXtFtxCW4nNFBKHcRrt9/
 11vGsOUF8Vyawtg9ALw1VQWWQjEhuzmA7Jv8JmxT5Nf/jJoc1mrYyoBTzfx+cg6JzJHwVbU0HXY
 P2tBnkT8IjO88+yMW50FXejy0a8SIr95JTYEOcGLUCigf3LBDMi5FJIYHpbswuhvXRLIIrXowwl
 jlLThX1LzmaPEjpwcQNY8ueGAM6gSCm3mfQdEdVBW2SQ2hd65+T1bIIT2NKVOtxTuuiCe/aviv6
 m9vjbP73x2FNN/4+OuezEfwwpTFoSCb8nyu+K1ULQ4IOwex+XZOVtzhSXGRmg7AG+M6AR2lR1H7
 7Davf+oeiv6S+bUPakJB4aVXtFjkJ4gK9t349UiFzLwbyoY8gO6oIjUrvSdv0=
X-Received: by 2002:a17:902:ef44:b0:2c9:cf62:6f61 with SMTP id
 d9443c01a7336-2ccbe616252mr63274975ad.17.1783453651528; 
 Tue, 07 Jul 2026 12:47:31 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e0c4sm17270585ad.49.2026.07.07.12.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:47:31 -0700 (PDT)
Subject: [PATCH v7 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout() for
 ODP faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Tue, 07 Jul 2026 12:47:29 -0700
Message-ID: <178345364975.660027.8790629832830633290.stgit@skinsburskii>
In-Reply-To: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/infiniband/core/umem_odp.c |   18 +++++-------------
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


