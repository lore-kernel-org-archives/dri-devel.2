Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBA5C5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E7E10EBF5;
	Tue, 11 Aug 2026 13:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TwnqsemE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A703A10EBF4;
 Tue, 11 Aug 2026 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=4bjm/133UemT++T0VsKIOqDU9vIzJ8JdrLbI/MFr8nU=; b=
 TwnqsemEh9eX5eYfGmN56gIwTePgDIbae4acoXp1M2QyaW4EFhwognIvrHK7G5yUaxTpXhbsuWjgj
 oWL2FugjItWKf8OJ60jY2UMVnt2kJwjni/d1rhnaWhpIvMh8zKEnBjREgH+aq8kxKiFtYFP2U88S7
 j3dCLnIGh0EKihi+sMREhXT5APV6NjauHuziKYR9mgPPankF5ScuR4T35Tsf05Lc+xFSfx1ipO8J1
 1GNKM6OZPqICIQeJ2HQZlgaKgh/AKTNqKwwEQEZaCTEmq8F891nV+Em2ZzZc7Y8f3HqKt9HB1ATij
 xyTzPOd7f12L5KaGpQjB3KlriIgZGcBQvA==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmps-00H9oS-Pt; Tue, 11 Aug 2026 15:48:08 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 10/20] Revert "drm/lima: Remove drm_sched_init_args->num_rqs
 usage"
Date: Tue, 11 Aug 2026 14:47:48 +0100
Message-ID: <20260811134758.96339-11-tvrtko.ursulin@igalia.com>
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

This reverts commit 098fe077ec029a1c8ded65af3c2b2a4190d93e9d.
---
 drivers/gpu/drm/lima/lima_sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 0a01213c4878..9a1e6b9ecbe5 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -521,6 +521,7 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 			       lima_sched_timeout_ms : 10000;
 	const struct drm_sched_init_args args = {
 		.ops = &lima_sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.hang_limit = lima_job_hang_limit,
 		.timeout = msecs_to_jiffies(timeout),
-- 
2.54.0

