Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB98C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECD610F1F8;
	Thu, 16 Jul 2026 08:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVhHrgaH";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4048810F137
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:16:40 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cad8076b01so69397075ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784139400; x=1784744200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xews/oLHPsdqsmPpn1oXU4/lUwRmc6mOTrGvCA27l7U=;
 b=cVhHrgaHhTNMpKyPxASD+efk7INLNPehfUrpBdOlYo06M+zQo0MT+XGbs4Yuaw2o4f
 JpMvn7qiWZZ0FRmkVAwZ3NZjTC3YgeuhI8leRDk1hB4qjMH3t/C5vco69z8OPAuV0kmj
 0C59Viyrq8/keiY95btqT2idXMc7bUwHkd2lNzPiZeGaiMdE0WlvUg8ab2JjulOEBaTV
 GZUiCUfxGM7EndgJcUeaJaku47X6EGojUdE5MfBZ6qX6yqG8RrZEAjk04DdJQvTwd1AE
 2kblR0X8jm2pr3mN2XxfM+RwI5ALtMVhSXthejitpslL7kx6LPuqTI5CvSXxY8TE95Uu
 PGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784139400; x=1784744200;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xews/oLHPsdqsmPpn1oXU4/lUwRmc6mOTrGvCA27l7U=;
 b=MgzcrcEZu1cXKLXCN0swElM4OhZxrIPONWEqYRMI7OZNzLfJKFaWXoITJAlItdL8pY
 CzlbxqDRFSJdah+D3s0Oz1cjzXAJmQkDpOnF+Grh7KYOvdvmjUSe+Wrqc7xWCslo1Aic
 fwxlhfds9vgk+7rdjmOmzY/RypKsSRymqpCNylS9APyUEXtuJIoZNCEAn8F/zJW34+Ct
 gD1RJbJWkQGOBApIp0CB+EkSQVAx+VFYnREIkrzY5ibfUoTp1zgC4SBSlBxNiAYaRMA3
 pup6/c9JmReaWQOoF0I5Ji/v2ZmoPR+7A+5W5a+taQN4Er6Gtc3a1835Eb9rOXdYCn+c
 Pqlg==
X-Gm-Message-State: AOJu0Yysn2bXQ26mDMTYAv2FhqrpZ+8GDnmP/nEbTc2TCH+twY8ybhKa
 PBLMI4kI29luMAutD+ldMNOZd8JEMhX/OGIQZtkTUflGogJ6OLUZvCUNWlo50QLe
X-Gm-Gg: AfdE7cnHXQhvZzhDUS0dNM7bgYhmO26grQKqpFGwyXM3Onv0KSJGS9i3L7ewQTcVGvR
 lIy8+o5qCzD27W745OiA/QvzeMA88vUfauLMqlEsarQGhqbz2hGw6iWRdzfpr3TOo5yUk3QR269
 rGeN91Qzb+9/JgzrFUXydAtNUKjXGjQujTDj9MIWToERaK/4EVhgAsgkcOynXqJoJGS+gKpRokg
 XUMkl8L5Rm2Jp9NkdPcg+grUGlLQjSn7C6T846Yc9vRJoYVB512JKaAkNvt+tzeU/8P7NOdlkGM
 jGNMIwE7+n0vkWNYsXVX2AAyl3i7uR9eJxmDBc2rF2v3ck0Y5viukJepCgEAi0u+uH8fx6YeWIl
 1q4+VfhsbtX0RQ0ZpBDUrdejAzuJ0ZUiA5NNfnjqBVs/L8jGRls50nnaCtVPcEf5A7dusEGCWiV
 LR5GPBfhxFhs48SGO4nRGdm8EaY7YJ0SR2C5QjDZyNqum9YBj3fdmCwlN1Bno=
X-Received: by 2002:a17:902:ccd2:b0:2c8:4c29:afeb with SMTP id
 d9443c01a7336-2cee9a64cf7mr89372715ad.8.1784139399557; 
 Wed, 15 Jul 2026 11:16:39 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10592040sm6621985ad.55.2026.07.15.11.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:16:38 -0700 (PDT)
Subject: [PATCH v9 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout() for
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
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Wed, 15 Jul 2026 11:16:37 -0700
Message-ID: <178413939750.1155966.3639451690646685854.stgit@skinsburskii>
In-Reply-To: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
References: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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


