Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFB9CD3427
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 09:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E6510E506;
	Mon, 11 May 2026 09:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d82cYUd8";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB1E10E506
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:59:23 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c8026aa4d53so2869079a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778493563; x=1779098363;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SiNQPZVG/iUu1atYnF0zTpBHir1antgFK/ZRHpE1vlY=;
 b=d82cYUd8K3PL7ogp3L1dMtRU22JeLzBErEfhK7DCqWF1+ksdhu8IeQTecPd5Vtym4h
 5DjMfAuU7GxvwDeEhhqOVhiAlME7KUdpyU2qmgk07qaKbI+dCuKPTqDUkbdgkGd2fM/0
 H6izinyajkJ17MYOJiUy/y8n+82fZ6570frS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778493563; x=1779098363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiNQPZVG/iUu1atYnF0zTpBHir1antgFK/ZRHpE1vlY=;
 b=qeVrbSXUiTx4hO5UcBWy+m0gwIwuT7Bg2VjoIbE/3YzDnmg3+rJfFyPbinX0a0ucYw
 hMht3aNisXWO0Cact2gE44Oiz61n+gAFvKaywx5/6VfJshxeIQH2ye/cqJO8QqmvhcMg
 oFkEyIfWQQA1r+DddrR4h62iyANzFm+64/AtgDP3GloSSJwhyWcvgRdUgbByl1CjYvKw
 OCCgE1cEtO4xfEmG6yw9CtPAQbZU3ZMd1VdxYq3QKqSuAp26YEeUneUfVNDmhBoM1xyc
 RbINZugd4yKp+vzVnp5EJnk5H1TzFzyGR3dYjnLYtmkBrG8AxxNhF/zk70sQTW6Y2R1K
 GOyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YQhofBmpmm14BhomujQBH+FihJss2OZujdoK2+Ac1X9QEB6FMugg95K2sPO7mhGSm8m1bkOOfcYY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzPVtIl68NsNPYslfeJjTE516ka/E8V7lfGXgKAOvHfnxTs7qA
 RTmOhhwMbVStucoYsTLQVUhZ3zPG2P7/DnuV6CpguIJU6MD5+iWBl5lLKzeEipy//g==
X-Gm-Gg: Acq92OEoy/rBilzCets6zWXF9GnK4s2gT+RSv5Cvq/LRq560CnL3oAXLBEA9xLdkyvK
 7npV4g5h+k3JjF/P8s3242yid7oSnpzoAajfNqj8W0HSqMJ0P4CyPwXYB7GfIRBz1uBA14XjCiR
 LtVxu2eh9Sl8lEkyXZc8h5K8W0SEA0erWyhTca43q0aBZOyuxq45gJvi684cZvWvL4XJu8xmtRe
 m1adDObOd2FQirTMQac3zC6jql1IRZJS7I1+uHmPKSgD16+IplE4A/n04EZ2vzJhRK/1zpWegzV
 xjHC10N4L4BjYDJ0zvooz5vEo4OF5ktyLZa4H2QSeElfhAgq2ZvlYEiC0IpIbukwwojZS3aBYCV
 PXtCrrytIRikJEzpJRKnh10bSQZFg6RiOk/wUpjoxmW1gaOyJUKR7c4Z0cLH17MLs6CDbH1I3xD
 SlTzATPDFUBsMqSu2aGVHyy6Yny50FBrcUlKgJGWndeRCuc0hXavSXnTGo50hUUYWOnYXrHK1I4
 DriJV2FRpGtRn7keDc=
X-Received: by 2002:a05:6a21:e097:b0:39e:f994:f697 with SMTP id
 adf61e73a8af0-3aa5a9141e1mr26560357637.17.1778493563343; 
 Mon, 11 May 2026 02:59:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:c54d:25b3:51f0:e590])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8267697d5asm8331114a12.14.2026.05.11.02.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 02:59:22 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add AUO B133HAN06.6 and BOE NV133FHM-N4F V8.0
Date: Mon, 11 May 2026 17:59:14 +0800
Message-ID: <20260511095914.1200201-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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

These two panels are found in MT8195 Dojo, a.k.a. the HP Chromebook
x360 13b-ca0xxx laptop.

Only the BOE entry was tested on an actual device. The AUO entry is
solely based on the provided datasheet.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f3cdaea89b29..98301aec2f4a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1955,6 +1955,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xb7a9, &delay_200_500_e50, "B140HAK03.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc9a8, &delay_200_500_e50, "B140QAN08.H"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xcb8f, &delay_200_500_e50, "B133HAN06.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xcdba, &delay_200_500_e50, "B140UAX01.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
@@ -2003,6 +2004,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09ae, &delay_200_500_e200, "NT140FHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a1b, &delay_200_500_e50, "NV133WUM-N63"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a25, &delay_200_500_e50_po2e200, "NV133FHM-N4F V8.0"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80_d50, "NV116WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
-- 
2.54.0.563.g4f69b47b94-goog

