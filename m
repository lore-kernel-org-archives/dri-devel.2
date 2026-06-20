Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FE8CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44F910E280;
	Sat, 20 Jun 2026 19:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CPfNc7aJ";
	dkim-atps=neutral
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr
 [80.12.242.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CFD10E280
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:23:19 +0000 (UTC)
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
 by smtp.orange.fr with ESMTPSA
 id b1HgweBLQJg5rb1HgwxhOy; Sat, 20 Jun 2026 21:23:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1781983397;
 bh=BXuclxyE0Xm6M4y3OOnY9C1tyOXzRvsIL00sMzI/lx8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=CPfNc7aJrn9Kd1Es8rvp3iQSoDsSaBla/lhU7swKETXxd1ZXFl2yhlwqCm/t2ZIxl
 ykJ29e9rXKoViyInWAG/Sus3qfoILWkDC7dflcadIQ1AP82e/SQUSZMbb+l0I5/gB9
 vWFmyKQL42MSnZxcpac0C3W9OJlBy5YaLOlWqO1+Xtm9008Y15pPGbl1lEITfqMwB4
 th7iYf7cTp6xswu+QoJiS3UrdERDjQa0p3foLrkiBQPppXw48oC+q9DimeIYR1U64+
 qOqVPNK2ELL83i1xhZkVRJwYnnvSv8d2A8tnlYvbQ8mZ/7y6T8sNdgMiuwesFEacIV
 g9zw3WgD42/mQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jun 2026 21:23:17 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH] drm/tegra: Fix a strange error handling path
Date: Sat, 20 Jun 2026 21:23:14 +0200
Message-ID: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
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

The resource freed at the 'put_aux' label is "sor->aux->dev".
However, this resource is taken after devm_tegra_pmc_get(), so there is no
point to release it in this error handling path.

This is harmless because put_device() will be called with a NULL pointer,
but this is confusing.

So, fix the logic and return directly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This is not a bug, so no need for a Fixes tag.
If needed anyway, it was introduced by commit e68c4244136b ("drm/tegra:
Explicitly specify PMC instance to use")
---
 drivers/gpu/drm/tegra/sor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 4032c6ad45bc..e384cbd0cbf7 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3764,10 +3764,8 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	sor->num_settings = sor->soc->num_settings;
 
 	sor->pmc = devm_tegra_pmc_get(&pdev->dev);
-	if (IS_ERR(sor->pmc)) {
-		err = PTR_ERR(sor->pmc);
-		goto put_aux;
-	}
+	if (IS_ERR(sor->pmc))
+		return PTR_ERR(sor->pmc);
 
 	np = of_parse_phandle(pdev->dev.of_node, "nvidia,dpaux", 0);
 	if (np) {
-- 
2.54.0

