Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878E5CD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 17:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A59910E1D4;
	Sun, 21 Jun 2026 17:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="iEiZLANt";
	dkim-atps=neutral
X-Greylist: delayed 477 seconds by postgrey-1.36 at gabe;
 Sun, 21 Jun 2026 17:39:31 UTC
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C10C10E1D3;
 Sun, 21 Jun 2026 17:39:31 +0000 (UTC)
From: Oz Tiram <oz@shift-computing.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1782063090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DVMW/6FPBK7CX7HpIDz1X8IYcT+kz39FXhgJ250arz8=;
 b=iEiZLANtyMs6lAzY9eQNHUeq4qWCr1LLbnsjRHK4xAGMaZDhNvbtQeTFmUclBjqvk5vAZn
 /H/qnrjzB/LcIqLjBL8EPODLrRmO68K18ipn7fHXpPEnXmYwrr4OdZM3CPeHz18ZmzRaw1
 sa4QulBXqyqeUqeR4cXvhhf2Ho3rM99P8Lko/nQ/X6pPNIlyI+GC4K3zmat7CtK3HEcyA8
 gJjBwpusW6TIR6AUGAcXcYGToQvruOz4cQzAm2kS2vQS4eSO3dIKSjjouUPrrghA0iSoHC
 kL/reuLLggZ0ItUsUEm1lxB+C2oBPKPBSMHssE5FiJZpJvvnGuKHiyaUP49lvQ==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
To: amd-gfx@lists.freedesktop.org
Cc: Oz Tiram <oz@shift-computing.de>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
Date: Sun, 21 Jun 2026 17:32:10 +0000
Message-ID: <20260621173211.28443-1-oz@shift-computing.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
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

APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
before giving up:

  1. ACPI VFCT table
  2. VRAM BAR read
  3. ROM BAR read
  4. platform BIOS

On some systems all four fail:

  - The VFCT table is absent or contains only the discrete GPU entry
    (e.g. when a custom ACPI override is present for the dGPU only).
  - The VRAM BAR is unmapped at probe time.
  - The ROM BAR is zero (PCI firmware did not assign it; observed even
    with pci=realloc,assign-busses).
  - No platform BIOS mapping exists.

The driver then prints "Unable to locate a BIOS ROM" and refuses to
bind, leaving the APU completely unusable under Linux even though the
hardware is functional.

Add a fifth fallback: request a firmware file named
"amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
request_firmware().  This allows a VBIOS image extracted from the
running hardware to be shipped as a firmware blob in /lib/firmware/ and
makes the binding succeed without any change to the ACPI tables.

The fallback is only reached if all existing paths have already failed,
so there is no regression risk for boards where VFCT or ROM BAR work.

Signed-off-by: Oz Tiram <oz@shift-computing.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index aa039e148a5e..491f88f495a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -26,6 +26,7 @@
  *          Jerome Glisse
  */
 
+#include <linux/firmware.h>
 #include "amdgpu.h"
 #include "atom.h"
 
@@ -457,6 +458,24 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
 		goto success;
 	}
 
+	{
+		const struct firmware *fw;
+		char fw_name[32];
+
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
+			 adev->pdev->vendor, adev->pdev->device);
+		if (request_firmware(&fw, fw_name, adev->dev) == 0) {
+			adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
+			adev->bios_size = fw->size;
+			release_firmware(fw);
+			if (adev->bios) {
+				dev_info(adev->dev, "Fetched VBIOS from firmware file %s\n",
+					 fw_name);
+				goto success;
+			}
+		}
+	}
+
 	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
 	return false;
 
-- 
2.53.0

