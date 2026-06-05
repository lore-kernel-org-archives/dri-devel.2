Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114B9CD6E75
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E55112A4A;
	Fri,  5 Jun 2026 02:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="G4y7xzCU";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 05 Jun 2026 02:14:32 UTC
Received: from mail-m2411.xmail.ntesmail.com (mail-m2411.xmail.ntesmail.com
 [45.195.24.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBF711A3B5;
 Fri,  5 Jun 2026 02:14:32 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
 by smtp.qiye.163.com (Hmail) with ESMTP id 412814aef;
 Fri, 5 Jun 2026 10:09:26 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: lyude@redhat.com
Cc: dakr@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 namcao@linutronix.de, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, Dawei Feng <dawei.feng@seu.edu.cn>,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Fri,  5 Jun 2026 10:07:52 +0800
Message-Id: <20260605020752.1707562-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e958adbad03a2kunme8b1df4229401
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR0fVktOGB0aSR9MQ08eSlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
 hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=G4y7xzCU87m6TM2r9nqttfnEpiwLXLmAUtmfJsKWNCxv2FIyJYSir3x5/iUP8pSqaa+aY9iIgL912ZjwsfFULxFMchyYUkPUhw90xVpfeHcY96zWxdGiTejHAeKcF2alBT9G+d7lUCcQrHWK3tFhXb3f3tp28LoWBKB7MIkwVtQ=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=9hPQlir0LYpa42uuWLi8uH8JCnnafnPqkGo+wT4cuCU=;
 h=date:mime-version:subject:message-id:from;
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

If loading the HS bootloader blob fails, nvkm_falcon_fw_ctor_hs() returns
immediately. This skips the common cleanup path and leaks the firmware
state allocated by nvkm_falcon_fw_ctor() and nvkm_falcon_fw_sign().

Fix this by routing the load failure to the 'done' label so
nvkm_falcon_fw_dtor() can properly clean up the partially initialized
state. Also clear the original 'blob' pointer after releasing it so the
final nvkm_firmware_put() remains balanced after a failed bootloader
reload.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
supported NVIDIA GPU with the required firmware to test this path, no
runtime testing was able to be performed.

Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for ACR FWs")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
index 4e8b3f1c7e25..71f55c5b0837 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
@@ -278,10 +278,11 @@ nvkm_falcon_fw_ctor_hs(const struct nvkm_falcon_fw_func *func, const char *name,
 
 	if (bl) {
 		nvkm_firmware_put(blob);
+		blob = NULL;
 
 		ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob);
 		if (ret)
-			return ret;
+			goto done;
 
 		hdr = nvfw_bin_hdr(subdev, blob->data);
 		desc = nvfw_bl_desc(subdev, blob->data + hdr->header_offset);
-- 
2.34.1

