Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C3606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664BD10EE26;
	Tue, 10 Nov 2026 08:35:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CC710EE26;
 Tue, 10 Nov 2026 08:35:12 +0000 (UTC)
X-UUID: a06c9c5edce111f19a56ed5b684f684d-20261110
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:e1ddb994-8e84-42b9-9870-bea375e14735, IP:0,
 U
 RL:55,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:30
X-CID-META: VersionHash:7db8b62, CLOUDID:dbf12460f72f4573f8c7665d24b8f6e9,
 BulkI
 D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50|99,EDM:
 -3,IP:nil,URL:99|11|13|91|81|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
 :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a06c9c5edce111f19a56ed5b684f684d-20261110
X-User: jiangwang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <jiangwang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 496395729; Tue, 10 Nov 2026 16:35:04 +0800
From: jiangwang@kylinos.cn
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso 318F
Date: Tue, 10 Nov 2026 16:34:53 +0800
Message-Id: <20261110083453.1008827-1-jiangwang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wang Jiang <jiangwang@kylinos.cn>

GFXOFF causes gfx ring timeout and desktop freeze on Lenovo 90NYA05DCD
(Ryzen 5 3400G, Picasso). Add a quirk entry with ANY_REV marker to
disable gfxoff for subsystem 17aa:318f regardless of chip revision.

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c3322058720f..0cec645710b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1365,6 +1365,9 @@ struct amdgpu_gfxoff_quirk {
 	u8 revision;
 };
 
+/* Match any chip revision in amdgpu_gfxoff_quirk.revision */
+#define AMDGPU_GFXOFF_QUIRK_ANY_REV	0xff
+
 static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=204689 */
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
@@ -1374,6 +1377,7 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	{ 0x1002, 0x15d8, 0x17aa, 0x318f, AMDGPU_GFXOFF_QUIRK_ANY_REV },
 	/* https://bbs.openkylin.top/t/topic/171497 */
 	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
 	/* HP 705G4 DM with R5 2400G */
@@ -1390,7 +1394,8 @@ static bool gfx_v9_0_should_disable_gfxoff(struct pci_dev *pdev)
 		    pdev->device == p->chip_device &&
 		    pdev->subsystem_vendor == p->subsys_vendor &&
 		    pdev->subsystem_device == p->subsys_device &&
-		    pdev->revision == p->revision) {
+		    (p->revision == AMDGPU_GFXOFF_QUIRK_ANY_REV ||
+		     pdev->revision == p->revision)) {
 			return true;
 		}
 		++p;
-- 
2.25.1

