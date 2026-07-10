Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC614C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1DD10E7CD;
	Mon, 13 Jul 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BN5435Am";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF0C10E25C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:27:08 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso13433765ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783718828; x=1784323628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rz6324+iAv2KNy97kcq58R5fN0X8s7ommcJ7e4qhr4M=;
 b=BN5435AmMgO+RYf0Zl8r1Ftw+L5ZRkvq45wVmg8MJKcTMJ0XUGb7MOw5n72MyYKFtR
 nmsW82TDdMhwCc6KUxh9TPvuyc6a0MGw63emJg2wLG2M/wG/fzgAtx824tq6VNrR4sJE
 VjtYRppT8CbZmFQyeh8RyQxGr4Y/rc4EMUA5NoNMKnm2ytDP2VO8KfdgzVUcjRDXIWuj
 /5ATLHbVtcbxjTkTjY3JiSydsYZBl3gFpcsnUb84hOoFi6iZxrNYTfeWbVJHIabktAZV
 ln/ZyIRS2NBWUwbkUmpcIcZGBo5gJ+srVpqFgbCBBoiNni6D3Z3JlbqA1YOKcEZkplUw
 0XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718828; x=1784323628;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rz6324+iAv2KNy97kcq58R5fN0X8s7ommcJ7e4qhr4M=;
 b=MKTFaLYf/9/w8RMA1QalUwY5veglhL+zQWDMxxFjIGhdT/jpMtnzC6pcWTx6rPYglc
 sVYE4Q3rjECUhhXbZwIOOAcvST8wYxjZf5taYytsU7B36qZ3jz57exIK5hrHOISl+qBM
 WvdRo2ptTzCVLKmEaO5c7LdWX3rWoVgMtlHxSRJZnLep/4FkeML75DwQJRq3B8vU8Wg/
 zTg/CutHmjzfTmAT74hydSHF1qh/+tmEa0eUsNq3vVJi3BTQSU5i5fSJhk+8VqvlLXL7
 EaBaQuvZnGV+xVX4dBypzvN9ooI7x7NFQsd1YcoN4kec0ZlQBpMzcDVmlQldEZMm0jFg
 c6dQ==
X-Gm-Message-State: AOJu0YwRL0/6S+m5FXUbbJgBKIfgeJ0ad+0NtkwWtR2YTJrcjkCO1h1I
 onX1hNZDy1vRagQ+b+yXfUdcm04wwS2/Jlr8mo+qsQCaF6EMMnSQj5E7
X-Gm-Gg: AfdE7cmtKPDpQGU5N1SqLc3iML98uvyDwOLGR3PAByMhcka84VjOvZi3z98r1JP+vul
 VUOfFONAQg9vC6NMjc23++gUAodQG1SJ38CRXUZtRIUrSZ08RiAqIYWESV4KfdtTOOvY+dM3zVm
 LE4p1LgWOmaANQBI47WGim+o5eCsD0+2Y9FQ2z1SeeZ+iNEgfIwk0TjxnrUZxotjgp+TljqkKgO
 b4gcgRY73hHLUxs2IKwrDPLqBSQ2+Frg/WSr8l6SyFtZgYyIoFzODZSPAsqei1j0qC6h5lho5KS
 6r6VxxVa6++scw88tv3DrPkEVFh7n5zibd8OYmyvrNlRC8ac3vtmnPWRIsia9Ab8QY5U7mXtr8n
 0MXe5CIPcD2vKlRI6bkBu+XQN0pGhlW/QZy9+GR5selFQtQdNS3Mjk3tURBuma400txceQMC/eu
 TgBkWZgnyDf1gbg8TgnQy5m7ML6tXcZfNRpcm/Ud52zBkhpYhiG1nIqxYAVMYDAu0uP1D7Xg==
X-Received: by 2002:a17:902:d98b:b0:2ca:1bbe:c3d0 with SMTP id
 d9443c01a7336-2ce9f3d5e4amr6769265ad.43.1783718827906; 
 Fri, 10 Jul 2026 14:27:07 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bd33sm65951165ad.58.2026.07.10.14.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:27:07 -0700 (PDT)
Subject: [PATCH v8 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout() for
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
Date: Fri, 10 Jul 2026 14:27:05 -0700
Message-ID: <178371882559.900500.4008217424194230517.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


