Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED0BC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B3F10EDCD;
	Thu, 30 Jul 2026 07:19:57 +0000 (UTC)
X-Greylist: delayed 3700 seconds by postgrey-1.36 at gabe;
 Thu, 30 Jul 2026 00:26:37 UTC
Received: from mail-gw-fk003.vdone.jp (mail-gw-fk003.vdone.jp
 [160.251.152.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE6010E0BF
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 00:26:37 +0000 (UTC)
Received: from mail-gw-fk003.vdone.jp (localhost.localdomain [127.0.0.1])
 by mail-gw-fk003.vdone.jp (Proxmox) with ESMTP id 92C024015A643
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:24:55 +0900 (JST)
Received: from e3.valueserver.jp (e3.valueserver.jp [157.7.184.13])
 by mail-gw-fk003.vdone.jp (Proxmox) with ESMTPS id 8A1B1401583AD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:24:54 +0900 (JST)
Received: (qmail 287325 invoked by uid 89); 30 Jul 2026 08:24:54 +0900
Received: from p1706034-ipxg06601niigatani.niigata.ocn.ne.jp (HELO
 localhost.localdomain) (jack@supremeoverlordjabs.co)
 by e3.valueserver.jp with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 30 Jul 2026 08:24:54 +0900
From: Tomonori Nakagawa <jack@supremeoverlordjabs.co>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Tomonori Nakagawa <jack@supremeoverlordjabs.co>
Subject: [PATCH] drm/rockchip: vop2: give rk3576 VP2 a primary plane
Date: Thu, 30 Jul 2026 08:24:50 +0900
Message-ID: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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

The rk3576 VOP2 has three video ports. VP0 and VP1 each have a Cluster
window that acts as their primary plane, but VP2 - the port wired to the
DesignWare DP controller - only has Esmart windows, all typed
DRM_PLANE_TYPE_OVERLAY.

The driver requires every active video port to own a
DRM_PLANE_TYPE_PRIMARY plane. When VP2 is driven (a board that uses the
DP output) it finds none, CRTC creation returns -ENOENT, and the whole
VOP2 bind fails, taking down the entire display subsystem.

Promote Esmart0 to DRM_PLANE_TYPE_PRIMARY so VP2 has a primary plane.
Esmart0's possible_vp_mask already includes VP2 (BIT(2)) and its
layer_sel_id[2] = 0 is a valid VP2 layer slot, while VP0 keeps Cluster0
as its primary, so the existing VP0/VP1 assignments are unchanged:

  VP0: primary=Cluster0, overlay=Esmart2
  VP1: primary=Cluster1, overlays=Esmart1, Esmart3
  VP2: primary=Esmart0,  overlays=Esmart1, Esmart2, Esmart3

Tested on Anbernic RG Vita Pro (rk3576) with the DP alt-mode output.

Signed-off-by: Tomonori Nakagawa <jack@supremeoverlordjabs.co>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 17eda592b..e7d013dc3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -894,7 +894,7 @@ static const struct vop2_win_data rk3576_vop_win_data[] = {
 		.format_modifiers = format_modifiers,
 		.layer_sel_id = { 2, 0xf, 0, 0xf },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
-		.type = DRM_PLANE_TYPE_OVERLAY,
+		.type = DRM_PLANE_TYPE_PRIMARY,
 		.axi_bus_id = 0,
 		.axi_yrgb_r_id = 0x10,
 		.axi_uv_r_id = 0x11,
-- 
2.54.0


