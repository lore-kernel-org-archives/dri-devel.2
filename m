Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D95FB5EAA
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 04:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7D510E0C5;
	Thu, 19 Mar 2026 04:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="qzcGejuj";
	dkim-atps=neutral
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE21A10E0C5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 04:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773892801; x=1774152001;
 bh=qrz4dzTAVjEcyUcrosogifsPOSLN65jJ+X0IWxKIan8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qzcGejujJWayzGYv4JOp002Whxrgvg8ubcVDjnBGwLFdWxrUZrev+5RA5HZfOST8k
 O38tVJjjPJDRncK1jVWHNMfto536mi0RtwmwbWyXPPx7nx32lZDvHYOZLZVuNP1uxg
 Cq+M/+WiNe1ChZMkxtxcXKYpJix28szaEsIRjjtT0t6xAZJ2btXM2CCnBSxZIRIy4r
 VeMebWYVtXRMk6X4zfGIPJLssxxUE/1hYBBhWj8ovJHZ7qNfLmQXE/nV9MpNOcVMVn
 7OJuEx9zLReZDLpa1t9FfOUdnLUVZ/EmUWdbh9UUx0P23Ju8VKs66oxz+46YYNrSq6
 /1MuGbX5bGHcQ==
Date: Thu, 19 Mar 2026 03:59:55 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/3] drm/msm: add RGB101010 pixel format and fix 10-bit DSC
 timing
Message-ID: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 359fec2ca25f556ad8c79c68c43fed389c950c06
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

Note, I'd appreciate a comment on the INTF timing change from someone
at QCOM who knows the DPU hardware a bit better, this appears to be
what downstream is doing regardless of bpp, but let me know if there's
a better solution here.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Changes in v2:
- Only allow RGB101010 if MSM_DSI_6G_VER >=3D V2.1.0
- Link to v1: https://lore.kernel.org/r/20260318-dsi-rgb101010-support-v1-0=
-6021eb79e796@pm.me

---
Alexander Koskovich (3):
      drm/mipi-dsi: add RGB101010 pixel format
      drm/msm/dsi: Add support for RGB101010 pixel format
      drm/msm/dpu: fix video mode DSC INTF timing width for non 8 bit panel=
s

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++-----
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                    |  8 ++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                    |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                   |  9 +++++++++
 drivers/gpu/drm/msm/registers/display/dsi.xml        |  5 ++++-
 include/drm/drm_mipi_dsi.h                           |  4 ++++
 6 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dsi-rgb101010-support-4956b1cd8657

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


