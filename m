Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F7C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59D89E47;
	Wed, 16 Sep 2026 13:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="efB9rYui";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B3589E47;
 Wed, 16 Sep 2026 13:46:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 98D8DC5CD60;
 Wed, 16 Sep 2026 13:47:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9E9D260337;
 Wed, 16 Sep 2026 13:46:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C8B111C7B042; 
 Wed, 16 Sep 2026 15:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Kzx7cYVqLgkBsTDq0kfXPzm/eoE3/PwS0/f16oAjmtA=;
 b=efB9rYuizlWyBmeyjgXAyqT/EmO5MBA2lRywzCNv1NeGY+zZNubrYDREDfyFlAfDhc+Ln3
 THOiYddqwpbMAMnpCfg3Z9NJyxnRTupdDioY4Yqs8LxIzqBZY7mbSJEfBtpJcbFYCRe0Af
 bPznxNRs4e1WFuvruUlofhhNEMnRMwkIgEBgIaXOVH6t4+nqLDM3nGsQ0jeKLdn945rrRz
 Ih7MdR6/pySHjFk5RNY79AJHDJHO/3XM62oACWrTor2rIcsE4eB0YjchUanbSXBGAVRHgt
 secfu1AAKqmLazXF9tB2qxEgpbtbbpHbd3kKCRRa2LAzYj9o2F+qlD8PzVd6Ww==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:32 +0200
Subject: [PATCH v3 08/19] drm/todo: add entry for removing the panel_bridge API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-8-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Now that a drm-bridge is embedded into every drm_panel during the panel
creation, the panel_bridge does not really exist anymore. Its API has been
deprecated and kept until drivers convert to the bridge API.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/gpu/todo.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index cb0ce432c114..a437ae5c71f4 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -484,6 +484,31 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Starter
 
+Remove panel_bridge API functions
+---------------------------------
+
+Now that a drm_bridge is embedded into every drm_panel, the panel_bridge is
+not needed anymore. Its APIs are just accessing the embedded drm_bridge
+transparently, and the are deprecated.
+
+The funcions to remove are:
+ - drm_panel_bridge_add_typed()
+ - devm_drm_of_get_bridge()
+ - drmm_of_get_bridge()
+ - drm_panel_bridge_remove()
+ - drmm_drm_panel_bridge_release()
+ - devm_drm_panel_bridge_release()
+ - their direct or indirect callers
+
+Convert users of those functions and eventually remove them when unused, or
+make them static drm_panel.c functions when used internally by the
+``drm_panel.c`` code.
+
+Contact: Luca Ceresoli <luca.ceresoli@bootlin.com>
+         Maxime Ripard <mripard@kernel.org>,
+
+Level: Easy
+
 Convert users of of_drm_find_bridge() to of_drm_find_and_get_bridge()
 ---------------------------------------------------------------------
 

-- 
2.55.0

