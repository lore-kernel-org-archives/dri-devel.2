Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E8AC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751FC10E066;
	Wed, 29 Jul 2026 13:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rsyKqCtK";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904E710E60A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 23:47:26 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4955c545a94so224385e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785282445; x=1785887245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I0sepYElNWpFKOjgjeV3qn5PVGIr7EC4aWTxpcIRLkc=;
 b=rsyKqCtKuutrmZAHJsHlg5XnCVqH75FvECxefavw5vtOyKQj7AVFCPxR7kMNB/WSeS
 Po5WzAy59ckUf/BpEnnK9eYOwVfrgLrD9DWckSwO4HGK2KHeV2QvT708maDSKQgkgNon
 8bRMN3cT2orIUMkJRAPoLc59WKsYgUUlSVMlGeFDn4lkoQ/prjcFubnwYocjn/ouhMMz
 d1y+7TcYjvbuxnj3Xr0qd9jof0LG3XSRNm2b8yiZQZjRfDHh9OD/8jyo5ecZlp6hul1b
 NMpUwmRmnzYZttfwVhP3InFVcLab+85wtIWxUykFJdTFhn86cqW0DayyId4A1M7DEgwR
 Wnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785282445; x=1785887245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I0sepYElNWpFKOjgjeV3qn5PVGIr7EC4aWTxpcIRLkc=;
 b=M0zbRxGGq2yXioCQo/UNQ8iywOSVT0BV5N6YsxIttbnTZlPy16v7OeEOtguYliVtYP
 xAYy/5PSne+93g3QfjsVrQs5wJo9iQxiMV9HJx72BcsDbrM2/GD0DfYNzg0xP9qTqpJU
 kY+efpkDsqDET8YCB3uricOl+SK6Gk7qXt5v7QJqi4Ciobclq68asrZ1gcGYKuIXJfLK
 0Hi3yV+n3BUoC2JMWosSnHwPoOSO/p3cuPLswgoiKRNW1LGYvG442gdL1CIX2f5nqnks
 tBSzfjNnB9Snn81bULPy6KVzgXVMgLwZKkDLHto4RCrUK8xML4BEiItFPBVwpoUn4CGI
 /zMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwGnKjeCHJFWA9Y714e22tJsPQRCcyUsAkMoCW/Ap3jdFfdt91t+UUzwhBvmrpLuTbQcUy/ObQj6w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkpZ1CpwYlPpeErT00R7RwEPzVlC7WSvYiMhe6+IsCoNzxNnoL
 pZu2EnSvxGwwanV9/YmmiWz8SBLdn1HPADjM7NWR7Bdrcb/kGzUOag3L
X-Gm-Gg: AR+sD10o3ccWqEYCsO1imj8CsBaZx62kha4dWwm07s9w3Skav/msAnrIGhAOprpM4sJ
 PHdmZK4FGcyldWFE8MdvzPQeja1hLEaLKw6GrXdf7EF7/5cg4QutNEbOjX9+JRhQ+DAfVpp/Xsu
 9is3vt0hQ59CsF7fpbFOKA2nd7Q2rvALJ6RqMLIG+u7Gbc92muvdD/74o0XJCuznJtn9OXSPAQA
 UW/5E/VF5TXXvyWGRkcmGDIyXtmo/NycvlicsiSKamfszDHmtQXDm825zAA3zVhOK0up3i/R64H
 2wgfs61HscbZ5uXr5VLL4tDNbSNzkdDHe8u3E38/DzG91yL8M+ZqOFKo5tZG+1r+Kcv9sseTjKV
 8M4GqwPKN/XPVqMicVimWAuGeJUIY0vbUNAjmvH1YlFpsq8B1FEELdWd7q2Rih36bv1Cm9aROd6
 FmOM4vWF8u/RwBVh/SRArtDWpgJ3Qs27fl5l+qXwUXgnz7LAArn9DWWaUSsOHOiz7BiLWi1sY=
X-Received: by 2002:a05:600c:1d19:b0:495:4505:dad0 with SMTP id
 5b1f17b1804b1-496c641546bmr34409585e9.2.1785282444813; 
 Tue, 28 Jul 2026 16:47:24 -0700 (PDT)
Received: from zephyrus-teodor ([92.84.22.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b1c76sm108157275e9.6.2026.07.28.16.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 16:47:24 -0700 (PDT)
From: Teodor Bostan <teobsn@gmail.com>
To: amd-gfx@lists.freedesktop.org, kenneth.feng@amd.com,
 alexander.deucher@amd.com
Cc: christian.koenig@amd.com, mario.limonciello@amd.com,
 dri-devel@lists.freedesktop.org, Teodor Bostan <teobsn@gmail.com>
Subject: [PATCH] drm/amd/pm: Add PPTable power limit quirk for ASUS G14 GA402R
Date: Wed, 29 Jul 2026 02:46:26 +0300
Message-ID: <20260728234626.86008-1-teobsn@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:49:47 +0000
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

ASUS ROG Zephyrus G14 (2022) GA402RJ and GA402RK laptops use custom AC
power limits of 100W (RX 6700S) and 105W (RX 6800S). On resume from
suspend, the SMU firmware resets to the reference vBIOS default of 80W,
hard-capping GPU performance.

Override SocketPowerLimitAc in sienna_cichlid_patch_pptable_quirk for
these subsystem IDs so the driver restores the platform's intended AC
power limit when reloading PPTable during boot and resume.

Signed-off-by: Teodor Bostan <teobsn@gmail.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index cef628752..10d330edb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -479,6 +479,7 @@ static int sienna_cichlid_patch_pptable_quirk(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t *board_reserved;
 	uint16_t *freq_table_gfx;
+	uint16_t *power_limit;
 	uint32_t i;
 
 	/* Fix some OEM SKU specific stability issues */
@@ -501,6 +502,18 @@ static int sienna_cichlid_patch_pptable_quirk(struct smu_context *smu)
 		}
 	}
 
+	/* Fix some OEM SKU specific power limit issues */
+	if ((adev->pdev->device == 0x73EF) &&
+	    (adev->pdev->subsystem_vendor == 0x1043)) {
+		if (adev->pdev->subsystem_device == 0x1DEC) {
+			GET_PPTABLE_MEMBER(SocketPowerLimitAc, &power_limit);
+			power_limit[PPT_THROTTLER_PPT0] = 100;
+		} else if (adev->pdev->subsystem_device == 0x1DCC) {
+			GET_PPTABLE_MEMBER(SocketPowerLimitAc, &power_limit);
+			power_limit[PPT_THROTTLER_PPT0] = 105;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.55.0

