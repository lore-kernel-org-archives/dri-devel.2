Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ACBCD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 06:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2A810EC8C;
	Thu, 28 May 2026 06:25:12 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AC810EC87;
 Thu, 28 May 2026 06:25:04 +0000 (UTC)
X-UUID: f459b61e5a5d11f1aa26b74ffac11d73-20260528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:2252d49b-4579-4e83-850a-9e842e9e17fc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:eecfb85d8b06434c670b26360a340b01,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
 5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f459b61e5a5d11f1aa26b74ffac11d73-20260528
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1972614382; Thu, 28 May 2026 14:25:00 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH 5/5] nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage
Date: Thu, 28 May 2026 14:24:51 +0800
Message-Id: <20260528062451.54107-6-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528062451.54107-1-zenghongling@kylinos.cn>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
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

Clean up the remaining IS_ERR_OR_NULL() checks in ctrl.c and rpc.c.
The underlying functions return error pointers, so IS_ERR() is
sufficient.

This affects:
- r535_gsp_rpc_ctrl() in ctrl.c
- r535_gsp_rpc_ctor() in rpc.c

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
index 70b9ee911c5e..aa0ebd3dfb17 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
@@ -42,7 +42,7 @@ r535_gsp_rpc_rm_ctrl_push(struct nvkm_gsp_object *object, void **params, u32 rep
 	int ret = 0;
 
 	rpc = nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, repc);
-	if (IS_ERR_OR_NULL(rpc)) {
+	if (IS_ERR(rpc)) {
 		*params = NULL;
 		return PTR_ERR(rpc);
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
index 41301f19729c..0c9657cb2dd7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
@@ -459,11 +459,11 @@ r535_gsp_msg_recv(struct nvkm_gsp *gsp, int fn, u32 gsp_rpc_len)
 
 retry:
 	rpc = r535_gsp_msgq_peek(gsp, sizeof(*rpc), &retries);
-	if (IS_ERR_OR_NULL(rpc))
+	if (IS_ERR(rpc))
 		return rpc;
 
 	rpc = r535_gsp_msgq_recv(gsp, gsp_rpc_len, &retries);
-	if (IS_ERR_OR_NULL(rpc))
+	if (IS_ERR(rpc))
 		return rpc;
 
 	if (rpc->rpc_result) {
@@ -561,7 +561,7 @@ r535_gsp_rpc_handle_reply(struct nvkm_gsp *gsp, u32 fn,
 		break;
 	case NVKM_GSP_RPC_REPLY_RECV:
 		reply = r535_gsp_msg_recv(gsp, fn, gsp_rpc_len);
-		if (!IS_ERR_OR_NULL(reply))
+		if (!IS_ERR(reply))
 			repv = reply->data;
 		else
 			repv = reply;
-- 
2.25.1

