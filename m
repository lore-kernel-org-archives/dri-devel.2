Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA1BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C90110E34D;
	Wed,  1 Jul 2026 11:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDvOYlDx";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA7E10E34D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:12:33 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2c74383c93cso4333455ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782904353; x=1783509153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SWJtxV4Ta72iy42vKEzWLu7hcuhePMIVVuTHVh0+3Bw=;
 b=YDvOYlDxDyUGr+FjoOL28uhknwBJXJsC1uTMIfgMbx1CkTB+9N5OC+AXAwJCcq4WO4
 EAe9hFzWiqoJiXZHfDa22f0EEEgzqa59s2fqLdzEhs++g5AUkbS6pFnmUV17cpVBWTuS
 v27Na50G8Wvg1PtUWEaog7z9Peq2oNPfEx+tMtjszbiBiVO6n+9gBybqdSVxGSP687un
 XFoYyE7u8j+UqzWjFV9GezmncYkCuM40hQdtX0cq46aJ2TuhvlN/+hICA2MJRiVCUIZI
 Izi29epq/OM3NmjtZe85bMQz/1AtAq32X1qUB87RlQEunKBYp66rFj+BVZk0ujtvt95E
 fp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782904353; x=1783509153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWJtxV4Ta72iy42vKEzWLu7hcuhePMIVVuTHVh0+3Bw=;
 b=RAsmvi2Et8ta/4KId9WAnC77to6DVDErNZmncgMJP2TowwXzmL6qUlZoj6p5SAUfON
 1iYwN576dclzvxeCZNQ3Pg2diNpnBLqLc40iAIuyj1FaK7FRNPeHBywy0Ho+bxHKoIMj
 5R3ebWiZEmKnXeMquBEkNPI6tKegpFtVUEHdVUBgbsQw/HMr+GDK+givRr/1J/j9ayL5
 WqY8YQxejzEKie0yxG10u0rE0Qw+233yRXEC2MQ0zz7OnuaVwSVlCryuOiPgJjosaULY
 4hARAz/DYJpj0jGdBEVHJUPeYNfHq6fR5Lkjjo6ciZ9EL6N0QWU9r6KkhysMecOaqbZm
 6zdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RouTvpYebIvXlE6J6KapuNutsy4wLrVlT05RkKPR15V3We+E3cXmtaBVonggaA7v5+dMd+IhB7abVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTT9TO7xwNVZJK6SQl35E8PDSDOohU81OiZpRAoGhFZgmWCOit
 JWBGEAYtRcVvBSU4ivodNr1mO+jhZsegiCcaMv8SQDZ5Qyed0qY1SbQ=
X-Gm-Gg: AfdE7clvPi+MXIqhEs1PELJKLCG+SYveP9xkim+O8pAvc2JLOzsSsN/UtbEzsC6ynmX
 F3QI3456i9fE31QTRBhDC4bzZpyUM23Nrt1Us7/7l3F6u4xkAUT/2OP1BImd9/TE9T/gdwHLGlT
 mJhDDh6pwymKsK8zhItviOLyN6njESh/YyQuL6IT/YtbzAJtpw/ThCyyCJ54WrYNssTpnhFANfB
 AZIfrkxAwycP0b4DCJfxWpfVMxGc1RniX67gdvf5TFOXZeQDMnAuWfjCZvjLjhN2D3S/CYe8EWm
 K9+DL8TSOCctN1x6IJ03QKITwYYF8785V/qLn5cKYOY/PVD4DYYbbCG4zfXF0tFNivgCbpQp8lS
 FjePawu14vvQyylp1eGV97UDc6QGT1VBtm3kmjGjxYzJi2mQWnDnN2KuD9tIzwUZ7BATFcvTFfk
 SoO4FG4+bU0z/ug4xhg+z2u2rE8Lk/zrJEwYnw3j31W16qLprlKOxe3+UZ7zetCchXgnT1DoG1S
 rUlsMk+CBngTtVhWmOirr6llDM5V41SaAmjAd2TpY8GDQdFMA==
X-Received: by 2002:a17:902:d4cd:b0:2c9:bd64:8c81 with SMTP id
 d9443c01a7336-2ca7e6d9f27mr12395735ad.18.1782904352730; 
 Wed, 01 Jul 2026 04:12:32 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37a71053sm30977565ad.8.2026.07.01.04.12.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Jul 2026 04:12:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] fbdev: uvesafb: unregister connector callback on init failure
Date: Wed,  1 Jul 2026 20:12:24 +0900
Message-Id: <20260701111224.48646-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

uvesafb_init() registers the v86d connector callback before registering
the platform driver. If platform_driver_register() fails, the function
returns the error directly and leaves the connector callback registered.

The later platform-device failure path already unregisters the callback.
Add the same cleanup before the final return when platform-driver
registration fails.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 9d82326c744f..ccc9dbc25813 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1907,6 +1907,8 @@ static int uvesafb_init(void)
 			err = 0;
 		}
 	}
+	if (err)
+		cn_del_callback(&uvesafb_cn_id);
 	return err;
 }
 
-- 
2.47.1
