Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B919C79FBF
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E598110E557;
	Wed,  9 Sep 2026 17:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fDddcE1h";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43AF610E58A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:36:16 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843af75de5so621945f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788975375; x=1789580175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EqyOJwWDc9siUyUIf9HLEiRZ/UBmYkZ2bG5NW9K2GYU=;
 b=fDddcE1hBH0aV7gxmYszw66V+DtDfxbheCNsiJvmvNvo45OJoLmieY0HRE8UkdnvWV
 8iDq+j+lo7oW6LrXsffpwr5zH7tWQjSsaY/krOmVQ8V8VCeoFTD3D9RplDQ9IJA4eTg7
 qRWkDYrwatkhcDxyzlnoxkSAWtxRbQ/WOctLaxb3T+Uej3h/3GMLMfhgWAfzV1hIJTX5
 fDVAyM5kUn9pij5liMk8UIk3KvHnVU35+L+0sIr6ubz3js2beQicC7eBi2v8c4IbREpw
 h2zSJXPVh2h8YQP1dX7gLJwz/GCvaymOYIc2WYo9MKxsV2x9y+osA1s26wS1Hc4xpogm
 OUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788975375; x=1789580175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EqyOJwWDc9siUyUIf9HLEiRZ/UBmYkZ2bG5NW9K2GYU=;
 b=mgeYz67lmq6yeARpgwpIdFBT/919pJb9VxBxfO8yTO5dUbAONMaB2kWAlnqtjD/gMs
 5h/klAwNM4nTWts6YvnDDoVcbTlKQYmdQ+n9HiBeF7pSA1VqfVM40zPLeddDtOVvGIkU
 GWHjlkFd01N3tJsyF3DbBs/oSmkIKBgDBFMVv5x1YEGZvhtGNyqIYbVN+xgHMJFy/FBk
 J2iKWpvsUjv3aHr9E0X8h58hQohfskpydxBt2F7EA/8EbIbbGZ0Rp8ULanvuyVX48MHM
 +DQli/qKklH3MMBDgkPJz61RFnK9is/06g0wH13YiGlf0ZjKm0CaWDrl1l6ujD19xs1N
 fuCw==
X-Gm-Message-State: AFuF++kUCgjcZ5SkNGaONsiXVbsC4WdpB503J5u9yrZQO0qNdbb4wWak
 DXPUm+ODpit+NPEfULcW9c+WC40GoiccR75U3b8+pWVdLqOs24MPK7Hl+WjU97IJ
X-Gm-Gg: AYBFou0Jpf2S+ykbEoJ6Tau4fPuhDOR+1zf34bU543HnN87qwhXjsSqBGCK32NSCL8V
 txAQIrx7SDhWHUOveV2CSrRlAl1JCPFMIU+ib9Rc+z4UCoor+ArHo7QTuAXpc+uvDHNw+IzqjEA
 UnX99DUWBAh3OgaImIqJWRON3GfEZBlLHrIDdlY8zeAPlvsSJx+NVLBTGgprS2hjKZjZPbH04mm
 CKnapN1EjKBkJTyx/WwQsOgiOX/deXeAR21fkq4averPw6q9Eahblt8ivdFT5jcWcAOTXE43fUO
 lEdZz9vC7szR9J5CPKcpxamrYP+GfWTTGD/isxHEIogCM1UazaizkIjlNzpKTt6z/XWx2miW50N
 7y83DL1kDsT9aU/2MQjse7xM+LJq3e/U6bAcrcsrChx087ILF1E7jE9uti9wB6/5FFKNqCI5+h0
 tp9pQsR2MoT0IaU6DVk64fv5xDIA+qdkHTltjkz5KViEdjh+ojmdd/vuEbqHUwzLI2DKxXvn3ge
 A6vdEndgYzyFLK+b3i+o5Om+fRNqCZeLgreP4kwUjFI1KY3NlJzmBGJrHOc9xiCOChuErkXbqfG
 Qw==
X-Received: by 2002:a05:600c:620f:b0:49c:eac2:ddad with SMTP id
 5b1f17b1804b1-49d2570acaemr24678895e9.1.1788975374390; 
 Wed, 09 Sep 2026 10:36:14 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900B0110705BF092680.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:b011:705:bf09:2680])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c06f04sm6876575e9.13.2026.09.09.10.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:36:14 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Igor Paunovic <royalnet026@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH v2 3/3] drm/rockchip: dw_dp: Attach "max bpc" connector
 property
Date: Wed,  9 Sep 2026 19:35:40 +0200
Message-ID: <20260909173542.14030-4-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909163206.36409-1-royalnet026@gmail.com>
References: <20260909163206.36409-1-royalnet026@gmail.com>
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

The dw-dp bridge already filters candidate output formats on
conn_state->max_bpc in dw_dp_bridge_atomic_get_output_bus_fmts() and
validates the result against the link bandwidth, but the connector
never exposes the "max bpc" property, so userspace cannot limit the
bit depth. Attach the property with a range of 6 to 10, matching
dw_dp_output_formats[]: the smallest entry is 6 bpc RGB and the
deepest entries are 10 bpc.

drm_connector_attach_max_bpc_property() initializes
connector->state->max_requested_bpc and therefore requires the
connector to have a state. Rockchip binds its components before
drm_mode_config_reset() runs, so the freshly created bridge connector
does not have one yet - create the connector state before attaching
the property, exactly like drmm_connector_hdmi_init() does for HDMI
bridge connectors. The later drm_mode_config_reset() then re-creates
the connector state, and the preceding patch makes
drm_bridge_connector_create_state() restore max_requested_bpc from
connector->max_bpc, so clients that never set the property (fbcon in
particular) keep the full range instead of ending up with 0.

With the property attached, compositors such as KWin write "max bpc"
on every atomic modeset; any in-range value is handled by the existing
format filter and bandwidth checks.

Assisted-by: LLM checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index b23efb153c9e6..8ff27353b1417 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -112,6 +112,32 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
 				     "Failed to init bridge connector\n");
 	}
 
+	/*
+	 * The components are bound before drm_mode_config_reset() runs, so
+	 * the connector has no state yet, but
+	 * drm_connector_attach_max_bpc_property() requires one. Create the
+	 * connector state first, like drmm_connector_hdmi_init() does.
+	 */
+	if (connector->funcs->atomic_create_state) {
+		struct drm_connector_state *state;
+
+		state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(state)) {
+			dw_dp_unbind(dp->base);
+			return PTR_ERR(state);
+		}
+
+		connector->state = state;
+	} else if (connector->funcs->reset) {
+		connector->funcs->reset(connector);
+	}
+
+	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
+	if (ret) {
+		dw_dp_unbind(dp->base);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

