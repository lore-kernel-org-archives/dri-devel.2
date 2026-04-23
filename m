Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609C7FB44C6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1D310E11D;
	Fri, 24 Apr 2026 07:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sgrbT7MX";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFDC10E289
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:59:42 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so28315565ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776949182; x=1777553982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Srgs3m4SHMyR9rB6Uq1iwx3CPI7WzOrLJ85yi1rwQKc=;
 b=sgrbT7MX7c1+FQhk1Sol3kGNNYB3g/GmbpUBU1t86m1nysN037fPkSPvAlEQoPSjFH
 QSaiKOh9XpWF4/mgGjKomz83ojYoO0Qt4i6o3y985j+2Hl5Iw1XFVV11gy7CKGG6Db48
 oNlKvES95tvdo3a3VKD3RgmF9yybnR7gHWZg2c+HndRoQSJHKqJtAo5WTEKcGiY1or69
 ICnTeFmZhJc1Z+t6/jUR3GRxB4LlKVXqLxMZdbyV5bLXYehup3FtWUNnykzxWg3l4aLd
 pKqhv362gipYi8xlRlM0dRe1u9BmnsVln3IKnOm+qjEVV6I/oyXK7qV8QcT4WNSW5wvD
 /QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776949182; x=1777553982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Srgs3m4SHMyR9rB6Uq1iwx3CPI7WzOrLJ85yi1rwQKc=;
 b=f608U8RldSGb0QZRu5xG/LGTI0JY6ye2CXWGlYwd9OyQP10Xi3ypC4olYAg4fULlGv
 /LTwk/rmaCvWq+edhcxgIs6uRYNsLlLsrop8JvV02oxr2P8b5aNi4v3VKCX+Fs1QWH0l
 ENkVr91FJ4+UH+uZO3rTcBNx/a25ZF2eocDaL5etUIIkLm600v8SJdvriaiSVkbJgpL1
 SmCneNGS99RGvWic1j0H2lg85mjQB/vtP1vu3pY8tUxpQ5dr4wj5wlOz9TmBHesLMOjT
 hgal22P0p9apEY1raSzlu3+A+9GR4YJbjlX+6kDedQsVpL6Xdl2ZcOGRqoBikRuX4vSt
 TUmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97f2qh58jxYZvEKiq0Y6eziWepoBJGJLDCPz8ObFZLOHc6sYB6MuTwGQZKjf1PmnmqSc+4yuU8RZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7Ndanpeb3Jl1HLSsU5bV75DhDZtFN/MyRsf7/gOIfkLE+rqFM
 Yffned0txb0y7/3Z326A+k8/mrEYWBAb7+1ph+O87WFMsDxFylDSV0Z6nSA0f+4zEg==
X-Gm-Gg: AeBDietnMb80uTq6wFOl0Vfl2WL9LsENNIiQSKizT+MBT8oe+ljFwMHqJTA+Z8wKSg0
 61r3M6dqko25A1NehiAjBpC0VPZbzG5rq1lFBkFxEjRmsk6U5226U6NRA9B28DF+eQOU81UUenj
 YDdtTTYR+P+n2KqQypDxn7b2HW22Y4/zIh8cB6ysKYKBsRREZhcmK41dsAKbKwxdor1p7bgy5JQ
 ONgGPx483CrjTZZMazjZ6BYw1nMM599DcnXLVsvQl6Sbpv7SUWGTmsgvt4K+WUmO52JMG6kjTYJ
 2ku58n2QR4g2cd7lB2LjU7dfIem6/9t2AIl/7WGf892/b27GFNtqsW48ZaAEXyo3iAjuNYv16Cj
 1DxamA44vjRzHTOADZrvRD0dp+Mq9kU5JNYZK4EmFa8RsQzPylTf2vMW4SffjzuToEUQnw0OXtZ
 RlV4oTcevduuhkhefQ25XDlBmlQK8aW8ZGzGmbtX3dd5EnxsEE3PteI6/Is7OGHbbAEEtybP11Q
 1lIlO3hoQ==
X-Received: by 2002:a17:902:cf12:b0:2b4:460e:6fa8 with SMTP id
 d9443c01a7336-2b5f9f61d45mr263684575ad.34.1776949181684; 
 Thu, 23 Apr 2026 05:59:41 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab28e35sm193499065ad.64.2026.04.23.05.59.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 05:59:41 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH v2 2/3] drm/panel: jdi-fhd-r63452: use devm_drm_panel_add()
Date: Thu, 23 Apr 2026 21:59:21 +0900
Message-ID: <20260423125922.57428-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260423125922.57428-1-mhun512@gmail.com>
References: <20260423125922.57428-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Replace drm_panel_add()/drm_panel_remove() with devm_drm_panel_add()
now that drm-misc-next provides it. This keeps panel deregistration tied
to the device lifetime and removes the manual cleanup from the remove
callback.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index cbe354b51b..32822c5712 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -200,7 +200,9 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add panel\n");
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
@@ -213,14 +215,11 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 
 static void jdi_fhd_r63452_remove(struct mipi_dsi_device *dsi)
 {
-	struct jdi_fhd_r63452 *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
 }
 
 static const struct of_device_id jdi_fhd_r63452_of_match[] = {
-- 
2.47.1

