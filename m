Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325B4C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94ACC10F496;
	Thu,  2 Jul 2026 16:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Wj1Kl427";
	dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0602C10F4D9;
 Thu,  2 Jul 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783009481; bh=shapZa4PeOLDWV2+6Nr+r+UxCdsZGjmFO3BjFyalYx0=;
 h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
 b=Wj1Kl427QYSRFjx+TbjCp9sFHY1ZtmARQ7KCBNFld7eS5ndnJsQo9LUWh92DAbSUn
 9TTLMwF+PW95MrKG6G5GzCXR5GVd9e/CIA9v+piYCn7AYtldkx3Ij8KAnln6IvKIaQ
 PbzBsZG88OIoTwn9QDxqlbXhFJzf4meeaVbtj4GdhmP37uhb3dYaUhX1CfShKy6qRH
 NaMKvjDdaUjhxtuAvJAQZ3OswPUKbZnBu3zqPEq27gxpwCV5sUGkaqTGa5JJm4gkIE
 C7Cj32ehZL6SBvixZTMHrxBOr72HvmICNRGNr5twAVW02NF5DShxbpq41pMQyxhsvx
 kjNPATJ/EoZTg==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4grhzs3SgSzYT;
 Thu, 02 Jul 2026 18:24:41 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 02 Jul 2026 18:24:40 +0200
Message-ID: <9a1df651e8c340e2f8fd44078641cc7f23242c72.1783009338.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/5] drm/amd/amdgpu/cgs: Avoid redundant copying of firmware
 filename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
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

While at it, remove redundant error message - request_firmware() will
log a failure anyway.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 54 ++++++++++++-------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 09c8942c22d3..a43cd4980d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -241,7 +241,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		info->fw_version = amdgpu_get_firmware_version(cgs_device, type);
 		info->feature_version = (uint16_t)le32_to_cpu(header->ucode_feature_version);
 	} else {
-		char fw_name[30] = {0};
+		const char *fw_name = NULL;
 		int err = 0;
 		uint32_t ucode_size;
 		uint32_t ucode_start_address;
@@ -257,17 +257,17 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 					(adev->pdev->revision == 0x81) ||
 					(adev->pdev->device == 0x665f)) {
 					info->is_kicker = true;
-					strscpy(fw_name, "amdgpu/bonaire_k_smc.bin");
+					fw_name = "bonaire_k_smc.bin";
 				} else {
-					strscpy(fw_name, "amdgpu/bonaire_smc.bin");
+					fw_name = "bonaire_smc.bin";
 				}
 				break;
 			case CHIP_HAWAII:
 				if (adev->pdev->revision == 0x80) {
 					info->is_kicker = true;
-					strscpy(fw_name, "amdgpu/hawaii_k_smc.bin");
+					fw_name = "hawaii_k_smc.bin";
 				} else {
-					strscpy(fw_name, "amdgpu/hawaii_smc.bin");
+					fw_name = "hawaii_smc.bin";
 				}
 				break;
 			case CHIP_TOPAZ:
@@ -277,76 +277,76 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				    ((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0xD1)) ||
 				    ((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0xD3))) {
 					info->is_kicker = true;
-					strscpy(fw_name, "amdgpu/topaz_k_smc.bin");
+					fw_name = "topaz_k_smc.bin";
 				} else
-					strscpy(fw_name, "amdgpu/topaz_smc.bin");
+					fw_name = "topaz_smc.bin";
 				break;
 			case CHIP_TONGA:
 				if (((adev->pdev->device == 0x6939) && (adev->pdev->revision == 0xf1)) ||
 				    ((adev->pdev->device == 0x6938) && (adev->pdev->revision == 0xf1))) {
 					info->is_kicker = true;
-					strscpy(fw_name, "amdgpu/tonga_k_smc.bin");
+					fw_name = "tonga_k_smc.bin";
 				} else
-					strscpy(fw_name, "amdgpu/tonga_smc.bin");
+					fw_name = "tonga_smc.bin";
 				break;
 			case CHIP_FIJI:
-				strscpy(fw_name, "amdgpu/fiji_smc.bin");
+				fw_name = "fiji_smc.bin";
 				break;
 			case CHIP_POLARIS11:
 				if (type == CGS_UCODE_ID_SMU) {
 					if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
-						strscpy(fw_name, "amdgpu/polaris11_k_smc.bin");
+						fw_name = "polaris11_k_smc.bin";
 					} else if (ASICID_IS_P31(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
-						strscpy(fw_name, "amdgpu/polaris11_k2_smc.bin");
+						fw_name = "polaris11_k2_smc.bin";
 					} else {
-						strscpy(fw_name, "amdgpu/polaris11_smc.bin");
+						fw_name = "polaris11_smc.bin";
 					}
 				} else if (type == CGS_UCODE_ID_SMU_SK) {
-					strscpy(fw_name, "amdgpu/polaris11_smc_sk.bin");
+					fw_name = "polaris11_smc_sk.bin";
 				}
 				break;
 			case CHIP_POLARIS10:
 				if (type == CGS_UCODE_ID_SMU) {
 					if (ASICID_IS_P20(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
-						strscpy(fw_name, "amdgpu/polaris10_k_smc.bin");
+						fw_name = "polaris10_k_smc.bin";
 					} else if (ASICID_IS_P30(adev->pdev->device, adev->pdev->revision)) {
 						info->is_kicker = true;
-						strscpy(fw_name, "amdgpu/polaris10_k2_smc.bin");
+						fw_name = "polaris10_k2_smc.bin";
 					} else {
-						strscpy(fw_name, "amdgpu/polaris10_smc.bin");
+						fw_name = "polaris10_smc.bin";
 					}
 				} else if (type == CGS_UCODE_ID_SMU_SK) {
-					strscpy(fw_name, "amdgpu/polaris10_smc_sk.bin");
+					fw_name = "polaris10_smc_sk.bin";
 				}
 				break;
 			case CHIP_POLARIS12:
 				if (ASICID_IS_P23(adev->pdev->device, adev->pdev->revision)) {
 					info->is_kicker = true;
-					strscpy(fw_name, "amdgpu/polaris12_k_smc.bin");
+					fw_name = "polaris12_k_smc.bin";
 				} else {
-					strscpy(fw_name, "amdgpu/polaris12_smc.bin");
+					fw_name = "polaris12_smc.bin";
 				}
 				break;
 			case CHIP_VEGAM:
-				strscpy(fw_name, "amdgpu/vegam_smc.bin");
+				fw_name = "vegam_smc.bin";
 				break;
 			case CHIP_VEGA10:
 				if ((adev->pdev->device == 0x687f) &&
 					((adev->pdev->revision == 0xc0) ||
 					(adev->pdev->revision == 0xc1) ||
 					(adev->pdev->revision == 0xc3)))
-					strscpy(fw_name, "amdgpu/vega10_acg_smc.bin");
+					fw_name = "vega10_acg_smc.bin";
 				else
-					strscpy(fw_name, "amdgpu/vega10_smc.bin");
+					fw_name = "vega10_smc.bin";
 				break;
 			case CHIP_VEGA12:
-				strscpy(fw_name, "amdgpu/vega12_smc.bin");
+				fw_name = "vega12_smc.bin";
 				break;
 			case CHIP_VEGA20:
-				strscpy(fw_name, "amdgpu/vega20_smc.bin");
+				fw_name = "vega20_smc.bin";
 				break;
 			default:
 				drm_err(adev_to_drm(adev), "SMC firmware not supported\n");
@@ -355,10 +355,8 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 
 			err = amdgpu_ucode_request(adev, &adev->pm.fw,
 						   AMDGPU_UCODE_REQUIRED,
-						   "%s", fw_name);
+						   "amdgpu/%s", fw_name);
 			if (err) {
-				drm_err(adev_to_drm(adev),
-					"Failed to load firmware \"%s\"\n", fw_name);
 				amdgpu_ucode_release(&adev->pm.fw);
 				return err;
 			}
-- 
2.47.3

