Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0595108E1F7
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6552C10E9A1;
	Thu, 19 Mar 2026 11:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="IKIt3sAG";
	dkim-atps=neutral
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57A210E9A3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773921473; x=1774180673;
 bh=mEBBmmKkewV68WUhcRxlXKoX+eqcn8AWTduVHXPX4BA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=IKIt3sAGOeIxPaCMUocRU+SoP7Tx2/8Gy90HmLHwY77ezeexR36SxfYHixGsqX2tO
 NA6suNR3LDNdRVz7vXnaAS8rYKE0cj4P+a7FXE3M9sbc1K5hBNOxKRTf00u0kh9FtH
 VhBouK/lPLslmWCqS5c1ydNeMN9Pw28k9zmhBZ7IrJOr61yeHEQ6r8DFYArWu0GxTR
 hZri0iMjdqDL7x1i6ETzLTq8wAWYSgM4tULTbGiJf5htR3Xx8Z942dUoRvDCiL5EEP
 /vLGAilJhB6igsMqCuGvCWV1gGe7QfmhDBQNmygw46rcrmEJ12dBEdtEuKqyDKVMyS
 1Vz13/mIRTArw==
Date: Thu, 19 Mar 2026 11:57:47 +0000
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
Subject: [PATCH v3 1/4] drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to
 V2_0_0
Message-ID: <20260319-dsi-rgb101010-support-v3-1-85b99df2d090@pm.me>
In-Reply-To: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 2976adefa00dd9004104e9d67642b07ae93d6130
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

The MSM8998 DSI controller is v2.0.0 as stated in commit 7b8c9e203039
("drm/msm/dsi: Add support for MSM8998 DSI controller"). The value was
always correct just the name was wrong.

Rename and reorder to maintain version sorting.

Fixes: 7b8c9e203039 ("drm/msm/dsi: Add support for MSM8998 DSI controller")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 4 ++--
 drivers/gpu/drm/msm/dsi/dsi_cfg.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/ds=
i_cfg.c
index bd3c51c350e7..da3fe6824495 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -317,10 +317,10 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handl=
ers[] =3D {
 =09=09&msm8996_dsi_cfg, &msm_dsi_6g_host_ops},
 =09{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_4_2,
 =09=09&msm8976_dsi_cfg, &msm_dsi_6g_host_ops},
+=09{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_0_0,
+=09=09&msm8998_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 =09{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_1_0,
 =09=09&sdm660_dsi_cfg, &msm_dsi_6g_v2_host_ops},
-=09{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_2_0,
-=09=09&msm8998_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 =09{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_2_1,
 =09=09&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 =09{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_3_0,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/ds=
i_cfg.h
index 5dc812028bd5..ccf06679608e 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -19,8 +19,8 @@
 #define MSM_DSI_6G_VER_MINOR_V1_3_1=090x10030001
 #define MSM_DSI_6G_VER_MINOR_V1_4_1=090x10040001
 #define MSM_DSI_6G_VER_MINOR_V1_4_2=090x10040002
+#define MSM_DSI_6G_VER_MINOR_V2_0_0=090x20000000
 #define MSM_DSI_6G_VER_MINOR_V2_1_0=090x20010000
-#define MSM_DSI_6G_VER_MINOR_V2_2_0=090x20000000
 #define MSM_DSI_6G_VER_MINOR_V2_2_1=090x20020001
 #define MSM_DSI_6G_VER_MINOR_V2_3_0=090x20030000
 #define MSM_DSI_6G_VER_MINOR_V2_3_1=090x20030001

--=20
2.53.0


