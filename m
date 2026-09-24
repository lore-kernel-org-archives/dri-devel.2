Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB527C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAEB10F447;
	Thu, 24 Sep 2026 10:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="DFob7wr2";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSA0dv/X";
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816F710F447
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:22:52 +0000 (UTC)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5E2DE7A00C1;
 Thu, 24 Sep 2026 06:22:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 06:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1790245371; x=
 1790331771; bh=Qr2SDQcrtk7M+1yXPOHybBbMUqlF7aNhcGwukiSZJB4=; b=D
 Fob7wr2prE59L3H534/Ssq0apu/6KoC6hzn67MeO7YGvtqBOlM+7twXT26SeUh1M
 d43/v1Ihe84FfiSN90I6bWY6XHEODaGgmy+7Pc/PsL4eA6dARSWoqgUsHi+E6EwP
 sB822DhvMx7k3j93LfiumTZ8MIPRoZZSYxC7fHKz13VQVD/oQOo89wuO4osJoDDN
 dYI30glaCjaf+9MNswTZxgJbY28QmPr8IUXGroR8mE50gKGjFROl6jmSQPJf/UGD
 gM0zjkESOWEAg2X3fStj6aFhI8H9//+9LFXJEHPWHP84o2BpuiLqH4S/Y27C9q9D
 jR9OowrdRq4TayGlHbTsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790245371; x=1790331771; bh=Q
 r2SDQcrtk7M+1yXPOHybBbMUqlF7aNhcGwukiSZJB4=; b=kSA0dv/Xtfo26k53h
 yfv64wLL7Pgp+qCLl8MVCqXJ6mWkmozjXTjsOddkAqUjmQFzBdXC3e8bn9r4xGLu
 Cdjm9X8PlRxNZoJwgjbI9W3AXkNNI/NcdA+npklJzZJXn4JH6zCpZxvpDrFIyyvp
 RpolUBJ370b+dWuyTT9U1qyS5f+DaNZzaaO7ns2d+BEYdF/oMtR6tFLI5vtYYepz
 M/oUJH7M0xZKeJdLoy4JgwvJ3sRK/m/ie07R9w2dg2KzS90zZ6R6Ydni2V1NZIqd
 SudPJL6L2Up6IdVoAgdizVeUPo3apK/9DqHn2Yp+R9Qh74NZEefLKh8RRsRJ52mK
 wGIIg==
X-ME-Sender: <xms:-vm0an0wdKidsk9IfrhlVlqw49qWChavoQSymmRGXDfClexhmFH-gg>
 <xme:-vm0amPTTKTnrIGLMwNkISz-0f3c_765OAOp8e-YUlYFKwJThHGBb1Ce8WsdogtIJ
 _nXtzkSyzOufmVE36tCjNt74KzW0RONwymlxbm5GnYXLcMWEs5DNWdC>
X-ME-Received: <xmr:-vm0altRu64u1HCn-Q8ziqrpyffMihFp71DL410zGNAWn7icmGkyMf7-z-0jd_697xcawDPabg>
X-ME-Proxy-Cause: dmFkZTE5U9DWJ/1d8NZBV16bjZrXhnu9+RjSei8Egg+AJBodp1SsqcAZICkdFDYYk8PQ/z
 nbl5nAv32NCM/Rvob60jzzR/sJI+sbtZKf4EXYq6NkDnWs3QsBAvLEkGDZPcVAuKZu09hj
 kufWDx+OHd427BpEwAmDDK2HcwDl5PIVxykoKPNTzoVswPV46/qyR6Xp/JY/TaNWyTgMqq
 yMy5OLUd6yAzE6clJlYL4qCFZSrQCDEMACpcb7vwZPjxoszy3u6FTeAITQlCqDvBOfb2xA
 f1SHw7kF1Gfs8fOU43Noc1IHs7QEkTjIEBtZWO5SBQ25T666ulWx7WKsjltbKYna0Y/oJ0
 JSSDKr36O7FaVyfUIYvVM7A3TeyFkfs56ja5J+58OozydCLxBsTb8TMz2DFELcwr3cMABj
 DErrE/q7bmr5y4j9Hj6Emk+Cw1Kr13kHL6qaNRkrjD4stB2N8cWlsPO38veNVk/twjNbpc
 1PuTARjfEyUTO6d7wvuMOebDiMB1cEz7zmY6VgNTtV75I74WWNXVnLYP8iGzJsh9vknaGW
 istTcMwEfc42yrh/w3UUQ/szk3GQfKxeqz32wSIicrmb9NLNvBeE8/u4h6FdQ8Z4n2t12t
 ZnTTNsWON/ck8Vex+HAV7f9K6DqmMnSVFSw/mQPqq3zIdM9htwAA3oHIT1QA
X-ME-Proxy: <xmx:-vm0ahGlsi67Ztebtt1d5CR0_L8nbrLiKR1GG9pvpRF2IJ4XWNkyMw>
 <xmx:-vm0aoQ8I6Yr4v3aKma3xZtnlh-pRL7QRmKJNrZWEGJN1WNcBBvk0g>
 <xmx:-vm0athPlVYa3SqPs4Qz7ApRDoXMav4PRBxVRUTsgb9lZAUsfobyQg>
 <xmx:-vm0akY14dFPVNglV7Rf6RZtpZEDvQq8B1onZO6yx3e9LdLKjqds-A>
 <xmx:-_m0anxwxzOwLsYxVH3s3Md0ed0C6H7YaL9k8kWsrW6Ino-WVq7TvPL8>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:22:42 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v14 05/15] accel/rocket: factor the completion tail out of the
 IRQ handler
Date: Thu, 24 Sep 2026 22:21:25 +1200
Message-ID: <20260924102135.92217-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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

Move the part of rocket_job_handle_irq() that starts the next task or
retires the job into rocket_job_next_locked(). No functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 996890025..e6e41d517 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+/* Start the job's next task, or retire it. Caller holds job_lock. */
+static void rocket_job_next_locked(struct rocket_core *core)
+{
+	lockdep_assert_held(&core->job_lock);
+
+	if (!core->in_flight_job)
+		return;
+
+	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
+		rocket_job_hw_submit(core, core->in_flight_job);
+		return;
+	}
+
+	iommu_detach_group(NULL, iommu_group_get(core->dev));
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
-- 
2.43.0

