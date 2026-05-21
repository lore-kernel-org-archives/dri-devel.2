Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA05CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D62F210E237;
	Thu, 21 May 2026 19:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="T9owrkld";
	dkim-atps=neutral
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A6A10E237
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:48:18 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779392896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlU3IQM2OYRl7N1ScizGGel8YM6cCC0xlGR922rswK4=;
 b=T9owrkldtadUvPGu8pwURLc9gsNTEL9Qm7UZVCYUFVQfdNGO0fCp0oV0sDk4Oc4QCnLWDA
 zSrY9twWH2HXrEOGXgp4tVmdmeqpv9qqhoDGZB/o3u5dhz7JVWzkn6Jzt+fbaaqo7C+YjJ
 ULlOO2U+X3TjImM6fEo3UyRVrFS8pPk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/tegra: sor: use str_plural in
 tegra_sor_dp_link_configure
Date: Thu, 21 May 2026 21:47:00 +0200
Message-ID: <20260521194658.366737-4-thorsten.blum@linux.dev>
In-Reply-To: <20260521194658.366737-3-thorsten.blum@linux.dev>
References: <20260521194658.366737-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=thorsten.blum@linux.dev;
 h=from:subject; bh=cuEE8mJZ2JCkrLzPutO2sbOWRw90RT1D++ufnmzO2EY=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn8iRbnLlZcPPHS/qKsleH3J7U6oQkpEnyCV8s+rdpu8
 WalUkVYRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyE7R0jw6fOrRMObJVirV6S
 sC+7MIpP6nkI02m7RxePHV6eExNSsYjhn6nbYadNNfxnnOKzNpgUTzyxhvXym/3yjzLOXv5oeOH
 rTE4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/tegra/sor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index de8b2dfc4984..93e5ffd4f206 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/string_choices.h>
 
 #include <soc/tegra/pmc.h>
 
@@ -940,7 +941,7 @@ static int tegra_sor_dp_link_configure(struct drm_dp_link *link)
 	err = tegra_sor_power_up_lanes(sor, lanes);
 	if (err < 0) {
 		dev_err(sor->dev, "failed to power up %u lane%s: %d\n",
-			lanes, (lanes != 1) ? "s" : "", err);
+			lanes, str_plural(lanes), err);
 		return err;
 	}
 
