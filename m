Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8DDC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DF910E537;
	Mon, 24 Aug 2026 08:47:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C40610E078;
 Mon, 24 Aug 2026 08:47:07 +0000 (UTC)
X-UUID: 5ed47f549f9811f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:f1e870b5-aaff-41aa-a8fe-45225e0d5b77, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:2095486799bd2b801d36fc10b4a86360,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ed47f549f9811f19a56ed5b684f684d-20260824
X-User: liupeng01@kylinos.cn
Received: from t14 [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <liupeng01@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1071178855; Mon, 24 Aug 2026 16:47:00 +0800
From: liupeng <liupeng01@kylinos.cn>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: liupeng <liupeng01@kylinos.cn>
Subject: [PATCH] drm/nouveau: Fix typos in comments
Date: Mon, 24 Aug 2026 16:46:56 +0800
Message-ID: <20260824084656.45328-1-liupeng01@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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

Fix misspellings of "overridden" and "particular".

Signed-off-by: liupeng <liupeng01@kylinos.cn>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 38032bb95826..10cd606d01b9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -323,7 +323,7 @@ get_fp_strap(struct drm_device *dev, struct nvbios *bios)
 	/*
 	 * The fp strap is normally dictated by the "User Strap" in
 	 * PEXTDEV_BOOT_0[20:16], but on BMP cards when bit 2 of the
-	 * Internal_Flags struct at 0x48 is set, the user strap gets overriden
+	 * Internal_Flags struct at 0x48 is set, the user strap gets overridden
 	 * by the PCI subsystem ID during POST, but not before the previous user
 	 * strap has been committed to CR58 for CR57=0xf on head A, which may be
 	 * read and used instead
diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 55691ec44aba..06488c79f1a4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -531,7 +531,7 @@ nv50_dp_mode_valid(struct nouveau_encoder *outp,
 	const unsigned int min_clock = 25000;
 	unsigned int max_rate, mode_rate, ds_max_dotclock, clock = mode->clock;
 	/* Check with the minmum bpc always, so we can advertise better modes.
-	 * In particlar not doing this causes modes to be dropped on HDR
+	 * In particular not doing this causes modes to be dropped on HDR
 	 * displays as we might check with a bpc of 16 even.
 	 */
 	const u8 bpp = 6 * 3;
-- 
2.53.0

