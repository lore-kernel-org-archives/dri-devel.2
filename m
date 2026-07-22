Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE18C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA7210E4F1;
	Wed, 22 Jul 2026 21:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pdbTk17b";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2CE10E4F0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:44:54 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso14253753b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784756693; x=1785361493; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3slUHnl834IP76VoxdiRinKrcbFYlUZTVsrXFJZ4JdY=;
 b=pdbTk17blbllYmW8bnVtEJK7XniQ6NX0h77nLKskDONm/x+Pjw/YDDPvyrht46ukVG
 Tno6a4rrsJD509NN1oighVQIEbSQo+AmNv53V0nXfTAD39tPyhJuFD1f4+BIVlgwx3aM
 p6bCiIX6Z9u8HyNCB///r0LNr0/xIzql8y7TQGn6mGa6XN6vddagMqdpjkQdIfaxEvVV
 ZGt/zhSBZdC+hl8VCQI/V1/0v38EchY/eHNyi8UIWFOYFAdHxpJigikReXmyvidBZ9SF
 umGJfsx1UUWc2b4cZHOrJChYy1vCLSWF0PlXSElNq1v0CsC0qwyb+RENcQGg9RNtpqw1
 CHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756693; x=1785361493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3slUHnl834IP76VoxdiRinKrcbFYlUZTVsrXFJZ4JdY=;
 b=WPSphPLTwfxfqCiMgslR2K6tzZMx2cBdY5B4KJ0naSGZ7XBpI1ZgVD6InnT9vhNaXo
 RGqm+SwEXarujTJMMm68yVd8DRVllynFr+Byog4Wzx/6G6PPZlVmLd7DrzAd7DbpcUdy
 xaOfDf8JHpKN3GMPoFeMQ3nVIKTB9P8xLICIYDKlXTCAIz7b8KLSsjwYDBX0ZAhadbxj
 Bag45WobMOjVYNvpxZm75FOtw9WVmgt4gNgQ+8k8mFEMDwLfyvLeVBI3ym7L8IayGAA4
 /wyDDQNsSGbZOylEJiaRkI/qakbqOz8Yuju3DQJJ3hF+XruXXOjY7CL0EtaHpMtkUmCq
 4cCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/vm4KlV+OApz0J+Ngn4dn8ReEIs7NjoR1SFIrZoWdNQt0VBD2UJ2CFWmbPr5p/iry1caFiIrI760=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrSZeX1LoX9zY/N7YpBZQlBVqA6HOBTUlRfuwnMMVDW375fJWm
 BzkR+nl5TPRGsk1KK2oAMBSky7jiXM/UiOL3nCpjtRQV2jqIO+jmNUF+
X-Gm-Gg: AR+sD10MvOQbkNcOaZUY/lmNSN58ududxpr2jnOv9QoyoTJGW+TlAJw+kG3h7H7VCkZ
 M6alsE1ap6vmU3pHeGjWDMM53jHys03KVtIFd5t0ki/okUqRAH9Yj3pQuVYl/1wBC8mTzmFzWmx
 Z5HXZ6RMkrxkj1svTA6keuk0F1IMkHmDbZaJ0wRRmwWKVmqPDq7qWjCjJxrQGvVqggfgE6lvkkK
 Fki7hGgHavRB102MMyeOcK9KPdQr2dwIJEPBlfznjUqUzj+KCGQ/62QdRolfiy7JEyUeYJ9JaSD
 5ZyfNK0IPl9gUhxSJm+kvGZhVKOfnzi0V0j9mTFEpTkxcy8DaiooxACeVfEE5ElTt5YSG2r5THz
 IbvFZ5P/DBUmDWbg5EkVq9kC+cEVhK+vlCBmgDyaxXDjP1wliMSXLpYXR2QhAilT4Aj1i9A2Whn
 7tgDadYjVCUTVevNlg0WuBDn2Sf7zF0dLmxikfUtnPWCHuzwxE
X-Received: by 2002:a05:6a00:4fd3:b0:848:3fe2:c88b with SMTP id
 d2e1a72fcca58-84e2b7f59camr674000b3a.6.1784756693352; 
 Wed, 22 Jul 2026 14:44:53 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e17237c3fsm1946297b3a.9.2026.07.22.14.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:44:52 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Wed, 22 Jul 2026 14:44:26 -0700
Subject: [PATCH v10 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-hmm-v10-v1-4-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
In-Reply-To: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784756683; l=3646;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=ZyAhBAfWZePcXjSsL7QqvsrSYU5bhX/lu/bgMYHTJjg=;
 b=tdDpNRsCNvmVGCNOZZ9HC3yxGmAH4ax4m27NmzACrsQovmkbRz97eJ93jI+rhX+xJ0J5zVBrq
 FSNwxKzSGzhDXRe3C8R+8iVP4estzVdVfYmBtDp3huLkA3AiN268Vyv
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

MSHV currently faults movable memory regions by taking mmap_read_lock()
around hmm_range_fault(). That prevents the fault path from handling VMAs
whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
mappings.

Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
preserves MSHV's existing unbounded retry behavior while letting the HMM
helper own mmap_lock acquisition and refresh range->notifier_seq internally
before walking the range. After the fault succeeds, MSHV still takes
mreg_mutex and checks mmu_interval_read_retry() before installing the pages
into the region, so the existing invalidation synchronization is preserved.

Fold the small fault-and-lock helper into mshv_region_range_fault(), since
the remaining retry path is just the standard "fault, take the driver lock,
check the interval notifier sequence" pattern.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/hv/mshv_regions.c | 54 +++++++++--------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6d65e5b42152..dddaade31b5d 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -381,46 +381,6 @@ int mshv_region_get(struct mshv_mem_region *region)
 	return kref_get_unless_zero(&region->mreg_refcount);
 }
 
-/**
- * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
- * @region: Pointer to the memory region structure
- * @range: Pointer to the HMM range structure
- *
- * This function performs the following steps:
- * 1. Reads the notifier sequence for the HMM range.
- * 2. Acquires a read lock on the memory map.
- * 3. Handles HMM faults for the specified range.
- * 4. Releases the read lock on the memory map.
- * 5. If successful, locks the memory region mutex.
- * 6. Verifies if the notifier sequence has changed during the operation.
- *    If it has, releases the mutex and returns -EBUSY to match with
- *    hmm_range_fault() return code for repeating.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
-					  struct hmm_range *range)
-{
-	int ret;
-
-	range->notifier_seq = mmu_interval_read_begin(range->notifier);
-	mmap_read_lock(region->mreg_mni.mm);
-	ret = hmm_range_fault(range);
-	mmap_read_unlock(region->mreg_mni.mm);
-	if (ret)
-		return ret;
-
-	mutex_lock(&region->mreg_mutex);
-
-	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
-		mutex_unlock(&region->mreg_mutex);
-		cond_resched();
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
 /**
  * mshv_region_range_fault - Handle memory range faults for a given region.
  * @region: Pointer to the memory region structure.
@@ -452,13 +412,19 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
 	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
 
-	do {
-		ret = mshv_region_hmm_fault_and_lock(region, &range);
-	} while (ret == -EBUSY);
-
+again:
+	ret = hmm_range_fault_unlocked_timeout(&range, 0);
 	if (ret)
 		goto out;
 
+	mutex_lock(&region->mreg_mutex);
+
+	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
+		mutex_unlock(&region->mreg_mutex);
+		cond_resched();
+		goto again;
+	}
+
 	for (i = 0; i < page_count; i++)
 		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
 

-- 
2.43.0

