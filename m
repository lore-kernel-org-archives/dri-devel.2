Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4224C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6317810F04C;
	Thu, 20 Aug 2026 14:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="a+ICdkxV";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F3410F051
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787234712; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L/DaF40pDagQoWU2c0CjEZ6g1zAsXCUTOSCCs7/U24Mz8yfVTLfEf68l2uvSrnVRO31IA+0jJjcai1j4Edxxj1XGqeUzIDpa7HTfBzjUUftw8j0uQ8Iq33r5ScKmfMtbjRgI1myXyH1sTEF/QWm9mym79+WWwDlcjRlXp7T1y6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787234712;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pvbx4KaTuvWa0YM6Na+dQI4ZBVd0UbSgLkQJoBS24oo=; 
 b=nozbtV/pJQtRYXFaAsW3JB5qyx2TQCDupBgHr5vxc9DeC9JIELP+GW3CBG5Gu/a24JQaFh9Ba7d+VG59sbbpKInbLJUVoGd73+CODyqMtEQAILqMjZnHzA/i4uwF5GZtvDW5N51oIQtAC5i4SlLVkrv1mKElR93aG8mAuKSOCxs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787234711; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=pvbx4KaTuvWa0YM6Na+dQI4ZBVd0UbSgLkQJoBS24oo=;
 b=a+ICdkxVzDRJ1j15HZZ6oiekbocIUJWxdPaYXV4hmK9NLq1w58BmzSKNCFEag4Rf
 f/ncGjTnXnyfHnSS58W7RsSegiIjDXXaGkddWVBsCSSFr3+8oj9VNZa91o3iM3VWEhN
 Oz971sNJESHZvxcssA3npmNDapHy5gAEuoXAayyM=
Received: by mx.zohomail.com with SMTPS id 1787234709630164.11279365116036;
 Thu, 20 Aug 2026 07:05:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 20 Aug 2026 15:04:49 +0100
Subject: [PATCH 3/3] drm/panfrost: Remove unnecessary header file include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260820-b4-panfrost-fixes-v1-3-1b2c2376f4bc@collabora.com>
References: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
In-Reply-To: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, Eric Anholt <eric@anholt.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=801;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=M8AIp75Rp6PKo1JUfsp8lBsYDRrPR/ccO3vWkb42mQg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqhwmA7x0DpHMprxTf7rTtwVxtNpIlmOHLlPRnr
 fyESaR3Yb6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaocJgAAKCRAOJn5M7lND
 PYdhC/9wDC2S0tmdhk3/fcF29UcBoxgH/pag4vjTCJzL84s3V4RairVZROftLACsrM2PVSPDgno
 xE5r+ESKuAF2rKzADvC0b42PSKUgNcMtjCKXJI5F5pQXstF7ZJ9GoJBYs86PK5cNIs0jYqMUfy7
 pgKb2OQhwIscaKamkgBLjfwdebuGJM7hdmTRSTj971paZvgOFwjmoDFGDOvLAHsA5svr/WDV3rW
 hBKeywmf7TTXchk+9QPKDdMHSpDL0LrR1Vs3/Rpu3jSUGTE9a8oFkSoERyxu4lbEZec4frik6Wm
 KX3NfPogVxNg9u8v4QNpAeLF5mLfbjR8UTahdmMo5xEdTYkwT+iKTnVCqmvfESNGeIi2t/meJgS
 3KR1A/NncXYsGFUNVkpR5o5Xl89Dj0w9CnLhNgJd1yg2akYc08SdM2Av4yPKfWqNT0vMvaX7xkB
 IgfTWD/OhQUwDAM4DDXA4lHwq+B9Qvwr38M1Jisj373JuXOVw4UcwnShkUVcnhKJjGfDQ=
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

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index d0a23c51be39..485349faf251 100644
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

