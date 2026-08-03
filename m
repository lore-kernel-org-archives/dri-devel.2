Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BE8C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD62610E6F0;
	Mon,  3 Aug 2026 16:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mBsGQQPM";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB46E10E6F0
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:11 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so19959205e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773470; x=1786378270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TkgRTuLVuCLYpIvdltmqBCjRKT4GYVnjKziTrqAUoEE=;
 b=mBsGQQPM6aT0hqDtbZK5mH5G1U1tmZyNd8Jv5uGdODWDEf/viHoP8fxQsCb7v1qQ9N
 VlTsr3ITASX5UArRTndcmGL6z52z3B/Rq884NDJvIpL/84SixXBai51ZgTp9Gb/0yr9R
 Q4IJuampyJ6K92UgsVNCPPsgyB7u4J6Ws86IxxCMFJk823rZiKMoDY9Bchq+G8k3kz8N
 zN2DiIPHggBXkeaRG4WT/oBG3vUWuugQGqpAatQd3sXO83s74dTNAens28572dsOX0+T
 ElMQW+OQCmH8NnLlEvtiXAOHKp+LOMhxm5LZyukzS+32q4mJw4Ct+dM2G9VLwHNIxn6/
 eQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773470; x=1786378270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TkgRTuLVuCLYpIvdltmqBCjRKT4GYVnjKziTrqAUoEE=;
 b=aAlzbymDKC1vFvPjUbN9axRzMIw5JWWPa53hfcxNeN658bZKtpLRoQq4JgRGhjTpQo
 lBn27LTAejNHrCuy/+yC1qPz8wPgttEQ15nWwPaq044oopR3RvFkRShPoMBvN6YJGsYb
 +q3kVKjkGi06XSfm2Bhphqs3zckwi0MX2Wa8FWtTUb4J+f00j+EM1yCYPd8VyWrL40uj
 7klSI7BG2ZDJrfxo/2/vYkONjl28QiQ7JHXZE+1XWaWuVGQXbQv0vtm+LDXZiAPYOarF
 u5fWbcZJrJJrGLaiKeSCrcoCwXc+qSbp1cp6z8jtKGMwQmvzabUhPQ9FggX9Y/CbIZa3
 LuaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rob6XP/BU4ZR0mP+ZnL3ARDC9BZ1R6r9xY+ttFQXt5q4rnWYfoJlrFiC3eQy6mOymtq1A7bvx4g55E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNd0DYuaZfJfPOKfHDJg5xrOik94X/O8G/2Bk4hoW4R6CmTcJj
 zIpaq7LTDDtbWQSjFGAW7NYMQBqo8pR8dIaYaox9AvlLPi4fd6IXjtsz
X-Gm-Gg: AR+sD11f7kPjWRveHNgUFNNrEZg3VSb9CXKuRtkrbwUjJwPq46ZV2KMU1v6Vf5sq08H
 ie8/DukxomWnQW2Ebqj9fw5W0FatJ8bS0g0f0VUjRtGomwA60y06ZY2E2LfzxknJmh+0BrnLVNy
 FDSLkyl9tpRrpNPx9lP3lqCU1g3CPEmlMqlCPST0kr41MpCxbnnUMOPXuiIxDRtacgQNvWdKJmY
 UN/+KUbbvEhR0jDF22Q+0YcyyHs/omN3Mn2NLZZ3o90DNRJEbayQN0EIR/yYyL23DXH3+hvaOts
 AcpTNhEAjXoBO8QFtlmfY2OVTjk08SN9EUZdK+4L+lvv6fq1ErvBsk/QnK9c51hImw/J4Z91lap
 al25WaWZtnAdKCLcx5iyBoKjHKl7t97Qtg5zXOJhy6qGYx26s72bXMivCG3funF0kyXPw601zgP
 3Xw0fZR2OfjOzU9x1JJwI1d0nQGj7TdF4mAOmrHlkcWxI4WzM9b3RL/hohsz3bMqeGqsYp1boMf
 8YehypVfyuBqALgJ9Xkuyu2dC6OmKWyu5J9RdGwV0VpcFLlQeXCsZ0Y9W8dnH3GU3wPYCYkutqI
 ZZS+5ZbIRTBMQVRXhXG3E5rlUx1ayeg8Ub3U8bviWuj/sdFR9gnSsRZe+3t8GV4SqJN449cQh/b
 4FJCWlxDjqKz8SD9kdE7s9xWvDSC+/xbup/SzwVz8fGjQ2OB65SCZsMSp5+ihtH5hR3vfZiEOTC
 aisA==
X-Received: by 2002:a05:600c:468e:b0:495:4b42:8677 with SMTP id
 5b1f17b1804b1-4980c6a2268mr222728085e9.18.1785773469919; 
 Mon, 03 Aug 2026 09:11:09 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:08 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 00/13] drm/sun4i: Assorted display fixes
Date: Mon,  3 Aug 2026 18:10:38 +0200
Message-ID: <cover.1785770165.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series contains fixes for issues found while working on the DE3
and DE33 functionalities, used on H6 and H616 SoCs.

VI scaler and VI layer:

- V3s advertises a 2048 pixel YUV line buffer, while it only has half
  of that, so wide YUV layers end up corrupted.
- Vertical scaler coefficients were picked based on the horizontal
  scaling factor and chroma coefficients ignored subsampling.
- DE3 mixer initialization clears the whole register space, which also
  clears the scaler global alpha. Since video mode takes alpha from
  that register, subsampled YUV layers are fully transparent.
- Since the conversion to drm_fb_dma_get_gem_addr(), luma and chroma
  plane addresses no longer describe the same pixel for odd source
  offsets, which the scaler can't handle.

TCON TOP and TCON:

- Both mixer selectors reset to TCON 0. If both mixers end up selecting
  the same TCON, output is black or corrupted, so park the other mixer
  elsewhere.
- DSI and LVDS never called the output mux setup, so on D1 the mixer is
  not routed to the TCON driving the panel.

HDMI:

- sun4i_hdmi_enable() ORs stale video timing polarity bits into the
  packet control register, so the AVI infoframe is not sent for modes
  with positive HSYNC polarity.
- The 594 MHz 8-bit MPLL entry doesn't lock on H6, so 4K@60 8-bit
  doesn't come up.

The rest are an error propagation fix in sun4i_crtc_init(), which
otherwise oopses later on, and four patches fixing OF node and device
reference leaks, two of which accumulate on every mode set.

Tested on Tanix TX6 (H6, HDMI up to 4K@60) and Orange Pi 3 (H6,
TCON_LCD0 and TCON_TV0).

Some of the issues were found and/or fixed with Claude and GPT.

It would be nice if anyone could test V3s fix before and after. Testing
other fixes would be nice as well.

Best regards,
Jernej

Jernej Skrabec (13):
  drm/sun4i: Fix V3s YUV scanline size
  drm/sun4i: vi scaler: Fix coefficient selection
  drm/sun4i: vi scaler: Restore opaque alpha in video modes
  drm/sun4i: tcon-top: Keep mixer routes distinct
  drm/sun4i: tcon: Set output mux for DSI and LVDS
  drm/sun4i: tcon: Drop TCON TOP device reference
  drm/sun4i: hdmi: Don't leak sync polarity bits into packet control
  drm/sun4i: crtc: Propagate layer initialization error
  drm/sun4i: tcon: Drop remote endpoint reference
  drm/sun4i: dw-hdmi: Drop TCON TOP port reference
  drm/sun4i: Drop node references while building component list
  drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz
  drm/sun4i: Align VI buffer addresses for subsampled formats

 drivers/gpu/drm/sun4i/sun4i_crtc.c      |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c       |  3 ++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c  |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c      | 22 ++++----
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c   |  2 +
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c  |  2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c     |  2 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c  | 71 ++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h  |  6 +++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  | 20 ++++++-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 20 ++++---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h |  1 +
 12 files changed, 119 insertions(+), 34 deletions(-)

-- 
2.43.0

