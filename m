Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BE60A261E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VR855FDp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65E110E904;
	Thu,  5 Nov 2026 01:01:27 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440CB10E8F8
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840475;
 bh=fYsBZY+jSikNub85K8e0+OdnyNo7wwxjd1+6YCys8OA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VR855FDpiojGQjntT7bGe/YYaibGfjJX7V2GMMa1wh0eDU9HRJWoEHKN6i4sLB/lb
 zGMzeRVnZWAZ/WAcP0279QRqq3Y1I6wJP24NTK688ZtIFiRPB43R+WKXAKsZtvbmui
 au6XKiWXwoPdyC7t1qswazUzjstRgBKySeboUzGwMh1JFEWJ00+jn6hN+ooledOunF
 G/3CQBu4nvEp4nBC6+Owet9wLXq1YalTwkcBqamBWhTzUFmr2hwuqesIEGTHfUJXeh
 xDv/HyJo2MwiwyJ39eGbPpCFKggTuDmyReErY+s1+HJkYwftoiiDdM9T0Mjmumtdf1
 cxBNyyW98SaQg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B9B1A17E0CF7;
 Thu, 05 Nov 2026 02:01:15 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 05 Nov 2026 03:00:47 +0200
Subject: [PATCH v6 13/15] drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422
 output format
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-13-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
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
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rockchip DW HDMI QP encoder supports YUV 4:2:2 output through
ROCKCHIP_OUT_MODE_YUV422, but was limited to 8-bit depth via
MEDIA_BUS_FMT_UYVY8_1X16.  Add support for its 10-bit counterpart
MEDIA_BUS_FMT_UYVY10_1X20, which carries two 10-bit components per clock
cycle on a 20-bit wide bus.

The HDMI PHY scales its PLL output by 8/bpc to undo the deep color
packing, such that it matches the DCLK rate expected by VOP2.  However,
YUV 4:2:2 is never deep color packed, as it always transmits two 12-bit
components per pixel, regardless of the color depth.  From a clock-rate
perspective this is equivalent to three 8-bit RGB components, so
configure the HDMI PHY with 8 bpc when YUV 4:2:2 is in use to keep its
output clock aligned with the TMDS character rate.

Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index db1933d75ced..7f05d26f8d76 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -190,6 +190,25 @@ static int dw_hdmi_qp_rockchip_get_vop_format(struct drm_encoder *encoder,
 	return bstate->output_bus_cfg.format;
 }
 
+/*
+ * The HDMI PHY scales its PLL output by 8/bpc to undo the deep color packing,
+ * such that it matches the DCLK rate expected by VOP2.
+ *
+ * YUV422 is never deep color packed, as it always transmits two 12-bit
+ * components per clock cycle, regardless of the color depth.  Hence, as for
+ * drm_hdmi_compute_mode_clock(), use 8 bpc to keep the PHY PLL output aligned
+ * with the TMDS character rate.
+ */
+static unsigned int
+dw_hdmi_qp_rockchip_phy_bpc(const struct rockchip_crtc_state *s,
+			    const struct drm_connector_state *conn_state)
+{
+	if (s->output_mode == ROCKCHIP_OUT_MODE_YUV422)
+		return 8;
+
+	return conn_state->hdmi.output_bpc;
+}
+
 static int
 dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 					 struct drm_crtc_state *crtc_state,
@@ -218,6 +237,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 		s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
 		break;
 	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_UYVY10_1X20:
 		s->output_mode = ROCKCHIP_OUT_MODE_YUV422;
 		break;
 	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
@@ -229,7 +249,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 	}
 
 	phy_cfg.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
-	phy_cfg.hdmi.bpc = conn_state->hdmi.output_bpc;
+	phy_cfg.hdmi.bpc = dw_hdmi_qp_rockchip_phy_bpc(s, conn_state);
 
 	ret = phy_configure(hdmi->phy, &phy_cfg);
 	if (!ret) {

-- 
2.55.0

