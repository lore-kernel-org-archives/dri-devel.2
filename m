Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99C1CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B8B10E7F2;
	Mon,  4 May 2026 18:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JINh5v7P";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12DA10E7F2
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777919074;
 bh=ZPL0/m2C5FPMkrDboCKPEVtxYEWiPUuSLnVJOAS9x2Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JINh5v7PHzTOk4WwFMRRwKsYD0iu2f1S9ZWkPcCc+AA1dbNcNblQEab8oRf22wRzw
 YKwVzvBfMSYejLfsOYBU3KuVO/3VvEk0CM97dT7HIizUt3uSxVWELoqvvOAyhEqKAQ
 Tr7jIXJMrEHD026rseSnW0BgxY/jI8Q09qpZp25JfW/MC51zhh4m3Iovw+ehPqZ/Pu
 PA0yo0YS4UlCJ531HLt7lvjtCKHi8c/jo09YCZLufQph2a40vDpgpxNVZ9XW57eFID
 ChYRAHkuYACULx3dWlN+5UiPTys+21Arw6g7a6fAWEwtVm0QsoGkNltkolSk8/D4qh
 mG8snLKNYH6QQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 846D417E156E;
 Mon,  4 May 2026 20:24:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 04 May 2026 21:24:02 +0300
Subject: [PATCH 4/5] drm/rockchip: vop2: Drop redundant zero-init in
 setup_layer_mixer()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-vop2-layer-cfg-tmout-v1-4-730226a7331e@collabora.com>
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
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

The layer_sel and atv_layer_sel local variables in
rk3568_vop2_setup_layer_mixer() are unconditionally assigned from
vop2->old_layer_sel and the RK3568_OVL_LAYER_SEL register read,
respectively, before any use.

Remove the superfluous zero-initializers.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 1f5e8c2acecd..0849bd922ffb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2134,9 +2134,9 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
 	struct drm_plane *plane;
-	u32 layer_sel = 0;
+	u32 layer_sel;
 	u32 port_sel;
-	u32 atv_layer_sel = 0;
+	u32 atv_layer_sel;
 	u8 layer_id;
 	u8 old_layer_id;
 	u8 layer_sel_id;

-- 
2.53.0

