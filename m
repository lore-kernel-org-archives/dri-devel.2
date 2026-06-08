Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579B9CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 04:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE40110ECD3;
	Mon,  8 Jun 2026 04:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LEJu8Aj+";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417BD10ECD3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 04:59:07 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-842288702fbso1484555b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780894747; x=1781499547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ipqvdmyqqpva+7JIGdF/76e2icFV3lJnAt8HUZ3Swsk=;
 b=LEJu8Aj+64grx3UCRe1ESmGOnYw4kViT4d4t0fbsN4E3uWfs1yDwsb5iMazOy5f91h
 a89zrMM32qwRRHZbWOanjUlRQeJfw7e2AAqPX41SWBz/svVf/tGGbkolNt1tf+4kAO9f
 OFp8K7FaqkpW1sNE2vYe7Jh0+eWECPlrO/rwj0/2F/leqRSQXLjRjNe3ADebBHZjNP8h
 kOufeQVxTnsJllztJX2VHn6SwkPsDaqJgU9Hu6mmhpGC/Vi9ZALC0Dn1VyWZbo4Mmg/W
 ON8DMRbLpYIhBr7Fq5yNir4DIbLyKSsqfRD6dkyIPFZq+zyvgFMdYCFVyh6289fyTQXe
 XgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780894747; x=1781499547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ipqvdmyqqpva+7JIGdF/76e2icFV3lJnAt8HUZ3Swsk=;
 b=ppRgMDsts8kEE3Gu3WFxOSewlNH40sjjXMEtnxErg5gBypAmgqjKLmQ5LqotUWv2e3
 Q2FjrNhPiEMld2mi6LzoxFkGcYSfoXUXtBOKli13JX+tgMCjuf+9SzW8S4Xa1mu6RQq2
 CMUBMGXcA2OKpj9ZXaaPjlm4n1H65ndWJyvsS/Cynibc8YAfbC4lSXJvBYQvO4GFMVYj
 neMhydwBQlp5eeUln9p4D0U79eUuvdbTENOcLFkdcFgOdIgf/vgssS80oHCtRAB/EB38
 oP8dIGqpEfffYmlB6QjK9KaiLJr2Iwy55n2R5+eZKO6DVD05wJIUUHkxWhf0Wd6HuKOH
 V8/w==
X-Gm-Message-State: AOJu0YxWvgF8yAMiSJq34SCTTIRle+9LXu/ngNYulg7WrKyuqT89zsrg
 Dcfgf1owyFfn2Ijea9ijLWHgzrzQPKCNhDv1geUralS3qqtMJlzsNhPjxPI9cQ==
X-Gm-Gg: Acq92OHX696/gApMce6/xAhLbMROLG+6etzKvieDsC5sKQYPHiUNtCyx4F11sD9WK6F
 eWG79v+bQ47VKRNywkc7s/rSmLp6FqeIfn2upeo+AaCvGK9hdW6NHKatVgEwRrpBOAanYHAiEnW
 CrcvpgfdyRuCMY8tPCt7OYxGLppSfVJxpK3fhAXseiYcA/tfb2LRW7lIEtNp2xQjoAAN3HODawo
 Xog4STWKJcixTcPq7B9mD195CSgntBU7Cc85Nn7zfD+h4Aj4X2zrW0Out6kVCRtBCuVt0R/FCBY
 qw3JyUdhEDMPvL20VfM9eZjemfnFSG4EDo8+eTbxF1yqLahQ4SLQIgcVeI4gUvCMAFs5R9emxNJ
 lR4SmKo4CoOwCtADs+tVHHJOMg6fwCjho5IRZYmv8FqbdsxIOZyAMYG7ryuZW//SwDcnqYirOVC
 w/YhMuHyZjTNaT5X23ArKPZoTrmkDYc2TiwBdb9A2Ka4y43VXU7qfZQ2lO3cMnH6JMg00GsBVXQ
 wo95/X4QVSIUPkr0/+D0D0mh182bDFaljjIs8veapuEsA==
X-Received: by 2002:aa7:8889:0:b0:842:4f24:f3a2 with SMTP id
 d2e1a72fcca58-842b1065a73mr14478970b3a.28.1780894746717; 
 Sun, 07 Jun 2026 21:59:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428221a7e9sm20732154b3a.11.2026.06.07.21.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 21:59:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] accel/habanalabs: kzalloc + kcaalloc to kzalloc_flex
Date: Sun,  7 Jun 2026 21:58:49 -0700
Message-ID: <20260608045849.5489-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Simplifies allocation by using a flexible array member.

No need to free separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../habanalabs/common/command_submission.c    | 20 ++-----------------
 drivers/accel/habanalabs/common/habanalabs.h  |  2 +-
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index ba4257bda77b..ba99329eacbd 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -809,7 +809,6 @@ static void cs_do_release(struct kref *ref)
 
 	hl_fence_put(cs->fence);
 
-	kfree(cs->jobs_in_queue_cnt);
 	kfree(cs);
 }
 
@@ -907,9 +906,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	cntr = &hdev->aggregated_cs_counters;
 
-	cs = kzalloc_obj(*cs, GFP_ATOMIC);
+	cs = kzalloc_flex(*cs, jobs_in_queue_cnt, hdev->asic_prop.max_queues, GFP_ATOMIC);
 	if (!cs)
-		cs = kzalloc_obj(*cs);
+		cs = kzalloc_flex(*cs, jobs_in_queue_cnt, hdev->asic_prop.max_queues);
 
 	if (!cs) {
 		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
@@ -947,19 +946,6 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto free_cs;
 	}
 
-	cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
-			sizeof(*cs->jobs_in_queue_cnt), GFP_ATOMIC);
-	if (!cs->jobs_in_queue_cnt)
-		cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
-				sizeof(*cs->jobs_in_queue_cnt), GFP_KERNEL);
-
-	if (!cs->jobs_in_queue_cnt) {
-		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
-		atomic64_inc(&cntr->out_of_mem_drop_cnt);
-		rc = -ENOMEM;
-		goto free_cs_cmpl;
-	}
-
 	cs_cmpl->hdev = hdev;
 	cs_cmpl->type = cs->type;
 	spin_lock_init(&cs_cmpl->lock);
@@ -1014,8 +1000,6 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 free_fence:
 	spin_unlock(&ctx->cs_lock);
-	kfree(cs->jobs_in_queue_cnt);
-free_cs_cmpl:
 	kfree(cs_cmpl);
 free_cs:
 	kfree(cs);
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index d94c2ba22a6a..dc13c8a6f242 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2046,7 +2046,6 @@ struct hl_userptr {
  * @encaps_signals: true if this CS has encaps reserved signals.
  */
 struct hl_cs {
-	u16			*jobs_in_queue_cnt;
 	struct hl_ctx		*ctx;
 	struct list_head	job_list;
 	spinlock_t		job_lock;
@@ -2080,6 +2079,7 @@ struct hl_cs {
 	u8			staged_cs;
 	u8			skip_reset_on_timeout;
 	u8			encaps_signals;
+	u16			jobs_in_queue_cnt[];
 };
 
 /**
-- 
2.54.0

