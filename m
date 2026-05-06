Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F88CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8915D10E1E4;
	Wed,  6 May 2026 17:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="cjusk6Fs";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3B910E1E4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:06:18 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so592546a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1778087178; x=1778691978; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AAA/XEnDQYh5Fa1StvH5sfi89CGS4a9crVf2I8bGITQ=;
 b=cjusk6FsYeYCZexqAYLKFS2V2dlTQycDN1sdRWPTCgSrRJqX31njqs8Kb+CpT7k7Gv
 cdf+twS8IgCiDvr9Z3vAcRduSkYSU+FXPQ99iCN4k959eCMrbp82xXg5ZA27sOsAoGCs
 rLHlfCMBr6CVO1ipzngKTUj+MnqZ4M5Su28Gm3PsNtP4mot399K502pEDjE1axUzKBYy
 ktjb17hMsa7+hjZGYtJvOJu/vuAxOHVWFyJnO8RUzzAqLLqRPpYFMg/6FYuHLzOK0Z8+
 qOGKrPKXEybaQxkrP029I4O63ChLcXdXAZy2gXB+bjZKkhw8rs1ooEpt8DzcbOwMPq99
 hTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087178; x=1778691978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAA/XEnDQYh5Fa1StvH5sfi89CGS4a9crVf2I8bGITQ=;
 b=PlxaMC6RY5jAH5KFXSTZmHPxpA3PxXTMrlVgyBMLajv14xB8USObinXHAsLyMlVQsy
 jpG0JbkK1iplnEScuBsZi4IG0y/nD8iyGFS3HL1R34xKLMU1VhRqCpWcd+lwP2A8P87c
 9/232OMR6453o6+HAGNeq5uqAHFzwKhT+2rIvGoEBnoWhNme4/SFuvXPkrzFX6T00xi9
 b20GryCFZGign7msdC3wmXQ+stE5J4Q5r2umAF96YAzR6oNPlppcOCe3TP2EYNDfLURv
 Wsj552yeje5lA0dQHIQszjFaMLJZJlIu/LcmbPJC+/ZoisDP9YS0gbSCOxZ7YQZLY+sS
 Zaeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yqcpDM8rmtUy9DIDRCPcMOcpWk4FpoAwgeLlWxeMmgKU1eSWE3AFl09Nrb4EBWgkZpxVo0wcTqm8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0RcNGxWCRF12a3hjLuzXHOTyLOByMAtRxDB9kHV0C79X6SJWc
 bOaasnlIkCW+9zNfcyeyKYIeyUHFvl+mP+nGYydAd1UD4lYfXfvB/fKR20wa2Uw3h3k=
X-Gm-Gg: AeBDievmg+hOPZo7YGG2Kh6kcR0i1fKL37+wNGWXg/vZeV9YaLsJ4kn3t9ZG6lOsMpF
 J4Evjbrg6ktXSP8nqBPZez9fIejzhmw1jSJbHVKq8FAc+Rk8yAWBA+1Srw8lEs5QVRI30s2u+j6
 z9oLq5tvgdCq7Uf+bY71N5oGbnhna8MJHzmK1gF5qXdUUANPvD3cln53KWabA/muE1nrt9JqcEP
 /v7ZtDWx2GYGnPfGx/pNpmTJEAskhVSri8VLzrlgRFxdk6bYc9xoCP+8oL2NX8kXbP274jTcSZY
 rHyn/7acq3/laI571hU5j9nBIHluaWYc4kcP7PQ0/ptXKOAK4Of5wqZMLQhfGJk+RYvh6V1B6JT
 lA7xTz7fzH4ZYzY9T/qk2+p3KvmUVJP+P7CZg/7owDvqiKK2/zpqyD0QpJbco7gt7UAubuq+b5e
 HtVRRu1KtPRJ22CBqPQJHaImvuUCdnCLjo751BGxoRtGIxkq+lAsHpvWSK6Ib5J28VnlkLQS2qc
 wWpHmmtAL4=
X-Received: by 2002:a05:6a20:7489:b0:3a0:b65a:5df5 with SMTP id
 adf61e73a8af0-3a9f771bb4cmr7934176637.30.1778087177790; 
 Wed, 06 May 2026 10:06:17 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. ([150.116.253.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242ab8bf4sm2649096a12.4.2026.05.06.10.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:06:17 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v1 0/4] drm/panel-edp: Add and update multiple AUO, BOE, CMN,
 and IVO panels
Date: Thu,  7 May 2026 01:06:03 +0800
Message-Id: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
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

These patches add support for new panels from AUO, BOE, 
CMN, and IVO to the panel-edp driver. 

Additionally, it includes a correction for an existing CMN panel (0x14d6) 
to fix its panel name and adjust its delay configuration.

Terry Hsiao (4):
  drm/panel-edp: Add AUO B140XTN07.5, AUO B140HAK03.5, AUO B116XTN02.3,
    AUO B140XTK02.4, AUO B140HAN07.7
  drm/panel-edp: Add BOE NT140WHM-N4T, BOE NT140WHM-T05, BOE
    NV140FHM-N40
  drm/panel-edp: Add CMN N116BCN-EA1, CMN N140HCA-EEK, IVO M140NWFQ R5,
    IVO R140NWFW R0
  drm/panel-edp: Modify panel name and delay for CMN 0x14d6

 drivers/gpu/drm/panel/panel-edp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.34.1

