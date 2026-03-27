Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9710AB839
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF9210E283;
	Fri, 27 Mar 2026 00:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ryy9Qe44";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDED610E31D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774572932;
 bh=tziTw9WjJXg9ysB8nqoQ8JdDk/cS9+M+QzzINfFb2ic=;
 h=From:Subject:Date:To:Cc:From;
 b=Ryy9Qe44pyXOT9TY7RhEmOPZV/qkiBk8JmgCAQCUtANUhBp63shZkIsdOadLIw83N
 AlhO8/HS89QoeRPg5UXO2wwKmYtBI7Vn3pna0g1dRqHptl60NiBYVCHsy7POpR3+VE
 3pFW7vkOH6JWq5zPQVq6PNayRdfoSVWBZh0rAL7bmbrg0Pzw3NfiG0cZ+E6jtT4Riu
 7K+43U4RArQyewtZ44k4RGfB/LxWLQbRLQLLciiJ2Uv976I5HLF+iQRQKTAtqHjGLm
 LbBMC7/3TCr0b8EKOl8GdQOpo90X8PBYtYTjgUpjAogAhfdbrVYaEAxkuYKHuq2vf/
 p9MffmRwpBQJg==
Received: from localhost (unknown [86.123.23.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2356417E5D08;
 Fri, 27 Mar 2026 01:55:32 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/2] Rockchip DRM use-after-free & null-ptr-deref fixes
Date: Fri, 27 Mar 2026 02:55:06 +0200
Message-Id: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ7CIBCF4as0rMXAAK115T2MC0oHS2yLAUM0D
 XeXdmPSxOU/k/ctJGJwGMm5WkjA5KLzcwlxqIgZ9HxH6vrSBBjUjAPQPkw0PKh1b4xUNzWAabh
 SAkmZPANuj7K43koPLr58+Gx64uv1D5Q4ZVS0Eiw/qUYxvBg/jrrzQR+Nn8iKJfgBgrMdAAWop
 UJjOymsbPdAzvkLVHg+LO0AAAA=
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
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
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

---
Cristian Ciocaltea (2):
      drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      drm/rockchip: dw_dp: Release core resources

 drivers/gpu/drm/bridge/synopsys/dw-dp.c   |  6 ++++++
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 20 +++++++++++++++++---
 include/drm/bridge/dw_dp.h                |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)
---
base-commit: 46c31e1604d121221167cb09380de8c7d53290b9
change-id: 20260122-drm-rk-fixes-a7622c71553e

