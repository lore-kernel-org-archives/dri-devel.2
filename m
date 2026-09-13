Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130CAC88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0DF10E9E1;
	Sun, 13 Sep 2026 20:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="aej3VOP8";
	dkim-atps=neutral
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5F610E8D8
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:52:35 +0000 (UTC)
Received: from seu.edu.cn (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3fa;
 Sun, 13 Sep 2026 20:52:30 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, bolin.liu@seu.edu.cn
Subject: [PATCH] drm/nouveau: validate required NET_img regions
Date: Sun, 13 Sep 2026 20:52:28 +0800
Message-Id: <20260913125228.110071-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad38ab103a1kunmc644730d251211
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkxMVh1PS0lITx4fQ0gYHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=aej3VOP82w76HOV1Pkn2hex74ttZ+/C75EM87dAw9JSzuK7yPnMNrcX5VcxDN2q1zCo19dyjbUHZjZbix53PIEdra2lyw8zUu4V1a72Gd229VX6AKlxgVZj/d+hgc1tuN9+MuBXJ/bhAi8Pj1gPdY+3ZonT4hVM3rRrfothnK4A=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=QNpEoAYO5tPIJrxr6Q1S8k9pTa9ZIFsxZipyEXigaYY=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The NET_img parser can finish without all FECS and GPCCS regions.
Reject missing required regions before computing their data addresses,
and release the firmware on both validation and ACR loading failures.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: c4bdac754ca0 ("drm/nouveau/gr/ga102: initial support")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
index 2b51f1d0c281..bfd1e00537b8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
@@ -317,6 +317,11 @@ ga102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
 		}
 	}
 
+	if (!fecs_inst || !fecs_data || !gpccs_inst || !gpccs_data) {
+		ret = -EINVAL;
+		goto out_firmware;
+	}
+
 	ret = nvkm_acr_lsfw_load_bl_sig_net(subdev, &gr->fecs.falcon, NVKM_ACR_LSF_FECS,
 					    "gr/fecs_", ver, fwif->fecs,
 					    fw->data + fecs_inst->data_offset,
@@ -324,7 +329,7 @@ ga102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
 					    fw->data + fecs_data->data_offset,
 						       fecs_data->data_size);
 	if (ret)
-		return ret;
+		goto out_firmware;
 
 	ret = nvkm_acr_lsfw_load_bl_sig_net(subdev, &gr->gpccs.falcon, NVKM_ACR_LSF_GPCCS,
 					    "gr/gpccs_", ver, fwif->gpccs,
@@ -333,12 +338,13 @@ ga102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
 					    fw->data + gpccs_data->data_offset,
 						       gpccs_data->data_size);
 	if (ret)
-		return ret;
+		goto out_firmware;
 
 	gr->firmware = true;
 
+ out_firmware:
 	nvkm_firmware_put(fw);
-	return 0;
+	return ret;
 }
 
 static const struct gf100_gr_fwif
