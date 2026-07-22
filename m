Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7634DC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EC910EFF6;
	Thu, 23 Jul 2026 07:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gsWNNrgY";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2EE010E385
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:47:36 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bfb5e20a90so5191275e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784681256; x=1785286056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QUxIn1WFaPZcx4UkuKtETzjufHYnex7kE/0l2kUJDdc=;
 b=gsWNNrgY7Gjm66s7k9y2AHTkA1ceFcPpNJaAWkYvhTh++r+nHp8z7CkCkKr4gWd2+b
 3wtn6tx59tJ65T+x00S+G9+4CKtnsacecI/XHJ200fnZCJW0810mPtFj54kUwCQoBkpM
 mO4m5g7z1W9Ad6ulg8uMT5SoxkIS8DMv5MMaUuJXrBgIOJlv/PhUyaxaD83vO7n4wHFj
 CzRQMh6b7OkAE5LCxRXP4JAijW9S/hJT5WSdm/UNLMnFLTv12OrwcvsZSetLxx7CrYd3
 xVLiyN5giqZ96kqyMNaEEjXcE2SgycAJcPtYg+IgubFnBhMdjXqtXUh9m5WwCwFlodX6
 U3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784681256; x=1785286056;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QUxIn1WFaPZcx4UkuKtETzjufHYnex7kE/0l2kUJDdc=;
 b=oAjt0/wG78wAajMw3J6oLlA6dQLmYYySi13fQZTebqQ0Q34qxPaiwUMJfpT0Lnceys
 SEBaToVpvt+ji8dy1x20clEkMepbRDvKo1c4XNcSwXWXQZrVA8GRpigXCw6hkyfoxHTE
 Ii1RME1eZJEvmu8yRZpG18N/o/vFpHNAjfyEkN8NOfN4XBG9YyuqbC072yJg3TICFaSe
 ZG+3cXBuTWmFZCGr1YdRzU6Px8bVMg5uC/XV+umxTeHCO8CxEUVd8QUrEg51clwaO5h/
 mWBCv1JQobJFRPIUYIkOX+G3/1jLcWWZxk97Nu3XW598x8dphlM41PzeM9Vda1lKeLrq
 PnSg==
X-Gm-Message-State: AOJu0YxsH1w4DefQu7kalz6c7F1qbXtrXZ+4AntG4Pffle8M6K+bII7d
 c2MxjJzGdz/xvyhwPrHbyw1SJI8jAPUjVemh/aancAu38Pf0lQg8N9Bu
X-Gm-Gg: AR+sD13Ehv3Bm7jRW2f3mCqttYYZK6AEU9KZl96RgNfaKMecs1HcOfCu9pTSxHkkw7A
 38tpN7kxWbTo8jVvBZTA6b3sxnbzCowOsEkLulvBqCf0rdZ5d6/MSzM0pCokOHugDvSqw3NX/UW
 IBOQ50IxzFFn/Cg1mgMtSiRxs5I/HsnQRlv9nWoEidW/cCJOMlNm7mf6PBXKmBqQ4vYkfFBeWNz
 ako4wcJtiRGnSWBmKzLBbiVopCpcs4bc0kSbwxJGT2e5TczPp/P5d7sJ8eaYulrWkIAgQwBaJzQ
 TZWCOWXXcwRQPBSnRKsUdJTsHsi1wo6RTT7rzKgA8b7PfWtItd95GfASrRSu+BI+1x5IHnSBC5t
 gJGfLovy2InAaT+MP/Ioz80sJTZdwWMGqS6y1cjIPcrBS+4fE6qoHUX3QepHIbQ2F9CRpvzdcF5
 AWTgKwUPo0/IUbQkL3rQXKb7ic4WlOsCHfwLnuoroaCaGvGW/gW39zWEM3nr4MoW8qT3LpEA==
X-Received: by 2002:a05:6102:f86:b0:740:2bcd:24d2 with SMTP id
 ada2fe7eead31-74753465e4cmr7656619137.5.1784681255740; 
 Tue, 21 Jul 2026 17:47:35 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.211.222])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-74ad31c215bsm1346505137.2.2026.07.21.17.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 17:47:34 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing it in
 timeout paths
Date: Tue, 21 Jul 2026 21:46:53 -0300
Message-ID: <20260722004654.744249-4-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722004654.744249-1-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Timeout-recovery paths flush the G2H worker to pick up a response that
may have been posted by the GuC but not yet processed:

 - guc_ct_send_recv() after the 1s wait for a G2H response fails
 - the TLB invalidation backend's .flush() hook, called by
   xe_tlb_inval_fence_timeout() before declaring a fence timed out

However flush_work() on a work item that is neither queued nor running
is a no-op. If the GUC2HOST interrupt for the response was lost or
coalesced, the G2H worker was never queued: the flush does not read the
G2H CTB and the response sits there unprocessed until an unrelated G2H
interrupt arrives. For TLB invalidations this results in

  TLB invalidation fence timeout, seqno=N recv=N-1

with the fence force-signalled with -ETIME even though the ack may
already be present in the CTB. Observed sporadically on ARL-H under CPU
load, always with recv == seqno - 1 and self-recovering on the next G2H
interrupt, which is consistent with a lost wakeup rather than a
GuC-side failure.

Add xe_guc_ct_flush_g2h(), which queues the worker before flushing it,
guaranteeing the flush always drains the CTB, and use it in both
timeout paths. A spurious worker run is safe: g2h_read() returns no
data under fast_lock, and receive_g2h() copes with runtime-PM state and
disabled CT communication.

After this change the fence-timeout error only fires when the ack is
genuinely absent from the CTB, making the message a reliable indicator
of a GuC-side stall.

Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  2 +-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index fe70c0fd85c..11a05c2b8c7 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1377,7 +1377,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 wait_again:
 	ret = wait_event_timeout(ct->g2h_fence_wq, READ_ONCE(g2h_fence.done), HZ);
 	if (!ret) {
-		LNL_FLUSH_WORK(&ct->g2h_worker);
+		xe_guc_ct_flush_g2h(ct);
 		if (READ_ONCE(g2h_fence.done)) {
 			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
 				   g2h_fence.seqno, action[0]);
@@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct *w)
 	receive_g2h(ct);
 }
 
+/**
+ * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
+ * @ct: GuC CT object
+ *
+ * The GUC2HOST interrupt for a G2H message may be lost or coalesced. When
+ * that happens the G2H worker is never queued and flushing it is a no-op
+ * that does not read the G2H CTB, leaving messages the GuC has already
+ * posted unprocessed until the next interrupt arrives. Queue the worker
+ * before flushing it so the flush always drains the G2H CTB. A spurious
+ * worker run is safe: it returns without side effects if the CTB is empty
+ * or CT communication is disabled.
+ */
+void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
+{
+	if (!xe_guc_ct_enabled(ct))
+		return;
+
+	queue_work(ct->g2h_wq, &ct->g2h_worker);
+	flush_work(&ct->g2h_worker);
+}
+
 static struct xe_guc_ct_snapshot *guc_ct_snapshot_alloc(struct xe_guc_ct *ct, bool atomic,
 							bool want_ctb)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index 767365a33de..4e0338953f1 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -22,6 +22,7 @@ void xe_guc_ct_runtime_suspend(struct xe_guc_ct *ct);
 void xe_guc_ct_stop(struct xe_guc_ct *ct);
 void xe_guc_ct_flush_and_stop(struct xe_guc_ct *ct);
 void xe_guc_ct_fast_path(struct xe_guc_ct *ct);
+void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct);
 
 struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_ct *ct);
 void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot, struct drm_printer *p);
diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
index 046d0655122..91960dc4ba9 100644
--- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
@@ -327,7 +327,7 @@ static void tlb_inval_flush(struct xe_tlb_inval *tlb_inval)
 {
 	struct xe_guc *guc = tlb_inval->private;
 
-	LNL_FLUSH_WORK(&guc->ct.g2h_worker);
+	xe_guc_ct_flush_g2h(&guc->ct);
 }
 
 static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
-- 
2.55.0

