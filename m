Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F7106ACE5
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E9210EAA0;
	Thu, 12 Mar 2026 19:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c78TC7Gx";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC2810EAA0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 19:55:48 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c7393536e53so575876a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773345348; x=1773950148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nM+VdCqvGkbedLjqKwSi2191Tu/5SDLEyyDq01MI7Kk=;
 b=c78TC7GxTfGF+UUekKb92eM3cuTlFvm9KwY5yLiHBAodzX8m1Zk1y4gwTy2Iz/WIow
 qF0faPrSBeeOPtrzEdVmuH6CB8/HZ00MnlY3QAoaLuHexYHEICw7YXKLBQJIbXInKiwf
 xpRfCwsiwQp84NhlDll+dhmYXOzz4ug1Gzq6ysLDObZEEDVkQiw3A2McgkWjdXlbt4/S
 W0vgjv6P1j0TMZSBGiEcB1q0SfxqMpGlVdYSzZd+GB7g+Ce7DG7mguJuXYrfAGTITZsb
 TOCN8YUxRvM1ZnQCDYP4vws/K0A94fYEE9HbMFU3ptYlo2qnnsEgkcPmGnVGD8zkz1pD
 mCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773345348; x=1773950148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nM+VdCqvGkbedLjqKwSi2191Tu/5SDLEyyDq01MI7Kk=;
 b=hPj6oqHiozYrqYC2rQMP1Bs0uv/90OqhCuno4K161GkVV0uDE2TzfHkYvVRaWZVfdW
 vOCuIDjyExyHn/aqi+YUXNEE/68InWLgS835M6eixXK3KNlGA73etifEZzrGTHzs93GF
 fQNwt4GmsenrTQN+MW4PjndhSfX4MtZKFwQ0K1EkP/vXfBD1eUpDyTvWW/kLIyNt0zOX
 FEqEkxnX85TKJy11ISuHy0WRrvuhr77ESw+H6QX7yCk7WPi0drDZV0L0z+hHjY6Meb/u
 wzJQ6ol/eCuC1f2qi5OmTsPIKsB3v3CFtAMMlM2dvV6ju6AHa3bIuEr7WFreXROY4BN9
 ZMfg==
X-Gm-Message-State: AOJu0YwGwC8pa9TBnN5Jtbd/PTyOu29jnMTIEmaFk2aBZcjojMqQs1eu
 Iw532v/GT0p44D8DVCg/Mc4uw9BC9ejO0u1WLpZxJYx9cJ3oXINLYNEya8lfOWST
X-Gm-Gg: ATEYQzwMGXnag2cHQETp/6OPpb9X3AKUg2GY1QDYP8ifuQU678u3c05+luQdYHILF5X
 PmcUEj4lhAZlWo1aUGOQwTgjX2/rVrtkaH6ZfU1xxzH3en1uVn3vKRPdVWrWZLtMeVuIGmttRaH
 5we8myGy7sPuMOca8KwaG70yFXIkjmWwPpRNnxIXCBYU5w5QKl6Wcai8j6se1QFDhz0jscIu2h7
 GZ0KM7617tO1QZjOAZqCydiiEYZMYiRlA5UzAmuUG+WQnnaHFRycVa8zmC+7tibWL/941KW1ZNC
 P4shCNaEgKWVTfwgwHuPsGrFMjPiHai5YnGGe9wobyLPh/auInVjnfeJwVDU2wETKzPCBOaeVhR
 X1AB9uLHbtoj9DKAP7Xkp4BKZUleR1yFjtx2cgPhHagS/kzzsep0haZSp7D2tRIJj0eH3TWVbAC
 4uT8RzhwbWR3VJwox5QqKbKJrR7sSUESwbMk3gTKxFVIM59UzALWDkY9lTtmkBppN/
X-Received: by 2002:a05:6a21:6d88:b0:395:b6ff:fe57 with SMTP id
 adf61e73a8af0-398ece117a4mr430955637.63.1773345347582; 
 Thu, 12 Mar 2026 12:55:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e99dsm5361786a12.7.2026.03.12.12.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 12:55:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO
 GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nouveau/vmm: use kzalloc_flex
Date: Thu, 12 Mar 2026 12:55:29 -0700
Message-ID: <20260312195529.13002-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Use the proper macro do to these sizeof calculations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 958fd78080bd..b9648290dffb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -53,7 +53,7 @@ nvkm_vmm_pt_new(const struct nvkm_vmm_desc *desc, bool sparse,
 		}
 	}
 
-	if (!(pgt = kzalloc(sizeof(*pgt) + (sizeof(pgt->pte[0]) * lpte), GFP_KERNEL)))
+	if (!(pgt = kzalloc_flex(*pgt, pte, lpte)))
 		return NULL;
 	pgt->page = page ? page->shift : 0;
 	pgt->sparse = sparse;
-- 
2.53.0

