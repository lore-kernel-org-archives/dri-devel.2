Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF75606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkme2BFu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556C91122AA;
	Thu, 29 Oct 2026 13:36:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2610411229D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09127437E8;
 Thu, 29 Oct 2026 13:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9CF1F01828;
 Thu, 29 Oct 2026 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280976;
 bh=bS0iSQJp3OkLpA0zXSDW5fylr9WknYcp8VwPrIX4pYg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lkme2BFuNhl2thv5wsWX5SRz6Lb06ZGBZu24M3tCwnOQjIJrLlvPR7RxJt26HKNUH
 ymC3dBitBj3U8WL8T9xhCuB4wnksPDIxrJ5IVMgQiWlo/tjx+TR/j2vQZhX6vaHkJC
 pNsu+KjlWOytlmng2Vx0OQZO8/RKmdO10jwiX4bt7s1yg66GRS7hjBeNuB2QA4+op8
 Wp2LEEDEwh3S46Qb56x3NE8SXDIPB2rD51VMOIY2dMnpLuZw8HFac4GZQLM5MsSgtE
 TxQ2R+NPbnLAzt5cjFvQ4lIoCHvcL9LN+6X3UYNLVhVRLeY3LyxlvLKyJdSvE2d7XA
 m0EGEssgESdkw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:49 -0500
Subject: [PATCH v4 02/31] accel: ethosu: Ensure suspended on removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-2-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If device removal occurs before an auto-suspend timeout occurs, the
suspend is cancelled and the device will be left with clocks running.
Make the remove() callback check this and force a suspend if the device
is currently active.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Reported-by: sashiko-bot@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Use pm_runtime_barrier() and call ethosu_device_suspend() directly.
   This works in the case of !CONFIG_PM or power/control=on whereas
   pm_runtime_get_if_active() did not.

v3:
 - New patch
---
 drivers/accel/ethosu/ethosu_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 38af57807cee..ae7ebf29cb2f 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -387,6 +387,11 @@ static void ethosu_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&ethosudev->base);
 	ethosu_job_fini(ethosudev);
+
+	pm_runtime_barrier(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		ethosu_device_suspend(&pdev->dev);
+
 	if (ethosudev->sram)
 		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
 			      ethosudev->npu_info.sram_size);

-- 
2.53.0

