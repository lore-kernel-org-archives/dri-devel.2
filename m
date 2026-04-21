Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEAF94CA0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5482E10E56F;
	Tue, 21 Apr 2026 17:52:45 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA50610E90F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:52:43 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.10])
 by APP-03 (Coremail) with SMTP id rQCowAC3vcReuedpblTLDg--.22569S2;
 Wed, 22 Apr 2026 01:52:32 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Brendan King <Brendan.King@imgtec.com>, Danilo Krummrich <dakr@kernel.org>,
 Donald Robson <donald.robson@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] pvr: acquire vm_ctx->lock before mapping memory to GPU VM
Date: Wed, 22 Apr 2026 01:52:28 +0800
Message-ID: <20260421175228.1928742-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3vcReuedpblTLDg--.22569S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kWw4Dury8Kw17tw1DWrg_yoW8Xry5pa
 1fX3ySg3y8KrW0q3WUJ3Wj9ry3Zw4rua4xGFykX3Z3Zr1rJ3Wqyr1Fqry5XF90yFs7tr42
 qrs0y343Xw12k3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
 8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
 1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
 sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-Originating-IP: [112.94.102.10]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

The drm gpuvm code doesn't protect find operation against map operation,
and the driver needs to ensure a map operation shouldn't happen when a
find operation is in progress.

As all occurences of drm_gpuva_find*() is already guarded by
vm_ctx->lock, make pvr_vm_map() to acquire this lock to prevent
disturbing any find operation.

This fixes occasional NULL deference in drm_gpuva_find*().

Cc: stable@vger.kernel.org
Fixes: 4bc736f890ce ("drm/imagination: vm: make use of GPUVM's drm_exec helper")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index e1ec60f34b6e6..eea88e7ad03c1 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -747,6 +747,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 
 	pvr_gem_object_get(pvr_obj);
 
+	mutex_lock(&vm_ctx->lock);
 	err = drm_gpuvm_exec_lock(&vm_exec);
 	if (err)
 		goto err_cleanup;
@@ -754,9 +755,11 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	err = pvr_vm_bind_op_exec(&bind_op);
 
 	drm_gpuvm_exec_unlock(&vm_exec);
+	mutex_unlock(&vm_ctx->lock);
 
 err_cleanup:
 	pvr_vm_bind_op_fini(&bind_op);
+	mutex_unlock(&vm_ctx->lock);
 
 	return err;
 }
-- 
2.52.0

