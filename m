Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3252CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF83113FE4;
	Thu,  4 Jun 2026 12:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="JxxojNkL";
	dkim-atps=neutral
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Thu, 04 Jun 2026 12:44:08 UTC
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EF1113FE4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780576140; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IFeFW55r3k46twQxnhhwJGn+hZI4p4KWTSMxJ6U1GfWRfgVSQGMyDDMzggP1oHLX8jIweP135RTTQi4OxOIorf5vt2ukPvwCnRiggIT3LDNtKcBYJmK2DQL06+8nyzdsT1bvNMginjGgNOADlZQqQGKGK8L5o6p5233cxhLIPnM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780576140;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0vHBkPpCnUPH6Jl9eRW0EO2TNIRHLEYaZ5jQKQBYyaE=; 
 b=Hhp/3T1B9zA2rW8dZCDT4+mmP4Q9Pgi8LkOJvu7N/ZhCNCL5nsEvkX5n/w2sWjGiXoTzqdk0rpy5Fy9TbCYSDY8YxomrK7HffZKWo4f/3R4cV3EOVyx1x5SL+cQd742bhlFSD9ohTrAZOWrsOdX8sOMclTuNiIlrkfC1rfwk2LE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780576140; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=0vHBkPpCnUPH6Jl9eRW0EO2TNIRHLEYaZ5jQKQBYyaE=;
 b=JxxojNkLLQz/hCfJuhZZlDTq0neIAsn63PwlWPJrtLhfnwdxw48irrq6MwxLYQla
 oyu2Ja5RpAGkKEuP4gLXZpzMlF+GM2aqVad+hqLuFfz0eOfBMzT3torBHweqMj/hwhq
 oTBAMrEdaAplRwZlC2urSamikfrJYywdPKaxlcp0=
Received: by mx.zohomail.com with SMTPS id 1780576139073222.57659917037108;
 Thu, 4 Jun 2026 05:28:59 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/virtio: Fix driver removal with disabled KMS
Date: Thu,  4 Jun 2026 15:27:43 +0300
Message-ID: <20260604122743.13383-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

DRM atomic and modesetting aren't initialized if virtio-gpu driver built
with disabled KMS, leading to access of uninitialized data on driver
removal/unbinding and crashing kernel. Fix it by skipping shutting down
atomic core with unavailable KMS.

Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index f0fb784c0f6f..2aaa7cb08085 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 
 	virtio_gpu_release_vqs(dev);
 	drm_dev_unplug(dev);
-	drm_atomic_helper_shutdown(dev);
+
+	if (drm_core_check_feature(dev, DRIVER_ATOMIC))
+		drm_atomic_helper_shutdown(dev);
+
 	virtio_gpu_deinit(dev);
 	drm_dev_put(dev);
 }
-- 
2.54.0

