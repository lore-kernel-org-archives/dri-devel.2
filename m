Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18450CD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E164D10ED05;
	Wed, 13 May 2026 07:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kuS51P21";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F47110E7B2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:42:16 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c7ffe8eeaf2so1769033a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778510536; x=1779115336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8jn65Vs/XmHD5uCxPgx2o8WJQwPscsdf6beYXOzE4Zg=;
 b=kuS51P21K+spsAICBVo9vjovRga7yeOnSFN6GP0hwUbUc+MREjgcHfM6OKn85oXRvy
 BaoZqVJtYSeTg8VsCwjpff1MjvYALO8cWS4PUeSFKKf6rHnjD4XgEDnxd6krf75wmoXC
 oQXHqKk6ttWI5bpgO0g0HxMPt+Djnn22AoPX3jHFzvI/vxeQUWOGwTuyfVw+pssJyX1J
 0OOYetq85YJ7EhYbro+PSrwGsl1wBMdcTgDBNqAoTtieg9ZmHvbTBEHriaNyixJYMUpD
 n7BcJG21HXLjlC1IZ7vCJDqA50OEjUWanjQl6ElIzK7AJNOFZQXtO5qw1LyCOAl7W860
 Srxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510536; x=1779115336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8jn65Vs/XmHD5uCxPgx2o8WJQwPscsdf6beYXOzE4Zg=;
 b=f4MVkNdcNsqvbTeuQPdUOBeWkNdkW2W8Ti7xzyMkZTEC97PQl+g9mWvPalNnCjp2El
 MI68pjFGUwUshFc9EBaqlHKTIzW2uSmmJezmouKrdnjAfUMdd4aoOBrNGtcqlp5wkgDf
 3QS8YqjLBxCugXQPhi9POc6fBqIhBFhvhmubiTGnhVvPQKIKQdDAGR1xOHPQnYdSqvnp
 40ImlqWAHjznfa6lfi6xam3ixIjqCBezEz167rBh0xn5IEboRij+V0lMlFNCk4kjAnEf
 V7QtFKM0c6aMsMwXdJi9tR+jb9ilTODw23KIXW+aLfP0FnnSTwIJmEWl8LKB2FZrIv2h
 9Yeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gF3LFeIL2aEIEV0XUrLEb4CARhEAh51O2edTBH9U2Cm96HiMmc7vfeP6Mz5iV27cl7s5lC4g5CcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoFSHXYIVgkGX6VuJJIavudbz8FS4FfU/0vgr+islbkgA727+r
 1eb71rTbLq1CuBBRPO7clkFDbRL9AVHFtnsCtmKkAprytjSSMqPEbzGb
X-Gm-Gg: Acq92OEDNnICRegyXYqfKG680EZwNNJq2u+tvySzuC+mNSInD6xM6pwakdikHfnrqo3
 0iLrdCpoIN2t8Ifo/C52asWP9d4Dm6dUiOYQieeUa1f6UWnuJxFuYH3nGSynPt+6efxBbmfoLco
 k9PYaTO4alws/j7Tix9yCBj4k9VnG2PrXZBV7PrMOuGtSUFGgpICHgD195stAPi/urtOkh0sLok
 Q7JiMJZPDelYmCkaJ+oJzyItGGdKtQtgQWsE1gz/h2tP2G6XrjxUWSVFj5RB3Lv04GEE1DWdmog
 BagaDZoDWQYKgSrtTi33FdzY4VVtFr57B3cSwfyP4rnecBcl/svIPMHpjfGVXZ5tikObLnTmzYC
 +DZgKOyw8YJx5LFsDXxb4XV55CnhIuY4pAVg3kQLdRoLAmzLorbPCTsaAYYUT3i0TJSYyuH+QdB
 7eAngl2QrWuxMi85NW0hNup2B5BtGSroQ9ZzLKuB8aAeT/B22PChqzMqtrigapO00Gv8SA5/cWQ
 MEGU5it++sv9+3X4fB4Ft2j
X-Received: by 2002:a05:6a21:e097:b0:3a2:d68d:9e83 with SMTP id
 adf61e73a8af0-3aa5a907649mr27062284637.5.1778510535983; 
 Mon, 11 May 2026 07:42:15 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.lan
 ([58.164.4.185]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f11csm26012405b3a.3.2026.05.11.07.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:42:15 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/8] drm/panel-edp: Add panel for Surface Pro 12in
Date: Tue, 12 May 2026 00:40:55 +1000
Message-ID: <44d976999b592fb4993bd95238e56cc4d9e228f7.1778498477.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778498477.git.harrison.vanderbyl@gmail.com>
References: <cover.1778498477.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

Add an entry for the BOE NE120DRM-N28 panel,
used in the Microsoft Surface Pro 12-inch.

The values chosen were tested to be working fine
for wake from sleep and hibernation.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 497dcd48f57b..2cf52f03c217 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2020,6 +2020,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c26, &delay_200_500_p2e200, "NV140WUM-T08"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cc9, &delay_200_500_e50, "NE120DRM-N28"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV156FHM-N4S"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e200_d100, "NV140WUM-N64"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
-- 
2.53.0

