Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F216ECD37BE
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 04:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3027110E056;
	Tue, 12 May 2026 04:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ONSNA6z3";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B476F10E056
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 04:55:02 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-835b78c3797so2117892b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 21:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778561702; x=1779166502;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pfw4DWQXulimGRtFLor58SM/f/ew7ugcdJ/+FaukvJs=;
 b=ONSNA6z3YRVWLW6jHblVp8Lry9Y5XlW/H1FkTZCLqSG8gg5OLq5XmBUylcyiYZpa6H
 eyEDcsCGK0Uybd+KwRoZs+4DECa1Gw1yy/4DO0v+Delhu+0LdQZYiQcf0mBD2kqw6Rnq
 nUdI9ZmAiY2xkb8AXxipF6WNA+t007zRJEoNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778561702; x=1779166502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfw4DWQXulimGRtFLor58SM/f/ew7ugcdJ/+FaukvJs=;
 b=q7MgTCdNCGr3EyVbGHHtld3vj9uwTGWY1Virj1rFKCzI0sH+XtrxmOUSECoC+WLS+8
 g+VhoV1VVO9S49PJ2hJh+6X8i/n9rGCTx/n++bY3/o4QWC0u8WbpO2pV4n1OFnPtH8d+
 AzevAmVP+PyFMiAdpJwkEDKah+558YfvXdATrt//9Ka6Myp/KQ9q8xiwMnCdkNeMIVRV
 uZy3ZrpjMDXeWcKS8ontAOm0hOTyBcFrzGYJroonY25gJdKZwkwI7VuFtfitojxTnMA7
 bmiOjTeNhAwyFmQ8rd9vuoxRc065bSqMs983A7l6NkBtnKIP/ImLqiXgF3nKqjys4vYP
 UjaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pfLVZ7LYOSeMQJ6Tus1mpo3DqkQVgmOYZfVo+bBs+jp3SUfyIBPk9eO0NHXwdbsl44GueYiW7/+s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+NUMRMzlqmOdmMjXX3rR3rCi9DmHpdwccgDo/MbFr1MDymiZK
 +I7amAu2hkDW+ZCZWQBYfG+2SNbblRTD6+3qvrAbFzlvsS0UZvXLJNRbpBPw9VsDCQ==
X-Gm-Gg: Acq92OHO5xSZSna9lk8ufWbZPsrgaYWlEgtZDQWFmWXgBdMkwVbxXRfTQhfpMypqiwZ
 O2mVjPtutIZQWjVcPCRCk5GVoXtBmP8HPoYOnMZ7qyzwLABNY3BD9x2Bbg90UYeh9ei0JmUnI7m
 /AeVX/VvcjiD4ZNmwl8B8sUCVHKVEHEo/m3Eo4AYV6IC2Z09z6R+UB2Q/BxOuOlMvDZ47G1RDBE
 R2wRFsNOiPsJ+sDQFmzm/KESESPLBIw0qqp7WdRRgevNOevdIpOQs/74OeaGnEPnYcKT8ZE6Ioo
 WIzxWilAcFAIXHL1mtSagRUaVLE1zJ8pMs76zWZ4D35QcnE+8dLivnLyvejxNc66d0tNSSUsZGi
 LrLcoqfuNMD2wFzup6BJlZBJsaHNvgvIUVYwE5SLTyyYs30ALUiHscDK9oWLI5ZoyjZCktMJitg
 nN5t87n3VvAbhrls5Fe1JaFyhmDxAaaYivv3bhKjVjXDTR1D6M/K9ca7YlhS0Z0weBAcojUrc/n
 F22pWUV
X-Received: by 2002:a05:6a00:3406:b0:837:b5b6:1b97 with SMTP id
 d2e1a72fcca58-83cf564e0a6mr17646583b3a.12.1778561702215; 
 Mon, 11 May 2026 21:55:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:6606:2bd2:159a:55e3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f03bsm22608983b3a.9.2026.05.11.21.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:55:01 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel-edp: Add AUO B133HAN06.6 and BOE NV133FHM-N4F
 V8.0
Date: Tue, 12 May 2026 12:54:53 +0800
Message-ID: <20260512045454.1505733-1-wenst@chromium.org>
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

raw EDIDs:

AUO B133HAN06.6 (from the datasheet)

00 ff ff ff ff ff ff 00 06 af 8f cb 00 00 00 00
2f 1d 01 04 95 1d 11 78 03 93 05 92 58 59 90 29
1d 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
3e 00 25 a5 10 00 00 18 b8 24 80 b8 70 38 24 40
10 10 3e 00 25 a5 10 00 00 18 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 10 48 ff 0f 3c 7d 14 0e 1d 7d 20 20 20 00 77

BOE NV133FHM-N4F V8.0 (from an actual panel)

00 ff ff ff ff ff ff 00 09 e5 25 0a 00 00 00 00
2c 1f 01 04 95 1d 11 78 03 28 65 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 a4 39 80 c8 70 38 50 40 30 20
36 00 26 a5 10 00 00 1a 6d 26 80 c8 70 38 50 40
30 20 36 00 26 a5 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0d 40 ff 0a 3c 7d 0f 0f 1f 7d 00 00 00 00 d2

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Added raw EDIDs to commit message
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

