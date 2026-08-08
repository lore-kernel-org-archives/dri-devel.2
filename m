Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFF2C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205FD10E679;
	Mon, 10 Aug 2026 06:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvsUeoJ0";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393BD10E1E8
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:19:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso3304285e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191545; x=1786796345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFo+FAm9dOuD7sRaxc5XvG2wnDlTsCrM8DjnwJd9TPY=;
 b=WvsUeoJ0o44IBhPdHLdbsK5+tCMziEw9AUAFu8gzfzcU22TbdWZ7Zu0tBFU1f7jncC
 RaydJ2GCh2L8uzk4VzmnqoseWaSCzuHeZEG9PNCQ7mA8GAHUHfzlSuNH85ODylJL9hPT
 NTCyfnHIoqlUri3kUEPVQCI9FinZOrf+B2Xq2KY/Hr5wcpx9AoIUhBQ3cYYIlWjD35/k
 ZR9y9YtsTE15p8dtnd4scxXU5Ps//nQcwplc6jmiKjbIcprnq3QN7zLRpimpByeSDTZc
 ZSiYdO2YYpQYIhitRw2jPS0+E2/qwYi8Wa1HvJvmZZbUMMSq1ZOwUA8oJn6GaWVejh2L
 t5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191545; x=1786796345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFo+FAm9dOuD7sRaxc5XvG2wnDlTsCrM8DjnwJd9TPY=;
 b=EguNYtbkLkyBWv+f9sGe/HoRHGJd/b72ThfhJsoXWBmOwY1/oBBd5AL1SlUd1WjqxS
 tckMiK/fO1Fz88D81zKoxFd4kPX7Pj8ryUFlLtaWaoVnUWBTrUXOKeGkjnwqXiLoP8+E
 1x2WvDgfze08Zi92/rxXygtm2pfEp5siWB+M9KVTAvplI7qT2CSj37k4erTBMwx0vh19
 ruv9rM5PG/0559HwXc88Yz/zLUSOELhCr9enyhH3H9wnw4Cj1WK5m1R3Qt9Ei2LDTu0P
 eNG9n+HSUc9T4Xba3Kk2fqvNsEauaIWYak6MZToeUNlHisG3s2Ag+0aiR3lX6p8TIZh3
 DTuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnM/JDRHpcOA7eN4C8PtxwNeJE8qlVkIG8zeTdJLZUQ1MiBBQhxFivrs6C9U0X/ikh5ePJvelJxsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwamJ6p2de6RXEU0Iw3xY7OJ076nNNukRph9GehCt6hqplMhL4U
 6hkVS/EQBoByp3aH9L09puYje6J56s/Yrhv6PAJ/nNGIP3hygT9qVCSx
X-Gm-Gg: AR+sD11YE8/LQoADi4muptW1MDj5vAEupXP8DqAZVfCneDeHNIGpjXOIlx2yDleR/PS
 DmXwRS5VdY+0xmxg7QBL4pD6cSCuBLK46WSv6hOxuDa39Q/L0yY2ATKKoHq8aZjaYObFkohpVrT
 VmzsJYYPgEaZKVu/hAQ4pLyYtXD1A9FyJ3TI7YgncSEGL+zhJGEirOAmwnN+wI32dr/wLpZAC8o
 HJSNL+Qwi7Qv7ck0JNa+xJVhrCDDEL7NdPdzrIA9WK4v40ve4zvKbTAigUG/WmcXeKRBQenFYn2
 lQPJss5IaLW6mkR7qcfpNOUBwcvK6lLy5dOl4gd0UBELDjD6mOe33LEf6EmhowjRysnY6QMx1sS
 Slm2NTgAWZC+Ywu9KZbCJRUnuJOnZLpr7ZEHogJq2jSvaMUYrFgs3b+rs3sc1gggtnShfW5pHh3
 MACgca+98h8qSRZDKl1haIWCI4LL43LojcrG7z/DH8f9E7vx2v5tHj2GckaAGrbKWrBK9kieZjx
 XjYoO/hGcBYmrC+7+aJGKiWKOqDax7pg4dcs7A0evQt4X02nInq4CwvxwgbMFjJBQ1TujkpmCID
 gBiVKNZqh3OwCVAqG6mNjvJk+oUYmyY=
X-Received: by 2002:a05:600c:470a:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-4995e0df176mr112874695e9.13.1786191545414; 
 Sat, 08 Aug 2026 05:19:05 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995421fee8sm212371525e9.7.2026.08.08.05.19.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Aug 2026 05:19:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amdgpu: fix GTT manager warning message
Date: Sat,  8 Aug 2026 14:17:45 +0200
Message-Id: <20260808121745.72691-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

WARN_ON_ONCE() takes a condition, not a message. The string literal is
always true, so the warning still triggers but the message is never
printed.

Use WARN_ONCE(1, ...) instead to print the message and keep the
once-only behavior.

Found with a Coccinelle script. Clang's -Wstring-conversion also flags
such calls but is not enabled in kernel builds.

Fixes: 7554886daa31 ("drm/amdgpu: Fix size validation for non-exclusive domains (v4)")
Assisted-by: Claude:claude-fable-5 coccinelle
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index f98bfba59a2c..f2ea881d39e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -565,7 +565,8 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 	if (!man) {
 		if (domain & AMDGPU_GEM_DOMAIN_GTT)
-			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
+			WARN_ONCE(1,
+				  "GTT domain requested but GTT mem manager uninitialized");
 		return false;
 	}
 
-- 
2.39.5 (Apple Git-154)

