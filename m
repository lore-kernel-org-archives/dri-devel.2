Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDB606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V26YpI7r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB90110E47D;
	Sun,  1 Nov 2026 21:25:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9816010E480
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 21:25:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B527601F9;
 Sun,  1 Nov 2026 21:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63ED1F000C1;
 Sun,  1 Nov 2026 21:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793568312;
 bh=aGELfrV/OMw95dVVl/o5OT5VGsTICMpPrGvwOEB8SYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V26YpI7rVmeF7TGRFNxl2chmgZIkOSOV86auQg9ab5HH4FZtDpPlzj0zSTApsir6P
 lVg8DfgWM3BeIAb5zqBORxnVowAdNCu8zDvxq791Tf9BqQZjitrSgAYfj3LLNjjV9j
 FSbfxUyAzQklN9qsiyxlb1LESNMQdIJPRlHXVEDk36jd2NgPNcjRxWD1twmc6NPTV3
 iDAHd745FiyJJWLn+/x3RFL7loPXIc9698XFOtvWZRCMJOB0mfYCMt/ySheEh5q8E0
 vpyiYm7ay0FV97ox6AqqRkcGYxQnAFbUUi3pdO82PVXTkpyX1p6d2NDANEa1fX21OD
 O+eXgGXL/dQDg==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/panel: visionox-r66451: Wait longer after the panel
 reset
Date: Sun,  1 Nov 2026 23:24:58 +0200
Message-ID: <20261101212458.2431191-3-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261101212458.2431191-1-vz@kernel.org>
References: <20261101212458.2431191-1-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The initialization sequence is sent 10ms after the panel reset is
deasserted, however on the SM8350-HDK display card the panel does not
answer a DCS read at that time, as a result the panel initialization
commands are lost, and the panel does not exit sleep mode and the display
stays black. With the first command sent about 15ms after the reset
the panel comes up reliably, so wait 20ms after deasserting the reset.

Fixes: a6dfab2738fc ("drm/panel: Add driver for Visionox r66451 panel")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/panel/panel-visionox-r66451.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
index 4f28bd3b6080..b0559e8b1cb5 100644
--- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
+++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
@@ -36,7 +36,7 @@ static void visionox_r66451_reset(struct visionox_r66451 *ctx)
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	usleep_range(10000, 10100);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
-	usleep_range(10000, 10100);
+	usleep_range(20000, 21000);
 }
 
 static int visionox_r66451_on(struct visionox_r66451 *ctx)
-- 
2.51.0

