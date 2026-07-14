Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4912AC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DB610F1F7;
	Thu, 16 Jul 2026 08:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oQ2otNgb";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE2810E0F5
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:21:52 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cea3004256so48377205ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784067712; x=1784672512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EUZJ2b06rpE59kyPt/lRc7T/ATHNB4Peeih6JEYSOE8=;
 b=oQ2otNgb7Og9cmM/XwueUjUQB69tT3PfCt4o3ayFXLcQivyjjqwxDIQG96fgxpaN7y
 Lr8FrR6O/DXXuDvg5Wo6c2njIOUDo4eN9OrMvslLQeC6kaZmgqS54Q17lEKUfZemRcxV
 Mp6+CHRHJ97WD3Npj0vnM62gkg0BJa0Z8LBwPmBpOgAAH7ed3fimZ5A7b61DL+NkPmvb
 XbsTmSVumDYHJPyQTy76nSXo7zdgK6PTIP6A7iAFH4tf1S8FIkpdlZsqgwvd0pKUGs6c
 KXFRvcwfn+yeC5+q23UDaJ4ffwNj/8q7W9D4X7dF/8yD8CCQKeOletw2qOe7tiPd8kKe
 ln2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067712; x=1784672512;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EUZJ2b06rpE59kyPt/lRc7T/ATHNB4Peeih6JEYSOE8=;
 b=T2s6IF+UVIXlqqu7O6auAL2w2oCrgtVAUunz04qA3TMueH6GA8DmB0x/k/0XgRceoJ
 FF8yE2nJNZcoiLPtBhia6OqOkWSod6/4Cf/rv5jNi2fq9iu1aBx8dhfD3qazTPD6SDC2
 rqJhg7ADzwketAGzk+ZgHsM7ikxWZjfvRTY+jGX/1suKwFg6Zj2ARJkwT5db6K4hVoX/
 0LAfwenXtcf3kcCY9uKOYrUkPCMzIrR08X7DCCzWadU55N4LlPx/JYDoSvw717zlTSdg
 cHz4cmUWsrMZ+dE5lWESIHpX9T7Nb4/8hai8OSrlUfmWOSNwqts7ls/MbdCTXsHL7noA
 grXQ==
X-Gm-Message-State: AOJu0YxqtMwOJITtg2x6xtfBBGtX55tGobHSJRLqa/zT8CKnm+7OMSil
 /gOWNSrkPYohq27MmkIxcRqmdmJ/bLbUsiPJALv69EDq57vVkUilaypm
X-Gm-Gg: AfdE7cm2heY5RF++PEn89+gKC8EI8uu8v9NZNnn6a0Lpuz5PMV7YQpG49IaaCOwXvFa
 pbGcETHNFi4doTDZ+52yrnQ4Vj/WQyqb5/iGjL57qbqHf2jEYdlZeCadl6aRfzBZI2Ux6kyzC9w
 1rcu8fTKuEYLwTTQnXllpQ8PJrQ07FJZXfNzxQMLsQiTbgJXAhd3FolCAV3lw8Y1ddHf6PLmw1M
 dgRY9wi4bVmhxjdpRZwwf7ehBfn/zCdlhwl2HmNHisPNFUI/3JvSrFb3HFm/o3jBAwYnhPpD9CQ
 RflE6vj3wg/T+TajYFKNY6O8nSaCTxn4CQsoGvrU5DiMBTEzIUcwcfNU4XO6QhbY7Wujr7suUuc
 Q+w40qITyQeMPrFY3nRvqS5aRwFaSHutBaX0Nt5Vuu7i+MjKRnbdeAWORfQQodNmEPubDiPKch7
 ZWw5taykLH4nFwTo1QzSqM5284Dw16Ck+2Gz1uRiuatenQlYpTn1P0cboCdU0=
X-Received: by 2002:a17:902:e751:b0:2cc:307c:51f2 with SMTP id
 d9443c01a7336-2cef143aec1mr42102315ad.22.1784067712200; 
 Tue, 14 Jul 2026 15:21:52 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1f030sm122554955ad.51.2026.07.14.15.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:21:51 -0700 (PDT)
Subject: [PATCH v2 4/4] fixup! drm/gpusvm: use
 hmm_range_fault_unlocked_timeout() for range faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
 kees@kernel.org, leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com,
 ljs@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Tue, 14 Jul 2026 15:21:49 -0700
Message-ID: <178406770964.1106335.10099816010446253543.stgit@skinsburskii>
In-Reply-To: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
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

The timeout passed to hmm_range_fault_unlocked_timeout() is a relative
retry budget for HMM's internal mmu-notifier retry loop. drm_gpusvm was
still keeping an absolute deadline around the outer driver retry logic
and passing the remaining time into HMM.

Pass HMM_RANGE_DEFAULT_TIMEOUT directly to
hmm_range_fault_unlocked_timeout() on each HMM fault attempt instead.
If HMM succeeds but the later drm_gpusvm-side mmu_interval_read_retry()
check observes an invalidation, retry with a fresh HMM retry budget.

This keeps the timeout focused on repeated notifier retries inside HMM,
while avoiding an outer deadline that also accounts unrelated driver-side
work after HMM has made progress.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b8f2dd9982f5..76e8a0028c7f 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -852,8 +852,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 		.end = end,
 		.dev_private_owner = dev_private_owner,
 	};
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	enum drm_gpusvm_scan_result state = DRM_GPUSVM_SCAN_UNPOPULATED, new_state;
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(start, end);
@@ -867,8 +866,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 	hmm_range.hmm_pfns = pfns;
 
 retry:
-	err = hmm_range_fault_unlocked_timeout(&hmm_range,
-					       max(timeout - jiffies, 1L));
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 	if (err)
 		goto err_free;
 
@@ -1459,8 +1457,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		.dev_private_owner = ctx->device_private_page_owner,
 	};
 	void *zdd;
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	unsigned long i, j;
 	unsigned long npages = npages_in_range(pages_start, pages_end);
 	unsigned long num_dma_mapped;
@@ -1478,9 +1475,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		return -EINVAL;
 
 retry:
-	if (time_after(jiffies, timeout))
-		return -EBUSY;
-
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
 	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
 		goto set_seqno;
@@ -1495,8 +1489,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	hmm_range.hmm_pfns = pfns;
-	err = hmm_range_fault_unlocked_timeout(&hmm_range,
-				max_t(long, timeout - jiffies, 1));
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 	mmput(mm);
 	if (err)
 		goto err_free;
@@ -1718,8 +1711,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		.end = drm_gpusvm_range_end(range),
 		.dev_private_owner = NULL,
 	};
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
 					       drm_gpusvm_range_end(range));
@@ -1734,8 +1726,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		return -ENOMEM;
 
 	hmm_range.hmm_pfns = pfns;
-	err = hmm_range_fault_unlocked_timeout(&hmm_range,
-				max_t(long, timeout - jiffies, 1));
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 
 	kvfree(pfns);
 	mmput(mm);


