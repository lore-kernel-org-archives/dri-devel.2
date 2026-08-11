Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC04C5CFEB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BA210EC08;
	Tue, 11 Aug 2026 13:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bW3VRW6/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C64A10EBDA;
 Tue, 11 Aug 2026 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=pljVsRQt6GhK7MADOHOTh9Q4W4MT4EGDoRg/GN83pkU=; b=
 bW3VRW6/y52inMf+NRPTqTll36WNZ9mpG1UPdC3PcTncbkepy3tjrMPfTljv2DYDoGSWOuCjek13W
 LibjnKPy55DTLclbzTMIIGme96to2HQAHhSibGKdqu8Q5l79yZIIrk7UN23HNUpv/+R/x6AEEfc3H
 y+c22gDWUKoxGxiGQkkcvQoOOuWYx3nDI4dsYGDZDmleIqkO28PwLKcoQpcOj7dxbXOFwjYXqxycU
 tVn9HV8qjdYmDAOJ8XVIUTzY4rm8z2nwWpEPrRMg4H515RGv1miBHh+ts1EMTTdoUpmSt+ynpshAe
 6IXRRD7Xt877FfpPnLlplq16Pz78i9P6Xg==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpp-00H9nO-Ka; Tue, 11 Aug 2026 15:48:05 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 06/20] Revert "drm/panthor: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 14:47:44 +0100
Message-ID: <20260811134758.96339-7-tvrtko.ursulin@igalia.com>
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

This reverts commit 30c4a19cf71f040462254dcb8b2d3c3e7232b99b.
---
 drivers/gpu/drm/panthor/panthor_mmu.c   | 1 +
 drivers/gpu/drm/panthor/panthor_sched.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 0182b72f1932..9f63a048df61 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2859,6 +2859,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	const struct drm_sched_init_args sched_args = {
 		.ops = &panthor_vm_bind_ops,
 		.submit_wq = ptdev->mmu->vm.wq,
+		.num_rqs = 1,
 		.credit_limit = 1,
 		/* Bind operations are synchronous for now, no timeout needed. */
 		.timeout = MAX_SCHEDULE_TIMEOUT,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5832dccfc093..5778e23e20a0 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3501,6 +3501,7 @@ group_create_queue(struct panthor_group *group,
 	struct drm_sched_init_args sched_args = {
 		.ops = &panthor_queue_sched_ops,
 		.submit_wq = group->ptdev->scheduler->wq,
+		.num_rqs = 1,
 		/*
 		 * The credit limit argument tells us the total number of
 		 * instructions across all CS slots in the ringbuffer, with
-- 
2.54.0

