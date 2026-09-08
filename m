Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB266C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFDD10E0C8;
	Tue,  8 Sep 2026 09:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oStquiTO";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C0B10E0C8
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:07:55 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc2276e6daeso3049870a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788858474; x=1789463274;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IMi1Y04Cowkyywav7yYVH94ClrmOV8qsvBcUcq9aXsA=;
 b=oStquiTO5XjFDzaFa8b+oeK8qG3HfSfXN0yeyRY5+6/1LEBScC4WBBpadzm5FHDMfT
 6ZrJiYP+Te2hacYsYNkKMEqLwg7sXbCBOB2gS3u2N1/jmMcPCx+aq0O4tmXM+kqIpu/Z
 ht20FP/LhVMyQ+w96PbFFYsueb0fQ4o7q+De0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858474; x=1789463274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IMi1Y04Cowkyywav7yYVH94ClrmOV8qsvBcUcq9aXsA=;
 b=E/Eo0rUokqVSb483iucNS8zt/7RgSCATLV1bTDaFqxx+GTN7fqDjHfqI7/7CokeLOW
 bwBgUCQff6a2QjA/8IvivPn3o9bRIbqGAcIc/rCT2bpzUFnxKoQEyvqjjsHup8STEkc/
 CvqdTdBtx6hEd6HFxz4kM6LWTNV8mzhj2UEHvthUyaTwRmORsmceqLx7dXsZC7gI2QEH
 bPPw5JzHupAT6gE8SD7TsxtXNEzYf+cmItG3M7fd/ZDYPpyOkdsCOooBo+5QIr7lscq4
 48Tar0XzuJRhu0jhvmAQXUV3AiMOW3ccKvO9KgPTcV3XmVkTMacaqntsoQlHWu1BT4gD
 g/TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByz11/B48EPS8a/vx8DwJm61wFnrG/vDRSp+E7fD+oAj7VYjI5rMWUKkBgWe6EiqGot5koSmzs5fl8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kb8rTr2pG5fpIqXsUWvLQOdR7V7fz0FPgNUrBdKYi+l9Ax/zI8
 QUi4pQudDvnQ5UAH3CQVbZU8T7LXKQgHlZ9oR6prpMo/vLUXLew+GfFee8XfeROk4A==
X-Gm-Gg: AYBFou0SxL0bMQOKQ32jkhsiWSGwTu5TRaHzFSC5xxH+1xb2AF6VrAbEtuIOltQAsFC
 XLljKa3XurHTTX8nRz2kO6BvzagStciKv04lsb5QQE6fz6Yj2q0GxDZ5ts3X+Mnzm6+O4jSB6QD
 3T2BBuac0vbIGPlgTITOYoEztoOV1/X8oxrsrpHg2O8MhicMp8vXgAdGDmkBC83LJdQ031A1Pqx
 aU5ZbmGF3YSDjRxsitMa1jnvrU7FPmY9Aohqae8ApmlUcPpyyHWxa1EehxzWXFIv+rekqxKWMy0
 O+rgX/3/4xITZ7aPQq+rcgZvVtm6z2n1PZg5IeCJ58ISA3vGCD1rnI3PMY7Ek1IYtDOLrBYBrrI
 fBAYZXThkXeWHYWiulzsHyR3bESIrRD8XQD/V9fPWlBZKYUi6EgpLqYwIOyt7QR74pesRr3VsGn
 Cwf3IxJ97o4K21kGWzjtcc0Rkz5FGB2+6MDI5TnmA7afuwAftcIg2jnE/AYDrfZKJBhv2MTAfdX
 nbB0y/h7qmgBqhavr3yuYeHhAo3LqrVn4++zLS3xd1pHMw=
X-Received: by 2002:a17:90a:d010:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-39b26272ef9mr45630109a91.12.1788858474627; 
 Tue, 08 Sep 2026 02:07:54 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:07:53 -0700 (PDT)
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
Subject: [PATCH 0/4] drm: Add and use drm_fb_dma_get_gem_clipped_addr() helper
Date: Tue,  8 Sep 2026 17:07:39 +0800
Message-ID: <20260908090745.1089143-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
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

This series adds a helper to retrieve the buffer starting address of a
"clipped" framebuffer. This contrasts with drm_fb_dma_get_gem_addr(),
which gives the address of the full buffer.

Some drivers program their hardware with clipped dimensions, so they
should be using the clipped buffer address as well, unless the hardware
can advance the scanout directly. (Side note: many drivers still use
the non-clipped dimensions.)

The sun4i driver was recently incorrectly converted to use the unclipped
drm_fb_dma_get_gem_addr() helper. This broke offsets into subsampled
pixel groups, but also exposed the mismatch between the dimensions used
vs the buffer address.


Patch 1 adds the new helper to return the buffer address based on
clipped coordinates.

Patch 2 switches the sun4i driver to the new helper, and fixes the
luma plane buffer address offset for subsampled YUV formats.

Patch 3 converts the imx/dc driver to use the new helper. This fixes a
mismatch between the programmed coordinates and the buffer address.

Patch 4 replaces the open coded buffer address calculation in the
imx/dcss driver with the new helper.


Please have a look.


Thanks
ChenYu


Chen-Yu Tsai (4):
  drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
  drm/sun4i: layers: Fix VI buffer address for clipped offsets
  drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
  drm/imx/dcss: plane: Switch to drm_fb_dma_get_gem_clipped_addr()

 drivers/gpu/drm/drm_fb_dma_helper.c    | 63 +++++++++++++++++++-------
 drivers/gpu/drm/imx/dc/dc-plane.c      |  4 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c  | 34 ++++++--------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 ++++++-
 include/drm/drm_fb_dma_helper.h        |  4 ++
 6 files changed, 83 insertions(+), 40 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

