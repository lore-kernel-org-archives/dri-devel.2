Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81148C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC1F10EDD8;
	Wed,  1 Jul 2026 07:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAYe0Maa";
	dkim-atps=neutral
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E05B10EB39
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:28:59 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id
 98e67ed59e1d1-37de961d1bfso3247189a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782804539; x=1783409339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ul3/ISJIxQCHD0fhKywsEwyygt0y3z6uVSVG5ItbopQ=;
 b=LAYe0MaaDPouoMXfRg4Nlvzwm3f9JQ9BVL21g+3LcehYE1xpGRIh/eMzncghPmgKYL
 02sSuDer9d4CBl6oTp7IZfkmgpShxTU7Sx7r2dGDULXN2KxLi3+BgD7S4eYesOxtHBJ/
 7dYnLyB+ThG2Br2N3Z1zGbNL2WCObnLl5p9mKvsyOJEQHyretnOnnNRIoT93mP60MYY6
 S/XJ/Cm4gcyn0cboAFYCRaD9zBgU4dU6YM6WDaetK7nex2h64IX170pEgkR1MhIi7E3p
 ZN9iJS5PYJ3iMp4Q8B8dTGUneI56yA53Ghouwi8WZQKVnxZeKzLmp9+PDfjAGBXrN8qq
 H62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782804539; x=1783409339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ul3/ISJIxQCHD0fhKywsEwyygt0y3z6uVSVG5ItbopQ=;
 b=oMCMEW5yuJUZGBa3B6L/NDBvtCb4jNZW0fHWLuPtEvQGcD71DQbLt8MvIyJKvwufIO
 5IjQQQown2zKdWcQEMFjONcWy+eeWciBZbMfIGhYqQIEaOzhXAdxbcTIfk2BLPQS60CN
 hAew1FGydcTfXEui98h26GuWPViiHxH7j5KotneEZwRfgEu+iCRGnCOuXt6X02vDrLUT
 Idb3iJlVeZEUzs8vqQEYKAKvxZ5nMHKKfWzoXSH+S1gJIBuUPeZDA6neUAde8Lfg9Dj9
 uRGNvtr5J2r/+R0MQOnCUjfBAAKHD71f3MWFKp03tZzw4aElm6Bws4wxCiI5EgOrLAN/
 ax/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3WWE67He6UGQ0lJFRvL65liYpIYSuE18gS2IXEZnZcmvTVj/VHz3OT+gBb+iNuB6av56dyDqFQew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2RnRxUNQBaY5sBPaljKL6VXAHDRVFpYYGIy9ENE8/pC7CaCk+
 Echn7uurJSXyGFtOsa1DBaEEB0r20GOyCK0OPea1ii3XJmar+aBp7h3l
X-Gm-Gg: AfdE7clK2euLvSC8WtvIxQJ9nkZC4b15OzpR4Y5E/bWleBCYOIMrWkPJNM/somu/V0X
 YoWqUGZV32CPxw2v0ioEqmRQflPp1FhGAzt47LIYfJ2Ow0S2REqJDXlP8WcFI3kHLPgr8Eh203N
 LFzf8x6Y96y00IY3RYsOB8mPVmOWQieYbIre5583FvpvC9XSkvRk8Gh5Zvg38cQc56GO01aWOQ/
 cHkK18B5Nlg5Dv6Y05Tj/5xLQyR+y+nE5MoBWZjzyUIk+Se3zHGp1ouaeAFgL2HOB2jWDREANQ1
 4CHQgyl4cWBzMl+y3o7x/wheqIBKRhjd1jeVtL4CDEHTnpfvQyYAkwOjZEJdy6ZHrjP1IOfna8N
 2AsJ16UcDNCWzTcLfKvryIk47AtH3YVrHs169CA/+PVPZVxhFBTdU4fZn55mbJZnttFMZ36TxWH
 fHmQF0bwlbTX6gvPJY0O/YAB+gYv/kGw==
X-Received: by 2002:a17:90b:1d02:b0:37f:9ce1:cda9 with SMTP id
 98e67ed59e1d1-380527daa2dmr1895486a91.31.1782804539506; 
 Tue, 30 Jun 2026 00:28:59 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32869sm1137101a91.11.2026.06.30.00.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 00:28:59 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, pierre-eric.pelloux-prayer@amd.com, lijo.lazar@amd.com,
 felix.kuehling@amd.com, srinivasan.shanmugam@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ke.zhao.kernel@gmail.com
Subject: [PATCH] drm/amdgpu: Fix typo in comment
Date: Tue, 30 Jun 2026 15:28:38 +0800
Message-ID: <20260630072838.67086-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

It should be doorbell.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 16c060badaee..b7be28d74e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2187,7 +2187,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* Create a boorbell page for kernel usages */
+	/* Create a doorbell page for kernel usages */
 	r = amdgpu_doorbell_create_kernel_doorbells(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to initialize kernel doorbells.\n");
-- 
2.43.0

