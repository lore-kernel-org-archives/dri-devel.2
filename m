Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF33FB3CEB
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C7F10E5AE;
	Mon, 30 Mar 2026 09:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="M58MqvZz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282CD10E5AC
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774864141;
 bh=13I7EMF2cf8HM8J5t3JwhzTEpcSRXcdWvOT1+w8dUJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M58MqvZz7TKX0CAP10WBqqb2BMNLWBWJnXueD8V/nQrVhuXaoVIIiHEyJMmvUNJt7
 WVoOJjyRrHuZRsvnIAh+KRZBs18gknP93LRtAefiFZx2FAlEowEtDDlL6A5/WFV8fM
 18ZNpeEncs+eZBuAm622PFnYMud54DnaasAuib6GiDg1YFCaSObtlAiZwjWiBaLpXE
 eYL1+EwwGFiaUw5Akc+SQ13r3noNX+1A+wEerXfuHeH6X9M25mIle/MCXMFG9v+giw
 D5LC8gsTcmn0vY3x2eqddbclh7nU8Cljf0psoG/ClJEMiyp6hdaT833Ilv2m5Kbs9Z
 3BV+I+h0GNyOg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 282BC17E41AC;
 Mon, 30 Mar 2026 11:49:01 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v6 4/9] drm/panthor: Don't call drm_gpuvm_bo_extobj_add() if
 the object is private
Date: Mon, 30 Mar 2026 11:48:43 +0200
Message-ID: <20260330094848.2169422-5-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330094848.2169422-1-boris.brezillon@collabora.com>
References: <20260330094848.2169422-1-boris.brezillon@collabora.com>
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

drm_gpuvm_bo_extobj_add() is a NOP if the object is private, but it
forces us to take/release the VM resv lock, so let's do that only when
we know the object can be shared.

v3:
- New commit

v4:
- Collect R-bs

v5:
- No changes

v6:
- No changes

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f8c41e36afa4..f490e0bf6cac 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1283,9 +1283,11 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	}
 
 	/* Insert BO into the extobj list last, when we know nothing can fail. */
-	dma_resv_lock(panthor_vm_resv(vm), NULL);
-	drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
-	dma_resv_unlock(panthor_vm_resv(vm));
+	if (bo->base.base.resv != panthor_vm_resv(vm)) {
+		dma_resv_lock(panthor_vm_resv(vm), NULL);
+		drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
+		dma_resv_unlock(panthor_vm_resv(vm));
+	}
 
 	return 0;
 
-- 
2.53.0

