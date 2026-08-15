Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98979C5CFDB
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 17:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B412310E0F8;
	Sat, 15 Aug 2026 17:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lP9bg+zC";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0666810E0F8
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 17:31:03 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-6ae3faeb9c3so1217037eaf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786815062; x=1787419862; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BkvQvNk2oNgW6GeNnclUP07CB2P6+HO4+248oqvobEI=;
 b=lP9bg+zCrIJBYXw4/wl1WxsWdSKDlZ6ItMBxLCZw8Wja11ALXJPkMIMvl3oUZrKFqJ
 4u0M6gcBx39TmpmGWP6eI1bHZUIGD8UpRzmGGa6ZWmoSGPVx9lFNx1CWgsDtbrUg4M3e
 s89YtiJKOHKT2RTLe81HJh35stlo5wW8x6LwBfnoE7XIFccJiWJb7mOTxVzG1cfGPK0C
 O0fz0gYIUqJTeyA8N4TLekodlgmxdD/aA5wnZGGaEItt/R5+nk1jM3WYixHueg+QnZhM
 Gape0uQE9Ghw6L9a6a8bMA9cXBfzACMHszbkepQKJD63YoRxI1lWYEM1shhbmLi3QqEl
 YGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786815062; x=1787419862;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BkvQvNk2oNgW6GeNnclUP07CB2P6+HO4+248oqvobEI=;
 b=V53zv1oETOPm1ErWH7RjBkUCcPP7vlvBECwZFaEsioL7ZUgbh/tdZipX8X6/NQkHWL
 tEbClZfA5VgbyMxyYafosKFdXc5NH4bigFrDvJtfCysQZ00xDuCtB5ZWNqo4KVOTwjlx
 tQm7nxNkgKIiZk5kfFsVkT+T0318ChOqxrFR14aVVZrpUppE6UPAq5cz8vW2aezoLpmb
 YNIrFEXvvj4DaDMS5G/9ZaD/sAV4TsqE0d9P6Nxo56msBkctVD0r451VsYOS7+WTskHl
 EbU6NtE60Blf48Lv3r67p+ppv4PwtfcFAI7rIzkpdR+ioMaBe/fReKD8a201GZCALjbq
 PORw==
X-Gm-Message-State: AOJu0Yy7gkGlyfYWx5aVrHrJKoU6+IzpujaFQzRng1sCoNtc+Dv6EOQu
 Dv+UcVAXNhfGhNpfFoGOqRLMlobEVzSRH36M1R2sL0xvkiK5TlDGGU6j
X-Gm-Gg: AR+sD10mrTb+mLkAh9rlWJg6xx88INyFmhA+L/hCHaP9rATHqcLZ/t3+oHmxzSfR1Hx
 1ai5u39fJP3dEXUordOHlqed1QeU6HeveYJJL3Ydiso59zrScXN+wVYESSFfwchkrLEjQgJldjv
 XQlXYO0D+G3DXh3gHVsTQToK5QZaStuuaa+JHjBaiQFiyBuUI2Dsx7OGKdf2bbVWA8CPbrOYfod
 EgpoHpfZLL2cHfzuKX7VBACVxa6FUjDz3RMwskFdIEqy1+zSJgSLZM8e4VQBCQfefeUIZltXN6D
 Ayo1iwnPBkmbADaNc3nEolygSfAZvKmvzjXMVFmUsSYoe6R8pj7uucHJJ0RXXSQNmpf1yAcrLYu
 I3aSenHbZUZdzZrE4z6y+B/oTpKBtpO8IaHpJxyjUDN7JE7/NhTldWQBmrwBXO2zg04bd9G8pjd
 eeUIt5+EIRmZ8JSfQdoFCPe15lqOUfqgmUo22EXH3lxoN24vKbIeCXjEdYPDkXWa6zjecARs/UW
 IzRPDWJxPGVVJcNSyy8Ap3tCekBNWGbfS3ZjjjYKVySAWCJmYv8Szx3Z9W5r5vc0LpwmO7JZGXX
 v7zFUDmyYow5jQ==
X-Received: by 2002:a05:6820:824:b0:6ae:33fb:4556 with SMTP id
 006d021491bc7-6b0d613f35cmr12820634eaf.8.1786815061905; 
 Sat, 15 Aug 2026 10:31:01 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7f3e86686c4sm4029328a34.23.2026.08.15.10.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 10:31:01 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] drm/nouveau: Fix NULL pointer dereferences in GETPARAM
 and GET_ZCULL_INFO ioctls
Date: Sat, 15 Aug 2026 11:30:51 -0600
Message-Id: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0NT3bzSnBzdtMyK1GJd01TLVAszIEg0TVECaigoSgVLANVHx9bWAgA
 SyjqrXAAAAA==
X-Change-ID: 20260815-null-fixes-5e9e86666a5d
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786815060; l=1411;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=tPxLL2CoSb3VmYmM9nMkXK7+/WPpCTFrGxjaNQhP7T0=;
 b=ow67/bAtMilaNqTNhXn9xssO8EWonROESywYsPc8eyHqPukYeVyCG6eQljyq13IoLA+1qIwJd
 1XrwYYuHaGHB+joMnCmjldMvmwC6l/3grGgzowk9fT8r30auMBLOnr/
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

When Nouveau initialization is incomplete (e.g. firmware microcode fails
to load or graphics engine initialization aborts early), userspace display
servers (GNOME/Mesa) probing device capabilities trigger fatal kernel NULL
pointer dereferences in the Nouveau ioctl handlers.

This 2-patch series fixes two distinct NULL pointer crash paths:

1. drm/nouveau: Fix NULL pointer dereferences in GETPARAM ioctl
   - Prevents NULL dereference of gr, gr->func, and nvkm_device->func in
     nouveau_abi16_ioctl_getparam(). Returns -ENODEV cleanly.

2. drm/nouveau: Fix NULL pointer dereference in GET_ZCULL_INFO ioctl
   - Checks that gr is non-NULL before inspecting gr->has_zcull_info at
     offset 0xf0 in nouveau_abi16_ioctl_get_zcull_info().

Both bugs were reproduced and verified fixed on GA107 (NVIDIA GeForce
RTX 3050 Mobile) running 7.2-rc7 under GNOME Wayland desktop initialization.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Jim Cromie (2):
      drm/nouveau: Fix NULL pointer dereferences in GETPARAM ioctl
      drm/nouveau: Fix NULL pointer dereference in GET_ZCULL_INFO ioctl

 drivers/gpu/drm/nouveau/nouveau_abi16.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260815-null-fixes-5e9e86666a5d

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

