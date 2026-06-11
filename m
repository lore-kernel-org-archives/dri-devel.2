Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2C3CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B135810ED1B;
	Thu, 11 Jun 2026 07:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGUF1AFJ";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB3210ED16
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:26:39 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490d6730461so2703905e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781162798; x=1781767598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eKc8xoinNQulP3EE43EUw/q3KLX56zkxbj8GquDS6g=;
 b=PGUF1AFJ/SsGGWNeOzob070uVUgRy6aGZdBExgbRGmDiKc3bI1WqpN+/T0LCjN48dK
 l5oMvpPPvn9tLt9qguhPuxdCOPZ04Lu5DzKCH4Kul/FcILTY7k+9oTqiV3y4d078dxTZ
 XOx7cib/3oGpOKoZbijj2uD9sHVPxizYhHrv3fd5C1dYGZ/466+snDS0eQiTpWN3EqFN
 3W0h6979WsLcWXNAzCoR7YmOmuZ+1gv1zO7QFkNFbse29BNcrAGkWSu/w0nTK9vuIsnF
 vGeSRlCC8kj+LX2CthllOOnG3n6oj4kgCRfcHVBogjt4jbTg+ZOgTp5GBwSUD2EzZPvL
 V/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781162798; x=1781767598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5eKc8xoinNQulP3EE43EUw/q3KLX56zkxbj8GquDS6g=;
 b=C+BWENVclL/AeZpvuuExDVhrlxMOAqkpPPxTgXmazE3SGjuXXzc03nmUxM7SDn71QG
 WFe+vNn2JKC3d9/54XhDfuWYA8f02X7TX+UMBW4O1EEJ4pElkxXVieBdzO/3C77lbFTC
 /gCGrj7yKa5+2FpcX2GAAO+RO1LCaKFDpzXG+xSejgrPwY5F7g3XKZlw+pRWwwptDPiz
 I3YShKhTjWc2oQNR/1i5GqMENbMHn0a+y51VIvNKIFEyK3p3QNyacqYTufBkxyTaHa9P
 YTH/iKh1xOuGYCEZcGjc4B0bsquiLiiFAMYWb4kUFLxBv7VZCS2g6HyhMErUmufZbENP
 EXrA==
X-Gm-Message-State: AOJu0Yxtu10meeGe5N7VL975jTy0N4E3xSSqdud5xE2zJQvGz3SiQFkc
 RWAiC1goxmjTneIb5zCmQk5fK/IrG0yjVQ3Oe8+40CmOAjoENt3bokOlb3jG/tz4VK8=
X-Gm-Gg: Acq92OFvGP7DXKdP473vjk5GFsTnr5e0rfEczk2ziL31hV6CpIZja06EbhWY/Q07JW0
 jDkWN/Sxrq1Ir3rz0KYqaswCEv4Tv2e7vpXXVX+w7ZpRhJgBsjBznKCoDmq+kaqRRbgPSBsNIGd
 KC5M/NtvLqsEy5eTfb4qY6rR/uPyG5wptsIkIInbuAxxvQ8L061VPztujvZRsL/EWemkHRyoDp8
 bLXKkRpekDKmO00Hym3lY4JKDWU+nvP+zQPbLXs3F9k9MuKtY9akHKHp93i6sbTj+Tj2sf3X3Sn
 hj1vQlY50a+IQyL8tupMGTbW6ghwa4HzQDTrR+bxg4Oh+Ry4dhdTMvAjmkM0E5ob3JG2a6gCdUo
 bOg34BMSSW31SPJPWOJNtlr274opVMcXrQm2LANlbHUTS6u+Aspqg1b3rLxX8l97sryd016/aaj
 RhUS0ReyRsZ6xzIYYQS8X2mvKQAtqsC9hlXIZ9NK323V79IlcTZ4IClsjNb4N+0rowXzzUGgsYL
 lY7387JyhLkgzzaIFdYCguQDg==
X-Received: by 2002:a05:600c:3104:b0:490:b2b2:87d2 with SMTP id
 5b1f17b1804b1-490e561be8cmr6449625e9.5.1781162797702; 
 Thu, 11 Jun 2026 00:26:37 -0700 (PDT)
Received: from localhost.localdomain
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea21sm42585795e9.1.2026.06.11.00.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:26:37 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH v2 1/2] drm/nouveau/pci: use config-space MSI rearm on
 MCP79/MCP7A (NVAC)
Date: Thu, 11 Jun 2026 09:26:33 +0200
Message-ID: <b658dc52cf2f7ec9cf65ba80f7713c7f79988583.1781162589.git.marek@czernohous.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781162589.git.marek@czernohous.de>
References: <cover.1781162589.git.marek@czernohous.de>
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

From: Marek Czernohous <mczernohous@gmail.com>

From: Marek Czernohous <marek@czernohous.de>

NVAC (MCP79/MCP7A) uses g94_pci_func, whose .msi_rearm is
nv40_pci_msi_rearm(): a re-arm write through the MMIO mirror of PCI
config space.  On this IGP that path is unreliable; when a re-arm is
missed the interrupt line stays dead, command submission times out and
the GPU appears hung until reboot.  On an Apple Mac mini (early 2009,
MCP79, 0xac080b1) this showed as sporadic fifo timeouts and GPU hangs
under load unless MSI was disabled via config=NvMSI=0.

Give NVAC its own pci func that re-arms through real PCI config space
(nv46_pci_msi_rearm) instead.  This follows existing precedent: nv46.c
documents the MMIO-mirror re-arm as broken on several related parts,
and commit 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm") already
split g92 out of the shared table for the same reason.  The sibling
IGP NVAA (MCP77/MCP78) has MSI disabled entirely as "reported broken"
in nvkm_pci_new_(); NVAC works correctly once the re-arm goes through
config space, so disabling MSI is not necessary.

Only NVAC is switched: that is the hardware this has been validated
on.  The other users of g94_pci_func (G94/G96/G98/GT2xx and the
MCP77/MCP89 IGPs) keep their current behavior; MCP77 and MCP89
plausibly want the same treatment but were not tested.

Tested on the Mac mini as a daily driver for two months with MSI
enabled and zero fifo timeouts; independently confirmed stable on an
iMac9,1 (MCP79) running 6.12.90.

Fixes: 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm")
Cc: <stable@vger.kernel.org>
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
v1 -> v2: narrowed to NVAC via a dedicated mcp79 pci func instead of
changing the shared g94 table (only chipset the fix was validated on);
added Fixes/stable/Assisted-by tags.
v1: https://lore.kernel.org/nouveau/20260409172126.115441-2-marek@czernohous.de/

 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  2 ++
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c   | 33 +++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
index 112b674..88efe06 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
@@ -46,6 +46,8 @@ int nv4c_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct n
 int g84_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int g92_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int g94_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
+int mcp79_pci_new(struct nvkm_device *device, enum nvkm_subdev_type type,
+		  int inst, struct nvkm_pci **ppci);
 int gf100_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int gf106_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int gk104_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index b101e14..a809ec3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -1237,7 +1237,7 @@ nvac_chipset = {
 	.mc       = { 0x00000001, g98_mc_new },
 	.mmu      = { 0x00000001, mcp77_mmu_new },
 	.mxm      = { 0x00000001, nv50_mxm_new },
-	.pci      = { 0x00000001, g94_pci_new },
+	.pci      = { 0x00000001, mcp79_pci_new },
 	.therm    = { 0x00000001, g84_therm_new },
 	.timer    = { 0x00000001, nv41_timer_new },
 	.volt     = { 0x00000001, nv40_volt_new },
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
index a14ea0f..90f03ba 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
@@ -9,6 +9,7 @@ nvkm-y += nvkm/subdev/pci/nv4c.o
 nvkm-y += nvkm/subdev/pci/g84.o
 nvkm-y += nvkm/subdev/pci/g92.o
 nvkm-y += nvkm/subdev/pci/g94.o
+nvkm-y += nvkm/subdev/pci/mcp79.o
 nvkm-y += nvkm/subdev/pci/gf100.o
 nvkm-y += nvkm/subdev/pci/gf106.o
 nvkm-y += nvkm/subdev/pci/gk104.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
new file mode 100644
index 0000000..9f6a6cd
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: MIT
+/*
+ * MCP79/MCP7A (NVAC): like g94, but MSI re-arm goes through real PCI
+ * config space.  The MMIO-mirror re-arm is unreliable on this IGP and a
+ * missed re-arm kills the interrupt line (see the nv46 comment; g92 was
+ * split out of the shared table for the same reason).
+ */
+#include "priv.h"
+
+static const struct nvkm_pci_func
+mcp79_pci_func = {
+	.cfg = { .addr = 0x088000, .size = 0x1000 },
+
+	.init = g84_pci_init,
+	.msi_rearm = nv46_pci_msi_rearm,
+
+	.pcie.init = g84_pcie_init,
+	.pcie.set_link = g84_pcie_set_link,
+
+	.pcie.max_speed = g84_pcie_max_speed,
+	.pcie.cur_speed = g84_pcie_cur_speed,
+
+	.pcie.set_version = g84_pcie_set_version,
+	.pcie.version = g84_pcie_version,
+	.pcie.version_supported = g92_pcie_version_supported,
+};
+
+int
+mcp79_pci_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
+	      struct nvkm_pci **ppci)
+{
+	return nvkm_pci_new_(&mcp79_pci_func, device, type, inst, ppci);
+}
-- 
2.53.0

