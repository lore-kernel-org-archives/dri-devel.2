Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7C2C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8044510E10C;
	Thu, 20 Aug 2026 02:13:57 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE3510E10C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 02:13:55 +0000 (UTC)
X-UUID: c816b9149c3c11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:4d03c018-63e2-4117-bf7d-13ad3a5e2e8a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-20
X-CID-META: VersionHash:7db8b62, CLOUDID:d767d709704772514f98cf92c1c0355a,
 BulkI
 D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50,EDM:1|-
 100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c816b9149c3c11f19a56ed5b684f684d-20260820
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 479494335; Thu, 20 Aug 2026 10:13:49 +0800
From: yaolu@kylinos.cn
To: jfalempe@redhat.com, javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: john.ogness@linutronix.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/log: Fix damaged rectangle height in drm_log_draw_line()
Date: Thu, 20 Aug 2026 10:13:43 +0800
Message-Id: <20260820021343.46033-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lu Yao <yaolu@kylinos.cn>

DRM_RECT_INIT() expects x, y, width and height, should use
'scanout->scaled_font_h' here. rather than
'(scanout->line + 1) * scanout->scaled_font_h'.

Fixes: f7b42442c4ac ("drm/log: Introduce a new boot logger to draw the kmsg on the screen")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/clients/drm_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 467cdce57dd3..da413ec1c7e1 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -113,7 +113,7 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 	const u8 *src;
 	u32 px_width = fb->format->cpp[0];
 	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout->scaled_font_h,
-					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
+					  fb->width, scanout->scaled_font_h);
 	u32 i;
 
 	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
-- 
2.25.1

