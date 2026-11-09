Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8656082BDD
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C10D10F132;
	Mon,  9 Nov 2026 09:31:43 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3471110E86B;
 Mon,  9 Nov 2026 08:39:22 +0000 (UTC)
X-UUID: 0b18689adc1911f19a56ed5b684f684d-20261109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:ccdf3466-bade-4e70-bdde-89a7f4e8e66a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:e99da3f601251e9ecbe5f7153963cfa0,
 BulkI
 D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50|99,EDM:
 5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b18689adc1911f19a56ed5b684f684d-20261109
X-User: jiangwang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <jiangwang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 577905332; Mon, 09 Nov 2026 16:39:14 +0800
From: jiangwang@kylinos.cn
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/amdgpu: Clear HDMI audio descriptors for sinks without
 audio
Date: Mon,  9 Nov 2026 16:39:08 +0800
Message-Id: <20261109083908.903757-1-jiangwang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wang Jiang <jiangwang@kylinos.cn>

EDID without SAD left stale AZ descriptors; emulated ATI ELD faked
audio capability. Clear them.

The legacy implementation refers to ce9778b7a027,
"ALSA: hda/hdmi: Consider ELD invalid when no SAD is present".

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 6 +++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index f2977fe6d824..f967ee505271 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1341,8 +1341,13 @@ static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
-	if (sad_count <= 0)
+	if (sad_count <= 0) {
+		/* sink has no audio capability: clear stale descriptors */
+		for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++)
+			WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
+					   eld_reg_to_type[i][0], 0);
 		return;
+	}
 	BUG_ON(!sads);
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index c68de0fe1d7d..18c171c533de 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1320,8 +1320,13 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
-	if (sad_count <= 0)
+	if (sad_count <= 0) {
+		/* sink has no audio capability: clear stale descriptors */
+		for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++)
+			WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
+					   eld_reg_to_type[i][0], 0);
 		return;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
 		u32 value = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index c3906270f25e..62922736d569 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1313,8 +1313,12 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
-	if (sad_count <= 0)
+	if (sad_count <= 0) {
+		/* sink has no audio capability: clear stale descriptors */
+		for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++)
+			WREG32_AUDIO_ENDPT(offset, eld_reg_to_type[i][0], 0);
 		return;
+	}
 	BUG_ON(!sads);
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
-- 
2.25.1

