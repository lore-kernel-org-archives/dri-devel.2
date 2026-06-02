Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156BACD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5289610F60A;
	Tue,  2 Jun 2026 22:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ChwvhoBe";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8135810F299
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:01:25 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4905529b933so91593015e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780419684; x=1781024484; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cTm3whJEPVR1V6vQN57Lc8lY18BNxkH1NXZKiaHL+cg=;
 b=ChwvhoBeXP9BJkFMm2VgEgsqI8UdFqc00SxpAUFyZ0/MnWZX8LuIUa8X4Nm3IoAtQH
 pIyjbeFNyGxYLYS1aG0hL/mfeo6nOW8rUjiMZrtZovRPdbEpQTSSuvpt/STfNvembE8i
 yDkyB00ReEcV2O4mvLYV2NeQGEI/4CQcJwTybfvIFrN59De1AFgpDZtweZkrp0JQLhes
 mqltZAMZcoZRLrVK3uzAKP5j+CHwdz4DO/geKUl/Q/vpIZSTFX9kMVf+dsd9k6WQPwkn
 g3rXqYesruKWRYZOEcgyQSE0KclI3o7jMNhOCSyyZ4JVE7SoLztw4GBnYITpvjBvVsdi
 ETmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780419684; x=1781024484;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cTm3whJEPVR1V6vQN57Lc8lY18BNxkH1NXZKiaHL+cg=;
 b=VVk4SwZWr+f9pBZyiEOaajyrvWcSI84jE9akqwt86UGkk26oS2QspboeaCHCacmQxG
 MAsZwafWpALrsQ4R1FeAl+oQFYCKCiQfArKokedEcY/Sch/5r97qOaw/ive9lJmUIreB
 8jl/S9oLKUxQthSHLZIWc9ParAbKfStyov2lfFb1+50b8lXAR92486Ttz8iPTfFpSX8K
 KljS+YxBUzj5ggWiarVIKypLw1zK1iJfBbjOcl4yVNqriWYjrGwFtZxBYhgESpDLDSgh
 ixuojC3dHNsIebznLQeqCtyHC9rQTXIbGKjjl4W2MFRWGlm24WTHYJHaT2/a7fCJ9IFN
 N0zw==
X-Gm-Message-State: AOJu0Yzp1bdb2ddn+ZS0isgxegmxJKEcYj7yWXR3R+jTp/CIVECs1TKS
 Y9WzSQ9b4RYxlWTLbyZIhb8hj0o41X/2rwpGZMymmUvhhPbPF/mdSA2lg/TuGQOy7bo=
X-Gm-Gg: Acq92OFau31OYoCA3KiT1XnX1oECG1mrXrQKth2rLBtfzNBDZd4GlHMxOkJq38y+DJs
 4GqLpLsUXP6W8nZw7XrCYrKPFzN/qq9wxlRDhC06CkkTbJ5mpEUqnHs1DJWetAF7AZBUWiIk0wc
 gwsaVx6CjyVkpeO0TDMbNGhVh6GkgjR8twcKZVXLk4xN+mwrl8+HXR1NLEe3zF58cu1cZX66Sfu
 QroMQ3ywD/sgM9PzRei9J7eB/T2G5AZ0ABuqzhDPdanv0e6OWoSvMuLZJ/Vs5Sl8xVIfLAwQUPR
 xNKqwgHzhnKe1MD2v7iFZ7DC+mnoca7UUFfI//S6AkrOrQ2kmoiUy/10yg/BnBxroJuAMnTuduF
 Ut0IEOOv1WJ18IkHO9NlnLJyMHa/xc+XOCZfTfSmJbA8k09dk7u+sTGqwSwcDJ0VAggjpiF7t+H
 fBjbOkRGQ1DrYRbbRlU8LIxspOLYb/fXUaXvehU1LtbJd0SeRKdiKcGiHBLczMVA==
X-Received: by 2002:a05:600c:6211:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490b505e6bamr11024685e9.11.1780419683944; 
 Tue, 02 Jun 2026 10:01:23 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm588495f8f.8.2026.06.02.10.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:01:23 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 02 Jun 2026 21:00:40 +0400
Subject: [PATCH 2/2] drm/rockchip: dw_hdmi_qp: expose "overscan" property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-hdmi-overscan-v1-2-31f71b817c80@flipper.net>
References: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
In-Reply-To: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=alchark@flipper.net;
 h=from:subject:message-id; bh=tHygaxsktj42z30dgx6UrKlEC5FoIMQxcKQ2lQcmua4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJ84QWFpevzNSVk3KbHC56Jr/59YE7c9cfbMmaquPyU
 WPBI+3MjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKY6vJKR4UhqqtjB4/6f1iwr2uOiUxorJcHYPiX05ukJaUuZAht04xn+Ge4taNm
 kGF3z68uU2DUrlLr/aCsWxnl6+h7Q/tQu8F+PCQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 02 Jun 2026 22:31:15 +0000
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

Expose the "overscan" connector property as recognized by KWin and the
likes to compensate for TV overscan cropping.

The CRTC will use the margin values derived from this overscan percentage
in its post-composition scaler to add appropriate blank margins on all
sides of the output image so that the TV doesn't eat up visible content.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index f35484715c2d..fae44d11dbef 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -137,10 +137,18 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 					 struct drm_connector_state *conn_state)
 {
 	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
+	const struct drm_display_mode *adj_mode = &crtc_state->adjusted_mode;
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
 	union phy_configure_opts phy_cfg = {};
+	unsigned int overscan;
 	int ret;
 
+	overscan = min(conn_state->tv.overscan, 100u);
+	s->tv_margins.left   = adj_mode->hdisplay * overscan / 200;
+	s->tv_margins.right  = s->tv_margins.left;
+	s->tv_margins.top    = adj_mode->vdisplay * overscan / 200;
+	s->tv_margins.bottom = s->tv_margins.top;
+
 	if (hdmi->tmds_char_rate == conn_state->hdmi.tmds_char_rate &&
 	    s->output_bpc == conn_state->hdmi.output_bpc)
 		return 0;
@@ -603,6 +611,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
+	ret = drm_mode_create_tv_properties_legacy(drm, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to create TV connector properties\n");
+
+	drm_object_attach_property(&connector->base,
+				   drm->mode_config.tv_overscan_property, 0);
+
 	return 0;
 }
 

-- 
2.52.0

