Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D7AC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB7D10E0DE;
	Wed,  9 Sep 2026 12:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aicharmers.com header.i=@aicharmers.com header.b="OfBf5NR0";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B8110E0DE
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:35:02 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso4370676a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aicharmers.com; s=google; t=1788957302; x=1789562102;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J/1sOUviqZ1rKZwRK0a5dgseTFfkWU+hFt9DbmOcrck=;
 b=OfBf5NR0VREG7vqWPNLI4uhpyfY7JHsbpNgSR+24Hd3Z4JXnxUnVliai62MmfURi0F
 bP4yDZSaL5jhShuZXb/8tUMqctbn3b+2/TBXSqBsLZsXai7vEFw7Jy19AH8wk0VzBsTV
 Nvd6e9/Xj/KDHToJsfErPia9npNcTgU3b+q8QLyQbIkbNOWChzf/HdrCo23eWuktFAP/
 MDaVREoCiaHxtSgCGxb1myyZSn1Mu1lp6zz5re6IBSBdTzpToNmBuKG5rspjOwWuPxeQ
 1TujyWhZxLDFXfl0sOjKSmKPVvE7NL78bks+bS3lU4rvV25kzeykN/gMM39WAlJTds6d
 Rg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788957302; x=1789562102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J/1sOUviqZ1rKZwRK0a5dgseTFfkWU+hFt9DbmOcrck=;
 b=a6uQIFEEe/x5S8KToFd0AuPkGR35Ega4vXyRSYhPO5n2hyyjflCzZdm5u5Yo+K1yFc
 mlVcks2IccONzNXiykF3q7XbpizZ2DvBBZLJqSH+22S+jmDEA15uW/qfygUlPfOxoVe9
 yP2vbBasu+WsuEayWp8oBWKDLlzvxvVGiaOkJ8dA5JxDjy2LxDRTQGqZq+MG+Jnm67Fz
 0giGAOdAZYHwI7FUj8jzbbrxtxtEfYvyAT2iP38FauIv5iMNRaerpGQ+PgH58nqXVXEl
 IxFCSRKQja2Yba4GyPJ7uMq9JV26x8h4qfRyFbURIfuoqyKhtz4MUjPLmqlKFR7J9rWT
 6u5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzmpddAqySzvc+YdA3dfljWxHRRc+3lEn+S94zFAG/nUNhiQ4a4Dclnziaz+1MOaCLr9QRJ6odA1g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuDHrUfDjH5eWx1bEiGeFY8mzK2Gwfj+uzpaH3D17Ghbt7Y/w7
 x9Ap6wSbSdfxeo3bfNjND0bff5MZ59PHf7SgPDtSnY3LM5Z7evvBvVSGAn26Ch0jnsw=
X-Gm-Gg: AYBFou01lgPzrz2xiHUVSRBnOjpYMXs8a4waDoRu1zXwhInk0tFQBnCX7BxH8v3fIVW
 RC6kVO3d6FhvoilK3axk6bLJjVbool2qja9jBmzR43AtLsnhq2AXdZXZEVrCAGAp3z6hKB2yWZ/
 nEBjpOQFbmcsNNmyEdaajMYC6c2qrr9jIp8NGT8u2OqrdqmZgpiXWnEVot31dEmuL6qJs/Ety6W
 pMbFJzC7lPyDQxVZYllyqiz0WXSd/KUUfGcnE5p3YDootzjEvfMCb6LTNSZR14rPXFhL5M9U1v4
 qMa+4pxyDsaWhmiSU1xnnzsrfO9EtE3+5GVeZ5++xERG4j+boOClY0LaiPgDD/YqtGMc14P6eBw
 vmZi56xNTylh4etUZgLPwt1RGk+7Mfp2y5cwgtUp3SF99HIT6BIRSvHjnG0tI0nhdtTkqWuj1/3
 wDrVPptusAnOkDQtQ5BNnqxasuvAY9/U3saCrF+1K9ysnbtFUG7lHOgBwjoQnhujKVGwPkYPBWf
 U8kRDMTWZdha+2EB6hGDMdRW3Jazlm1qNOlUY2qaPZ59E9hhOdBRRr52tJrEDjg8o5mRx81V7vc
 g2kYHBHih7EwmhKOu6FmQCcGUDj2un7QMghMVRidDviQZLRL5/HDjKF8U7t3
X-Received: by 2002:a17:90b:394e:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-39b26272d76mr53476830a91.12.1788957301779; 
 Wed, 09 Sep 2026 05:35:01 -0700 (PDT)
Received: from ip-192-168-20-19.ap-southeast-2.compute.internal
 (2403-5803-1750-0-4b7-4fed-6113-1a7c.ip6.aussiebb.net.
 [2403:5803:1750:0:4b7:4fed:6113:1a7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08cacba5sm40179457a91.12.2026.09.09.05.34.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Sep 2026 05:35:00 -0700 (PDT)
From: Ed Schofield <ed@aicharmers.com>
To: Kenneth.Feng@amd.com
Cc: atharvatiwarilinuxdev@gmail.com, 062bel313@gmail.com,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Date: Wed,  9 Sep 2026 22:34:43 +1000
Message-ID: <20260909123443.88228-1-ed@aicharmers.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
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

Apple Navi 14 boards 1002:7340/106b:0218 (revision 0x41) and
1002:7340/106b:0219 can time out when EnableAllSmuFeatures includes
UCLK DPM, leaving amdgpu without a DRM device.

Exclude only UCLK DPM from the initial allowed features and enable it
separately in the Navi post-init callback. On 0218, enabling UCLK just
after EnableAllSmuFeatures or at the start of default DPM table setup
still timed out. The earlier 0218-only patch passed ten warm boots with
UCLK enabled in post-init. The earliest safe point remains unknown.

Check the enabled firmware bit, update the supported-feature bit and
rebuild the memory DPM table and sustainable clock limits before the
UMC workaround and UMD clock setup. Validate the PPT memory states that
DCN20 consumes before post-init. Preserve both memory-voltage features
and honor PP_MCLK_DPM_MASK.

Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi
post-init implementation for 0218. Retain the revision restriction for
0218 and the revision-independent 0219 match from Atharva's proposal.

The combined patch passed ten warm boots on 0218, with rendering and
H.264 video decoding checks on every boot. Testing on 0219 is still
pending.

Link: https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg149770.html
Link: https://github.com/t2linux/kernel/issues/19#issuecomment-5537823876
Assisted-by: Codex:GPT-6
Signed-off-by: Ed Schofield <ed@aicharmers.com>
---
Changes since the 0218-only RFC:
- Add the 0219 board match from Atharva's proposal, without a revision
  restriction. Keep the 0218 match limited to revision 0x41.
- Keep the Navi post-init implementation and clock-state updates from
  the RFC. Atharva's proposal enabled UCLK at the end of smu_late_init().
- Record the failed tests at the start of default DPM table setup and
  ten successful warm boots of the combined patch on 0218.

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9a..d7cc41a5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,6 +60,19 @@
 
 static int navi10_init_ppt_limits(struct smu_context *smu);
 
+static bool navi14_needs_late_uclk(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+
+	return pdev->vendor == PCI_VENDOR_ID_ATI &&
+		pdev->device == 0x7340 &&
+		pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		((pdev->subsystem_device == 0x0218 &&
+		  pdev->revision == 0x41) ||
+		 pdev->subsystem_device == 0x0219) &&
+		(adev->pm.pp_feature & PP_MCLK_DPM_MASK);
+}
+
 static const struct smu_feature_bits navi10_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
@@ -356,6 +369,11 @@ navi10_init_allowed_features(struct smu_context *smu)
 		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
 	}
 
+	/* These boards time out if EnableAllSmuFeatures includes UCLK DPM. */
+	if (navi14_needs_late_uclk(adev))
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+					   FEATURE_DPM_UCLK_BIT);
+
 	if (is_asic_secure(smu) &&
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
@@ -470,6 +488,25 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+/* DCN20 consumes these PPT states before the post-init UCLK enable. */
+static int navi14_imac_check_uclk_states(struct smu_context *smu)
+{
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	unsigned int count, i;
+
+	if (!navi14_needs_late_uclk(smu->adev))
+		return 0;
+
+	count = ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
+	if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
+		return -EINVAL;
+	for (i = 0; i < count; i++) {
+		if (!ppt->FreqTableUclk[i])
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -490,6 +527,10 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = navi14_imac_check_uclk_states(smu);
+	if (ret)
+		return ret;
+
 	return navi10_init_ppt_limits(smu);
 }
 
@@ -3219,6 +3260,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+/* Rebuild memory clocks before the UMC workaround and UMD clock setup. */
+static int navi14_imac_late_uclk_enable(struct smu_context *smu)
+{
+	struct smu_11_0_dpm_context *dpm = smu->smu_dpm.dpm_context;
+	struct smu_dpm_table *table = &dpm->dpm_tables.uclk_table;
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	struct smu_feature_bits enabled;
+	int ret;
+
+	if (!navi14_needs_late_uclk(smu->adev))
+		return 0;
+
+	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT, true);
+	if (ret)
+		return ret;
+	ret = smu_cmn_get_enabled_mask(smu, &enabled);
+	if (ret)
+		return ret;
+	if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
+		return -EIO;
+
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
+				 FEATURE_DPM_UCLK_BIT);
+	table->clk_type = SMU_UCLK;
+	ret = smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
+	if (ret)
+		return ret;
+	if (!table->count)
+		return -EINVAL;
+	if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+		table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
+
+	return smu_v11_0_init_max_sustainable_clocks(smu);
+}
+
 static int navi10_post_smu_init(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3227,6 +3303,12 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	ret = navi14_imac_late_uclk_enable(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n", ret);
+		return ret;
+	}
+
 	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");

base-commit: c22f9a61e288580824edbbc3ae5a29c9a338594f
-- 
2.55.0
