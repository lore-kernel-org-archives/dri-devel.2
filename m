Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4409BCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2237010EF7D;
	Wed, 13 May 2026 16:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iz7J+lbh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4933410EF7D
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778691542;
 bh=AAqKJoPOOkLMripnuQaHw9xbx35RrEUMeTSdxMx4p6s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iz7J+lbh0ukvjOToMFhD5Zp8Se4seX2ihx25f/7zzFUb0I7hTL8179T8uCclw+FSw
 1MRunWebsti7/QI1M/oKi7k3n2cTIo/Mb1LtRxiV4099JPsz8qbhZdDKsYSoFqDtb7
 B9hN248Y6p+ePLN9GNKED/cXdduVAQb0q485ypZmmKxANrbTGBD+4eqCZqGY2YfkrJ
 z12Go3GpLzOD3CKfNRrw5ud+cAnuQtUyDNaqNblSrYjK6NyUdkKn4ADkxANeNdT6ro
 CAszu8lPyEaUkjJW2sFw01FhuRYrqlWH83unEuhlFyH8Q9mKVU6axEOViIayI0oDAB
 A685TKVXB1fTQ==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 86F8B17E1584;
 Wed, 13 May 2026 18:59:01 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 13 May 2026 18:58:51 +0200
Subject: [PATCH 3/6] drm: Define a conditional guard for drm_dev_{enter,exit}()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-panthor-guard-refactor-v1-3-f2d8c15a97ce@collabora.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778691539; l=1053;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=AAqKJoPOOkLMripnuQaHw9xbx35RrEUMeTSdxMx4p6s=;
 b=FYRu54IWmcIrt4VqItE/N6hDpklTqfnMHVMRaefA+rhpji77Nnesrd2OBc/n1HO3aQJVUjjtc
 z7TIGQgNP8uDMCgjQngOurcrLUVY/qExit+MP4PzEpPLSs8Pva8lVXu
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

Define a conditional drm_dev_access guard to automate the
drm_dev_{enter,exit}() sequence.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 include/drm/drm_drv.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986d..79d1958f93e4 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -490,6 +490,15 @@ void drm_dev_unplug(struct drm_device *dev);
 int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 			 struct drm_wedge_task_info *info);
 
+/*
+ * Only the conditional drm_dev_access guard is valid. The drm_dev one is
+ * here so we can extend it with a conditional variant.
+ */
+DEFINE_LOCK_GUARD_1(drm_dev, struct drm_device,
+		    { WARN_ON("Use cond guards"); _T->idx = -1; },
+		    drm_dev_exit(_T->idx), int idx);
+DEFINE_LOCK_GUARD_1_COND(drm_dev, _access, drm_dev_enter(_T->lock, &_T->idx));
+
 /**
  * drm_dev_is_unplugged - is a DRM device unplugged
  * @dev: DRM device

-- 
2.54.0

