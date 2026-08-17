Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1786EC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E51E10E995;
	Mon, 17 Aug 2026 23:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="gRXyvJ0k";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E9810E995
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:07:41 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=hDtubHjp/xMGNMwNAq0xYxCKHC6+VbTRAs+CykGwDBs=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787008058; v=1; x=1787612858;
 b=gRXyvJ0kGPOARyCovpv8TBxKvWd4Mi6mMLJomr4uq7CcLQCrncoq8x3h5NuzqbGZ/662Q6an
 xcpC6AJsjdKfiUUoZNnAyoT37OhCAtp1zE1Y+cqGtveEw8YpFxh2cdNN+iyQe7P41ODtsP3AHZa
 ZSzcDINtDBL6ILnF9+zXISegldoTuij6tQ+m5gPOhR3TIPmbT0PvJTAD7hsZDU4CgTJ4z844qLo
 p5h6UrehZ/kVzqVdsXMbAiSMAs2dodAYabzCfPsA86ZTyAyzLlbRSth+yspvDDkTl1jM5SJhD+j
 KTrgbcUNrkW0708Eh7KtjEYoycuitUR+CSyZtZ/ldO+LQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id a617dcd1e5ca65bd;
 Mon, 17 Aug 2026 23:07:38 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, alexdeucher@gmail.com,
 max.zhen@amd.com, sonal.santan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v4 3/5] accel/amdxdna: do not warn when a sync request is
 rejected
Date: Tue, 18 Aug 2026 02:07:05 +0300
Message-ID: <20260817230707.356828-4-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817230707.356828-1-taimuraz@kaitmazov.com>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
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

Log it like the pin failure above it.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 77a9493cd7ba..4f38f985c74e 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1310,7 +1310,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 		amdxdna_gem_unpin(abo);
 
 		if (ret) {
-			drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
+			XDNA_ERR(xdna, "Flush BO %d failed, ret %d", args->handle, ret);
 			goto put_obj;
 		}
 	}
-- 
2.55.0

