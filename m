Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED73CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0DB10E428;
	Sun, 10 May 2026 22:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fTlhbuvS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470D310E42E
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GiA3N7Kw6o97xhAR6vODtvJ0s3mz3ghj2FnYSXeHJwM=; b=fTlhbuvSjnQiFl85+49thEVM6j
 v4J6vDjhTZeWflfqzkTil9MrFW9/icl8vqdlypiE6tzZX8fUYeKgOV0zP1Yr/oBngiAI3Go3hJQka
 GjRtWecIEUTz8qyG/537Ha6cNbO6mMtd+H2j/5TCuUDvuf6pl5Hl4Z9GfWVKcps83cfbalqLPXGGr
 0BYt4jWMZadwdkGQ4zS7Y5o9YWd9NpBw9orXD/69ScpDF605x3MEN5dHq296RIhvlwAOZEOWNPenZ
 WGPRlSgzSk0vDW4GDV9mzOcvIj4vW3CMDbFj6kzEWngJRx3ymRwulmdWIg/psKOcZ2alJC2w97oWT
 dRwohQDQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCNi-008k1J-Jw; Mon, 11 May 2026 00:12:14 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:11:58 -0300
Subject: [PATCH v2 01/14] drm/v3d: Drop unused drm_encoder.h include from
 v3d_drv.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-1-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
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
 h=from:subject:message-id; bh=BvwjvlTs/1agsHt2s2KJ+GxhOg//L7rFBv1Tg3JxMeE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQKzIl0YkwczE7m9nWjY4C3De2ne/u20IPCN8
 fedJx8WjB+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECswAKCRA/8w6Kdoj6
 qidrCAC7ZHteMbIZjo15phV2ExyHz+pe+pwie1vx9s3ib1aTILRYoQB7HzVQkCkJV5V+qXA+3l+
 JivsQ3dHpe/P0Mj4xS4QCBBa3pON87rillt/u2NBfr7loOqxmbng3aN1a9BXkVLWnlcG2L1Gpip
 jbTykj6R3pdWOwhINBt3sFrB+CHe6xgq/uegs7YY0rEgw/0TcFSREAGO9nQhLYVqZebKBXSAJ7S
 sF741ID55CQgKBLh7VF0pJEtd+dXycd5aGIe7DGAfKQUI16y1dxCuXEbhIzgAg/ZyE4/OgSt4/J
 t9hyeZaWV5plOLBWDAhOe9onMpk8ggXGs8o373FxBeJk6+gh
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
2.54.0

