Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E256C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4AA10E737;
	Mon, 17 Aug 2026 11:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="qLdjusiZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUqVuKGt";
	dkim-atps=neutral
Received: from flow-a6-smtp.messagingengine.com
 (flow-a6-smtp.messagingengine.com [103.168.172.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4F210E737
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:36:49 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailflow.phl.internal (Postfix) with ESMTP id 478691380159;
 Mon, 17 Aug 2026 07:36:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 17 Aug 2026 07:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786966609; x=
 1786970209; bh=iCp4oScVjuhbCppokXSayid8kHmUfEtSxjX6qVMQ/g0=; b=q
 LdjusiZBO7NzsA/2DC1yoid/sHXpMsLxfz/O8yngg1ilFjxdsBjvEnD/ieh3/Gss
 nZOnIm95ovcMaqWkohuAL5BhK3fm4pYTrXlw/N98AaqKhMltPaLPUipPVcozPope
 3UW+E+7tkEC4Katq7M0DF4EhAOmERZj68pK+tHiGLNyyZ3XLWwVJRkPDLX50wpVe
 z7ZUPSeeUJOrcv9wAkK4QaX3EcsNtha7K7hsqRCWsth6XE4p8FdXlqtisJkOjFep
 X6mYgXFnYnUqskqL2W1h8w2CJNX5FImNCF/+2uza2ePgtQ/JRB/pHwbOYAtBvPSX
 il6NixzL7mR4shsDoyoKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786966609; x=1786970209; bh=i
 Cp4oScVjuhbCppokXSayid8kHmUfEtSxjX6qVMQ/g0=; b=HUqVuKGtlIsHsUEfR
 Uu8FkVAFt9H3gw8lC0hgXINQVsJJtCvzPM4r2xfft6MhsbPnN5VHM+EkO3ALd2st
 oWZL5bssdstFfzgNgeWJGfci2ly1owOF2f8W5CoWNwytzhVysxTK0Q0VS6HadI6B
 OzOnu/P8qyfWiPokjbr9FjLe4tOPt0SpMGDm8ndkglyjbl6R5+aPqC8bHEsaTTyM
 l1e+NvvBtCn8C/rzh+y5VDy3llQrA7iNFXNxgVTRhiPin1pk7IdGjonzpgzA5FjK
 lFIkQLNeqzqXkhXXRSEWndIJhJz3GyD46/69NUhbAR1KwGySERjSUOGZWZfl2aLF
 aHSew==
X-ME-Sender: <xms:UPKCauEzkuBAspjhOzVT7ZZ32yiypmSPiesPpua4DOioLp8jw4mgmQ>
 <xme:UPKCardr6kIE6dyrp6qACjmvTsqx_eM5ODF7_iUkdi2pmDyHZmcFWwFsdzk7fhqUN
 l2SEOXeL5lmSoNupy385W_NFN2G9REIznCceqxoU6kjitDGI4Xr-EQ>
X-ME-Received: <xmr:UPKCaj-TlEFLF1qZl1Cj1FM0VpISNkmBo7SmDNMi7CiGsIM8iuKiwKG7YrYkKpOyzpf2YSu_Fw>
X-ME-Proxy-Cause: dmFkZTFJpbjkSDT6AcryrIHhgbEVj8SvkD3tgmT76I8WU6lQDo3YUCdtzXxAeg/zKqpB+E
 Srz/I8ZJc3N7HCrgkTkwyaBZdvHNOdURxqLv8+rxKpfV73gGv9LWiSebktKgvlTsmvhDvl
 7z8e7P5tVZXD1XfHmjG3x7RlOqfrClYofT98201dsDsGzeGalaNI/cy87SBMyHKVxLpD1H
 cf8c4VtlmLV27PNqhGPBVow9iGRSY0ganIZ7M7ursi5UKI38krV8lOdP4K1YQOgw9wIEpu
 SQtDihQpP3WqB+Si6LCioT5pFEw0karkUBJswAF2S4IqKtJUmYgRgB9BVHgg2tCz+ac+he
 3kkqG427iO+vmCknQQkHrxtfrT7iOkUn06Q/vsVWn866AKQ66H0yjF/LqvVC3kX9FFE8mZ
 heb2b4reVuapWmFMiEUWSAFsOhe1N/+LsEp78zbchgGjjpgfZzDSjbOZnP0d2nq4leHUQN
 56rDqAff9ohEoMdAxqJtdej1ICv/wO4NukBJyXpaid5f8kIlU2WXaz+kutXgBNlH8eDRIf
 tWl3JxP/DKBxgR54r1U8cQLq7SB6UcG0izK/Yb5AJU3i2ywd8sFC5T3pAem0cAoIv6CcjR
 p1QegLdIdZN9GZQygteLojc9yMIgsHSIPNmzC0gNl9w3jiWwWLGNfkIp+8Tg
X-ME-Proxy: <xmx:UPKCahbn_VtJDI_87RDTnOynOm4CVH_oEsJHF_cR3XZ_FHBpKEXPww>
 <xmx:UPKCakfZ_2H5uAKKXO9DJsymvcYMHBV2a0YRiwlZAundjyc_1hV8WA>
 <xmx:UPKCavRCCNAqKBzHL8vMK-yKHSMltMvTKxP9klV7ejy4UCfv0Dercg>
 <xmx:UPKCaukWCFU2WPK8qUP-FAMGBPFw2XZokSmiLdtx6TiSirsqRihheg>
 <xmx:UfKCaqNm0gsmzOgI0w5ttXqUGZCXO5AvLk2PhOmh806r17tthVNLg8ge>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:36:41 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v8 03/12] accel/rocket: factor the completion tail out of the
 IRQ handler
Date: Mon, 17 Aug 2026 23:35:54 +1200
Message-ID: <20260817113603.1436067-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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

rocket_job_handle_irq() stops the block and then either starts the job's
next task or retires the job. The second half is a step of its own and
reads better with a name, now that taking the register writes under
job_lock has moved it a level deeper inside the scoped guard.

Move it to rocket_job_next_locked(). The early return that used to leave
the handler now leaves the helper, which is the same thing here: the
scoped guard drops job_lock either way and nothing follows it.

Doing it as its own patch keeps the locking fix at the head of the
series minimal, so a bisect that stops before this one gets that fix and
nothing else. There is one caller, and no functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index d484a3a6f..0bb11c718 100644
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

