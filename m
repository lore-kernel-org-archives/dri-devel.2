Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AA2C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7288410E4F6;
	Thu, 17 Sep 2026 16:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="GhbmoBrg";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9D410E4F6
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3O/sSDf4Nmc2qh2JhufK4PyTt46P7UAeOLGyiVV0SO0=; b=GhbmoBrg9FaUusy411BGVUUgEY
 R4V4bnG+inuV2abPGNBJ//RE+FWg1hcDnA8Y+CA3AdWlXzYYGv04jKTGjjO+fyjj0evYne/AzAsJV
 3Y2iReH24sFJUpc9mZgIryI1aRtmsW87uWWzTVp4FZXXLDKPMSqv6u/aiExLGuuqoj5Q=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1x7FDd-0000000Bw3I-3ux8; Thu, 17 Sep 2026 19:44:22 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Date: Thu, 17 Sep 2026 19:43:06 +0300
Subject: [PATCH v2 4/9] drm/panel: novatek-nt36672a: Set driver name to
 novatek for consistency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nt36672a-panels-v2-4-f8de8be5b86f@minlexx.ru>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
In-Reply-To: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
X-Mailer: b4 0.16.0
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

Since this driver should represent not only devices manufactured by
Tianma Micro-electronics, but also from other companies, it makes more
sense to name it according to what driver file name already is: novatek.

This does not change neither module file name nor Kconfig symbol, only
driver identification in dmesg. This makes it possible to e.g. grep
dmesg for "novatek" and get messages from both nt36672a-based panel and
Novatek touchscreen.

Reviewed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 464d9ce47d87d..73bec4f47ec60 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -479,16 +479,16 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
 	drm_panel_remove(&pinfo->base);
 }
 
-static const struct of_device_id tianma_fhd_video_of_match[] = {
+static const struct of_device_id panel_nt36672a_match[] = {
 	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, tianma_fhd_video_of_match);
+MODULE_DEVICE_TABLE(of, panel_nt36672a_match);
 
 static struct mipi_dsi_driver nt36672a_panel_driver = {
 	.driver = {
-		.name = "panel-tianma-nt36672a",
-		.of_match_table = tianma_fhd_video_of_match,
+		.name = "panel-novatek-nt36672a",
+		.of_match_table = panel_nt36672a_match,
 	},
 	.probe = nt36672a_panel_probe,
 	.remove = nt36672a_panel_remove,

-- 
2.55.0

