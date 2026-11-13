Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C438606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KLEehsrJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAC610EC52;
	Fri, 13 Nov 2026 16:59:05 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6804810EC52
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:58:59 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 95B50205A06;
 Fri, 13 Nov 2026 17:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCXXq3g6D1s6SKjDhjdThlUNLXSU+tl5c6mTusSIemo=;
 b=KLEehsrJ6lsz/AXN42FueuEqhyhT7OMBgGt0JmJRwZ7xmWJyn8P4OrYg3ZvmKcp4jaH3vo
 U7sUhBi9ZZlB8Di0OO8nEQIYt4BfujDJ0r7YuEGoTDsYtNk2M5fvJJVKQJ1NtFdbPGr3Ez
 QgpOnGJHLmRa0PbJ3tMOk77rg6eMW0nDSLGhHYfkrKS/Fe7ewx1gY9t3R9HSmAqkseKitq
 yYsfHartlHt3B4RddhNPykxm8v4coJGfyy6aSara2TE9ksUt21S+2nin3SSYz2VIvaQcrz
 Qno5h8FJPGa+lTUQqNUrPPbl8k3FmV47kSNH3Xww9/pd2fQvAFpNc3vLQKctpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCXXq3g6D1s6SKjDhjdThlUNLXSU+tl5c6mTusSIemo=;
 b=DAQI8oHaAwaiQ+GW3pTOffG+dY5trvB9ePOLo2RQU57AsO0m4c3kJEis59LpZUdIMElg1a
 9XGfoFClZhmD5PRQ/MjmzDAPICXOShv0knORoM471kgnmr6JPYxOEUDWlebrkH72a6SRoj
 OStuWP3GMVItVCB541BYQjy8O/xMoGJH+FafkPoP91DhF6fQuwajRjLwORxc7SIrMCJvtA
 BfD7xnztyPoBewGNegmOxsd/ajIMzKm8/ewaTcPBOcvcsE/L0RcYImxoj5wMysTZCpSXm/
 4y7fBkpSUByNKXahzctqpT+giisbeYcY861HB/VBJHdbz3KFXRx+ORwA2YKpLg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794589133; a=rsa-sha256;
 cv=none;
 b=Mv5/aIry7/d+7cP3MRX4In5RYEatjzDbvpZ/8LYuJn+GUBxI3NGLlrPAYtlYeK1E7Fc0T0
 /5u+Zfbb0nrO4vhzlApzuTy6LbtQsZoRjmVEomHgWv+N3xABcNZklqK86EA245i6TeEUmM
 rFohvT1pbsYiw4uUBozZO/jPZIrHzqbVqZOzJNtGibqpqyTY07pMMeCqQ73QTz98O5HobZ
 KpRpYe+2SBb8nTU1h0vU456c7jw2Z/9f5bdoy5pI4d6ZRWCY3X/Y4fI8bLapCXcuMG4aBg
 +ZGBIOTzZ8xPG/7dAulVm6PgK4oS2YdeSSPssOvEVMRIcaoJEyN9TMbEU9u6pQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de
 smtp.mailfrom=p.zabel@pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1xRuc1-0041Ib-1i;
 Fri, 13 Nov 2026 17:58:53 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 13 Nov 2026 17:58:53 +0100
Subject: [PATCH 1/3] drm/panel: ilitek-ili9881c: Fix Ampire AM8001280G support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-panel-ilitek9881c-lanes-v1-1-9d9320cc1387@pengutronix.de>
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

Add back the missing number of lanes for Ampire AM8001280G panels.

Fixes: 2f7e4a699736 ("drm/panel: ilitek-ili9881c: Allow configuration of the number of lanes")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 7bf38e96678a..cc4cd646b611 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2662,6 +2662,7 @@ static const struct ili9881c_desc am8001280g_desc = {
 	.mode = &am8001280g_default_mode,
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
+	.lanes = 4,
 };
 
 static const struct ili9881c_desc rpi_5inch_desc = {

-- 
2.47.3

