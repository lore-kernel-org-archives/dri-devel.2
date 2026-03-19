Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC84108E1F7
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5789310E9A0;
	Thu, 19 Mar 2026 11:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="YJug8NNn";
	dkim-atps=neutral
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch
 [109.224.244.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C05210E99F;
 Thu, 19 Mar 2026 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773921466; x=1774180666;
 bh=sEVl3HuB7ehM4vExON+7mh6z/VnbwN4gR3kLK+MIxl0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YJug8NNn1MFIYmrO+WS5olRPbVwpVsh9T02JEgnlcqqHIRy1DivoOkIZ4ny1ITNx+
 6fVsLiLIiLkY5gt7K43CKGm5GzBZXHkKQZ6AYfHhMN4XZX2ZjtoeF8Mve6nolpcSru
 1aaNsOJWCRBNGJ2eEf3OMu7O8Y9VKwOntQX9/OPOzwz3qWwWMAzIs6D76tSysomKTd
 B1+YtA4M2rbZ+x5NXpor1SUmtz5otoRnLGNNzKk5cLeS3gy+uA19bTfkG3cZBMPXuh
 QdBpvEBT7skqjvtanBlZCloGu+5vcP0BpBVpIpnVy6DeGXxxrsDPcv284fGDvKPp3+
 0hUEHedL7nVTg==
Date: Thu, 19 Mar 2026 11:57:42 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH v3 0/4] drm/msm: add RGB101010 pixel format and fix 10-bit DSC
 timing
Message-ID: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: eb0a5f7f6133b232632ff827dfcf3168d202003c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This series adds support for the RGB101010 (30bpp) pixel format and
fixes a DSC timing bug exposed by non 8 bit panels.

Tested on the BOE BF068MWM-TD0 panel (10 bit DSC) on the Nothing
Phone (3a).

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Changes in v3:
- Fix typo for MSM8998 DSI version name (V2_2 -> V_2_0)
- Add msm_dsi_host_version_is_gt per Konrad and use for RGB101010 check
- Fix up comment & commit message for video mode DSC INTF timing width chan=
ge per Neil/Konrad
- Link to v2: https://lore.kernel.org/r/20260318-dsi-rgb101010-support-v2-0=
-698b7612eaeb@pm.me

Changes in v2:
- Only allow RGB101010 if MSM_DSI_6G_VER >=3D V2.1.0
- Link to v1: https://lore.kernel.org/r/20260318-dsi-rgb101010-support-v1-0=
-6021eb79e796@pm.me

---
Alexander Koskovich (4):
      drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
      drm/msm/dsi: add DSI version >=3D comparison helper
      drm/msm/dsi: Add support for RGB101010 pixel format
      drm/msm/dpu: fix video mode DSC INTF timing width calculation

 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    |  9 ++++-----
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                   |  4 ++--
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                   |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                  | 21 +++++++++++++++++=
++--
 drivers/gpu/drm/msm/registers/display/dsi.xml       |  5 ++++-
 5 files changed, 30 insertions(+), 11 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dsi-rgb101010-support-4956b1cd8657

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


