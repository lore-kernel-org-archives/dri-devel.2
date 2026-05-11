Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DA4CD37B2
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 02:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B46210E1F9;
	Mon, 11 May 2026 02:19:38 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5535F10E1F9
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 02:19:35 +0000 (UTC)
X-UUID: d802bba44cdf11f1aa26b74ffac11d73-20260511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:636fb6df-a2c6-4efc-80a8-c86fb1fabc9e, IP:0,
 U
 RL:0,TC:0,Content:34,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:34
X-CID-META: VersionHash:e7bac3a, CLOUDID:708deb6f678f4fe26d6609d6ef28d10c,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:4|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d802bba44cdf11f1aa26b74ffac11d73-20260511
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 642515119; Mon, 11 May 2026 10:19:31 +0800
From: yaolu@kylinos.cn
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/atomic: determine the hotspots attribute first
Date: Mon, 11 May 2026 10:19:26 +0800
Message-Id: <20260511021926.67673-1-yaolu@kylinos.cn>
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

If drm driver has both 'DRIVER_CURSOR_HOTSPOT' and
'atomic_set/get_property' will cause hotspots property
set/get error.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 9e9b2f3f106c..21b6b79f5f9e 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -548,9 +548,6 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		return ret;
 	} else if (property == plane->scaling_filter_property) {
 		state->scaling_filter = val;
-	} else if (plane->funcs->atomic_set_property) {
-		return plane->funcs->atomic_set_property(plane, state,
-				property, val);
 	} else if (property == plane->hotspot_x_property) {
 		if (plane->type != DRM_PLANE_TYPE_CURSOR) {
 			drm_dbg_atomic(plane->dev,
@@ -567,6 +564,9 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 			return -EINVAL;
 		}
 		state->hotspot_y = val;
+	} else if (plane->funcs->atomic_set_property) {
+		return plane->funcs->atomic_set_property(plane, state,
+				property, val);
 	} else {
 		drm_dbg_atomic(plane->dev,
 			       "[PLANE:%d:%s] unknown property [PROP:%d:%s]\n",
@@ -625,12 +625,12 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 			state->fb_damage_clips->base.id : 0;
 	} else if (property == plane->scaling_filter_property) {
 		*val = state->scaling_filter;
-	} else if (plane->funcs->atomic_get_property) {
-		return plane->funcs->atomic_get_property(plane, state, property, val);
 	} else if (property == plane->hotspot_x_property) {
 		*val = state->hotspot_x;
 	} else if (property == plane->hotspot_y_property) {
 		*val = state->hotspot_y;
+	} else if (plane->funcs->atomic_get_property) {
+		return plane->funcs->atomic_get_property(plane, state, property, val);
 	} else {
 		drm_dbg_atomic(dev,
 			       "[PLANE:%d:%s] unknown property [PROP:%d:%s]\n",
-- 
2.25.1

