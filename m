Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C5ACD3424
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 14:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F2810E0D7;
	Sun,  3 May 2026 14:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9GjszKt";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B309610E0D7
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 14:42:59 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2aae146b604so21247385ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777819379; x=1778424179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ou/5On1uyl01c3qIMy6/Dp4LyFT5Z887lgJDzrIZsRA=;
 b=C9GjszKtVM9WyMmGQVqmWWGjG/g13Q81qSqnSU01QZzjNhaFb0a1TmQoEs0Cq8WQVC
 eJ2nKxKsTdx5cjQPMu3r+VH4ikWRt5z2OJJUTAdq64MHH3r3MhdLPkrBuz0M+yKLhL3q
 2W8eySq0lRUxITj5XV9YtEzXGvsSZQ2Y7yZN7P64O+uUPNs2JUMwSOtlFzjv44LjUISo
 lw6YzagSdTRp3KFQej6h8ypq/tSa5d7PMBdQCcdA8geRzauz6H+ZwfIRIkbTRFMvmLg/
 79AJAAucX5hWpQtgqn9HWY/qkYNv1DliXXajLOX1wFWfTcbrtyIeuPQPLoIevADd3hsW
 ACNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777819379; x=1778424179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ou/5On1uyl01c3qIMy6/Dp4LyFT5Z887lgJDzrIZsRA=;
 b=d3DphzKAhJrwze4A/+ZpnGw7Ho9L8SaT2ek/3nzhegClEQbsLiqJzw+ypDLBef1gxq
 mgfihqHrbkCkDOoBkdxOeS3TPsrF7ruYyeEwPNcK6iUXfVNlOft93K9KZM4AO8EwpDMr
 QwRsUMXvlNGJcajDaOQcNs/H7R+ffzlVNRo/kXP+RvpTlcKnfSimnTTkya7qCQ/9Wc7V
 3Mgbkh/t8QNOqBkYKvgCcATcqtt40H8ybAeMVmMrIZxA1JtJfaNbyxfk1bP9YS2OyXMN
 boPEE44JOliHDY8PRB6cQMN9vdLNj7QTREBy3m+Fj99UXXPr1kWCl4pL7dYmjMvGGwLG
 UqPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9meY2fou7sNcezI8l4xEqkalC3qXsjNvuV+KDNihwgZLLA6VS5+BdCUw9BrY3WFHnWmHU+3TlMAYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKMcrHiAtL25nxAgS1BHeFxLf0/xXlwhvXEVvwuaxXJre4TGTw
 /KAg6O5L6OfWnQZTPH/VPmsBVTtNw7TzO1NLdVbdII2x8IKuNzqAfpKa
X-Gm-Gg: AeBDieuUiFXto7CFBPnaq6qKAF+74XhX+qLh6zMGa4fy3cxLZji1ttC/xmGDx5729DY
 FHUOmyyRIawwPAVTGpaIvExxVlwvT1w9KArW7WXpeAZmHS3RhgdFgjbwUjt/UDkAgLltYA0EbOr
 AhZjg5H9htpcbexJNvQUDWacqTlI53wDtmMh6N92oVRIEg5OTVZ3OxfHT3gGK94VfWnbcQHqvZt
 wEjIT/KX+yRb3vzhbVpbms2K+Iwn7hln0nVlMy8e2aESbkjUl7/Kx5Vwdzn91KFfjjunA3rF27s
 vBKK4Qxh6ILg+AnU5p7DWlQ6KW6MPEUdMj66fH8b65CM8LcE6FwqwsCSsJ0Zo40KjFAUlhGvell
 IlWmE9fzaN4Jw5KY1qk57Hg/4285BjZTf75HQXBBMdEVTc4vJ1AKE4DU9b/TNyce+HPgJk91hHq
 YS2NkugEfr8Wl3uMcceYKgt9aozQ==
X-Received: by 2002:a17:903:38c4:b0:2b2:489a:f46a with SMTP id
 d9443c01a7336-2b9f2822798mr65760155ad.36.1777819379098; 
 Sun, 03 May 2026 07:42:59 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caad2bd7sm86415765ad.36.2026.05.03.07.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 07:42:58 -0700 (PDT)
From: gyeyoung <gye976@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, gyeyoung <gye976@gmail.com>
Subject: [PATCH] drm/panthor: Fix missing declaration for
 panthor_transparent_hugepage
Date: Sun,  3 May 2026 23:42:34 +0900
Message-ID: <20260503144234.2150138-1-gye976@gmail.com>
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

sparse reports:
	drivers/gpu/drm/panthor/panthor_drv.c:1805:6: warning: symbol 'panthor_transparent_hugepage' was not declared. Should it be static?

Make it clean.

Signed-off-by: gyeyoung <gye976@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 1 +
 drivers/gpu/drm/panthor/panthor_drv.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 66996c9147c2..e8dc4096c1d2 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -31,6 +31,7 @@
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
+#include "panthor_drv.h"
 #include "panthor_fw.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
diff --git a/drivers/gpu/drm/panthor/panthor_drv.h b/drivers/gpu/drm/panthor/panthor_drv.h
index 1bc7ddbad23e..b81f21ed5398 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.h
+++ b/drivers/gpu/drm/panthor/panthor_drv.h
@@ -4,6 +4,8 @@
 #ifndef __PANTHOR_DRV_H__
 #define __PANTHOR_DRV_H__
 
+#include <linux/types.h>
+
 extern bool panthor_transparent_hugepage;
 
 #endif
-- 
2.43.0
