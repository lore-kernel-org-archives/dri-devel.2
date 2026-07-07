Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FCCC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223D810F44D;
	Thu,  9 Jul 2026 07:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqovxpvf";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2749910E29A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:47:18 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-37df72c9984so4575685a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783453638; x=1784058438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vfGwKSNbrl+nU6kvbTrSHfyfMmoFAmwmGff/pR29LWo=;
 b=kqovxpvfFytLIUG+rYvkhhW+WwocNELx53R4Yx/1VcBEC5Lc2bnU1cNimVbVFOkYQW
 /8XzWeMVxzwTjOLJfRC1C0GRwaSGOdBZSetBUjlgCgUs5ULnpgc/rcEP9sNfMH3ObUap
 lFH2PFxTRCp/bgKNlqNlC8TxmYiF2MVVZZWrvZdc9Jpm8pKQvOhmzaMksw8qC////P92
 IuAPMC5QNQ5pGtCSbCjzWCT4CIbzPFIG9vAqzJRBdi1z29iEaQCDaMtv6UuSzq2RPRBk
 B7snXnB0Q8IQgcs1FE0jAgtSXUEVYiA+KmC5fEEhIcn2J7XsALcgP0Hc1MHCz3cJE/Qs
 He6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783453638; x=1784058438;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vfGwKSNbrl+nU6kvbTrSHfyfMmoFAmwmGff/pR29LWo=;
 b=i2xciUB01ni46XYbVcyBVaYshUbiV6/1uENglri+MXVtFgAmM+kWXtSNX4ns8jrcFI
 p0zxXd7WKAr0k2SjIN4iYvxEZpqNyLRN/jYV5RMUgnIBvmG/DO65J9zr4B8ArV8ptuKn
 6awkkSNs0WU1aDuLlVOO3MWj1NuSyJ/sB4JHBU401BvTz5mScrXO4J+LEvPOJFJNX0ap
 n6iLMq3Q5Q4VzHQ6o+yKM4vPwrP3mtPpQ+H9Dpxf2xoLPGC7m1KgjoSqOVYscJExX1Lp
 hFlAgQv12Lq4mBvYqa2uDyvrZN9otpYxGbusz64OsobWadCwoYs7l1DVUWzEHhGG12gZ
 tAdw==
X-Gm-Message-State: AOJu0YwBvk3W+9rUCO5BQrIgc4kBnXcxSQnZ41eOPGaQPezlLjK36SRc
 NJvN/SxVG7Nj5FdJqQAxjA8/4MVtvhwPlBr/2gi/JPOCjubBAjhTj07Q
X-Gm-Gg: AfdE7cmRUw2LoKiUBS8QKNn6lh4dDZqXdTYJUoaO0PtP2JltozxXDwjcL4d3/Upyds8
 yqFi2xom+hNyyBz/ig8+xmLAILyl7kpl2q3Ztb427ifAAR1HcQ9ZxpqK4MzYXaosNO1+QpURPjs
 HnYIp4LU3fFVz73/MxuoH8CuaCgjn0vgcf+kHCZTKkrkIQyGpVwPSppzqwicJ8s0zR29o7XHKEX
 khhgXrXuI8sdYQK1FQppPoW+b3tFjk68l9PRMLBWZp+XlxRDlriME+0y9vVQ3yZyRLPDF1nBeat
 Lg3iNmzq0/b3o0oAjs9PmnoFYGFo3Nl7j0mcLrndX+L9phFGACNenz5YJU2rsMawvjxetWlFmYk
 WYqYRC2WX0q2A/+tQMy+T+qe871H0PQJvzDFMHcmv2REHtVhXvSxkGVMR1j3PfZXACBKXT17et7
 kuhOsf9OPuid++Sc+oFYkcNbOMB1en+hwZtszo5CdbPJjFuXcKT7beHyc5PfU=
X-Received: by 2002:a17:90b:2e48:b0:36a:fcf5:64d2 with SMTP id
 98e67ed59e1d1-387573b24f7mr6589891a91.16.1783453637572; 
 Tue, 07 Jul 2026 12:47:17 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d36675d5sm1660092a91.12.2026.07.07.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:47:17 -0700 (PDT)
Subject: [PATCH v7 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
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
Date: Tue, 07 Jul 2026 12:47:15 -0700
Message-ID: <178345363584.660027.14063544694872741718.stgit@skinsburskii>
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

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/hv/mshv_regions.c |   54 ++++++++-------------------------------------
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
 


