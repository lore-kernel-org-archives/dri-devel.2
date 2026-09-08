Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D215C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B8810E492;
	Tue,  8 Sep 2026 22:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9Sbuyd5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A7D10E492
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:04:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E118601FF;
 Tue,  8 Sep 2026 22:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C351F00A3D;
 Tue,  8 Sep 2026 22:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905093;
 bh=ai8d/z/jR8St5LaF9248MzOc4BaNMXKIfXmoxvaaQR8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Z9Sbuyd5soYPLUogOkXYWQxJ5DOum41oY9eGKtVprQupwojEkYtALmxRNx0Qi/U4g
 6KgVZcsXAyM8EPITlGzTag0rMP+7QcI9J9Ox/0bgbpk+UH4fUjnTmTrmk28nfbnPf4
 d9ui/wsKi9EMVvUq/CnFSgNqAehDCgXVlmUrUSwJMF1oB3oEtNT4aRgptqy5Xmp5J4
 87NAxj5yh4nAhU6bwHFxU0YSIZY3294nBlLtJDwKMvL76SyPgg1TgB0Q8ZL1N5zkDy
 F3w47xTgIMxM5YA1X+MAMpcUV2aZoTgKkR42c//kqdFt1GlIm0X6pCv+BzO8uYGh14
 F22Rqa6O8PFgQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:38 -0500
Subject: [PATCH v3 01/22] accel: ethosu: Suspend after initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-1-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

The initial runtime-PM reference is held only while initializing the
NPU. Release it synchronously from ethosu_init() after the final
hardware access, before registering the DRM device.

This keeps the runtime-PM setup and initial reference handling together
and leaves the autosuspend configuration in place for subsequent jobs.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 8108622de258..df76253d01a6 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -338,6 +338,8 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 		 ethosudev->npu_info.sram_size / 1024,
 		 ethosudev->npu_info.pmu_counters);
 
+	pm_runtime_put_sync_suspend(ethosudev->base.dev);
+
 	return 0;
 }
 
@@ -376,10 +378,6 @@ static int ethosu_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
-	if (ret)
-		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
-
-	pm_runtime_put_autosuspend(ethosudev->base.dev);
 	return ret;
 }
 

-- 
2.53.0

