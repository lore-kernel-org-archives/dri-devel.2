Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA86C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091F910E3FA;
	Sat,  8 Aug 2026 09:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATL2zJPB";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6BE10E4A5
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:58:22 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4954b3c5cbeso365535e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786183101; x=1786787901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g22IUbt8ZLLCFwaMoIL3xYIHr/pNgXlbdNwWp0/GjnE=;
 b=ATL2zJPBCbcwAdQsLDovO6tmvva3mjmgZqgj0PpUUb0W4gpvlL0yR/9h6eKQlEA1jO
 PQxvvvQHUAGp6eLmxc7K3mpvdSvFQADwspSBk10on/QbxwkwuiJv1/Eaf6Dwr78DIZ3F
 2EpJnOhRu1V7uOdGmZLMjR2wtwbiS74nu/fECovrk7YlnQQBc2fukod8QUl4k+l1Y6OA
 a+5F+HT7w+bHQ0Xyj1SKXz1E+6vwm+icArBJfGyQhyjQAw8raQM+1OFYxOzXjKzoBu7a
 4Twz3LQRdBJSxbAGblQD3HXmCaA/e4fbY4AMlDztSjnQznq2+yRv5iwMWE3VEFKAl/dM
 yb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786183101; x=1786787901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g22IUbt8ZLLCFwaMoIL3xYIHr/pNgXlbdNwWp0/GjnE=;
 b=QS7YquAQBgeRuoTvVZCjMZHCGA/BqG0lhLd3rLyFdYO4l83dzR1TkjnSVqDZtFutwL
 iHgZceCSK4w1DkVXtDIi1pScV9i58AcUPEzANQcneu3J5+mWqcnwviAeYHHpvYiyhY0e
 BpuH24k+/B5xhsoxuNbZax1fV6ML0OQnJe/F0qbEzjOMb4izVtq95FOyXIunCKM5E4TI
 K9XI4PwIFQlv9/7K2bOXvUaeToqkR/kdxM5yWExcU3DiSNBmFaR5MGGPyd+Uirvlur4w
 NK4dhiqOGT+YRhCfgWEbEzea0wZTjxgrGz7yW0QS7ZT3GD4JxLOSkDBSH5bYxk8o7kiQ
 LwrQ==
X-Gm-Message-State: AOJu0YxjuFCs6CVUiObbAyBahfhkyLiXVtt7LkvTUFghv79CZwltxq4j
 akHzLshrOfUZogx668YSepCLtUj9nZwhkxpyTGiu7zYveu6tFBrcQZY3WLLroZ8A
X-Gm-Gg: AR+sD10JkVWAJbdE+7ecORdUvCK2H2cL1Gn+CrkHH7mxsMtWSCslrfwYmtVpxZTrIzI
 bVQXTLjdJJhKspkOJe43QLpki93pBfDrXp9LvFD9r72C182CK702M0MnEQIQJLcsm7pancPO6Te
 4dF18VSBSsDdkfANYs9RzP3UmOiHI68EWbSAp7xzkfAB+qDoCnTdvChf+nvEOP4w93Ci7XCf9GO
 Y21pTJ4xN0K/w+K4a5AM9HsYrYAtuo7zFyYmzZ86NAuqEJWWeEo8ydQKOfoldH6EtYFnjLn0+nn
 jUTvbobNSGu9jreb39O1FpnHrj2FvT8qeS9i1ZPhG0s/9VLwQgC+CTSWQp+EL26Zok0pozqdQqd
 QJCxpBBq285TjYZPmMRYrnw8p50RcPs9l111DyZk8jJVjCUxMYl/X01yMvZhz77AARY8HUf1ieZ
 bt2ztaoK3mMAQ+GrSBCg0ana7o7rG/82EyejamaPCBI7emHjXuqh7BlRMjPc/6F4jHQ0nBvVAgr
 0VJmuaxWtkQ9BqLbEQi5jlU22N9RiUqcgtEnwarUT5qYjFPMdRyNfkk2lSGcnrr7IHI2A==
X-Received: by 2002:a05:600c:4514:b0:493:f42e:1b3f with SMTP id
 5b1f17b1804b1-4994e7c7360mr190359775e9.3.1786183101054; 
 Sat, 08 Aug 2026 02:58:21 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm13255725f8f.0.2026.08.08.02.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:58:20 -0700 (PDT)
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
Subject: [PATCH 2/5] drm/display: bridge-connector: Preserve max bpc across
 connector reset
Date: Sat,  8 Aug 2026 11:57:21 +0200
Message-ID: <20260808095749.9428-3-royalnet026@gmail.com>
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

drm_connector_attach_max_bpc_property() initializes max_requested_bpc
and max_bpc in the connector state, but nothing restores them when the
connector state is later thrown away and re-created:
drm_bridge_connector_create_state() returns a zeroed state for
non-HDMI bridge connectors, and drm_mode_config_reset() installs such
a fresh state on every connector that implements
&drm_connector_funcs.atomic_create_state instead of a .reset hook.

This matters because drivers can attach the property before
drm_mode_config_reset() runs. Rockchip, for example, binds its
component drivers (which create connectors and attach properties)
before calling drm_mode_config_reset(). After that reset,
max_requested_bpc is 0, so drm_atomic_connector_check() computes
max_bpc = min(info->bpc ?: 8, 0) = 0. Any driver that filters output
formats on conn_state->max_bpc then rejects every format, and clients
that never set the "max bpc" property - fbcon in particular - end up
with a black screen. meson already attaches the property on a
drm_bridge_connector before drm_mode_config_reset() and so already
boots with max_requested_bpc = 0 today. dw-hdmi's format negotiation
does consume the value there, but meson attaches the property with a
maximum of 8 and the 8-bit fallback formats are not gated on it, so
negotiation yields the same result for 0 and 8 - the change is a
no-op for meson.

HDMI bridge connectors are immune: drm_bridge_connector_create_state()
calls __drm_atomic_helper_connector_hdmi_state_init(), which
initializes both fields from connector->max_bpc. amdgpu likewise
re-initializes max_requested_bpc in its own .reset implementation.
Non-HDMI bridge connectors have no equivalent.

Mirror the HDMI helper on the non-HDMI path: record the upper attach
limit in connector->max_bpc (drmm_connector_hdmi_init() already stores
the same value there) and restore max_requested_bpc and max_bpc from
it in drm_bridge_connector_create_state() whenever the "max bpc"
property is attached. Connectors without the property behave exactly
as before.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 6 +++++-
 drivers/gpu/drm/drm_connector.c                | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 632cc3ae3b54..d33c4fc42fbf 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -282,9 +282,13 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
 	if (IS_ERR(conn_state))
 		return conn_state;
 
-	if (bridge_connector->bridge_hdmi)
+	if (bridge_connector->bridge_hdmi) {
 		__drm_atomic_helper_connector_hdmi_state_init(connector,
 							      conn_state);
+	} else if (connector->max_bpc_property) {
+		conn_state->max_requested_bpc = connector->max_bpc;
+		conn_state->max_bpc = connector->max_bpc;
+	}
 
 	return conn_state;
 }
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..0400a6a92e2b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2866,6 +2866,10 @@ EXPORT_SYMBOL(drm_connector_set_link_status_property);
  * @max: The maximum bit depth supported by the connector.
  *
  * This is used to add support for limiting the bit depth on a connector.
+ * @max is also recorded in &drm_connector.max_bpc, so that
+ * &drm_connector_funcs.atomic_create_state and &drm_connector_funcs.reset
+ * implementations can restore the property default when re-creating the
+ * connector state.
  *
  * Returns:
  * Zero on success, negative errno on failure.
@@ -2888,6 +2892,7 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 	drm_object_attach_property(&connector->base, prop, max);
 	connector->state->max_requested_bpc = max;
 	connector->state->max_bpc = max;
+	connector->max_bpc = max;
 
 	return 0;
 }
-- 
2.43.0

