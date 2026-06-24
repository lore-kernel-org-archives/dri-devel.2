Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8989CDE005
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8177B10EEF6;
	Wed, 24 Jun 2026 12:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVtKmPUO";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958D110EEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:23 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso758817f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304162; x=1782908962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XAJmFy8LAnGJsBUtLmdOHGEG0gZamE6rRydN5uBopPw=;
 b=iVtKmPUOXO/Mnb8d1vlYdPknsXtlol6z4yMS8x5VsWKvpfn/w2k1FSwNT0LUNdjtEe
 UcSFoaM3BQJUeSon33ualAtrsbq67quQr63RPB16mTAG9jZbQpuqVItE6aeNQwjX3wYO
 RI7GRIkzol7hDGWtogb3b4RHPmuNTDT6a+FIqTd3DP3NJHfqJTbNCMQkD9nQmZGQz8yY
 k58CCSgyUaP1ShbcqNCz8ntBVyh/ziSU20q69xG2JpL0QOoYOvUeL2OBw6ni/+BVTxBF
 PB3aAszFRk+mTVOJ8kK/X1yJNgYGjd0H839DnAJFHiuW3pyoOpb0fQ92Dy4Qaq3QdGGl
 vvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304162; x=1782908962;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAJmFy8LAnGJsBUtLmdOHGEG0gZamE6rRydN5uBopPw=;
 b=TuGktRt3ou7CgX14HC6jSrtfQh0w0Dks83IsxLi3HFZxeoaJTJFCHrn0txnR4mdAYG
 jKjvZ3PJkO5k/cYczk61QDukDebU0ETjBClsT5fhVirWNCTWNZ5aJDV9WwQtu0Ns+5He
 iBqFGHa2OSpcwtIXQ1iZGFnUCoNLsEKjXiGyH6GLiTMQeumV54XsbkZdg/KnMY8YAeoR
 Z+TB4ZT9mGjce1eIsa1boBvS+LactPlqiK0WEdUmKLRaxUi1ZoFl9YsEY9YIcmmKGlEu
 I1uwn9M/tmPfD3XJ8SekGsmAtKcDFPCcPirxA4oML9kuWzsVTFA1vYl+GqEXFKuNB3vj
 h+SQ==
X-Gm-Message-State: AOJu0Yw5m1QYupwWlgfAA+TQYagOrU8MaHJuYOdLRNCx6J6fCzmlurYJ
 V4vTymiTcr8eHD+QoS647ujBbxKbsPDK9AqDfX7AF9xbSsllMgKFP5yE
X-Gm-Gg: AfdE7cn7d8O+CmAroLeZh5DGAVX/11OhiS9TBCBkW2avtL72Kdo/n02N6bEjjXyTn0t
 KV52nS3W02fYQR14YQd7Z6XFe/a2/CSH/5csIA+ucM/23vbZ+gGu9B5HCqANEZIjZJMtu5cpmYA
 +R735H/MbnGqOqgPBRno1EB5r4PZGmA+N2+VP2iVRcJSlwr/28LnVTBdUTszQI/J4PaZkG9r2o5
 5gAQ9r4Xtsvfu4yKGvpujknSr8NNxhmaL4N16pyxP7RrnYb1E7fWTDDnhrkrr/F+CXKuThKfnKe
 h8PHmL6gBHXvmsh0QNM1IrgGFx9MEvuYZ7TiQytdnr6XQieq3loHmKQOV0PYcRXAHo5zDecygPU
 LvmLApNobs0oU2wKRsAOTQK7+053tgHQAUP5qguGwM9Io9I3URHP1JItDgOKFHq3/x7m2qADtVZ
 Vy6aJNUXaN3Ajni4bmTs3Hs4pFSQ==
X-Received: by 2002:a05:6000:2587:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-46c0951d92emr5308154f8f.3.1782304161896; 
 Wed, 24 Jun 2026 05:29:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 02/10] dma-buf: use dma_fence_test_signaled_flag()
Date: Wed, 24 Jun 2026 13:13:26 +0200
Message-ID: <20260624122917.2483-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624122917.2483-1-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Instead of dma_fence_is_signaled_locked() use
dma_fence_test_signaled_flag().

The extra polling check seems unecessary for those use cases.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/sw_sync.c | 2 +-
 include/linux/dma-fence.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b0218a9..243991bc1506 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -262,7 +262,7 @@ static struct sync_pt *sync_pt_create(struct sync_timeline *obj,
 	INIT_LIST_HEAD(&pt->link);
 
 	spin_lock_irq(&obj->lock);
-	if (!dma_fence_is_signaled_locked(&pt->base)) {
+	if (!dma_fence_test_signaled_flag(&pt->base)) {
 		struct rb_node **p = &obj->pt_tree.rb_node;
 		struct rb_node *parent = NULL;
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 158cd609f103..803e10ca76e3 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -658,7 +658,7 @@ static inline struct dma_fence *dma_fence_later(struct dma_fence *f1,
  */
 static inline int dma_fence_get_status_locked(struct dma_fence *fence)
 {
-	if (dma_fence_is_signaled_locked(fence))
+	if (dma_fence_test_signaled_flag(fence))
 		return fence->error ?: 1;
 	else
 		return 0;
-- 
2.43.0

