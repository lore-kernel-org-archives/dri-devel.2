Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709B7C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B8E10E6AC;
	Tue, 21 Jul 2026 07:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="HiobroSZ";
	dkim-atps=neutral
X-Greylist: delayed 314 seconds by postgrey-1.36 at gabe;
 Tue, 21 Jul 2026 04:24:58 UTC
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CC910E1DF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 04:24:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 80B5B11A6DB; Tue, 21 Jul 2026 06:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1784607582; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NmOHbUsNial5QKHl9vm8xpsyqeQGDivA0DLIByqaVa8=;
 b=HiobroSZ25O7SFIdr3sT4njzwP0/Ms1IGnn7AmARf0xCC1Z97XLW//IxV6RiaYJR0testc
 qKX6QqTsU/yzY1cG7gOrSnJYXtYaXIIW+7r6PvkM+KXA/PKXbqGmUxe9Ng7je0oQct23d+
 Hr2hgHLnkEM08/FiMQZSMy53InHqdWepHmJX5yvbaXtZuDv0/3fh2VBFbFLYdCehVJamKp
 LVhKS33jRjF8kuBngIJRmSc7JbHUd+I2g/1jF087xTWvVPTQ2nJhR2DFJO5D/P+F3eOVE+
 2i2XOreebGhEjYJBMcBiZ9Y33Sg0bRyqFGfx4zb9K88tdE8eiU7C48T/Ac4/GA==
From: Heiko Schocher <hs@nabladev.com>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@nabladev.com>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v1] drm/panel: simple: Add Kyocera tcg070wvlq panel
Date: Tue, 21 Jul 2026 06:19:32 +0200
Message-ID: <20260721041935.757240-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:21:13 +0000
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

Commit 922fb2db0287 ("dt-bindings: display: simple: Add Kyocera
tcg070wvlq panel") added the compatible string for the Kyocera
tcg070wvlq panel to the devicetree bindings documentation
(panel-simple.yaml), but the corresponding entry was not added
to the panel-simple driver.

Add the missing compatible entry to the driver.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c09bf3db5e78..caef94e5f384 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5909,6 +5909,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "koe,tx31d200vm0baa",
 		.data = &koe_tx31d200vm0baa,
+	}, {
+		.compatible = "kyo,tcg070wvlq",
+		.data = &lg_lb070wv8,
 	}, {
 		.compatible = "kyo,tcg121xglp",
 		.data = &kyo_tcg121xglp,
---
base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
branch: abb-display-v1

-- 
2.55.0

