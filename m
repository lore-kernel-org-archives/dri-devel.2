Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C38CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6850410E0F1;
	Sun, 10 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="zAP6YyhE";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F2410F4E7
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:21:55 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2ee1054627bso2495665eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778250115; x=1778854915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oybKgWGrdSrX9eknGp6NH6btmZDhUagbD7C71tP0OM=;
 b=zAP6YyhEF4Xj+TdL1DiCTUKzW2gXJdXQH47xLfR8xakWHnePViNhJ3Big1vJR6zcs3
 nf+H6f84r8xo0rc72iMbj/Nc5+MVtCG4lL8VfwN0H3yhfeaDhfUkUEY8TC9u9ajaDqpE
 J61nHIFssSdBS0KcSReKGN4HddN6xty62rVbUExiYAf+8SxY++MaljkFpw0eD8W8ykmH
 S+zYxSCMruCNwrWYJp3lwVFZV4jfBocfNVDbb0EAZtpNaSa51qPV7XRVxFVKGvOHHK1s
 IVdPgdVmT7VRNSvsJCksRquYrLCmr4O/l392vwzR7DsHTLOlXJAhTu7l0eOQje9fdJle
 Q8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778250115; x=1778854915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9oybKgWGrdSrX9eknGp6NH6btmZDhUagbD7C71tP0OM=;
 b=Q5HkEKiCQpU8laJFIYDGKy+t67RRI31D5AGZxF6MGg0Vr4oukyBhhT34KDm1SUBHBS
 U7pu7MsfEquhb7ilD4L3eJuZYmsDR/B51DxXurOhQaMJpaFf8jTQHnF7477EI4zNLAFx
 99BBwXVNOhSzDf6lHGej0M2fu51EABk7a1bR5OAAM9f7/+pWi25qdLqyVUUPqScSxwee
 DQ9Vi49PwDTtPNuHobwRD1DhEKOM6vdEJ3iv/58dO03w4q/t8hHNxjh1AihF2Yadvz0b
 lwBiu8bLT16gz5r6wSMPok8kLFW3VN7TX/bkrdmeXRFwIITFkWUkqABu/+zw17l+ns7S
 hzeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Qpbe/9qUKkxZrC439k31myNRqbXl4jF3W278+qQljBbgIADDK2D4MWW0x+eZAyRdb2SnUYBCpODA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3XAQ3Ol4GRbUxHWBxilwP3HjAFwtNGtbRmerwLpxYMDqLF7ns
 3Hp5YKHNUYltjE+ph34E96Tdvh7m+JKf6bUMbsjbnqT6eFx5dDCXYRaKV1WDDvzQ3XU=
X-Gm-Gg: AeBDies8lcDX9S1zpmgzI3xtbawMz8TccWD3DO+9cXuEMdW3vBANug5sfLu+2fZh205
 4mdfgg4BI5hvC6LLmdBmNH85Vn8q+xfKIK307FJlX4qQet7knDrJ44cA+IvdszUqTGyH16xXGIQ
 RWLrH4dzqIXBKmHUweejS9eyHpw3JbcGgcRdd5bb3RxcnAhx/ypuudzauYCxek2pCdNl0stmi8y
 gUSEXLxiEPs6nyJNSOe6X6suYJJr7aOi4ZRgPHxRr4H4Nyimj/ViTVDrcqOr5FEd++V5vKTFKJ3
 JhTLcK0FjlCs2wDM0gSNH+3TogpIYI+RHfvg9hVgzeOUWwygab7s+Tsl7GbD5vTiIloLZQGtkJ1
 r1L19oLezoQ8lOHvgKcRIQQeeAdjg2KV8RQyrSnq9wU4QI5CL+0BbCNax6w/4isshFlIogHq2ba
 zgMt3TIv3IpPFQbfWaAp2igz9rwiYrmWin6LaukMokV0zTgaHgtLeDIPKWilVkkuzf0btbIWGJA
 49p0vE0
X-Received: by 2002:a05:7300:148c:b0:2c1:67e1:61a9 with SMTP id
 5a478bee46e88-2f6e4374892mr3087610eec.13.1778250114741; 
 Fri, 08 May 2026 07:21:54 -0700 (PDT)
Received: from DontFreeze.tail1d9320.ts.net (201-68-218-231.dsl.telesp.net.br.
 [201.68.218.231]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c469b6sm2324767eec.24.2026.05.08.07.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 07:21:54 -0700 (PDT)
From: Andre Jun Hirata <andrejhirata@usp.br>
To: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 gabriel.dimant@usp.br, guilhermesangabriel@usp.br,
 Andre Jun Hirata <andrejhirata@usp.br>
Subject: [PATCH v3] drm/amd/pm: Use guard(mutex) instead of manual lock+unlock
Date: Fri,  8 May 2026 11:21:42 -0300
Message-ID: <20260508142142.7103-1-andrejhirata@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508111213.53309-1-andrejhirata@usp.br>
References: <20260508111213.53309-1-andrejhirata@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

Use guard() and scoped_guard() for handling mutex lock instead of
manually locking and unlocking the mutex. This prevents forgotten
locks due to early exits and removes the need of gotos.

Signed-off-by: Andre Jun Hirata <andrejhirata@usp.br>
Co-developed-by: Gabriel Dimant <gabriel.dimant@usp.br>
Signed-off-by: Gabriel Dimant <gabriel.dimant@usp.br>
Co-developed-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
Signed-off-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
Reviewed-by: Christian König <christian.koenig@amd.com>

---
v2: incorporate Christian König's suggestions:
  - use return f() directly instead of ret = f(); return ret;
  - use early return pattern before guard() where applicable

v3: fix style nits pointed by Christian König:
  - drop superfluous ret initialization in set_gfx_power_up_by_imu
  - drop unnecessary braces around single-line scoped_guard

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 868 +++++++++-------------------
 1 file changed, 261 insertions(+), 607 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index feadf604b..2a0f4abc4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/cleanup.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -41,33 +42,25 @@
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_sclk)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_sclk((adev)->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_sclk((adev)->powerplay.pp_handle,
 				 low);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_mclk)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_mclk((adev)->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_mclk((adev)->powerplay.pp_handle,
 				 low);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
@@ -80,13 +73,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
 	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
 			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
 		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
 				block_type, gate ? "gate" : "ungate");
-		goto out_unlock;
+		return ret;
 	}
 
 	switch (block_type) {
@@ -115,9 +107,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	if (!ret)
 		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
 
-out_unlock:
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -126,9 +115,8 @@ int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_set_gfx_power_up_by_imu(smu);
-	mutex_unlock(&adev->pm.mutex);
+	scoped_guard(mutex, &adev->pm.mutex)
+		ret = smu_set_gfx_power_up_by_imu(smu);
 
 	msleep(10);
 
@@ -139,44 +127,31 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	/* enter BACO state */
-	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
-
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	return pp_funcs->set_asic_baco_state(pp_handle, 1);
 }
 
 int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	/* exit BACO state */
-	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	return pp_funcs->set_asic_baco_state(pp_handle, 0);
 }
 
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state)
 {
-	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (mp1_state == PP_MP1_STATE_FLR) {
@@ -184,23 +159,19 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 		if (amdgpu_sriov_vf(adev))
 			adev->pm.dpm_enabled = false;
 	} else if (pp_funcs && pp_funcs->set_mp1_state) {
-		mutex_lock(&adev->pm.mutex);
-
-		ret = pp_funcs->set_mp1_state(
+		guard(mutex)(&adev->pm.mutex);
+		return pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
 				mp1_state);
-
-		mutex_unlock(&adev->pm.mutex);
 	}
 
-	return ret;
+	return 0;
 }
 
 int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	int ret;
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return 0;
@@ -216,49 +187,32 @@ int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 	if (adev->in_s3)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-
-	ret = pp_funcs->get_asic_baco_capability(pp_handle);
-
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_asic_baco_capability(pp_handle);
 }
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
-	ret = pp_funcs->asic_reset_mode_2(pp_handle);
-
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->asic_reset_mode_2(pp_handle);
 }
 
 int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->asic_reset_enable_gfx_features)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
-	ret = pp_funcs->asic_reset_enable_gfx_features(pp_handle);
-
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->asic_reset_enable_gfx_features(pp_handle);
 }
 
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
@@ -270,75 +224,60 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 
 	/* enter BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* exit BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-
-out:
-	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
 bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	bool support_mode1_reset = false;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		support_mode1_reset = smu_mode1_reset_is_support(smu);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!is_support_sw_smu(adev))
+		return false;
 
-	return support_mode1_reset;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_mode1_reset_is_support(smu)
 }
 
 int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_mode1_reset(smu);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_mode1_reset(smu);
 }
 
 bool amdgpu_dpm_is_link_reset_supported(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	bool support_link_reset = false;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		support_link_reset = smu_link_reset_is_support(smu);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (is_support_sw_smu(adev))
+		return false;
 
-	return support_link_reset;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_link_reset_is_support(smu);
 }
 
 int amdgpu_dpm_link_reset(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_link_reset(smu);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_link_reset(smu);
 }
 
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
@@ -346,100 +285,82 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    bool en)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (pp_funcs && pp_funcs->switch_power_profile) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->switch_power_profile(
-			adev->powerplay.pp_handle, type, en);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->switch_power_profile)
+		return 0;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->switch_power_profile(
+			adev->powerplay.pp_handle, type, en);
 }
 
 int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
 				   bool pause)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (pp_funcs && pp_funcs->pause_power_profile) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->pause_power_profile(
-			adev->powerplay.pp_handle, pause);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->pause_power_profile)
+		return 0;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->pause_power_profile(
+			adev->powerplay.pp_handle, pause);
 }
 
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
-	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
-								pstate);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->set_xgmi_pstate)
+		return 0;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
+								pstate);
 }
 
 int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 			     uint32_t cstate)
 {
-	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
 
-	if (pp_funcs && pp_funcs->set_df_cstate) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->set_df_cstate)
+		return 0;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_df_cstate(pp_handle, cstate);
 }
 
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_get_pm_policy_info(smu, p_type, buf);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_get_pm_policy_info(smu, p_type, buf);
 }
 
 int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 			     int policy_level)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_set_pm_policy(smu, policy_type, policy_level);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_set_pm_policy(smu, policy_type, policy_level);
 }
 
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
@@ -447,15 +368,12 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs =
 			adev->powerplay.pp_funcs;
-	int ret = 0;
 
-	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->enable_mgpu_fan_boost)
+		return 0;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->enable_mgpu_fan_boost(pp_handle);
 }
 
 int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
@@ -464,16 +382,13 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs =
 			adev->powerplay.pp_funcs;
-	int ret = 0;
 
-	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
-						       msg_id);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->set_clockgating_by_smu)
+		return 0;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_clockgating_by_smu(pp_handle,
+						       msg_id);
 }
 
 int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
@@ -482,22 +397,19 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs =
 			adev->powerplay.pp_funcs;
-	int ret = -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
-						   acquire);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->smu_i2c_bus_access)
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return = pp_funcs->smu_i2c_bus_access(pp_handle,
+						   acquire);
 }
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
 	if (adev->pm.dpm_enabled) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
@@ -510,7 +422,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 		if (is_support_sw_smu(adev))
 			smu_set_ac_dc(adev->powerplay.pp_handle);
 
-		mutex_unlock(&adev->pm.mutex);
 	}
 }
 
@@ -518,49 +429,40 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 			   void *data, uint32_t *size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = -EINVAL;
 
 	if (!data || !size)
 		return -EINVAL;
 
-	if (pp_funcs && pp_funcs->read_sensor) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->read_sensor(adev->powerplay.pp_handle,
+	if (!pp_funcs || !pp_funcs->read_sensor)
+		return -EINVAL;
+
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->read_sensor(adev->powerplay.pp_handle,
 					    sensor,
 					    data,
 					    size);
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return ret;
 }
 
 int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->get_apu_thermal_limit(adev->powerplay.pp_handle, limit);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->get_apu_thermal_limit)
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_apu_thermal_limit(adev->powerplay.pp_handle, limit);
 }
 
 int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
-		mutex_lock(&adev->pm.mutex);
-		ret = pp_funcs->set_apu_thermal_limit(adev->powerplay.pp_handle, limit);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!pp_funcs || !pp_funcs->set_apu_thermal_limit)
+		return -EOPNOTSUPP;
 
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_apu_thermal_limit(adev->powerplay.pp_handle, limit);
 }
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
@@ -583,9 +485,8 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 			amdgpu_fence_wait_empty(ring);
 	}
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
@@ -593,14 +494,14 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 	int ret = 0;
 
 	if (adev->family == AMDGPU_FAMILY_SI) {
-		mutex_lock(&adev->pm.mutex);
-		if (enable) {
-			adev->pm.dpm.uvd_active = true;
-			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
-		} else {
-			adev->pm.dpm.uvd_active = false;
+		scoped_guard(mutex, &adev->pm.mutex) {
+			if (enable) {
+				adev->pm.dpm.uvd_active = true;
+				adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+			} else {
+				adev->pm.dpm.uvd_active = false;
+			}
 		}
-		mutex_unlock(&adev->pm.mutex);
 
 		amdgpu_dpm_compute_clocks(adev);
 		return;
@@ -627,15 +528,15 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 	int ret = 0;
 
 	if (adev->family == AMDGPU_FAMILY_SI) {
-		mutex_lock(&adev->pm.mutex);
-		if (enable) {
-			adev->pm.dpm.vce_active = true;
-			/* XXX select vce level based on ring/task */
-			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
-		} else {
-			adev->pm.dpm.vce_active = false;
+		scoped_guard(mutex, &adev->pm.mutex) {
+			if (enable) {
+				adev->pm.dpm.vce_active = true;
+				/* XXX select vce level based on ring/task */
+				adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
+			} else {
+				adev->pm.dpm.vce_active = false;
+			}
 		}
-		mutex_unlock(&adev->pm.mutex);
 
 		amdgpu_dpm_compute_clocks(adev);
 		return;
@@ -670,84 +571,66 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int r = 0;
+	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->load_firmware ||
 	    (is_support_sw_smu(adev) && (adev->flags & AMD_IS_APU)))
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	r = pp_funcs->load_firmware(adev->powerplay.pp_handle);
-	if (r) {
+	guard(mutex)(&adev->pm.mutex);
+	ret = pp_funcs->load_firmware(adev->powerplay.pp_handle);
+	if (ret) {
 		pr_err("smu firmware loading failed\n");
-		goto out;
+		return ret;
 	}
 
 	if (smu_version)
 		*smu_version = adev->pm.fw_version;
 
-out:
-	mutex_unlock(&adev->pm.mutex);
-	return r;
+	return ret;
 }
 
 int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable)
 {
-	int ret = 0;
+	if (!is_support_sw_smu(adev))
+		return 0;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_handle_passthrough_sbr(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return smu_handle_passthrough_sbr(adev->powerplay.pp_handle,
 						 enable);
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return ret;
 }
 
 int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_send_hbm_bad_pages_num(smu, size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_send_hbm_bad_pages_num(smu, size);
 }
 
 int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_send_hbm_bad_channel_flag(smu, size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_send_hbm_bad_channel_flag(smu, size);
 }
 
 int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_send_rma_reason(smu);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_send_rma_reason(smu);
 }
 
 /**
@@ -761,61 +644,45 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	bool ret;
 
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_reset_sdma_is_supported(smu);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_reset_sdma_is_supported(smu);
 }
 
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_reset_sdma(smu, inst_mask);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_reset_sdma(smu, inst_mask);
 }
 
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_reset_vcn(smu, inst_mask);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_reset_vcn(smu, inst_mask);
 }
 
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	bool ret;
 
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_reset_vcn_is_supported(smu);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_reset_vcn_is_supported(smu);
 }
 
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
@@ -823,22 +690,17 @@ int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  uint32_t *min,
 				  uint32_t *max)
 {
-	int ret = 0;
-
 	if (type != PP_SCLK)
 		return -EINVAL;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_get_dpm_freq_range(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return smu_get_dpm_freq_range(adev->powerplay.pp_handle,
 				     SMU_SCLK,
 				     min,
 				     max);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
@@ -862,16 +724,12 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
 int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_write_watermarks_table(smu);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_write_watermarks_table(smu);
 }
 
 int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
@@ -879,76 +737,56 @@ int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
 			      uint64_t event_arg)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_wait_for_event(smu, event, event_arg);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_wait_for_event(smu, event, event_arg);
 }
 
 int amdgpu_dpm_set_residency_gfxoff(struct amdgpu_device *adev, bool value)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_set_residency_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_set_residency_gfxoff(smu, value);
 }
 
 int amdgpu_dpm_get_residency_gfxoff(struct amdgpu_device *adev, u32 *value)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_get_residency_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_get_residency_gfxoff(smu, value);
 }
 
 int amdgpu_dpm_get_entrycount_gfxoff(struct amdgpu_device *adev, u64 *value)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_get_entrycount_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_get_entrycount_gfxoff(smu, value);
 }
 
 int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_get_status_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_get_status_gfxoff(smu, value);
 }
 
 uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
@@ -969,28 +807,23 @@ uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
 void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
 				 enum gfx_change_state state)
 {
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	if (adev->powerplay.pp_funcs &&
 	    adev->powerplay.pp_funcs->gfx_state_change_set)
 		((adev)->powerplay.pp_funcs->gfx_state_change_set(
 			(adev)->powerplay.pp_handle, state));
-	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
 			    void *umc_ecc)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_get_ecc_info(smu, umc_ecc);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return smu_get_ecc_info(smu, umc_ecc);
 }
 
 struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
@@ -1002,12 +835,9 @@ struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
 	if (!pp_funcs->get_vce_clock_state)
 		return NULL;
 
-	mutex_lock(&adev->pm.mutex);
-	vstate = pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
 					       idx);
-	mutex_unlock(&adev->pm.mutex);
-
-	return vstate;
 }
 
 void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
@@ -1015,11 +845,11 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 
 	if (!pp_funcs->get_current_power_state) {
 		*state = adev->pm.dpm.user_state;
-		goto out;
+		return;
 	}
 
 	*state = pp_funcs->get_current_power_state(adev->powerplay.pp_handle);
@@ -1027,16 +857,14 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
 	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
 		*state = adev->pm.dpm.user_state;
 
-out:
-	mutex_unlock(&adev->pm.mutex);
+	return;
 }
 
 void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state)
 {
-	mutex_lock(&adev->pm.mutex);
-	adev->pm.dpm.user_state = state;
-	mutex_unlock(&adev->pm.mutex);
+	scoped_guard(mutex, &adev->pm.mutex)
+		adev->pm.dpm.user_state = state;
 
 	if (is_support_sw_smu(adev))
 		return;
@@ -1055,12 +883,11 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
 	if (!pp_funcs)
 		return AMD_DPM_FORCED_LEVEL_AUTO;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
 		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
 	else
 		level = adev->pm.dpm.forced_level;
-	mutex_unlock(&adev->pm.mutex);
 
 	return level;
 }
@@ -1151,17 +978,13 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 				 struct pp_states_info *states)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_pp_num_states)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
 					  states);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
@@ -1169,24 +992,19 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 			      enum amd_pm_state_type *user_state)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->dispatch_tasks)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
 				       task_id,
 				       user_state);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!table)
 		return -EINVAL;
@@ -1194,12 +1012,9 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
-				     table);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
+				     table);
 }
 
 int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
@@ -1208,19 +1023,15 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
 				      uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_fine_grain_clk_vol)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return = pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
 					       type,
 					       input,
 					       size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
@@ -1229,19 +1040,15 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 				  uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->odn_edit_dpm_table)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
 					   type,
 					   input,
 					   size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
@@ -1250,52 +1057,40 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
 				  int *offset)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->emit_clock_levels)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
 					   type,
 					   buf,
 					   offset);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 				    uint64_t ppfeature_masks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_ppfeature_status)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
 					     ppfeature_masks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_ppfeature_status)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
 					     buf);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
@@ -1303,33 +1098,25 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
 				 uint32_t mask)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->force_clock_level)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->force_clock_level(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->force_clock_level(adev->powerplay.pp_handle,
 					  type,
 					  mask);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_sclk_od)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
 }
 
 int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
@@ -1339,10 +1126,10 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 	if (is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	if (pp_funcs->set_sclk_od)
-		pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
-	mutex_unlock(&adev->pm.mutex);
+	scoped_guard(mutex, &adev->pm.mutex) {
+		if (pp_funcs->set_sclk_od)
+			pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
+	}
 
 	if (amdgpu_dpm_dispatch_task(adev,
 				     AMD_PP_TASK_READJUST_POWER_STATE,
@@ -1357,16 +1144,12 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_mclk_od)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
 }
 
 int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
@@ -1376,10 +1159,10 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 	if (is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	if (pp_funcs->set_mclk_od)
-		pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
-	mutex_unlock(&adev->pm.mutex);
+	scoped_guard(mutex, &adev->pm.mutex) {
+		if (pp_funcs->set_mclk_od)
+			pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
+	}
 
 	if (amdgpu_dpm_dispatch_task(adev,
 				     AMD_PP_TASK_READJUST_POWER_STATE,
@@ -1395,170 +1178,130 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
 					       buf);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_power_profile_mode)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
 					       input,
 					       size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
 					table);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
 				  size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_pm_metrics)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
 				       size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
 					     fan_mode);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
 				 uint32_t speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_pwm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
 				 uint32_t *speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_pwm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
 				 uint32_t *speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_rpm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
 				 uint32_t speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_rpm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t mode)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
 					     mode);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
@@ -1567,19 +1310,15 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 			       enum pp_power_type power_type)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_power_limit)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_power_limit(adev->powerplay.pp_handle,
 					limit,
 					pp_limit_level,
 					power_type);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
@@ -1587,17 +1326,13 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 			       uint32_t limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_power_limit)
 		return -EINVAL;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_power_limit(adev->powerplay.pp_handle,
 					limit_type, limit);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
@@ -1607,9 +1342,8 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	cclk_dpm_supported = is_support_cclk_dpm(adev);
-	mutex_unlock(&adev->pm.mutex);
 
 	return (int)cclk_dpm_supported;
 }
@@ -1622,10 +1356,9 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
 	if (!pp_funcs->debugfs_print_current_performance_level)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->debugfs_print_current_performance_level(adev->powerplay.pp_handle,
 							  m);
-	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -1635,18 +1368,14 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 				       size_t *size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_smu_prv_buf_details)
 		return -ENOSYS;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
 						addr,
 						size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
@@ -1698,7 +1427,6 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!buf || !size)
 		return -EINVAL;
@@ -1706,13 +1434,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_pp_table(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_pp_table(adev->powerplay.pp_handle,
 				     buf,
 				     size);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
@@ -1737,17 +1462,13 @@ int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
 					    const struct amd_pp_display_configuration *input)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->display_configuration_change)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
 						     input);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
@@ -1755,35 +1476,27 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
 				 struct amd_pp_clocks *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_clock_by_type)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
 					  type,
 					  clocks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
 						struct amd_pp_simple_clock_info *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_display_mode_validation_clocks)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return = pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
 							   clocks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
@@ -1791,18 +1504,14 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
 					      struct pp_clock_levels_with_latency *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_clock_by_type_with_latency)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
 						       type,
 						       clocks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
@@ -1810,69 +1519,53 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
 					      struct pp_clock_levels_with_voltage *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_clock_by_type_with_voltage)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
 						       type,
 						       clocks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
 					       void *clock_ranges)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_watermarks_for_clocks_ranges)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
 							 clock_ranges);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
 					     struct pp_display_clock_request *clock)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->display_clock_voltage_request)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
 						      clock);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
 				  struct amd_pp_clock_info *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_current_clocks)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
 					   clocks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
@@ -1882,43 +1575,34 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
 	if (!pp_funcs->notify_smu_enable_pwe)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
 					uint32_t count)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_active_display_count)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
 						 count);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
 					  uint32_t clock)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->set_min_deep_sleep_dcefclk)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
 						   clock);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
@@ -1929,10 +1613,9 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
 					       clock);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
@@ -1943,44 +1626,35 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_fclk_by_freq)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
 					    clock);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
 						   bool disable_memory_clock_switch)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->display_disable_memory_clock_switch)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
 							    disable_memory_clock_switch);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
 						struct pp_smu_nv_clock_table *max_clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
 							 max_clocks);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
@@ -1988,35 +1662,27 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_uclk_dpm_states)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
 					    clock_values_in_khz,
 					    num_states);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_dpm_clock_table)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
 					    clock_table);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 /**
@@ -2037,17 +1703,13 @@ ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
 				    enum smu_temp_metric_type type, void *table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret;
 
 	if (!pp_funcs->get_temp_metrics ||
 	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
 }
 
 /**
@@ -2064,19 +1726,15 @@ bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	bool support_temp_metrics = false;
 
 	if (!pp_funcs->temp_metrics_is_supported)
-		return support_temp_metrics;
+		return false;
 
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		support_temp_metrics =
-			pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
-		mutex_unlock(&adev->pm.mutex);
-	}
+	if (!is_support_sw_smu(adev))
+		return false;
 
-	return support_temp_metrics;
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
 }
 
 /**
@@ -2098,17 +1756,13 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 				   void *table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
 
 	if (!pp_funcs->get_xcp_metrics)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id,
+	guard(mutex)(&adev->pm.mutex);
+	return pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id,
 					table);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev)
-- 
2.43.0

