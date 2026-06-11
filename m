Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E500FCD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E10610EEE7;
	Thu, 11 Jun 2026 12:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X83bS2F+";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B04F10EEE8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:45:40 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45ef4332d89so556847f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781181939; x=1781786739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXPVPLZ24FFS4gpZDOA+n5sn4Zne5FOUIT6Mg5+7lsY=;
 b=X83bS2F+P5UTFoYvbkx83jazxgqq2q0AdVpqsJFmAsGgDeVI5VGnkV86RWA84+kI/a
 m+rRSiYxw5hfphJYG/kevAzR4cRZp20ry+ntleskl2co41T03MT5M6kdMM8YBu3/6qXa
 4FZmouUSrgb0WRZepyuFJNGn7y2KhS+bK7ILycoEVcnP96KEepipLIdpO7vEAFed2iku
 kx9XXuozygrAV/nOu0zfU/PX4MryhMEJaxw4ru/ZmiHnrhajEK5yB0wXNQPZ6C0/EMUT
 6Zee7iG6oZJUaBhcgZ+1CFlc4ZMGnnxcvIEcImklDVdqi/PwSe475U6uITX03HYSVOTm
 I0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181939; x=1781786739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXPVPLZ24FFS4gpZDOA+n5sn4Zne5FOUIT6Mg5+7lsY=;
 b=hncHd9Z37OXA6efA3VD9n6xYGhSdAXxdocxQJCX51UuZChz618o+9vysp6d3q8qDw5
 q0V9Ac1KeXoOb0KYc8ZGOuGSyad+7idv0UjyimEmo/4Wi2Vb1LWCTQ0CiYSmNMDSHvBX
 xxVSAkCYyDnClc6I2JC2XCXIaldsvN29Igv4LMG5RRiMVeFpwT4IoR3WbbYYuGFNU10o
 S7qah+O43o8l5Rvrrokhj3PAI5QTquVxU3Ci5402r0uWUSFhnBUiYtiSK8929Jq0/xdF
 26eJ2b2AX/Xyk1PEdBofRVFUKbStCaCIum5Z6ydyuPPguFMGzWhmRGNBkEIoYcym1VMP
 8aUQ==
X-Gm-Message-State: AOJu0YwQZIJnLdkQgrQ1DBNCIjVGMqYEwlswcF2ByWeqHYtVjqQl+LcQ
 kZ3SPN1myQvhW7vfkANovD/nm0qpRbgxirZ3tNf95TQ6EvUDZ08yxjLl
X-Gm-Gg: Acq92OEkqzh/a6eD80y/ZzfHA2oWXAJD5AZoML69bTB387shZInnJAa30lkdyG/WC4F
 1IonurcoLCymHcGTY1O/VWy/r1HQFWTeqYC7g40w4/pGmatykDuHYxKHXbHONPB4a64NJBlSIw1
 qA11lLbZD/sclISAdyR84Ze2cp8WPOMUfaf0d+Rz4PzAb1QKdRoVxgR3GKks4yq4ZrQqEfEFZd4
 5m0UkdpXdam9W7ZpppUNkYggpoNBqVxXHDbmJdZ3qOijKAugjEdUVqR0rtdvTWwwekBrgxItn9G
 wA0A9q8NEBgzpDUo0vAt8Cou1QUOu+BafekaaltjjtAGz586T292d+hUJ35t8hqHCwBfDqq6WAR
 Q6hVeBZ6ehIJ7fwn/XuU9qI6jLTtHCPiVtQ2sab+DMf4TnGP2BExICdJMpbfmenEl+0wgT6mqSS
 8xZGTHQ4bKxxfaKkJU4bhdR1q4l/2JpHWc8hVtBiTAO2Zj3nWGe6uWSgFeTLOaRPfzjkVjIFyGy
 w0AvY47Mxx7Rwpw2dAAe50lqDTu
X-Received: by 2002:a05:600c:8b29:b0:490:6e0f:29f4 with SMTP id
 5b1f17b1804b1-490e55cc3fdmr17908975e9.3.1781181938417; 
 Thu, 11 Jun 2026 05:45:38 -0700 (PDT)
Received: from localhost.localdomain
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e532c778sm48697645e9.14.2026.06.11.05.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:45:38 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH v3 1/2] drm/nouveau/pci: use config-space MSI rearm on
 MCP79/MCP7A (NVAC)
Date: Thu, 11 Jun 2026 14:45:34 +0200
Message-ID: <20260611124535.527275-2-mczernohous@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611124535.527275-1-mczernohous@gmail.com>
References: <20260611124535.527275-1-mczernohous@gmail.com>
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

From: Marek Czernohous <marek@czernohous.de>

NVAC (MCP79/MCP7A) uses g94_pci_func, whose .msi_rearm is
nv40_pci_msi_rearm(): a re-arm write through the MMIO mirror of PCI
config space.  On this IGP that path is unreliable; when a re-arm is
missed the interrupt line stays dead, command submission times out and
the GPU appears hung until reboot.  On an Apple Mac mini (early 2009,
MCP79, boot0 0x0ac080b1) this showed as sporadic fifo timeouts and GPU
hangs under load unless MSI was disabled via config=NvMSI=0.

Give NVAC its own pci func that re-arms through real PCI config space
(nv46_pci_msi_rearm) instead.  This follows existing precedent: nv46.c
documents the MMIO-mirror re-arm as broken on several related parts,
and commit 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm") fixed g92
the same way while moving the remaining chipsets, NVAC included, into
the newly added shared g94 table, where NVAC stayed on the MMIO path.
This change completes that fix for NVAC.  The sibling IGP NVAA
(MCP77/MCP78) has MSI disabled entirely as "reported broken" in
nvkm_pci_new_(); NVAC works correctly once the re-arm goes through
config space, so disabling MSI is not necessary.

Only NVAC is switched: that is the hardware this has been validated
on.  The other users of g94_pci_func (G94/G96/G98/GT2xx and the
MCP77/MCP89 IGPs) keep their current behavior; MCP77 and MCP89
plausibly want the same treatment but were not tested.

Tested on the Mac mini as a daily driver for two months with MSI
enabled and zero fifo timeouts.  Independently confirmed stable on an
iMac9,1 (MCP79) running 6.12.90 with the v1 form of this change (the
same one-line functional switch, applied to that kernel's g94
implementation).

Fixes: 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm")
Cc: <stable@vger.kernel.org> # v6.16+
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
The stable tag is annotated v6.16+ because the new file uses the .cfg
member introduced there by 2f89bb3264af ("drm/nouveau/pci: add PRI
address of config space mirror to nvkm_pci_func"); on older kernels
the backport is the era-specific one-line .msi_rearm switch in the g94
implementation (nv46_pci_msi_rearm exists everywhere), happy to send
those per tree if wanted.

v2 -> v3: no code changes; annotated the stable tag, clarified the g92
precedent wording and that the iMac9,1 test used the v1 form, minor
nits (copyright line, declaration style matching the header, boot0
notation).
v1 -> v2: narrowed to NVAC via a dedicated mcp79 pci func instead of
changing the shared g94 table (only chipset the fix was validated on);
added Fixes/stable/Assisted-by tags.
v2: https://lore.kernel.org/all/c5a46ddcc38172b43bc3d7432e8114669f3dc933.1781162589.git.marek@czernohous.de/
v1: https://lore.kernel.org/nouveau/20260409172126.115441-2-marek@czernohous.de/

 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  1 +
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c   | 35 +++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
index 112b674..0172e0d 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
@@ -46,6 +46,7 @@ int nv4c_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct n
 int g84_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int g92_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int g94_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
+int mcp79_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
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
index 0000000..e2ae242
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Marek Czernohous
+ *
+ * MCP79/MCP7A (NVAC): like g94, but MSI re-arm goes through real PCI
+ * config space.  The MMIO-mirror re-arm is unreliable on this IGP and a
+ * missed re-arm kills the interrupt line (see the nv46 comment; g92
+ * already re-arms through config space for the same reason).
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

