Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90180C5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4B210EDC1;
	Tue, 11 Aug 2026 23:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="FaW9+3Rf";
	dkim-atps=neutral
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC68810EDC1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 23:22:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786490066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxfYNX+Hd4Q+pPx1Zw++iFweRyJ12Dx1jgRIxqQMzA8=;
 b=FaW9+3RfXkFMg2JPUa9c5/dZfocd+GJNyXo1NTGFGO7otd7Uz8kYOspPADoUoSBdVw4qmR
 TQvGTvhggZHGh3CPIKkN1WG7gL14wm5Sk/Rh2sbf0tQOiPMWdO3/gXSOPwyVNnWlIafIJl
 8DRoTTVFwRi6NOCLP1f2+860k5vPTDO1V2RlGRQD8yIGCnscGgo8ARAMD6eDrtzEvCfTPm
 WEgcdeV4zxVRhQXkH7JwcFIwLCWs0eNQeBmvuyVLjoKfhCmQBpIztZtSvBtpv7KvIouEeg
 oc3QWa0nlfQzjYkVSpNMXCjGGeUpe8BEtfJ9sZpHwf5NM3kW3kzun4xPr1+NZQ==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v2 2/5] accel/amdxdna: add a quiet variant of
 amdxdna_gem_vmap()
Date: Wed, 12 Aug 2026 02:13:48 +0300
Message-ID: <20260811231351.1011244-3-taimuraz@kaitmazov.com>
In-Reply-To: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

amdxdna_gem_vmap() logs an error whenever the mapping fails, which suits
its callers: each of them treats a failure as fatal to the operation it
is performing. The next patch adds one that does not, and an exporter
that implements no vmap op fails every call without anything caching
that, so a logging probe would print on every ioctl.

Split the mapping out into __amdxdna_gem_vmap(), which returns the error,
and leave amdxdna_gem_vmap() as that plus the log. No caller changes: it
still returns the address, or NULL after logging.

The log takes the device from the GEM object rather than from abo->client.
amdxdna_gem_obj_close() clears that pointer once the last handle to the BO
is closed, which a job holding its own reference can outlive.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 30 ++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index b66ec9e48..1b8e90cd7 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -191,12 +191,8 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
 	kfree(abo);
 }
 
-/*
- * Obtains a kernel virtual address on the BO (usually of small size).
- * The mapping is established on the first call and stays valid until
- * amdxdna_gem_vunmap() is called.
- */
-void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
+/* Returns the error instead of logging it. */
+static void *__amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 {
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
 	int ret;
@@ -210,13 +206,29 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 	if (!abo->mem.kva) {
 		ret = drm_gem_vmap(to_gobj(abo), &map);
 		if (ret)
-			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
-		else
-			abo->mem.kva = map.vaddr;
+			return ERR_PTR(ret);
+		abo->mem.kva = map.vaddr;
 	}
 	return abo->mem.kva;
 }
 
+/*
+ * Obtains a kernel virtual address on the BO (usually of small size).
+ * The mapping is established on the first call and stays valid until
+ * amdxdna_gem_vunmap() is called.
+ */
+void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
+{
+	void *kva = __amdxdna_gem_vmap(abo);
+
+	if (IS_ERR(kva)) {
+		XDNA_ERR(to_xdna_dev(to_gobj(abo)->dev), "Vmap bo failed, ret %ld",
+			 PTR_ERR(kva));
+		return NULL;
+	}
+	return kva;
+}
+
 /*
  * Free mapping established through amdxdna_gem_vmap()
  */
-- 
2.55.0

