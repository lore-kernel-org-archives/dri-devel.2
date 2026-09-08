Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19FBC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1EC10E0FC;
	Tue,  8 Sep 2026 12:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="afWsrmjO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB04B10E0ED
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:45:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C75DF601F7;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 751A3C2BCB8;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788871504;
 bh=VFryqqzhM6lSSy4pdb+U7EIAsRSleqEPMNVWVeCSDEY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=afWsrmjOmN2spwI9V5Gq+ptION1ON4GzIJVcRHD+Gys4Qp0aQyyRyGpDNhGNTMe3K
 Cep5LswnJcUhNv0B3ipisWUwcyjYZeUQpx7TvpUXLNkqVLIvF3j7Atqg8XCCNe9K3U
 SK1WA7giHIz07OQj4BCggJb7xg68BdQmOVmo4zoC+PJkQt7aeU1TBXcLlpS9SylVI9
 flsVO29m70PUCXj57E8vaAPjiUU1vJXeo3iOhDWzGwG5NIxgPc6nc37xlEKHwMy50j
 3oLe2VCifwBMvw/rvWdh/bkezFom4CeULKobni32lN+6HhRqchvRl0+Few02bF88LE
 h21ZlIebIsHpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC2C79F9E;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 08 Sep 2026 14:45:02 +0200
Subject: [PATCH v2 1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ebbg-ft8719-fixups-v2-1-5454ae1f5581@ixit.cz>
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
To: Joel Selvaraj <foss@joelselvaraj.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Casey Connolly <casey.connolly@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=rkKe1B3w8nfJnM/PyCVxhpwlE8OgOguOydHVF4lcyVc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqoANOWhebknUywxD5wXoUqrrutGzcfC1TSC2Mq
 SrOYSEh9xOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqADTgAKCRBgAj/E00kg
 crXcD/43mQI7xN9miQgoykM1OpJnWuQGafBFybMVjDZFyfkt7CTMOwFv5FpL1r4/pFWXQodJnWe
 sPpd67/FfM+fcYokvSJE5a8ntXH1Byy+ydbTCtGN025m2+RPndkBKuthCOvRR/zDc9eCQ0mZmbs
 EbfNd2X6f1GwpAahLHoHLJ4lblEDTTal3aoXEjn5NzMYFGlKhmDsRp2Pt1o3l4rnEjNnS/r/ckC
 163s/4qNMyRcqmJ+zxpxXcyXb+t29j+Yxgg2AjIwQ5+Nbx4m/gwIRdABebKIzgBlpNC8Y4geGHp
 Zm+uRAw4udaFkIkquEyJe0ac31M6fcV6RE2iNjYgZQ7NKwS1qvLPGTDuVd0/6XrFXyKzFecAgxR
 HadSlAnvPzRIVKSuvKqlfAGbetGQf0NxEFzbG50EP9wq0EPP1g7/R+mWKX5AdmB+90RU8vewyLO
 8pR/tpihVs2uZUR5h6au9GZVkFVBQz6HpJf8Z5155L2MGVOYWQ6sqkGU1bwMWUnfyiz+FofwBqU
 IVtrIm3ctSVzz9elUXCVL3MfOLkiYO0cwlvoFxSzcSl+dYLogNjyXsLH6fKnGYLK4Cwr30EMDcm
 qMFs7q6aGhxI3ovBV7iBbBNVLvwY8Z62oxyCoG9076APn23uEN2/VsRcjarLkez9nRak5RwU5uV
 IWn6n4jI+fzGF6A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Casey Connolly <casey.connolly@linaro.org>

This corrects the host initialisation sequence so that we can send
DSI/DCS commands in prepare().

Cc: stable@vger.kernel.org
Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Tested-by: Marco Mattiolo <marco.mattiolo@hotmail.it>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index fb9f9f42be4f2..1ab09c50a6306 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -193,16 +193,18 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
+	ctx->panel.prepare_prev_first = true;
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
 	drm_panel_add(&ctx->panel);
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {

-- 
2.55.0


