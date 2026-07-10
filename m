Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC75AC44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5801710E7EB;
	Mon, 13 Jul 2026 07:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4q9/KeL";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AAC10E242
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:26:54 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cad8076b01so16881505ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783718814; x=1784323614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3sr6piRbjR+cpoS2FsjQdy3tGYWA8BG46QjFZOECUzI=;
 b=m4q9/KeLLj66VpZ5E4X3tnQjylTiQmuIkPaix+ZLx2NVPrwk8trK7c+gWz9Fb9GJQp
 UlT7RqabOC9BHyWQ5nbHgTmR4Imp5ltKbRVXNjwLbcqEZAvjiEKrvVXK48i9PG/4Fa83
 JiJ9QZq/tfCkyXcTZwyWTHMx3k2abo/q5lzkvVuSnr4Ik2Bjxf7OWBkGO3Pbt+u+40qf
 aJKePkapsdmj6k4Ir9S1+Pf1OAdlIAx/FdySynEONIELb4GIY/eNfP+Q/Rq/W3xUhRzE
 +4iXW+Ozc7kf8ioYti+8TqekDgL4NX6SycIWfwl0NHUSbzqmDcua+nchA683rL/x0RZa
 n43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718814; x=1784323614;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3sr6piRbjR+cpoS2FsjQdy3tGYWA8BG46QjFZOECUzI=;
 b=R71FtKp2m+MOc7prz8CI3ou1FTMmPhObltTmVoGODvk/Xq631XeiJXDNfUvGsQDO0U
 UcMGzT8Q44mHOT3GCWoCh5GtSEqUpypjRIMWeNUnF2lD7101rmUP0Yeaw1rzzTk8s+Cd
 KMxez9p+Bh4SmjtL5dzbKwo9K0xtw2U0bjvG3jp8CQCZ9LAlPXPWyUQjbjR9GmU4y6FB
 A1QnioRYoYzODAbdD8eUhWd3zkhXfaKgJqY5ABr6Jg34xaCsC7b9FijTioSxm4q9urGL
 7dPspjbcu9CiuuRxQTj79AcSdiOVPoafBFA40JClGukucM8PqUFJWVoa8LI+swsAUjPW
 cNOA==
X-Gm-Message-State: AOJu0Ywljvs8iFzqizXl2rviXkSXKKquOh/9R75J4Di80wZ9OHUjvNkn
 L0fRIdbKMQG8lJa4i0dhmNcKFljiHzBsGjaQ8sA9qJuUUkjg6bn2BLlP
X-Gm-Gg: AfdE7clb2RCgEj8mg9kpjP3/YXSl3nF+hcd5ZUeKP4b6YeOm0NRte42xds9pnHoX8QQ
 ygDCuB+pyDwsDxCpFHLGvM+aL/lE31Evds/ElqtX1Y1YxfXtwRzCRjnSGy0bff3ix7qIJ6HGMrs
 9VHaU3Vf+IYoSXhm3HrmpsFWgKayaF3dUCd5+ZJHsr3cOpedrnXKhamGVOIUg1j/S381qtz5SV/
 w7RBz+JsrYMBRE8iCyp5f56oTY6qmVgBXgjNBXI8XfqOcGHD9GelcLsYHc2yNxQOZiB0VdyC7d5
 fcO4RKNIWTvz3Isl3eVpLevoFfbkpLR6Nh4mLeECVOxE8d9C/mhOcC1Xz7uKh1UWU4axRczuGWc
 nZlFh/Kyj1tUX0UhLcKmLNhFgARczNOrNbrhEy6GOk70HqK+4aZT1eAFfT49kT3DMrV3aLlmA7a
 0FngqhwbahRY0B4+Uk0bq/tQe9JyRfMAdqrfSIyAnN6gsu8x/c3fWLp1rgaHw=
X-Received: by 2002:a17:902:dacf:b0:2c2:7baf:139f with SMTP id
 d9443c01a7336-2ce9ef1bd15mr7721375ad.30.1783718813633; 
 Fri, 10 Jul 2026 14:26:53 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e0c4sm66015545ad.49.2026.07.10.14.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:26:53 -0700 (PDT)
Subject: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
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
Date: Fri, 10 Jul 2026 14:26:50 -0700
Message-ID: <178371881034.900500.5214601525971121683.stgit@skinsburskii>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
 


