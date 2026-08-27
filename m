Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF1AC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009A310F194;
	Thu, 27 Aug 2026 20:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NG5zfhq1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE0810E1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1537D41B68;
 Thu, 27 Aug 2026 20:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51401F00A3D;
 Thu, 27 Aug 2026 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862799;
 bh=5CB2dKmCQSY1qUwmTvFZhSCvj33xjn/pkJ3N+pasapc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NG5zfhq1Ui8zNeI5gL/cL0XPa92Qw1KI/XTkJu21PAB4scoAMTTQfSFQyLgYj/tsH
 m92JgKh+VAeNdNgyBfGIjaNcf5Daj4zqJztOPB4hNiGqvmhpoG4/l8nMsL4xtmSU2v
 uxViQJYyo7uotjCM2ovzAhHhLomUldN3EfH/IQMbgaZWwQnNkrMIgOZVUwcA04b9lS
 qX70JxU4ceVtQuDaga1p4SEOYiuT8kaMLEnd6bQ0mwQxHm7TjsQ76pWgvL9JJpuFAQ
 5fSYzG2mlwoq4ZDA6OUHVxzwf/vII2BB1xNl9Sf1coSMkW0UpNHKmXUFW9Etk+V+su
 nzmLcaaprEYhg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:01 -0500
Subject: [PATCH 02/11] accel: ethosu: Drop IRQF_SHARED flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-2-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
In-Reply-To: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
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

The IRQF_SHARED flag doesn't work with runtime-pm as the IRQ handler
could run without resuming the device. This could also be fixed with
runtime-pm calls in the IRQ handler, but there is no known need for a
shared IRQ.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 99c8812691e5..c33f2877b385 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -337,7 +337,7 @@ int ethosu_job_init(struct ethosu_device *edev)
 	ret = devm_request_threaded_irq(dev, edev->irq,
 					ethosu_job_irq_handler,
 					ethosu_job_irq_handler_thread,
-					IRQF_SHARED, KBUILD_MODNAME,
+					0, KBUILD_MODNAME,
 					edev);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");

-- 
2.53.0

