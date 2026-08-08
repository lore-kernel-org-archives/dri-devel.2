Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B984DC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC2A10E4A2;
	Sat,  8 Aug 2026 09:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ST42Sa1V";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC30910E4A6
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:58:24 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f611b3af9so39210f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786183103; x=1786787903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bygF4+CGk1HszXnKQxQkJUMmXmQwnL2yRQrBPqNom6w=;
 b=ST42Sa1VqmdePuhIQ3TQ8avga47TvKxamNgKy+GrqNX62SdNtt+uicmxQ11eddcIIQ
 r9we2fjf6sLe8eea5vQKgRC7IyyTKQK0rhIhsHryy8FIZWhbGh2Rjin3ZRM+YraLHsV3
 Nn0knDawzBXY0NTBM5EdC5ediBhpYDcI8EyORCCPvN5o8VM4AmOA10BAmh6E9crequkM
 n7Y+fI1xmHKlyCgHrii12jNfvOdoQMZiA87Kv/ds+bRS0Zw4649TL2RnkTcMqVjHoMaT
 j0soDag6Gk9HdQBFi54S8yuKziw1UuKmV6w3kbEl1ppspJDmUi1N9FrRJUcQEYXtD0Vz
 cRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786183103; x=1786787903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bygF4+CGk1HszXnKQxQkJUMmXmQwnL2yRQrBPqNom6w=;
 b=c0gB/vFSmz68i157IPgUdpsqBbO81JZu4p9Reau0XkD9ngrABsAsoYujrMEJmg0hin
 XsN20m09ajDQMpRd9LztaWoXt+87RlkjHs4AtmXkZKzKYyXC6pv8Ize5gp1qSwihncf1
 ozWSLRqS/aNcHALWgcwiRUC+wHqOGY2tAcUYx91ZBBpuA1hyCi9peqBdNFyouZBOlC76
 jipaGZaxpdrGRxOLDllQEekPz80Rsyih0/oh1aNl13AqZ7cLAkWCY/Dgd+aFzAr5m0bd
 rqKelKxXdIFuxF0CsaHZeRKxtKx/OHaa9cSns8rmCu5LPsMHfXaC/st0IkRWQmFnrKrY
 /R5A==
X-Gm-Message-State: AOJu0YwcxXnTDcHiFFCKVGFe0B0ATnvxmFm1/+0+ytBXj+4bDJyMV+qI
 kzpwGpvkmmFH1Ok08qFzPVVjnh4Am+YE83eZvoAqnt4upV4X1VuFss/Qyd/celUC
X-Gm-Gg: AR+sD13J+tEAKQmTnmlR+qu6fpZS+GoMqd95QCp92zqyeVebOIqaaEr/TTzzi31VcOh
 fn8mOF3GN/T5N59sX23okEe9dbKQCHLt0ZHGYw3gFLOZZwZeoZOoPLm76fblDtL+Bb0bqUiDILl
 IFKMMFwt0o64/EBoKf2BY8FMg4h0JkzMgEpSAkc+e7l6jQ88v+rL1exKzcgSJFtG3SD6W1koUNC
 nPHPQQH7t4cwBStkMAYLyXQjOmpBsZygctxNsS1T2CdRTXvV3jrGZVfK+1QTL0i02sDtKGpUkd6
 dfNM8gYTb+U7DdvEsX3NLTOHb6sHpLjpnf/kL7cwndTZ2q0ZeEyI0B34fkU8OUZPSv4/x0GFW12
 +PEEqKmYSplXT/6sUaDe103yJihnxLf+6BUwQUcV426uI9R5fhbYn3pj61tnBM1/9AdXZ79chBs
 X68VSYoAJq/vCPdQF5tm5YRzA2Fvn0bmpx0mO7R23ZHTFwPHqNcaRKUIYP4gUeTzk0KffDNl7Uh
 haroMKTU+hcW6XKTSExj469QHZ0dj53gfpKGA8HiBkenUG2IuH7V+fEsn6eWdGknqiBGg==
X-Received: by 2002:a05:6000:401f:b0:47f:7e91:3d55 with SMTP id
 ffacd0b85a97d-47fec520b24mr21741731f8f.2.1786183103128; 
 Sat, 08 Aug 2026 02:58:23 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm13255725f8f.0.2026.08.08.02.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:58:22 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
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
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 3/5] drm/rockchip: dw_dp: Attach "max bpc" connector property
Date: Sat,  8 Aug 2026 11:57:22 +0200
Message-ID: <20260808095749.9428-4-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808095749.9428-1-royalnet026@gmail.com>
References: <20260808095749.9428-1-royalnet026@gmail.com>
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

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 770ab042a187..4dc29963b5d8 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -172,6 +172,32 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
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

