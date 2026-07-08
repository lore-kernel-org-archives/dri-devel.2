Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4911AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4430810E672;
	Wed,  8 Jul 2026 21:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SYpCZtiL";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630FE10E672
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:53:56 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47de008b020so149220f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783547634; x=1784152434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IIMECz0v1f4LVIdLn0HTlLUSx/SJvMxrwrh19eAWfPY=;
 b=SYpCZtiLY832ZhG3xcsCPkgDkqz+WBjlahuoup1cykRkCLTQcGPzpDalmijWP9p10b
 ZEvWlQlRWlNr6WNFU1P9g8bqErh8VuqRnMY4nwt8nfhm1fD4Y+XPNwCpnQG7CYHRlJhF
 mP44WqmIrPR3IbMwy88Lp1i2PoJzcUYldQRwpmG/+HCyWbe0lIzCG4BZOo9COBdcKc8T
 Muzg9kSHwVR0vC6Hp/jIGvH9jnBlqtpmRVMOnxb0jwD1Aw2mi3vMcXiqASbHw5UkTfWY
 U7uqonHsgTcgnQvFzQsRfaZ0MSPupR1QuU950z5sgMJJ6vFiNWWS2InjYzj1IvOD3shv
 5VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783547634; x=1784152434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIMECz0v1f4LVIdLn0HTlLUSx/SJvMxrwrh19eAWfPY=;
 b=T8OcWTtGDVMOj/jknYdHLrUGeN1Rm2r1MysMcJ0Gwn2gXkGQTCwwCKlhCW6p6QLo50
 xteq99nAZsJhfeUimdwyWqm3qeSnPONR5zX4we0dVHjL8Jc1eSf/PbO+ngDwnLR5K4uv
 cjPOpnThV9RNoPdmKCK93Dy6uXsPBUMJc43YT8H3s9wHni/mBd9q7qFeunPtvgaFlwFw
 5xOgVJIS4X4NGyD2AzXCgUy7q9jntVWj3X9yTtAxQ0e2tw86KG4Fr/DShu+MOm5XAPww
 6lXKlIFfu6jmyI6RSw5yr35h7jykR3uMv4t+RY9M6NgieA3GYKSoYHfHR3fLc5KQ8CZW
 APaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJkTC0RHoC+cXR96jUCSlU6HBhDbh/Eh+jOEFz05IkfFM3E1GNQGgsezuSQWzq7KEe654228Da0fU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEiGmjzLg0Sa8ql0Zgn6nZe65p5IpOVEzmmqDpB1UyL9Zwc/4m
 fA/AaBLoi1Zz6nXmXduSglOHOAzO3hdfDeXcb2FXe/VVpdgfqGKM1Cpc
X-Gm-Gg: AfdE7clo5tmYQ9N7G3w+8aAfisEQXR+ha7I8UthG6uwNxUoNTCFyyWSdedo2n3fwKQ2
 xo2lT9/+LmhpXkcvHLeNj/8A9n+43JuxnU916K1rXbzbd610MxZkjcXiAIHYjOhNkrUenQDMYVS
 TR3i718AOdFm46MiOb2oJto6H9zvYvfFu1pqtGs7Li0VyUEK72avnbJX0uZ1pmBoiDupsFQR0I3
 y7g5XRGX284zslD3USTmY1HJZTTG540NFuleYEybdS+YlAZEHqQkkUTQ9R1yUkRGNSLD6G37Rqv
 bhR+6OLqHi9L9vodxmrQW/gIRhQwd3cFnJK+yKYwTDCP/UmphIMUno4ImrrC7R7BTngM6v5SbEr
 5hDvKjO8q3wXogABE282xbbBseD/dk/pRxM08KMsAXoHcOcgmsZovAdQuCfVu4SRmJ+i0hNZ3c6
 89HBmLPo6dvlJIp6huarPVyCU/Wjeiol7D8FdFur53sTeepxxJbg==
X-Received: by 2002:a05:6000:4602:b0:47d:f6a5:1fd6 with SMTP id
 ffacd0b85a97d-47df7561c98mr84937f8f.26.1783547634411; 
 Wed, 08 Jul 2026 14:53:54 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:7550:b182:7bdf:fbd0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm46622289f8f.15.2026.07.08.14.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 14:53:53 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/imx: ipuv3: account for active PREs in atomic check
Date: Wed,  8 Jul 2026 23:53:38 +0200
Message-ID: <20260708215338.147145-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ipu_planes_assign_pre() starts each atomic check with the number of
registered PRE blocks, but that value does not account for PREs that are
already used by planes outside the current atomic state.

This can happen when CRTCs are updated independently: the current commit
only adds planes from the affected CRTCs, while PREs used by other active
CRTCs are ignored. As a result, atomic check can approve more PRE users
than the hardware can provide.

Subtract already-active PRE users that are not part of the current atomic
state before assigning PREs to the planes in the commit.

Fixes: 00514e859335 ("drm/imx: use PRG/PRE when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index 67f2da7f2b65..d6806d1ae6e1 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -822,6 +822,19 @@ int ipu_planes_assign_pre(struct drm_device *dev,
 			return ret;
 	}
 
+	list_for_each_entry(plane, &dev->mode_config.plane_list, head) {
+		if (drm_atomic_get_new_plane_state(state, plane))
+			continue;
+
+		plane_state = plane->state;
+		if (!plane_state || !plane_state->crtc || !plane_state->fb)
+			continue;
+
+		ipu_state = to_ipu_plane_state(plane_state);
+		if (ipu_state->use_pre)
+			available_pres--;
+	}
+
 	/*
 	 * We are going over the planes in 2 passes: first we assign PREs to
 	 * planes with a tiling modifier, which need the PREs to resolve into
@@ -843,7 +856,7 @@ int ipu_planes_assign_pre(struct drm_device *dev,
 		    plane_state->fb->modifier == DRM_FORMAT_MOD_LINEAR)
 			continue;
 
-		if (!ipu_prg_present(ipu_plane->ipu) || !available_pres)
+		if (!ipu_prg_present(ipu_plane->ipu) || available_pres <= 0)
 			return -EINVAL;
 
 		if (!ipu_prg_format_supported(ipu_plane->ipu,
@@ -871,7 +884,7 @@ int ipu_planes_assign_pre(struct drm_device *dev,
 		/* make sure that modifier is initialized */
 		plane_state->fb->modifier = DRM_FORMAT_MOD_LINEAR;
 
-		if (ipu_prg_present(ipu_plane->ipu) && available_pres &&
+		if (ipu_prg_present(ipu_plane->ipu) && available_pres > 0 &&
 		    ipu_prg_format_supported(ipu_plane->ipu,
 					     plane_state->fb->format->format,
 					     plane_state->fb->modifier)) {
-- 
2.43.0

