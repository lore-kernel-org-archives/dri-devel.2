Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4391FC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3FB10E039;
	Sat,  8 Aug 2026 13:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z6cVKASU";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA69010E1B3
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:41:58 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so417045a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786196518; x=1786801318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5x4mrfTwKDCuKeGOKJh1sjTyl1+66+prXU9ablIRt+g=;
 b=Z6cVKASU594RsbR2tHm7FGkQEozqNNAqz1g1Zjd+Rcs9EMTUUTi9IvbS2HMNIjO13h
 VmeGncwPCGwgg8i1L+4yqZPOtTIh5aVx3MemxI7rOY9DMkRMF3KzQTGdo4W7R7Jp1Kwb
 cZFxPBPf02AHalRh7DZNwqXTuz2zeZ/yogWl7fUaxQaI16MP5wBRTSN6Y9Or7HEpG852
 R6bMQ0+9unAL/qOKh/2gGwTbzBA46+cC2eXD+A0Pov5s7zveASqNoVC/RQhb8NihglI9
 tgXjljZykFhcgPdmzWh6DAymqc11HiyXnUmtGQaFsvxa9cjjAnQiSYSdkKNfBMat2GK6
 kcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196518; x=1786801318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5x4mrfTwKDCuKeGOKJh1sjTyl1+66+prXU9ablIRt+g=;
 b=YwSddPsG+t0xgmJSTU+gYhK8Q5IYpn7wyhvCXI01w226ZSplvticvLLbZPAR9VDYqE
 9h2j342/BDjgcOUb89gsLmzf4uY0JgwheB4Dtd8LOQp+AWUCszFGLvsjkZ/61+BYJFxz
 wZ5OiRYCgy7Ig/A1rFIHoJS0lKKXpco2Hh0o8ZokxnjUGoDU8zSYAaYKqrpzf5pufqEy
 6keMA77YIsonO/ikoaO6gIuYLEaYiIszKBc7ZkfoX2Ai8ChwLyvyiaYqsVlfDpuaeQqv
 2onDY0UkEEJbVjs7SOI4yosLh7LE1HcexhKHZBrmWPJ5DDXMvlaTTCpAmNk6aPh8DS0u
 4ufQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYAT8E18/ipXN6XktxgOedW4nkvuWFaXZQGPPhgG3pqMHBT30hnw2RRJt717NasfKBlxYNyvouCiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yywtt3WmKPZ9/P9jHiIeHZqC2aC2qPHsU/rJ7bzgYY8B0o9njEJ
 xonByJ8oYky5t9ZdCcbwwvI9L3MgAGYzl2zjQsENEdXQwBGQUZEOvwdj
X-Gm-Gg: AR+sD107rTYm/dnIsOjP+FsH3GUcOe3Ej5wGUr5byM35vEotJo1AdiQ/RHtxwX7elws
 /keQI1g9wFbEIMrh09NvW8mZWzG5mYnwryPNlRc4bZjlNn44eAcAYZEz85FcNRU9VR8QiTQAgXk
 vItgbmW0Mt85ipEnFmS2C/Uz5281ZJT8Md8pWNJVocIhb0nj1+cXdrjmMUfhlEkB3GR+6unGcBL
 KW4xp6+PUt7ciNl6CQ/2otOQ+5e7tgjVOsl536J4h5g8akoZybh6o6BalpoUv69cIEMR02OXyeL
 vYpN0ZgF7kHnLReIDco4x+fkGPCshUREIW4jhNe63rbJJgY7eNRO0wWCncmmyoA4jiMPhdSo3v/
 mQoAI8w+fnQLwW8GM2TVGMhN/tanCj1P0LpUUkK+FQNmz/f+vQoZCrMtlQriQhlwA6ZbCPN0Yvb
 NNGYiacfjKeAXgixyq/S5fgLZMo73Gnr2jrp6wOwT69WqsBMwBIg==
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-3903c5932femr32396260a91.13.1786196517998; 
 Sat, 08 Aug 2026 06:41:57 -0700 (PDT)
Received: from lgs.. ([152.32.188.52]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6f13dsm6278888a91.1.2026.08.08.06.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:41:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:41:37 +0800
Message-ID: <20260808134137.2864847-1-lgs201920130244@gmail.com>
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

nouveau_drm_device_init() calls pm_runtime_use_autosuspend(), but
nouveau_drm_device_fini() does not call the matching
pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the common
device teardown path.

This issue was found by manual code inspection.

Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index e16f59b00f6f..1579a4b0785e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -585,6 +585,7 @@ nouveau_drm_device_fini(struct nouveau_drm *drm)
 	if (nouveau_pmops_runtime()) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	nouveau_led_fini(dev);
-- 
2.43.0

