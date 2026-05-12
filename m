Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FD7CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A77B10E59E;
	Tue, 12 May 2026 19:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="vhQ2s/zF";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D8210E59F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:00:41 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso4289982eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778612441; x=1779217241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K1LUeqbzazsIc6mr20+RzO+gGoqsPMt05zm7tfAxS5c=;
 b=vhQ2s/zFXCsc1c4h+/xOKpmwmSWn/ND+S9Wn3SsABlvgnbgKVPsBrxdGeDNlxoN5zQ
 +p1bXU6Zw70S8RxAd2aVHFEprDOpIUOB15qc4oCBHnPzKAikxqO5RiQQib8/MpAvSIXk
 EbHU2Ga2RKx6fsBzFyWzA280HLxIhHAfEo8WG4ulNYEEbmtONo9PTzxVTveKI2oEeCnM
 U1GjWzR7SNQSJQFeucngt2BbNq/MlgZR8JGiONyWnHSQ9k9rEkrcg8/+IK5dI1yBmUFu
 CM+TE7xOrv2gCOgwZEXNTpOY9CJBcRzbUayggmlVZmhyc5EFFzCFU8jzT3VJGwHNYP7R
 +rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612441; x=1779217241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1LUeqbzazsIc6mr20+RzO+gGoqsPMt05zm7tfAxS5c=;
 b=GMvGuTomiW+qIUSze4HyJmf8JFt42iXbf75YYFZ18OYikOt6YeEiaPAHX6vmmdWog2
 yh1ZafR2XuWi06NGii6VrG/TwQwMT14NQ1PP3jVGBShpTLl6PpB46DRxtn/8MYQUWqi1
 eqdbsEFLhwOuQFu+ATCtcsoSyYzcOFiLspBMhZpE0r2orQ4wxENXmm/858sMPSAwP+9k
 dpLzUvuJ3WCq5KFMJEgw4/FKx7KoFPKImBCOLad77rzqZyhD7k4NGut4MEyv7SAi3yTw
 O6UzNj3Y8/WXw1OIgA5pwu7MkI96HKepPWJ/1pF5DXARuA7FIZFQfhFogsOc4qWbW8Dz
 2vhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lyBcuC/Yb9oYzc5gu73u2pBtXhszWDnb9q3FXYvO+ntrHHKX3fsOJ4xkAeoeOppmZj5fOVmU6ZqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7nLux8PLL/cS95AqPEnBHvugOYCBPiy+D+KjCMHb17s/e5iOh
 Ac/aoC5UReOZ9tc2r36isn9NEIcqVUYNw3L7KZtrhG7Fxpri59nRaAAMdKdYFin3OK8=
X-Gm-Gg: Acq92OHFxdwxCfipl8xOJEsIYxYecMIAJe6JKi06mCkcdkMRe2oiFX6gN08yxQq5D7c
 3G6DNtbagLUJKPAJCQ6dAVBRi2eaBvCn2YOwrJSWAengwZpBjPHj7bUaLszZDWKTa+E3+EQcaDJ
 RXB6x+BKgZ8NeTdtTLzfOUduBOzkkPDy0KCB+Hk+5xH6m3Q3a2gdtjOUPtA7KCuFYr09zIFizDb
 WKsDuIg8Ru5uss1ZNr0nj6gz4eY5m2hwjcPuVk3FhwERMJfHkFrJlhnC48e01lb/jdfSCP7mEl9
 NNt0CCaqY22YV+DTLf7cVXXDqYOPtoRHaJNgD8OvJvJuPdRS/csIO3v6tTEMHezqvmEADnCvBmV
 LkPEtA4wp6McCmMaQTdY/x9YoxQjw/Vq0inAMHZBpL/3bodAM0vtbUjVboRemaeqCMXJURWZT7D
 yOYF0zo/z48bsgyVq5Q7oT7kxuajE6EXxZNxvhz/5G8Sw7kWlIskPMlPFn86r1E0tP79MW54StM
 JvRIsjy/fdRlEM8NP8dJENHiZ+Joo5RDPBSoNa+KAD2Gbs3Z1RCFB7d2do=
X-Received: by 2002:a05:7300:fb91:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-30117a7ba4bmr167426eec.8.1778612441175; 
 Tue, 12 May 2026 12:00:41 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88914523csm18716616eec.29.2026.05.12.12.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:00:39 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/9] drm/amd/display: convert GPIO translation logic to lookup
 tables
Date: Tue, 12 May 2026 15:59:43 -0300
Message-ID: <20260512190019.228440-1-guilherme.bozi@usp.br>
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

