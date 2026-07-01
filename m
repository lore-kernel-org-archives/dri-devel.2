Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E093C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDC510EE44;
	Wed,  1 Jul 2026 10:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ijbbXKOq";
	dkim-atps=neutral
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B50610EE44
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:59:57 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-6a0e525db1eso274861eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782903597; cv=none;
 d=google.com; s=arc-20260327;
 b=b4rLISrjjaIX8vUwatKikb3jGc+CtlAygxpdicCrC4L5eCmButI799r0b9gKvqAcOO
 6R2At4Hub4aO/uIs90mgFuG3KfncSewFnSIb/pd7zTOvZNGR+SxBjZtxuRvDu02+OEda
 ITVO+DgTPGRaRq3wj4ea0BKUHY23PJ79D/3kIfbJ/NkSR5eVdBQod1jOz9tpDzZdiYIf
 C6JihMnhPjAEMluLvXPyj6iCMi34AnUpUBVXCui+1cAuvdRT0BBmw0pdbxHO5wmdrvT4
 ptcEikYecWUXh56NRMN1VWg8guKKS5aRCm6AjvHeKtmLbGgE/QyERUREsvO9HoAPOMQ1
 D4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lO56/jrYt5xZFVEPQmv45xkupS1NYM0pLDiA7bnEG+A=;
 fh=71deF6N9aSgBpRdcC66F0wYKqtjnG7biL879s7lZe8c=;
 b=rjraaI6n0rqpjKc4JA3HzI3bvVzvpLKv7Dl7Stn2zYOaVXDWyYy6VzU5dX1fNnEQRS
 +hcGOniFEo23xnuqGm9gC7S05g8gT0CFPC3Iul6LQMLgvNEGYdaC7fQabcWpfPKsi8lG
 BHgCTj/nZA+kR3LwWIr1FxJz9I02Ub/AFEP5OgdjQnQgqBpcPtycY1lg+W0iW7CL+xA6
 59mSsfAdo8OrHzJdQxMTIKLsiAWh5g1VDzFjtI8TVLHKFPkO9XTy+pqFFt9E9V735syL
 vG5iSNbGqK9WNig/n/QGFTOBL21RS3+mZraXEIlxQMpTw8QqSgfdnTlTlfsNHzS1xaHU
 KGTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782903597; x=1783508397; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lO56/jrYt5xZFVEPQmv45xkupS1NYM0pLDiA7bnEG+A=;
 b=ijbbXKOqBduHhklEmEQ9TFZ8htAr1nH4YJz1Xe6r5aR2DyC0Fmd15o35S/wiXTNOj0
 Yp/ZnY18BOGoMU/s2g4KpFvik5b/8zBHXNsOedwomFh/uLgffgehvyD2vGG7WfMDszbU
 ewMjM281HfVnjZ9L+OcbJG5q6dMX4Isi+PSgLYEm0WoXsR/a8k+2BtM5iAUHWPHNvuB4
 NrQLG6AIcMWT0ULI/5tBsZxv/1D2ZCcqb2HPUkZbrAG6eg/SOfCBwYvx+ejPQlnJCA/3
 RCC/eGa8rieU4XXdP/9Xvy8IWU5Xm8oLvB9E8jdNVyraKtlc0ig6rMs/eh38JszPAcst
 ZJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782903597; x=1783508397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lO56/jrYt5xZFVEPQmv45xkupS1NYM0pLDiA7bnEG+A=;
 b=OhXE4WIyuRYiIVM+EZLLMAzhYpHssXriI622PQHs/3OKYOqpvqmOpQeuTSE/aCvvkO
 OhZXCf4EpomNYgJykpVYPGHuFVhGGqQQU+b53avrfJULtrhvzwFmRWc7IbtaHf0vyiBS
 dueYrZDodO9h1zHaqWkOYIcBqmHcffEqIup9+YPuiYDUAQviynOL3bEAVpwS3dnRbLhm
 QZSM4+tfc9ZcQTR01CfRAZVWc1MgDa9NlCXQwnWGC7aJO9HpjZaOtIxtgD/2pwErJD+z
 3JdARMJ/Xzb3a6DqMGkQvePzB13OuaYpKI+YWRfnIyOpQ9rx6erfIkJbKRQi2u7014Ik
 bBYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85mivccgUXH/mptt1GpgarhfO5gsjmTjErCuq3DaHZPDZzqZVRqi9PTlwkxQMSVl5xDQCW0LjSmAE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxduUvc5ICXxQQsffN4F5S0sJ30f5lg1Rdo9voOFPYEC9Jnva2y
 Zfk5T35M0cMQhhayg73h8dz5aI+/Lsb3fS8q+rmV10PhQq9C4Ev70PivFZdy2Z197DmIJQIJ5nW
 xRjU+quXT2QQZuCqGpVlfUn9Ls4atKE4=
X-Gm-Gg: AfdE7cl2IRFP5yOckeYTz74r34WurY1rSwBxdYy3XixKpnJopM9dUKQPgrBjnt8S4hp
 cjnOq4mqm05oA+4dpBzOBIQ+qr1Ka6IRdCHsaDCK2nLCDpAbuS70x4yzw2Q2qmVLcggWKUOJKRy
 DWgZSmhn6R2/7kfr9zpA/uJwilcDuE6lD+s3iLGxD8gN/W6LoD8CjXjjsjIYjbgozLzXqloiEbb
 blNxUCUPHl4hGfmM/Z28WxbDzY104cd/mKsMeuo8OpKpjURC16f8T5ALovOv+FoXsFEdtk=
X-Received: by 2002:a05:6820:4c10:b0:6a1:7abd:2a6c with SMTP id
 006d021491bc7-6a309bc1fb7mr506522eaf.55.1782903596578; Wed, 01 Jul 2026
 03:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260608124018.480365-2-diogompaissilva@gmail.com>
In-Reply-To: <20260608124018.480365-2-diogompaissilva@gmail.com>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Wed, 1 Jul 2026 12:59:45 +0200
X-Gm-Features: AVVi8CdTMl8FaEPIfiIJ6n1_iuadQGCC_quf_89FmVweKwbOPq0QNm5_UZ___PQ
Message-ID: <CAJpoHp6DnspnA0rirGb6E=A9wCS3eaDn=eFaqmae98Q+39b1PA@mail.gmail.com>
Subject: [PATCH RESEND v3] drm/rockchip: Remove dependency on DRM simple
 helpers
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the dependency on drm simple helpers from rockchip
DRM drivers.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
Resending just in case this was missed. Thanks.

v3:
 - rebase on drm-tip tree

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c  | 9 ++++++---
 drivers/gpu/drm/rockchip/cdn-dp-core.c           | 9 ++++++---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c  | 9 +++++++--
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 8 ++++++--
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c        | 1 -
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c      | 1 -
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c   | 1 -
 drivers/gpu/drm/rockchip/rk3066_hdmi.c           | 8 ++++++--
 drivers/gpu/drm/rockchip/rockchip_lvds.c         | 9 +++++++--
 drivers/gpu/drm/rockchip/rockchip_rgb.c          | 8 ++++++--
 10 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 776954c7d052..46c245e35d21 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -30,7 +30,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"

@@ -303,6 +302,10 @@ rockchip_dp_drm_encoder_atomic_check(struct
drm_encoder *encoder,
        return 0;
 }

+static const struct drm_encoder_funcs rockchip_dp_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
rockchip_dp_encoder_helper_funcs = {
        .mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
        .mode_set = rockchip_dp_drm_encoder_mode_set,
@@ -361,8 +364,8 @@ static int rockchip_dp_drm_create_encoder(struct
rockchip_dp_device *dp)
                                                             dev->of_node);
        DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);

-       ret = drm_simple_encoder_init(drm_dev, encoder,
-                                     DRM_MODE_ENCODER_TMDS);
+       ret = drm_encoder_init(drm_dev, encoder, &rockchip_dp_encoder_funcs,
+                              DRM_MODE_ENCODER_TMDS, NULL);
        if (ret) {
                DRM_ERROR("failed to initialize encoder with drm\n");
                return ret;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c
b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 190cce9530c8..c3f41a4449f5 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -23,7 +23,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
@@ -671,6 +670,10 @@ static int cdn_dp_encoder_atomic_check(struct
drm_encoder *encoder,
        return 0;
 }

+static const struct drm_encoder_funcs cdn_dp_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs cdn_dp_encoder_helper_funcs = {
        .atomic_check = cdn_dp_encoder_atomic_check,
 };
@@ -988,8 +991,8 @@ static int cdn_dp_bind(struct device *dev, struct
device *master, void *data)
                                                             dev->of_node);
        DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);

-       ret = drm_simple_encoder_init(drm_dev, encoder,
-                                     DRM_MODE_ENCODER_TMDS);
+       ret = drm_encoder_init(drm_dev, encoder, &cdn_dp_encoder_funcs,
+                              DRM_MODE_ENCODER_TMDS, NULL);
        if (ret) {
                DRM_ERROR("failed to initialize encoder with drm\n");
                return ret;
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..a09b382d208e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -25,7 +25,6 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"

@@ -825,6 +824,10 @@ static void dw_mipi_dsi_encoder_enable(struct
drm_encoder *encoder)
        clk_disable_unprepare(dsi->grf_clk);
 }

+static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
        .atomic_check = dw_mipi_dsi_encoder_atomic_check,
@@ -840,7 +843,9 @@ static int rockchip_dsi_drm_create_encoder(struct
dw_mipi_dsi_rockchip *dsi,
        encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
                                                             dsi->dev->of_node);

-       ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+       ret = drm_encoder_init(drm_dev, encoder,
+                               &dw_mipi_dsi_encoder_funcs,
+                               DRM_MODE_ENCODER_DSI, NULL);
        if (ret) {
                DRM_ERROR("Failed to initialize encoder with drm\n");
                return ret;
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
index d2e76d36d724..9dc207c2d20d 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -23,7 +23,6 @@
 #include <drm/bridge/dw_mipi_dsi2.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>

 #include <uapi/linux/videodev2.h>

@@ -275,6 +274,10 @@ dw_mipi_dsi2_encoder_atomic_check(struct
drm_encoder *encoder,
        return 0;
 }

+static const struct drm_encoder_funcs dw_mipi_dsi2_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
 dw_mipi_dsi2_encoder_helper_funcs = {
        .atomic_enable = dw_mipi_dsi2_encoder_atomic_enable,
@@ -290,7 +293,8 @@ static int rockchip_dsi2_drm_create_encoder(struct
dw_mipi_dsi2_rockchip *dsi2,
        encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,

dsi2->dev->of_node);

-       ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+       ret = drm_encoder_init(drm_dev, encoder, &dw_mipi_dsi2_encoder_funcs,
+                              DRM_MODE_ENCODER_DSI, NULL);
        if (ret) {
                dev_err(dsi2->dev, "Failed to initialize encoder with drm\n");
                return ret;
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 0de822360c8d..b23efb153c9e 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -20,7 +20,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index cffc0af5190f..b6e154c35e7c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -18,7 +18,6 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index f35484715c2d..af34062685cd 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -24,7 +24,6 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 1996f8656612..b4ba9f894360 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -12,7 +12,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
@@ -454,6 +453,10 @@ rk3066_hdmi_encoder_atomic_check(struct
drm_encoder *encoder,
        return 0;
 }

+static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const
 struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
        .atomic_check   = rk3066_hdmi_encoder_atomic_check,
@@ -696,7 +699,8 @@ rk3066_hdmi_register(struct drm_device *drm,
struct rk3066_hdmi *hdmi)
                return -EPROBE_DEFER;

        drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
-       drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+       drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
+                        DRM_MODE_ENCODER_TMDS, NULL);

        hdmi->bridge.driver_private = hdmi;
        hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c
b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 7a0c4fa29f2f..f3be2c91d147 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -24,7 +24,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"
 #include "rockchip_lvds.h"
@@ -427,6 +426,10 @@ static void px30_lvds_encoder_disable(struct
drm_encoder *encoder)
        drm_panel_unprepare(lvds->panel);
 }

+static const struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const
 struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
        .enable = rk3288_lvds_encoder_enable,
@@ -594,7 +597,9 @@ static int rockchip_lvds_bind(struct device *dev,
struct device *master,
        encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
                                                             dev->of_node);

-       ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
+       ret = drm_encoder_init(drm_dev, encoder,
+                                     &rockchip_lvds_encoder_funcs,
+                                     DRM_MODE_ENCODER_LVDS, NULL);
        if (ret < 0) {
                drm_err(drm_dev,
                        "failed to initialize encoder: %d\n", ret);
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c
b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index add3123e5ce7..2ad24b914989 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -17,7 +17,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>

 #include "rockchip_drm_drv.h"
 #include "rockchip_rgb.h"
@@ -65,6 +64,10 @@ rockchip_rgb_encoder_atomic_check(struct
drm_encoder *encoder,
        return 0;
 }

+static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
+       .destroy = drm_encoder_cleanup,
+};
+
 static const
 struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
        .atomic_check = rockchip_rgb_encoder_atomic_check,
@@ -127,7 +130,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
        encoder = &rgb->encoder.encoder;
        encoder->possible_crtcs = drm_crtc_mask(crtc);

-       ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_NONE);
+       ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
+                              DRM_MODE_ENCODER_NONE, NULL);
        if (ret < 0) {
                DRM_DEV_ERROR(drm_dev->dev,
                              "failed to initialize encoder: %d\n", ret);
--
2.51.2
