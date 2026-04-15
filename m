Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A7F428C9
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D8010E738;
	Wed, 15 Apr 2026 19:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MaHNnPFc";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F33210E736
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:10:14 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso4322487a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776280213; x=1776885013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LTqrfv4BEcpMmcd4d3ppiH5KBkdSGHZGeXMM12mQixA=;
 b=MaHNnPFcmIR6dgtiGwxekSJwslnwPyq42GUjUviIB3lYf8ybdvfEXSnYfx5hCKunMx
 t79l97mMFVRubvlTRgaaXVizr2rWlqj8ILJiNsEMgRfy6cxTUYc/VWi8yFfeDzYRVOW/
 TDHz8nfi68gfxmh+8J2tHxj5mzkY0ApN+xqYZIuk6GXGXfr0eVXscD/8ts3kJRbo226d
 F6T1nsG/1NhEJ1j+/lOIDVbXZvOUFLtvzTJqAnFg6SRJVG0XFbGWlHSP8uEhwWBhxf40
 Vp8nmQKZBPWtcBKiNDv4EPyg/dSHwvUAON9nrP58vk5jmaoYZF7UyPeAdXuZvJ7aZTwB
 G6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776280213; x=1776885013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTqrfv4BEcpMmcd4d3ppiH5KBkdSGHZGeXMM12mQixA=;
 b=QVDJYKB8lWJYfhq2P+UW9zrNdsl+Aobq5i1xABihZdx1B8djUrw7HziL2z1/5MVXGx
 atWz78fOfV3Y4fkzfxRV65e8XM//IsPFEwHityJGcL4f4OPKq2L1oomZND/T+k5R/v+k
 mQIqgjZVShz0jFj1sf9NMHlORsmDOP3D+5xD4nwu7EYcGasL0rfP0NH+Lc/GR+YMgnAK
 T6SPK6Jl8MQjCGJQxCzEX9kak2AmJB4qPXkU+ESfHU3DiCvgGakq29JL5+FNXKpcww8q
 qB87IDsi69KXNUqEXK3tXi3I+pb1eKqn5n/bDAZ/6X089Io6P9mRCpPSxHkTD/PyUOfw
 yD9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sFyzIdokhKu84HRieryH4JQ0TJSsPljc12dpzOWot/0u0hXlnn4GjiWxJQevnlsyElitDYgfbmgU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvJ+ydVa98fLmsImLyB1EexFXmCAVarkibm4I5RAWG5EBLTWRa
 6T1KxoNHpWTund4gzeuuJwoc38RoZuqDp6sZPCLSHDlwCmi1+ZWWTbdt
X-Gm-Gg: AeBDieuUPff3aIqk/Kl3u/4A9vCDjBpsyu9yl3cqATIBvS3Y3ViuZv9n+sdzm2nUcBl
 7rRjPHzhq1jqXWAp4/mTOj0BLqUyMHROI1Dw5328vbctNN7svr7L4zNor9E/nczELod3G+B4Gif
 LtU4SsmqV59SGLCJ9Q031P/VeR9ORVkn8QpXtJmxohq66ATX1zaL8o0hXJjF9LXLOxqi0PVRdk5
 sCdZUOU2yn1axgFMQWPU8tS/DjbLu/+3rKayG+T+ns1dKJnIGNwqcmXWJtPXOdpzjEm1Ig9UL9k
 t+wA0ndHI0uPHaAgQuaMKwxq0+Fx2A6/7XMfYWeKFZdmcgzbpjfAKlpsJVWRPbTa4MBY+oRMSgJ
 xX9oqKiWwmLtasauDNkiK1lXKdnsU8yKadtxl91Mr+VhN6t0d8xSD+b6TLZlRH92v6sWQAcfYPC
 wzK7HBE6M+e+tgP7ulDob3LX8KbefWaguVmiEIpLL/jAfH/w==
X-Received: by 2002:a17:90b:350b:b0:35d:a2d3:5c44 with SMTP id
 98e67ed59e1d1-35e428581f9mr22426248a91.28.1776280213582; 
 Wed, 15 Apr 2026 12:10:13 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fd3074758sm2759890a91.1.2026.04.15.12.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:10:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>,
 Andriy Skulysh <askulysh@gmail.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: hitfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:10:03 +0800
Message-ID: <20260415191003.3829558-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When platform_device_register() fails in hitfb_init(), the embedded
struct device in hitfb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  hitfb_init()
    -> platform_device_register(&hitfb_device)
       -> device_initialize(&hitfb_device.dev)
       -> setup_pdev_dma_masks(&hitfb_device)
       -> platform_device_add(&hitfb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 048839dc548a5 ("video: hitfb suspend/resume and updates.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/hitfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index 97db325df2b4..29708c2d506d 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -495,8 +495,10 @@ static int __init hitfb_init(void)
 	ret = platform_driver_register(&hitfb_driver);
 	if (!ret) {
 		ret = platform_device_register(&hitfb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&hitfb_device);
 			platform_driver_unregister(&hitfb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0

