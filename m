Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69E4C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D73C10E3BA;
	Fri, 26 Jun 2026 14:40:01 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F030810E3BA;
 Fri, 26 Jun 2026 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.75.66])
 by APP-01 (Coremail) with SMTP id qwCowAA33NQ5jz5qf3RqAw--.18622S2;
 Fri, 26 Jun 2026 22:39:55 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/nouveau: nvkm_chan_new_: multiple error paths return
 without releasing acquired references
Date: Fri, 26 Jun 2026 22:39:53 +0800
Message-Id: <20260626143953.48952-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA33NQ5jz5qf3RqAw--.18622S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5ur18urWxZw15KryDZFb_yoW5WryxpF
 43WayYkr18trsYyas2yr48GasIyw4UKw4jka4UCw1SvrnxXrW8Cr4rAa10vFZ5Jr4xGr45
 GFsIqa4SqF15Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
 nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUKA2o+iCgR+wABsK
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

After allocating chan and acquiring references on cgrp, vmm, memory, and
  chid, numerous subsequent error paths return ret directly without calling
  kfree, nvkm_cgrp_unref, nvkm_vmm_unref, nvkm_memory_unref, or
  nvkm_chid_put. Every error return after the initial allocations leaks one
  or more acquired resources.

Cc: stable@vger.kernel.org
Fixes: 06db7fded6de ("drm/nouveau/fifo: add new channel classes")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 .../gpu/drm/nouveau/nvkm/engine/fifo/chan.c   | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
index 418a8918bcb8..1bf595bafa9a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
@@ -410,18 +410,18 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 			      &chan->inst);
 	if (ret) {
 		RUNL_DEBUG(runl, "inst %d", ret);
-		return ret;
+		goto done;
 	}
 
 	/* Initialise virtual address-space. */
 	if (func->inst->vmm) {
 		if (WARN_ON(vmm->mmu != device->mmu))
-			return -EINVAL;
+			goto done;
 
 		ret = nvkm_vmm_join(vmm, chan->inst->memory);
 		if (ret) {
 			RUNL_DEBUG(runl, "vmm %d", ret);
-			return ret;
+			goto done;
 		}
 
 		chan->vmm = nvkm_vmm_ref(vmm);
@@ -432,7 +432,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 		ret = nvkm_object_bind(&dmaobj->object, chan->inst, -16, &chan->push);
 		if (ret) {
 			RUNL_DEBUG(runl, "bind %d", ret);
-			return ret;
+			goto done;
 		}
 	}
 
@@ -443,13 +443,13 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 			if (ouserd + chan->func->userd->size >=
 				nvkm_memory_size(userd)) {
 				RUNL_DEBUG(runl, "ouserd %llx", ouserd);
-				return -EINVAL;
+				goto done;
 			}
 
 			ret = nvkm_memory_kmap(userd, &chan->userd.mem);
 			if (ret) {
 				RUNL_DEBUG(runl, "userd %d", ret);
-				return ret;
+				goto done;
 			}
 
 			chan->userd.base = ouserd;
@@ -461,7 +461,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 
 	if (chan->id < 0) {
 		RUNL_ERROR(runl, "!chids");
-		return -ENOSPC;
+		goto done;
 	}
 
 	if (cgrp->id < 0)
@@ -475,8 +475,17 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, struct nvkm_runl *runl, int ru
 	ret = chan->func->ramfc->write(chan, offset, length, devm, priv);
 	if (ret) {
 		RUNL_DEBUG(runl, "ramfc %d", ret);
-		return ret;
+		goto done;
 	}
 
 	return 0;
+
+done:
+	if (chan->id >= 0)
+		nvkm_chid_put(runl->chid, chan->id, &chan->cgrp->lock);
+	nvkm_memory_unref(&chan->userd.mem);
+	nvkm_vmm_unref(&chan->vmm);
+	nvkm_cgrp_unref(&chan->cgrp);
+	*pchan = NULL;
+	return ret;
 }
-- 
2.39.5 (Apple Git-154)

