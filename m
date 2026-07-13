Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2817C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9A210E961;
	Mon, 13 Jul 2026 12:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3UGCPVo";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5C710E961
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:11:54 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2619604a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944714; x=1784549514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M8Fc1y4+RwjniJfgwRtIk0X9ABaeOzCopsCGLc1zspc=;
 b=i3UGCPVouZPKB+0/mH59PWIWSY+WhQvcQ+mr+1DqA34/Aw18PZSvVh9lFOmmnc4Jv3
 LGdNDOVSYTt6jLgYTYCGRLBWRYUwQ1fxjZoxqDtObBO/x0IWlmyyu8fRzbJZoziq/azj
 dRUHHMo+/ZLqje0JfL3flIUEPIchvTiWVbUEZpPtaNnsco6YB/0CwX43iZ5hO4uPq3+o
 n2Os8vfNmq9oC/MOqdKexcG5sGRr758wjObLBSK+WoewTLVZ/DQ0cJwsnAnqacs137ku
 XN9GOxJMxgKYA+/rDucUY+4NltBzIfu/zov+J/cNyGPiIhlRlSJBrauhdgx89cV6jEZQ
 OFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944714; x=1784549514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M8Fc1y4+RwjniJfgwRtIk0X9ABaeOzCopsCGLc1zspc=;
 b=FD92OaVsc73g6zNlaJx1EJoJplRFIAN0Om1g/xDvloRP2QyHDMo71n07Dadz6BaFX7
 TUbcH/J+AVbG0siCn5Tr0+j8hQ7JbjnOZdn6X9shzYK394S+Jp/RZIqO6jUSs67a8hBH
 qU5HTbMNc0ZNjZgZ5q67AuLuWsAcXuPAzaG67Uv11nnISoy+fS166RIyrZMrNiTGvX7Z
 +Sq/1K+6alMrkJ/kWcuAYj4sGDzAFBvVkcofRhfnPkYsWZBryCsTIazRsO4SN3dA5yc6
 cXjIjy863JIPHq6mC07iV7CKcTrAk5JUqcqeAW7SkG8tizl0tWvFZ57e1fFLDXajm8kt
 i9Mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZ063z4k1ELJug5IHXIqk/G1FsH6xqmlD0XD9jVzNF86u7MZ6/cyf92L2MRO3wK5NTQHPn20lqR2Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxTkPlX3+8VryINEau8a8dq/FUBlzelVFrFPudcEYYS45aZMkI
 Me8/FSCPmqKglHcLnPAoR/ShFl4hV322xDVw3pU51A93UP2dOQ08aK+r
X-Gm-Gg: AfdE7ckJsG83QkdbaYSo718xq87PBNpdcdA2EF1IiYY42rOE9q4VKrF3KJeTUPBIfmc
 ifs+IA1julUPmvm0XzGavgOvFvaTGVICAx8YOe/yEJI81yV/fiKbJwfOkQt9KxrBSHdQEbpIvAp
 L1oMPSyxG5CET7WaNWmRFALYWeYcIeeuYsYrrnouI7uNp6H2LEjbsCWFjjMs/s52ombHLIztIpI
 aiiYENYasTsbOf0M9hm4A8VDtJI/dj4Jauf+6g0Tr2WrLlCwz+iUBMhQE9fP2cqVi3at/HVuX1r
 FEQI7oLvAaLDDl7wXvzP6HbKUH5WbW0h1vA1mK2NqxR4PANb/VNbgd6uSceVG3ywAkXcABfNnZm
 fu196z5Bh5FPHiyyAqknNO3i05XY14PSk+o8gszgQwf3bDI16pD4tIpkkqNfigT8PNww/RECtX7
 27ZqJIiFvwEg==
X-Received: by 2002:a17:90b:4c51:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-38dc7607589mr7644160a91.0.1783944713757; 
 Mon, 13 Jul 2026 05:11:53 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:11:53 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v7 17/19] media: meson: canvas: Fix Use-After-Free by linking
 canvas provider device
Date: Mon, 13 Jul 2026 17:37:12 +0530
Message-ID: <20260713120840.17427-18-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
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

The vdec driver retrieves a canvas instance using meson_canvas_get() and
stores the raw pointer in core->canvas. However, the helper drops the
provider device reference via put_device() right before returning. Because
no formal device relationship is established, an unbind of the canvas
provider driver triggers a Use-After-Free (UAF) bug when the video decoder
subsequently attempts to access that memory block.

Fix this lifecycle hazard by enhancing meson_canvas_get() to establish a
formal managed device link between the consumer device and the underlying
canvas platform device. Using DL_FLAG_AUTOREMOVE_CONSUMER ensures the
dependency link is automatically torn down when the consumer driver
unbinds.

Additionally, handle missing link conditions using dev_err_probe() to
clean up upstream error diagnostics, and ensure the canvas platform device
reference count is dropped safely along the uninitialized driver data
path.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260530111022.9C6D71F00893@smtp.kernel.org
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/soc/amlogic/meson-canvas.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index 79681afea8c61..5102a491bf778 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -54,6 +54,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 	struct device_node *canvas_node;
 	struct platform_device *canvas_pdev;
 	struct meson_canvas *canvas;
+	struct device_link *link;
 
 	canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
 	if (!canvas_node)
@@ -70,9 +71,18 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 	 * current state, this driver probe cannot return -EPROBE_DEFER
 	 */
 	canvas = dev_get_drvdata(&canvas_pdev->dev);
-	put_device(&canvas_pdev->dev);
-	if (!canvas)
+	if (!canvas) {
+		put_device(&canvas_pdev->dev);
 		return ERR_PTR(-EINVAL);
+	}
+
+	/* Establish device link to prevent Use-After-Free */
+	link = device_link_add(dev, &canvas_pdev->dev,
+			       DL_FLAG_AUTOREMOVE_CONSUMER);
+	put_device(&canvas_pdev->dev);
+	if (!link)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+				     "Failed to create device link canvas\n"));
 
 	return canvas;
 }
-- 
2.50.1

