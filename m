Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A6109446A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 11:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567A010E286;
	Sat, 21 Mar 2026 11:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="pB0amgU2";
	dkim-atps=neutral
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464AD10E286
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1774091188;
 bh=Bh7Ir3H0CY3VDMvhV9FMShbp9LroW2I2hlAtJxWy2m0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=pB0amgU20f4c1TqKzMqTIW1RVDxZ9XnffPpxmGxqKonOuY6HyD0pXw5OSKX7+CMoV
 8C8brPgcCYR7iE9RvUeN7kMlkiDABLu0jNTYvkw7PzFIYN4zJ4lJqOgoEyejrmZ07n
 QkOMERi3oF0IvYxZVfwcvtBGv30eFVM7aijKuL48=
X-QQ-mid: zesmtpsz1t1774090641t308b39db
X-QQ-Originating-IP: paFbi8WlmVrJS3irHdYehrm5QNgV5zXZdOJspUeAEc4=
Received: from localhost.localdomain ( [116.172.93.199])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 21 Mar 2026 18:57:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13888191121335503655
EX-QQ-RecipientCnt: 24
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, ray.wu@amd.com, Wayne.Lin@amd.com,
 timur.kristof@gmail.com, superm1@kernel.org, ivan.lipski@amd.com,
 dominik.kaszewski@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, kexinsun@smail.nju.edu.cn,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: [PATCH] drm/amd/display: update outdated comments for renamed
 vblank_control_worker()
Date: Sat, 21 Mar 2026 18:57:17 +0800
Message-Id: <20260321105717.6212-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OAykwSsVAcprVxpVphQ9R+O5zu723FH2ntCTmPGSDjuRjHVT26IB6CyN
 Q/4C9J+DLHwW0qkXaNSjEl5v0936PxuuKmVxXB0lXEoW4lfFbQNL+aXkPP1HmvNiUBVgWRl
 qIRtJKcjN7cqUibc7t5Ar/1xE1X32wgHZubjzjVAOXv0wj8RMEfzxPRlf0wa2xuJINHwfdc
 H835yo5WJ7t6P+W/0/nk6wk2iXIwGsLrtFwJT7OrQ/AP4hxkwAjnjh5RO/ya1MROfX8BUs8
 +mvwjWFzyxOO7qYbyWWp09rQ8Y3xPINDEAXdLXnYI7t5+q83Y2mv7vyC/CLf0ecZH2yun9F
 A7Lr5y7pQc396lyUk2/6pFFRUFpetrtg1xJEJ70pNFgb3bWoCQ57KSfOTtDTV0zWc2im8eS
 2QStWs7MkiVLphtzDNaoEudwk42ohpxtVhA5/6s21xFlY5okvaO8bVx9gvwyI9X11EHALDI
 7qtmCkaa8CbToZXa0SLQhc/fI3dx4L2K1iedndJcd7O0eiHjP9+kJX5mywZVNV5z8ItLUUH
 8t2YUhB/jKHrSf3Q5SgrXwBlNY4qlH/bwc12n++wP745H9wmIbQembK5fXcBlKOaH/EWj91
 WqX36kOSjfrzAzWmFqcMTdWRzDL6yYU/hkchAi/dW2xYJq9mg7LwUduMPZ4aNZg0GJ6nII8
 r1Xobdz9TDpLoDZWaOBj9r5hhQPqLAXOYzMx4s4lYBLb9QSKYTE6IQ83ls18M/Q9J1N3zqV
 OBmXHAQD/jnzLZz61yblykCj3LRKI9fIeS8W7JQxqRiFfmeVvRkU8fMPQZ6hkQ1/mV4i28R
 9GxJDFHwLkeGG4mpBdI2WI/kXCIwTC0z3x47eNOhVFIeTx5FR7a42evqhzNQCgH52LWpuDa
 WjwjtNk+gXVjtT4YUcMthxNvrEESakADkHvrn/dFSIR1Ogyo4uRx2s32OLil5LxEDnPZ2b1
 9aIbUGuHQ9+eFC8ExRUV00WVDX3tY+mD8cGQye3BIfF1zaqhtE8Z2VRmNfM2rkxHlTQJKai
 CIByJOS/T3zffns4PW6C6UZ7X7rul78vnLrlh6t+2P+IWIYPozLY+4hui3aHhlqEUZ5MP4h
 DKe70hpZsV+fdr/zKbbBjg=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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

The function vblank_control_worker() was renamed
to amdgpu_dm_crtc_vblank_control_worker() by commit
6ce4f9ee25ff ("drm/amd/display: Add prefix to amdgpu crtc
functions").  Update the two stale references in
amdgpu_dm.c.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6..c2b7b31b0d29 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9894,7 +9894,8 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		 * a vblank event disable request to enable PSR/RP. PSR SU/RP
 		 * can be enabled immediately once OS demonstrates an
 		 * adequate number of fast atomic commits to notify KMD
-		 * of update events. See `vblank_control_worker()`.
+		 * of update events.
+		 * See `amdgpu_dm_crtc_vblank_control_worker()`.
 		 */
 		if (!vrr_active &&
 		    acrtc_attach->dm_irq_params.allow_sr_entry &&
@@ -10062,8 +10063,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			/*
 			 * If the dirty regions changed, PSR-SU need to be disabled temporarily
 			 * and enabled it again after dirty regions are stable to avoid video glitch.
-			 * PSR-SU will be enabled in vblank_control_worker() if user pause the video
-			 * during the PSR-SU was disabled.
+			 * PSR-SU will be enabled in
+			 * amdgpu_dm_crtc_vblank_control_worker() if user
+			 * pause the video during the PSR-SU was disabled.
 			 */
 			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
 			    acrtc_attach->dm_irq_params.allow_sr_entry &&
-- 
2.25.1

