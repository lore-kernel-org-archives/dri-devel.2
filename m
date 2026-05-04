Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E1CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9B910E7EC;
	Mon,  4 May 2026 18:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dHOSERkt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A54D10E768
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777919072;
 bh=LIaSlxFKDMGdLUeGmCaMWboNkyhoBoZUFgC5ptDTBTY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dHOSERktEipbU+Wy5cUpTDKMgYTumbdri8JkAkRQx8MyFLu1p8Q8dmBxIMPiaDVJ0
 LYPgZ23rp4iDtFnvdH6yV/I2idGqV/U6rXewcU1tGeyN6IY2Op/F5Zyjt/J7lw6jJM
 XC8qF7J2Aff+pvBonsUcvNSHkMxH5WoRiTk3uGshvfnEEbwntiQkGGXE79LCMmqlKI
 Nab986FKJVQtoexN1/0dulZd+j+xOP+DC51j5W56tXb7AhUgvKATpZXHuRU/mI1wSl
 DvG4T2Ee/aHvKPAws6G16WI2hfEjlze156z9+oxVP49QjzWiaPTal1paHuqwvtfwza
 tljjXr3RF7LAw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0FBFC17E12EB;
 Mon,  4 May 2026 20:24:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 04 May 2026 21:23:59 +0300
Subject: [PATCH 1/5] drm/rockchip: vop2: Fix wrong wait target in layer cfg
 done check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-vop2-layer-cfg-tmout-v1-1-730226a7331e@collabora.com>
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

rk3568_vop2_setup_layer_mixer() waits for the previous Video Port (VP)
layer configuration to take effect before writing a new one to the
shared RK3568_OVL_LAYER_SEL shadow register.  However, it passes
vop2->old_layer_sel to rk3568_vop2_wait_for_layer_cfg_done() as the
expected value, which at that point already contains the new VP layer.

This causes the wait to poll for a value that has not been written to
the shadow register yet, resulting in spurious timeouts when two
non-blocking atomic commits race:

  rockchip-drm display-subsystem: [drm] *ERROR* wait layer cfg done timeout [...]

Pass the local old_layer_sel instead, which still holds the value
captured from vop2->old_layer_sel before it was overwritten, i.e. the
previous VP target that the hardware is expected to latch.

Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 02a788a4dfdd..edca0fb16e08 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2307,7 +2307,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		 * Changes of other VPs' overlays have not taken effect
 		 */
 		if (cfg_done)
-			rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
+			rk3568_vop2_wait_for_layer_cfg_done(vop2, old_layer_sel);
 	}
 
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);

-- 
2.53.0

