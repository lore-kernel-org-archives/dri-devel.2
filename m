Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD668C53209
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5610F2F1;
	Fri, 24 Jul 2026 07:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RWVTmXDk";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E10D10E117
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:46:00 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1040989a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832359; x=1785437159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OFWWMcPCcMgyyaWxMapaPQ6yr5T+tvoKVuXbzZSZnOI=;
 b=RWVTmXDkLv8gS5agl6NX7splrrr2uTltGEi1CRdIUZxZY9eKLA089l5GCrt9F8NTkp
 3AAEOvSFU4hcJ0txu0eMBTPVc0fEMC9LaqHPebxwRbComF46iCIKVTY2gSk8YqaNXSgE
 kSnsPpKqcF23lJuL84b0UhDOd3IHyJS9YxIHPZcfW3x/dZ5LYxX8B79QqYLHUOpOPTrb
 UrAdFxa7akQ+/6dSmTA2MNlFOsNRDONsaP5GocpOWOmczWup7p/Yn5nx9UfAAiRvW9Oy
 j+92CLB3r1+UYUtcsCSkursoa+wRRvCVwVGE6/6JSJ5Le5s4LGj0x9eSbCd3dnJBsgs7
 0UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832359; x=1785437159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OFWWMcPCcMgyyaWxMapaPQ6yr5T+tvoKVuXbzZSZnOI=;
 b=GqebWTfpJWBypPFqJP0irKqEn5wlBTVTjacXXCixHTUJVv04PkXGs7t+QY5kprxlxq
 K8wwqOJ0M/Np9RSayVlVlNf3vXhjludb84fluT9BCYLXOb4d+qMDuk7o+0/Gu+fPohzx
 cO8aBme0sH+ZbueHfQIhzNvrsa6c40+Dio0p4odd7txxSsb8lRDC20LkYZy65rdW7Qkz
 ir717VRiEbmzKA42SUHda1VJl/2ODd5YR9vR8hY7dhASY0kScaAmaRN7UUAnlEnSpAnb
 tBiLRDrz3Y1PU3fqmp9/KnewteuSK7H1I+YqY3J7fKZjEwT+Q1wTTlRddma8ETZYRBqk
 Zgyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRzizwgMmRdq0ezbLT7ZvIL6GvS65grlIvw9y88z2XHqhUCgACQzHlfauWBn4Sx0pES409D8Vp0TM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXVuZpnHNq0y3ADfti3Ds9VASuskE4fHx02vaZeXCabm+ZIpnG
 o/i7iPPYkCcq/BuTHpG2wq1SgxqnTR3v3fZ/Tg7838yndsYXnM43Hk4w
X-Gm-Gg: AR+sD10Xjt/jtWu4RSB80sQJFlPYP6yuwEHV+9p+k5bjGQNNv/fnCQ1vsRmRXZqvzGM
 eWFJ4BINR8VKsSffmSsaUIJ0T8cUefr4bYLIorrYSF/Tivv+El2wnhB8pwfwvsy/SUPXUmGXHEr
 gZg8YVqRWWvavmflljsOgdq2GGTX/hWe7rB5PZ5oq3R00wmuBcygJn8WsjSy0XbtGpVAOCp5y98
 1DZRr3Qwzt1tsTQZJyVNwKsE6R/iOt5v8Om/MiGSPfnG8p3mmMq5WMR4MyJUgnN67xaulKzoM8/
 xl763+/iuACmpGD5g3WHHfy36VOSLaHcGdCpd17A0qbgdbyhmwB8VuzWAU0YKn1F/bVxpjOhWk3
 4OhRfacn5YKlBbbRSo/hOLAkxY/y7m7Ne7BEWyVcZxJvc1C3+j/J80E/52rWnH6r3j9NGkayp
X-Received: by 2002:a17:90b:55c3:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-38ec64f19b0mr4395595a91.10.1784832359386; 
 Thu, 23 Jul 2026 11:45:59 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:45:58 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: cocci@inria.fr, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/36] drm/amd: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:04 +0900
Message-ID: <20260723184538.3888637-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  6 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  6 +---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 32 +++++++------------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  6 +---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  7 ++--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 ++--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 19 ++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  6 +---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 10 ++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 19 ++++-------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  9 ++----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 16 ++--------
 28 files changed, 60 insertions(+), 192 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f0..c64c79db3016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4482,11 +4482,7 @@ static int gfx_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = gfx_v7_0_cp_resume(adev);
-	if (r)
-		return r;
-
-	return r;
+	return gfx_v7_0_cp_resume(adev);
 }
 
 static int gfx_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1cad6dc9476e..5baacf86facb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1614,11 +1614,7 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
-	if (r)
-		return r;
-
-	return r;
+	return gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
 }
 
 static u32 gfx_v9_0_get_csb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9512fef81d84..22b48f4232b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -599,11 +599,7 @@ static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
-	if (r)
-		return r;
-
-	return r;
+	return gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
 }
 
 static void gfx_v9_4_3_mec_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6fe3d3d56c40..4dac16bb330c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1537,11 +1537,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1ca0e7f65442..5192fe097385 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1440,11 +1440,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 81f1e9882177..4ddb8277c37d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1358,11 +1358,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index cf3d2997fff8..d41e3720020f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1406,11 +1406,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_sdma_sysfs_reset_mask_init(adev);
 }
 
 static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 8a9ba2276275..004a8ce8eedc 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -128,11 +128,7 @@ static int uvd_v4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_uvd_resume(adev);
 }
 
 static int uvd_v4_2_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 454f109cbb2e..52700e9048f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -121,11 +121,7 @@ static int uvd_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_uvd_resume(adev);
 }
 
 static int uvd_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 46222fc30be6..3760a06d8ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -484,11 +484,7 @@ static int uvd_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_virt_alloc_mm_table(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_virt_alloc_mm_table(adev);
 }
 
 static int uvd_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8abe47..a2f908f86df3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -491,11 +491,7 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_virt_alloc_mm_table(adev);
-	if (r)
-		return r;
-
-	return r;
+	return amdgpu_virt_alloc_mm_table(adev);
 }
 
 static int vce_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index b763fdf43c60..0d241002df82 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1075,16 +1075,12 @@ static int kv_populate_samu_table(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_kv_copy_bytes_to_smc(adev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, SamuLevel),
-				   (u8 *)&pi->samu_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_kv_copy_bytes_to_smc(adev,
+					   pi->dpm_table_start +
+					   offsetof(SMU7_Fusion_DpmTable, SamuLevel),
+					   (u8 *)&pi->samu_level,
+					   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
+					   pi->sram_end);
 }
 
 
@@ -1134,16 +1130,12 @@ static int kv_populate_acp_table(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_kv_copy_bytes_to_smc(adev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, AcpLevel),
-				   (u8 *)&pi->acp_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_kv_copy_bytes_to_smc(adev,
+					   pi->dpm_table_start +
+					   offsetof(SMU7_Fusion_DpmTable, AcpLevel),
+					   (u8 *)&pi->acp_level,
+					   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
+					   pi->sram_end);
 }
 
 static void kv_calculate_dfs_bypass_settings(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 012227c70600..50973f92ccbf 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6989,11 +6989,7 @@ static int si_set_temperature_range(struct amdgpu_device *adev)
 	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
 	if (ret)
 		return ret;
-	ret = si_thermal_enable_alert(adev, true);
-	if (ret)
-		return ret;
-
-	return ret;
+	return si_thermal_enable_alert(adev, true);
 }
 
 static void si_dpm_disable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f4e817885e54..9c2eb6431727 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1922,11 +1922,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	 * Send msg GetDriverIfVersion to check if the return value is equal
 	 * with DRIVER_IF_VERSION of smc header.
 	 */
-	ret = smu_check_fw_version(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_check_fw_version(smu);
 }
 
 static int smu_hw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index db5db2c9c8e8..0dd2dbbfb2cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -540,11 +540,7 @@ static int arcturus_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = arcturus_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return arcturus_check_powerplay_table(smu);
 }
 
 static int arcturus_run_btc(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 8feea44f3ca0..48af342aa549 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -484,11 +484,7 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = navi10_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return navi10_check_powerplay_table(smu);
 }
 
 static int navi10_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index a889d846e9c5..8f35ddaabe88 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -528,12 +528,10 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 					  address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					  (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DramLogSetDramSize,
+					       (uint32_t)memory_pool->size,
+					       NULL);
 }
 
 int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
@@ -1378,13 +1376,8 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 016a5c893fee..3350ea1bea24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1368,11 +1368,8 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_freq, dclk_freq, false);
-	if (ret)
-		return ret;
-
-	return ret;
+	return vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_freq,
+						   dclk_freq, false);
 }
 
 static int vangogh_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 2b011610e3c7..85f77754a0c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -893,11 +893,8 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq,
+						     uclk_freq, false);
 }
 
 static int renior_set_dpm_profile_freq(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index cd7bf36673cb..2a74bb8a7b78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -533,11 +533,7 @@ static int aldebaran_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = aldebaran_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return aldebaran_check_powerplay_table(smu);
 }
 
 static bool aldebaran_is_primary(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4f10bce36756..a2b0a2f23916 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -583,12 +583,10 @@ int smu_v13_0_notify_memory_pool_location(struct smu_context *smu)
 					      address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DramLogSetDramSize,
+					       (uint32_t)memory_pool->size,
+					       NULL);
 }
 
 int smu_v13_0_set_driver_table_location(struct smu_context *smu)
@@ -1281,13 +1279,8 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4ce1429cf57b..0ca404ccb4a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -463,11 +463,7 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 			return ret;
 	}
 
-	ret = smu_v13_0_0_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v13_0_0_check_powerplay_table(smu);
 }
 
 static int smu_v13_0_0_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 64db62a8d642..b55626f61be7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1893,7 +1893,6 @@ static int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_irq_src *irq_src = &smu->irq_source;
-	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1901,13 +1900,8 @@ static int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v13_0_6_irq_funcs;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v13_0_6_notify_unload(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5f23f2e7f401..0cc3ec648521 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -499,11 +499,7 @@ static int smu_v13_0_7_setup_pptable(struct smu_context *smu)
 			return ret;
 	}
 
-	ret = smu_v13_0_7_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v13_0_7_check_powerplay_table(smu);
 }
 
 static int smu_v13_0_7_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 2a0c7cde938d..27a3f5d9cba6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -549,12 +549,10 @@ int smu_v14_0_notify_memory_pool_location(struct smu_context *smu)
 					      address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DramLogSetDramSize,
+					       (uint32_t)memory_pool->size,
+					       NULL);
 }
 
 int smu_v14_0_set_driver_table_location(struct smu_context *smu)
@@ -911,13 +909,8 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v14_0_wait_for_reset_complete(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0fbcaf884419..0aec08200038 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -366,11 +366,7 @@ static int smu_v14_0_2_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v14_0_2_check_powerplay_table(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v14_0_2_check_powerplay_table(smu);
 }
 
 static int smu_v14_0_2_tables_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 046069e93854..cb1602cfab98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -782,13 +782,8 @@ int smu_v15_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				SMU_IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				 SMU_IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v15_0_wait_for_reset_complete(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 227cd86e13e8..b398e1606177 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -318,11 +318,7 @@ static int smu_v15_0_8_fini_smc_tables(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v15_0_fini_smc_tables(smu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v15_0_fini_smc_tables(smu);
 }
 
 static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
@@ -1253,7 +1249,6 @@ static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_irq_src *irq_src = &smu->irq_source;
-	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1261,13 +1256,8 @@ static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
 	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v15_0_8_irq_funcs;
 
-	ret = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_MP1,
-				IH_INTERRUPT_ID_TO_DRIVER,
-				irq_src);
-	if (ret)
-		return ret;
-
-	return ret;
+	return amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_MP1,
+				 IH_INTERRUPT_ID_TO_DRIVER, irq_src);
 }
 
 static int smu_v15_0_8_notify_unload(struct smu_context *smu)
-- 
2.43.0

