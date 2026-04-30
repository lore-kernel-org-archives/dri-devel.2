Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8FCD13D2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC4D10F300;
	Thu, 30 Apr 2026 10:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="L+XNgZQF";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B958C10F300
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:45:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso18437405e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777545938; x=1778150738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH6lwupXQgZsDfsk+Ni+P6Ao1SOC2/nvO0bGhPDZvSk=;
 b=L+XNgZQF9R5iVnvQ63Dae899KoEmrD4RTHZyNwxLmtPoQg5EUOTAk2QpKLNmq/2hLA
 d60vDOJsSkvXxXjRSx0GZ0UnRNlcPUhtJ3/3+IcZRhErMBwKXIDCJNsFhu+MoH39i2xq
 o8A5FRg580RXlL+3EgTup1bUYZ/vn2bdaYXxhZBwWRmOQXf92FP5GqEcDLkl/2mNMW6T
 3Ye4q7PfrwYu/KG2IYrcqSsJKS18XFBSVrMXFCbD6R3UIQiNWdQpROQiG/O2+Zavz0nN
 x1Xh44zVSOrM8zIm/jwW1N64AyEsj1ajo48DNueGtkiNritelQQcDeLXn728SHbp1e3f
 xPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545938; x=1778150738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cH6lwupXQgZsDfsk+Ni+P6Ao1SOC2/nvO0bGhPDZvSk=;
 b=c7aDbsiPsimEkIzh3OkwwZv/Wv1UQ5vTXOBDn4YvtWpINddLxLa5v5bfsdnJUMXu++
 vyPlYrmVO/j0qPQMH07Hq9GW2x4BCYa7Q1UXBchE1mR37V5gIRtuFrun25DjB1GZbqdp
 sJgpara7rQfEPjf1s7pYxB2C+goPdeHaUsvUZSUouEBvApCrCr7qykIXtpIV/XAIgI5l
 mhi8j/mS0imeQgOQh6WsW1lLHDp3X1yWH0jfzg15a5m+57qIzjepJw1G8+JUfg9biPWX
 2VNKMLx+BH+hhFUQhK3Xrsipv5pZysnddTYw6pIcZV5DEvAppkAMSAWC43CRcnnCK8Mt
 Xgfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91JMYa1HMlRIQemqtgjMkLu/hMMmn7BTYJOsWjp+4+BtkdRfCriFmRIOwcQ3JTdwAeMjeCtk7TwZs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi3xZ3K6RGe3WyH/59nFWUngt0AtfLsfNmx1PDeMQse66496pL
 0VC4VI4QP6S0E999cvyARg3jrs28+ya3Id0vLUUAZ8WJbUGuvjbT3uCPgNBd/O/XSLw=
X-Gm-Gg: AeBDieveMvPzJ6Gxvnb+6CCAJ8OZjvhnsG2KRM+IbyE03GRgkzjn5sKDY4wrMa1dL++
 vJUnDPtJsTU6yqIW4KpyYydYkeJGHwPXzjWTc69CRnJXQ9OKH1NROWn/fvWkxU5Olth66a06TmJ
 QFyM+/w8S1h+cH43Q3i0U4CiiZUXF0E1Yd3vqs8yBKM69HAjXHec4HBNI1HMngnu+n1Iv2M8cwV
 EuKSvnpj35gO4U+zAdlVRd78+Hg4G3Jr3cd8zDPN0Qq5doghzj8wloVOHDX8kh+WLWeX1KGpD1Q
 AwLKdzIk8CGE9LPdDpDmXF2Ns2FxYU5+RIXoT1szmvjUykn/EcHFCuGHoTF9kYA226NJrkQEqo2
 dmQPIurc/QvC+5Yc5fG1z5Dn6voXADirPfq1HevW3EUwPeYoopPdcu1ZCXYdxfFIm2G7HoFiyb+
 lmPlWaRBDhVpN6IaqTW4YInxhMTS/XnXMzLRNjraYpSJif8ZofgCXN4E9oLSmcmb/N4kJbLNBq0
 Bfr0m7s7EKDcV26DQ8ow0tyUg==
X-Received: by 2002:a05:600c:8b62:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48a8609bebdmr33353905e9.14.1777545938225; 
 Thu, 30 Apr 2026 03:45:38 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08c77bcc4a3b99186a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:c77b:cc4a:3b99:186a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a820c71c8sm94405275e9.4.2026.04.30.03.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:45:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v1 3/3] drm/mgag200: Drop unused include of <drm/drm_pciids.h>
Date: Thu, 30 Apr 2026 12:45:15 +0200
Message-ID: <b81a4830b3c287e9360197693a823a0dc72c674c.1777545446.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
References: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=743;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=p/fWWZjv2DhPAd2+rU7lplYy4B5Mg8fJo9XCQ/7AKXA=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8zLAYrRtoFHr6yl7PuNhx3gnqegzRykeh8eCz
 Do3ILhv18KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafMywAAKCRCPgPtYfRL+
 TkzeB/9txxNKUZJGGdlmQgJmrayTv0Yn1WfuyndpsQe3gD10/eGuJ5A6wtmN3t+wlBHeA/MUiLE
 WB/k2aQ/V1vHCBVh25eZDAbNNj+FDlrW3IgTj4cauT/sBFHxDtkIAgS0Z36NVnvUDqWU1EQsp8e
 DJsueUKyAxozR/xja1obc1u5eDSJh2Yvre1jskp3dpJQ0OTzXRc+MEvtFWugflYiQ8+GyKWPwaw
 l8RLENpHupS/3nd9PaRPSM2TYXXN8p/R5Hp+cM+6IF0K6Axy8YFTXqSV54BBliK+QMo6AP1P9FH
 MupZkgf7cLGIknejrMzSCj+Q9X1K7YDnd5BJ9ygiI7U1TCpL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

The <drm/drm_pciids.h> header only defines radeon_PCI_IDS which isn't
used in the mgag200 driver. So drop the useless include statement.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index c180dc3c7a58..bb315490964f 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -19,7 +19,6 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_module.h>
-#include <drm/drm_pciids.h>
 #include <drm/drm_print.h>
 
 #include "mgag200_drv.h"
-- 
2.47.3

