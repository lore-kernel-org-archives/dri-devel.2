Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE12C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2ACA10E86A;
	Thu, 17 Sep 2026 07:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JRVI2pHi";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1EE10E4A2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:50:57 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f705536so141987066b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789545056; x=1790149856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j8D6JnnoF4uT9GFk7g9DjQ1aSimSgKnpfAaaRW4jURk=;
 b=JRVI2pHit+VG4iLL/QpoazCeQ7mYpx3XRkxMuXKifj4Gr71UdE80dSz0Gugu4kwvaX
 zl4V/JxSKzGhOYEZQ+cnzxaFR6yYN14/UrVsMI6th0G67T5odxnfqt/Q2FngVLrsNwD4
 Hm/2wMCz/Li5EYrL1YsifnZxI+QYCSrNXLwiNVjbmsfoqk9FcToKjTfrEKas3WCMzFIb
 dhpKaW4JH6Pmk8oUv0X8DFXfsGkhwPgGrh1GVwmRKPGl156LT7/wcOP9lkKQpM84fe3h
 jXgLGja0TDt17MucwUjd7qwSLCdY54hirZeHej+nY5iUH+BYGkHimH2igjViG5gWOt2d
 ctWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789545056; x=1790149856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8D6JnnoF4uT9GFk7g9DjQ1aSimSgKnpfAaaRW4jURk=;
 b=q4XULYh/oK7JHRM+Dkj8MZu7cYgmQOnbda8lipnyoTUU/Df0FZnztImmDzJDk5cYmj
 yyMr39p8w5PZG+IsNe4sm/xIlvJZNZysB5MWHWn2+pMr13eMX9Khg4Q3qk4knkBgdVkd
 weibQOY7SxjywIqG8pGsVF2qCWRgBSzdYGbTOeGxA5Y4nViC0booI69f7p1E7BRzDHsq
 KvApIlwA4PIO+Z9C07roLUsKa6EYPYMyypUCCvOGReEQ5uo+kFDu2LHSMm/Dyc3CQUL5
 K9vy6xaaRP3U8JnfdTFuZDDspUw2f0kjUx0/mHetX4Od9MmHVZ69M67LBeASlH3P8YaN
 eBMg==
X-Gm-Message-State: AFuF++kwusJTjgt4bHD48+fMu9cBzGwO2z/A9aXdLYfFvGiSfmc+ziQY
 8uj2xLCPM+WTTWod4cK6ZNSCoGw1ou3j8kXrMTzwid/X6389dWMbeo8g
X-Gm-Gg: AYBFou3nUi+RPPO8L2JB7mmLfG1tqr9dtkVuzZP7YYEpRSrPA/gPOqj6RjvZ/Ba5jag
 wx89aWzC5IasOOCi9GmoPz9UZtFAxEANx4q0O3HlpU2ikaQMLy7NhzghTiBxV0rZyOZ9aCluUqd
 AavRtvHQLFRHjx9F/10mbGttRbNm+Z+IX/SPt0kYUOSiAJyjt2rE5E95WakxEwqd3fFbko+P8Z8
 smwxXFvpA3r+E6CfIJKStrbu6yCh/SwdeerimWaWeJih0CaU9Dy2TW26sR1J+ju59uyC2TYaqpz
 FNZJ+N2xXG3IADr3w9RS6gIMEiYuCJkDdSK5QA4TSXTmaPdvyPv6fLelpVZd0nv2NsgaMsqIJMN
 6xJh9xXRRAs/RA/h2Uxf6N4L/nsClbCY7jZLdQMY9s/GjmhYeamXdQoI9mheDzYUbsTIHPy0303
 mf/lsiJ+r80C/kxHbAGLRkdMO/2oKH/Vz2ABYmAMG3ebzs775FtwIry4XWwr5NstJNBB/lF2aDa
 ZM1heMvt5zUJ6Y/bH+7lckRYTOgCKBS8qdYNJNkVlj98yxr0kFeCkSqdJSS991ymaoMPHMFtkfr
 84/xgzoTkLvITwgR1QaL1usxFPTy0UJglitColUf5yv3unr+5oumdoe9ZaUAyLwrUrWS7IHVBQR
 hY2sOLd/8H33jzKqGCAzQeDnh8NKjWkeBdYrUSxbqnDg3IPH02nIFpjWtvG+fhk2Lqpoh+S6r8j
 5IuIXAIYu+Kq6bO0gdahlr6pi7gnv924EaAKONmNCbMZHQthJKBy2ZeVbMvAaHFayuoFc0EIc+I
 miCoep4LOybzY02
X-Received: by 2002:a17:907:940a:b0:c29:4415:2ebb with SMTP id
 a640c23a62f3a-c29e51e2170mr112244966b.8.1789545055876; 
 Wed, 16 Sep 2026 00:50:55 -0700 (PDT)
Received: from
 cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal
 (219.145.32.34.bc.googleusercontent.com. [34.32.145.219])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de652313sm76139466b.55.2026.09.16.00.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 00:50:55 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Boris Breyillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: add missing pm_runtime_dont_use_autosuspend()
 calls
Date: Wed, 16 Sep 2026 07:50:51 +0000
Message-ID: <20260916075051.1353-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

panfrost_remove() and panfrost_probe() disable PM runtime on teardown or
failure but don't call the pm_runtime_dont_use_autosuspend() function,
causing potential resource leaks.

Add the missing function calls.

Found using Coccinelle.

Fixes: 5c0c825ae4c6 ("drm/panfrost: Replace DRM driver allocation method with newer one")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 36cc2e67a308..74e8e5783f9b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1012,6 +1012,7 @@ static int panfrost_probe(struct platform_device *pdev)
 err_out2:
 	drm_dev_unregister(&pfdev->base);
 err_out1:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -1027,6 +1028,7 @@ static void panfrost_remove(struct platform_device *pdev)
 	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
-- 
2.47.3

