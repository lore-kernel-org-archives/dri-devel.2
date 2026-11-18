Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE7606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F131B10FCB8;
	Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D5510F9AE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:47:40 +0000 (UTC)
Received: by mail-dl2-f3.google.com with SMTP id
 a92af1059eb24-1521c45a248so699567c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995260; x=1795600060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4oXRPbHc3fd5SVJ8C3IA2oI/iwyu+86UUZoTNrt+hdk=;
 b=G3hYP+TC1tGSg2z0g8m8AEg+Q5uRpXk8OMhJfG4AmCdvDJ9fMqMX1l6bBiMhvmzt1f
 FMETkL8Lpk1VF+sDVi2IRjL0XwBOJBCBAEcwFwHlcc5wdghKDGczc+ADOQ0mIa5b+eAA
 L9F6GFlP5h6fz9j2EwTAAGPnUOuGXwzurDKFbsx3/HhYgYfwhbRjdH4YPJBucfM+MbAU
 uWJ33Q28MniaYFPI6aJxDMyGx5jJFwxmdnhqoIu9QdOot8XKfiedAsQLYnrcyMsczq8G
 eIllF8W44HiAFQhLFiRVZlMcqpfgy5U0GC9cW7T9fKpmYSoWFyqgjHMpICjZQS6USdj1
 S+wg==
X-Gm-Message-State: APuU4Z+u9yt8K0ji99t0bnrpGJCTCDo407EA4M2VA/yjAJylE/HeAfKF
 0h2BogwF1n/5iFRWwggbZBp5Jy4Wll61inDeF4+e86aKH67yaKaov4I9
X-Gm-Gg: AYBFou2O91mi3gHvsIYTrVwtpjB2QMYVBSmfZVU4m5TIQ/xflHgnspIjBqQ5cCj/KtO
 T+WpL1luvWsDo0n5cNM+HwuXaviI+6dkTfdhL38/fJOtesJ95v7Jl3BDrWf0rEkODU3555ahIWl
 UzeuPYMfcQkS19oc6xqiJ/FpDIlORVbclsAtZbjk1PMFW5A4YqI6XVIM6TlcDth5QAGq6R+zJv2
 1LOGX/KxUCjMgcJVfbf0X6Bosr0MEoKSpOvLDD+26wTEsyNNCDHYxebuhEHb33u4Qz2PAew2jOE
 tr+e/oDfdZwmQU07G8PSShtkvACwTQjsCDjJKvpAnHR2cD862JVcuNDLhnkwQxcItoW4dF/4ypF
 uiCBdwSqJrFxr2W+2TM1kUFBz8pfjkj0Gbs1dlNGtLhztZN9gkB2VrO+Ka6s8ICwEWR7M6VZWwZ
 h1x/0npG1EyjmqBWuvfxGNyLWtDharkzJMrSvsGdQDkfBPmX4p97vexBJk7R7KbmvQZQ5Ht3FDU
 OdMbD8tCVhK/E/LFNa0bh+bZUlSb5R7xHyHdWFxST+gQyRHBUTxDA+PkrfSpTYIFgoXom0B035r
 DY8kEEB0TNHCUG38I1LAYcdeiPYzhSxR1OZjlLvEqjhlZjA=
X-Received: by 2002:a05:701a:cca2:20b0:1b5:1a0d:b544 with SMTP id
 a92af1059eb24-1b543beb57cmr2310789c88.7.1794995259724; 
 Wed, 18 Nov 2026 01:47:39 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784017sm5326510c88.4.2026.11.18.01.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:47:39 -0800 (PST)
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 0/3] drm/panel: ilitek-ili9881c: add Industio Purple Pi OH
 panel
Date: Wed, 18 Nov 2026 17:47:17 +0800
Message-ID: <20261118094720.110127-1-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the 7-inch 800x1280 ILI9881C panel used on
the Industio Purple Pi OH (RK3566).

Patch 1 adds the Shenzhen Industio Technology vendor prefix.  Patch 2
adds a board-specific panel compatible with ilitek,ili9881c as the
fallback; the module is marked ZC-700010BH and has a 94x151 mm active
area.  The vendor device tree only describes it as a generic
"simple-panel-dsi", so no panel-vendor compatible is known.

Patch 3 adds a dedicated driver entry with the vendor initialisation
sequence.  The existing am8001280g entry (another 7-inch 800x1280
ILI9881C panel) was tested on this hardware and only lights the
backlight without a picture, so the vendor sequence is required.

The panel is reset through GPIO0_D6 and its backlight is driven by PWM4.
On hardware, the panel probes as DSI-1 94x151, modetest reports the
expected mode, and the geometry test pattern is correct.

The board DTS that uses this compatible is part of a separate Purple Pi
OH board series.

AI assistance: parts of this series were drafted with AI coding
assistants, using the vendor device tree as input.  All changes were
reviewed, built and tested on hardware by the submitter, who takes full
responsibility for the content.

v2: add the vendor prefix to this series, drop the redundant
    width-mm/height-mm properties (the driver supplies the panel
    geometry), and remove the non-standard Assisted-by tags from the
    commit messages.

pjh456 (3):
  dt-bindings: vendor-prefixes: add Shenzhen Industio Technology
  dt-bindings: display: panel: ilitek,ili9881c: add Industio Purple Pi
    OH panel
  drm/panel: ilitek-ili9881c: add Industio Purple Pi OH panel

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222 ++++++++++++++++++
 3 files changed, 225 insertions(+)


base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

