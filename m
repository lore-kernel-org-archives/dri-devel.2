Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFEACD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1841510EA01;
	Mon,  1 Jun 2026 22:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=theesfeld.net header.i=@theesfeld.net header.b="N23YkX00";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A2D10E8EF;
 Mon,  1 Jun 2026 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
 s=protonmail2; t=1780343717; x=1780602917;
 bh=i5q6iyFTLtGZwAyQzskDa+UIgmFftyxv9qY3L/cfpX8=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=N23YkX00yFQSbqS9JbTZfcrjGpXrbY1qAJaobCIP0PT82buagoPDd/ZtTBRO0PrWy
 QRyLqWJXWVvrvp4WB74iGrvOxHJVuf4CNBfEUPNxIamMe6qR3pKzn50QabDTBc4Rwd
 bmXCAE1beNpaQYWGSA08v9nfxugiIHoTLTfbSmhitgUsZGYwPd/yNIoxDdqidRyV7v
 b8SPpNBZHbtpQkRvQp6l3O8FTdCIWPcRsFZQ2r75lciJu0CZNbqsHvzlbdqKvhfyS+
 ks/1v0eycTOqsGZRyu6rAoFAwNL+mid7cnEoELmKI7GP1ifryXP8gb11/MPG1CTTmI
 YUI9tPokCXbhg==
X-Pm-Submission-Id: 4gTl736RV8z2ScPK
From: William Theesfeld <william@theesfeld.net>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: convert CRIU event-private allocation to
 kvcalloc()
Date: Mon,  1 Jun 2026 15:55:10 -0400
Message-ID: <20260601195510.639318-1-william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 22:12:59 +0000
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

criu_checkpoint_events() allocates the ev_privs[] array, sized by the
runtime count returned from kfd_get_num_events(), using the open-coded
kvzalloc(n * sizeof(*p), ...) form.  Switch to kvcalloc(), which
carries the same zero-on-allocation semantics and adds the standard
size_mul overflow check on the n * sizeof multiplication.

No functional change.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 44150a71f..9739214e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -543,7 +543,7 @@ int kfd_criu_checkpoint_events(struct kfd_process *p,
 	if (!num_events)
 		return 0;
 
-	ev_privs = kvzalloc(num_events * sizeof(*ev_privs), GFP_KERNEL);
+	ev_privs = kvcalloc(num_events, sizeof(*ev_privs), GFP_KERNEL);
 	if (!ev_privs)
 		return -ENOMEM;
 
-- 
2.54.0

