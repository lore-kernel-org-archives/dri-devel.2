Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B15FF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EC510EF15;
	Wed, 29 Apr 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXK49GvX";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D244C10E4E6
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 03:08:49 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7986e538decso124507557b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777432129; x=1778036929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pK3hSHFPCb7iAbpW1nQuRwBugG9K8FcaZDqruZMNM7A=;
 b=gXK49GvXQGT3SMaO+aujJ69XBnLkberkwvNuHHkls+AE4u7MTTjT9RhHcOzyKXY43l
 hkpMqa3hMsqRr7YWPKdbYViq6GedT06UW7njKmFgMOZmu+Euw8Is3hVCVB5U0dwsaQ1+
 Cv8PXifc0BnEocvaeDlrbUETK7wBKejRIvDw7iwJNH8eO9OgUz5NugkKXphXrzQ+bkz4
 ObSGWZKB5BsVpmNsvjlTWz0CdUZ9ytnbdk8Gd9iOOCUIoTOobZkeHbDMy3EVa1YARwl2
 ch1ETNx/Z8mHHyEohvUTMNkYNcjhtLQtGE+4EryHCkdc3ZN10i3oC8uJe3T0KcGJEpTU
 PqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777432129; x=1778036929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pK3hSHFPCb7iAbpW1nQuRwBugG9K8FcaZDqruZMNM7A=;
 b=sfU0wbe8YlZh7hVz3MJdh00lWgJ0LoUlgxqR0v/kbasmtwZ66BSYbeNHe8IMNy1B73
 CkfIVb7goP1VHkgwgRYBfZYUNBLKvTPXblGI22AodpuaVZINDn7JGwwMzzjf2O+e7XeZ
 E0K5dwjozDChb5wH2+r/ABXfyqpwABzfyzN/IlAUD/+7Y83NfOcWCJjJOxsjVNG94Hjh
 aIMK57nEnql7eZb9E+/l274/2qQW/lLoPDVDFVKcKfOAjbW+fHgmo0DBHt8E8xa7BYA2
 jaxJLjrB1bSMmkj4lYOeYVblYWyN6j1i4rfWHqAyYWcXhR/yLnpvwkJhVdwJgc+NX1D0
 I2Ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8K0R7INemNNj9lXqMaRhf1/8ohyDUcP0jGLbqtdqgs8GwElfE5i+tY2KHAsEIDldtQiYrhz5QRlUs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywdku2CI8jbXFSk8WQMqUdjO/8BjlPH73m0byYhEblVvMjuYLMR
 WOPlkVnrhQ69J/QhU2ZYb2gFjqDQMqY0E5Q7vXTJqDebeREigol4QXt2
X-Gm-Gg: AeBDiesfblJTHi99mVQ6NexqmA2JT01KBP//j+WGPopn9geZ7mDzyG4gdBvGrKQuOID
 69bXD6SxGPx/KvTbHNXcm43oqc3/xQ78S8ULMUcDvLGtW1xQ27L9yflTabLL0E8IPg7zYQ1SJaG
 NYsvWfBDkjJoGD71cnzBcioVwgvoIgNO5iJfE5PPKCL6ejTUTLmj15QoswZ+fUbhUvYIBHfksXa
 1XB15vdtIgd1b1YN9kW2k5Vk9dCHBBLKEg6Jmd0ZeD4ddy7L4bEWLoK07hLhWtKZPSwGm4zh+zE
 jnQwLE6TOp4okyaq/kky9cM6tNNi0KJec6v0kYWK9K3mAj+061s802Eeg8TjQXdbIAKAuHUQ/Yt
 JbTVuGhMFK8wwnJLRn88k/oFctc5eHsn/u8viMeoig5qhYYK5T1bf2ojjiYOUDVNby24q63ByUo
 1PxElkFLHdYzaclzSSR1EUHGAg3psNULoZ4skbGN7ZBq1xmCobftj0VCEPs+Nc3JEUpH0Eivvor
 gliRg1xd/dL0lB9YMnjgEzYawuaut6RSJ4=
X-Received: by 2002:a05:690c:e3ea:b0:79b:cf31:9787 with SMTP id
 00721157ae682-7bcf5573e9emr55855817b3.28.1777432128767; 
 Tue, 28 Apr 2026 20:08:48 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::111d])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd25af5385sm8674627b3.48.2026.04.28.20.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 20:08:48 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] drm/bridge: analogix_dp: Extract error pointer from correct
 variable
Date: Tue, 28 Apr 2026 22:08:40 -0500
Message-ID: <20260429030840.704252-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

In devm_drm_panel_bridge_add() error path the pointer error should be
extracted from dp->plat_data->next_bridge but instead it is extracted
from bridge, which is a valid pointer and not part of this error path.

Extract error pointer from correct variable.

Detected by Smatch:
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1489 analogix_dp_bind()
warn: passing a valid pointer to 'PTR_ERR'

Fixes: 1b86a69b61df4 ("drm/bridge: analogix_dp: Apply panel_bridge helper")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 460729fdcecd..3e46350170d4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1486,7 +1486,7 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		dp->plat_data->next_bridge = devm_drm_panel_bridge_add(dp->dev,
 								       dp->plat_data->panel);
 		if (IS_ERR(dp->plat_data->next_bridge)) {
-			ret = PTR_ERR(bridge);
+			ret = PTR_ERR(dp->plat_data->next_bridge);
 			goto err_unregister_aux;
 		}
 	}
-- 
2.54.0

