Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E576CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E1810E28C;
	Thu, 11 Jun 2026 19:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="GuJyaSky";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B6910F0DE
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 19:51:21 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-59ebb89109aso109062e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207481; x=1781812281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AqexdJuQhvZ4SiuJdYKxfTsj0ya3VX999FM6ttvHo3w=;
 b=GuJyaSky66coFT+f6bwMNiSkpxaqD4zQ6+JlujatE/JHORU4xVmaaZgbcWrTq0+hsP
 0GtHci1Tqu28fm8M4y3/TNFZrasZQ/9RYny05nAtTX1gqqUklcQqpOLi9OY278iY9sta
 D2KAh/AabOc5ox0w3EkzitEsweqZRht3/19TYGzBZD9TTqvxpOeM1Ts4oD7c95zo64kp
 InS7QLxDF+2cY+L/yWx22JrKsYq+S955q9ux+U+3o/lzknIYrqL9DvQIXg/dM+dLqe+e
 ieKI/7rUoaauKGSf8O9BvE495Vb0KacT1gMmByH1cUmGmLX9OxbBo2cxZ/By6HSvRiPv
 ojfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207481; x=1781812281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqexdJuQhvZ4SiuJdYKxfTsj0ya3VX999FM6ttvHo3w=;
 b=oWLcLiuKZtJpKJrEa1GJtpHRv+ybikXEkZ7I4ZCc0SwEtrcutfeQzTELgOEyhqCRCN
 DLJ2RjWZ3NRMOJd5KLMVrsV2hUdaoqamHMW//LbD+FAJ2YOWJy9nVWJZONeA19J+GO3e
 iYOYsfBNmZLx5k1RwJKDzOzMkNV2ezFDYWfNiwLv+PTH0RJH7pV4xQWZCSqNG2zlCINd
 I89zeEtORDoEdLrOXSGGESp5P/mt/Qw2+/XnDKgO77J4E1ij5W2eOFAMFO4QhmvhQF2L
 YQIdTYDtfjTV95Nsnx7pVJJ7I8lZIsXV4bzHQR5AixAvdZ4mpPxBMKozGSVVS8d+pjWE
 8DKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jQYyAW1qVToF9x/lbrsJ419RCy7we/wNRce6ISfBoI+q3SQjKbRriLgtSmdfpvZx9tn7w64bp/oY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx47W07JDUvgVZa7zpAes8Z4ZX3AaCeLHYiq62A1oTzJcexukpl
 eOXbf8ilVBJNNGPrU86pYXUkIzuIMr8v/sF2GO/C0EYjqGEJAXW2hoiyU5pSqiqdkyE=
X-Gm-Gg: Acq92OFES80G//Am8M56R/+KZTkj2YtT3b6sqG7YV00874gnu3J/SaA+UtQIDAcu3cK
 eSo7s9tf0/GijZ70fQTA0ItLS9QzrzgLk6FLgcQTTpvPkeXUegzVO6t+7w8gBP10oIkfplC4AVS
 V1eSYSz6QgE8qkpCeNQV9gYu10Gs2Be4Su1w4S8w2a9SLU+ErOj9oamUoC5VR4o4fCWnvp1P05o
 p3Fmx+OyRZlAENPJh4kR9FFJJDhE0B++J5iK36V+fA/K9pI98yH/3ER4rRqsxmLi0tJdKWLRDLP
 R4Xu8Y9ptNYH7G05MZDeNL46K70KL5fXGEauWLDj3BFH7VguvqaPi/w0dmpzNbmRoecAGEmOdvz
 OA6Pwq+BcnbkapECR6OIR32GtGxjbfWEO101k8ywfNzZCwQCjXysbjxFTFJKwc29XHuhZyXuTFV
 AcMJPqX4+q62US2h96ASTAney+P1bheMmmRpWIKMkP3irjVY/GfAMf2946WFGTEsNDwOgm7w2op
 meinoAqwrMQlF/R5wONDj2ZZJ9nPzr26fyuM42/VH4EzaOl0Q==
X-Received: by 2002:a05:6122:2485:b0:56f:6b46:28be with SMTP id
 71dfb90a1353d-5bb00d816ffmr2885899e0c.8.1781207480684; 
 Thu, 11 Jun 2026 12:51:20 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:51:20 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 0/9] drm/amd/display: convert GPIO translation logic to
 lookup tables
Date: Thu, 11 Jun 2026 16:49:00 -0300
Message-ID: <20260611195026.25125-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
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

This series converts the GPIO HW translation logic used by
multiple DCN generations from large switch statements to
static lookup tables with shared helper functions.

The new implementation reduces duplicated translation logic
across generations and makes the GPIO mappings easier to
maintain and extend.

The series introduces generic GPIO translation helpers first,
followed by per-generation conversions.

The following generations were converted:

  - dcn10
  - dcn20
  - dcn21
  - dcn30
  - dcn315
  - dcn32
  - dcn401
  - dcn42

The dce60, dce80, dce110 and dce120 implementations were
left unchanged for now.

dce60 and dce80 contain special switch-case handling paths
that currently do not map cleanly to the new table-based
representation, so they were intentionally excluded from
this refactor.

No functional changes intended.

v1 resend:

No changes since original submission.

Automated review:
https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-overall-20260512190019.228440-1-guilherme.bozi@usp.br/

Guilherme Ivo Bozi (9):
  drm/amd/display: add GPIO HW translation helpers
  drm/amd/display: convert dcn10 GPIO translation to lookup tables
  drm/amd/display: convert dcn20 GPIO translation to lookup tables
  drm/amd/display: convert dcn21 GPIO translation to lookup tables
  drm/amd/display: convert dcn30 GPIO translation to lookup tables
  drm/amd/display: convert dcn315 GPIO translation to lookup tables
  drm/amd/display: convert dcn32 GPIO translation to lookup tables
  drm/amd/display: convert dcn401 GPIO translation to lookup tables
  drm/amd/display: convert dcn42 GPIO translation to lookup tables

 .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
 .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
 .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
 .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
 .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
 .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
 .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
 .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
 .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
 .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
 .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
 11 files changed, 1274 insertions(+), 2035 deletions(-)

-- 
2.47.3

