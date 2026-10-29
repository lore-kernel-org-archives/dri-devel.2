Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCD606B579
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZ3hZQ27
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F9C10E642;
	Thu, 29 Oct 2026 13:36:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF37310E80F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A55BA43FEB;
 Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5533E1F01825;
 Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280993;
 bh=hJYTrH+aur9SWWkX5ptStgA96ul/hKboEQv9ENEYer8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fZ3hZQ27jJv6PoU7yRKelGZvCmzVXIqCsUauLOz0zog2Nmd7hPp8xHyT4FFSFSuFK
 N6vDGMLkfpbBaHBtMUr4Ojm4GnOkshZ1N7HHNeROCnnpIb4yJQZHE8KtuQgqG9P13x
 f7afqpPIKnpEm3b45ODr1Hgv04cZCvLK75e6kaRNzyJDAh4ogpRoMc1R5/8pm5lbbm
 J01uFOlemdFrGUFO6vbofBMzUgnwr9TzbNXBBgJzp0m6y8y7lVYVjUA8qKbl/MbCmD
 4qKIsXIiNad6hCO3X5hnnsnOc8pekWcuGgJX/Qx6Q9eIF8gYE5qa9H51W3RTJxUKuZ
 AinyhM+qpOewQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:00 -0500
Subject: [PATCH v4 13/31] accel: ethosu: Prevent command stream export
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-13-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Command stream BOs are validated at creation time, but the generic PRIME
export path can expose their backing memory to a DMA-BUF importer. The
importer can then modify the command stream before the NPU executes it.

Reject PRIME export for validated command stream BOs while retaining
generic export for data BOs.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
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

