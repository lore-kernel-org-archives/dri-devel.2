Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55242C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4780C10E00E;
	Sat,  8 Aug 2026 12:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFxOaEcR";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6710E00E
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:11:49 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so6587425ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191109; x=1786795909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qqtodrANULHy2HebqvyH0gpSUnDrF1cP92+56xd0b6c=;
 b=IFxOaEcRABrCwxu+m9I5y17uFiTiKh6aa0dQaqgiinMoGmEMA8cFaTs3WkLzouHmHo
 sgWtv2kVBkiwGr4YHid0mA0/+oq5+vEoWq4W9OxQ4IgMD5OQ7L555VeKuB2yiEXmDRIz
 T7XLL6KF/nQ3r8vcIdfPW/QRmyXCHmGm50VmGGjK9Mgz9lV6qYjjuu09PUxx9aNwnnOq
 dx7HlVBmr9jybSUtEbHJK1Ey9rQZ4EmN6E2clgb/L6mo+k5zbVf3OzMey+W6QmZghP5O
 PZ9H6YOkAuXGcaj9AMekVLxMJL0x1IKaWIXismZEUZqSSLSntelVqgayxeoFXr8XFR28
 ZOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191109; x=1786795909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qqtodrANULHy2HebqvyH0gpSUnDrF1cP92+56xd0b6c=;
 b=QJWDewCh9NpEkdjfIZvaOFpQOWTq/xliQKAW9G5TI174DYpciM+M3VrlNup06TJhYQ
 M68kXXNrd4winfW2gmdMJuXt2hZqrhEm+bpKsk40sX6WFnMkDzQZa1miElBPPNtOA04B
 CjbXgVoBoATrqWuvo0XBWybmI7ubrICleNnraf0g7pNyx+SxiMICItfZ84TEwy61Ks8N
 2TyJVNrfc482VJkHqaKpwfBT2BLafb8B2CxaFAJ945DMqFeixaF/mu2WxHVpj7TNkuCh
 AgaFlHc/zsehUhmDJiF7XpdhmegMrCcEiXBv5XElkHIGj1U3sYbvaAsT4SGj8bJtbUzq
 crQg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0G2uQtUHgEhpw2v8VSGS2cmXEKsXjOR0wiDJ3bRNsu73DaE887bM9JqcXRZfH8i1dhUIPPI3gc8g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7ULcj9S9bleiA76DNp6saR3DljCU9GTDi5wPCIg2+9Ixodn7V
 s5AFzAa9wldFUn+N17FlgJssyHvOuNBsJbQjxbX4mPZPnbfiOdxRTAYe
X-Gm-Gg: AR+sD1230ULOkI0wuavBmwUfD1b9xVGIK/vZ+ZU4DtFuj4CiTvvC4G44MhTV5rm6L8w
 nWAF/zmOD9TLArsoCyx8FTd7l7PZenyulvvagrn7FXE+JvsdQ5yxXDDCmjWXEB7Uq+9IRejfQA+
 kaQYAxL9/7lX5k1boBoJF1yCe0MOyq2Tao07Dgt8eYqJrFp8vAeb4nHtINHclsG7aT4LaIJQZT1
 a2SJS79d3eTrK4dzUkdGBjM9637B5xwcoWJd80l0Sb7NVf3zNPkyG7TvxKttmXbDKZbcE9UGf9h
 TgmaLwqq9Sinoz+iQqBE4W9TfuKkJfHjP2hdRSzaXuuyBSapFopbkA4AA8X+loNRlQCtmd16Elj
 53KLk/RFtrcaf9D0iaiTA6y8qq11cHwCRFxJvJmLx/qgdGDel+NotC6gYLzQ+1sZyKtjer7OwqM
 yFinnzbWeL/1YCWsChostcIMku74Ed2ROK2krwMmFXL5g=
X-Received: by 2002:a17:903:2383:b0:2cf:4544:104b with SMTP id
 d9443c01a7336-2d294b29144mr139478015ad.5.1786191109424; 
 Sat, 08 Aug 2026 05:11:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14dbedec6sm18151975ad.44.2026.08.08.05.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:11:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
Date: Sat,  8 Aug 2026 20:09:34 +0800
Message-ID: <20260808120934.2813010-1-lgs201920130244@gmail.com>
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

amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
amdgpu_pci_remove() does not call the matching
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

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1aed121f4ddb..e814701bc8fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	amdgpu_driver_unload_kms(dev);
-- 
2.43.0

