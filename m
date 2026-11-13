Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D19606A33D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MqhvfJFj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F441126EE;
	Fri, 13 Nov 2026 16:59:05 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86FB1126E4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:58:59 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AB928205A0A;
 Fri, 13 Nov 2026 17:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DD0CfyTYSpBOxmAOGks3Gn/EK2/cA2lrTDv89mouTc=;
 b=MqhvfJFjnTRQezOHZ6rdW3BwbNgFiSNnG6SEWjgDwkXJwjKYWHo1eUakaLnp1dhTfhDrNE
 ARXzfa+LABd6VaR7PK1Ofxf3TXZV7LfGGJLyVjLqkxzqI2R+bgKR7PidmH1HyhF9FveW+8
 ypD4M9vLQUk2o+BpCBI8AZJzlSd+cG5RKAl47JmIiaZSrksYiKc+VD1dHDdJrzId6h0fxc
 jSokBLHDOsVZMrdcx+zmueEQ0FVtmx6c5IkMGNYcco25/BBpGr+pqHlkaWG04+XFxWzctO
 O5Mku1DusQEhm6dJ2s3W02OLOuT0VQQplaSDWiMc3x3wEoFqmeh4H1vowL8x3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DD0CfyTYSpBOxmAOGks3Gn/EK2/cA2lrTDv89mouTc=;
 b=e0Q9IawiUjWpVc7/yjjj5A0A6IINWmlGm/zNDRBSYIjLYIlBiq7ADdYtcTVq/4N7ccpmuV
 Isq6BEpxTsahnGmbmVhhupXMc87P5BVEWkRSMhBa9HfQKZF5mumk/SbMqKTI4uGzZHjX67
 6kHJBU4g5TXbqiKjQtUEhaFPdNIBiyskAEp3cd2aE+4gSR3RsKNTIqlJsiw6Z5AVH5/jiB
 7XoVssyh8CrGjwW2xpJmk7meY6YYeGFUKd4zO2DVUP1+8HxHCF+eduZU8Kwv48OIihYDYi
 kFjj+yJH6YkwgC9Z8+TJLk+oWW6c2o2FJNcHe94Ow4KUb90wAb6tUwzDgkAHaA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794589133; a=rsa-sha256;
 cv=none;
 b=G2vIBFTvTJBCb9XtTxA0AjsE+cCxV8gBcMuRwggEEReUVDDRlyvA5hMte6lk0RZWrQ4OyA
 WiAjbkefWkG3qg/++InGetquUMBcj37VjYNyVL6xmyBvjTQXiuxDBl93G2NX/wNPhVm+KZ
 /ab5zxMZwWCCRRi4aAMN88jf0A2irxiMkzIIfbDuth68OSgw7aqwjTv5h6KaWsyWtVKzKE
 /EvgwjlPip3CVripqFq1ViEXPobXdKVJ80BC4Pmz0vc+/l8TmaWo0H6rxyQqz/es22JuMQ
 gH3RYyqn2R1s5t9qQQTsDneVC0QDhf3y7ul8e2n28EBYAYbVNPvZat58gUQ6mg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de
 smtp.mailfrom=p.zabel@pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1xRuc1-0041Ib-21;
 Fri, 13 Nov 2026 17:58:53 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 13 Nov 2026 17:58:55 +0100
Subject: [PATCH 3/3] drm/panel: ilitek-ili9881c: Fix TDO TL050HDV35 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-panel-ilitek9881c-lanes-v1-3-9d9320cc1387@pengutronix.de>
References: <20261113-panel-ilitek9881c-lanes-v1-0-9d9320cc1387@pengutronix.de>
In-Reply-To: <20261113-panel-ilitek9881c-lanes-v1-0-9d9320cc1387@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.16.1-dev-53874
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add back the missing number of lanes for TDO TL050HDV35 panels.

Fixes: 2f7e4a699736 ("drm/panel: ilitek-ili9881c: Allow configuration of the number of lanes")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 4b68dcf319d4..444d41b3d1c9 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2637,6 +2637,7 @@ static const struct ili9881c_desc tl050hdv35_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.default_address_mode = 0x03,
+	.lanes = 4,
 };
 
 static const struct ili9881c_desc w552946aaa_desc = {

-- 
2.47.3

