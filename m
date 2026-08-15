Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40FEC5DF6A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 18:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E7910E21C;
	Sat, 15 Aug 2026 18:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="gtRQ0oFW";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9397C10E232;
 Sat, 15 Aug 2026 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=JlABK6BU2IUXRTJvhlCW2Qh3AOM/Z2Os7JmIZcJCzM4=; b=gtRQ0oFWTL3SiHef
 fXp7qpzWOO45DbC0zGZSkhCJU/q0oaAz5OWWgu5exIhIvXJcHmfWcHNuXuxzLeCbrrLQr0QcpUbhn
 pZrO/Ma/2SCz+ukmi5HLbfqC5Qk6yBdNsBXAgnqcf3PD4bMHgn4gE1st/7e9Kbuq0ZBcZRLkzNu5s
 +NcKyv8sJlUD9iu1BPxDzPfsj9HJkq9jGZPwrPzrIx27lDrI+ACyXLw4SigXzZfhL4mfxy1JqbxyS
 NXdiAh0EaZy/RjGDCoSZKWFgkktODBl8oHYEii9lc454TSq4uKtn+LHOxy56co19D29ZVm31GtyPl
 jTZb57+NDnRD6NDSaA==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <linux@treblig.org>) id 1wvIgZ-00000002HFi-00or;
 Sat, 15 Aug 2026 18:00:47 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/4] drm/amdgpu: Remove is_idle (trivial cases)
Date: Sat, 15 Aug 2026 19:00:31 +0100
Message-ID: <20260815180033.8958-3-linux@treblig.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815180033.8958-1-linux@treblig.org>
References: <20260815180033.8958-1-linux@treblig.org>
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The is_idle method on amd_ip_funcs is never called.
Remove the trivial cases where either:
  a) It's just a return true function that can be deleted
     together with the .is_init =
  b) The function is called somewhere else, so we just remove
     the assignment.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 6 ------
 drivers/gpu/drm/amd/amdgpu/cik.c                  | 7 -------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 6 ------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 6 ------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 6 ------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c            | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 7 -------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 7 -------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            | 7 -------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 7 -------
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              | 7 -------
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              | 7 -------
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              | 7 -------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            | 2 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            | 7 -------
 drivers/gpu/drm/amd/amdgpu/nv.c                   | 6 ------
 drivers/gpu/drm/amd/amdgpu/si.c                   | 6 ------
 drivers/gpu/drm/amd/amdgpu/si_dma.c               | 1 -
 drivers/gpu/drm/amd/amdgpu/si_ih.c                | 1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc21.c                | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc24.c                | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c             | 6 ------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             | 2 --
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            | 7 -------
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            | 7 -------
 drivers/gpu/drm/amd/amdgpu/vi.c                   | 6 ------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 --------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 -
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 6 ------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 7 -------
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 6 ------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 1 -
 57 files changed, 213 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 9014678d75ab..e475bf2bd1a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -588,11 +588,6 @@ static int acp_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool acp_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int acp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
@@ -618,7 +613,6 @@ static const struct amd_ip_funcs acp_ip_funcs = {
 	.hw_fini = acp_hw_fini,
 	.suspend = acp_suspend,
 	.resume = acp_resume,
-	.is_idle = acp_is_idle,
 	.set_clockgating_state = acp_set_clockgating_state,
 	.set_powergating_state = acp_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 532f83d783d1..976b65f90bc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -126,11 +126,6 @@ static int isp_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool isp_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int isp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
@@ -345,7 +340,6 @@ static const struct amd_ip_funcs isp_ip_funcs = {
 	.early_init = isp_early_init,
 	.hw_init = isp_hw_init,
 	.hw_fini = isp_hw_fini,
-	.is_idle = isp_is_idle,
 	.suspend = isp_suspend,
 	.resume = isp_resume,
 	.set_clockgating_state = isp_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index c835504fdf2b..d6b51b3f216b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -508,11 +508,6 @@ static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
 }
 
-static bool amdgpu_vkms_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
@@ -533,7 +528,6 @@ static const struct amd_ip_funcs amdgpu_vkms_ip_funcs = {
 	.hw_fini = amdgpu_vkms_hw_fini,
 	.suspend = amdgpu_vkms_suspend,
 	.resume = amdgpu_vkms_resume,
-	.is_idle = amdgpu_vkms_is_idle,
 	.set_clockgating_state = amdgpu_vkms_set_clockgating_state,
 	.set_powergating_state = amdgpu_vkms_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index e037c08c8547..d29991a4af4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2137,12 +2137,6 @@ static int cik_common_resume(struct amdgpu_ip_block *ip_block)
 	return cik_common_hw_init(ip_block);
 }
 
-static bool cik_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
-
 
 static int cik_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
@@ -2168,7 +2162,6 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
 	.hw_init = cik_common_hw_init,
 	.hw_fini = cik_common_hw_fini,
 	.resume = cik_common_resume,
-	.is_idle = cik_common_is_idle,
 	.soft_reset = cik_common_soft_reset,
 	.set_clockgating_state = cik_common_set_clockgating_state,
 	.set_powergating_state = cik_common_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index b951328d94cf..824ccac9f9f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1225,7 +1225,6 @@ static const struct amd_ip_funcs cik_sdma_ip_funcs = {
 	.hw_fini = cik_sdma_hw_fini,
 	.suspend = cik_sdma_suspend,
 	.resume = cik_sdma_resume,
-	.is_idle = cik_sdma_is_idle,
 	.wait_for_idle = cik_sdma_wait_for_idle,
 	.soft_reset = cik_sdma_soft_reset,
 	.set_clockgating_state = cik_sdma_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index f2977fe6d824..7de7adc8f225 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2921,11 +2921,6 @@ static int dce_v10_0_resume(struct amdgpu_ip_block *ip_block)
 	return amdgpu_display_resume_helper(adev);
 }
 
-static bool dce_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static void dce_v10_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 						     int crtc,
 						     enum amdgpu_interrupt_state state)
@@ -3267,7 +3262,6 @@ static const struct amd_ip_funcs dce_v10_0_ip_funcs = {
 	.hw_fini = dce_v10_0_hw_fini,
 	.suspend = dce_v10_0_suspend,
 	.resume = dce_v10_0_resume,
-	.is_idle = dce_v10_0_is_idle,
 	.set_clockgating_state = dce_v10_0_set_clockgating_state,
 	.set_powergating_state = dce_v10_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index c68de0fe1d7d..3c1d6901127d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2867,11 +2867,6 @@ static int dce_v6_0_resume(struct amdgpu_ip_block *ip_block)
 	return amdgpu_display_resume_helper(adev);
 }
 
-static bool dce_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 						     int crtc,
 						     enum amdgpu_interrupt_state state)
@@ -3167,7 +3162,6 @@ static const struct amd_ip_funcs dce_v6_0_ip_funcs = {
 	.hw_fini = dce_v6_0_hw_fini,
 	.suspend = dce_v6_0_suspend,
 	.resume = dce_v6_0_resume,
-	.is_idle = dce_v6_0_is_idle,
 	.set_clockgating_state = dce_v6_0_set_clockgating_state,
 	.set_powergating_state = dce_v6_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index c3906270f25e..a17944d5e843 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2839,11 +2839,6 @@ static int dce_v8_0_resume(struct amdgpu_ip_block *ip_block)
 	return amdgpu_display_resume_helper(adev);
 }
 
-static bool dce_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static void dce_v8_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 						     int crtc,
 						     enum amdgpu_interrupt_state state)
@@ -3184,7 +3179,6 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs = {
 	.hw_fini = dce_v8_0_hw_fini,
 	.suspend = dce_v8_0_suspend,
 	.resume = dce_v8_0_resume,
-	.is_idle = dce_v8_0_is_idle,
 	.set_clockgating_state = dce_v8_0_set_clockgating_state,
 	.set_powergating_state = dce_v8_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index e49d8a79045c..9dd7a3335719 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -4186,7 +4186,6 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.hw_fini = gfx_v12_1_hw_fini,
 	.suspend = gfx_v12_1_suspend,
 	.resume = gfx_v12_1_resume,
-	.is_idle = gfx_v12_1_is_idle,
 	.wait_for_idle = gfx_v12_1_wait_for_idle,
 	.set_clockgating_state = gfx_v12_1_set_clockgating_state,
 	.set_powergating_state = gfx_v12_1_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 563abcf718b7..6c98de9d9747 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3665,7 +3665,6 @@ static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.hw_fini = gfx_v6_0_hw_fini,
 	.suspend = gfx_v6_0_suspend,
 	.resume = gfx_v6_0_resume,
-	.is_idle = gfx_v6_0_is_idle,
 	.wait_for_idle = gfx_v6_0_wait_for_idle,
 	.soft_reset = gfx_v6_0_soft_reset,
 	.set_clockgating_state = gfx_v6_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6cf427995078..f7c2b149acd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6762,7 +6762,6 @@ static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.hw_fini = gfx_v8_0_hw_fini,
 	.suspend = gfx_v8_0_suspend,
 	.resume = gfx_v8_0_resume,
-	.is_idle = gfx_v8_0_is_idle,
 	.wait_for_idle = gfx_v8_0_wait_for_idle,
 	.soft_reset = gfx_v8_0_soft_reset,
 	.set_clockgating_state = gfx_v8_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c3322058720f..a4365e26120a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7528,7 +7528,6 @@ static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.hw_fini = gfx_v9_0_hw_fini,
 	.suspend = gfx_v9_0_suspend,
 	.resume = gfx_v9_0_resume,
-	.is_idle = gfx_v9_0_is_idle,
 	.wait_for_idle = gfx_v9_0_wait_for_idle,
 	.soft_reset = gfx_v9_0_soft_reset,
 	.set_clockgating_state = gfx_v9_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 522981fa182d..99732056c58f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3944,7 +3944,6 @@ static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.hw_fini = gfx_v9_4_3_hw_fini,
 	.suspend = gfx_v9_4_3_suspend,
 	.resume = gfx_v9_4_3_resume,
-	.is_idle = gfx_v9_4_3_is_idle,
 	.wait_for_idle = gfx_v9_4_3_wait_for_idle,
 	.soft_reset = gfx_v9_4_3_soft_reset,
 	.set_clockgating_state = gfx_v9_4_3_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c70657bc089b..75a552782c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1043,12 +1043,6 @@ static int gmc_v10_0_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool gmc_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* MC is always ready in GMC v10.*/
-	return true;
-}
-
 static int gmc_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v10.*/
@@ -1114,7 +1108,6 @@ const struct amd_ip_funcs gmc_v10_0_ip_funcs = {
 	.hw_fini = gmc_v10_0_hw_fini,
 	.suspend = gmc_v10_0_suspend,
 	.resume = gmc_v10_0_resume,
-	.is_idle = gmc_v10_0_is_idle,
 	.wait_for_idle = gmc_v10_0_wait_for_idle,
 	.set_clockgating_state = gmc_v10_0_set_clockgating_state,
 	.set_powergating_state = gmc_v10_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7e612f947349..f454aff831b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -1004,12 +1004,6 @@ static int gmc_v11_0_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool gmc_v11_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* MC is always ready in GMC v11.*/
-	return true;
-}
-
 static int gmc_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v11.*/
@@ -1054,7 +1048,6 @@ const struct amd_ip_funcs gmc_v11_0_ip_funcs = {
 	.hw_fini = gmc_v11_0_hw_fini,
 	.suspend = gmc_v11_0_suspend,
 	.resume = gmc_v11_0_resume,
-	.is_idle = gmc_v11_0_is_idle,
 	.wait_for_idle = gmc_v11_0_wait_for_idle,
 	.set_clockgating_state = gmc_v11_0_set_clockgating_state,
 	.set_powergating_state = gmc_v11_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index b05465dc30b4..2c7e3eae7b23 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1105,12 +1105,6 @@ static int gmc_v12_0_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool gmc_v12_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* MC is always ready in GMC v11.*/
-	return true;
-}
-
 static int gmc_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v11.*/
@@ -1159,7 +1153,6 @@ const struct amd_ip_funcs gmc_v12_0_ip_funcs = {
 	.hw_fini = gmc_v12_0_hw_fini,
 	.suspend = gmc_v12_0_suspend,
 	.resume = gmc_v12_0_resume,
-	.is_idle = gmc_v12_0_is_idle,
 	.wait_for_idle = gmc_v12_0_wait_for_idle,
 	.set_clockgating_state = gmc_v12_0_set_clockgating_state,
 	.set_powergating_state = gmc_v12_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b49098931d19..ca7afb9b7d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1132,7 +1132,6 @@ static const struct amd_ip_funcs gmc_v6_0_ip_funcs = {
 	.hw_fini = gmc_v6_0_hw_fini,
 	.suspend = gmc_v6_0_suspend,
 	.resume = gmc_v6_0_resume,
-	.is_idle = gmc_v6_0_is_idle,
 	.wait_for_idle = gmc_v6_0_wait_for_idle,
 	.soft_reset = gmc_v6_0_soft_reset,
 	.set_clockgating_state = gmc_v6_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 98db62cc8718..1c1eccfe383f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1346,7 +1346,6 @@ static const struct amd_ip_funcs gmc_v7_0_ip_funcs = {
 	.hw_fini = gmc_v7_0_hw_fini,
 	.suspend = gmc_v7_0_suspend,
 	.resume = gmc_v7_0_resume,
-	.is_idle = gmc_v7_0_is_idle,
 	.wait_for_idle = gmc_v7_0_wait_for_idle,
 	.soft_reset = gmc_v7_0_soft_reset,
 	.set_clockgating_state = gmc_v7_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 119268273530..b46b87291c51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2300,12 +2300,6 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool gmc_v9_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* MC is always ready in GMC v9.*/
-	return true;
-}
-
 static int gmc_v9_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v9.*/
@@ -2355,7 +2349,6 @@ const struct amd_ip_funcs gmc_v9_0_ip_funcs = {
 	.hw_fini = gmc_v9_0_hw_fini,
 	.suspend = gmc_v9_0_suspend,
 	.resume = gmc_v9_0_resume,
-	.is_idle = gmc_v9_0_is_idle,
 	.wait_for_idle = gmc_v9_0_wait_for_idle,
 	.soft_reset = gmc_v9_0_soft_reset,
 	.set_clockgating_state = gmc_v9_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 333e9c30c091..512c76d97840 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -655,12 +655,6 @@ static int ih_v6_0_resume(struct amdgpu_ip_block *ip_block)
 	return ih_v6_0_hw_init(ip_block);
 }
 
-static bool ih_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return true;
-}
-
 static int ih_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
@@ -788,7 +782,6 @@ static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
 	.hw_fini = ih_v6_0_hw_fini,
 	.suspend = ih_v6_0_suspend,
 	.resume = ih_v6_0_resume,
-	.is_idle = ih_v6_0_is_idle,
 	.wait_for_idle = ih_v6_0_wait_for_idle,
 	.soft_reset = ih_v6_0_soft_reset,
 	.set_clockgating_state = ih_v6_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 699c274d357e..bae86e5fa316 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -630,12 +630,6 @@ static int ih_v6_1_resume(struct amdgpu_ip_block *ip_block)
 	return ih_v6_1_hw_init(ip_block);
 }
 
-static bool ih_v6_1_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return true;
-}
-
 static int ih_v6_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
@@ -767,7 +761,6 @@ static const struct amd_ip_funcs ih_v6_1_ip_funcs = {
 	.hw_fini = ih_v6_1_hw_fini,
 	.suspend = ih_v6_1_suspend,
 	.resume = ih_v6_1_resume,
-	.is_idle = ih_v6_1_is_idle,
 	.wait_for_idle = ih_v6_1_wait_for_idle,
 	.soft_reset = ih_v6_1_soft_reset,
 	.set_clockgating_state = ih_v6_1_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 6de9e87e04e1..b51dacf9e126 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -670,12 +670,6 @@ static int ih_v7_0_resume(struct amdgpu_ip_block *ip_block)
 	return ih_v7_0_hw_init(ip_block);
 }
 
-static bool ih_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return true;
-}
-
 static int ih_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
@@ -844,7 +838,6 @@ static const struct amd_ip_funcs ih_v7_0_ip_funcs = {
 	.hw_fini = ih_v7_0_hw_fini,
 	.suspend = ih_v7_0_suspend,
 	.resume = ih_v7_0_resume,
-	.is_idle = ih_v7_0_is_idle,
 	.wait_for_idle = ih_v7_0_wait_for_idle,
 	.soft_reset = ih_v7_0_soft_reset,
 	.set_clockgating_state = ih_v7_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index a9c00adcfe41..72069b77f6f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -791,7 +791,6 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.hw_fini = jpeg_v2_0_hw_fini,
 	.suspend = jpeg_v2_0_suspend,
 	.resume = jpeg_v2_0_resume,
-	.is_idle = jpeg_v2_0_is_idle,
 	.wait_for_idle = jpeg_v2_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5208312e7017..2968256d4cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -665,7 +665,6 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.hw_fini = jpeg_v2_5_hw_fini,
 	.suspend = jpeg_v2_5_suspend,
 	.resume = jpeg_v2_5_resume,
-	.is_idle = jpeg_v2_5_is_idle,
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
@@ -682,7 +681,6 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.hw_fini = jpeg_v2_5_hw_fini,
 	.suspend = jpeg_v2_5_suspend,
 	.resume = jpeg_v2_5_resume,
-	.is_idle = jpeg_v2_5_is_idle,
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index e9ccadeb7696..564e40899df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -564,7 +564,6 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.hw_fini = jpeg_v3_0_hw_fini,
 	.suspend = jpeg_v3_0_suspend,
 	.resume = jpeg_v3_0_resume,
-	.is_idle = jpeg_v3_0_is_idle,
 	.wait_for_idle = jpeg_v3_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v3_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v3_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 6fd4238a8471..b29ca3a49939 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -748,7 +748,6 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.hw_fini = jpeg_v4_0_hw_fini,
 	.suspend = jpeg_v4_0_suspend,
 	.resume = jpeg_v4_0_resume,
-	.is_idle = jpeg_v4_0_is_idle,
 	.wait_for_idle = jpeg_v4_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0fdc32b3ae91..49f84e6647a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1225,7 +1225,6 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.hw_fini = jpeg_v4_0_3_hw_fini,
 	.suspend = jpeg_v4_0_3_suspend,
 	.resume = jpeg_v4_0_3_resume,
-	.is_idle = jpeg_v4_0_3_is_idle,
 	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 3f61d5367d94..197d1af18a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -806,7 +806,6 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.hw_fini = jpeg_v4_0_5_hw_fini,
 	.suspend = jpeg_v4_0_5_suspend,
 	.resume = jpeg_v4_0_5_resume,
-	.is_idle = jpeg_v4_0_5_is_idle,
 	.wait_for_idle = jpeg_v4_0_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_5_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index e6e99f7e0a8a..9b57fdc1e69a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -682,7 +682,6 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.hw_fini = jpeg_v5_0_0_hw_fini,
 	.suspend = jpeg_v5_0_0_suspend,
 	.resume = jpeg_v5_0_0_resume,
-	.is_idle = jpeg_v5_0_0_is_idle,
 	.wait_for_idle = jpeg_v5_0_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v5_0_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index db3fbe4eabb9..62632d9b4287 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -886,7 +886,6 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.hw_fini = jpeg_v5_0_1_hw_fini,
 	.suspend = jpeg_v5_0_1_suspend,
 	.resume = jpeg_v5_0_1_resume,
-	.is_idle = jpeg_v5_0_1_is_idle,
 	.wait_for_idle = jpeg_v5_0_1_wait_for_idle,
 	.soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index ea54a2b6eddb..5a4859ee96f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -631,7 +631,6 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 	.hw_fini = jpeg_v5_0_2_hw_fini,
 	.suspend = jpeg_v5_0_2_suspend,
 	.resume = jpeg_v5_0_2_resume,
-	.is_idle = jpeg_v5_0_2_is_idle,
 	.wait_for_idle = jpeg_v5_0_2_wait_for_idle,
 	.soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_2_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index c929d6f83bac..8ddd12740a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -671,7 +671,6 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
 	.hw_fini = jpeg_v5_3_0_hw_fini,
 	.suspend = jpeg_v5_3_0_suspend,
 	.resume = jpeg_v5_3_0_resume,
-	.is_idle = jpeg_v5_3_0_is_idle,
 	.wait_for_idle = jpeg_v5_3_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v5_3_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_3_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4cd325149b63..7a167ad93fd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -625,12 +625,6 @@ static int navi10_ih_resume(struct amdgpu_ip_block *ip_block)
 	return navi10_ih_hw_init(ip_block);
 }
 
-static bool navi10_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return true;
-}
-
 static int navi10_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
@@ -699,7 +693,6 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
 	.hw_fini = navi10_ih_hw_fini,
 	.suspend = navi10_ih_suspend,
 	.resume = navi10_ih_resume,
-	.is_idle = navi10_ih_is_idle,
 	.wait_for_idle = navi10_ih_wait_for_idle,
 	.soft_reset = navi10_ih_soft_reset,
 	.set_clockgating_state = navi10_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 96faaf8c5737..e9a1bd3f0d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -992,11 +992,6 @@ static int nv_common_resume(struct amdgpu_ip_block *ip_block)
 	return nv_common_hw_init(ip_block);
 }
 
-static bool nv_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int nv_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
@@ -1058,7 +1053,6 @@ static const struct amd_ip_funcs nv_common_ip_funcs = {
 	.hw_fini = nv_common_hw_fini,
 	.suspend = nv_common_suspend,
 	.resume = nv_common_resume,
-	.is_idle = nv_common_is_idle,
 	.set_clockgating_state = nv_common_set_clockgating_state,
 	.set_powergating_state = nv_common_set_powergating_state,
 	.get_clockgating_state = nv_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 7100f30ffeff..0adfd4b101aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2647,11 +2647,6 @@ static int si_common_resume(struct amdgpu_ip_block *ip_block)
 	return si_common_hw_init(ip_block);
 }
 
-static bool si_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int si_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
@@ -2670,7 +2665,6 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.hw_init = si_common_hw_init,
 	.hw_fini = si_common_hw_fini,
 	.resume = si_common_resume,
-	.is_idle = si_common_is_idle,
 	.set_clockgating_state = si_common_set_clockgating_state,
 	.set_powergating_state = si_common_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 47f1d325bd1a..edebd9109fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -725,7 +725,6 @@ static const struct amd_ip_funcs si_dma_ip_funcs = {
 	.hw_fini = si_dma_hw_fini,
 	.suspend = si_dma_suspend,
 	.resume = si_dma_resume,
-	.is_idle = si_dma_is_idle,
 	.wait_for_idle = si_dma_wait_for_idle,
 	.soft_reset = si_dma_soft_reset,
 	.set_clockgating_state = si_dma_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 66f650f87243..52118765dccf 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -297,7 +297,6 @@ static const struct amd_ip_funcs si_ih_ip_funcs = {
 	.hw_fini = si_ih_hw_fini,
 	.suspend = si_ih_suspend,
 	.resume = si_ih_resume,
-	.is_idle = si_ih_is_idle,
 	.wait_for_idle = si_ih_wait_for_idle,
 	.soft_reset = si_ih_soft_reset,
 	.set_clockgating_state = si_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3d4573d93742..b2024d05aa5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1324,11 +1324,6 @@ static int soc15_common_resume(struct amdgpu_ip_block *ip_block)
 	return soc15_common_hw_init(ip_block);
 }
 
-static bool soc15_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static void soc15_update_drm_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	uint32_t def, data;
@@ -1480,7 +1475,6 @@ static const struct amd_ip_funcs soc15_common_ip_funcs = {
 	.hw_fini = soc15_common_hw_fini,
 	.suspend = soc15_common_suspend,
 	.resume = soc15_common_resume,
-	.is_idle = soc15_common_is_idle,
 	.set_clockgating_state = soc15_common_set_clockgating_state,
 	.set_powergating_state = soc15_common_set_powergating_state,
 	.get_clockgating_state= soc15_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5a6c84c802f6..599d47e1d38b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -1042,11 +1042,6 @@ static int soc21_common_resume(struct amdgpu_ip_block *ip_block)
 	return soc21_common_hw_init(ip_block);
 }
 
-static bool soc21_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int soc21_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
@@ -1111,7 +1106,6 @@ static const struct amd_ip_funcs soc21_common_ip_funcs = {
 	.hw_fini = soc21_common_hw_fini,
 	.suspend = soc21_common_suspend,
 	.resume = soc21_common_resume,
-	.is_idle = soc21_common_is_idle,
 	.set_clockgating_state = soc21_common_set_clockgating_state,
 	.set_powergating_state = soc21_common_set_powergating_state,
 	.get_clockgating_state = soc21_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 9a658e4837f4..6c8b8ed4a44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -519,11 +519,6 @@ static int soc24_common_resume(struct amdgpu_ip_block *ip_block)
 	return soc24_common_hw_init(ip_block);
 }
 
-static bool soc24_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int soc24_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_clockgating_state state)
 {
@@ -582,7 +577,6 @@ static const struct amd_ip_funcs soc24_common_ip_funcs = {
 	.hw_fini = soc24_common_hw_fini,
 	.suspend = soc24_common_suspend,
 	.resume = soc24_common_resume,
-	.is_idle = soc24_common_is_idle,
 	.set_clockgating_state = soc24_common_set_clockgating_state,
 	.set_powergating_state = soc24_common_set_powergating_state,
 	.get_clockgating_state = soc24_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 43e92e2a85e8..10fc2afddea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -355,11 +355,6 @@ static int soc_v1_0_common_resume(struct amdgpu_ip_block *ip_block)
 	return soc_v1_0_common_hw_init(ip_block);
 }
 
-static bool soc_v1_0_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int soc_v1_0_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 						 enum amd_clockgating_state state)
 {
@@ -387,7 +382,6 @@ static const struct amd_ip_funcs soc_v1_0_common_ip_funcs = {
 	.hw_fini = soc_v1_0_common_hw_fini,
 	.suspend = soc_v1_0_common_suspend,
 	.resume = soc_v1_0_common_resume,
-	.is_idle = soc_v1_0_common_is_idle,
 	.set_clockgating_state = soc_v1_0_common_set_clockgating_state,
 	.set_powergating_state = soc_v1_0_common_set_powergating_state,
 	.get_clockgating_state = soc_v1_0_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index bbd0e05d39e5..dcb8487e22b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1496,7 +1496,6 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
 	.prepare_suspend = uvd_v6_0_prepare_suspend,
 	.suspend = uvd_v6_0_suspend,
 	.resume = uvd_v6_0_resume,
-	.is_idle = uvd_v6_0_is_idle,
 	.wait_for_idle = uvd_v6_0_wait_for_idle,
 	.soft_reset = uvd_v6_0_soft_reset,
 	.set_clockgating_state = uvd_v6_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 93253db5e2de..b1428f5bbc81 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -796,7 +796,6 @@ static const struct amd_ip_funcs vce_v1_0_ip_funcs = {
 	.hw_fini = vce_v1_0_hw_fini,
 	.suspend = vce_v1_0_suspend,
 	.resume = vce_v1_0_resume,
-	.is_idle = vce_v1_0_is_idle,
 	.wait_for_idle = vce_v1_0_wait_for_idle,
 	.set_clockgating_state = vce_v1_0_set_clockgating_state,
 	.set_powergating_state = vce_v1_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 3a6fc8604108..dd870ecac2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -633,7 +633,6 @@ static const struct amd_ip_funcs vce_v2_0_ip_funcs = {
 	.hw_fini = vce_v2_0_hw_fini,
 	.suspend = vce_v2_0_suspend,
 	.resume = vce_v2_0_resume,
-	.is_idle = vce_v2_0_is_idle,
 	.wait_for_idle = vce_v2_0_wait_for_idle,
 	.soft_reset = vce_v2_0_soft_reset,
 	.set_clockgating_state = vce_v2_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index a9497e2e07f7..9809a23fa521 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -857,7 +857,6 @@ static const struct amd_ip_funcs vce_v3_0_ip_funcs = {
 	.hw_fini = vce_v3_0_hw_fini,
 	.suspend = vce_v3_0_suspend,
 	.resume = vce_v3_0_resume,
-	.is_idle = vce_v3_0_is_idle,
 	.wait_for_idle = vce_v3_0_wait_for_idle,
 	.soft_reset = vce_v3_0_soft_reset,
 	.set_clockgating_state = vce_v3_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e9d790914761..69976c8be034 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -2034,7 +2034,6 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.hw_fini = vcn_v1_0_hw_fini,
 	.suspend = vcn_v1_0_suspend,
 	.resume = vcn_v1_0_resume,
-	.is_idle = vcn_v1_0_is_idle,
 	.wait_for_idle = vcn_v1_0_wait_for_idle,
 	.set_clockgating_state = vcn_v1_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0442bfcfd384..c559213e442c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2102,7 +2102,6 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.hw_fini = vcn_v2_0_hw_fini,
 	.suspend = vcn_v2_0_suspend,
 	.resume = vcn_v2_0_resume,
-	.is_idle = vcn_v2_0_is_idle,
 	.wait_for_idle = vcn_v2_0_wait_for_idle,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0d8a3cea63ee..732aaa1d8e67 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -2110,7 +2110,6 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.hw_fini = vcn_v2_5_hw_fini,
 	.suspend = vcn_v2_5_suspend,
 	.resume = vcn_v2_5_resume,
-	.is_idle = vcn_v2_5_is_idle,
 	.wait_for_idle = vcn_v2_5_wait_for_idle,
 	.set_clockgating_state = vcn_v2_5_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
@@ -2127,7 +2126,6 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
         .hw_fini = vcn_v2_5_hw_fini,
         .suspend = vcn_v2_5_suspend,
         .resume = vcn_v2_5_resume,
-        .is_idle = vcn_v2_5_is_idle,
         .wait_for_idle = vcn_v2_5_wait_for_idle,
         .set_clockgating_state = vcn_v2_5_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index eb16916c6473..4509e6130bc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -555,12 +555,6 @@ static int vega10_ih_resume(struct amdgpu_ip_block *ip_block)
 	return vega10_ih_hw_init(ip_block);
 }
 
-static bool vega10_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return true;
-}
-
 static int vega10_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
@@ -630,7 +624,6 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
 	.hw_fini = vega10_ih_hw_fini,
 	.suspend = vega10_ih_suspend,
 	.resume = vega10_ih_resume,
-	.is_idle = vega10_ih_is_idle,
 	.wait_for_idle = vega10_ih_wait_for_idle,
 	.soft_reset = vega10_ih_soft_reset,
 	.set_clockgating_state = vega10_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 85846fd08ce4..460f4bf195e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -655,12 +655,6 @@ static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
 	return vega20_ih_hw_init(ip_block);
 }
 
-static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return true;
-}
-
 static int vega20_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
@@ -727,7 +721,6 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
 	.hw_fini = vega20_ih_hw_fini,
 	.suspend = vega20_ih_suspend,
 	.resume = vega20_ih_resume,
-	.is_idle = vega20_ih_is_idle,
 	.wait_for_idle = vega20_ih_wait_for_idle,
 	.soft_reset = vega20_ih_soft_reset,
 	.set_clockgating_state = vega20_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 352c27103305..2cd6d7d77b1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1729,11 +1729,6 @@ static int vi_common_resume(struct amdgpu_ip_block *ip_block)
 	return vi_common_hw_init(ip_block);
 }
 
-static bool vi_common_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static void vi_update_bif_medium_grain_light_sleep(struct amdgpu_device *adev,
 						   bool enable)
 {
@@ -2025,7 +2020,6 @@ static const struct amd_ip_funcs vi_common_ip_funcs = {
 	.hw_fini = vi_common_hw_fini,
 	.suspend = vi_common_suspend,
 	.resume = vi_common_resume,
-	.is_idle = vi_common_is_idle,
 	.set_clockgating_state = vi_common_set_clockgating_state,
 	.set_powergating_state = vi_common_set_powergating_state,
 	.get_clockgating_state = vi_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 284aac4d96bc..d19b7e985c02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -224,13 +224,6 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 }
 EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
 
-STATIC_IFN_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* XXX todo */
-	return true;
-}
-EXPORT_IF_KUNIT(dm_is_idle);
-
 STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
@@ -2079,7 +2072,6 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.hw_fini = dm_hw_fini,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
-	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
 	.soft_reset = dm_soft_reset,
 	.set_clockgating_state = dm_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3524931451c8..488a24e857fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1157,7 +1157,6 @@ struct __drm_planes_state *amdgpu_dm_get_next_zpos(struct drm_atomic_commit *sta
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 struct amdgpu_ip_block;
-bool dm_is_idle(struct amdgpu_ip_block *ip_block);
 int dm_wait_for_idle(struct amdgpu_ip_block *ip_block);
 int dm_soft_reset(struct amdgpu_ip_block *ip_block);
 int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index b763fdf43c60..6dd81a17bc6b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3108,11 +3108,6 @@ static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static bool kv_dpm_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return true;
-}
-
 static int kv_dpm_set_interrupt_state(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *src,
 				      unsigned type,
@@ -3317,7 +3312,6 @@ static const struct amd_ip_funcs kv_dpm_ip_funcs = {
 	.hw_fini = kv_dpm_hw_fini,
 	.suspend = kv_dpm_suspend,
 	.resume = kv_dpm_resume,
-	.is_idle = kv_dpm_is_idle,
 	.set_clockgating_state = kv_dpm_set_clockgating_state,
 	.set_powergating_state = kv_dpm_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 012227c70600..6cc414a8a4de 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7928,12 +7928,6 @@ static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static bool si_dpm_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	/* XXX */
-	return true;
-}
-
 static int si_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX */
@@ -8134,7 +8128,6 @@ static const struct amd_ip_funcs si_dpm_ip_funcs = {
 	.hw_fini = si_dpm_hw_fini,
 	.suspend = si_dpm_suspend,
 	.resume = si_dpm_resume,
-	.is_idle = si_dpm_is_idle,
 	.wait_for_idle = si_dpm_wait_for_idle,
 	.set_clockgating_state = si_dpm_set_clockgating_state,
 	.set_powergating_state = si_dpm_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 7c70e228a5ba..239c64b8edca 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -241,11 +241,6 @@ static void pp_late_fini(struct amdgpu_ip_block *ip_block)
 }
 
 
-static bool pp_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	return false;
-}
-
 static int pp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				    enum amd_powergating_state state)
 {
@@ -286,7 +281,6 @@ static const struct amd_ip_funcs pp_ip_funcs = {
 	.late_fini = pp_late_fini,
 	.suspend = pp_suspend,
 	.resume = pp_resume,
-	.is_idle = pp_is_idle,
 	.set_clockgating_state = pp_set_clockgating_state,
 	.set_powergating_state = pp_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cca32f74abf0..ab6da9bd91b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2811,7 +2811,6 @@ const struct amd_ip_funcs smu_ip_funcs = {
 	.late_fini = smu_late_fini,
 	.suspend = smu_suspend,
 	.resume = smu_resume,
-	.is_idle = NULL,
 	.wait_for_idle = NULL,
 	.soft_reset = NULL,
 	.set_clockgating_state = smu_set_clockgating_state,
-- 
2.55.0

