Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE86C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E083810E044;
	Sat,  8 Aug 2026 14:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lShLWjyu";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CDE10E044
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:01:57 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so425158a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786197717; x=1786802517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LWQEkJchPYeC0ZoavYUr3xCkFVeRdSuQOuSKSluD+U8=;
 b=lShLWjyuz05lj7sipBy3R0AYDol0i0HqzuZf0aZi15Wqp8WVRJE8dCaT7biOUGj9ui
 Iao9CrHBR2SkbCBio9ul896sMc01foDFVLCQZZ9xT4sqt8VguGAPtyzg+dCNwNdRdwvI
 ZBO4odlmIHhM7OZdx2zOQmP8VjRWokNBm/5IZAd/rFkCRroAfoZUDym0Y5JxASj95yYv
 D/BtIELUkMhXEK0MHPzFwnhNZ9d/7ERQJCwDTtrO+EF7oLYaJrmq6FmpaGyW1WeflFkD
 LEEjBnh0TPuv02Dc4V/caUJZhTFm6Z4gcuber8qpvXjY+YzpyqejFGhX7QhQORPJq0WO
 UlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786197717; x=1786802517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LWQEkJchPYeC0ZoavYUr3xCkFVeRdSuQOuSKSluD+U8=;
 b=Jp7KMjKT4ueFGeOcbLYPAZ5jra1+wMoOhxY2XOfZHSgqiUwj1bEIic5Cdkt5z8a++p
 MltAtXowKLGNMccfsyFQlQxnL6rdsZ6HqblqhA/9h9hDzbzSBlZeEXmZsLUVpy28zNCZ
 u4akSoSBwLEpb079TKKA5Q0wmmdUnK8l1/E/zvqjRhErW3cOS3i/Q9YxetFdpAfbInYh
 4w/AHjvdPRpKA2ElEu97zSUF1BB+xyOKCcRlj1ZuOuWRtst2E6Vl+eqooHij1ftkgZSV
 ME2TIrAycvuEzoGsdZGIsB7cGszLEl5FxshzsRIIDmJF6yAsVKELfbawl3JEtZ9ZAYGX
 60pg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+8ca2PPJKvzQGJbJID7DOSbcB9iG+RU4F+A3fwo52CWE+GFexMGq8WbPMjNPZiu6Qq9o8ZBm3aMA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAGKLYlCWa2DUzNyxrPmeR3SoKw2bpD7f36T4W191npIuYhJ8X
 OowS9vql/tQEO8eX8bgnflQiAICcJOk2MVfyjbh5iKFXYx0FRSTuBReN
X-Gm-Gg: AR+sD13GIl55yasxQJbh0Xk4XV/IINVxudN+6lJJvzfzqM7JNYjXmw9zM0WVbZRU4B1
 YF3JEaEU4/mZZJUFJzfnSn+KJkEDw0rVEtMhVoiClbea/T7BoF6Os46Km72icAUOTjFrRUEbtaU
 2HI5zx/8m6Xc0UwWB4tCgam2XGYWWUEa0pIDlOFV8+IdHotNkyQPFlaJ0XxjISucA9a65AngHl1
 1s0y5+iQpwG9Ti3jqjOYlQ7bVJX7szlkw62Ml7o8NESBAi59L3ZDrA6WFbGvsJM8T9jjeYH5aPC
 l85ya1oZsQ3AlK7siiZChfrpe1DTrv7TsJ8MEIDJt1m+HuuTXQO38vdY3vNAScOZA0PW0GkvSQf
 Gcf051Js7yAe+21WVTtngwjAjFLVrqbgk6z4qxUAzWJq3gQ9inPmsxj4XxFFbSzfAyAywh6PGvx
 6h7Hl7W1IttDOobpHOrhUoauk+YeRmlbTZ23IL4SrNb+Q=
X-Received: by 2002:a17:90b:3f43:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-3903c54302bmr31739321a91.8.1786197716470; 
 Sat, 08 Aug 2026 07:01:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085dbf82csm8638162a91.1.2026.08.08.07.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:01:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/radeon: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:59:42 +0800
Message-ID: <20260808135942.2880971-1-lgs201920130244@gmail.com>
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

radeon_driver_load_kms() calls pm_runtime_use_autosuspend() for PX
devices, but radeon_driver_unload_kms() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
unload path.

This issue was found by manual code inspection.

Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index dc43fd790a9c..4a99c09f4164 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	if (radeon_is_px(dev)) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	radeon_acpi_fini(rdev);
-- 
2.43.0

