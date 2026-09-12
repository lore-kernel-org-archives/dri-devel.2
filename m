Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C677C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 06:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD5F10E567;
	Sat, 12 Sep 2026 06:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="SS3g8BQi";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQVrHRKb";
	dkim-atps=neutral
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB5A10E5E5
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 06:51:30 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id A17EB1D000AB;
 Sat, 12 Sep 2026 02:51:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 12 Sep 2026 02:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1789195888; x=
 1789282288; bh=+AhFYA6kLyf5iGfmp128Qz+6Bq5cxqtA7vBGMdZdKi0=; b=S
 S3g8BQiNN0rjjrIU54x4c/RdkvrZdaZCBjtn7FuXi9mN55OGrkmIUOG5qU8OQ84k
 aHk/wp03TJRjlkNR0Mz00ndiYrO7qYZ2sZRcKR/CzXt5TV01VNvUwINTmpmIpDJD
 29M/oTOgAdmposqg5pSWivjCI2RLPO3h+Ma9cDnVp+1cDka9v2rz75YQEYh83jzx
 ZXv9Saa04DV0xK0UpCOncPUYmBwcfhN7Ua0Rn4NjBFWroMTxp2VvnN3/ouzeQiv7
 UN0FaAm2vNwn2MX18qLvkSNKnX5ZoPPzdDSXs7p/hQ3a4SfBobR+sOfc4wVeolt3
 B1IGMpweTDzcCxLG7wj+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789195888; x=1789282288; bh=+
 AhFYA6kLyf5iGfmp128Qz+6Bq5cxqtA7vBGMdZdKi0=; b=lQVrHRKbGFVBaB6sw
 QsSyNVsIsYzGxpKguVjNE0nfR0P/82W05fDOhvtaLOwnpwE3TfChYosR6HYsqMA9
 10OvWJRfgDGWsX+21SUQbq+52F/Wt1FcttGZo4FSA1Xy2l3Stv7Pua3MNYNs112I
 +ZtJSOa4NVofltkm1aIgaP6h6mNxJKskgEY7QSbB9eKQHI9hAS873c9BxkoKIikR
 Vo2cK/SHOIa4AgIJZj6ClOrpnBK/neVeYR7dgC2LY9OpgHZaIuTXeKGcdbY0D2Oq
 /sTNKqk2M8KSpqwvAzT8QoPtLe+Dy0/WT3+YGyHsXuejPMNu5w2U23o6penpYTPT
 KZLLA==
X-ME-Sender: <xms:cPakapwSlycizDvcIV4wqdqaAbJAyeBjRWo3FOwXvIsPLq75tIzXIQ>
 <xme:cPakapb04nNp3Lwuc4M2OQBCjJhWnRDIL_o06fMlHW2MLr98GEwd0I_NP5uFFY1ze
 1X1vyifZUWUmcPPp-2krYBTARJ5O7T5TZz-rafT0CrNPlLhL2Rrxv8>
X-ME-Received: <xmr:cPakahJGf8gMdiM2pwIggnCfIZQGSYk1a83ChqZpgtASf79630YFFmAeVIgFvJeeeiOq9AvhIg>
X-ME-Proxy-Cause: dmFkZTEPb8qUI/Bch63DUv9Os4CRaZnJidcR38w4lyHY6iaGmzqubjANrD0SeN/gjpgWtD
 9JpSgLNav7upxo5UY8BD+gTgneuYvtjdT7xUeoI37l3u3ANYgfWTUMIQPTBe+0FGjKZ893
 EmiED4E9ABLDGP636x+3BNPL+06gHQG63VHM2tKDilhH/OyX7+TagruxeFKd93pQCYj32B
 BeiQF2P6k05N47Few9BlXMbV3J128+kb4hnRL4hf+Yoc0wDQXXqOQeonbIg1B1tOCqO85x
 XB7Y9LiCcE2oZkETEXdiacCDRMuKmK7OMtWiJEvsJa8P7QUcJM2B6xHrJPAU/2XBsLk7Rn
 nXZIEnpaOlhztllKAJmqmyh+1BzljzZIYJQP5kN4jjFJ3Wnbb9ZZ9+lsz43QONrs8SEMNK
 dqquehyN6IR5n4z86mAQdmMwp3CrMNrObcmpB6CFpGoQKMrVChoD4wFm11vKu+UF3D+eSq
 BZt1aLtJGUtzGOmm274iehc4Fq2KDfFcOfW53cYwTlzHHbyu88MzWVNr9EL8O9rKD7De8h
 y7aiIQrqqL+9FZd32fImranh3a9ruoVVx5fkLYYuZiSDNlwQ++jk+6PYesvKTQUsfYxODc
 wAFypyEme26SBcNkNMr5/S34wi4eYq1LHbkpMMPymMMur/0hOcyog4gQmjRw
X-ME-Proxy: <xmx:cPakavxAsn_TVz0gHhpTAlkaB5wI1jXBGtbaq40AQkm4PnU8J5BsSA>
 <xmx:cPakapPBsU81CVWk5AP-ajrss0OnH-NlnzsFU7sK0mLqVJerlngzAg>
 <xmx:cPakajtxoz_FH-oXiGYvpOasUVUzYydIvao_TQahHQv6JB-TKRXfXA>
 <xmx:cPakam1eKGAjH1YLDU6X00E1qW8UPjQPaJBP7tzLpkwbQUhWnoUV0A>
 <xmx:cPakarZPri7rsRMxXJXqL975vYhoGpRff0PT_J4lVLlXzms-cofyt6iC>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:51:20 -0400 (EDT)
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
Subject: [PATCH v12 02/14] accel/rocket: take the completion register writes
 under job_lock
Date: Sat, 12 Sep 2026 18:50:41 +1200
Message-ID: <20260912065053.1519165-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
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

rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE from
inside it. The two can therefore race: a completion being handled on one
core can write its zero after a submit on the same core has written its
one, and stop a task that has only just started.

Nothing in tree hits this often, because the interrupt is the only
completion path and it does not overlap its own submit, but the ordering is
wrong on its own terms.

To be exact about what the lock does and does not buy: a mutex gives mutual
exclusion, not ordering, so it does not by itself stop a zero from landing
after a one. What keeps the ordinary path safe is that the handler signals
the job's done fence before the scheduler can issue the next one. The
reason the writes belong inside the guard is that stopping the block and
deciding what to start next have to be one step, which they were not.

Move both writes inside the existing scoped_guard() rather than adding a
second critical section, so stopping the block and deciding what to start
next are one atomic step.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index f40435505..575945015 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -345,10 +345,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
 
-	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * Stopping the block belongs under the lock. hw_submit() writes
+		 * OPERATION_ENABLE too, and outside the lock this zero can land
+		 * after that one and stop a task that has only just started.
+		 */
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
 				rocket_job_hw_submit(core, core->in_flight_job);
@@ -360,6 +365,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void
-- 
2.43.0

