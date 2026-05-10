Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4758DCD37B5
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 18:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1D010E349;
	Sun, 10 May 2026 18:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LvUIkdyg";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7BC10E349
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778437930; bh=tWZ1i/q7CLgAfivuQtexjnsHVV4DZ1Xla4Z36a9NDCo=;
 b=LvUIkdyg7+3h9LZKREWDFpVSrscJqxgnPPH/EEELR91LT+N5wsE3QVW6DAl1bf15C561yREnj
 8ZsTDO9FQKDFx80LTt5NTYRyDsN3sebS/sdbb96KEgWYbdu1RTcgry28E+3eUOrf2vqF/RClSyx
 7njs79i9s7OlaWI06wMP6y8IGRkN2rEgx/UFaRG9VzndY2SHSqOu6V12jl82zCJ8cpzNbmeb+z1
 3SlO1w/jp8FwoEj93iGptm8MUSvyK+YD1KmoJ/hETZ1VoerRP6qqs+Eemez55qhYgGeVH+3JTGx
 6xvpmPw1lkuxULWe4ml7KBL6/TD2wN+jpXoftNc74QKw==
X-Forward-Email-ID: 6a00cf1b61db3ab145b0f2fe
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 09/10] drm/rockchip: dw_hdmi: Configure HDMI PHY in
 atomic_mode_set()
Date: Sun, 10 May 2026 18:31:10 +0000
Message-ID: <20260510183114.1248840-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510183114.1248840-1-jonas@kwiboo.se>
References: <20260510183114.1248840-1-jonas@kwiboo.se>
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

The HDMI helpers negotiated TMDS character rate and output bpc are
available from the connector state. Change the encoder helper from
mode_set() to atomic_mode_set() so these values can be used to configure
the HDMI PHY using phy_configure().

This has no impact until the dw-hdmi bridge is fully converted into a
HDMI bridge and HDMI helpers are used to assign hdmi.tmds_char_rate.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 29 +++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 9d3bb6cd5670..94a30579a736 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -226,11 +226,22 @@ dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 	return MODE_OK;
 }
 
-static void dw_hdmi_rockchip_encoder_mode_set(struct drm_encoder *encoder,
-					      struct drm_display_mode *mode,
-					      struct drm_display_mode *adj_mode)
+static void
+dw_hdmi_rockchip_encoder_atomic_mode_set(struct drm_encoder *encoder,
+					 struct drm_crtc_state *crtc_state,
+					 struct drm_connector_state *conn_state)
 {
 	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
+	struct drm_display_mode *adj_mode = &crtc_state->adjusted_mode;
+
+	if (hdmi->phy && conn_state->hdmi.tmds_char_rate) {
+		union phy_configure_opts opts = {};
+
+		opts.hdmi.bpc = conn_state->hdmi.output_bpc;
+		opts.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
+
+		phy_configure(hdmi->phy, &opts);
+	}
 
 	clk_set_rate(hdmi->ref_clk, adj_mode->clock * 1000);
 }
@@ -270,15 +281,23 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_connector_state *conn_state)
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
+	union phy_configure_opts opts = {};
 
 	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
 	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
 
-	return 0;
+	if (!hdmi->phy || !conn_state->hdmi.tmds_char_rate)
+		return 0;
+
+	opts.hdmi.bpc = conn_state->hdmi.output_bpc;
+	opts.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
+
+	return phy_validate(hdmi->phy, PHY_MODE_HDMI, PHY_HDMI_MODE_TMDS, &opts);
 }
 
 static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
-	.mode_set = dw_hdmi_rockchip_encoder_mode_set,
+	.atomic_mode_set = dw_hdmi_rockchip_encoder_atomic_mode_set,
 	.enable = dw_hdmi_rockchip_encoder_enable,
 	.atomic_check = dw_hdmi_rockchip_encoder_atomic_check,
 };
-- 
2.54.0

