Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC371C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50FB10E046;
	Thu, 13 Aug 2026 14:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/U9UMkA";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24EF10F384
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:40:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954b3c5cbeso1941645e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786632055; x=1787236855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4182N1qJg8wcsdY0I1VphGRMJvbBfDpbj3gNAH48eMo=;
 b=S/U9UMkAvvmX4SeLWwBJ/JRjg3zzUfYIDF9lfDQ1JZBljcCgQJdCtLjK+PywG22EYk
 TbMfjWV9ZJOoMGYs3aJG/Sp21ndRQXmXe0NYf+MKwETlzo9MKdxG33Yg6VPJXX6mFrne
 hUb79xuoyDkiIkU8udSpJ6Dp1aoVJBuJ9QumLUuAgxn3YS9Fmvo6BgYXPgPxWMAkQmu0
 fteOEomsb3cXDsbIF+9ci71d3VBetkSaXabSkRzi21SWUYTORKculok8Fwdp51pu7WBk
 uNqwUnCHUtfZcGrQc1PfrmTutpYiwXvCiDU/j1kS1WY7fss+LlfVl6VZRwvSCvWifpWo
 hDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632055; x=1787236855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4182N1qJg8wcsdY0I1VphGRMJvbBfDpbj3gNAH48eMo=;
 b=hLFHfvIEI5ddqSupx5CmFxhU0dWkvXwtCS9PKnLLuxy8xDiefhepqVejlW3prxYJEg
 wcappid2sXBIEys2r+xd0uBgcJX5mlJyxoUISVRCyKbBcD/o46Bls8Sf8BCxypQx1GsR
 /Zt5F7pbYoN7ytoWoopa08RzgqqtkgH14SRYtov2PelmQiyQYc8fihERoGF4mdElap14
 9miy5NmujMuElToZ23s7d+BfecIn3W6BMlzqeI9Mq0aYRlfqFIZt6Rv9q6dMM6kGWUNu
 rEXiMgt5TGb4aTbuMnC9FZRfLbFQhHpnxRHbif/H6YszJgCpYPI7RPmWi+epvgVW/AnI
 qG3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2Pg1aAmcaAu+hYImL1D7O3hMaURlSj5PlO0GOtJ1Jpvq61mAoxhd7iuaeWRPagOtMystEcCnGc5E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLjB+v6hbL5iwd45hLS53EyEtJ3iSTS63flmCumy3TY6CuiMv0
 7vaMB+0eyrNgqEh6vbXab74zNOIIOSdFgyPmseYp7mq7a6Pqje6P8j+X
X-Gm-Gg: AR+sD13gdqRXq4t5OGhP0BdK/g4LNSC0uPL/meW6b8IEH+d1hSAG/KvQdR1fj5xNo2c
 FgF4egxirMXKOKMzPZ0ckX3qCHlju6lF8st5Xx46X19JV0FsO51bv9xoC9z1Mb62KWZiC8lVDnN
 YFTALvVQW+jLH41zOLMdgbMIoutGSrajtP3itgU0UDBoYuIu4RB4g/BSnEa7CHz8+DD+H95+Y4B
 tDTxmGF4ZE/qb9KouxkBtp1HWTcMFAzBr2cbbEQw1liNyn7bxGLzFeldK7BNrDwC9B0f0gB1G01
 LHLDSBOQLES9zp5kkDYKczZT0U7Oq5cXlBHMGbu02DUf2+VuZidb/dg3MzZgDYPHSrdk2SerYaj
 hKjBlDBVC9Ayt+hhTxke7Sc7st7tmO6dYIfqxPdjIvrLrY3NZxTJ0OpN2MgkG2wIRdpdnQGJAzG
 Oc/+RUv8R86rJf/qzdGEh/m9kwihw4FxOnF86zy47oz3hHEMjbYYpeUlnb4U1N3PxFuek6UMycu
 emVPsay9iXjbRBEB+1AsbwsEwOwgLkC+i/vVlyszXYmaEXvDiAnA2jc3EtzrHzEVYgN6w==
X-Received: by 2002:a05:600c:4513:b0:499:5b0f:72b with SMTP id
 5b1f17b1804b1-499821aa11emr43142705e9.1.1786632055178; 
 Thu, 13 Aug 2026 07:40:55 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C00AE6C52CFC8961284.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:ae6c:52cf:c896:1284])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b58700sm66426445e9.9.2026.08.13.07.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:40:54 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marius Dinu <m95d+git@psihoexpert.ro>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 2/2] drm/rockchip: rk3066_hdmi: Add missing Kconfig selects
Date: Thu, 13 Aug 2026 16:40:19 +0200
Message-ID: <20260813144019.12089-3-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813144019.12089-1-royalnet026@gmail.com>
References: <20260813144019.12089-1-royalnet026@gmail.com>
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

rk3066_hdmi.c calls drm_bridge_connector_init(), but
ROCKCHIP_RK3066_HDMI selects neither DRM_BRIDGE_CONNECTOR nor
DRM_DISPLAY_HELPER, whose module carries the bridge-connector code. A
configuration with ROCKCHIP_RK3066_HDMI as the only enabled Rockchip
output option fails to link:

  aarch64-linux-gnu-ld: drivers/gpu/drm/rockchip/rk3066_hdmi.o: in function `rk3066_hdmi_bind':
  rk3066_hdmi.c:(.text+0x7a4): undefined reference to `drm_bridge_connector_init'
  aarch64-linux-gnu-ld: drivers/gpu/drm/rockchip/rk3066_hdmi.o: in function `rk3066_hdmi_bridge_atomic_enable':
  rk3066_hdmi.c:(.text+0xe74): undefined reference to `drm_atomic_helper_connector_hdmi_update_infoframes'

Select both, like ROCKCHIP_CDN_DP, ROCKCHIP_LVDS and ROCKCHIP_RGB do.
DRM_BRIDGE_CONNECTOR in turn selects DRM_DISPLAY_HDMI_STATE_HELPER,
which resolves the second symbol.

Fixes: 57d6811e8a6d ("drm/rockchip: rk3066_hdmi: switch to drm bridge")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 697c0748eeca..4e58685f58ff 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -146,6 +146,8 @@ config ROCKCHIP_RGB
 config ROCKCHIP_RK3066_HDMI
 	bool "Rockchip specific extensions for RK3066 HDMI"
 	depends on DRM_ROCKCHIP
+	select DRM_DISPLAY_HELPER
+	select DRM_BRIDGE_CONNECTOR
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the RK3066 HDMI driver. If you want to enable
-- 
2.43.0

