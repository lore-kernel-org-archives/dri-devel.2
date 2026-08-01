Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1651EC55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E354410E3E1;
	Sun,  2 Aug 2026 22:41:01 +0000 (UTC)
Received: from mail-gw-fk003.vdone.jp (mail-gw-fk003.vdone.jp
 [160.251.152.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100EF10E185
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 22:35:27 +0000 (UTC)
Received: from mail-gw-fk003.vdone.jp (localhost.localdomain [127.0.0.1])
 by mail-gw-fk003.vdone.jp (Proxmox) with ESMTP id 2B92F40177F92
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 07:35:26 +0900 (JST)
Received: from e3.valueserver.jp (e3.valueserver.jp [157.7.184.13])
 by mail-gw-fk003.vdone.jp (Proxmox) with ESMTPS id 245CF401827E4
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 07:35:25 +0900 (JST)
Received: (qmail 849831 invoked by uid 89); 2 Aug 2026 07:35:24 +0900
Received: from p1706034-ipxg06601niigatani.niigata.ocn.ne.jp (HELO
 localhost.localdomain) (jack@supremeoverlordjabs.co)
 by e3.valueserver.jp with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 2 Aug 2026 07:35:24 +0900
From: Tomonori Nakagawa <jack@supremeoverlordjabs.co>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Tomonori Nakagawa <jack@supremeoverlordjabs.co>
Subject: [PATCH v2] drm/rockchip: vop2: give rk3576 VP2 a primary plane
Date: Sun,  2 Aug 2026 07:35:20 +0900
Message-ID: <20260801223520.8661-1-jack@supremeoverlordjabs.co>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
References: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

On rk3576 the two Cluster windows are the only windows typed
DRM_PLANE_TYPE_PRIMARY, and both have possible_vp_mask = BIT(0) | BIT(1),
so they can only be attached to VP0 or VP1. VP2's only attachable
windows are the Esmart windows, which are all DRM_PLANE_TYPE_OVERLAY.

vop2_create_crtcs() requires every video port a board wires up (an output
endpoint on video_portN) to own a DRM_PLANE_TYPE_PRIMARY plane. On a
board whose DT routes any interface to VP2, no attachable primary plane
is found and probe fails with -ENOENT ("no primary plane for vp 2"),
tearing down the whole VOP2.

Promote Esmart0 to DRM_PLANE_TYPE_PRIMARY. Its possible_vp_mask is
BIT(0) | BIT(2); since vop2_create_crtcs() assigns primaries in window
array order and Cluster0/Cluster1 precede Esmart0, VP0 and VP1 still take
Cluster0/Cluster1, and only VP2 gains Esmart0 as its primary:

  VP0: primary Cluster0
  VP1: primary Cluster1
  VP2: primary Esmart0

Tested on Anbernic RG Vita Pro (rk3576), which routes its DP output to
VP2.

Signed-off-by: Tomonori Nakagawa <jack@supremeoverlordjabs.co>
---
v2: reword the commit message per Chaoyi Chen's review - VP2 is not
    DP-specific; describe the plane topology instead (the two
    PRIMARY-typed Cluster windows are limited to VP0/VP1 by
    possible_vp_mask, so VP2 has no attachable primary). No functional
    change.

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


