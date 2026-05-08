Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A632CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E45010F2EC;
	Fri,  8 May 2026 07:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="PNU8H5dP";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C770610E2DD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 02:48:57 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so4031194eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778208537; x=1778813337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vi7JmfvF0Dj77MW1QUs1e0pA+dGxpN5ALhf0rwynnn0=;
 b=PNU8H5dPYz/nnpc5bWksX3fV4jGyRn7JmU9RMvOcJLtXZ9t8mY5G/LqdgzWJ2iGt8q
 plc+QVKRYk/yfXYAJ91flnFKa3bhvemYd03xL6Cq8SI9iLfioLqdw5GnpXyZkftkoXBV
 4CoXsVYS6ceHnpaytzZr3EtRzCpBIWrgwh5l/Buu+tnZsUrN8AibZ6vKLSCLmUoHLwgL
 DrnWMzfiG5svdVjTnsqxZNOqaGEP4Wmwlg+N/7xPmnN3udKkbONbpo7NE/fzi2MvuR1V
 GUN2Skxijf7u93rrVfWce1ruduxG797fXJMIS8CtyX3B2yzbsiKVKS5V9b7D6PQjUjzX
 nEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778208537; x=1778813337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vi7JmfvF0Dj77MW1QUs1e0pA+dGxpN5ALhf0rwynnn0=;
 b=SMuOWYq2qtQui3rvzKCR5EhItukPM/8UTD9FKS6HLR1E4hIlbFg1+oOtUvjOnTireY
 04yO0bHWAsWnAS9us24lbwYo3q/gmWg4CbQxV+wEoScB3V0wDDlFILO7g1+/t23myOeU
 S8bN63uHGjpEN1Xr2eYv2w+L5MLETWC2HwB/80/O3qQeTpmXc4CIlJxbtX6LfVBK9/g5
 0x7KYu7PAcODlSFOkvxY7sQZoknSKvlhtcoG2I95vu5kJeUfi4uvcxPfdLufCakChKkV
 11RuOpNehr3LWAQTP0PCvbG24hCIgDHe4dpNOFJkTVD6PZ5628dgkTeCtRMucagkaqir
 MvLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9id3ELoV/Yn3TmrDk0oPt2C2JNAcPq35/7Dl5hqiCuubOf8+wzxMJrYYI5efz5HqYxT2y54ci4bdQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyu7q5UhR1/yMfKCbOrWHf3olR4RX9EUJbOu5CMcn6wu6PsVxUt
 pNixmTWMLMx+IOExTTfSOa3wvguwQHQgY9GN2DHpGu3RMVioYO/PBCdyjpJCSQ/wnS8=
X-Gm-Gg: Acq92OFGLmnQN02fep4I8pMNSSq7gyiL/+eM3/lzW+9SZsFOECTp3uy6Lr2Kh8aNfy8
 sspLPnFM8yhoRCRQhH2684KJyTHFf2T5XWbehZHhIwrHGCG1X+YY04JtUY2gq8DOvO3+Mh2pJd+
 /Q7R+xwdT/VbisB9xzORTagdypHe3gD8SU3AZSOLEseZjeO+W9Aiz4ZfvyGJrQ2ro4qC3F8pI4f
 /4Ffv1khx5/S6JsESUJqLlCacNLU7VFSjqD3V7rkTpUN0jxT306iNu52XhiwX7lYkYa/ZhlT8rl
 zvgdztuP3PlN1covCz5RoyklOX9pmeBat4F7IyMw7zi0apO9STmP7pLw0XN9ihgC6a4j3iZPimd
 NtpLl+PQa8s7T8KaK3zX6ABuJ5GnAN5HX8dKl14dVv+yil0ctjyYuf5EUCoFcnbF3Z+uOEIv9xf
 DRxVPiOq9gmYburg2q3KpzwRxbP3ZkRPIqaDabUHbSfGCJXx13wKR7D7+2XXkh6paqPw+xAHBO3
 HzqtzLg
X-Received: by 2002:a05:7301:4289:b0:2d4:62f0:b2d4 with SMTP id
 5a478bee46e88-2f54948f51dmr3444068eec.13.1778208536736; 
 Thu, 07 May 2026 19:48:56 -0700 (PDT)
Received: from DontFreeze.tail1d9320.ts.net (201-68-218-231.dsl.telesp.net.br.
 [201.68.218.231]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f885edb83fsm455669eec.7.2026.05.07.19.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 19:48:56 -0700 (PDT)
From: Andre Hirata <andrejhirata@usp.br>
To: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: Andre Jun Hirata <andrejhirata@usp.br>,
 Gabriel Dimant <gabriel.dimant@usp.br>,
 Guilherme Gabriel <guilhermesangabriel@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND] drm/amd/pm: Use guard(mutex) instead of manual
 lock+unlock
Date: Thu,  7 May 2026 23:47:42 -0300
Message-ID: <20260508024744.6523-1-andrejhirata@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 May 2026 07:55:51 +0000
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

From: Andre Jun Hirata <andrejhirata@usp.br>

Use guard() and scoped_guard() for handling mutex lock instead of
manually locking and unlocking the mutex. This prevents forgotten
locks due to early exits and removes the need of gotos.

Signed-off-by: Andre Jun Hirata <andrejhirata@usp.br>
Co-developed-by: Gabriel Dimant <gabriel.dimant@usp.br>
Signed-off-by: Gabriel Dimant <gabriel.dimant@usp.br>
Co-developed-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
Signed-off-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 384 ++++++++++------------------
 1 file changed, 135 insertions(+), 249 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index feadf604b..fc8f137a2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/cleanup.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -46,10 +47,9 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 	if (!pp_funcs->get_sclk)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_sclk((adev)->powerplay.pp_handle,
 				 low);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -62,10 +62,9 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 	if (!pp_funcs->get_mclk)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_mclk((adev)->powerplay.pp_handle,
 				 low);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -80,13 +79,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
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
@@ -115,9 +113,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	if (!ret)
 		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
 
-out_unlock:
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -126,9 +121,9 @@ int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_set_gfx_power_up_by_imu(smu);
-	mutex_unlock(&adev->pm.mutex);
+	scoped_guard(mutex, &adev->pm.mutex) {
+		ret = smu_set_gfx_power_up_by_imu(smu);
+	}
 
 	msleep(10);
 
@@ -144,13 +139,10 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	/* enter BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
 
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -163,13 +155,10 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	/* exit BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
 
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -184,13 +173,10 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 		if (amdgpu_sriov_vf(adev))
 			adev->pm.dpm_enabled = false;
 	} else if (pp_funcs && pp_funcs->set_mp1_state) {
-		mutex_lock(&adev->pm.mutex);
-
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
 				mp1_state);
-
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -216,12 +202,9 @@ int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 	if (adev->in_s3)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_asic_baco_capability(pp_handle);
 
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -234,12 +217,9 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->asic_reset_mode_2(pp_handle);
 
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -252,12 +232,9 @@ int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->asic_reset_enable_gfx_features)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
-
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->asic_reset_enable_gfx_features(pp_handle);
 
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -270,18 +247,15 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
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
 
@@ -291,9 +265,8 @@ bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
 	bool support_mode1_reset = false;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		support_mode1_reset = smu_mode1_reset_is_support(smu);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return support_mode1_reset;
@@ -305,9 +278,8 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
 	int ret = -EOPNOTSUPP;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = smu_mode1_reset(smu);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -319,9 +291,8 @@ bool amdgpu_dpm_is_link_reset_supported(struct amdgpu_device *adev)
 	bool support_link_reset = false;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		support_link_reset = smu_link_reset_is_support(smu);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return support_link_reset;
@@ -333,9 +304,8 @@ int amdgpu_dpm_link_reset(struct amdgpu_device *adev)
 	int ret = -EOPNOTSUPP;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = smu_link_reset(smu);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -352,10 +322,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 		return 0;
 
 	if (pp_funcs && pp_funcs->switch_power_profile) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->switch_power_profile(
 			adev->powerplay.pp_handle, type, en);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -371,10 +340,9 @@ int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
 		return 0;
 
 	if (pp_funcs && pp_funcs->pause_power_profile) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->pause_power_profile(
 			adev->powerplay.pp_handle, pause);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -387,10 +355,9 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
 								pstate);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -404,9 +371,8 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	void *pp_handle = adev->powerplay.pp_handle;
 
 	if (pp_funcs && pp_funcs->set_df_cstate) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -419,9 +385,8 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 	int ret = -EOPNOTSUPP;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = smu_get_pm_policy_info(smu, p_type, buf);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -434,9 +399,8 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 	int ret = -EOPNOTSUPP;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = smu_set_pm_policy(smu, policy_type, policy_level);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -450,9 +414,8 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 	int ret = 0;
 
 	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -467,10 +430,9 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
 						       msg_id);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -485,10 +447,9 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 	int ret = -EOPNOTSUPP;
 
 	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
 						   acquire);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -497,7 +458,7 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
 	if (adev->pm.dpm_enabled) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
@@ -510,7 +471,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 		if (is_support_sw_smu(adev))
 			smu_set_ac_dc(adev->powerplay.pp_handle);
 
-		mutex_unlock(&adev->pm.mutex);
 	}
 }
 
@@ -524,12 +484,11 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 		return -EINVAL;
 
 	if (pp_funcs && pp_funcs->read_sensor) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->read_sensor(adev->powerplay.pp_handle,
 					    sensor,
 					    data,
 					    size);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -541,9 +500,8 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit
 	int ret = -EOPNOTSUPP;
 
 	if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->get_apu_thermal_limit(adev->powerplay.pp_handle, limit);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -555,9 +513,8 @@ int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit)
 	int ret = -EOPNOTSUPP;
 
 	if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = pp_funcs->set_apu_thermal_limit(adev->powerplay.pp_handle, limit);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -583,9 +540,8 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 			amdgpu_fence_wait_empty(ring);
 	}
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
@@ -593,14 +549,14 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
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
@@ -627,15 +583,15 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
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
@@ -670,25 +626,23 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
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
@@ -696,10 +650,9 @@ int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable)
 	int ret = 0;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		ret = smu_handle_passthrough_sbr(adev->powerplay.pp_handle,
 						 enable);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -713,9 +666,8 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_send_hbm_bad_pages_num(smu, size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -728,9 +680,8 @@ int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t si
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_send_hbm_bad_channel_flag(smu, size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -743,9 +694,8 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_send_rma_reason(smu);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -766,9 +716,8 @@ bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_reset_sdma_is_supported(smu);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -781,9 +730,8 @@ int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_reset_sdma(smu, inst_mask);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -796,9 +744,8 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_reset_vcn(smu, inst_mask);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -811,9 +758,8 @@ bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_reset_vcn_is_supported(smu);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -831,12 +777,11 @@ int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_get_dpm_freq_range(adev->powerplay.pp_handle,
 				     SMU_SCLK,
 				     min,
 				     max);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -867,9 +812,8 @@ int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_write_watermarks_table(smu);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -884,9 +828,8 @@ int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_wait_for_event(smu, event, event_arg);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -899,9 +842,8 @@ int amdgpu_dpm_set_residency_gfxoff(struct amdgpu_device *adev, bool value)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_set_residency_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -914,9 +856,8 @@ int amdgpu_dpm_get_residency_gfxoff(struct amdgpu_device *adev, u32 *value)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_get_residency_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -929,9 +870,8 @@ int amdgpu_dpm_get_entrycount_gfxoff(struct amdgpu_device *adev, u64 *value)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_get_entrycount_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -944,9 +884,8 @@ int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_get_status_gfxoff(smu, value);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -969,12 +908,11 @@ uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
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
@@ -986,9 +924,8 @@ int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = smu_get_ecc_info(smu, umc_ecc);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1002,10 +939,9 @@ struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
 	if (!pp_funcs->get_vce_clock_state)
 		return NULL;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	vstate = pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
 					       idx);
-	mutex_unlock(&adev->pm.mutex);
 
 	return vstate;
 }
@@ -1015,11 +951,11 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
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
@@ -1027,16 +963,15 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
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
+	scoped_guard(mutex, &adev->pm.mutex) {
+		adev->pm.dpm.user_state = state;
+	}
 
 	if (is_support_sw_smu(adev))
 		return;
@@ -1055,12 +990,11 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
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
@@ -1156,10 +1090,9 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 	if (!pp_funcs->get_pp_num_states)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
 					  states);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1174,11 +1107,10 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	if (!pp_funcs->dispatch_tasks)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
 				       task_id,
 				       user_state);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1194,10 +1126,9 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
 				     table);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1213,12 +1144,11 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fine_grain_clk_vol)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
 					       type,
 					       input,
 					       size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1234,12 +1164,11 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 	if (!pp_funcs->odn_edit_dpm_table)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
 					   type,
 					   input,
 					   size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1255,12 +1184,11 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
 	if (!pp_funcs->emit_clock_levels)
 		return -ENOENT;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
 					   type,
 					   buf,
 					   offset);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1274,10 +1202,9 @@ int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 	if (!pp_funcs->set_ppfeature_status)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
 					     ppfeature_masks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1290,10 +1217,9 @@ int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
 	if (!pp_funcs->get_ppfeature_status)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
 					     buf);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1308,11 +1234,10 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
 	if (!pp_funcs->force_clock_level)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->force_clock_level(adev->powerplay.pp_handle,
 					  type,
 					  mask);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1325,9 +1250,8 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
 	if (!pp_funcs->get_sclk_od)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1339,10 +1263,10 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
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
@@ -1362,9 +1286,8 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
 	if (!pp_funcs->get_mclk_od)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1376,10 +1299,10 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
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
@@ -1400,10 +1323,9 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
 					       buf);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1417,11 +1339,10 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->set_power_profile_mode)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
 					       input,
 					       size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1434,10 +1355,9 @@ int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
 					table);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1451,10 +1371,9 @@ ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
 	if (!pp_funcs->get_pm_metrics)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
 				       size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1468,10 +1387,9 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
 					     fan_mode);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1485,10 +1403,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_speed_pwm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1502,10 +1419,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_speed_pwm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1519,10 +1435,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_speed_rpm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1536,10 +1451,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_speed_rpm)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
 					  speed);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1553,10 +1467,9 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
 					     mode);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1572,12 +1485,11 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 	if (!pp_funcs->get_power_limit)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
 					limit,
 					pp_limit_level,
 					power_type);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1592,10 +1504,9 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 	if (!pp_funcs->set_power_limit)
 		return -EINVAL;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
 					limit_type, limit);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1607,9 +1518,8 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	cclk_dpm_supported = is_support_cclk_dpm(adev);
-	mutex_unlock(&adev->pm.mutex);
 
 	return (int)cclk_dpm_supported;
 }
@@ -1622,10 +1532,9 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
 	if (!pp_funcs->debugfs_print_current_performance_level)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->debugfs_print_current_performance_level(adev->powerplay.pp_handle,
 							  m);
-	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -1640,11 +1549,10 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 	if (!pp_funcs->get_smu_prv_buf_details)
 		return -ENOSYS;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
 						addr,
 						size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1706,11 +1614,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_pp_table(adev->powerplay.pp_handle,
 				     buf,
 				     size);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1742,10 +1649,9 @@ int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
 	if (!pp_funcs->display_configuration_change)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
 						     input);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1760,11 +1666,10 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
 	if (!pp_funcs->get_clock_by_type)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
 					  type,
 					  clocks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1778,10 +1683,9 @@ int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
 	if (!pp_funcs->get_display_mode_validation_clocks)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
 							   clocks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1796,11 +1700,10 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
 	if (!pp_funcs->get_clock_by_type_with_latency)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
 						       type,
 						       clocks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1815,11 +1718,10 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
 	if (!pp_funcs->get_clock_by_type_with_voltage)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
 						       type,
 						       clocks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1833,10 +1735,9 @@ int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
 	if (!pp_funcs->set_watermarks_for_clocks_ranges)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
 							 clock_ranges);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1850,10 +1751,9 @@ int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
 	if (!pp_funcs->display_clock_voltage_request)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
 						      clock);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1867,10 +1767,9 @@ int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
 	if (!pp_funcs->get_current_clocks)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
 					   clocks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1882,9 +1781,8 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
 	if (!pp_funcs->notify_smu_enable_pwe)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
@@ -1896,10 +1794,9 @@ int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
 	if (!pp_funcs->set_active_display_count)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
 						 count);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1913,10 +1810,9 @@ int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
 	if (!pp_funcs->set_min_deep_sleep_dcefclk)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
 						   clock);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1929,10 +1825,9 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
 					       clock);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
@@ -1943,10 +1838,9 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_fclk_by_freq)
 		return;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
 					    clock);
-	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
@@ -1958,11 +1852,9 @@ int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
 	if (!pp_funcs->display_disable_memory_clock_switch)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
 							    disable_memory_clock_switch);
-	mutex_unlock(&adev->pm.mutex);
-
 	return ret;
 }
 
@@ -1975,10 +1867,9 @@ int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
 	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
 							 max_clocks);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -1993,11 +1884,10 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 	if (!pp_funcs->get_uclk_dpm_states)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
 					    clock_values_in_khz,
 					    num_states);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -2011,10 +1901,9 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 	if (!pp_funcs->get_dpm_clock_table)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
 					    clock_table);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -2043,9 +1932,8 @@ ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
 	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
@@ -2070,10 +1958,9 @@ bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 		return support_temp_metrics;
 
 	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
+		guard(mutex)(&adev->pm.mutex);
 		support_temp_metrics =
 			pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
-		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return support_temp_metrics;
@@ -2103,10 +1990,9 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 	if (!pp_funcs->get_xcp_metrics)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
+	guard(mutex)(&adev->pm.mutex);
 	ret = pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id,
 					table);
-	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
 }
-- 
2.43.0

