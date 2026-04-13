Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D72F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F4C10E4B6;
	Mon, 13 Apr 2026 15:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NCKJPxvs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4981110E4B6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k6y2qBMp0b6M9MtxIO2K/tj3CSyPVQrquKPrpgVZIbs=; b=NCKJPxvsgIhZzUs3LAKINO//gd
 bWNLfZr6jJy4dkagRsP0uRbB06b4edJmC1NYh1m1tgNVdi5y1CXzbUbHzbHviL+OEQxNuBBTX3sws
 tSLO78hmx28QEGwNQRSmbVK0wzuzvA3cVQjV/emDxn9p1Bj5CKNVeZbTVWqIT2HNM1Iir4EPhnAOR
 eIIEmZBILK1pbpJ6HrO872V4ebVzUL/n6Zzo5GYXLaV/2AfMwb6u3B3hnVuMbeDcMwr1xEnqPoy4a
 I0UQAg2WEDKN1LL0pdtaSkWRs8JieO/NQWLnC5GT8oxnCqaRaHeaZ+AoLpDk2YyIirMsaIupxv7Ft
 6X3DK7eg==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIqt-00FSq1-6O; Mon, 13 Apr 2026 17:05:27 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:16 -0300
Subject: [PATCH 01/10] drm/v3d: Drop unused drm_encoder.h include from
 v3d_drv.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-1-bac63a8ceb6c@igalia.com>
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=jOZ+09nruK8IookzwlNX5Rb8VXsXZCa6x2nEDa2oH2g=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYtETu6n7CjTMuh52dBpX+f5T83zaCRHr/AU
 RAbjNbYCmqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLQAKCRA/8w6Kdoj6
 qlaECACk1aawaeUdSssnJEoNgQt0qGRm7enhmjf9GeZIaLQiqYWL8iUuwu8TVSbokvHdMaotgoK
 uSzWvzEUBCKvF533ciVObHJgrXyUg4lLF/P+t6fEFiUe1TrvQ4dWrK2IcOPwStQFWV2xyv2keem
 rLkrbN4xp7sE37bgHwAib27nOqWGwL5Rdx/wJalP5gE4kSTRm5is0MkcqphlE0FCocx2S8CltUZ
 XQbMh3XgmpTjL9EeffEcnCSc1YQoJoYOdcydQW7n1XedHbFfRWb84IfsIRScsiiEg54bD9784Me
 u2PJVhLTaT+AUWzg1FgbHrcytHscBzXKz4hS27rt5XcWO0pN
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
2.53.0

