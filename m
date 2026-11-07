Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6C606A332
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLpXS1fD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6FD10EB72;
	Sat,  7 Nov 2026 14:28:21 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE7510E3B5
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 03:18:58 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1b1ce85287aso1287186c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 19:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794021537; x=1794626337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y7unajM2tsEtL6kyV7l2dYlgYPenWJUuAJfXbqODBpI=;
 b=aLpXS1fDA5YskIT5xQtJTxbFTZF5D/I+3fUwi94C8EHhYJzDLhnko77gdDOOOvemwM
 Lsi9gakMbERqXVLotKMzIBTyaqwHcqrIDLM5ul/yWmhSFk1e/jlIdFSebIXpxmbNPRFx
 3nTv4VtwQgmECmopnFjeQWfGCJaX53oQZyqqo+vGMZMPUHnZljgA4lh1MV0Aqu6852td
 8Fys5XR3muqA1GZOfmat9DdKHpRRFV5UCLpzyvFex70u28Hj1y5TX6Ap5cGUJPZttEk9
 3xCL1cYsrjaZkcmxMkYyXIL80u75xtNW8pW4x67sMG3UbMacwE+zSGcVD2EH8veNrdr7
 qaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794021537; x=1794626337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y7unajM2tsEtL6kyV7l2dYlgYPenWJUuAJfXbqODBpI=;
 b=yJKsH+sPpaG5UCJoOXKpOVth+quyw3xoJ4whnY927TE8R8+zRwu5eIPgqzl5JUlx4s
 xKzlWqp/h6+e9VRfiXqqr7MBDadXHXXlYh8sZ6jC14zoSzBqti6mhAFq2zgkGWfcxEHo
 Af2q+acRVP6cWSXT0arSNhKJclj6OpclN9//BRAWsEFTrwNovvoWNGEGmjuvQraDWKoi
 lBciuJKacbD1qSSNE81Z1rzON6FrO1yn2VhcQAPhOb3CEx0CRUpdna2LYb09ze9rMLu4
 6UIpKkm7ycljpCcUTPHtlwzCasLqjzTZwZFDOzkHdty+6xJ6ve4ADQHYIQ5csEb5L6gm
 7sBw==
X-Gm-Message-State: APuU4Z8IVKmk50+nYM/cWnZRcLbfEjbm37rFKg9h/1Nfr0NJld2wKU95
 lMy+zC+cvQIG/b7rfe1TE09MuWhMliADd/iBb4wX2oBsUPIvjXNjgxUnMX36TAhc
X-Gm-Gg: AYBFou0QCaeFVR+83FWFyY7pqXmXAPOHpDInJ7mP1I27AMyEBtOr6XQO/bwguGSrtkF
 p67vphsmCFNo9v5S0fb83DGryFidVtqqjfSJshnpzmLn7iFandHeBVUS2fQmkHAOTP6KfsLXRI6
 JQhGfJrmswzIFLYmh3J+dNdnKUf+ZqacpPRsiSHLF+QEVjlS28nAlFDSbJsXtpQPQFYFw68gz2Z
 +U7yREgML5mvRZrDC/3rgjqS74Ozg1h9Seog3Ja1FTh6F842f/GpG58K2RPX4z/+QfxjTxx6qdC
 aTd7uYXmi5prFUYM6BNW2yVrppCdBfyLYr5skdgZ5xmCfUoAtgg4VVTpGcFrXCeQJrw/b/baB+H
 aD8gdzsz2Pcsu3fNOe8/fgCBNhXWLrKWo/Bo1D1HcmP5F0/KHo6dTwIqTtZFmAHdaH0aO4gsE6Y
 XZooCtPUKpAQuiYw2acTMUMvGkLQ4mV60xcBEoo9ZaD9DB9w+aFdMdvH8ZKJXlYfnXryXchLbrt
 O+M7oOr9/PdyuM18K2wlJzDj8++R6d9BuZW61IUF58UhIN2XjfPAQQsm9tpUZ5zckb0iWKDJVKN
 3HjMlk/gFXnqNDGtLUjUTwlxChQ8Ex/9nGeZ8tm7oHa39gEEpDeMdSrIuQlLllG3LWkMevlCUZE
 qeanzv2H5ANnDYHUDE1NmdvK84V5ysdTIaI1Kp0YL+93qJ70TL5Pe8Y7LHcFnsC+v33yyIus=
X-Received: by 2002:a05:701b:424f:20b0:1b2:4f97:27d7 with SMTP id
 a92af1059eb24-1b25d32eef9mr5595214c88.36.1794021537288; 
 Fri, 06 Nov 2026 19:18:57 -0800 (PST)
Received: from Karthik ([2405:201:c01e:69e8:376b:daa2:909a:eabb])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e485ce2sm9706545c88.7.2026.11.06.19.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 19:18:56 -0800 (PST)
From: Karthik Sarvan <karthiks1mail@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, louis.chauvet@bootlin.com, melissa.srw@gmail.com,
 simona@ffwll.ch, oaroraetimis@gmail.com,
 Karthik Sarvan <karthiks1mail@gmail.com>
Subject: [PATCH v2] drm/vkms: Set preferred_depth to 24 for XRGB8888 default
Date: Sat,  7 Nov 2026 08:48:42 +0530
Message-ID: <20261107031842.18152-1-karthiks1mail@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026071933.48366-1-karthiks1mail@gmail.com>
References: <20261026071933.48366-1-karthiks1mail@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:28:21 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS defaults to XRGB8888, which has a color depth of 24 bits stored
in a 32 bpp container. Setting preferred_depth to 24 reports the actual
depth to userspace (such as Xorg) via DRM_CAP_DUMB_PREFERRED_DEPTH
rather than returning 0, while keeping the fbdev default intact.

Signed-off-by: Karthik Sarvan <karthiks1mail@gmail.com>
---
v2:
- Add commit description (Thomas Zimmermann).

 drivers/gpu/drm/vkms/vkms_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..10337889b1b0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -146,12 +146,8 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.max_height = YRES_MAX;
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
-	/*
-	 * FIXME: There's a confusion between bpp and depth between this and
-	 * fbdev helpers. We have to go with 0, meaning "pick the default",
-	 * which is XRGB8888 in all cases.
-	 */
-	dev->mode_config.preferred_depth = 0;
+	/* XRGB8888 has 24 bits of color data stored in 32 bits per pixel. */
+	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
 	return vkms_output_init(vkmsdev);
-- 
2.56.0

