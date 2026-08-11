Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F912C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A3D10EC04;
	Tue, 11 Aug 2026 13:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Xzrk+qNJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D2610EBDB;
 Tue, 11 Aug 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=ON/9GW2ElhJwOWI6pf48bkmDYkLfMBBb8xeMza75pgw=; b=
 Xzrk+qNJYD0u/97cpFPKX0m9WLO9JIAQmc3IpX/KJJ9vLpqdIIXJJuGAqIBEXvlvpyuITAkJKp7bO
 y/PGUNp0RRstmhz3XBgXtrbH++EJppABQdgZMtMJV03uoiuj1hGx/a+mutF6O8Hq/TKLsF2N3raGY
 fbk0w8OxFMzZ31qDs9a6uyv4lA2xWzOqnLdC1t8ObbkyR64Q/mlDI25ksY6MQQLqsUn5H2upgK3Xh
 qSXZmFGn1mNnCKiALtsZ3mRf/aCX2alDnLpzfoEmGlfKoLPzFpW3yJc4ebONgkIiQn5hVza5I6u9P
 jmq/YcEnhPzhflx9oJ5YepAlwTVruNDRgA==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpo-00H9ms-3S; Tue, 11 Aug 2026 15:48:04 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 04/20] Revert "drm/v3d: Remove drm_sched_init_args->num_rqs
 usage"
Date: Tue, 11 Aug 2026 14:47:42 +0100
Message-ID: <20260811134758.96339-5-tvrtko.ursulin@igalia.com>
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

This reverts commit a1bf9381fc62f3c4e26a2caedb8317046383a559.
---
 drivers/gpu/drm/v3d/v3d_sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 50d4166bfe75..e6283a75bcdf 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -826,6 +826,7 @@ v3d_queue_sched_init(struct v3d_dev *v3d, const struct drm_sched_backend_ops *op
 		     enum v3d_queue queue, const char *name)
 {
 	struct drm_sched_init_args args = {
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.timeout = msecs_to_jiffies(500),
 		.timeout_wq = v3d->reset_wq,
-- 
2.54.0

