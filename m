Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B3CC44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A832B10E18B;
	Sun,  5 Jul 2026 10:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="dwRgHEb8";
	dkim-atps=neutral
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F9910E189;
 Sun,  5 Jul 2026 10:05:10 +0000 (UTC)
From: Oz Tiram <oz@shift-computing.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1783245908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7EJhZdscjisekpdqgSaSUGhkO3QFbBPTc4PoNhhHsQ=;
 b=dwRgHEb8ozO7WxvzoFBDf9QqBGiW6IlhxENAaBTn1sLeAeb9ut98qtQ5NCgALUYn/v24df
 YSH0Ycf9jSf5UXDF5t5zpHfTmp6wB8RHMtuoi4ZjR79JKNLc2NkpxdSojn3CNjntwEpOey
 jqHNhkzgERKeLtzVVNtLfJqjisnmggtm1xNxtri5+TWgt5X58AdOdoMtiZep8ZYHp73JsQ
 6JTYLvMAIemGQ35zSpfrIy56d409zrjMk+0RdsPCb0ZcaP4lgP1y9nvuzjXfHQ3bxaMX8B
 WHzcwetZiUregKgVovpzbYHA7bnTBfIVj5uJZ96mZtqJPXkA3Bus/dhNb6lDSg==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
To: amd-gfx@lists.freedesktop.org
Cc: oz@shift-computing.de, mario.limonciello@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
Date: Sun,  5 Jul 2026 10:04:36 +0000
Message-ID: <20260705100436.6877-1-oz@shift-computing.de>
In-Reply-To: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
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

On some systems all four fail.  The specific case motivating this patch
is a hybrid graphics machine (dGPU + APU) where:

  - The VFCT table contains the iGPU entry but with a stale PCIBus value
    from BIOS POST time (0x6A).  When the kernel boots with
    pci=realloc,assign-busses, PCI bus numbers are reassigned dynamically
    and the iGPU lands on bus 0x0B at runtime.  amdgpu_acpi_vfct_bios()
    matches entries by bus number, so the entry is never found.
  - The VRAM BAR is unmapped at probe time.
  - The ROM BAR is zero (PCI firmware did not assign it).
  - No platform BIOS mapping exists.

The UEFI GOP driver initialises the iGPU successfully for early display,
confirming the hardware is functional.  The VBIOS image data embedded in
the VFCT is also valid; only the PCIBus metadata is wrong.  The firmware
file can be extracted directly from the VFCT using dd:

  dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) count=16896 \
     of=/lib/firmware/amdgpu/1002_1900.bin

(0x68 is the byte offset of the VBIOS image after the ACPI table header
and VFCT_IMAGE_HEADER; the image length 16896 comes from the ImageLength
field in VFCT_IMAGE_HEADER.)

The driver then prints "Unable to locate a BIOS ROM" and refuses to
bind, leaving the APU completely unusable under Linux.

Add a fifth fallback: request a firmware file named
"amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
request_firmware().  This allows a VBIOS image extracted as above to be
placed in /lib/firmware/ and makes the binding succeed without patching
ACPI tables or BIOS.

The fallback is only reached if all existing paths have already failed,
so there is no regression risk for boards where VFCT or ROM BAR work.

Signed-off-by: Oz Tiram <oz@shift-computing.de>
---
v2: Fix commit message: clarify that VFCT contains the iGPU entry but
    with a stale PCIBus from BIOS POST that mismatches the runtime bus
    number assigned by pci=realloc,assign-busses.  Explain that the VBIOS
    image data is valid and document the dd extraction command and byte
    offsets.  Note that the UEFI GOP driver initialises the iGPU
    successfully, confirming the hardware is functional.

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

