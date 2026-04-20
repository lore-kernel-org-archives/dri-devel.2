Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D67F327B5
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181C310EB92;
	Tue, 21 Apr 2026 07:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i8/DYI8T";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9636810E10D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 07:39:54 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso17157705ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776670794; x=1777275594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dj7/VWJAYljedX89eSjbw1RVS0mtVMWYTOlQIVg73N4=;
 b=i8/DYI8T3Gy0UgYz40+eFMQocfFDsgujXqATaV9FBHpjavGH2wEyphNT1N4MtQc13U
 crZnLZXOM20hDRNTMEUtyxy9k7RhRsY01erC+nfJWIgCIzg1gedHBrjTfT9pkO7OAqEV
 rChHyYoSxfeKL1/Bq5DOYcqti45ipfP7jybe4H7EocOKRa4BgY/L2q+MbEnKY+Wznm6l
 DpbGzM18W50hXZgjWUUrrCaPs2wMNsi7Clrlad7LqYkcIervK/FpvGN78KIl8XQPpLBi
 3hWVx/01FdkoFZPZUT1AyaoalKXgBKLDLTNWcHPT3LPX+5mNYLFWmhmJ7tViRACKLroy
 bcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776670794; x=1777275594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dj7/VWJAYljedX89eSjbw1RVS0mtVMWYTOlQIVg73N4=;
 b=A2gA0bJ4L4cyLdO0X4bau0xcIRyfEakR6sKAMc49CJnfeuhHMVP9PNTaV6jcbdfLAN
 jPVnKbyG/A/C8L+XPZAlAUN+F25t/tsoXnWmYhrZy6jvxZQLnzkNnVXFQqV745eVc5zL
 OKosF6Am2sDrhuJOn0ESOsErCWSTm9NAcbLPpEpWy7Mu3fFNMXufadPjV91mLXJHm14+
 qRerANhXVzUSp1TRxgAtrVve5/Ap69XLv4ZzBBiPi2DO7fl2xKfTchaQC8Ps2Vq6npsc
 28ZG81bz1awwuqqdcnFpWeOJRRgxDETIUWZWcB3+9wKjkrPiec7ErsD2GIKH4z0hO4tJ
 oX3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Uy2MLDYLg0LK/ct2rrt+TT9NcFs0r1Nx6WLWjxiTIC+JvwvOBiP4MdKgoD6FgElymxUKvEdxckv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6MAyBkexmYCGl6SV+Lv2X+ow6wK6Ck5VbGPbNirsk5b7Tp9Hr
 qguakIl8dLF7ZaQkP+yTwv1sMULkA4QWL9QltwIuuH+FybH2yJ282LI=
X-Gm-Gg: AeBDiet9zzKOcXt+Pft7ch/1vgDCTvo2ejkgoVO1pcUzCWRbRTNellmsKgOvmhn8AIA
 HEZH3+GvdutmYzyoP8rKNzcbeqE0Fv9705KPZE/xtsahiq8b6+zZd/HtUG2je0cQmvDmUd+NpXq
 NVA4SYgp5WwUsuImezvKjWsdfXXOH0De0acgQB6Mx1PFy+j1UFBH1aJ2DtchlkBj8hjF+gZrdH8
 jjxrM3sN1tdWlM7J5GAEg8NoWVMbKoEzSjHSrO8zsr/HNd+bMLA4zWZ9kOqCHzbIIPqhRbFdqzJ
 CN+lM5XD/50M/g6Rie7eHHwOkz2+/SB8F1lmHtuE5nntv7co8WsiFp0qSSGY/aQGrFKCU5/smIG
 PZqhHJeaELMw3TD7YGE8CD3ckTiq+gZ5YPwyt8jfrxv8MrfCHRZzx4BkToY1roKlYBThQlgvw7w
 08v5r0Qulzqg4FRhY1XFg3j5fRktdEhN5sgFJC0pxDP/2yGM/DkdDXXsqj6pt2/qbkNivafuPTv
 7YbV/cuRw==
X-Received: by 2002:a17:903:1110:b0:2b4:636b:dc4f with SMTP id
 d9443c01a7336-2b5f9e950a0mr105085335ad.15.1776670793641; 
 Mon, 20 Apr 2026 00:39:53 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cf67sm92864705ad.51.2026.04.20.00.39.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Apr 2026 00:39:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/panel: lg-sw43408: remove panel on DSI attach failure
Date: Mon, 20 Apr 2026 16:38:27 +0900
Message-ID: <20260420073945.65849-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Casey Connolly <casey.connolly@linaro.org>
References: <Casey Connolly <casey.connolly@linaro.org>
MIME-Version: 1.0
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

The probe path registers the panel by calling drm_panel_add() in
sw43408_add(), then returns the result of mipi_dsi_attach() directly
from sw43408_probe().

If mipi_dsi_attach() fails, the probe path exits without calling
drm_panel_remove(), leaving the panel registered in the global DRM
panel list. The .remove() callback does not cover this case because
it is only invoked after a successful probe.

Fix this by unwinding the panel registration with drm_panel_remove()
when mipi_dsi_attach() fails.

Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 293826c50..0eb78bc90 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -294,7 +294,13 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
 
 	dsi->dsc = &ctx->dsc;
 
-	return mipi_dsi_attach(dsi);
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->base);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void sw43408_remove(struct mipi_dsi_device *dsi)
-- 
