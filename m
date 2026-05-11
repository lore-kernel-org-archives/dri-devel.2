Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A92CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 08:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C365B10E509;
	Mon, 11 May 2026 08:51:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC21910E509
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:51:49 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1wMMMe-0001RF-Dn; Mon, 11 May 2026 10:51:48 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <l.stach@pengutronix.de>) id 1wMMMd-000DyV-1a;
 Mon, 11 May 2026 10:51:48 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: etnaviv@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 2/2] drm/etnaviv: check MMUv2 status after reset
Date: Mon, 11 May 2026 10:51:48 +0200
Message-ID: <20260511085148.652256-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511085148.652256-1-l.stach@pengutronix.de>
References: <20260511085148.652256-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

A fully GPU reset is the only way to disable the MMUv2 and the
driver depends on the MMU being disabled after a reset to be able
to properly restart the GPU. Validate this assumption by checking
that the reset actually did disable the MMU.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 34fff36af450..577fc8131976 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -601,6 +601,23 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
 			continue;
 		}
 
+		/* try resetting again if MMUv2 is not disabled */
+		if (gpu->identity.minor_features1 & chipMinorFeatures1_MMU_VERSION) {
+			if (gpu->sec_mode == ETNA_SEC_KERNEL) {
+				if (gpu_read(gpu, VIVS_MMUv2_SEC_CONTROL) &
+				    VIVS_MMUv2_SEC_CONTROL_ENABLE) {
+					dev_dbg(gpu->dev, "MMU is not disabled\n");
+					continue;
+				}
+			} else {
+				if (gpu_read(gpu, VIVS_MMUv2_CONTROL) &
+				    VIVS_MMUv2_CONTROL_ENABLE) {
+					dev_dbg(gpu->dev, "MMU is not disabled\n");
+					continue;
+				}
+			}
+		}
+
 		/* enable debug register access */
 		control &= ~VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS;
 		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, control);
-- 
2.47.3

