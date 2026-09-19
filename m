Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99768C982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1A010E1BD;
	Sat, 19 Sep 2026 16:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kz2wbrII";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA87910E2D1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 16:50:18 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b5b07ec78so1215516a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789836618; x=1790441418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4Qqo2m5lZfr3OAGZ6npJ+URqdVjHxYgzHywKwbEg8A=;
 b=kz2wbrII9z4hQd8AqYrFSHyanA/rz2aJlRvvt2+MpiSSDUc2gDPBF5zqxAxJ8UQWRa
 yjzTq7HCQsty/x6c4fPCV3kEHB7JnWQeGYwbfGwtQbAuGwHuMxxPIDZwdjcG64OkHQJG
 xNQKqcJLTbErt3FYiHNchgswVQY12zWRefrBft3smzrHGroqGEdo1mQjhxk4qP1Ys7eM
 eWkaZPS2h9UOcycwBDWYT5L7/5v7Ne+iFHPhn1QNXin8S+YZhSGdlaaBIOKEpdZ/NAie
 RA7E32fRGhGRwe3DPJMlqo4CNOxTRAPio4CMQMxWuCdifELlgUQS5RZ52hL9XJpGS379
 7g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836618; x=1790441418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4Qqo2m5lZfr3OAGZ6npJ+URqdVjHxYgzHywKwbEg8A=;
 b=YfR932ZpkxgbhU8wwKbq4OMuilUh3c65zTKiioiTcgIoHFvFC+hOXlFnuD+7exb1oD
 BCLARXn6a61yi1U6n00FvMLDs4oh2F0fXxV5W7qCDmngAj/YhZRxCQdHRZXqup41spqI
 jQTbumn0xwDviD2DxkHCQ6Mn6fKDSWGuYNQqX+oSSz1zCPF2Z3ETdoHGL//1ElKjQtW/
 AoUKXvbevzN4pkSxpYY3pHeN68zmUL8UfNqHiEzFU8CGidrDkMcxtOEkru9k6crA1Zo/
 VtUWwEJPuUL9dZw2/R7De9Va332TePHmQ1SVUFIpgQ0RyxGlC8kMezYtIt51xizWQBmG
 +vWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaA/5/zkvybtCM/0JOAUjjotPcXvUHt0EYEU5ZbdXYsLT3kkumJoCa6qXyLPjl9atalFajJHsq6xY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYxS09gNMlpg3H3+4pmlXiM1iixqlF6AV6CS4W+47mySjIgr1Z
 qYXLdM+BCHXbKLpNvuuh3/npG9mOZaZcd+f6X1gLb5snFkzZ69TPQiDxlkDmhBLn
X-Gm-Gg: AYBFou2V9aZjU7aFo66DduBJIAhrOpdlrw+NrKHknVQt2zVL/F7smr0JfTDTdD8+qqT
 wMVPtpMYJwDjWMHh2NVEwhs8l1N5ZA7U35j3EhWnsmyx1uQSSx8Uyy2DAU2ewrXK0FSKAus09ah
 QWb9NKyTzsPpniq5AyYntl1QdYjh1ps1pKS+pUcijzEf/iUIfpqq/I4QV2oLWTkF0ZkUOVWM1Gn
 PS+vr9Q2+HMhVdCUnDC+9vMjLkZyz/HFzLQQC0m7EjZN0zXFGrxxabPwftVstvS8PyEQ47Pld1U
 HSG2Tl+6KhF4LWsgrAZLzVeiwrH6jC2ZK8GjRoOlvKobprd9BESVmLTCuWzDHg66RNCmOJtPZA1
 TAlE7fUTf8UR18XhmD3EATeP0t4mgTJfHFffsFIzFhbL2K+XlIji06iJ1rjf12TGxsTbiITD7Cw
 wMzrFMBCg+HDLFMBrDyJmhl/0xRz8UzveLvf85GESnypuX4bvd3EINUzl7c+94jXhk/Aem+FvgV
 Q==
X-Received: by 2002:a17:90b:52cf:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39e54bd0941mr10914911a91.15.1789836618094; 
 Sat, 19 Sep 2026 09:50:18 -0700 (PDT)
Received: from G15-5520 ([103.206.144.198]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55cef9bsm7531914c88.10.2026.09.19.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:50:17 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] drm/amdgpu: replace deprecated function strcpy() with
 strscpy()
Date: Sat, 19 Sep 2026 16:49:59 +0000
Message-ID: <20260919165000.36173-1-lalitshankarch@gmail.com>
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

Prefer using strscpy() over the deprecated strcpy() function to
populate ras_block.ras_comm.name.

No functional change.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..8bd91314d0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1132,7 +1132,7 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "gfx");
+	strscpy(ras->ras_block.ras_comm.name, "gfx");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->gfx.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 5a60d69a3e1f..3fa533d5b18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -39,7 +39,7 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "hdp");
+	strscpy(ras->ras_block.ras_comm.name, "hdp");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__HDP;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->hdp.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 363b99168478..969ebc9d5a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -328,7 +328,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "jpeg");
+	strscpy(ras->ras_block.ras_comm.name, "jpeg");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
 	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 9a7f7d2b2767..42a05b5a2d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -87,7 +87,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -112,7 +112,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -137,7 +137,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 0f6b1021fef3..9796428e44e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -36,7 +36,7 @@ int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mmhub");
+	strscpy(ras->ras_block.ras_comm.name, "mmhub");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->mmhub.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index e4c8e98725f0..785bf29d2c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -37,7 +37,7 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "pcie_bif");
+	strscpy(ras->ras_block.ras_comm.name, "pcie_bif");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__PCIE_BIF;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->nbio.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..4e520d16e550 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -327,7 +327,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "sdma");
+	strscpy(ras->ras_block.ras_comm.name, "sdma");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->sdma.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 71d34fd09385..69fdd075e14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -315,7 +315,7 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+	strscpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->umc.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 17db7264269e..bc7b5733f581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1333,7 +1333,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "vcn");
+	strscpy(ras->ras_block.ras_comm.name, "vcn");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
 	adev->vcn.ras_if = &ras->ras_block.ras_comm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 45e31b3daf06..5babcba1907e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1341,7 +1341,7 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl");
+	strscpy(ras->ras_block.ras_comm.name, "xgmi_wafl");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__XGMI_WAFL;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->gmc.xgmi.ras_if = &ras->ras_block.ras_comm;
-- 
2.53.0

