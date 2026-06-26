Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEADCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D8A89C48;
	Fri, 26 Jun 2026 11:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfGmLhKu";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAAD10F5A2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:58:35 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c0e124d2a21so83386866b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782475114; x=1783079914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i0Ps5tEtd22JyPLt5Txw4hpkbL4qYP5JlG6cYEFGqrA=;
 b=hfGmLhKunB8vtUk1h0a3S5JZ+XyBNkKYCxXaP84nU0kPwK+1AZ6gZA8YGcjRwU2DSi
 ldGCvKMbOKNsNKzCE7vyHGKdOcsYQPGjP4EbXkyHkDQPcp2ZAS+wotI5x41Fo3wYtras
 WJQEg5bBXD0rVGunk5XjKlTfXGAiOSGRTx6fpHzpGPsJlGxL92Y/W1TySQcnMNs1Ct3U
 ajxbgq3xH8yNN1DzEWXoKrFm6SSi7DX/sgOFyVKt+s0l5VN671b4Y7D09lN4mFCXANis
 WJnXOuvETBIWCX1wZH+xIuno5XMlEMuYCqE/1vwof4gYyAaCBRGjq+f53bKIJ2hCZ8+I
 3UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782475114; x=1783079914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0Ps5tEtd22JyPLt5Txw4hpkbL4qYP5JlG6cYEFGqrA=;
 b=m3svukBmYEALNGtx2pzIHl07wCRpPvgUTdHMdph0tVqCk5zd1TP1ZoTuXfCKLtFPeE
 m7u/83G4p8suIApg27GUtaZ1s4LmpBcmXqS9ACQTx+2T/tx0d0kbMfm2qxknEB2Ao0Pv
 hDucvos57iQ1PeVtwTAWH3fxxL4MaHGaTqLjqCj0l8tx8gKi41/iIAHzVbmeVLbcDSsr
 QqZepQHJ5zIGDbakBC5FU7s6sRWZCbzeHad5HyyIvWAsNcCfUxrF09BiqZcBHe2pOxay
 4Jt6DyM2n9PIzV6Rc6CnOHNPgNf7AjKyL5BL7GPdDUSfOEyosZYTNQPgLMJ2iuKyKjXD
 ZwvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RokLUKNQCbAxKcb/9FFJ+Jgd2jqhKkWnq1mE5JAfS1uxI3qVyXqpe1flzqOA+EmH9eywxK55+LWF7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU+NcVgjwN+4ASwxykxX29vX1MljnPVwQsaa+X8NrGEOVrxULk
 8oe07XXuWU+eNdHMvSwdeLyg8g3J8GXrnKmPAdVPU2faNEj2ou4GolIaoRTJzutP
X-Gm-Gg: AfdE7cnNlwKqP4Xyim5w8XxiO7Q5AqMoTFbIvOonzWP5F3Z2EtwdbDvH0QZXo+LRcyQ
 7U212d2EknOqwvBQrVdIFypwbJznd2dyh3QdUxDAfCqKnANWvCBn4/0R4OT4ExBqP2m4RZqRClB
 QZmGcTUw3W0+V1/Z5mA9ylUqchUTLFDdFCOTBt7zLd21cUXLZHzaGhpgnKv/04ZwWEpxQg6m0UL
 asfYPkmI03T9b5601HgPfGoCHfZrpEkRid0tdmbrSf5xcU0Q162u0YS5RKNmV8brIEV2iVSqBOq
 hDkhpFYgTrSu9SlvSzuJGlBuZNosq5qqXR5N1g4zrcjEyGi8PKGVpyLfiUglCa2W3A0qPvPHrAP
 VJM3scub7HL+dNKlL0AL6UYUrSHYQu6HNyPE5T8maENIf0BexkSPf+GfdyDOj3VpqVnwKIz6Lqm
 BMx/CCB1MLV3V5LcywgUcCqBlK8F8K24smiw4nQT8W9PFFYDnGHtW7au34OEktoaeoR3ek1lg+T
 49zcpyx3SW29r7f45ZRiL255DVUX6K/4Q==
X-Received: by 2002:a17:907:7ba1:b0:bd0:df77:98bb with SMTP id
 a640c23a62f3a-c1205d4fd16mr415304166b.9.1782475113560; 
 Fri, 26 Jun 2026 04:58:33 -0700 (PDT)
Received: from fedora ([154.66.167.183]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c122e9ae635sm37986266b.20.2026.06.26.04.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 04:58:33 -0700 (PDT)
From: aquiles <achillezongo07@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 aquiles <achillezongo07@gmail.com>
Subject: [PATCH v2 2/2] drm/xe: skip resv fence wait in xe_svm_invalidate if
 no ranges are bound
Date: Fri, 26 Jun 2026 11:58:08 +0000
Message-ID: <20260626115808.2072258-1-achillezongo07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 11:59:24 +0000
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

xe_svm_invalidate() waited on the VM's reservation object fences before
processing MMU notifier events, even when no range in the affected
address region had active GPU bindings (tile_present == 0).

Add a pre-scan over the affected ranges and skip dma_resv_wait_timeout()
when no range needs invalidation and all BOOKKEEP fences are already
signaled. The fence check is necessary because tile_present is cleared
when an unbind is submitted, not when the GPU job completes — skipping
the wait without it risks unmapping DMA while an unbind is still in flight.

Signed-off-by: aquiles <achillezongo07@gmail.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index e1651e70c..447c5c965 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -233,6 +233,7 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 	ktime_t start = xe_gt_stats_ktime_get();
 	u64 adj_start = mmu_range->start, adj_end = mmu_range->end;
 	u8 tile_mask = 0, id;
+	bool needs_inval = false;
 	long err;
 
 	xe_svm_assert_in_notifier(vm);
@@ -258,11 +259,22 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 	if (xe_vm_is_closed(vm))
 		goto range_notifier_event_end;
 
-	/*
-	 * XXX: Less than ideal to always wait on VM's resv slots if an
-	 * invalidation is not required. Could walk range list twice to figure
-	 * out if an invalidations is need, but also not ideal.
-	 */
+	/* Pre-scan: skip fence wait if no range has active GPU bindings. */
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end) {
+		struct xe_svm_range *range = to_xe_range(r);
+
+		if (!range->base.pages.flags.unmapped && range->tile_present) {
+			needs_inval = true;
+			break;
+		}
+
+	}
+	if (!needs_inval &&
+	    dma_resv_test_signaled(xe_vm_resv(vm), DMA_RESV_USAGE_BOOKKEEP))
+		goto range_notifier_event_end;
+
 	err = dma_resv_wait_timeout(xe_vm_resv(vm),
 				    DMA_RESV_USAGE_BOOKKEEP,
 				    false, MAX_SCHEDULE_TIMEOUT);
-- 
2.54.0

