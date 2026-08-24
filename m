Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87645C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AAE10E18C;
	Mon, 24 Aug 2026 19:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFFyZLTf";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AAB10E18E
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:04:26 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1a4c62804so1035382a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787598266; x=1788203066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PW9z4Kczz+MaTp35NxsSZNeNvJrFEB2eoMmOK27RfDA=;
 b=YFFyZLTfkuilplDnAwKeqom+kga+6K3oVsTcSDybvzUY25ntyp5PxT3ivLwAYJLBZ1
 xc2l0scFYUJzkpr4aL5/5ZPuLgJucwTcpmBLlcWoKpiOWXWEBwQAlu2b5UWTfsN/0l+2
 hzw0RN+VJWbYjod6kzad52qQM9AYZIiQhnEYtN5h4Zn8b68/4qpvGFIHOu8vCKQPPg7x
 AO+tXy5CoM2ufQFAquk0jN2zGbG1lC64z09Ag/wyJ5DFirUmNuEQets/hoCcKPUNFPI7
 cj/2j+c8WcE6oy7HBHWfQ/IiGr7CRnW++NQ8j0KrFg/NjZQJlABED/Ssr52EZrC4I8ha
 VTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787598266; x=1788203066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PW9z4Kczz+MaTp35NxsSZNeNvJrFEB2eoMmOK27RfDA=;
 b=JVqrGgSeqZhJA5b2kQQ6zPEpJwwo2xRjxe3fFV/SyuD6oLliz+7lR+dug3RzE/CGl1
 IhIWa5eUHhbudgoeTn9lrSuiPSwYr+r+05447sWBNMssUxOpeG+vk4gtlXz0PrGt9jo8
 8GEkkzfzWzZpiAXQ4+ltim9Vzpz7HDrm/DpK8KhDT3b/6Vhwn7rXJLsXcBbS1yGeANat
 Z39chX4m0Yp/s6Pr3NC553qNrRQSOan4xReQVLRqpV3w5GQt62tRaW9pP+YVd4FRSRnV
 SGbrAQlLzYR+S6+mTWxo5ZQoFsxox/2JllISQOfdp2xs0cTkks/u8UgXMb5WLsQPp6Yl
 bSRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpnIS4g2w8e+ryHMlRouk4v9Sk5ODZVmiAMCJu8ifsGO4UlBx0ULtHlK63YSN6ibZSOtmQBNdJ8f8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltu1DMtDAFVQOrKi9eo6RzX14VIKYPaqCFlco4B2Q54PGONFgC
 fkLMpoJdYrkM9a2Aaa9tq+AxlesEmWbPXIeNvWSKAwMNzXfafuxX2pc=
X-Gm-Gg: AR+sD10HqgJuZJ+p8N1DDYN8pmbRQGbnssSGwlUDvZiFMVOWdmDtPUtqe/CYn5y21O5
 UdOtfjUpmkniDFVla9a1/n+1A+sPB8XeYphWjMtQcEGAW71vAdEvqvEaO/EOw3CioXOYScInk6j
 bImywcAGXOBgry8n4hqZc2hEI89c2u+zJGCVsVXojO8l9OnQKA11YQ9kB0PdH+BcUvDT6x+lHe+
 CDYig2L/iirieoxiOdrrscmYYYMeFT66zSoruw2qA7dV/Ox1meepfdmJ01ywfiw17mgksV2CgDA
 2CXs6b3IuvaXOD/LdG4uLPR6gbstLquTDSh2SDVS1RrAFsVZ6qusFz3/dSRC5sRP8yPpYIxapO3
 z4t975T55CMRuw4btRG/9Xk9aO+fb8R+hKwY7wMlY0rOy4smsNiHKGZJRpAWgR17fOaK5bjSqVO
 Rp1hvQNr9L+ENTdTzpw19qcXjgzFyvb1XGBXcMqWh4Mf6nLMu5CImFeWmFppPB+U/NTH2x+nX4M
 rsU0mbj7D+9ShKXs1QvtLED
X-Received: by 2002:a05:6a21:9214:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3cd4ba4839amr45577910637.5.1787598265874; 
 Mon, 24 Aug 2026 12:04:25 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([223.228.8.56])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f90cb8e3sm42815637eec.12.2026.08.24.12.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:04:25 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 "Guna R . Bharati" <062bel313@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro 5300
Date: Mon, 24 Aug 2026 15:04:06 -0400
Message-ID: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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

On the AMD Radeon PRO 5300, enabling UCLK_BIT in
navi10_init_allowed_features causes errors such as:

SMU: No response msg_reg: 6 resp_reg: 0

or:

SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000006 SMN_C2PMSG_82:0x00000000

To work around this issue, we use smu_set_pp_feature_mask() to enable UCLK_BIT instead.

Fixes:
https://gitlab.freedesktop.org/drm/amd/-/work_items/4895

Tested-by: Guna R. Bharati <062bel313@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  7 +++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3969a7670..c05ceb0be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -905,6 +905,33 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
 	return smu_set_config_table(smu, &adev->pm.config_table);
 }
 
+static int smu_apply_late_quirks(struct smu_context *smu)
+{
+	struct pci_dev *pdev = smu->adev->pdev;
+	int ret = 0;
+	uint32_t features[2];
+	struct smu_feature_bits feature_mask;
+	uint64_t mask;
+
+	if (pdev->device == 0x7340 &&
+			pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+			pdev->subsystem_device == 0x0219) {
+		ret = smu_feature_get_enabled_mask(smu, &feature_mask);
+		if (ret)
+			return ret;
+
+		smu_feature_bits_to_arr32(&feature_mask, features, 64);
+		features[0] |= BIT(3);
+		mask = ((uint64_t)features[1] << 32) | features[0];
+
+		ret = smu_set_pp_feature_mask(smu, mask);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int smu_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -977,6 +1004,12 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 
 	smu_restore_dpm_user_profile(smu);
 
+	ret = smu_apply_late_quirks(smu);
+	if (ret) {
+		dev_err(adev->dev, "Unable to apply late quirks\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6dfc3b585..ed67e4bfc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -349,7 +349,12 @@ navi10_init_allowed_features(struct smu_context *smu)
 	      (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	      (adev->rev_id == 0)) &&
 	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
-		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_UCLK_BIT);
+		if (!(adev->pdev->device == 0x7340 &&
+				adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+				adev->pdev->subsystem_device == 0x0219))
+			smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+					FEATURE_DPM_UCLK_BIT);
+
 		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_VDDCI_SCALING_BIT);
 		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
 	}
-- 
2.43.0

