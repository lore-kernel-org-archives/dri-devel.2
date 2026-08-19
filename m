Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B1EC5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6051F10EB4F;
	Wed, 19 Aug 2026 06:36:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E08210E0B9;
 Wed, 19 Aug 2026 05:47:54 +0000 (UTC)
X-UUID: 81237c649b9111f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:935162e1-4b5d-4aed-acbb-16546980a9ef, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:061688282109be565fb1e26fb1d5117b,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:5|-
 100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81237c649b9111f19a56ed5b684f684d-20260819
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <gonglinkai@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 191839397; Wed, 19 Aug 2026 13:47:46 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Ray Wu <ray.wu@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, gonglinkai@kylinos.cn, stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix dc_lock leak on GPU reset error paths
Date: Wed, 19 Aug 2026 13:47:42 +0800
Message-Id: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

On GPU reset, dm_suspend() takes dc_lock and leaves it for dm_resume()
to drop. If amdgpu_dm_commit_zero_streams() or dm_dmub_hw_init() fails,
the function returns with the lock still held. The matching resume path
is then skipped, so every later dc_lock take hangs.

Release the cached DC state and unlock before returning the error.

Fixes: 3cf7a0bc87f0 ("drm/amd/display: Catch failures for amdgpu_dm_commit_zero_streams()")
Fixes: 2b6943df5413 ("drm/amd/display: Pass up errors for reset GPU that fails to init HW")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 941c1a312824..214aca906fe1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3511,6 +3511,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		res = amdgpu_dm_commit_zero_streams(dm->dc);
 		if (res != DC_OK) {
 			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
+			dc_state_release(dm->cached_dc_state);
+			dm->cached_dc_state = NULL;
+			mutex_unlock(&dm->dc_lock);
 			return -EINVAL;
 		}
 
@@ -3824,6 +3827,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		r = dm_dmub_hw_init(adev);
 		if (r) {
 			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
+			dc_state_release(dm->cached_dc_state);
+			dm->cached_dc_state = NULL;
+			mutex_unlock(&dm->dc_lock);
 			return r;
 		}
 
-- 
2.25.1
