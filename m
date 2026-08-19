Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6773C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 22:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143B310E1BF;
	Wed, 19 Aug 2026 22:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="OiZuyALs";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DA310E1BF
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 22:45:18 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=+ASMGtrMOeusPXkPPDG/b0fd350EBV0tjJwDMfZVciI=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787179516; v=1; x=1787784316;
 b=OiZuyALsqc9K0CfxZSRIbq8SLGKXRDBkDpwUdAsmPeG8Xw16rlhc0KCP43V1GrBo4ScjJr4F
 Vp029FHo5wgrnuw4A6SdRHt6geSeX8GVvkHBLMAvM0uKSiNXr8xkBHCSAi1qxTKzGRKAn2qw7mT
 VQ4ZZx/f4D83KP2HF5MCy8FdF7jmJE7jI8BZituTHGSF0bfHgGE+SzWzGGDxSeovabKp35r5uKg
 D4pbcn4BoGOss4xhBcHK8l1xOWL4a9sB0Xb5542Duf6SKFenKUAGtKWm6R2H+FQ7N7UGhrQpBY7
 SpPGwtI3AoBri1Ry4RmlKGGU2DW1WGW15jXDkd9zzfKBA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id d4d7defded4ff9d9;
 Wed, 19 Aug 2026 22:45:16 +0000
X-Mizu-Trace-ID: d4d7defded4ff9d9
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
Subject: [PATCH v5 1/5] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Date: Thu, 20 Aug 2026 01:44:54 +0300
Message-ID: <20260819224458.257346-2-taimuraz@kaitmazov.com>
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

amdxdna_gem_vmap() flattens the iosys_map drm_gem_vmap() fills in down to
the void * in abo->mem.kva, and iosys_map is discriminated by is_iomem, so
an exporter answering with an I/O mapping leaves a void __iomem pointer
there, which amdxdna_cmd_set_error() memsets and memcpys through.

amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
object, so an NPU paired with nouveau or radeon does.

Drop such a mapping and answer NULL. Checking here rather than in the
.vmap callback leaves that callback's iosys_map contract intact for a
caller equipped to read I/O memory, and covers everything that takes a
plain kernel address through this helper. vmw_gem_vmap() refuses the
same case; unlike that one this path is reachable from an unprivileged
ioctl, so it neither warns nor logs at error level.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index cca84fa07e9d..f88b5349cd4b 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -209,10 +209,15 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 
 	if (!abo->mem.kva) {
 		ret = drm_gem_vmap(to_gobj(abo), &map);
-		if (ret)
+		if (ret) {
 			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
-		else
+		} else if (map.is_iomem) {
+			/* Callers use the result as an ordinary kernel address. */
+			XDNA_DBG(abo->client->xdna, "Vmap bo returned I/O memory");
+			drm_gem_vunmap(to_gobj(abo), &map);
+		} else {
 			abo->mem.kva = map.vaddr;
+		}
 	}
 	return abo->mem.kva;
 }
-- 
2.55.0

