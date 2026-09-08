Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F475C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0574110EDA0;
	Tue,  8 Sep 2026 22:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V47tf8M2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FCB10EDA0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:05:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B67960232;
 Tue,  8 Sep 2026 22:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA431F00A3A;
 Tue,  8 Sep 2026 22:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905099;
 bh=MWrrQYUhx+9Xsk9gELQ0A3vmgKNDW3R1AUupsQHIcE4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=V47tf8M21es2gsJFShqGh0OT7Wu7y7TV3PL+6zVD+h6IihAVfftXqBkz8LZ5tS8Ak
 K80ayyzR3G1k5KjDLgtd8F5sfTIjqYYKFLNRLt8EIrOFZIkGX8zxzkI4uIRlzXcKM5
 wn0M3QKDBg/yFEm7e76LkFeIijKJEA66wNQP5lg52ZjfoE6XJ7TAiEAJ/mYT2Bmenv
 aARMAT5oCw4PtALaub0eimraeZIhmTwgkb2YdklkMD2uOjanUMkJFLFDNND9wrfFyl
 8vHoooi6XEFzwLjsr3zJQT7lLyol1DCy8JHbdtcXyoRcyc/vqzOzvLcslUuiyXpUaR
 i2A8nK1MCn95g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:43 -0500
Subject: [PATCH v3 06/22] accel: ethosu: Prevent command stream export
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-6-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

Command stream BOs are validated at creation time, but the generic PRIME
export path can expose their backing memory to a DMA-BUF importer. The
importer can then modify the command stream before the NPU executes it.

Reject PRIME export for validated command stream BOs while retaining generic
export for data BOs.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 9afe2549ec84..c046aee42687 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
+#include <drm/drm_prime.h>
 
 #include "ethosu_device.h"
 #include "ethosu_gem.h"
@@ -30,9 +31,18 @@ static int ethosu_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vm
 	return drm_gem_dma_object_mmap(obj, vma);
 }
 
+static struct dma_buf *ethosu_gem_export(struct drm_gem_object *obj, int flags)
+{
+	if (to_ethosu_bo(obj)->info)
+		return ERR_PTR(-EPERM);
+
+	return drm_gem_prime_export(obj, flags);
+}
+
 static const struct drm_gem_object_funcs ethosu_gem_funcs = {
 	.free = ethosu_gem_free_object,
 	.print_info = drm_gem_dma_object_print_info,
+	.export = ethosu_gem_export,
 	.get_sg_table = drm_gem_dma_object_get_sg_table,
 	.vmap = drm_gem_dma_object_vmap,
 	.mmap = ethosu_gem_mmap,

-- 
2.53.0

