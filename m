Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6502F31E4A
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F77D10E887;
	Thu,  9 Apr 2026 15:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+XjJRky";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FFF10E887
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:48:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4888375f735so10522855e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775749710; x=1776354510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hi7gTWUjjbNZ/lpqn6fGZ/r8bt9C2/F9X2ujmXrNQKE=;
 b=I+XjJRkyzKDfyHgCDdD4kECEYXn7hVgIrEaYNAw9SVMm7d5xr15QrYCxLkjnj/tjBs
 AnROS+2rg/9p76APXilU8YhwN1F8FdoxYLwFFXLrEd0L1BVAqSnoKjU6/UWThv+e26FM
 nonKOHQpzii27/Dvgf3A60lLEndV+Wh6OuiL7cxw8RAQCPMOpixHVTr8ztG8LVctvKIz
 EpCzlwqPERE8beN2cAZcTcE/jFpPVe8tpHY5q4aKC2dMaa9mR37H3O0LR2nlpUyi5x2K
 +VWQ0s/MqMdcTXF7+FiucBHWvergrs/8x3ApBlIXBHRYfFT/JP7dhjFqcBPAemLLPy1B
 WYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749710; x=1776354510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi7gTWUjjbNZ/lpqn6fGZ/r8bt9C2/F9X2ujmXrNQKE=;
 b=ILGNitO/OWE66dtBt/AejayJFA58YJi3dxrr1IyXpItVY+nbD0079ynHVvfjdAtmdJ
 Xm93CnYNmV6TlkyQG4nMt2OcYpdTV4MHJvgYW52c1O87FI0Gt6IlRdf3SnimB6O4t2EO
 OH2QBFPb4wkhYls2ZvDJfDsUzmJcsGfjAihin/VVPz02aqh65AxadaCid+x8E2yMgoNF
 8f5eCQf8+ByAQQvqLKWrUWNosiX9j1C7xx0hgjgPWkPE/xvbWyUnBu3N17SHcg8J6EIu
 dCsgSJJq6cgIcPwdzlTOYdOemDNY0t/geqCsHzYuDudZbXJLi7MT3EMuUbDRYYE4OhU8
 rRjg==
X-Gm-Message-State: AOJu0YzgjYgFrk+i/g47+yjGWmGeC65RT+XoJv3NnWfzvpkTEs6v/RcN
 Lvw8gvzC1Pkx0vxqE2Yw6QXA7FKU2+ts3NACDR7w9EhXs8WGZM1AgYCl5u6oAtyeUxtbjg==
X-Gm-Gg: AeBDiet9AnCKF9/jpOePMjcgWCoruNNBTSoUUqRFlLEioWdrNeVsNl3RWXk6u57ndsc
 1qLPDEFquqy37E/z4b6u2H1h9ychWnCsNX24IYO21w5j+fXLH4Y1IAgiufA+mzaWs+jtHye0xm9
 ML8Yrbghp3m1OLU9DbVAMnqUjzGfKDr0VloJp7VkcEwIhh0qWFx6kAqH2GfIwur3mrxvZXjWcFw
 OYL6uRB75HfIYwU3hADDQJHYdNYAICQfIRI6DIV4fUUMoarkK/azJ/G3ybbHuKucM1r4VUdLoLR
 IX7DljhOywdN2xkBw8SjP2G2RyQXArQf8qj/u3TDVNFRdMvUWJ9IIiE0Ezb+16eP6yVp2nIqDKD
 aWWyNEU5NJX3OABhy1yhFjxJ6CCvfoMpUN37pdCNVbccpUTPr/ZtHcDpzJQI0w2+tfuB9pqVJn+
 3R6a8wh1JBDQt7pt4RYhKiCtZhB+1TGjnX5Nf+5sHBxHOOZI2lr5hhej2lBCNbSLWFZH+pIhbzK
 PJyW/sde8ojrqyMt9E=
X-Received: by 2002:a05:600c:3f0a:b0:485:b6dd:5066 with SMTP id
 5b1f17b1804b1-488996f9414mr382636995e9.7.1775749709613; 
 Thu, 09 Apr 2026 08:48:29 -0700 (PDT)
Received: from Arch-Spectre.home (host-2-101-228-96.as13285.net.
 [2.101.228.96]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d53807d7sm8920765e9.10.2026.04.09.08.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:48:29 -0700 (PDT)
From: Yicong Hui <yiconghui@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH] drm: Remove unused header in drm_dumb_buffers.c
Date: Thu,  9 Apr 2026 16:48:26 +0100
Message-ID: <20260409154826.8955-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Remove the header #include "drm_internal.h" from drm_dumb_buffers.c,
which is included but not used.

Header was introduced in 47f10854ca89 when moving functions, but was
not removed in 96a7b60f6ddb when the drm_gem_dumb_destroy function was
removed.

Compiles successfully with DRM enabled, pass kunit tests and
IGT-tests in a vng virtual machine.

Fixes: 96a7b60f6ddb ("drm: remove dumb_destroy callback")
Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/gpu/drm/drm_dumb_buffers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index e2b62e5fb891..61bf3c9b7182 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -32,7 +32,6 @@
 #include <drm/drm_print.h>
 
 #include "drm_crtc_internal.h"
-#include "drm_internal.h"
 
 /**
  * DOC: overview
-- 
2.53.0

