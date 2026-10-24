Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40511606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=gzcyrfN+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E3F10E1B7;
	Sat, 24 Oct 2026 16:29:20 +0000 (UTC)
X-Greylist: delayed 480 seconds by postgrey-1.36 at gabe;
 Sat, 24 Oct 2026 16:29:14 UTC
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF48910E180;
 Sat, 24 Oct 2026 16:29:14 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 058fab7f-7490-4316-b2a6-b06f24c3fce8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1792858872;
 bh=4yRUaUcZJ7NVfl/ojp5ovKj0o5QzSmiM/G82y808yXo=;
 h=From:To:Cc:Subject:Date:From;
 b=gzcyrfN+SohEVnOopB1lpmVXh9mJMOjMuc8ZyFDiB5QP4e2fXg7HSPbCdvYkxr1Iy
 MUsU/R/9Wr9+uine925Mjg74u5+Vu3mlm8yVbxjG9HcyNsz+VuMIXlKoKmAwCzhx4n
 Nsz2Qcml9udIpHmkXPNfdHvRWG/jFZr18vVRGlYQQWsTV0b/KtBTLME470Gj33wPRB
 vjMJ5SI+osZXpsFI3gwbd1nXb8UflsWb7iLs/vr6lSCCmYlzwWexWcC6XaOqjaCv/z
 6i/FBbfnUqye4e2QWljP15NYsL2sM/1k+ayQajlcdH8MUkTJaJIDnjHzXQ2RP3fF/x
 dVGeWIHeSx5sA==
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Andre Eikmeyer <dev@deq.rocks>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
Date: Sat, 24 Oct 2026 18:21:09 +0200
Message-ID: <20261024162109.307247-1-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU messages
as soon as UCLK switches into its third level. This happens at boot or
at the latest under dGPU load and ends in a CPU CATERR that resets the
machine.

Apple's VBIOS trains the UMC p-state sets at 95, 496, 598 and 736 MHz
(umc_info v3.3), but its pptable lists 95, 496, 736 and 750 MHz. Level 2
then runs 736 MHz on a set trained at 598 MHz.

Take the UCLK levels of these boards from umc_info.

Tested on three MacBookPro16,1, two with the 5500M and one with the 5300M.

Cc: stable@vger.kernel.org
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2d0508861..63b773252 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -470,6 +470,60 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+static bool navi14_needs_trained_uclk(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+
+	return pdev->vendor == PCI_VENDOR_ID_ATI &&
+		pdev->device == 0x7340 &&
+		pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		(pdev->subsystem_device == 0x020f ||
+		 pdev->subsystem_device == 0x0210);
+}
+
+/*
+ * The pptable of these boards lists other UCLK levels than the VBIOS trained
+ * the UMC p-state sets at, and the SMU hangs switching into such a level.
+ */
+static void navi14_use_trained_uclk_levels(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	struct atom_umc_info_v3_3 *umc_info;
+	uint16_t trained[NUM_UCLK_DPM_LEVELS];
+	uint16_t size;
+	uint8_t frev, crev;
+	int index, i;
+
+	if (!navi14_needs_trained_uclk(adev) ||
+	    pptable->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels != NUM_UCLK_DPM_LEVELS)
+		return;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    umc_info);
+	if (amdgpu_atombios_get_data_table(adev, index, &size, &frev, &crev,
+					   (uint8_t **)&umc_info) ||
+	    frev != 3 || crev != 3 || size < sizeof(*umc_info))
+		return;
+
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++) {
+		trained[i] = le32_to_cpu(umc_info->pstate_uclk_10khz[MAX_UCLK_DPM_LEVEL - i]) / 100;
+		if (!trained[i] || (i && trained[i] <= trained[i - 1]))
+			return;
+	}
+
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++) {
+		if (pptable->FreqTableUclk[i] == trained[i])
+			continue;
+		dev_info(adev->dev, "UCLK level %d: %u MHz -> %u MHz, as trained by the VBIOS\n",
+			 i, pptable->FreqTableUclk[i], trained[i]);
+		pptable->FreqTableUclk[i] = trained[i];
+	}
+
+	pptable->DcModeMaxFreq[PPCLK_UCLK] = min(pptable->DcModeMaxFreq[PPCLK_UCLK],
+						 trained[MAX_UCLK_DPM_LEVEL]);
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -482,6 +536,8 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	navi14_use_trained_uclk_levels(smu);
+
 	ret = navi10_append_powerplay_table(smu);
 	if (ret)
 		return ret;

base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
-- 
2.56.0

