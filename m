Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED62CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE04010EAC0;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VrkUHQ1g";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CADF10E550
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:07:40 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-341d0522b4dso11825348eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790928460; x=1791533260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z54n6VzC+kkkl/3Ijn5IvZJnQmri9nkKbsWlxFk/GYk=;
 b=VrkUHQ1gaD82K8RsdlOEMUQ3L07BGnfLQXjJ7LPRlFO1xZIjSIhW7+Orn2eVHH89+S
 nE/IWjH+Ti1p4H799zxn9/TeQ+Y5M9cTWJDDCVQwEfJJdr9J4pA+W5TPatQfJsr2E7Cc
 HnGrcPKe3i7+VeVREBcnbQxVfrAfJ1bG55GqQa+upXZZ5oHE7pMWAWEVRzvt5a+hV9O2
 HXLe+vP2iEavKJeq0seYkT3ibGTUhkCJxNOSH90mV1LLRQJk3bGMZFow+RJFp+A5a8b2
 uIrRwVbSX37HF5ZN4KRsDmsGOYmRG2zcozvRjcRxPINBMgldUChT/i56GnQXe+Kzla/P
 +OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790928460; x=1791533260;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z54n6VzC+kkkl/3Ijn5IvZJnQmri9nkKbsWlxFk/GYk=;
 b=WPmzbDiWEPNdfXDJYOPpkMgRsxlMPon//LlvePX2mhyLMjXtdCHgIj2WQNFRABfZv4
 QCyGE5hFF+5e9FZEC8KkVkRP1P91rWkYGPZgPFszXR+6o5/VrqF3BciCqfr1ONRZkE4s
 6YUOntFZGEyIwXR05rZxDXW5ple8gQ+3/nz/qq6vCgb2zMuw1xZBI8Ax+jtg8eufWqQN
 Av7sTNh8O+BEwibdtMZwBmbm/EBoft8dbpD4/ULtfS1MpVfGdTSO+Acm6Kx7fYUtHMBz
 B24QeD9pg6ufxD4ZsyJN5zdyWwh24iOUHHTUmBrOsUKXTEByGfnBrUdm7j9Ej1+H2SCz
 tawQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4lC2EzDg1UNgtBF7Oa20NW0PH9UhYUkLNxPolUdpqnqCmQrCzgmAjyfuGA8gxthft1waUWm9Pmf4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3Ke9JyOzSQX6Eu2DuUZcPrY5A9r2/JjvhPByV4VCOSnoUsrTo
 8F2uqJUQO8f7/9PSUR3biarcTcghHo1Y5JnhSG2oWI2Qb+uFEPPyFfEy
X-Gm-Gg: AYBFou0QUtPjdUeq+UdIP4tQp71wvZhhxG75YSQCnTxVtOOL/t/L5e7LhdHoh4Hkqmx
 YlBVXOmq++0unDRRICizfZf8hR4ev7m9H029gJKt+EO2+h3AlOn/q2i+ari+orNNohv4B2LRslF
 BiHo+kKEAhm8nBPSDiND4kJN99VP3G2tlkFxtLaGunizwvDClYfcfuTNM3EGylBrd+BILvHdpu5
 20aPvQrhIy5K5ydQ39iEcIhva/kQ8Xn24PmYZYwhgjVD98H7Z0yrhcxLcGjJy5WxA7jhh6Ndgs0
 zctOvWqoy7QfGJMwrJz6o24QZHdaKXe9FPwyUWs6nI3XQynW6s8pFATdQE86EmO/HwmY96UI6vL
 phPT1z6fGK1ajUbmyQRI0zk+IPsk79rO6c2dx1Jtx7quxvwPqlNvr8TLco6vOGvyNO0JiSpwm1V
 MrpRZbf1Jh4uG4dpJ+HG+p321DGJPWUxn04dgxn7DB9M7KP8j54i+cPqiH09pRg+5tcW20KPYiy
 jiTqJII18ZKyDNQi2fDa815eJbxWYvau8fMXPkO6iXlnoKsis9oNsgFDNPKSPJWw/fwqkbyHb00
 xnyoDDI=
X-Received: by 2002:a05:7300:e9d7:20b0:350:7852:f7df with SMTP id
 5a478bee46e88-3507852fc50mr1336424eec.0.1790928459675; 
 Fri, 02 Oct 2026 01:07:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1c0e:3312:2cff:28c9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f303e3sm5492739eec.5.2026.10.02.01.07.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 01:07:39 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH v2] drm/xe: use resource_size() in xe_pagemap_create()
Date: Fri,  2 Oct 2026 13:36:59 +0530
Message-ID: <20261002080731.13992-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Use resource_size() instead of open coding res->end - res->start + 1.

Include linux/ioport.h explicitly, since the file relies on struct
resource and now on the helper as well.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
v2: elaborate more in the commit message, and include
    linux/ioport.h. Both as per Rodrigo suggestions.

Link to v1: https://lore.kernel.org/all/20261001163328.51556-1-sinha.aryan03@gmail.com/
 drivers/gpu/drm/xe/xe_svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index b228a737c..a9b087c43 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -3,6 +3,7 @@
  * Copyright © 2024 Intel Corporation
  */
 
+#include <linux/ioport.h>
 #include <linux/pci-p2pdma.h>
 
 #include <drm/drm_drv.h>
@@ -1848,7 +1849,7 @@ static struct xe_pagemap *xe_pagemap_create(struct xe_device *xe, struct xe_vram
 out_no_pages:
 	drm_pagemap_release_owner(&xpagemap->peer);
 out_no_owner:
-	devm_release_mem_region(dev, res->start, res->end - res->start + 1);
+	devm_release_mem_region(dev, res->start, resource_size(res));
 out_err:
 	drm_pagemap_put(dpagemap);
 	return ERR_PTR(err);
-- 
2.46.0

