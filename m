Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC440CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4690F11356E;
	Mon,  1 Jun 2026 16:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="h95Ovt9v";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7744211356C
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780330443;
 bh=aaEpI9GXRz3EZr4yshfNJTwzGYvwXpQNt8splWEouIY=;
 h=From:Subject:Date:To:Cc:From;
 b=h95Ovt9vxHfhP69JU5VlaXfKvtrXpGwFxoAa8Vw127ZPodNDTXGRZj0GsmTFroLT+
 zjHXPtnm/VDLWYM6vr3R9awCwZm4gulwulHl02nrt84lDPQEnkIEP6uW9PC2RrgLTH
 sHAi+kA259VUJP2x78xF63bLtj6XXDmzCrWPS6XoCB2kFg9M2M2pI+swqoexCoq2jp
 QWScb3SY6SuPinuXN721ZQ1AZXK2iQ/O8+t7MsmHOwXijMg13QRDNsnRsJINEqNmFu
 ajSWOj2lHuJPuxUFhwF4SNfrCcVo4E6Gwccz4eShtexHodUGVvA8sz+fz8cSJzuRKx
 k/kS8KrZVwKvQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E7E2417E045E;
 Mon,  1 Jun 2026 18:14:02 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v4 0/3] Rockchip DRM use-after-free & null-ptr-deref fixes
Date: Mon, 01 Jun 2026 19:13:43 +0300
Message-Id: <20260601-drm-rk-fixes-v4-0-c3f3f123e1da@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMTQ6CMBCG4auYrq1pp3/gynsYF1Cm0gjUtIZoC
 He3sNEQXb4z+Z6JJIweEznuJhJx9MmHIYfc74htq+GK1De5CTDQjAPQJvY03qjzT0y0MhrAGq6
 UQJIn94jrIy/Ol9ytT48QX6s+8uX6Bxo5ZVSUEhwvlFEMTzZ0XVWHWB1s6MmCjfABBGcbADKgp
 ULraimcLH8B4gsAswFEBlwDqEvGLCvsFpjn+Q2k/8Z4LgEAAA==
X-Change-ID: 20260122-drm-rk-fixes-a7622c71553e
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

The first three patches in the series are fixes for use-after-free &
null-ptr-deref related issues found in dw_dp and inno-hdmi Rockchip DRM
drivers.

The following three patches provide a few minor improvements to dw_dp
and dw_hdmi_qp, while the remaining two address use-after-free and
memory allocation in DW DP core library.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v4:
- Collected R-b from Andy
- Fixed a conflict while rebasing onto latest drm-misc-next
- Added new patch: drm/rockchip: dw_dp: Add missing newline in
  dev_err_probe() message
- Link to v3: https://lore.kernel.org/r/20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com

Changes in v3:
- Dropped patches 1..6,8 already applied by Heiko
- Reworked remaining patch "drm/bridge: synopsys: dw-dp: Unregister AUX
  channel on bridge detach" into:
  * drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
  * drm/rockchip: dw_dp: Release core resources
- Link to v2: https://lore.kernel.org/r/20260310-drm-rk-fixes-v2-0-645ecfb43f49@collabora.com

Changes in v2:
- Fixed conflicts while rebasing onto latest drm-misc-next
- Added two more patches:
  * drm/bridge: synopsys: dw-dp: Unregister AUX channel on bridge detach
  * drm/bridge: synopsys: dw-dp: Drop useless memory allocation
- Link to v1: https://lore.kernel.org/r/20260122-drm-rk-fixes-v1-0-3942f185750e@collabora.com

To: Andy Yan <andy.yan@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sandy Huang <hjc@rock-chips.com>
To: Heiko Stübner <heiko@sntech.de>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org

---
Cristian Ciocaltea (3):
      drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      drm/rockchip: dw_dp: Add missing newline in dev_err_probe() message
      drm/rockchip: dw_dp: Release core resources

 drivers/gpu/drm/bridge/synopsys/dw-dp.c   |  6 ++++++
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 15 +++++++++++++--
 include/drm/bridge/dw_dp.h                |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)
---
base-commit: e84b07e0a30b371117f9a1120a4645c213f39cd9
change-id: 20260122-drm-rk-fixes-a7622c71553e

