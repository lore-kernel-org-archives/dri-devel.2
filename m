Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1308CC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3422010E038;
	Sun,  5 Jul 2026 15:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RnxJT4n2";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DD910E038
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 15:36:57 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8478cc93299so2360541b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783265816; x=1783870616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OXCZCCGOyqe2xRMAN5jliT8u+ao8sWXmCdGqqZO2Sz4=;
 b=RnxJT4n21zkuztMIGkGTljqzwc1E0j3leWDUnL61UYMhgkrrA3zuVVtYpEW9/iYEQe
 jTi883rXm99Q8EiPAhkBfwhFT5/PsQ1p+QCaiknARdtfQKXnyZ1ytp5MXInwHTQV/ijG
 GgywOCnqms8X2jF0Rso3bDBPh1k5mDMD4JJk3LxGWxumvi2s2qDwIu758Ax8DYCJuBQN
 Xw6uWUpXxl91v9T3T6b7+m5yQ9F/SGbOBiPu7ssDW8o2u579qi0Ts6+sPoQwNVucGrO/
 Nik1SNz8DEa5lYRfV3VZScrZFhyP/mjDFUitD0nI0/qLlupCUxHgDHlnFk8bFJVProKA
 Yw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783265816; x=1783870616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXCZCCGOyqe2xRMAN5jliT8u+ao8sWXmCdGqqZO2Sz4=;
 b=CfBrKF+WVFRdiJboMOuNM7TL34Go4Bbut5GE1rVTzjXEOlIrRIILSgxjXhL3HLOkoY
 Zo/VHyE1c6QEAzebfil0c+Z31b58SOdimM7xNjcYcwNCav9kxWigHnLfoTzVRAozjcbv
 WenwbFOd3pBMiNFTPi26VdjJh1UkY+KMlNwe1kt58nIau5z9+EadYo4bMQTGho54IZDJ
 /8SgsEdlQEMHdf2sOhGGwEthJDslS6gONlE/DspylX5ypH3WXo19GmEFfKcll8xwylo1
 ocwU7AgNHXH9d/YGtU42L6dXpajedROr0jklmmTXENY52v/NqjDY57KYM/uyagMuac0Y
 4EVA==
X-Gm-Message-State: AOJu0YyEilmuA5fWa//azShYhOcApWz3/AiPkCsUe1ooN0nrZNo2g8RQ
 FmdONu03AdsqB5Ok6eq/ODXltnWG1ExMHGefHWqFsDlObpZYcxvvLQBr
X-Gm-Gg: AfdE7cnGsxR8R96x4fRKO212XCxLRmty0bf28p5Io1uRiSUAZNQqaMdHh9+tNXNIRWg
 bTgnN+ANaHPlLc9QEJ6VTYXqXG3naiVRjybKb9Cc7YJrTeh5KCqv8x/N8rgmPqWg3ykE1KHqGgQ
 1BTa3BAEbb5Fz6do29KLPhDgDPTAajU9wo1fClqWLswpvlBTYLfNonrXRJxZADSBfZjsGz441Od
 LtXggjdko/8+J/Nz7ptDpwmRQWlv3hXN0+G+16eRUvdBUZhq9ZemyXwRVBoRfduH++sm7B3zZsD
 lqAIMXYXYDMI6g1dmEmz8ldPJ/8xLpAf60iBcP5amu3YMZu8mXRjx4T/+bCWaWiTymN9x63Lc3u
 NCY9qx6HjOcHYFemvHJTfMyGNKft/5NezcuRRzMsmtDzgvZ5Ddx3gF5sme0wP1DHyqsZyN5jIgF
 cAvh07K+nnhSgqTBW9HRrI5i/6ncSj+icu38EcUFA=
X-Received: by 2002:aa7:9304:0:b0:847:8b1d:22fe with SMTP id
 d2e1a72fcca58-847f6f67796mr5581254b3a.50.1783265816442; 
 Sun, 05 Jul 2026 08:36:56 -0700 (PDT)
Received: from nuvole ([144.202.86.13]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6db29d1sm2402076b3a.53.2026.07.05.08.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 08:36:55 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 0/2] drm/panel: Add Novatek NT36536 panel driver
Date: Sun,  5 Jul 2026 23:35:13 +0800
Message-ID: <20260705153515.46147-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Add a driver for panels using the Novatek NT36536 Display Driver IC,
including support for the CSOT PP8807HB1-1, a dual-link 10-bit panel
found in LENOVO Legion Y700 Gen4.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v2:
- Collect tags
- Mention the CSOT PP8807HB1-1 is a dual-link panel (Krzysztof)
- Use devm_drm_panel_add() (Neil)
- Link to v1: https://lore.kernel.org/dri-devel/20260630023439.248861-1-mitltlatltl@gmail.com

Pengyu Luo (2):
  dt-bindings: display: panel: Add Novatek NT36536
  drm/panel: Add Novatek NT36536 panel driver

 .../display/panel/novatek,nt36536.yaml        |  91 ++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36536.c | 488 ++++++++++++++++++
 4 files changed, 591 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36536.c

-- 
2.54.0

