Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F877C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730C010E999;
	Mon, 17 Aug 2026 23:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="IQxyGC1j";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E898510E996
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:07:46 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=wnkkhvIdl8hl3bhTqmwNGuieJgvlWhbLMhY01fpF43Q=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787008065; v=1; x=1787612865;
 b=IQxyGC1jv9Kc923ssEDoiXBSOeQ9E5fvRVh24Kqxl+NCdx6d5nkBFRe/bSUWOlrp1w/yMMit
 6swyVQZj0WfwBNvE9l/96oNaDjNAdcHBk4N/AhOOq+yIwAphtlH0yRtH1MxbLWSFJFTADQuaQuD
 uddvJ/pOQahEqUFQcwMHUBz7NKuuQO5L7WBCuoYZbiKIkqyvD4hwSVHZUwBh02SRx79VaKihYUd
 KPvo26MtPV2gLVZdxDO2nGZ1CQ6aHhfPgfQbGGWZaNzv5+TUAnwm4Iz2n0DjPrfviiVUE5mdw4g
 nS7p+dPfTojlVmNsIjMEQgBFj7sJdnY1K95vbEFM9ZeVg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id e8e36114d302c11b;
 Mon, 17 Aug 2026 23:07:45 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, alexdeucher@gmail.com,
 max.zhen@amd.com, sonal.santan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v4 5/5] accel/amdxdna: do not fail a sync for a BO with no
 debug context
Date: Tue, 18 Aug 2026 02:07:07 +0300
Message-ID: <20260817230707.356828-6-taimuraz@kaitmazov.com>
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

amdxdna_drm_sync_bo_ioctl() calls amdxdna_hwctx_sync_debug_bo() for every
FROM_DEVICE sync, which answers -EINVAL when the BO has no assigned hwctx.
Only a BO attached with ATTACH_DEBUG_BO ever gets one, so an ordinary
read-back sync reports failure after its flush has already run.

There is no debug buffer to sync in that case, so answer success.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 855da8c79a1c..c0d0aa53c596 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -416,7 +416,8 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
 	guard(mutex)(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
 	if (!hwctx) {
-		ret = -EINVAL;
+		/* Not attached as a debug BO, so there is nothing to sync. */
+		ret = 0;
 		goto put_obj;
 	}
 
-- 
2.55.0

