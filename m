Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6675C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA8710E03D;
	Wed, 16 Sep 2026 03:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YbTk2YMU";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E28710E03D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:33:37 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so418659a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789529617; x=1790134417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WW23/p8j1VrlcRbF/FlA+rOMTRyOj5YVS3I8yZ6IEcE=;
 b=YbTk2YMUkuA2ecLvqJ16HA6NVkZLALAlbcjFUwDC/+Samo0QJSK3xByc/QUaLsGUew
 mjiWqvQ+oK7t5x/iz4kM+08ReCMjN8yjnOsKDW0ngGVxkWF+IGheCEtczZ2oHnrvkeCy
 Q224ZFGpuM6s7i9GK+7R8fKVrgllx6CVIup4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789529617; x=1790134417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WW23/p8j1VrlcRbF/FlA+rOMTRyOj5YVS3I8yZ6IEcE=;
 b=GhnhBDRxPz+XKToCit5EUT6Vm8Ehs/X9eRpQzT4WrcNn4vzu74jluI1tGFOVjN7yio
 rBMV/MVGfi1oykZA24VAPD3lYbVMnMTn9pZDIBwU/BJFzf/T3ALxlKxpVJodgVOZ/WxS
 QSgWP+YIEIPLCGUKycvLi2JoY55dbhNHaQzCHIXXOHp5aIGyOWDyQ4iNKCJpq0jYYVQZ
 vY6/8Gy6z/yK6xXvTD9sK3Jc8o8Ewe9V+uE0a1hWxu6w9rfeUfYNE8U6lgmVIUC8znwK
 WhOAWJBOFiGZB2w5ZN+D2sXPo0MrAxa9YNLU3LBHwnRglTEvkfG76L4ET2+vAhWwAPWB
 N/FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQwZfDc3MDbZGEovw1K1EsSeK5yJh2qGc93IQKeTbYEaqLFyC4MwYL2RJY9AzVHUBDoMIqJSfmw8Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m07KzqzDYMDdEGUL1BiGkjhHy0z8ER8GH2MB/MARGPXghT69vn
 CanwVrGl2QcItWgtWQxIajN59FM43VobAr+KSJQa0PcP+9npii+MSFyDlhbq5kpYQg==
X-Gm-Gg: AYBFou2I4KdW7bNUaaG36eYDTo1uIfXx6/1SFJzyWaI3oYVY08B0NB9yw5S97BM8DXp
 dWWT2naeqHeRDO7QIagG69C73HywghTCG2DIT/NlP77WPBstCTS2RDWbYkISYUmGdbGHfC9CaTf
 rffDOyeLgDHRTMI0BFkHpTLvpB+i6dLapeMboVOgHZQYRXwSoNL+NooNTJOYKEXwC9+PVL2rfeg
 GxP667fXH2ThXx1YanwJ0Ny3/0AjmW0QunscmlNTj2JeqKhN6NKvBaeXgbxs5lkZpJmwSCCBu3d
 sekBmNSBwyWILo6VDl3zwIJuDxq5yH0PDEG4af4+04KAbLKWTTnA8LnDpZJPx2YTx5lcy5Jz1zf
 iZjQkPPRxEuZuFnDiTS24nLL3lFh3iDSfj7KFUROq5X1iNCHc/64kVq7yqnzpP5tlj7I/pq+8VY
 5SdOkVsneZsTlaSPWfNk+JWk9i3QEzu1OqsSsULUsBIXQ+naULbJtGZCWDhaTAd6MWI5ybu0Hge
 iZaioy+AWNIPfJjSfSwTiWbKdTOcnw+aHeByqlPnfx0hsvizyqvmn5xIg==
X-Received: by 2002:a17:90b:224b:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39e1e4246f7mr2337951a91.13.1789529616959; 
 Tue, 15 Sep 2026 20:33:36 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 20:33:36 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFT v2 0/5] drm: Add and use drm_fb_dma_get_gem_clipped_addr()
 helper
Date: Wed, 16 Sep 2026 11:33:21 +0800
Message-ID: <20260916033327.3054126-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
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

Hi,

This is v2 of my drm_fb_dma_get_gem_clipped_addr() series.

Changes since v1:
- Add and use new drm_framebuffer_get_block_offset() helper (Thomas)


This series adds a helper to retrieve the buffer starting address of a
"clipped" framebuffer. This contrasts with drm_fb_dma_get_gem_addr(),
which gives the address of the full buffer.

Some drivers program their hardware with clipped dimensions, so they
should be using the clipped buffer address as well, unless the hardware
can advance the scanout directly. (Side note: many drivers still use
the non-clipped dimensions.)

While at it, also pull out the offset calculation of drm_fb_dma_get_gem_addr()
into a separate helper in drm_framebuffer.[ch], thereby separating
responsibilities.

The sun4i driver was recently incorrectly converted to use the unclipped
drm_fb_dma_get_gem_addr() helper. This broke offsets into subsampled
pixel groups, but also exposed the mismatch between the dimensions used
vs the buffer address. Two other drivers were also touched.


Patch 1 adds a new helper to return the byte offset into a framebuffer
for the start of the pixel block of the given pixel coordinates.

Patch 2 adds the new helper to return the buffer address based on
clipped coordinates.

Patch 3 switches the sun4i driver to the new helper, and fixes the
luma plane buffer address offset for subsampled YUV formats.

Patch 4 converts the imx/dc driver to use the new helper. This fixes a
mismatch between the programmed coordinates and the buffer address.

Patch 5 replaces the open coded buffer address calculation in the
imx/dcss driver with the new helper. Existing behavior, which might be
wrong, is preserved.


Please help test. The series is only compile tested on my end. The sun4i
changes should revert its behavior to before the drm_fb_dma_get_gem_addr()
was adopted. The imx/dcss changes should not have any behavioral
difference.


Thanks
ChenYu

Chen-Yu Tsai (5):
  drm: Split framebuffer pixel offset calculation from
    drm_fb_dma_get_gem_addr()
  drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
  drm/sun4i: layers: Fix VI buffer address for clipped offsets
  drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
  drm/imx/dcss: plane: Switch to drm_fb_dma_get_gem_clipped_addr()

 drivers/gpu/drm/drm_fb_dma_helper.c    | 61 ++++++++++++++------------
 drivers/gpu/drm/drm_framebuffer.c      | 45 +++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-plane.c      |  4 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c  | 34 ++++++--------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 ++++++-
 include/drm/drm_fb_dma_helper.h        |  4 ++
 include/drm/drm_framebuffer.h          |  3 ++
 8 files changed, 118 insertions(+), 51 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

