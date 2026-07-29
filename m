Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B849C54F54
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6072F10EA4E;
	Wed, 29 Jul 2026 02:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="bsPPTse8";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC31610EA4E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293679; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gXv1svCflKx162bORdnCPnNfnjBDGr3gvTq9xgaoJ5taWg2iOo9Q0F41uGhmlzpPqMBmQ1U0jER8RZnZkCvQGlh0bjqjQscWLUxLR6sdivCyHIpXQlCtXa9NQufGGlXcbAq491xslthg70Pq1g7aPGbTIffqj7dmusiXS6pC16A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293679;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uP9JDNjIuM7429b59kQKnwdLdN1fmwoS5yZiDgLBDLw=; 
 b=ajIZW26mO2H6CdQ0MAJqZim4B7YDiTLBW7YZ0Zrk3LenpJRu02x6TTiEhskrZZnrQJ8CQ+M8eauhm7M7VQJHs5813iafu2t8qAmNICqIgg+XhfdmU/5H/hciFaKkn+pvfHi2RMtnikQ6UDbUkkAsAT/yJTt2SmEhmlChyi6ihCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293679; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=uP9JDNjIuM7429b59kQKnwdLdN1fmwoS5yZiDgLBDLw=;
 b=bsPPTse8ukgpq5VqCH0z2g9HjH0+jS/Zh7h6HjYpOmYlxQbzGvIWVpEQwFzs2dDj
 mqcoLBDyy00tNajtEMUKWrlhOmkkSZ+64Lfx5W9zz0H682JXWNPVNqR0tG+PVov5jf3
 1EjM8rMfIlrCg/2TJ1nhO4LJkdw3hreufVgb1UsI=
Received: by mx.zohomail.com with SMTPS id 1785293676466794.2857299848356;
 Tue, 28 Jul 2026 19:54:36 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:15 +0100
Subject: [PATCH v4 03/13] drm/panfrost: Remove unnecessary header file include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-3-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=689;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=O25ujp75xoczWqfZkgJjzvV7Yz1Pjgp3Puq391G662I=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtWMOKmMORns9iV5K3lpnfXRqLEfVzXeOmdX
 9rEwBmMu1uJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVgAKCRAOJn5M7lND
 PRkSDAC8vHzGkAeiPl1b7ShT3hCmWdfun+QZF4l6IMU/NkrLUone3COfK3g85Ro6ICxX3LHeXb4
 HFVJy/nJG/cK1ElWLtTHEca1QZBPjb7Z9OwvDM0tka/0a8yYR6c7qgCh3L1rtKAXQ7mNLogicQU
 ukmLoSws9/lnEf0dMCRD8OkLqU7wuE23K5LV375/jCGlkuevzRC8y4VKTK2SQhWI2jf1GhF6HTh
 0UOrfwxptkuyKMdip5iy3yOOP1etT1t4RdQHmMp7UbSHdiOPlIMOzslzhLSo2mWBEuR5MDAM9NT
 BglnRGCGa7ceFJhaEYjqO0K0qDryIAXZBk9ms+88K5vR8TcwZuxSppm/qKohIE//Sp0bh5FZp6p
 jaU+IO+Gkif7+mj4SSUFz+ejZG96CmB+9qU8zEQBTdQF4GijAEB/Ozz1fD+qlOE5Tm6kcNQ4A81
 aRlvr22LhH5VYljRKsLoC1bKy8D3ICchuQBnNZQo7QBL7J+xX66ZqEwpjZ2HY/lSoNyeE=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

None of panfrost_features.h definitions are used in panfrost_device.c

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7fed22d555a5..d8421fd6a662 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -11,7 +11,6 @@
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
-#include "panfrost_features.h"
 #include "panfrost_gem.h"
 #include "panfrost_issues.h"
 #include "panfrost_gpu.h"

-- 
2.55.0

