Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1FDC5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7497A10E998;
	Mon, 17 Aug 2026 23:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="y2URJesB";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB36610E998
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:07:45 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=r5BQO4WY749LimYnXVPYhA5lxxL2G5hYYQKhHdZkGA8=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787008063; v=1; x=1787612863;
 b=y2URJesBpqcHMzZieW0W/dVKL3fZgc0cyNGtd6XLaHAcDMhdTjyQXGJqCrSNoDbHJCBFxt9O
 nMZHscpV1uR/iliqFmOTQb6YG0Ibo/vkO2aQusl2SqcRG3pPNc59RgkE3Oc5bFFbcz0ZKEi9aY8
 XUP2P15DKiXPjG8ClngGzv2aXI1EypJRxj0+7/i+7tSrz+USmhjj2BL+T3H8c+MrNbwMqRaSGIT
 LZQQAAsCV0CbZWzt1c9dlVug32sjGn1JQxHpJGSYkok9VdpK/KGBDTibVWFBGla6CKMVDii5hRS
 Y6FrHspuAo6dVJKhc4pCNr0iaRZ66fwvBTB7Q5JHNXtyg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 590bce2c18ae208a;
 Mon, 17 Aug 2026 23:07:43 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, alexdeucher@gmail.com,
 max.zhen@amd.com, sonal.santan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v4 4/5] accel/amdxdna: refuse to flush an imported BO
Date: Tue, 18 Aug 2026 02:07:06 +0300
Message-ID: <20260817230707.356828-5-taimuraz@kaitmazov.com>
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

SYNC_BO clflushes an imported BO's scatterlist. An importer may not do
that: the memory belongs to the exporter, and dma-buf gives the importer
no interface to ask for maintenance on it. Refuse the request instead.

is_import_bo() is (obj)->attach, which covers more than foreign buffers.
A userptr BO arrives through a ubuf, and on a carveout device every share
BO and the device heap arrive through a cbuf, so SYNC_BO answers
-EOPNOTSUPP for those too, including the AMDXDNA_BO_DEV path that flushes
through its heap.

Only the ubuf case gives up maintenance it was getting: on a 64 MiB
userptr BO a 4 KiB sync and a full sync both cost 659 us, this arm having
ignored the range. amdxdna_cbuf_map() fills in only the DMA address and
length, so drm_clflush_sg() already walks zero pages on carveout memory.
Userspace maintains these through the mapping it already holds, as XRT's
buffer::sync() does unless it is told to sync through the driver.

Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 4f38f985c74e..a713a9982d34 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1224,6 +1224,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 {
 	u64 end;
 
+	if (is_import_bo(abo))
+		return -EOPNOTSUPP;
+
 	if (offset >= abo->mem.size)
 		return -EINVAL;
 
@@ -1234,9 +1237,7 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 	if (!size)
 		return 0;
 
-	if (is_import_bo(abo))
-		drm_clflush_sg(abo->base.sgt);
-	else if (amdxdna_gem_vmap(abo))
+	if (amdxdna_gem_vmap(abo))
 		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
 	else if (abo->base.pages)
 		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
-- 
2.55.0

