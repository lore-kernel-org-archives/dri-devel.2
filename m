Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB64DCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD8510F8F4;
	Fri,  2 Oct 2026 15:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NmXC0YU3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1BC10E655;
 Fri,  2 Oct 2026 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=vsi4JzSeum98+ObpK+4AA5dBJvtqxXlmcyrKfm8FISc=; b=NmXC0YU3jDvh5j8BW5NftUW2Bl
 Xc+OZoD7gBnS9ptouJcxgG13pyfZkrdWwHtzzKD3fIUSCrEOvAe8W/XI9iVzejcQxk94XDaVonP3H
 +id/wJ5X/wc5PWwQdTHeku3pNwqunf89FgwMVpkrbw3ciQ9OIoh2uNXLu9XLvIChbVZnVqAqU3JBe
 dduBHKxTKqb8D+j/6/ycmXUYUnJExe3xFXaWS5vFwIyG3QslhvDWxnlftk/wMzw648Jx2azcE9UF2
 LPaBPPPSzCtuCLZPeaQR9QTCgXw36r6eN5GyXZp9VkwgUU6v+e8pjDoamxnbe9AQ5/P7sqzGRklEM
 pAKWnQLg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTk-00Aflz-Ar; Fri, 02 Oct 2026 17:47:20 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 6/9] drm/sched: Remove useless log message on memory exhaustion
Date: Fri,  2 Oct 2026 16:47:10 +0100
Message-ID: <20261002154713.77591-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
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

If scheduler initialization has failed due failure to allocate a handful
of bytes for the run-queue backing data structure, there will be plenty of
loud messages in the kernel log. We can safely remove the one
drm_sched_init() logs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 76acd0e4339c..00eb017fbcec 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1165,7 +1165,6 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 Out_check_own:
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
-	dev_err(sched->dev, "%s: Failed to setup GPU scheduler--out of memory\n", __func__);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(drm_sched_init);
-- 
2.55.0

