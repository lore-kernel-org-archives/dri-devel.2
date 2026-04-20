Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943FF327B3
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8913310EB79;
	Tue, 21 Apr 2026 07:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q2EgJpUE";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147DA10E422
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:34:45 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35fb166b0c6so1854098a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 23:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776666884; x=1777271684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LZw6M1+Kjv5eGAQmOik2U10ct5aJbT9e2mhLsFRjRQA=;
 b=q2EgJpUEqmCl7ZJvHkLXEs0LmJr1x/ABa4GeaBpKIu7SWleVDVhHhv7DcfdSOF/qjp
 hFc0sBLwa8GTtpp9H4rHOwFX/q7gFQUaT+f4PXf5pR+zm/VOMc+CbvanvRAuA0N8mmbh
 glL4i+5ysTYOT2hBm8LooGdcHmNAXqRtb1XzAMRg81/0kLaWgLZSXcGWcXgY7OD/XE+H
 /m63z8ArSokkojXg8XMYdPEe9Co442buEiuiuOdOFRhUhO8jk7L7WqJmyl1LSwtIyDu5
 8oDi/DCKbXzGjU9x7+ZD4ylzEjWcXawU6MwYf6fpfJiwhPZiYX5nCd0sj5r5fxvOWKtO
 fBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776666884; x=1777271684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZw6M1+Kjv5eGAQmOik2U10ct5aJbT9e2mhLsFRjRQA=;
 b=H/3oG4rzXXCV2625BEgKla4xj2tkAet8MTEvQzZ+ybS3ClXgJqmnGxThK3zpxJuzj6
 xi9izswAJioLg7xow4AK9kJLo2tqMZNOi6BbhKir/Mg5qIkYSNT53qvZVpcOEaAPYeCA
 XvxJDGr/KPdks7Af2Z8nh5H6ufudUWQ6nl27LyYxE8jV+tGqKB8wkXPPQjgm1Zzs1feD
 su1pRhFitHsEKlkVQ3cqitl7tR+GZzCfxaEsiKfdSRqtWRu/noK26KM0a4cqp8G6DYSd
 ua8bkaFgfzCuejV1i+iT2RIQwZBvWVm0EWgqZ64s6I0hXgt2IvFByI6yTLSQHcD6jQ9V
 lFfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ++q6gFsdPuRcYkmi1IWwA/+7RAcf8XIIwmQLZR99bQf8jiIWKari3qs71+DUbcKPAFlpMnYOi1StE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPWGMQ1bG/8iJvr5nofiOD/7Y+GiEAg0ylZT9fy6bSAgmfJJpT
 0k8kwPjcgE/ogBT8RRJBvuIaHzG0XSPOZrJOHRr1PgsI4dj5dkCK5NU=
X-Gm-Gg: AeBDiesr19P0ZTYbs7IwSl4xHr7sjRvCNtOUcXtkoy1HD8aS+Hi2crXi2ZN58F8zzpX
 2ZVYk8turAT75eBPOWjtJkUU9HMUe4JWBGLXvIVKV6sLGEs2N1iaRC7SyHVXyxNzSQ4q5IFIc36
 3h5nmry2G1aFjP5hCehIW5s5Or/UCe7EpZ6u8L5yUFAYZ/V8Aj/IIiINOQeg54W5bIZM58E0+SY
 bE+6l3AbCVGuOQR/4adcx7rRHCD4XyugYcBvIDNrNrKTcZl2qO2MUOkyaOFbDrjntuKIxB9f5T0
 GngZZw1c03R3Gqqp6l4MhrfHGyZ11U5mab3hBIUooiDFk4hjvzAk4N3pWvcLDlrbBPWn2DDuuR9
 Lfbe6EcmognzBdw5VzkYVI2GSUJ+3DtjszlWPNppP/eQblRVfPCd8KPyRWR8wOvmOhlC6vzZ5DM
 08fG33+2Ki0p9s52/d31OSFsExznVBJ4eWLCrVf7mo1jruy++OGlVTnuz1OQkYq/0eZV6Alpkd4
 BTOxSMsUA==
X-Received: by 2002:a17:90a:51c3:b0:35f:b230:5889 with SMTP id
 98e67ed59e1d1-361401ec4a7mr6196933a91.6.1776666884455; 
 Sun, 19 Apr 2026 23:34:44 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36148706043sm3862825a91.1.2026.04.19.23.34.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Apr 2026 23:34:43 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/panel: ili9881c: remove panel on DSI attach failure
Date: Mon, 20 Apr 2026 15:34:08 +0900
Message-ID: <20260420063435.91650-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

The probe path calls drm_panel_add() before mipi_dsi_attach().

If mipi_dsi_attach() fails, the driver returns without calling

drm_panel_remove(), leaving the panel registered in the global DRM
panel list. The driver's .remove() callback does not handle this case
because failed probe does not transition through the normal bound-device
removal path.

Fix this by unwinding drm_panel_add() when mipi_dsi_attach() fails.

Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 947b47841..be5e58658 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2359,7 +2359,13 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = ctx->desc->lanes;
 
-	return mipi_dsi_attach(dsi);
+	ret = mipi_dsi_attach(dsi);
+	if (ret) {
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.47.1
