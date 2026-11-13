Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB401606A884
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FqGGBqlD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE3A10E6DB;
	Fri, 13 Nov 2026 16:59:05 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB9C1126DC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:58:59 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A2EA7205A09;
 Fri, 13 Nov 2026 17:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFI3r+Q6FEAEks4qOtwVF8gGWmhazE0E+bBjIIZurlE=;
 b=FqGGBqlDzCDtJdfgfwP0dGlYlA9xSwNyCQ9ux8cxVTTcp+8ymJN1EVWA8rlInUpdLoNh2d
 YB+O+xV7TwH1csyrlUruXJNyCXe70cTD7H+33AYTsNLuIorcRZzmn6Cr0h7JVntkOCOD4u
 9wgqYQslzGuY6S8by2wDuSbXFLVP5EXcqLZ8/9Tinm72+x+q4/SBSovAPH8T3mqlL0fJvq
 pay/A8iXucvmo2mMlVnmcrZc8CzoZEKFSqTNTiQgBbFBV6Y/5wit4Zz3v7DP5G8ksuhTO5
 +NVERZUOtIK7GLIxWE4YdLOtnSH6XgJslCvTp0jEZKtNr2WH9+Ea8d0vknk2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFI3r+Q6FEAEks4qOtwVF8gGWmhazE0E+bBjIIZurlE=;
 b=NI9hfEVlcKSILENw/ML4sgms1bwwmEblO2C1RQKtYO1vKsYT+nvJxf96s4oIaEA9g9MIdk
 CfFe4fq0tE/DtuKx8TBh5n9iPn/tEpBCD6pqW/E7CZkjb+KLjltQBOFs+ohh8vw83V7dix
 GwYdRmaNewMWv/JAItuEfhce1JR+5Ytw5z4B77ohJL7pq8bdNNDkBctOjvj4VY7rH7qeUy
 SQCZcJXJL0ggevFwyswpilItq9mWNBtznAR8OTP+KAAKuG1xwQ68PVTAKW23zcoun8mdNV
 Ab7Fzxi5Y5INHPcCmOub1eIFKWcwXmr/zsVNBeetNaGKgf6+FFGT7qp/ZPIwWg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794589133; a=rsa-sha256;
 cv=none;
 b=Um7R3MOi61uvGWJCQcK7RUdutqUqMF6izYmszagzdxN3Z73lGMLrhzInvp2SseM5CsIkyc
 kcQ/x7NVKlBlGDFuKJ3aQZVoub8akjQI+kuIH3ANHnDRU9Is8T0tRzKzuXsghob3XlFIW1
 fRksmJ894ByDrWel4Zeak2lddspZrokV0ZLMIBrx66MRnVcGosVZAYRlIn0b1Csrrcf4dR
 PDQL8uLXuKE3JpJ+VdBAJcGfzc5TBJ+VOjahUnwZuYJY71V3/YRrXjse/+60vZHYtx+lh7
 49iy00mMol1qxNESKuMeN8fm153tUrFzut1kOVaSF6/EGzhX+r8VaFKz+CwjSA==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de
 smtp.mailfrom=p.zabel@pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1xRuc1-0041Ib-1s;
 Fri, 13 Nov 2026 17:58:53 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 13 Nov 2026 17:58:54 +0100
Subject: [PATCH 2/3] drm/panel: ilitek-ili9881c: Fix Startek
 KD050HDFIA020-C020A support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-panel-ilitek9881c-lanes-v1-2-9d9320cc1387@pengutronix.de>
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

Add back the missing number of lanes for Startek KD050HDFIA020-C020A
panels.

Fixes: 2f7e4a699736 ("drm/panel: ilitek-ili9881c: Allow configuration of the number of lanes")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index cc4cd646b611..4b68dcf319d4 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2627,6 +2627,7 @@ static const struct ili9881c_desc kd050hdfia020_desc = {
 	.mode = &kd050hdfia020_default_mode,
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
+	.lanes = 4,
 };
 
 static const struct ili9881c_desc tl050hdv35_desc = {

-- 
2.47.3

