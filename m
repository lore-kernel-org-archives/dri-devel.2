Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB3CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FEA10E432;
	Tue, 26 May 2026 01:47:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190AD10E432;
 Tue, 26 May 2026 01:47:31 +0000 (UTC)
X-UUID: d8dd33c658a411f1aa26b74ffac11d73-20260526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f2a4c120-bc7d-45c2-ad90-49a96698b607, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:2f75ae6802a4740e16f1367a3d665be0,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d8dd33c658a411f1aa26b74ffac11d73-20260526
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 830269961; Tue, 26 May 2026 09:47:26 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] nouveau/gsp: fix NULL pointer dereference in r535 nvenc/ofs
 alloc
Date: Tue, 26 May 2026 09:47:21 +0800
Message-Id: <20260526014721.13299-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

nvkm_gsp_rm_alloc_get() can return NULL as well as error pointers.
The current code only checks for error pointers with IS_ERR(), which
would lead to a NULL pointer dereference if NULL is returned.

Fix by using IS_ERR_OR_NULL() instead of IS_ERR(), matching the
pattern used in nvkm_gsp_rm_alloc().

Fixes: 7c2d25f1e408 ("drm/nouveau/gsp: add common code for engines/engine objects")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c | 4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c
index acb3ce8bb9de..a67cc65abfcf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c
@@ -30,8 +30,8 @@ r535_nvenc_alloc(struct nvkm_gsp_object *chan, u32 handle, u32 class, int inst,
 	NV_MSENC_ALLOCATION_PARAMETERS *args;
 
 	args = nvkm_gsp_rm_alloc_get(chan, handle, class, sizeof(*args), nvenc);
-	if (WARN_ON(IS_ERR(args)))
-		return PTR_ERR(args);
+	if (WARN_ON(IS_ERR_OR_NULL(args)))
+		return args ? PTR_ERR(args) : -EIO;
 
 	args->size = sizeof(*args);
 	args->engineInstance = inst;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c
index 2156808cba4f..6d3b554108f9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c
@@ -30,8 +30,8 @@ r535_ofa_alloc(struct nvkm_gsp_object *chan, u32 handle, u32 class, int inst,
 	NV_OFA_ALLOCATION_PARAMETERS *args;
 
 	args = nvkm_gsp_rm_alloc_get(chan, handle, class, sizeof(*args), ofa);
-	if (WARN_ON(IS_ERR(args)))
-		return PTR_ERR(args);
+	if (WARN_ON(IS_ERR_OR_NULL(args)))
+		return args ? PTR_ERR(args) : -EIO;
 
 	args->size = sizeof(*args);
 
-- 
2.25.1

