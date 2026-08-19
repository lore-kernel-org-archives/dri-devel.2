Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD173C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 22:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4164B10E59F;
	Wed, 19 Aug 2026 22:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="L1SFKNGL";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A52410E59F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 22:45:28 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=AyEpzOmoZokcn98I4PpV2wK3LnYYCx7YqYVB4sid0oU=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787179527; v=1; x=1787784327;
 b=L1SFKNGL4iSI59NzIp3cyjzrqIbJr5d/D1svtnEY/gGrP+4HLI8WUP8Pbu5z9nIjILjEKAba
 IaGQBbefJx/+B38He9lorSxeS4gF13CZ7y+EGOaVkxJEYBUq2W6ct7e1alh3cvt7uj73OacUJFH
 cIK/7FnZzetBcF13ObwuJHAGe+4Mi5eZXmEd518yOpd7+xttJHjWtXuWX2MUZ+usNaMclFRo/Xs
 Z0PY9u+Cwi0A3gAGC5MkNUp3HH9Kyi/xgbNqubVt8eYybKrG5gyf4n3xkMs8E/JLlrMNNWVjPxw
 GCzVPSXnuJvrF2AuNVWiwFhX9poMEr7stN70N/32bOd7w==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 448221c47654d854;
 Wed, 19 Aug 2026 22:45:27 +0000
X-Mizu-Trace-ID: 448221c47654d854
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexdeucher@gmail.com>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v5 3/5] accel/amdxdna: do not warn when a sync request is
 rejected
Date: Thu, 20 Aug 2026 01:44:56 +0300
Message-ID: <20260819224458.257346-4-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819224458.257346-1-taimuraz@kaitmazov.com>
References: <20260819224458.257346-1-taimuraz@kaitmazov.com>
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

amdxdna_drm_sync_bo_ioctl() answers a failed amdxdna_flush_bo() with
drm_WARN(). Both of that function's error returns are decided by the
ioctl's arguments, so SYNC_BO with an offset past the end of the BO
splats and taints the kernel from an unprivileged caller.

Log it at debug level, since the same caller can repeat it.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 77a9493cd7ba..0e0f844526ca 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1310,7 +1310,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 		amdxdna_gem_unpin(abo);
 
 		if (ret) {
-			drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
+			XDNA_DBG(xdna, "Flush BO %d failed, ret %d", args->handle, ret);
 			goto put_obj;
 		}
 	}
-- 
2.55.0

