Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E3FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025FE10F2FE;
	Thu, 30 Apr 2026 10:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="F28v/YNc";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421D910F2FE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:45:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so4865035e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 03:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777545937; x=1778150737;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQwFm9jiEdrCsHCWWqeAxRTirLWIVkqHXmc2k/6t4rQ=;
 b=F28v/YNcQbRszFtgocMuqjYHhpZB0dObfdJoVkT76updSCFYn0wegYNNhR307F30bA
 jmICCZWsFY/dDYPd55mf/Bdm2znLfQbcltZ+q8PyygQwGmGB3IXcH/C+YHz8C06+xK9z
 N8ozDy9EwjY2XDzp318uDlIONIZo9EZve4xuqbNMm6ML9Fqi6Bi9Jvq+IGW1RTPb633J
 AfNaJCV7ntMllKf6mz9sziYYDxBDAte4KPx25NmLDm1UwK4AdbIBDG7DXJ69ywjxqGK6
 wdKA0W0L6b5OPKU1nKGh3mTKjdXVcEv6rj3WzKbUWsb388ptf6p+3ujhKP1KlXWSsm99
 xOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545937; x=1778150737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQwFm9jiEdrCsHCWWqeAxRTirLWIVkqHXmc2k/6t4rQ=;
 b=f/P3bfBZ5nOBCCFpQqpIJEagvNNt7iJ6MidU9axxTKiqtVUSmebM9ZdY5pjU3KgXpn
 xv2WtsTCwXo+5e28BOHf/nyxkSwOO7+seOjANsFcZPoVA7vA7ZO5of91USRlBq5jDqaR
 3mYTQ8s93rChcZHPvJZb3yrlNb8HcFVtMjBusVo0tvhCcOPpwoFsmZCHIHKl4naLxD/T
 qgsfu3SpukoHoGOEqnAMZNDRy+aLGdIaRVnC0deSuWKFCcCZ56ALExmiNRf3f4Ov6Xxf
 S59Fs6RfHkBqn3ryEAtrCWncXq9Vd9o2rD9mj9tdJD8aQTL7EzgpPosJjizi5EA7Yj7W
 33Rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qyXgYAEMxDBIuNfmpmJsZFZtgQLuU0U21MDjlSru4wkcgQMOXpkCC+CneSk2AS+wF3fDIoqsagNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9aBWD6EasTjf52RVb4iBcXTrvmmkTnlOSBmSS3OnpYVKEzhfw
 5qkbU/qO0wyxFZy3LdFIf90Yr9Z4sBeIuFacqcPwLkE0SGY6M+GymwtRgZNDE1uIT0Q=
X-Gm-Gg: AeBDietouh5mnsCVyiD5MlFW/SLZ5BlWA6gLaZw3n8j3OoG8dGcpKjdVRNTDMDsRv0d
 IYIVLvWzF0gFialFvMCeTBrvkO88fL/OjCPki9nq+zqEItfD2AGQrsR0fI28blHglJFpwmDqEmE
 n+T/QjH8tCIbzdKiyt0sj0BcreGTtCSFfttpduED184jI610tsWIZoAJ/nZBvivhPa/MB1vw4Tf
 88v8jUnaBtpFX/aDTPPWYfqnQHWnpWsNtM+nrIhZxowJVDL+MnEFQFlFXvHAPgOlyFbcbwW+p7W
 Hm5wbYRvBS8giODxY2JdVWqanMxuQMuk+kq/UZ0SeiubmxtgsbbSfnoXQ0ZIeVsty72+jBQt1Z+
 DwEghY+BpEWc1aG7Tovx7xk3XxV++dPOpTypTrVE+gpd16LCWtFDdP7WZqGJTLjew07xAvjtPbF
 gBNMz0Dp/dhqMyfCM1gJRIWkGuXT+o7uO2nxgr4s2iKLamAMS+qsDM9OAQFYngQp4onCFtv0dvY
 Y2mYW0sYOLBUs2xIoeCV2ht7w==
X-Received: by 2002:a05:600c:698c:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48a8447b63amr42992975e9.23.1777545936686; 
 Thu, 30 Apr 2026 03:45:36 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08c77bcc4a3b99186a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:c77b:cc4a:3b99:186a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a7c310048sm38046395e9.22.2026.04.30.03.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:45:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v1 2/3] drm/gma500: Drop unused include of <drm/drm_pciids.h>
Date: Thu, 30 Apr 2026 12:45:14 +0200
Message-ID: <981b4edf04d7fce3bd750f1136ac4ad78628d114.1777545446.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
References: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=714;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=DHa6IP9ZsWhhTvyeZ+oX2+XRXbtm8+xSbwGelhOVE1k=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8zK+jpyOdlgbXA7tt4chSL9tfC/wiyeEEntuh
 8JEa5T0UDiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafMyvgAKCRCPgPtYfRL+
 Ti5BB/4zAIcnwsAqfetAFvosUeTkwXotd2rZM6F5/IkVF/d0EZQGuGSnIYSjfmBeVKGsoJaM3gk
 Tfh1XhTisDjaa2PFo5Kn7nHVFx9odiU3+ioYsNQFGrBEZQ5dxct+ByqdqT2qwqiIXyLInMw2WLh
 85sWz6F2+n73Yeb1yJTcITAKRUKoqywsLLqcn17PAR4ZWe7UcrTFblJr2yrd3zGVoCR5q4mtL88
 fJZL8VkRLaM2iURn1b7ErCu87FGZqPYEDJ/vew3acyKYfTrC9KQJcrKua0Spamo7wloKvE3SGXf
 pAWyO0bAEKoEpK3aFMellFA71bi1ZroSkRAxNY5USe6C/oA/
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
used in the gma500 driver. So drop the useless include statement.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 039da26ef24d..f7ec6c21a9a1 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -24,7 +24,6 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_ioctl.h>
-#include <drm/drm_pciids.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
-- 
2.47.3

