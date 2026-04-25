Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2E3FF8865
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B2A10E518;
	Sun, 26 Apr 2026 06:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NA0lQZyr";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4E910E034
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 05:39:58 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-50e63771d91so70454951cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 22:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777095598; x=1777700398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ee9tn27jibidoYwOFfvWDoDEqvYUolsrYADjFbx6g60=;
 b=NA0lQZyrGQL++UMLLsDZiyM6xK03EUM33ofjEmjVYV9Dc/h0AZh7KTgIdsFM0d5JRr
 wjHrnJCHZWN/bIfKfOI14tba2Hyxz8a+bV6lMCIdsddAW3pTxCROhQdIG0j8rCFUWFY9
 C7mBhzODLchhMGSU5DHcH1zqcTwiLSPAnblwfBdfjgb+jqqvm4UJ5iOi35sBUZh3lEJF
 RZA4yJu0bQ/ZvN5JQ98uE5PW4kS4f6LR/qYcyUGgFpmdjb7sx3Y7EikPUVOXvfLyPvGz
 OJSgclhPy9DoRDzMnaICVOGrVG53O0NClDL40g3/KQJnBrFzE5T1Jq/ceyK3Bu0SRB7l
 JTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777095598; x=1777700398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ee9tn27jibidoYwOFfvWDoDEqvYUolsrYADjFbx6g60=;
 b=GVWIZ2imA2pYKhoVf04sVQVUdv1PrbqANWhwDPzH7Bhmv1NuDxEMbBxzfmBGOw01/V
 zQ5+pO6qI4H17P3omg01uLFgN6DVnYxCHRNrJR+wIYt/+1Yo8ghhdszyw+NbmuR1Bk4Q
 lPdMv3Ww31XgquYFDVnChBmGDni3BlWsz/A30gvqoncrPmmy/e53MUezM+nHb9Bqhag/
 GmQFKd/a0UYCPURRhPLkbrSaaUuFB5Jgd0y+2tWJXVfPnjys8DMty8A1xQ1RtJKxlCWL
 CqlvAnu+8Ldi3AqZ2PbkbnAREnaR/EStmKgvwfduWernSmCk3dZiv27jdoh0Txc473Na
 xTDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/USRi/S0TOEV2rcHrkRjZ2NCGHDRgKjCbTm8oSFaFQgHLZ6Piz9M+v1j8AlLSeTafoSHdRDnMrodk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFervmqtEBpCRYrWzAW0136WNj5B8JTx8fME6cWdgx+iliWcSG
 VAVkRFLsyRMNJcvfLkwXb1Vyve5q4BxAajJMMCVHhDkboQDeUskFB8+v
X-Gm-Gg: AeBDietVzRyPFE5n2eEJqZEXYoJaQFRZHHAUeZ9eZhctz1ESprha3PzLENUPyMzJ+my
 1zL2YnQxMuYvoFJK1V3dTxgMD0sojHGxQQULYU0USqRk8lFNHf4NgU7fZPtIO0KmK2p7yr4xfFT
 5m68b12tNqy+QzDgdz9KkP4++lafJvNC9RB3zJpKo8kwF2vefOhFqJzkf1KBuMLhQ0JieNO+A1d
 HSrpQTvtdA7rR6F1cPiKBm/s7bLuoGvJ0rgMHeL66kKse9rsGjDT04TeSesLOyIEh3R2CgT/P64
 tzZwuB0Sfl0R+DF7o1OaU49SUxoQfXI5uWkriO5d7p/7SbFDtn2tfYG+7E2kHGEGh+LWDELoNWP
 AOx0aKhkJKmbm45fbWZ+bHFD00HKojtMI0NVmzS0EGpZWk74sMw9D/pjh1VMq2NaN8VYNu2cpy2
 ZI7kvtP00eI58vdiJr0lfclL8LaH/1vIPCaMndr+wsr9temGTeB28N2vCv7IjM6Ebs2R/aXRx1I
 lohcWZdzp5INeIw12Kzl0r1nH4eBeMADXUWVI5t75tg3nItfeaTOJ8NEzeC6kGUYzhlayC1OSHo
 mTloy3YYldjJAVkiPG7ehR3iRW0=
X-Received: by 2002:a05:622a:1208:b0:509:44c3:5ffa with SMTP id
 d75a77b69052e-50e36c69265mr486591751cf.52.1777095597716; 
 Fri, 24 Apr 2026 22:39:57 -0700 (PDT)
Received: from Christians.localdomain (c-68-55-113-25.hsd1.mi.comcast.net.
 [68.55.113.25]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc9715610sm75943411cf.10.2026.04.24.22.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 22:39:57 -0700 (PDT)
From: Christian Van <cvan20191@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Christian Van <cvan20191@gmail.com>
Subject: [PATCH] drm/panel: feiyang-fy07024di26a30d: return display-on error
Date: Sat, 25 Apr 2026 01:39:48 -0400
Message-ID: <20260425053948.117714-1-cvan20191@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

mipi_dsi_dcs_set_display_on() returns an error code, but feiyang_enable()
currently ignores it and always reports success.

Return the DCS command result so callers can observe enable failures.

Signed-off-by: Christian Van <cvan20191@gmail.com>
---
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index 4f8d6d8c0..dbdb7e3cb 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -98,9 +98,7 @@ static int feiyang_enable(struct drm_panel *panel)
 	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
 	msleep(200);
 
-	mipi_dsi_dcs_set_display_on(ctx->dsi);
-
-	return 0;
+	return mipi_dsi_dcs_set_display_on(ctx->dsi);
 }
 
 static int feiyang_disable(struct drm_panel *panel)
-- 
2.43.0

