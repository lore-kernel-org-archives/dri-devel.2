Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100FDCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B2710F36F;
	Thu, 18 Jun 2026 16:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mSC8JJwZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7F510EE43;
 Thu, 18 Jun 2026 16:52:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7C1342D85;
 Thu, 18 Jun 2026 16:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7641A1F000E9;
 Thu, 18 Jun 2026 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781801545;
 bh=8ZSjD4Gy0zG74j+xE9k9L78nCqmOGzl2OWVGk/wh3AI=;
 h=From:Date:Subject:To:Cc;
 b=mSC8JJwZBSyMXQAUkUMo84OVSRaE7Ax4pT0WBvMm1rkWhvuep2UeyOIGydZJ2omRR
 byvC8hDXSjZ50ipNIPKFgNMbhRmWhyzzvzkcgCy4pV8SGFzOPXqEUcdKLJJsN9o8ku
 /IVNtNNUJBQP/eXnbvPQ9AqHckiZe47JP+5xSptY0PRj4egImNgcxY+srH/cleGfwF
 VO9BrpiHdDlRDI4+5CK++Rr8wIyjG/2SrPTKuS8HJJ33qwYLvP5f51kBBUGC7jAwhG
 zykcDtQ9aldT3Ybhpn1q2UKEixjjGTkVqNxgwZuFYCvoBadXKLGrgNoKSTzr2jwsR0
 IieOlIUkNnF/w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 18 Jun 2026 09:52:14 -0700
Subject: [PATCH v2] drm/amd/display: Shorten hdmi_frl_status_polling_workqueue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-amdgpu-fix-wq_name_len-warning-v2-1-ef0e2e6f5be7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OWw6CMBBFt2L67Zi2Ahq/3IchpC1jqcKALQ8NY
 e8W3ICfJzm5584soHcY2GU3M4+jC66lCHK/Y6ZSZBFcGZlJLjOe8QRUU9pugLt7w/QqSDVY1Eg
 wKU+OLGRHc+ZCIjdSszjSeYzqFrjlPw6DfqDp19XVqFzoW//ZHoxi9f6OjQIEoE4Tkeok1fJ0f
 aInrA+ttyxfluULrz79u98AAAA=
X-Change-ID: 20260604-amdgpu-fix-wq_name_len-warning-63c8012e0c2b
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alex Hung <alex.hung@amd.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6TfhnfijkEQ8/smiI3W4Z7KxLUCLXT/X4YBCr5s6MII=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFkmSu6rn4varshoeL+45/SHiRIi1mtm2Z0SiLKSLPU6W
 mpzqImro5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExkpwQjw24N3zMpwgfPLT6x
 Zv3C8Glrbzr2NngFvV/HfOHj1oVm2XcZ/sc+fjZBYPtFiw8HZdMnbfkg7FGkZ2VxflYtZ/5bw8+
 KuzkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
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

There is a warning when creating the hdmi_frl_status_polling_wq
workqueue because "hdmi_frl_status_polling_workqueue" excceds
WQ_NAME_LEN:

  workqueue: name exceeds WQ_NAME_LEN. Truncating to: hdmi_frl_status_polling_workque

Shorten the workqueue name to "hdmi_frl_status_polling_wq" like the
structure member to avoid the warning.

Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Rebase to solve conflicts with 0e967e086e75 ("drm/amd/display: Extract
  connector and encoder code to amdgpu_dm_connector").
- Pick up Alex's Reviewed-by.
- Link to v1: https://patch.msgid.link/20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2e74ff94dcac..881626f0f258 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -834,9 +834,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 	if (adev->dm.dc->caps.max_links > 0) {
 		adev->dm.hdmi_frl_status_polling_wq =
-			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
+			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
 		if (!adev->dm.hdmi_frl_status_polling_wq)
-			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
+			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_wq\n");
 	}
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);

---
base-commit: 991fd2cb908bf5d35a496760519442d6e9f8763d
change-id: 20260604-amdgpu-fix-wq_name_len-warning-63c8012e0c2b

Best regards,
--  
Cheers,
Nathan

