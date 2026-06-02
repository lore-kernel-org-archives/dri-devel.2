Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6867CD6E69
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C4A10F61E;
	Tue,  2 Jun 2026 22:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="Ugz7tmj8";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF1710F299
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:01:19 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so4228394f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780419677; x=1781024477; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ivGt1S0OiiOp249bVc4Q7TnMYrm/Fs6AUzb1TqWbuUM=;
 b=Ugz7tmj89onfKFV6QnBLAVne6PlVMlUmyg5XN6nFmSRThVALyYJLGRnkj8Mz2D2lP9
 LS3sTtnlbhl2z20IBi3Gw0StTQYU+8deYTUlxB0rrK33bYwj0Qd/9wa+xJ73vWmEzBVx
 O36XkCHHTM+5lujvlb0iPkRgL6LmHFfEYs6coa7zU6Hh39EI914IDwQKHzqvBCpOG6O8
 Baod0j90S2RHsahPMxT6LLueOy0p+gHO8Eu64gUoupeMGmrPpnDC9ZCmVHkS7J/ycEuF
 Meq0xULCJk8Sp9lqzlmVDUaNnfQGB8zXa0Hj/NHNfIFJOoB4XjVv4S4fjktV6urlSSLH
 tDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780419677; x=1781024477;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivGt1S0OiiOp249bVc4Q7TnMYrm/Fs6AUzb1TqWbuUM=;
 b=f64EguqEgJXp4f/SgEzFxtgDKYl/OGoPmKkBAYiIIt4R75uTG5hg1BU62aVJfZHN0+
 wvbALkSqjaZylN33w/57JcDkJj3YIlYsLKkMbe/vs495AggO5B+zXfal1fgcf0mufYwN
 oPWAHf1hFuyOf75edBvYi+6gX2NT75Dy54EsquoASzE5MI/UKUiH/tG2Ur4plen89q7+
 pHe2jnOBycJwlMoU0+o0tcls/3D8+Jo4+dGTsL4qC56xs4kUeUuraA0xiflbcUTUjii/
 kt7eUT4+pn/dKfxHsIsI0Ol00JX/+3oZWHWqunVf29ibtHUzd3biaD51iy9akk8thUv3
 rUuA==
X-Gm-Message-State: AOJu0YwKYj5g++39juScZUTgSpcs/laNxyu0O7Uya0+rJyIibIY21VLW
 K8Csmv4yo7F5409pVh6QWte1Bhcm3K+SYC+CaC7Jx1zhCyj2vrAKF8+OmfaJashDq38=
X-Gm-Gg: Acq92OEsH/+Ppi2LuSQ3289U12DEWko2ngNqpvcWx+muo2Ab/p7/TZfPpvG0182TTQp
 MxgrOV+G7+DwA3quIz3LkN30mUHnqGnIw21FdruaxNWZYb05xcfSryI8Jm/E4K50Pwud1Jz4ycS
 Eucb0Z7RRnMfEAz1r8MD76c3OBzJdlUGM5iMfUk7C8z8Jd/AKtuGxshFN7ecrJ33IK1wq/Lb5Lz
 47ahs1NBmWo41IDuYmJ+EEpx8qMOc3P4DkPsnuoC6twZ6ffl8lmBfkE9mxjVliOiNIiGhPIuy/b
 p7/+GN0tuzsLfqO4Kv5+G8g6+gqcbhiXUvso4351QD3NprBOiknenRJII7LFwgwIOG2BG5NA/W9
 ivTZlwmyeOq85UxgDqXhvMWT9v3ZUnEw65FkTaV1Zjk10XzssvhpjdLP4eF+E/EYPQSSPPvMIGi
 emdkREo3MO6tYjZISjlN2oPRJbPycsIcLEYABedktVcAxhatWwXgQ=
X-Received: by 2002:a05:600c:1384:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-490b50c2008mr8721775e9.30.1780419677363; 
 Tue, 02 Jun 2026 10:01:17 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm588495f8f.8.2026.06.02.10.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:01:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/2] drm/rockchip: dw_hdmi_qp: Add support for HDMI
 overscan compensation
Date: Tue, 02 Jun 2026 21:00:38 +0400
Message-Id: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADYMH2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMj3YyU3Ezd/LLUouLkxDxdkzSDFAvLpLQUSwtDJaCegqLUtMwKsHn
 RsbW1ADtlkBpfAAAA
X-Change-ID: 20260602-hdmi-overscan-4f0d89bfd981
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=alchark@flipper.net;
 h=from:subject:message-id; bh=mr+rOHka+rwyOFfzI59/eJ3S3PjIo4G5+vOSklSi9WQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJ8/gmM7HPdFlsfzlmuwfbuhvmzJMVmc2YUs1tgi/oO
 8eE7DPtmMjCIMbFYCmmyDL32xLbqUZ8s3Z5eHyFmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKoXNzD84b59tIy5/sjtcxN85I+zlATPjdlpnNfjarprsWnEVN9IM4b/CY+3igg
 9Tl5w0PjVp7Up58/IFnm7Mz14lfc74wsjU1IQOwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 02 Jun 2026 22:31:15 +0000
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

When using a TV as a display, output image may be cropped due to overscan.
Rockchip VOP2 supports post-composition scaling in hardware, which can be
used to compensate for the overscan.

This adds the necessary pixel margin fields to the CRTC state, and sets
them from the TV overscan property of the connector which is understood
by the userspace (tested with KWin's display configuration module).

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (2):
      drm/rockchip: vop2: honor TV margins from CRTC state for overscan compensation
      drm/rockchip: dw_hdmi_qp: expose "overscan" property

 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h    |  2 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c   | 17 +++++++++++------
 3 files changed, 29 insertions(+), 6 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260602-hdmi-overscan-4f0d89bfd981

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

