Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F34CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253361136A3;
	Mon,  1 Jun 2026 18:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kGIUJ8ve";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0861136A3
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780336832;
 bh=f3hUMNFcEdyqeQuUHaPUg6wYaJ5ED/dmqbO5zRa5LnM=;
 h=From:Subject:Date:To:Cc:From;
 b=kGIUJ8ve3/hI+JQuzo60CZ83t7lc3FfA6ay+h3etetqrznxwIkEW4spp7rfFmdSxS
 IIv7VBp2eGjVhVm/YTyZT8BEfUnHxvLjzAqbUsr1/GrExPomvXqMvH82qdvSIHNWb9
 wqY021pJKPqh9Hb3VrKFL18ey8VV0zzUNIcHzqSuJhbX4H5FaIPUoivzYCqTQwgTAQ
 WmYQRU15/4kzc/xsz4J0C7OegRSQaNJfBDZRlcVDA0V2YHi/Z0p/0JOc3v2XF+hFHN
 7SFKpRa3AcWCLCk7Eb914qC2qHZCuevZdF8Kck/DrFFHmsFbI9HK5NhPOLKnPpAdMN
 iWK57FPpVIqUQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 62CF417E03DA;
 Mon,  1 Jun 2026 20:00:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/2] YUV support for VOP2 background color
Date: Mon, 01 Jun 2026 21:00:02 +0300
Message-Id: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZgyWgyuvIdh0ZYBapCSFhoJ4
 e4W3Lp8yfvvrxDYWw5wz1bwHG2wbkhApwxMp4aW0daJgQQVQtIVoxsJdYvLHDHXggslSiNvJaT
 F6Lmxn6P2rH4cZv1iM+2J3ehsmJxfjruY797/csxRYG10oSSVdGnkw7i+V9p5dTbuDdW2bV/F8
 53YvAAAAA==
X-Change-ID: 20260524-vop2-bg-yuv-1b0e6a09c579
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

Since commit bec7cbfa7d4f ("drm/rockchip: vop2: Support setting custom
background color") the VOP2 display controller allows configuring the
background color of each video output port.

However, this is currently limited to RGB formats.  When operating in
YUV overlay mode, the color must be programmed using YUV format.

Add the necessary RGB-to-YCbCr conversion logic, covering all color
spaces supported by the display controller: BT601L, BT601F, BT709L and
BT2020L.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Used vop2_convert_csc_mode() helper to address an issue reported by
  vcstate->color_space holds a V4L2 colorspace enum
- Rebased onto latest drm-misc-next
- Link to v1: https://patch.msgid.link/20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com

To: Sandy Huang <hjc@rock-chips.com>
To: Heiko Stübner <heiko@sntech.de>
To: Andy Yan <andy.yan@rock-chips.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Sashiko: vop2_rgb16_to_yuv16() expects an enum vop_csc_format, but

---
Cristian Ciocaltea (2):
      drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
      drm/rockchip: vop2: Add YUV support to background color

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 155 ++++++++++++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |   2 +-
 2 files changed, 140 insertions(+), 17 deletions(-)
---
base-commit: e84b07e0a30b371117f9a1120a4645c213f39cd9
change-id: 20260524-vop2-bg-yuv-1b0e6a09c579

