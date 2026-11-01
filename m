Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E99606A32F
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=jjnIYMQP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFCC10E414;
	Sun,  1 Nov 2026 13:24:20 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A24E10EA40
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 13:24:12 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso16513927b3.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=korea.ac.kr; s=google; t=1793539452; x=1794144252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LxDX9PzbtJZKyZGuacihFDO/9p8vV6pNspzhtvTNV8o=;
 b=jjnIYMQPtiw7p1y2qtCQ3CStFjuUYqUNqJF5ePFJBoFLkbhksV7BPv4fAJSVbzuMen
 SljbGAoAToRt/EaxrzhQ6l2vJZ4E2BVcJSsUidwrtwdEJQocKPY/Ou9pm/zRNSPbkRNf
 EN7La2wrCO2bj1M396Xzis2dnF4NChMcqGG8ZModYiBGotTi2jWto4EFxGVVCNxq3R96
 dt8fQzNiiEUgaXf1SMPugyzL2zkO/lynd3XE//N7ucOTrfGEBnYM8zAfg7L+asMqd/aY
 2ZAYoZ9R63z8OfEvQ+tBvSI+UfG4RLCOPH8rf3lujzXusdi3jn9TO6BbVqNcdKfjyKxC
 TtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793539452; x=1794144252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LxDX9PzbtJZKyZGuacihFDO/9p8vV6pNspzhtvTNV8o=;
 b=WSeDY3vSDr7TQxCxhvfd6I8VfS7LnfL1UTuM9MKohZe1+Y9p2QdvSO1fKFYnj+a66y
 4uiveHdYqE3zVDWIXIv0c69+WBNMa2J44KYb+CfFBeLciV1n01b/5ofZ7A1ronGWoCa3
 KDw+pmek5MT+7uuwR7MkeVy5O4GeeBjeNSsjZUYUFB4TTY5drJZG81LRVgn3IAp/3bqi
 CedFf6aUp6Ly42AeQPfwKwb5cdcXIbHedkF05DTGPywKrjihukE6evqS2I37uF+2qg0+
 1bfg9PIz8fVnEDdrGzyNW7gAbfZrc+AWgS3lvKxEX/6IWWHfMmzr1zMVUONeo4qcisV2
 pVXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqv7MxvLC82+938/KHAvYneDQTvEvtXYR40QvakGrzQpp0JihNihmloujgjdw6LdghGBPCd7MR4Sc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIKkuXnSj4gjra02G7fNROZMwXGfYDH7x4p8xDgEl9RrIZ2Ekp+
 yzHDKiV7vULX40Q97qbTjr18LDAv3CVeVnVH+tIKFqG/WeOTeoejuspxfOkOzkoDFw==
X-Gm-Gg: AYBFou36Ds3I/qMP4l5dnX7mj3qnRZUrTuJTEUG4wzIK3a7mvExkUVe9QcfYgFlWZuw
 y4uai/czAFs2Ye/TIhr78Zgup4BMld70ZjxNezFXH7RBcyARJ2H5MK2a3v8W3sFIg+x8AD+9bOs
 a49KMpINDvR4SJEM/ngOI+94TZB4v23IsbswKtkwWZZMlfuDSkinU/Z/ZY7iEaR+IGB8H+bl786
 AlZtFyiL8O1B7U3klr3fJMQEq7pt4rkUjK5fRmGXQX1CejQ/vOKbO9EOnSkKK2rALSZ/4w4fobw
 r9y6tbBiup4hLf+S8UUJY04R0Jgl8/xWJloMryVcxuabcREF6xyEBfsnv8iLUdqIQoZstaWLfEP
 pNS3N9oBS5Upns9ry7TMKQpZ7NaE4TCSo+55V9Ht8tGy+NfYOSEV1Pln9/10p6F3RuoR51wIZQT
 qkuU7CB7Jbz38A1dZfRRRaKx1dOv0w/vap8BIdf9AF3v0+mFRCfgwyAwyI/H/gIUfoIdoiWw3W9
 +eOkbW8fMUnIN6xEwtmZT1U/RQVp6ut0btTtP2z3ymuDeNlM+k5X1Q3U/b5eFZ3IFnwAXgBAlFo
 3PmpHIzv8TzCaXOJ
X-Received: by 2002:a05:690c:c4e5:b0:8b0:8b34:ede3 with SMTP id
 00721157ae682-8b2b6594f0cmr48287597b3.3.1793539451749; 
 Sun, 01 Nov 2026 05:24:11 -0800 (PST)
Received: from s2lab05.. ([163.152.163.130]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b704e62esm36685267b3.3.2026.11.01.05.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 05:24:10 -0800 (PST)
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH v2] drm/amd/pm: remove dead code in
 smu7_patch_dependency_tables_with_leakage()
Date: Sun,  1 Nov 2026 22:24:05 +0900
Message-Id: <20261101132405.1387745-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
References: <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The smu7_patch_*() helpers called in this function only call the void
smu7_patch_ppt_v0_with_vdd_leakage() and always return 0, so the error
checks on their return values can never be true.

Make the helpers and smu7_patch_dependency_tables_with_leakage() return
void, and remove the dead checks.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
Changes in v2:
- Make the smu7_patch_*() helpers and
  smu7_patch_dependency_tables_with_leakage() return void, as suggested
  by Alex Deucher.
- Rebase onto current mainline.

Link to v1: https://lore.kernel.org/all/20260114163807.2525868-1-ingyujang25@korea.ac.kr/

 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 117 +++++-------------
 1 file changed, 30 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index bdf1e489369e6..dafe25b1efb65 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2672,8 +2672,8 @@ static void smu7_patch_ppt_v0_with_vdd_leakage(struct pp_hwmgr *hwmgr,
 }
 
 
-static int smu7_patch_vddc(struct pp_hwmgr *hwmgr,
-			      struct phm_clock_voltage_dependency_table *tab)
+static void smu7_patch_vddc(struct pp_hwmgr *hwmgr,
+			    struct phm_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2682,12 +2682,10 @@ static int smu7_patch_vddc(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].v,
 						&data->vddc_leakage);
-
-	return 0;
 }
 
-static int smu7_patch_vddci(struct pp_hwmgr *hwmgr,
-			       struct phm_clock_voltage_dependency_table *tab)
+static void smu7_patch_vddci(struct pp_hwmgr *hwmgr,
+			     struct phm_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2696,12 +2694,10 @@ static int smu7_patch_vddci(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].v,
 							&data->vddci_leakage);
-
-	return 0;
 }
 
-static int smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
-				  struct phm_vce_clock_voltage_dependency_table *tab)
+static void smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
+				struct phm_vce_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2710,13 +2706,11 @@ static int smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].v,
 							&data->vddc_leakage);
-
-	return 0;
 }
 
 
-static int smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
-				  struct phm_uvd_clock_voltage_dependency_table *tab)
+static void smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
+				struct phm_uvd_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2725,12 +2719,10 @@ static int smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].v,
 							&data->vddc_leakage);
-
-	return 0;
 }
 
-static int smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
-					 struct phm_phase_shedding_limits_table *tab)
+static void smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
+				       struct phm_phase_shedding_limits_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2739,12 +2731,10 @@ static int smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].Voltage,
 							&data->vddc_leakage);
-
-	return 0;
 }
 
-static int smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
-				   struct phm_samu_clock_voltage_dependency_table *tab)
+static void smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
+				 struct phm_samu_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2753,12 +2743,10 @@ static int smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].v,
 							&data->vddc_leakage);
-
-	return 0;
 }
 
-static int smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
-				  struct phm_acp_clock_voltage_dependency_table *tab)
+static void smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
+				struct phm_acp_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2767,12 +2755,10 @@ static int smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
 		for (i = 0; i < tab->count; i++)
 			smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->entries[i].v,
 					&data->vddc_leakage);
-
-	return 0;
 }
 
-static int smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
-				  struct phm_clock_and_voltage_limits *tab)
+static void smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
+				   struct phm_clock_and_voltage_limits *tab)
 {
 	uint32_t vddc, vddci;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -2787,11 +2773,9 @@ static int smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
 						   &data->vddci_leakage);
 		tab->vddci = vddci;
 	}
-
-	return 0;
 }
 
-static int smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_leakage_table *tab)
+static void smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_leakage_table *tab)
 {
 	uint32_t i;
 	uint32_t vddc;
@@ -2804,63 +2788,22 @@ static int smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_leakage_ta
 			tab->entries[i].Vddc = (uint16_t)vddc;
 		}
 	}
-
-	return 0;
 }
 
-static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hwmgr)
+static void smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hwmgr)
 {
-	int tmp;
-
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_sclk);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_mclk);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_display_clock);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_phase_shed_limits_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_ac);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_dc);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_table);
-	if (tmp)
-		return -EINVAL;
-
-	return 0;
+	smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_sclk);
+	smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_mclk);
+	smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk);
+	smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_display_clock);
+	smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dependency_table);
+	smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
+	smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_voltage_dependency_table);
+	smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_voltage_dependency_table);
+	smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_phase_shed_limits_table);
+	smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_ac);
+	smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_dc);
+	smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_table);
 }
 
 
-- 
2.34.1

