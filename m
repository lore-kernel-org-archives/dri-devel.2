Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012BACD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A83110EE65;
	Wed, 17 Jun 2026 07:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linke.cx header.i=@linke.cx header.b="G36PtcGg";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Wed, 17 Jun 2026 06:32:27 UTC
Received: from mail.linke.cx (mail.linke.cx [49.13.16.253])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4A110EE12;
 Wed, 17 Jun 2026 06:32:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA6A242877; Wed, 17 Jun 2026 08:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linke.cx; s=dkim;
 t=1781677460; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=pnIdiK+fTeeawdLBxJqzYPrNcQXD7qCLhhUpI1B19pQ=;
 b=G36PtcGg3PqXRsZlmpaRiss9lLU3oIf2DvxDdHMT4vz+lfleR5fTbhAPtxN7c6ywJEunL/
 MldiwMEJrWf43S51Fs1I6bQxeXPyyzSsvFAJP5C0DC45xSrKWB+wha4azhJxiLH921xDNP
 v14vutKbpuw/ezDhOYaRpQYgFW3UyDEC9SdR7QZIWee1ekwRwmy36nkNa3n258Hudlj/mf
 tGS2hM/mBIeZUI7xY8nDVl3u1LjECXmq5VeIeiH5vW1VU1V8ReUyCX8sKePzKnGk17tToo
 WDTCx0TQl+O7MRgKQOjWDK7fxm2T680wuOBuDZULairJlSIvPQCsqrSuOnbuEg==
From: Jakob Linke <jakob@linke.cx>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Lijo Lazar <lijo.lazar@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/soc24: reset dGPU if suspend got aborted
Date: Wed, 17 Jun 2026 08:24:15 +0200
Message-ID: <20260617062415.19898-1-jakob@linke.cx>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:07:22 +0000
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

For SOC24 ASICs (RDNA4 / Navi 4x dGPUs) re-enabling PM features fails if an
S3 suspend got aborted, the same issue already handled for SOC21 and SOC15:

  commit df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")
  commit 38e8ca3e4b6d ("amdgpu/soc15: enable asic reset for dGPU in case of suspend abort")

The aborted resume fails with:

  amdgpu: SMU: No response msg_reg: 6 resp_reg: 0
  amdgpu: Failed to enable requested dpm features!
  amdgpu: resume of IP block <smu> failed -62

Apply the same workaround for soc24: detect the aborted-suspend state at
resume via the sign-of-life register and reset the device before re-init.

This is a workaround till a proper solution is finalized.

Fixes: 98b912c50e44 ("drm/amdgpu: Add soc24 common ip block (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: Jakob Linke <jakob@linke.cx>
---
Tested on Navi 44 (RX 9060 XT): recovers the deep->s2idle fallback and pure
s2idle resumes that otherwise fail with "resume of IP block <smu> failed -62".
It did not recover every case: one resume still failed under sustained rapid
s2idle cycling, so like the SOC21/SOC15 versions this is a mitigation, not a
complete fix. Single suspends in normal use recover.

 drivers/gpu/drm/amd/amdgpu/soc24.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index ecb6c3fcfbd1..a970d8a76302 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -521,8 +521,36 @@ static int soc24_common_suspend(struct amdgpu_ip_block *ip_block)
 	return soc24_common_hw_fini(ip_block);
 }
 
+static bool soc24_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 *    As for dGPU suspend abort cases the SOL value
+	 *    will be kept as zero at this resume point.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc24_common_resume(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (soc24_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc24_asic_reset(adev);
+	}
+
 	return soc24_common_hw_init(ip_block);
 }
 
-- 
2.54.0

