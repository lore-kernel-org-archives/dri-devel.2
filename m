Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A88C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B64010E407;
	Tue, 18 Aug 2026 10:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKuG5bfl";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7259410E4B5
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:32:36 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so36800035e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787049155; x=1787653955; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AaTdQTQ5KDHtFKgVM7cEDQIq5HDLA+lElYs4fROzZ+c=;
 b=NKuG5bflyMeHeEmPqw0vzp3Ik7ne/my91kfce4tCKV5KifYUnmXMW8a3hOIeJDr6q1
 qGR5tR2nssEq7Lu1dGO29NWfi2uvnepBN+iT4V9qW9e1qs8xnUGQHn2D4U9kIuTAz0X5
 u4LgsRckfIKxS0uA9mcAOKMf9DX74coMKri4LELzMhIbVHRzFAe+CVvrRq0S9d9AgjtE
 R21BOQxL1uRpD4w83UPTRFS7Gl07cHQFD2NyQl8W09dsnKQ/FrDIY1k5Cq4F/5NvX3dG
 Sq4v2o4knQgRcDVvCWiP6hAAQrbUL6fPC386CvKYc+0dcFfMhllZQkxysNeuiBrKH1AG
 OboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787049155; x=1787653955;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AaTdQTQ5KDHtFKgVM7cEDQIq5HDLA+lElYs4fROzZ+c=;
 b=KY4CaEHx2Pr8qEbrnwBloaQkMsPJpiuM5Mml7CE6b4YuYA49/e1CviKiSKeyXtCEbD
 XohYWFwF4kbK2KmB2WDcJDzeFuwYUxYCPoADMj45f05m3U+HGdQIzAOziMkp9N1Xsc7I
 Yegv3zEdS/M6OsMgT/RkuwT0K6kAS2lphPL2BcRZZ5aMvyecz19taShb5I9xMVp/0cwD
 nv7AINmGIDETsFip/YiNPW+V9Ly8qqGmc5g7ooyKYgxmoM0P5i9v7ZNpHmbEaAIMBjWc
 1PixcLFWVl317qyw/Txnd0Doj80BDMUFkCdfRUqrRItI+ECjvEQ+x4NjoxQ1top6TgVm
 hGUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq25WBYxnHQmN7IFte09CBzOdQdiQmPiJ+qxQ2DzdvHi4NAnJd+Ay/6avpZNdk50M10PjYNoJDNIxc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6aS9E7uFp2qZOixk/5jAnyF2dIAR/+0QXQpPLA2Oq2DDfZGfl
 EmwKbEoqC8xCEEXMKg/oj8C+6i8BQSOGJKgSw/FDCpmR82UpYit5OYZV
X-Gm-Gg: AR+sD128ziLo8vX58oJ4Ui0NzrUiT460Xzua58icWEcQ6r076vk2cbLm3MwUv+yuznC
 UzKVMCf+Dobp10SGwPyV1N4jtHlh7Oca4uojMblZ+HxYInfcuqngU3U74/iXaZ1DfxYmWGXjmgJ
 7IcvblkWA3kLZxiMV/26vi3KVYUlYixMlnRCyTadkPuGHAvEpZfauuIwfSFKBAe2SvyA76EFDv7
 mUtPlNxLkSmKmReNGihlFGPUlscA3Q7YaZs4AFGcQX2JQg6Ok0WKcbeRUvHZwIjdmSR7u2pwZPZ
 dRY1PaHADGj/w16VW2HRJZVnsz5rSf5FsMe58VnX6cecIKlonBHARpkOy4wUHNoN5IsRaLKd9uU
 lLcUYNU1a2yOVropdBRfXUfAHbY3yD/O1hyC4m+iGfPGbyzYPvvv1UxH/FDwskiE1KMnGXoIVIi
 dF59RcFW9mhSvq7XlJdaDsxGbnjU91lJt5I4HODmTU1b7JILBFpdM814xHwBT1lfUp3qP3Tgjwz
 YL35D6/bPNYwFpRFP719cuqdq5pu3HvgRXiGWbcb30xhcxErHBUA0rc
X-Received: by 2002:a05:600c:5306:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-4999fafdb79mr142980085e9.8.1787049154516; 
 Tue, 18 Aug 2026 03:32:34 -0700 (PDT)
Received: from [127.0.1.1]
 (2a01cb0007c59900868885f119326717.ipv6.abo.wanadoo.fr.
 [2a01:cb00:7c5:9900:8688:85f1:1932:6717])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996183b89sm286950535e9.12.2026.08.18.03.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 03:32:34 -0700 (PDT)
From: Amin Gattout <amin.gattout@gmail.com>
Date: Tue, 18 Aug 2026 12:32:00 +0200
Subject: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ80hGoC/yXMQQ5AMBBA0avIrDVpu5DWVcSCdjASNB2EiLsrl
 m/x/wWMkZChzC6IuBPTMieoPAM3NHOPgnwyaKkLaZQRzeT7sAleowunkGi1V0Zb6wpITYjY0fH
 9qvo3b+2Ibn0ncN8PgUo2VnEAAAA=
X-Change-ID: 20260818-amdgpu-strcpy-0e92d18299c6
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Amin Gattout <amin.gattout@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049153; l=2002;
 i=amin.gattout@gmail.com; s=20260818; h=from:subject:message-id;
 bh=Z9rg6SsGzP7wm590tdNj/0vQ4mbnDFtBl6dpCEg6CDs=;
 b=9xpeH0/D3c0TwnMtjtVQSYoVw0OGC2Mm2rbnA+SzNRcXNiA2RICYmkzbS1cQm5NFbPQv+KFiX
 Dh8hhR4CfEKBrVrHn4sGbn5JTaAPvfHw0loe+4seB43vcRLZgS/+H+S
X-Developer-Key: i=amin.gattout@gmail.com; a=ed25519;
 pk=MSIqDPkCOkwtyP8Fns1m+KFU9SgqoDl2mpLe18vL+hQ=
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

strcpy() has been deprecated because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().  No functional changes.

Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index cc6d1a4e4c3a..1caa393c44d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260818-amdgpu-strcpy-0e92d18299c6

Best regards,
--  
Amin Gattout <amin.gattout@gmail.com>

