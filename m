Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D96CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 18:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F6310E20F;
	Sun, 21 Jun 2026 18:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="k2ccOVTV";
	dkim-atps=neutral
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8E710E20F;
 Sun, 21 Jun 2026 18:01:26 +0000 (UTC)
From: Oz Tiram <oz@shift-computing.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1782064884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZdQl6cpDNRleiDk+rgSJQzCixdRfIPpLBTexba67Bo=;
 b=k2ccOVTVDodeVJG9fAUFOGaIbxTredjTz6VwC6zmy+WlwUtG4+sZEw4ALXvIvypcZzhz0J
 IK3wFL2+Giw2FMC9a2hxxpUOIKWqcnh23xw7Yj5k5ozRDfmjU7lIm8jMSMbnT4p/LOyQ17
 6UGNGEDz0qp2k15LfVXNfGgaH6pRCJH2OvGwkEvx4WpzKi3z0X6HyGDixxG2RHL8ETZTxE
 9aRyon+d6hYXEQXLaHEZULxv8yP9IVvXeiL6hrw4esCcwqx+alKyAuomLeFrAvWm/s/wIg
 BDtp3glKU0WJ3QU7r1TEd0xIxYJ926vEuCa1Ty8+glOlkbEfV4pn4+MUqpU/DQ==
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
Date: Sun, 21 Jun 2026 18:01:54 +0000
Message-ID: <20260621180154.30421-1-oz@shift-computing.de>
In-Reply-To: <20260621173211.28443-1-oz@shift-computing.de>
References: <20260621173211.28443-1-oz@shift-computing.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
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
v2: Validate the fetched firmware with check_atom_bios() before accepting
    it, consistent with all other VBIOS discovery paths.  Save fw->size
    before release_firmware() so it remains valid for the size check.
    Release the buffer via amdgpu_bios_release() if validation fails.

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index aa039e148a5e..86064c753b09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -26,6 +26,7 @@
  *          Jerome Glisse
  */
 
+#include <linux/firmware.h>
 #include "amdgpu.h"
 #include "atom.h"
 
@@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
 		goto success;
 	}
 
+	{
+		const struct firmware *fw;
+		char fw_name[32];
+		size_t fw_size;
+
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
+			 adev->pdev->vendor, adev->pdev->device);
+		if (request_firmware(&fw, fw_name, adev->dev) == 0) {
+			adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
+			fw_size = fw->size;
+			release_firmware(fw);
+			if (!adev->bios || !check_atom_bios(adev, fw_size)) {
+				amdgpu_bios_release(adev);
+			} else {
+				adev->bios_size = fw_size;
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

