Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B13C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD9C10E06C;
	Wed, 16 Sep 2026 14:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aicharmers.com header.i=@aicharmers.com header.b="QVNK6NRP";
	dkim-atps=neutral
Received: from mail-pz2-f34.google.com (mail-pz2-f34.google.com
 [74.125.228.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD20610E13E
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:42:49 +0000 (UTC)
Received: by mail-pz2-f34.google.com with SMTP id
 41be03b00d2f7-cc4ae616175so640998a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aicharmers.com; s=google; t=1789569769; x=1790174569;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UintJ1OcX1Vv5LA0Oy4kGu7rjHpo6UkClpvkxFTZXDY=;
 b=QVNK6NRP2CJysMdAKAWjr34Tyo16IZKlvXcjxJyzecUGi2b5fi90H94qYgpc7C0o+f
 FC+NJEnVLUkTpTqX1s66wUX6tKO5T6jAjSPw2UzuHJe20I0bH4uUDGp01mNwzka8aiwU
 I0MvnCoipXYedSGem6LesLIJBBerkcnOI2qew79YsryFvpjBJlCd7Xg4JIQMrXOM43tm
 vBNQh7c4OSMZvz1/3cRIq9h8LCrk8YIYzkmDc7xgM43NUZ2ewy9NHuMXtNo40BuGKev/
 YFTjQTyafj7zGUc6YsOaN89t0PtlzbypA2bIVRK85cgoy+DpBF2OH3BR6YjvLJiGx3NQ
 cJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789569769; x=1790174569;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UintJ1OcX1Vv5LA0Oy4kGu7rjHpo6UkClpvkxFTZXDY=;
 b=yDIRizJUcZGvJB1npE3ZKpiLL0xYjy0XclWoq3Dl3v4zfXpr7hxktV0LZfzPoZ/tbo
 l5m+ZVxMXxi8sBEeP4Fb6MkoGr5SmCjyqpmksIK7z8gs0IVnVLohqvXSXunDkNI7Dy69
 jIJeAck16jESrdlXQgz/hgU8EqnLAyT3OJfq6aM+NwnQjmAfLWkhtPdUIOS/XiObN/Lt
 izMwyyVu8AHggzAaUE2aD/0umNcT2v8gTb+ahuBBY/DyfhsnUlM4oIe+uAJ4OZinuT/J
 XFLliF6Fk2LRHlzrs0pbuyx/4kq0VZowJYBjFqBBM0P+RSNz5cCYOz2tC4O1pADoYp+N
 e6jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXouQcfC/m+m3pjHGPb/+C5aB2rUywBciNEpPQPGUUh7zozHYJb76tdhiin+2h7bbjvXl9kA5306A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mbE02L+gmZ9WX4Re8WD8uFBigLgFSYYHdKPmo+Ezqv7GeFp6Me
 QUL431PbIocPJte7Geg1Jg915CYlALm8ApS/lEEN0806c/8M07Y3kDMOKh6g6NRoR3A=
X-Gm-Gg: AYBFou1qqHISCLeIoT1LRWapoS2Ar7d3xQUNWUts88QhrFXvNw8K96EifVnkSNuAbUy
 jeZnxKS5U8oQok/ANYqw7Ugb25ySEqwcNzlXHMHRapn6rQCVi0XjbXUf65VkDyzWAcvodVbse6e
 A2d2bZnWy7tPe92dmVzet4mYIo/u+kfmDn86wwuGPdgOaoYEOorxxGo4a+EpCUZjGnCMiTI46Zo
 8T7I/TZaMOLpOTIE8p0JUV1G9X83tuwj6+ZORGpgkMEZ4AkrAA64nbNZpXFkTlOCqsY1gZf0ozL
 CVka8A9A9y59oRvi9wfXNZzSh1syZD0ImPPHJpClHcDMVLpas7Ztwv2FVFaVBeVe3ue6cfIQ6zz
 GbtyDsVVwhAa8Iwc/i3bD28LnzNv5iHCditihwfu9f8jt+rEU4q9xu4W+H1KcS9vLPmL1gmrxbv
 vBGeEWouPlsp0T1uilNsqVh/cymLI2QI58C0pPugdjTSZ04qyUW00zWRcZF3ZqXXEHc424R+ugN
 IXFHB40D/LlFELjjTg8jI+77nuG24mYDuL37LowCEeZ0fFhpaJPFRXvsVlZj2yOiYPXfoxYVI3t
 XRgsyU32kyNgnYVuokwfMoCgtu0n
X-Received: by 2002:a05:6a20:d48e:b0:3da:1e2f:3be9 with SMTP id
 adf61e73a8af0-3dd5f720482mr8089122637.22.1789569768985; 
 Wed, 16 Sep 2026 07:42:48 -0700 (PDT)
Received: from ip-10-0-0-163.ap-southeast-2.compute.internal
 (ec2-15-135-184-173.ap-southeast-2.compute.amazonaws.com. [15.135.184.173])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc50ab54cb9sm1780799a12.8.2026.09.16.07.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:42:47 -0700 (PDT)
From: Ed Schofield <ed@aicharmers.com>
To: amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ed Schofield <ed@aicharmers.com>
Subject: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Wed, 16 Sep 2026 14:40:14 +0000
Message-ID: <20260916144014.879355-1-ed@aicharmers.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Some Apple Navi GPUs intermittently time out during SMU initialization
when EnableAllSmuFeatures includes UCLK DPM. Leave UCLK out of that early
request and enable it from Navi post-init, after display hardware init
and before the UMC workaround and UMD clock setup.

Read back the enabled features before rebuilding the memory clock table
and sustainable clock limits. Also check the PPT memory states used by
display initialization before late enablement. Keep memory-voltage DPM
and respect the user's memory-DPM setting and the secure Navi 10 exclusion.

Limit this workaround to Apple 7340/0218 revision 41, 7340/0219, and
731b/021a revision 40. Revisions and PCI IDs here are hexadecimal. The
underlying initialization dependency behind the timing sensitivity is
still unknown.

This builds on Atharva Tiwari's submitted 0219 delayed-UCLK patch
and Guna's diagnosis. Ed Schofield moved the enable point into the
Navi callback, added state validation and clock-table refresh, and
extended the board matching.
Independent tests of the related T2 implementation support improved boot
reliability on 0219 and 021a; those are not tests of this exact AMD patch.

Link: https://lore.kernel.org/amd-gfx/20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com/
Link: https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5637976466
Link: https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5645652752
Assisted-by: Codex:GPT-6
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Co-developed-by: Ed Schofield <ed@aicharmers.com>
Signed-off-by: Ed Schofield <ed@aicharmers.com>
---
Hi Alex, hi Atharva,

Here is v4 of the delayed-UCLK workaround. Atharva is credited as the
author in `From:`, with my rework credited through `Co-developed-by:`.
The local development history starts from Atharva's original 0219
submission [1], followed by my move to the Navi post-init callback,
state validation, clock-table refresh and additional board support. This
export is a single replacement patch against AMD staging at `8a4e96cf2`;
it is not an incremental patch to apply on top of v2 or Atharva's
original patch. (V3 was a local revision that I didn't submit to this
list.)

Atharva, I agree that display initialization may explain the timing
dependency. This patch already enables UCLK after display hardware
initialization on the normal probe path. It is intended as a targeted
workaround for the reported boot failures; it does not establish the
underlying cause or address native 5K support. Could you share the exact
initialization-ordering diff, kernel version and GPU IDs from your
experiment? In the AMD staging tree used for this patch,
`dce_v10_0_early_init()` handles Tonga/Fiji, while these Navi boards use
the DCN path.

My goal is to stop the intermittent boot failures on my iMac (0218) and
other affected machines. Testing of my related T2 candidate in PR 61
[2], which was based on my local v3, is encouraging:

- Matt Olney's report on 021a [3] records internal-display boot success
  improving from 2/10 to 10/10, with mixed restart types.
  External-display results were 4/10 versus 4/5, with uncertain kernel
  selection on the failed candidate attempt.
- Vivek Chauhan's report on 0219 [4] records boot success improving from
  1/5 to 3/3.

These results are from the T2 implementation, not this exact AMD v4
export. The T2 patch stack also includes a separate correction to its
existing fixed allowed-feature mask on 0219, which clean AMD does not
need and this patch does not contain. The results support improved boot
reliability on these machines, but do not establish full performance or
reliability across all display configurations.

Compared with public v2, v4 adds 731b/021a revision 40, preserves the
existing secure-Navi-10 exclusion and generalizes the helper names. It
retains 7340/0218 revision 41 and 7340/0219. All IDs and revisions here
are hexadecimal.

Compared with my local v3 / T2 Linux PR #61, v4 excludes 020f: 3v3nFloW
reported that initialization completed but the machine subsequently hung
under load [5]. Their follow-up testing with a fixed memory-clock level
[6] suggests that memory-clock changes cause the hang, but doesn't
establish whether GPU load or display activity triggers it. I've also
excluded 021b from this version, which we don't yet have testing results
for.

Local build and host checks pass. I am currently travelling without my
iMac and have no new v4 hardware results, but I am submitting this
version for merging, with the workaround limited to the three board
matches supported by the existing evidence from the volunteer testers
mentioned above.

Alex, this patch replaces v2 and applies directly to the AMD staging
commit identified above.

Thanks,
Ed

[1] https://lore.kernel.org/amd-gfx/20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com/
[2] https://github.com/t2linux/linux-t2-patches/pull/61
[3] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5637976466
[4] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5645652752
[5] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646139127
[6] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646438512

v3 was local, not submitted. Since public v2: add the tested 021a/40
match, retain the secure-Navi-10 exclusion, and generalize helper names.
Since local v3: remove 020f (load hangs) and 021b (no testing evidence).
Base: 8a4e96cf2acd1e0340581df100b559f77ad7d855 (AMD staging).
This is a full replacement, not a patch to apply on top of v2.

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9a..3ac2a074c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,6 +60,37 @@
 
 static int navi10_init_ppt_limits(struct smu_context *smu);
 
+static bool is_asic_secure(struct smu_context *smu);
+
+static bool navi10_apple_needs_late_uclk(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct pci_dev *pdev = adev->pdev;
+
+	if (pdev->vendor != PCI_VENDOR_ID_ATI ||
+	    pdev->subsystem_vendor != PCI_VENDOR_ID_APPLE ||
+	    !(adev->pm.pp_feature & PP_MCLK_DPM_MASK))
+		return false;
+
+	/* Preserve the existing secure Navi 10 memory-DPM exclusion. */
+	if (is_asic_secure(smu) &&
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0) &&
+	    adev->rev_id == 0)
+		return false;
+
+	switch (pdev->device) {
+	case 0x7340:
+		return (pdev->subsystem_device == 0x0218 &&
+			pdev->revision == 0x41) ||
+		       pdev->subsystem_device == 0x0219;
+	case 0x731b:
+		return pdev->subsystem_device == 0x021a &&
+		       pdev->revision == 0x40;
+	default:
+		return false;
+	}
+}
+
 static const struct smu_feature_bits navi10_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
@@ -356,6 +387,11 @@ navi10_init_allowed_features(struct smu_context *smu)
 		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
 	}
 
+	/* Defer UCLK on the selected Apple boards until IP late init. */
+	if (navi10_apple_needs_late_uclk(smu))
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+					   FEATURE_DPM_UCLK_BIT);
+
 	if (is_asic_secure(smu) &&
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
@@ -470,6 +506,25 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+/* DCN20 consumes these PPT states before the post-init UCLK enable. */
+static int navi10_apple_check_uclk_states(struct smu_context *smu)
+{
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	unsigned int count, i;
+
+	if (!navi10_apple_needs_late_uclk(smu))
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
@@ -490,6 +545,10 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = navi10_apple_check_uclk_states(smu);
+	if (ret)
+		return ret;
+
 	return navi10_init_ppt_limits(smu);
 }
 
@@ -3219,6 +3278,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+/* IP late init follows display hw_init; refresh clocks before UMC/UMD setup. */
+static int navi10_apple_late_uclk_enable(struct smu_context *smu)
+{
+	struct smu_11_0_dpm_context *dpm = smu->smu_dpm.dpm_context;
+	struct smu_dpm_table *table = &dpm->dpm_tables.uclk_table;
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	struct smu_feature_bits enabled;
+	int ret;
+
+	if (!navi10_apple_needs_late_uclk(smu))
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
@@ -3227,6 +3321,12 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	ret = navi10_apple_late_uclk_enable(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n", ret);
+		return ret;
+	}
+
 	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
-- 
2.43.0
