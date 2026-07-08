Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F82C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F58E10E1F5;
	Wed,  8 Jul 2026 20:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="at7u5he6";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FBE10E1F5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:21:30 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so8640535e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783542088; x=1784146888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lPC/fPRplTXrPRJP9WPEDmAAHY+62t7UA57bz5CaOyI=;
 b=at7u5he65ZBCVtDaFrnYTepSloLansYMXMAEtLi1aV+W6f8RB35gj8SR6vkOMnqZjc
 HQLx0JqVlOVcdXnmInwIV0srumW5mj4dHOkdxULwsp5G5/GEfYE6ZkoopBmjSlLOkbzO
 +nVWElR+H2gin5fjWwVRio0uZ+52vUBaovTgJPVLt8RFv2WuR6wk3i0aHRG5kDAh8def
 V1ovV4jMnsN2TFN4y3yFC7pAxDCkn2u9DgON0YgtU/PVfnh9bsBa//Mz7DJDHyreRm5n
 caiMEvCBDOi0xLJOFeqZ7s7PXANma6fEBff5lQVc3BsI7wgqZGAZSkMXz10iQa8k2EWm
 N+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783542088; x=1784146888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lPC/fPRplTXrPRJP9WPEDmAAHY+62t7UA57bz5CaOyI=;
 b=YLUuJzCP7QD8lbIIKLTUmNvlIqZ/ect1TGjfXGXbJFKOPj6mC2xEE5Yh1h1pjUf8cR
 qJ2+DVdT/+9AHUf2T2qgHpERq+GDNXJ9OTHmXLOWbWDDpF+bAXWurkzbr80luSlsc1/V
 1MoGd5zlp9yAj+bpAy5N1PkJW/PtDB8URrp4nxa5qMtSAVBlBSNMH0rsT08auwcg12J6
 0ClnHnQ7UkVc+xH10W/iTtGB9U7FEIk75rlY2mth1WZKmS1VQYSJSeS0MlFhnasqgsqz
 RI5J2X8MEN0RW1TG5CUqrTeNFycl5AQAuA5sG7I2Qdt1sdQVBjmoMVWZikSRwx+At2/1
 geVw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpgtmj32s0hrMgCrqMaZG/p085IA/AiLL4kdyC8pQWcuGLnTIKfJpiBm5TK2DcHfUfGMr5y5tg/sNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXFGRMDU6lUYNgxs6xMR7krYgoYxkzxSm2N+yokL+B+VFis9h3
 kQ6MqOLln+OIZ4xESyPuQAzU9aIU+x1qXCRoaCk2kUr64Bi2l9bfDgxc
X-Gm-Gg: AfdE7clDiE2fZNq5+qQsiemOd+J+OHek1chnU+a+jYIaOxrj284faoOWMMNqiNDsBLs
 868osyGm6SwqXtUMvS+zyuS0fguMV/38XdEP7GOywuKhgLHNX5sh6RvO+k/WykjAzD0esrXj4TZ
 BWvvuXjCgHE+O9ZMPhjFyC10hWb8huRPRbwmbAlbvRezSCKCRylPqYW43STOMyQGAL032r8RQbV
 nmdIdJX4gEXfGvT9Py2qZ0P6OmoCXulOlv67mfYAXbnD4h/FYOBADTm3r8/nGJsDqo8FPwI251b
 3mSZ3hBZo0c1kW4ePaHxzsFRrIzjU7PndTdGPBMofFen0fEdkJTSuJRNdu4L8i53b/G7TmpCk9L
 78Q+t52pnNF2897rGmgEGXGG9UVXSlYpWRL4pIo2orkXukEUKw16Of59AVL6PSt7G5Fjf/JL5Dh
 bHHR2UIOym40rRxuPRIQ/roaB9/lDAcR/N8ELfotDkEE6MqqQgIA==
X-Received: by 2002:a05:600c:3e07:b0:493:de89:61b with SMTP id
 5b1f17b1804b1-493e6868766mr42351155e9.26.1783542088002; 
 Wed, 08 Jul 2026 13:21:28 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:2b86:7192:b44e:9f03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e54a25cfsm97381485e9.0.2026.07.08.13.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 13:21:27 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/imx: Fix ipu_plane_duplicate_state() OOM handling
Date: Wed,  8 Jul 2026 22:21:23 +0200
Message-ID: <20260708202124.12560-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706140246.41506-1-osama.abdelkader@gmail.com>
References: <20260706140246.41506-1-osama.abdelkader@gmail.com>
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

ipu_plane_duplicate_state() could dereference NULL when kmalloc() fails
by returning &state->base unconditionally.

Return NULL on allocation failure, as the CRTC duplicate helper does.

Fixes: 00514e859335 ("drm/imx: use PRG/PRE when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- add Fixes and Cc tags
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c7ec09e557c1..67f2da7f2b65 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -323,9 +323,10 @@ ipu_plane_duplicate_state(struct drm_plane *plane)
 		return NULL;
 
 	state = kmalloc_obj(*state);
-	if (state)
-		__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
+	if (!state)
+		return NULL;
 
+	__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
 	return &state->base;
 }
 
-- 
2.43.0

