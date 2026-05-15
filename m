Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3265DCD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAECC10F42F;
	Fri, 15 May 2026 07:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="InuP9YzS";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2763210E0A6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:43:01 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-83d31ac4017so3717872b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823781; x=1779428581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3PjlyOf8sBl8btmWeVxVjjQtlMp0Y5dRKaD1umBdh4=;
 b=InuP9YzSnt1HVo06eNEVWrHlM+U08jrs+9kbqvMpC+vDz+S6rzlC1pqFWQN3xaIO8j
 lOKgr50TxOyuNvut0ozInL13UTI4qZuPgp/ZPp6mKLjR/oFus46xrVlm6ZPfwvS1cVg/
 2J8cUODAHWbIzRJmFiYnL5B/DnwzGqzajN5bIcox0AA1SraPJe3HW63JTXkXvyJDMKEN
 y4rd/Xf83RnU/x3y/uEPN5nd+gHorOI1qxsZMa70x65cxFbWC9QC1CZX+RYUn9e6KlcB
 3mewgR80TZu08Uv6TOszc3QV7XA1uevCBdJAktYp7a2ZDehZu2vpgJWCCqAnik/ES97E
 bYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823781; x=1779428581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L3PjlyOf8sBl8btmWeVxVjjQtlMp0Y5dRKaD1umBdh4=;
 b=VlLxPSZUkmTFF04ng0L2VQKRR4x+ivX/JU5/Domo/momott1XcnYwx9tqH2kDpCNr7
 jnfJq5g+lMj77UltPnQ8uMX3K4R3GflU5HYiTvgRsrVeGRwn1VjgUWChU5pkcD+4TdsR
 1RWEIujMDHh265ChqpuM2b5iMZ57N00MuebRvE0v9tUBf34VLXYvV2e/5iYgAHns70qC
 tooaZ4d10cyqgVDKBdZKwv18uy751zdxBH0hTySUAf0mShu4PZ+Pckz+Neb/3zRjMXQP
 mdWS9xaTC7NJhUygMtiY+BS9BS9RG0074Pks3BU/OW/GVdM6WAZcK0szMEEHbcH+do3H
 /OGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jZ1OqB5N/ekQQXGe/TEt+6bd82NhusE4h7jhIJ1m7r1SsUbXBA3fbOR8QNLVyrFvMqUFZWVyvj5c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywal7K+UezEWaaMwz2pCwKOeNWgg69COhfppGE5hyKO6WpEQjfv
 YKj626zj73y728O0FVF4TgfLmoMQK311nFzD7qqiNWDC1wchM4Kg+Z8/
X-Gm-Gg: Acq92OGJn+W5FIofquHZzFG9vGvgQSe4M4a5TXacvPs83nOs7qOsNfxmIONzEPSXh8d
 3qQBNZ/RpWoNqzuWPihd9AhlT8Jl3a3Mr8ylhb/k4IFaSyw1XAQb+YsVMaYH1WreFXrX49K9tNi
 Envvs29zjA0EoPy1q6TiYq3YVnQ5M9Si5h4cOqtgX3bW16s6XDnhSxJU7C2/9fgd1KNwx3D37GI
 F/PkieRrOjUwMtcAD5fQr94bCHEAtbAbc0re34TemRPQFXLbqmjQIfFhC8h2TZHaK0ggAePXV8V
 y5oxk0ATwbgXz/A0JOoGuKwSvoUgH5HkdHkXUKv2bkJKVDjRn0fenanyMkq2Cb1Kg2l/vbrJF7V
 ReHYx6/7vZRV67Dv2VEsdQirpghQHUfP2BYOCHXB+1y5fNce35nWDhGwb8jPr8T8b7MQOoyOFz+
 G1Oo5589frFAELJxSH/bRppHpk55xQWD5j/adVxx/PwWdJAE0SoR52VHRtaloFyDK1sKvaExebQ
 LHhxehKL2Sjt+9b7T+ZKW9OtEsPar5x/ctqMw==
X-Received: by 2002:a05:6a00:3921:b0:83c:de0e:bac5 with SMTP id
 d2e1a72fcca58-83f33f3d3c7mr2755385b3a.49.1778823780683; 
 Thu, 14 May 2026 22:43:00 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:43:00 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 5/7] drm/panel-edp: Add panel for Surface Pro 12in
Date: Fri, 15 May 2026 15:41:50 +1000
Message-ID: <9e749a3a483e4a3c684eac3ee6a4b241c94a0362.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

Panel edid:

00 ff ff ff ff ff ff 00 09 e5 c9 0c a0 06 00 07
0a 22 01 04 a5 19 11 78 07 9f 15 a6 55 4c 9b 25
0e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 62 53 94 a0 80 b8 2e 50 18 10
3a 00 fe a9 00 00 00 1a 13 7d 94 a0 80 b8 2e 50
18 10 3a 00 fe a9 00 00 00 1a 00 00 00 fd 00 18
5a 5b 88 20 01 0a 20 20 20 20 20 20 00 00 00 fc
00 4e 45 31 32 30 44 52 4d 2d 4e 32 38 0a 00 0a

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

