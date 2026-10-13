Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C28ECC6B1F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5E610FA27;
	Tue, 13 Oct 2026 22:52:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C7F10FA18
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791931917;
 bh=KiRqqrlaf8HazlzQcUHaYydMUHKelMqz701+av4CyKA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fMZN61CsPtxfilKjKFZHI1ApDChIuDnDGWKYRnFxrf/2r/O4toGECNBnKzAMoNJt0
 S/4nxzwjhldCg6CyED18/0YZRIY1h7XqZThvzGrPSNNrM6Iwf9l4AxVT4uQ+9gHUoU
 ergJqUBoNf7VdtaCp8mm0bG/yE+RdyI5LvNbW5EbCX54uSXJvQLrUDrNyn8tb0nIbe
 FQZIILAqdaHVnoigxm4qweXdNQYKyPziZOZDrDId2yg1EgprIMyQxoVluWUgE05W0G
 xwZGIUvJ2ATI+Abrf2Ak/PjA0JXFIKLG8H8kRLiP63WFHVXRzuPljBZQ9wZew0AvDY
 gtnszGRmGyEIQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A999F17E12B9;
 Wed, 14 Oct 2026 00:51:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 14 Oct 2026 01:51:27 +0300
Subject: [PATCH v5 10/15] drm/rockchip: vop2: Switch to enum vop_csc_format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-dw-hdmi-qp-yuv-v5-10-6fab0fe43a9b@collabora.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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

Improve code readability in vop2_setup_csc_mode() by using enum
vop_csc_format for the csc_mode variable, as well as for the return type
of the vop2_convert_csc_mode() helper, which already returns CSC_*
enumerators.

While at it, replace the nonsensical 'csc_mode = false' assignment in
the no-conversion branch with the equivalent CSC_BT601L, which carries
the same value (0) but is type-correct.

Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 45f3acbfa634..1b0f72958763 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -648,7 +648,7 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	}
 }
 
-static int vop2_convert_csc_mode(int csc_mode)
+static enum vop_csc_format vop2_convert_csc_mode(int csc_mode)
 {
 	switch (csc_mode) {
 	case V4L2_COLORSPACE_SMPTE170M:
@@ -711,7 +711,7 @@ static void vop2_setup_csc_mode(struct vop2_video_port *vp,
 	int input_csc = V4L2_COLORSPACE_DEFAULT;
 	int output_csc = vcstate->color_space;
 	bool r2y_en, y2r_en;
-	int csc_mode;
+	enum vop_csc_format csc_mode;
 
 	if (is_input_yuv && !is_output_yuv) {
 		y2r_en = true;
@@ -724,7 +724,7 @@ static void vop2_setup_csc_mode(struct vop2_video_port *vp,
 	} else {
 		y2r_en = false;
 		r2y_en = false;
-		csc_mode = false;
+		csc_mode = CSC_BT601L;
 	}
 
 	vop2_win_write(win, VOP2_WIN_Y2R_EN, y2r_en);

-- 
2.55.0

