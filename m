Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6765F43694
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF9410EA39;
	Fri, 17 Apr 2026 10:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JGwuwgXx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2095410EA2B;
 Fri, 17 Apr 2026 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qZIsFYmEwmNabOPsdbc8918/y678dDaOBlNw05NZMZ8=; b=JGwuwgXxiAjOfi5GFzn7HVgZuW
 mwdP8JkkpCS24d7DEn1vR6bebmEP+twooxnID8Wt3Rx3rstWJZ1LXzs438kG6K290HhLbqCgfUR1s
 0hlpOa3mi01JYvytUG7mhOJ9QtPgTwcT2fRazr/HZZX5rwEJuMIaMvDAczFgU/ukf9f9JC7FYsPTv
 UtmvaXH51UX1JsPbTyo6gPR5cEFcSr75TdQdbLoyDH1FUHSDjWjVDGwmOnYQe8U9C+OIFv9KM5UfU
 IO4kQxT/Usxg1fhMeRHgp/irVqb6LtuG3Jxh8bG50sMq+VpVSquQ8v/svlJDz7QHBxSe+s7+F+wbp
 rNzxxm1g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wDgaP-00HPVA-DB; Fri, 17 Apr 2026 12:38:09 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v8 27/29] drm/v3d: Remove drm_sched_init_args->num_rqs usage
Date: Fri, 17 Apr 2026 11:37:42 +0100
Message-ID: <20260417103744.76020-28-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
References: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
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

Remove member no longer used by the scheduler core.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
Acked-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1855ef5b3b5f..c01fa90def4c 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -838,7 +838,6 @@ v3d_queue_sched_init(struct v3d_dev *v3d, const struct drm_sched_backend_ops *op
 		     enum v3d_queue queue, const char *name)
 {
 	struct drm_sched_init_args args = {
-		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.timeout = msecs_to_jiffies(500),
 		.dev = v3d->drm.dev,
-- 
2.52.0

