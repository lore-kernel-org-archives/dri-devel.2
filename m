Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD6EC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5DA10E1F8;
	Thu, 27 Aug 2026 20:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JEPy6ki8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9499B10E1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FB744182A;
 Thu, 27 Aug 2026 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8D01F00A3A;
 Thu, 27 Aug 2026 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862798;
 bh=IdrnkpO3EzdVTmDSOgcFTiAoRe1SyW/dmxYVVke1fVs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JEPy6ki84+j3c0MBpLgac1q0eGsGl8Eec2pcb+Z7oPjDjMnKDJfo+7Ejzbqu66P7T
 +dm6uqiPMBqrdCYQjl9eCKBsvGKuWVMVFCK1lfoCeehoYOK5/S29vHibBqFPMSwhBf
 f6s3+ANgfIUEWrXyKNIn4LBjRY6cyDqdiOeIZSLjkIvK3pEQ1tsrU6kwwKQK0+vKwF
 jHDAZYmu9JFwO0nZO3+dn8o6bjDxehyRAjUyne3DscN6CNL0bfBccocwqxQyMuvaEV
 vYrTLNDDNiizp6DdXr8urcBhKMYQp+7mRWOfUVxy4nw3rH9JhGUux4KWyRRU1ZrIvV
 UUgYBwTa9AB6A==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:00 -0500
Subject: [PATCH 01/11] accel: ethosu: Fix ethosu_job_open() return value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-1-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
In-Reply-To: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

A WARN_ON() returns a 0 or 1, not the original negative errno. Just drop
the WARN_ON() as the FD open will pass the return code to userspace and
there's only one possible source of the error (drm_sched_entity_init()).

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_job.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 6a038c0384cc..99c8812691e5 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -368,12 +368,10 @@ int ethosu_job_open(struct ethosu_file_priv *ethosu_priv)
 {
 	struct ethosu_device *dev = ethosu_priv->edev;
 	struct drm_gpu_scheduler *sched = &dev->sched;
-	int ret;
 
-	ret = drm_sched_entity_init(&ethosu_priv->sched_entity,
-				    DRM_SCHED_PRIORITY_NORMAL,
-				    &sched, 1, NULL);
-	return WARN_ON(ret);
+	return drm_sched_entity_init(&ethosu_priv->sched_entity,
+				     DRM_SCHED_PRIORITY_NORMAL,
+				     &sched, 1, NULL);
 }
 
 void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)

-- 
2.53.0

