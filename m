Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D19C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D6710E5C8;
	Wed,  8 Jul 2026 09:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HlcTHUEs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41FD10E5C8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 09:56:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56213601EC;
 Wed,  8 Jul 2026 09:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3B91F00A3A;
 Wed,  8 Jul 2026 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783504614;
 bh=OSrEVIc8I4v07uohcflk865RNS4QPYoK87cBft0LbSM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HlcTHUEsJFmDC0ZybPXosmPoLjcHJc1ZrYdI5BbtiFZFWW+fjLQB85cQhMZj6bxxP
 7X92SlATxbpmo1NZCeZFgOch6oJz4E5ZiAppcOotnPwePTsYIFx1jci6fNTpKcDq0x
 dTuMYaDswy5tyZzi6atIUSb7oHn2//ape9Tyayu+XhAhTOnsVFyviK8eaM/ypgiXO4
 jzN5i4FW6QYjLc6/THZTj3BDKmG/cFLrbtVlFJAsH/9ukbaKXUzeqgqLmmzqXxm8P1
 zv4gjQn0mIYDv5VZ5bNwmemtdOd2POWex0OffYJRTGGI9eJcGvD2ipxYfPBRDiaeDG
 q3oiZA9dNNO7A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: victor.liu@nxp.com
Cc: linux-kernel@vger.kernel.org, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] drm/imx: include dc-drv.h to avoid sparse warning
Date: Wed,  8 Jul 2026 11:56:45 +0200
Message-ID: <20260708095645.385291-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708095645.385291-1-jirislaby@kernel.org>
References: <20260708095645.385291-1-jirislaby@kernel.org>
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

sparse (build with C=1) warns:
drivers/gpu/drm/imx/dc/dc-ic.c:273:24: warning: symbol 'dc_ic_driver' was not declared. Should it be static?

And it is right. Include dc-drv.h which declares the struct. This
ensures the types of both match.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>
---
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/imx/dc/dc-ic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-ic.c b/drivers/gpu/drm/imx/dc/dc-ic.c
index d8aa46ee6a7a..0f2fc7aecf31 100644
--- a/drivers/gpu/drm/imx/dc/dc-ic.c
+++ b/drivers/gpu/drm/imx/dc/dc-ic.c
@@ -14,6 +14,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
+#include "dc-drv.h"
+
 #define USERINTERRUPTMASK(n)	(0x8 + 4 * (n))
 #define INTERRUPTENABLE(n)	(0x10 + 4 * (n))
 #define INTERRUPTPRESET(n)	(0x18 + 4 * (n))
-- 
2.55.0

