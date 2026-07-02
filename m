Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71068C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3231010F663;
	Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfZ+62KK";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7B710F2F5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 11:28:28 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-847852f9bdcso93950b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782991708; x=1783596508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v0OaAWjYlIYRoMyv8XepLU2uh7OE86lEeTjyFLs3I9Q=;
 b=HfZ+62KKNtRauXSnnhc3eelWaW5dODV3M8GX2c0Cu2OwlR2t+hACKQ21rsc9dnabgU
 Pj0b7Pz8EUzrmhNB2ukDa8x7wxXwAok5x+2Z7bVTzngv5xSx/4n6WRvy7NFvQ4EnvJQu
 TzlCHErmuIWPsM11gk9zZ4W1S46bEnkTieSGxNOwLt6iGpiDEuXOS2Pwo1ap1rdMpoge
 7xIlH0CZNu2fvCpiWxorOL/9o/jEHas2Mrpl69vSqluAk0L7jkw5kGgJNBT7A4oogNwT
 ha9bbeQKxri2a4IShPaVpmLf/GwS90Ql9htPJW+EWInjprjhJUs0UvAirBS4GYRhWIXk
 aqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782991708; x=1783596508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0OaAWjYlIYRoMyv8XepLU2uh7OE86lEeTjyFLs3I9Q=;
 b=W+vhinKns5YNmRzoMQzpXlWIBGZtXh9R5TDNbPcDth0jQBgUmLxev2TH0CzMml2EBn
 MKPgLwdr2CZGPp3toRhfI91Z4ZwmV6KDFbCspASRPuXJIDVzcvg6KgxvZboWXwdiVQB3
 Crtzu9OLOPg+J+SMyE08HX6aQhzgveHr/DVIVrlwZH+0wjB4/V8sNMQv9NxlCDl5SbAP
 lZUxX0iRdZh/pKgd8RbgVPVO8huJe0OqnUgpcoQuHy7aWk0uyv3vXF0TQuKju+ddJdph
 MoVs5NB4Vae9SU7UlAZhLZy1yeculEQ3uclX667GnF7c16XiOQmhBQF/BK2kcsTJAVLM
 2IjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Gc/yPB5gLxptyc91u+OglgLkATFthJ6RfwPeb12BF7iMNI8xSYMxZeGIeuMPgbJuZUHedmKG8Eqg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM48rbnULdPYFj4wv1nKDUGzTmJXkfOqq2oua8u4AxEi8lPwW8
 Mm2DR191Pbjut0wW08RSBNLi2PgLwz1mwWlm3S/MfpV2y6DD9IUfAj83
X-Gm-Gg: AfdE7ckz6xtft7gl1jbXBma1LM2Q1HK88DqjfWjoTvwa1eqTGrRNSJYfLsj0Qd6Q/JQ
 Vi10GA4ln6DxywGNS2EyQByz0/uPxgbuJlRMkPwZC//h0PmcvRHqsEcI1Jt08at9rA8awHRtYHw
 lTG3GWiZOPfCnBdk7Dyqo3FtspiUQjejdhlR4DUQMc1WI8Men8d3JE0U+Y20NjmvqQTxKCSmMAK
 23EQIrPkrx01a+IL0pmPTRZRv7j/X9xIU2/vbl04BZDghC3yPLqEMI68ZqgUTbiXPcGEJ0LyM/w
 DjevfqLUogNEYB1PlV1yCnWPG8ly8WpdT+HUQR6MftvRL7E/rUP1uBP202niTbnQcY68aDhXBkv
 +OW9bhgGvhleqNqqH2CMsZCZMARhNqe8PBOoNyWTA5k6fM1n18H7i0hQUwd1iNQ5NFjOl8SAQk4
 QzHI9NgxJJ3mNJlH6LKligzM3IZTcwEBX2OcwZGT0bVYCMKXk1ffAGYPNb+51BdPL44ZT5hqemY
 xrxvB2BtJIn2diDzyBbFp2OIIIQrAvf5RD36ncl+1AczeUmJs5WWmhClO9gSaI+IPqbKJTqM7Hz
 d7OWNmu9uSGIdxZajBsRdhE/af6dqfM0FIKD5w==
X-Received: by 2002:a05:6a00:1786:b0:82f:99c5:868d with SMTP id
 d2e1a72fcca58-847c0878178mr3165665b3a.4.1782991707959; 
 Thu, 02 Jul 2026 04:28:27 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb76c0b9sm1244995b3a.21.2026.07.02.04.28.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jul 2026 04:28:27 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <demarchi@kernel.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] drm/xe: remove duplicate <kunit/test-bug.h> include
Date: Thu,  2 Jul 2026 16:58:20 +0530
Message-ID: <20260702112820.34675-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

xe_pci.c includes <kunit/test-bug.h> twice, separated only by the
<kunit/test.h> include. Drop the redundant second include; this is a
non-functional cleanup flagged by scripts/checkincludes.pl.

Fixes: 6cad22853cb8 ("drm/xe/kunit: Add stub to read_gmdid")
Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 drivers/gpu/drm/xe/tests/xe_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index 9240aff779da..c2c686aed1cb 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -9,7 +9,6 @@
 
 #include <kunit/test-bug.h>
 #include <kunit/test.h>
-#include <kunit/test-bug.h>
 #include <kunit/visibility.h>
 
 #define PLATFORM_CASE(platform__, graphics_step__)					\
-- 
2.54.0

