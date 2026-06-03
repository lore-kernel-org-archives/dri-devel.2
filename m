Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D994DCD6E6B
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6626112426;
	Wed,  3 Jun 2026 22:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GDyhE7pA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A38112424
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGzxWorI1WSPNnuszObDbT35PKIqjrK3mVfXTUiu0o8=; b=GDyhE7pAm3p/Hw1bz3X4YyVNT4
 1Yd2uL1WKe24BBqm1B20k1sB1vtxFQYHoSXLuJHDEFfi6hDaJ9dTgy+ro5iM8vcy2So6Tx9lJ5rEY
 zqCqjccuDoGPVsXY+gLd+tSdH/zx6NSI9TLAR5jOyAVeX4S9NtstEmVD2wsLvQ+1N585KntPijTSg
 LlMRXwu8ZxDQZuI1GcC01sjwBfPT0cZZ9SsWLmmrjoNmB6LqCATQQv27dHMjCfNW/X2x3W8SJW6cp
 F+Ci5WCJWqBAKishPkNJ4RE9lkvOBa8Fhb206Pn5jCH7i6dq7rCR3/QAoVwCnwU0r7JtzTICRJEcl
 meJAWafQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu1X-00CNgx-Ch; Thu, 04 Jun 2026 00:25:19 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 03 Jun 2026 19:25:03 -0300
Subject: [PATCH v3 01/14] drm/v3d: Drop unused drm_encoder.h include from
 v3d_drv.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-v3d-sched-misc-fixes-v3-1-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=scpYwZF1xTCU+NKRY+hI7mDvbzs1OcGFXyPoGpF+9yM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnF2t4zmQd4AjYi451gyQR8GMX0QkpW7N9Wx
 ylFOySQ1piJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxQAKCRA/8w6Kdoj6
 qs4zB/9tmt7uWv9d6xv8tbOy0RvgHF/s/YPgAECGuNoGgHnZWLx4OzU63yKZ1nU2gxl8EalpxlM
 qZ3gJD2xPjHe2iEOeSzCU0WixROZZw0UidvY5RBlZP2aqR6gMJNxEXyiCEn0ydlsDigaF5gFEW/
 +Nu887hnmjGr3h38/BcGk22IYD2r6azrXJWPcADDIbjqrHPsU4U6o8z5m+Hx515TYKPs1MYEOSA
 zkUA40bd5+O4pbJuMQCby1qfBc928kTCRVc4bf7fV7Y08sNaFpzOa1Rm3r+d4pl8NCkLIrGftwT
 bOfZE3IzdBwTowfRwRvmzR0aQKrc+dOr8WEMMaROn3U+gJ0v
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The V3D driver has no display pipeline, so nothing in the driver requires
drm_encoder.h. Remove the stale include.

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 4ebe175a8c6b..5a0b9da2c3aa 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -7,7 +7,6 @@
 #include <linux/spinlock_types.h>
 #include <linux/workqueue.h>
 
-#include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/gpu_scheduler.h>

-- 
2.54.0

