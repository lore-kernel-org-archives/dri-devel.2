Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452F3E85367
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F24F10E09B;
	Fri,  3 Apr 2026 14:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPlcAZY2";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220F010E09B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 14:52:18 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a2c3dfb4a1so2623354e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775227936; x=1775832736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bTlw1pKeaTzUESwGji3ZkJ8SZ2G06/DfjSApvfBocL0=;
 b=QPlcAZY2kUst01UWrOzRv6sTUIlT8dyzRpwxNUXno1xdGiPz8XCKJajSZOSszo0e3m
 iMG6L9msedNBvhei6nGeGLFviNM4LkdVqXywiqebs2c8643MDserDp+vgBxt4TDmDVhl
 HEgCMC98DxWf6G0HCPu20HaP0vzZIMPbWp4jBfpdP5ezppZCYjzLyGl4AEEMzF74Dqso
 rGyT2LNhvrABRviTwDNCZntTAUpiw3vRh1t/ZWpqMnIktbM7HCbD7eB9PcoWdcuxnaVi
 fP6AB4/NuX5OwogwWo0xpcVTqaEMHGnOsTOB88Tleu+yswJTwi/dF23AGpbcCeWy9Bk0
 xuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775227936; x=1775832736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTlw1pKeaTzUESwGji3ZkJ8SZ2G06/DfjSApvfBocL0=;
 b=oxs39WylVPsggJ+BWWEmnR3wEDowi1ILHBwHP1sCNDiDQr8bz3WfqVOhLLmTTgpaS0
 M8zOdw4/pl0MCou/9uD0DeZm0gQhOywu/2atlK4pgi5/5M3UvFmnyy5VL41CL5EgOtPQ
 pKAT0dByBJDcXtiUdCFnZv/4H0HViV8hZWTv9IiWGUaWy0gjJdSqy1pmyBpU+gjLc5aP
 W+cms+Rh+2D+SUVqOkAZXeqEfeJhsxh8I4N9Mh43FML1U8xGwXqLG4sgabmMu4Jhc/1k
 6Cr5JFTouson5IZv95GzIqyNUx8mfgsIv/7GdHR9ToDO/+lxJL/1o7ONcrIf1H7Z17vF
 46+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg3r9+w3IoNyokvXy8vPpVXG0aJw+rnrp44xCXIKZ90rzz1u0pj68aiJnwf5aHQXCDOYr6VPFso3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5gQtsWi8tpsk1qaOfzYcYXmuy6A9b+R6RpKn5MnKM93gQ4eQi
 SvoBl4RonH4n3+74hl3kwUjsnXzMIme7tD0bX6CWYRciChGKwqdvnF07
X-Gm-Gg: AeBDieu2gSOsI5/XDdCa7XAuwV2xMXM8reky2TfgdXw600UfKsUAV75Th1VoW+MN7rg
 uzuJdnztvKTfx/r6L+x5rVtF4v0woIyceh3Z8qHwF7bEC5Vb+Mci96YE8Cn+UFRKMElzoWwGbXA
 C/8XaTHf5xZFHiU0RP4FZf1hvhK2RprqSVwP2UxtAsJZa6loCOkq9WM0BWKecICgGn0OsH3cDS/
 HBS4GNF8CEBe6svpyknmr3VlsYQnBg4vhDHsuJG2dd4JLSiVnkiKwWemdWq+aD4q1J2MOSXAmF8
 FQhowe/lp8zD07Glbr9vb7++c5TabRIPjEsT2/zItd+Bb1wlXyqk7yZh+iDUwS9fT5bGX07x+Ul
 g3tR6Zcf3Yu6uoyE+RoYjulSomKu9rDu0Vp5vEriBWMdHv/w+LxsNiPDiQZgFq9f+neFHam2/W+
 OGLLiqxeP9GLAxEyABJOjN9kcSM1U3jZTY/WcRkyn31RIHgRh3IKC6BgI5E8Ln
X-Received: by 2002:ac2:4e0a:0:b0:5a2:787a:fa54 with SMTP id
 2adb3069b0e04-5a33756cc8amr1154914e87.18.1775227935969; 
 Fri, 03 Apr 2026 07:52:15 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:a944:abe7:1177:5b7b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6c95294sm1502331e87.12.2026.04.03.07.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:52:15 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Douglas Anderson <dianders@chromium.org>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Kees Cook <kees@kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: dw-mipi-dsi: Fix bridge leak when host attach
 fails
Date: Fri,  3 Apr 2026 16:52:05 +0200
Message-ID: <20260403145208.15890-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

dw_mipi_dsi_host_attach() and dw_mipi_dsi2_host_attach() call
drm_bridge_add() before pdata->host_ops->attach(). If attach fails,
the bridge stayed registered without drm_bridge_remove(), leaking the
bridge reference and leaving the device on the global bridge list.

Fixes: 90910a651123 ("drm/bridge/synopsys: dsi: add ability to have glue-specific attach and detach")
Fixes: 0d6d86253fef ("drm/bridge/synopsys: Add MIPI DSI2 host controller bridge")
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Use drm_bridge_remove only in the error paths
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c  | 6 +++++-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index ca4dea226f4b..ef7be20a59cd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -345,10 +345,14 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(pdata->priv_data, device);
 		if (ret < 0)
-			return ret;
+			goto err_remove_bridge;
 	}
 
 	return 0;
+
+err_remove_bridge:
+	drm_bridge_remove(&dsi->bridge);
+	return ret;
 }
 
 static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index e6eaf9fd0251..a4bfd3ad166d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -540,10 +540,14 @@ static int dw_mipi_dsi2_host_attach(struct mipi_dsi_host *host,
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(pdata->priv_data, device);
 		if (ret < 0)
-			return ret;
+			goto err_remove_bridge;
 	}
 
 	return 0;
+
+err_remove_bridge:
+	drm_bridge_remove(&dsi2->bridge);
+	return ret;
 }
 
 static int dw_mipi_dsi2_host_detach(struct mipi_dsi_host *host,
-- 
2.43.0

