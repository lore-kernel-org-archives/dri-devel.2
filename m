Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0377C79F91
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A1310E4B6;
	Sat,  5 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmRawAQD";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFB210E27B
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 08:03:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so24055425e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788595428; x=1789200228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ijYlKX7H3ZC3bUCAPIG6NvhcVl+caSM8FaaFILEG42Y=;
 b=HmRawAQDlv3OgCMRYTwUs9TExq4G2jj629QecPc5mPzqYemgNr9DpgPhMKcVovJ3ET
 T3igL1VMhaCrGK8wVLtNyA2eRv+rzo97SS3AkbAe+2qn5bv73T8ZHU0wqA1pCgMk/aB3
 9SngDUcK3ZxgmZV4JEnnO9iXC60Im6+wetdkzFkGa9oyiGKk6m1LldSya9ueVHHLJJ/m
 cXey/eMh3FewtJfsCViF1qy2MGw7xQuylVS71k4ysS3CuOfmVmrWcDB5kjuoLhHEaEUL
 RNvAtwdptXA+rO9YXMbYdSEB+2P6+HSjQQZbigySh0oo+Y6onWQPKjl/JpM7LCTQoy81
 Ql7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788595428; x=1789200228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijYlKX7H3ZC3bUCAPIG6NvhcVl+caSM8FaaFILEG42Y=;
 b=sfkPuAWBy8dH5G1l7tMtJA+XSKXtC0F3DTNeENcdgMmCPVqMXPrAKu6lYeiLKhuxuB
 N36w02g2Hcb7WAOMyMhNSQz3Xp1cIBLAx6s8Tqanxq5OxW68hDrx5HxsLxzvp1PHKRVp
 EPeHS8O1ug+QoV4cIuOQYS6PqM/3C39GfjMZ/oI0QHZnVMuKzGZowv3DsjO/qRpC/KcO
 PnnhaVQ/DmO0IVf5OveMxAxf8DVKtKOoQVF/KQPL1ETcSNzYVW7ZbuQ2j4N167cUdccl
 J4ndc75CVP+aQe87I9adsEQ+vHJ84jpsAC5iLTXyhjxrziFydnhjIJ847R69KLBnCu/4
 CsBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIb90jMfyCOl+ZZ39P9iS2UsRenConfTG8PekGudl27pRS2SRfbIW5cVzYYUrXUMGVWjY13tOVLyM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mkpCzBx15WSH0RaTaAee3YVS9hTDev5PU1BIcs4PmcfhsNAzuV
 uKk9ig01HkrJ+jmU2B7Q0Gf9jDRA1MDRqFPkiXqwyH4Ynpn15rnIW0m7
X-Gm-Gg: AYBFou10IipvMzgasfLS+xlVd1SlU8AWZI/e4V0nHFZKlbAQidS5k4JY6qQ0ycsE/Bq
 OfAHNXTV49wJB55sGaDcKCmIf/NCs9b2bt1P+/PKgy8ObXG+GhZYs21LzGzAevF8j37ADzAqRkR
 9aNIc1dEjePMDSBVn0rXqi7LQApA3uijSqN/jBK20kouIOebnb61YQyuW5BJv9m9t3vsKbkeQIf
 J3k/B80kEF8tO+a2bswfiSOJ+A5RprNjpG3TT6lpdOFT4nsO6oSK5EFjV2g8ngwg6G4IrnncO01
 PG9OK8cwBteVb07g5jsAP7IADDEaqnUjth9MmGS6Hxgrxhcod1+DKaat+21HKDZKgarOEQ/09El
 Yzg9gNoudvu2Kh1LNeTlOPqYBI2XUKhR688la2Kyndsc2X6o3uyNMqteATnTVhTK2YtvMuR1fRr
 eJxNl0GnAfe0hx1ICGxlGyomau2bzJEdjB9v2szBYaoE2wAeA5PYrgb2MLO/N0RUbXDp4gd0xoV
 Rtse0y6ulnMPaqYqXw6nvkqNk5cgSycM4ZGBCta/gzozXTjEzEOoq64Y0myrMTXEkARbi9Ns8np
 Oj9eFAFL+IVGPoI+rGkoEad6t6c6ReOyNY0PkqPBoowT3XtmlIhSwBLtzUebZ+lAz1wzDw4ad4n
 3pQ==
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id
 5b1f17b1804b1-49cf826c5f5mr100450055e9.13.1788595427510; 
 Sat, 05 Sep 2026 01:03:47 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de.
 [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm128532325e9.0.2026.09.05.01.03.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Sep 2026 01:03:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/logicvc: Drop the select of the nonexistent
 CONFIG_DRM_KMS_DMA_HELPER
Date: Sat,  5 Sep 2026 10:03:44 +0200
Message-Id: <20260905080344.34077-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

CONFIG_DRM_KMS_CMA_HELPER was removed by commit 09717af7d13d ("drm:
Remove CONFIG_DRM_KMS_CMA_HELPER option"). When commit 6bcfe8eaeef0
("drm/fb: rename FB CMA helpers to FB DMA helpers") later renamed the
select in this Kconfig to CONFIG_DRM_KMS_DMA_HELPER, no symbol of that
name existed, and git log -S finds no Kconfig file that has defined one
since. The select is silently ignored. The driver already selects
CONFIG_DRM_GEM_DMA_HELPER, which is what it needs.

Remove the dead line.

Fixes: 6bcfe8eaeef0 ("drm/fb: rename FB CMA helpers to FB DMA helpers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/logicvc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
index 579a358ed5cf..11aae1626199 100644
--- a/drivers/gpu/drm/logicvc/Kconfig
+++ b/drivers/gpu/drm/logicvc/Kconfig
@@ -4,7 +4,6 @@ config DRM_LOGICVC
 	depends on OF || COMPILE_TEST
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
-	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.53.0

