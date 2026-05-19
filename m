Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565FECD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F23510E15C;
	Tue, 19 May 2026 11:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eepcU3Gh";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2385710E15C
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:46:28 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b9ec9443c2so22399475ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779191188; x=1779795988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ta61K0Pmld/CsWKgzlq6xjmWULCR3bAZMfwfucx3DEM=;
 b=eepcU3Gh3PM8WQgoaQsPYI2Y1vvZhJVdcaOOyvMzhjgGGzs+ECwCOTa7WrXnjI7hW1
 Z9FU0bQkrxKIYlJ7eYF7nxYxTeXpZ2bMg1qifO4IzSTNxutwE74OVW4FQCs3y3neW23R
 5hPeP8Ex/s3EYIWzMAtTMQ+17f6dpsLghDJuq8hilMO0fdUoIwTJ/U39fwh2rJ+Tek9t
 CTGQYWcCf1w7bHoRLTK5Mm8w4QcF9OdaEmEq+s8oS99LPYq407hSbYgJ/9KQm2Hm5Yb6
 HsevKEhppfXjh0KYPJhRpYL6HGxSSPZNTEqhRCaaehBps4L5MvXlmV7Geh515vaeJcYo
 2AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779191188; x=1779795988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ta61K0Pmld/CsWKgzlq6xjmWULCR3bAZMfwfucx3DEM=;
 b=gEqaQQ01B5JulkbkIvWMAbeYeqm4HEfhW8dODbqG1Mkw5Yh/k7WiAkcCX+9LEXAcfL
 ju5Lj71SALiZeMPcjKP/2Y3hEpxJ1Ylp+4R4aDkXl4XrkF/CY+IPZLNXKwKVv0d5kN/a
 S6glIXclA2HOusoOh5Zbjl5MvM75c9bksBmXZvpmZ1hZss+voyVXCe1MkPDncgCI/Obr
 RhKWsjHMig0lrftTbKZwVj5ZMnkrhkvVWQvS8mEjvcOViX5NNsfyxh8G2TCf4aq3NFxW
 lu/k0oWFNTVTfKDhFw0gDdMOmMVl8FBEA7IqnxVimR7n6W2n4+Zo3nacp26C2/DWZqBI
 +NIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yYE8E4A4u2lGrHLquLDctZ28dihyWRI63aGgLSgeJgT9s0faMlY4T4JeKyIVTg+6ERV1oO6nvdtI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi+lNS46Dn+jYYqTvO6GlKCdV2uyao2YA1aeO240KCfvOO/coc
 Uy5zpPMx0m2296WSR5qlAisi2KSiUlFZSLj4FoEES5us8dsQnozSvMGP
X-Gm-Gg: Acq92OHpBRpj0Wy+WVJjJwA+KpL9aNWIPoKacZzZAgDHEwbgjMSLnu89twunJ32+OO8
 Gv2CvLt+dgt6DKrtgiyW3J2C6sH3QNr6fXZ/zqmaGohj6uLqR/fDVTWFj93YCGqB1XXJypflbJu
 7iWfiRKaTFpYHDKLzwypEdijMOZaAlWLH6nY/R2+fh/XxZ1c4MJi4skJGGB15+tUgdATQn+BapJ
 mR8j/HnTrGOy6wjuWutnzTt4VPBhArekKu4R3bxQpMkI69KCKmpDPnhjJYCoo/jjcxQLtxn+rbM
 zEELLdeobbs2bjX8nbZ8XblGeAcNXQn5J4nxLn0Lo/ULcKpVHhEAgFsuUo35roR0RSZJkknhPEu
 eEoGv0C8o8XQrNUSxhil93qt871mpaX5x4yG4p9RygNEzXo2MLnVTAoubfTkIWYADmI8ufT6MQm
 iQi8N3g9WlxwdH0xP3aqWeUWQEkA5I0gTjbW/zRkn4eVe+bCYFGUk/SA==
X-Received: by 2002:a17:903:1cc:b0:2bd:2c3a:2a36 with SMTP id
 d9443c01a7336-2bd523168b6mr203103925ad.0.1779191187600; 
 Tue, 19 May 2026 04:46:27 -0700 (PDT)
Received: from souradipto-das-Latitude-3460..
 ([2405:201:8011:1c:c7a5:efe1:9ef6:7b2e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe4935sm193368545ad.42.2026.05.19.04.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 04:46:26 -0700 (PDT)
From: Souradipto Das <souradiptodas6@gmail.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Souradipto Das <souradiptodas6@gmail.com>
Subject: [PATCH] drm/fsl-dcu: Remove redundant connector registration
Date: Tue, 19 May 2026 17:16:11 +0530
Message-ID: <20260519114611.11388-1-souradiptodas6@gmail.com>
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

Remove the explicit calls to drm_connector_register() and
drm_connector_unregister() from the parallel RGB setup track.

For standard drivers, these operations are redundant as they are already
handled automatically under the hood by drm_dev_register() and
drm_dev_unregister() during the master device probe lifecycle.
Collapsing these calls simplifies the error unwinding path down to a
single internal memory cleanup step, as stated on the gpu todo list.

Signed-off-by: Souradipto Das <souradiptodas6@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 84eff7519e32..5b457c16966a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -92,18 +92,12 @@ static int fsl_dcu_attach_panel(struct fsl_dcu_drm_device *fsl_dev,
 		return ret;
 
 	drm_connector_helper_add(connector, &connector_helper_funcs);
-	ret = drm_connector_register(connector);
-	if (ret < 0)
-		goto err_cleanup;
-
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret < 0)
-		goto err_sysfs;
+		goto err_cleanup;
 
 	return 0;
 
-err_sysfs:
-	drm_connector_unregister(connector);
 err_cleanup:
 	drm_connector_cleanup(connector);
 	return ret;
-- 
2.43.0

