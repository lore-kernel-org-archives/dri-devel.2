Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8ECDE003
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8EC10EEEC;
	Wed, 24 Jun 2026 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KhD5xXDu";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629A710EEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:26 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so6231725e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304165; x=1782908965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gDF3E/f0HpcAxk6Syf/Djo3DsKUW9SV64tqXNSKhSz8=;
 b=KhD5xXDuAJExcdEOD2oLGz0756HuwM+VKnCYJNI6xtRlJVkcbjxgtQC4+Hz1rc2F79
 8CW5N3n5of1u7+SrmbUHw+IYmichfKhROy5dhjd320sQYGr45C87vb2BA0w95nEU+tMp
 atIWdgDxl50rd9+Pr9j3nXrlS5V/sAlrhyV6/BT7aL43TQLbJ6ujpaf1OK39rvW78wi8
 UmK5NJPj5Lm3HivLUmAmDyKhafSSVHmjk4ZShq6x/slvSqdXe0DepSw50TH6BY4xWdBJ
 JJ2YSN81KxHx5dzWoz80LMy13Zsgok8fUMt7mxkfjhlIImykZ95NX4LVNZpD4W+HLvPN
 TD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304165; x=1782908965;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDF3E/f0HpcAxk6Syf/Djo3DsKUW9SV64tqXNSKhSz8=;
 b=JipT9KsUqvRZ5+wECaUDuhg3CBZgLAdGvBiqA/tNditChQHwdDE5NEBLzWZOTkFzle
 nYZe+MxO8NLYRQ8D758HnHmzjS9shCv2KBiAwxah9vLvYkSTg+dtxybjUTWQdFlZkU8p
 I8zgnlUI2sp6WAxvW9NofafCfwdtv2zyt7co6cxgUq4itC9q6StBeo5RMxOJWoyf8lu4
 VBK7hUvGSCUBlHmBuHygvQJu0yEWCZDSTH7zLwDd6d0XLfSw9UcJO2jlkUiKTWyXc1yY
 uGV9CxabCMKs5Led0P+TRl5CKuVnX+zTgf96kGKVa3a5AHSquhYDSd+0sY2DpsTw8Pr1
 Tdvw==
X-Gm-Message-State: AOJu0YygFDf36ckImXYtuMF05tLKMh1LD+0jMdIpBqeuMBIbYbr/GqY5
 8llGQmOWfKgp1Gt2GEmULReybees/QwBEb8iTeWsjYyZRsjDUEG0WWbKbN6NxNnH6uo=
X-Gm-Gg: AfdE7cnDg/K2ftT8LflCgiFhxuc8cgsYghAfJZOHjEY2bTaKmOqsfn7BiI4Av8ETa75
 S+EobMnWwLrqf5IZ3YCDDkAJDILL9mjeOBuo1XasOPHYS/+2sjgKJWHoJOGrY8ERpLfE9NBXuVj
 cY+wm+8fVLquUZqYtlrKYtSocYw0FjWE1g0YCiyD78isDv313JIVwk6wmCNU1J4xQe3VfNB8P/L
 5c/FYvNhsmabnK/KzI4bOj/B9FWxzyK+uDkIcT1ymZk8lCTvlkYK2Pvzugi/ZqSvE70I0Tw0eJO
 yzGChAZvuMIfU/CJ+7WA3pvwZU1ooGnYAjXSPugAwZYNqR9QMmOtqre5DoiwfoSEHWE0OF0qBH0
 O9bIhD3DKfcC9bk3eUK++mP8uavdpHvsEmpV6V4LEWJ4Ft3l+NDcMAzPwv550748okAYshzQgsB
 ls+5TB6epTSTgIIeVV3AeL09WasA==
X-Received: by 2002:a05:600c:5252:b0:492:4a50:8445 with SMTP id
 5b1f17b1804b1-4925b387f72mr116817505e9.31.1782304164616; 
 Wed, 24 Jun 2026 05:29:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 05/10] drm/sched: use dma_fence_test_signaled_flag()
Date: Wed, 24 Jun 2026 13:13:29 +0200
Message-ID: <20260624122917.2483-6-christian.koenig@amd.com>
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

No functional difference the mock HW fence has no signaled callback
anyway.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 14403a762335..82dce344bfa1 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -224,7 +224,7 @@ mock_sched_timedout_job(struct drm_sched_job *sched_job)
 	}
 
 	spin_lock_irqsave(&sched->lock, flags);
-	if (!dma_fence_is_signaled_locked(&job->hw_fence)) {
+	if (!dma_fence_test_signaled_flag(&job->hw_fence)) {
 		list_del(&job->link);
 		job->flags |= DRM_MOCK_SCHED_JOB_TIMEDOUT;
 		dma_fence_set_error(&job->hw_fence, -ETIMEDOUT);
@@ -258,7 +258,7 @@ static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
 	hrtimer_cancel(&job->timer);
 
 	spin_lock_irqsave(&sched->lock, flags);
-	if (!dma_fence_is_signaled_locked(&job->hw_fence)) {
+	if (!dma_fence_test_signaled_flag(&job->hw_fence)) {
 		list_del(&job->link);
 		dma_fence_set_error(&job->hw_fence, -ECANCELED);
 		dma_fence_signal_locked(&job->hw_fence);
-- 
2.43.0

