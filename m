Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D86AC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EBC10E75B;
	Mon, 20 Jul 2026 07:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="VmjwMqoF";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC2810E407
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:00:08 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so85975265ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1784257208; x=1784862008; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xOzVSHNBDNSOB4E81Je7FXFIT8+VyQrxsrlI2kqyQ0U=;
 b=VmjwMqoF7QUIISZHoQpddYPZF+5f2DyiOYVUh9AwL1C8B3VElqPJDEZuuKsfogEKCP
 ErOH4wa7bttTv+Zoy32t7r8niHy8fGr51nOaTVNYVyrpHNEN2DJbw3/l3i9rLOvZr9Ee
 +JtDenmW945T1O0vY5tHwzUjD9rbkhISamXwbZn4r9vQuivad+K5aFbVDNeFh65JQWRy
 JujNzrOyx1FB2JTrgsPXZ2Lrpa8DriO4LQCpQ2kGY9g3q5p4BTO+N65BKG5Zc1ZVCYPS
 xHkVvnnf9MH06pqMm8r5V4xVAQ6G9iN8l7d6zahYm+Ors7AKHAxN3cqbgd+NyzSglt1e
 +Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784257208; x=1784862008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOzVSHNBDNSOB4E81Je7FXFIT8+VyQrxsrlI2kqyQ0U=;
 b=fW22jMCccIDgTm2NAS8/R7IDZUwa3k0O2zEJ48VhHBVOzqvznNdWQoVRG7U9Ze9DFA
 lMWp4iTfn1gDcjTZv1pWzgqgD8xM+EBHq3CVdtIlK4DvdydQtXBx+px1NBX5JTrN/9gB
 h3LuuUBN2k1c51BoO6slsSfRo+jmBDjrsiB1s7ThmC8gMvgUnOo0ARpAiruyu3hBR2r8
 //VlwS0iA7rXsaXL/p7qLMTX2Fe0n1MDVSQzxyJqTkcK9S5lXPpZ8dVzWj+BiVb21Svi
 dDknXH5BgAhrJXBG8oqzeIX+lHvrYT04VL7MnY/0drMwzud0SXPcqhqGb/Wuw//gho/B
 8Yew==
X-Forwarded-Encrypted: i=1;
 AHgh+RphMPhsse8MhxYwf3UrjDvpZkM1EEzZCJnyvJc3woxplVtzH/6eF4He0OeMByYrjk4VxIHk5Qxn9Xs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc7ncrpGx+GoOHuLIaJj9D8bA+n5fGKTH4IEfiPqhs8IU8mfxm
 W74udqaVGz6lcEW1TF4fZlz3OnyjK6ABoIRzwrYYo5kuQV9mmaxt77bqoCprmpDwYhk=
X-Gm-Gg: AfdE7clwloPY4J4xUqNexCXFehT6RMqLXH3h50JT8hqQaRD3ShJM6xi81HZ5nFafnQF
 t3nCohPPzpqGF/3lHTTSka3lZlKWw7tlbx6yHefaoZIhnSRoSWnZPhVRXBpuxVFkbTAauBYetS9
 RYsjZmAZKgRpTIAcS6dJl4658IflwK0/9sWsQM79BbVk8B9A6dMKU099twrBU4kfDRxhWSd16mH
 73SnkBsPzAnTyAUeS9z1Bw4ES2oHEiYwBk4FKa0O0tGPTPY22w1ARY5SRhhpYhR+EpDGF9hVz+P
 g5Y64R3QtzBznrnVnnxAY7IyUh90UKOO8lQZ38m/7X3K+5T5jwF9f12KfS12kpy3C+Fol0N2JGk
 sfQGnhrd0nio1kMNW+zSllABo/K7TGGbsJfjh3LI2ZHV8alKr/VQUlXIG72t0gd3r5ZSY9xM7uy
 esw6iv2mkc400AlYz2WvJ6OYdkw+Ri0cQwOOo1slwm1zaPtrDH4zzT3aAWZ6rMDdZGR60wdE3Sj
 xKa5B8=
X-Received: by 2002:a17:903:228b:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2cf3484be35mr7946935ad.4.1784257208283; 
 Thu, 16 Jul 2026 20:00:08 -0700 (PDT)
Received: from dio-Nitro-AN517-55.. (61-219-175-100.hinet-ip.hinet.net.
 [61.219.175.100]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3471f42csm2444205ad.61.2026.07.16.20.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 20:00:07 -0700 (PDT)
From: dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dianders@chromium.org, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>
Subject: [PATCH v1] drm/panel: panel-edp: Adjust T8 timing for AUO B116XAK01.6
 and B140XTK02.4
Date: Fri, 17 Jul 2026 10:59:46 +0800
Message-Id: <20260717025946.2751081-1-dioyc_zhang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Screen garbage or flickering can be observed during mode changes (such
as VT switches) on systems using the AUO B116XAK01.6 and B140XTK02.4 panels.
This occurs because the backlight is enabled before the video signal
stabilizes. Waveform measurements show that the panel signal takes around
140ms to stabilize after a mode change, meaning the previous 50ms T8
timing was insufficient.

To resolve this issue, adjust the eDP panel delay entry from
delay_200_500_e50 to delay_200_500_e200 (increasing T8 from 50ms to 200ms).
This matches the updated panel specifications from AUO, which now formally
define T8 as 200ms to mask any display abnormalities during mode changes.

Signed-off-by: dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 8d3859cd3ddc..3a168bfffd4e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2055,7 +2055,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1999, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e200, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x203d, &delay_200_500_e50, "B140HTN02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x208d, &delay_200_500_e50, "B140HTN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
@@ -2074,7 +2074,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x67a8, &delay_200_500_e50, "B140XTK02.4"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x67a8, &delay_200_500_e200, "B140XTK02.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.34.1

