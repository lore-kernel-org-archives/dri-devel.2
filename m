Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F388C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D3910EC00;
	Tue, 11 Aug 2026 13:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UqIjcPb7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A797210EBDB;
 Tue, 11 Aug 2026 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=YtXGH4d6P96H2uH2l8a6g6zEJJTmQ5VPZ9zpfU2qDxI=; b=
 UqIjcPb7/WBTbzo+nN40dAQ4z6xClrj8061F5/cYGde+oofXShtB8ba2NIJUKi+Z42+O2Qepwe50H
 cvAfcL8zAr8YZDA7Bd/jLQygohx34ZPnGW9ozEfrejTrdcv2WksjnsMqZ0Fk5PGTenzKEcTUfW8Vi
 asRWawmg3xyPTNN1cG4sPwXPc3yBO5gj3y2HR5TsmPJd3X4b44VJnVIBNNdscD54F0aMoXRKQs2AE
 dUC2cMh+C9JES6J3SafWv7ZH/83/iBfnmJCW1oz2cEd/wU0sM+xvCTwElZ+e0xVTdXAlkY5gLpjkO
 pi6/HVvGx+Ay7YD6eriFvx/Jrc+fEOsj/Q==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpo-00H9n3-Ro; Tue, 11 Aug 2026 15:48:04 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 05/20] Revert "drm/sched: Remove drm_sched_init_args->num_rqs
 usage"
Date: Tue, 11 Aug 2026 14:47:43 +0100
Message-ID: <20260811134758.96339-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 2833a0512b4cd55d9fea7ec18be85ef82e69ad3b.
---
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 14403a762335..8e9ae7d980eb 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -290,6 +290,7 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 {
 	struct drm_sched_init_args args = {
 		.ops		= &drm_mock_scheduler_ops,
+		.num_rqs	= DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit	= U32_MAX,
 		.hang_limit	= 1,
 		.timeout	= timeout,
-- 
2.54.0

