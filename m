Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0BAC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FC310E6F5;
	Tue, 11 Aug 2026 16:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EDvBs7i5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F0B10E1D0;
 Tue, 11 Aug 2026 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Y/NLCfPManloVbIEp1hIfJ640h9AiKzq4r84jSYP02I=; b=EDvBs7i5NlFzrtOBtMzegziGp/
 da81hnYhrAhw7kS94o/OU8gWjXjJF7QgcXaqRo/Q7mE+eGIATl2tp/1009+nMjqB9gE9eazszyrvs
 jIOIMyMyCCes+NgZT1SblGb8VOWQXMv8NeVO5hGPN5QV/8MUqfEP0dbiPverQtfHTEp0xK917pCbA
 kT54Z7sAmn2CeBy+jq0/CNC2MEqMU64Qi/n3ydeJtQCHAi7MbBn047pw9jxQjo2qrGu0SH1CYbcGi
 R/HMT7/BglJ7fjYTmdnBEHZHJipmgQSVk6R2K6UJetcn8D1JRaUkwUbA8aR2J3dPMsGDjBiMWXBiZ
 8drEXhLg==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtpOB-00HFd3-KG; Tue, 11 Aug 2026 18:31:43 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v3 04/19] Revert "drm/sched: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 17:31:23 +0100
Message-ID: <20260811163139.99746-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811163139.99746-1-tvrtko.ursulin@igalia.com>
References: <20260811163139.99746-1-tvrtko.ursulin@igalia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This reverts commit 2833a0512b4cd55d9fea7ec18be85ef82e69ad3b.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
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

