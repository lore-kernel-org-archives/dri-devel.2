Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13CDC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D601710F384;
	Thu, 13 Aug 2026 14:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxPD7bUe";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7161610E42B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:40:55 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47c2ae992beso169761f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786632054; x=1787236854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rW6YbGwCwODCemZSHGPE83tUot0DKF5hC6yD4MR3y14=;
 b=hxPD7bUetcwHQ/ddoACjYMy9+t3TXp6nmxp4uvoK0mlSbVtpJWNwEIGbevwHvBKDtI
 pCpOFls0Kbko0PfUuM15r1E/5CMnVC9aAZaFqsarTY5S1kAR1k0RS6yS8eW7VgDxSgGY
 mkxgQho63jbowQd4E9LzZNWPwjwvun1QWVoAgF67zt9p/mlkS3OGOqLfBgqKC0iGasfv
 hGbm1PEyNzj7aPmCrdoz0ZwY2+yP19LKMvXMaQiYhROHg2anwTOfZWhpc5fvtIBxYFQI
 Zyk0F/js346nYyoldTb+l9iGy+6QsG/Nn+saZPS5ZA5mCaKmWpXaXLeP7H42oaDEHEHr
 eEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632054; x=1787236854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rW6YbGwCwODCemZSHGPE83tUot0DKF5hC6yD4MR3y14=;
 b=p3f5tifDw00A/D3omtbdnCrfGMacPq81VbNcxiqug4MhCHfcZHEIF0lMKfad9KqSpf
 kWHjoFd8cDCA3C/i8SCOakYN7sIYts4TKJRP50uEaCxHfctiqmHhXtY2HvxCDUUSGIiR
 +YcGhElEfESBki5lx/mFesu/UEmEUf/1k0Y/SrVbk+mD3XUtUdfZm5+mCBJ2IDhwSPi8
 JkvyqFK5YcFqu7jIuOXa3Rs8RsoBVxh7VXD07wzYvMa9aFdQyB+H3M5ju+z+gK2LQfmJ
 G49zxjXYw971d7/ZIBrbQR7l7YhcYnv8AjM/+WpX3b8GDwexbqdA5L0/DB+UmAKPsCc7
 od/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKO25ACzKwj/Yuq6XSL/bUNA8Dme/3FB9lN+QveSH7q8ZxXFnlrMOWQwAgX3kcKB1GkEPUfuRA5R8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyftCQmDDDfEaTeopdBADEeGi9JmiEPhfC0Redg8pk45dUijSH3
 eqQZAaoeU9d61CyGBljc0CoTw4jHTHR6oF1Hq0MSe65ItoB3mOwCr6PF
X-Gm-Gg: AR+sD12H49mykpDzyLVXTHqt8enEUVWN2d4Y/Z67YP1TC5syfagai66twKZEbE95wRo
 3+qSEvuHh0KVtLks0269uATWgZTBWtf4NXb/gXRilQUjmubE3bGTpn5xxVf6e2TC3URGd0oVkbK
 uaJP01m8l5u3pANrxrhppsxKN/HVat6A9lrX8vioesRhKOLISs6HWpkuf7Yc5ftdFk3QioXO/g8
 e8i5JCYCLcfkr0y6t9f4xXLs9ouc1WJcy622DhRCj9DyTcOEho98JNuU+W0wPHpCi7xL1wblPGQ
 Le5PtAHCpQm+A9fv7FnGLozfQe4Ux0K2lnNQ/UFf8nw8HYRJkinQhSEa7rugNsTSP9PJO5p5Z8E
 jYvJj0cx/iWTeH/aOKYx6mEpOvzUyzB5N2jBRhhSH+UwUirYpvM3wCkdaedNR2xkdi/CzKbY1eJ
 9oCBL7WSejJ9jdBzDBaNgJy5WATLPK3ZkfgU3ldU7Q+O9eNDcn9PkQZzUJjaG73Hr15o39bxv3p
 ssEiZyUiz9yJC80GrhKylyT+qNSfFynyNY2Lsq5dfyiJ7qI5QaOxCsMzPelLZ7+0I5zEA==
X-Received: by 2002:a05:600c:4443:b0:499:73ca:c419 with SMTP id
 5b1f17b1804b1-4998265873cmr41318505e9.4.1786632053713; 
 Thu, 13 Aug 2026 07:40:53 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C00AE6C52CFC8961284.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:ae6c:52cf:c896:1284])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b58700sm66426445e9.9.2026.08.13.07.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:40:53 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
Date: Thu, 13 Aug 2026 16:40:18 +0200
Message-ID: <20260813144019.12089-2-royalnet026@gmail.com>
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

dw_dp-rockchip.c calls drm_bridge_connector_init(), but ROCKCHIP_DW_DP
does not select DRM_BRIDGE_CONNECTOR. A configuration with
ROCKCHIP_DW_DP as the only enabled Rockchip output option fails to
link:

  aarch64-linux-gnu-ld: drivers/gpu/drm/rockchip/dw_dp-rockchip.o: in function `dw_dp_rockchip_bind':
  dw_dp-rockchip.c:(.text+0x1d4): undefined reference to `drm_bridge_connector_init'

Five other Rockchip encoder options that call
drm_bridge_connector_init() (ROCKCHIP_ANALOGIX_DP, ROCKCHIP_CDN_DP,
ROCKCHIP_DW_HDMI_QP, ROCKCHIP_LVDS, ROCKCHIP_RGB) already select it,
which masks the gap in any configuration that enables one of them.
ROCKCHIP_INNO_HDMI is covered through its DRM_INNO_HDMI core option.

The same change was posted by Marius Dinu in March and dropped when
the failure stopped reproducing in his build. The failure is
configuration-dependent - any other enabled option that selects
DRM_BRIDGE_CONNECTOR hides it - and it still reproduces on current
drm-misc-next with the configuration described above.

Select DRM_BRIDGE_CONNECTOR like the other users do.

Fixes: d68ba7bac955 ("drm/rockchip: Add RK3588 DPTX output support")
Link: https://lore.kernel.org/r/aneNCDU12OzG99UX@venus # ack to handle this apart from the dw-dp series
Link: https://lore.kernel.org/r/20260319155051.1944-1-m95d+git@psihoexpert.ro # earlier submission by Marius Dinu
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index e7f49fe845ea..697c0748eeca 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -68,6 +68,7 @@ config ROCKCHIP_CDN_DP
 
 config ROCKCHIP_DW_DP
 	bool "Rockchip specific extensions for Synopsys DW DP"
+	select DRM_BRIDGE_CONNECTOR
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  to enable Synopsys DesignWare Cores based DisplayPort transmit
-- 
2.43.0

