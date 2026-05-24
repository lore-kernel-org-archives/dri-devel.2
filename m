Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66274CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 15:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D6210E166;
	Sun, 24 May 2026 15:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fa3a4TfE";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF3210E166
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 15:57:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso4099325a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779638263; x=1780243063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wuu4460x4/FBZThRE+KXHL2JDpzAJY9WR1Xg237ETeE=;
 b=Fa3a4TfELz9Sua1k8mXT5+W9mMUuj7lJfjtVsDvilzvYEaBGyiuFInb0KPlIH9EBhO
 DrYzwbwAdOt30LOCAx1XJOF4Et4G4eJw6ss8FKA6L2OSMjY4l/bvBC7qHBjXTgK8l3cz
 CeABgyo0ubKeIMiBpUwqZSyKaUwECAWZgIR6wFNBmzyxsQylFZZyVONH6+o8DO6xd6MR
 VGZFOpb+MHcdoOhGxry0cN/p4CDZg8EgxjNgzpvls7JCzh4lN2e+Bb/zReBP/hNzwWR5
 vjis6Go92VqyMN7NAAdOzZyxqSFCRSj7K0NNXYZvXiR352cxi4X1OX2+uIuMo8SEoAvs
 xQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779638263; x=1780243063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuu4460x4/FBZThRE+KXHL2JDpzAJY9WR1Xg237ETeE=;
 b=KOj7HkWi/H47Xh2cVQBmp3s/Km1F2Y+IjJm6qwLA5qy6+uUxgjLt8H6FngDivqzJw+
 0z2xEgB72q7uJ1mYTy+KRF75sxekSJ8QsqInZtwHXjA6s3F2aW/RlUnHTFKnp8UHOqLy
 5ZLmhmR9/PKuCQmoKCtXdTmv/Je0kCjzwKA6zd3TgIO+M9GxM+78RJioJg/N4PCDPhUt
 q6zK/TrA2qtQj2sJq37W+p5LPBhQL0g5BzIGrLnKPNxGF/K3TpkecrZK3v9LTRcPHYyz
 9+5qVffhHJLvkaYrkPQFSSPjEamz9sqqbM2KfBcinwEvQKmwsZ1HfksoKSnKBgb/4+4D
 0yIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o/KkwMXVET4eXRt3VOiXaRZffxnXd6G3rACop2BTRnd9uqPWHKB8WM0sj/NFIDJxspI6dhG5roFw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUOz+Tz6jhmnck8Wv+/QR8EAMRIZwBdtNVAJStA1+V+q0rDpWI
 HjEp2B+KCJCrU0RoMjahxC5OX9IVeyY2VVNN2bI/Zb3F63lifhY+S68=
X-Gm-Gg: Acq92OGWMS7A0drr9GnFF38vh3VIhYRAzB4PrNJH1QtoQjQUUEc3/c3FMncPd0nmFc1
 jNI6/yTqNXUYsJghJPDw/PbN3WV1ZWTE0wmIIDUDp5SJmfvW8q0NdTIina5632ggUK5244fNnUR
 NpRO+XXTusXl8lALXsDU95j87Xvf8TVdQCrR4pZ0f6oQHnvhls5BlMHy9NGby5qGu/pfQoujVp5
 0DItOUmEn4lwr3on87zZDs1yDSrapaCgQ9DBv8/dv1YFb8sOteECX5T3c3O2oPCZDAzzXRD+FAB
 /98eWtMaTxsBKBMIE4CGoKfb+/Ae1193K7gz1FH0MX5P6p5VEe957Rc+PKFk/g+9rdBP2QK95KH
 HSIxgJJJy6l98NCPWLOn71qsCEDHGUMUJN9iZj7sd4R7lSS9BQCO92Wf3m7se6qCkH9gMs33/ef
 L1SM466hZEP+gkZbEEWumeAT/7zdzo3WsONd3xb8g/On/Uqk4LrbkxZCM4F2fzYYfcmvCX1Ow=
X-Received: by 2002:a17:90b:544f:b0:36a:b560:5c61 with SMTP id
 98e67ed59e1d1-36ab560606bmr3756342a91.7.1779638262720; 
 Sun, 24 May 2026 08:57:42 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a71ecf799sm7169671a91.8.2026.05.24.08.57.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 24 May 2026 08:57:41 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/gma500: clean up modeset on backlight init failure
Date: Mon, 25 May 2026 00:57:11 +0900
Message-ID: <20260524155735.13865-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

psb_driver_load() initializes KMS polling before it attempts to
initialize backlight support. If gma_backlight_init() fails, the
function returns directly and skips psb_driver_unload(), leaving
drm_kms_helper_poll_fini() uncalled.

Use the existing error path so the partially initialized modeset state
is unwound before probe fails.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f535..7218026fe2 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (ret)
-		return ret;
+		goto out_err;
 	psb_intel_opregion_enable_asle(dev);
 
 	return devm_add_action_or_reset(dev->dev, psb_device_release, dev);
-- 
2.47.1

