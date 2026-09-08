Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8409C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C8610EDB0;
	Tue,  8 Sep 2026 22:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OakRzItU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5290E10EDA0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:04:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C29C360213;
 Tue,  8 Sep 2026 22:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F6A1F00A3A;
 Tue,  8 Sep 2026 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905094;
 bh=B++ChOOJS0KMKO8mbkmrvvELnBJLVRMq96OfPvDS7js=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OakRzItUAnfI0vHAjR7TSUDbPjtXFsvWGVvzZirbPOPe1PzIwuzQPsKI3ubMlmxvK
 P6JarMzvZfttSVZadEPJAlKfspsLD0YuDqJbMKuTIVqGur0uETM3VTRh4jnPQDSVB5
 KCik+MQNzuAvyxpBmQ6a1PIJxUdPZwlhoHbGjJchNEuaZ3utluA15HGHOw0a+vu/n+
 eeEx5az6JEMQCy5Y7Tw/hrd1UaibxAsZkCc5/DO4DOxLK9IEGYq6/ieCEASfl8u70U
 sDrccrRqfX1+nXnn0DzeaYV270Lh9lPzcAREPnqn9aR28tTwRdSYgG5RDITEajYLsm
 WnIj5uYZq6EQA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:39 -0500
Subject: [PATCH v3 02/22] accel: ethosu: Ensure suspended on removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-2-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 sashiko-bot@kernel.org
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

If device removal occurs before an auto-suspend timeout occurs, the
suspend is cancelled and the device will be left with clocks running.
Make the remove() callback check this and force a suspend if the device
is currently active.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - New patch
---
 drivers/accel/ethosu/ethosu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index df76253d01a6..1f6fb5d18cf2 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -387,6 +387,10 @@ static void ethosu_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&ethosudev->base);
 	ethosu_job_fini(ethosudev);
+
+	if (pm_runtime_get_if_active(&pdev->dev))
+		pm_runtime_put_sync_suspend(&pdev->dev);
+
 	if (ethosudev->sram)
 		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
 			      ethosudev->npu_info.sram_size);

-- 
2.53.0

