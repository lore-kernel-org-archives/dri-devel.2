Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA8AC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E7E10F20A;
	Thu, 16 Jul 2026 08:19:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B9A10E111
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 02:41:41 +0000 (UTC)
X-UUID: b26bf6727ff611f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:ddbe0f24-7c63-4fe9-a4ed-db76705d53c6, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:acf9c0f2ba261254fdfb4b32d2d36e1a,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b26bf6727ff611f1aa26b74ffac11d73-20260715
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <pengcan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 2098616807; Wed, 15 Jul 2026 10:41:35 +0800
From: Can Peng <pengcan@kylinos.cn>
To: linusw@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, eric@anholt.net
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] drm/tve200: add OF module alias for autoloading
Date: Wed, 15 Jul 2026 10:41:30 +0800
Message-ID: <20260715024130.186416-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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

The TVE200 DRM driver can be built as a module and uses tve200_of_match
as its OF match table, but the table is not exported for module alias
generation.

Add the MODULE_DEVICE_TABLE(of, ...) entry so modpost can generate OF
module aliases for OF based module autoloading.

Fixes: 179c02fe90a4 ("drm/tve200: Add new driver for TVE200")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 562f3f11812a..f5ef468538f9 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -263,6 +263,7 @@ static const struct of_device_id tve200_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, tve200_of_match);
 
 static struct platform_driver tve200_driver = {
 	.driver = {
-- 
2.53.0

