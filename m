Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCA8C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCBB10F443;
	Thu, 24 Sep 2026 10:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="fffb6f3C";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VB8tyHwO";
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FCE10F444
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:22:15 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 06A607A0095;
 Thu, 24 Sep 2026 06:22:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 06:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1790245333; x=
 1790331733; bh=gpp762BvRwhu+TFLXORNswWov10yfkMbGud787FoQf0=; b=f
 ffb6f3C94LwANYV35FZ8qm8D/mav8mbwAJhplM9rabV2JVT91NLT2iNSbMJH78iO
 bBM7lTJjf/9d0v+gq5+RKLmwZa2M972YpNInQz46tBbVDoZgEVFd5cTLqIb+qWwr
 ywtP9q1UkK5hmzyH8VNTLaK2hV7GjTMYd6ccDOW/S9XbhA4lciwF0CQL/GKP+ycM
 eLtrSrEuaDnYImavd0jpESvgFPmurgVmsxINmbsZxq/B1jJ7/ldQUX2WTIRt6x97
 d2ks/W/EtjpsSOfhyThssaK+dYOCdtDON+30q7sgGRhN2GWvlD4W5Iol9lODmfOS
 DYEYBy26YlHMX3JRZx1JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790245333; x=1790331733; bh=g
 pp762BvRwhu+TFLXORNswWov10yfkMbGud787FoQf0=; b=VB8tyHwOe7DrPeyG5
 szZsJw4OIjJDu4FJihWnoY86bPoycfseTd4SW0BeQ0ADUSWZporS3SX/9By7aRvh
 HRX2YjzvZb/FiJBab70qJSMXk7zxkYCUFkOwb0zeUfS581Q49wGjv1C11rcqT+xA
 B4pX8oXj7eicWluj75Er/9/ENf8gYUtS1ttla2REc6nSTEA6l7GWl4aIOjdHLX0n
 UfFSOyLWQ2VJlfchHumuFW1Rcu+PkFs2WRIK8hJSQXf8aOv01L29uSknODSYr3I0
 u6oTzoT+xbWDYE/DqQSXgiFQCXFiZYe8eidP1pA1WII0isMzVmbX/gUZNmlSfnin
 GapQA==
X-ME-Sender: <xms:1fm0anRAqwpjjnrjt2JacYJnC4oEFlSkpQI2ucjXy7_pte3hWh9IfA>
 <xme:1fm0ao6JytdW9884n6Y7FCoO2Wy6cMmd2EgO6gDVWCpLtFnrWHz_sVNNhEvAxg2OM
 vajgG9aN7F2dfvki0PWTHJwaTzyzuNdsAMzaOAAke6pF7iZ_EBNjW4>
X-ME-Received: <xmr:1fm0aqqDkMa0zfS0P6mKjPCmVSdWJuwwD9DT69bHA-hkzzQ_mnirzJHswL-e9Iw-MKa515AVFw>
X-ME-Proxy-Cause: dmFkZTE5U9DWJ/1d8NZBV16bjZrXhnu9+RjSei8Egg+AJBodp1SsqcAZICkdFDYYk8PQ/z
 nbl5nAv32NCM/Rvob60jzzR/sJI+sbtZKf4EXYq6NkDnWs3QsBAvLEkGDZPcVAuKZu09hj
 kufWDx+OHd427BpEwAmDDK2HcwDl5PIVxykoKPNTzoVswPV46/qyR6Xp/JY/TaNWyTgMqq
 yMy5OLUd6yAzE6clJlYL4qCFZSrQCDEMACpcb7vwZPjxoszy3u6FTeAITQlCqDvBOfb2xA
 f1SHw7kF1Gfs8fOU43Noc1IHs7QEkTjIEBtZWO5SBQ25T666ulWx7WKsjltbKYna0Y/oKo
 JPQ8pXQilrwWWeYarZXzxUVNS0M/pRyhhSA/ZhGS/PW7j4SW8pzBCqeBL0BDNss3H9rVlQ
 GmjOBu5qLmik+D6L6Y3ZUH+gjnAUSROvWgx25huEVjbrLy73SjjLubx/JtmdnaUoE3V/ii
 Q/YZaHvfbrS+cHiDux+ECtXWYKn/KzJ/te6vg8bwJy7dlpon6m06lEf1Rk5plm4ejhMOcS
 6/Y4/nuw9byymDIyDoaB3tcooeOgCRXS6J0T2W9bs7Vb48CTCEppJPDrniXI2XeNmeKSgE
 iWAjzW1xknWlW9lGrArSle1RTyotE1AZle7NbEtVheRhRJEHaA6DQrPtLiHQ
X-ME-Proxy: <xmx:1fm0arQKgMJkcp6HFTDRZ7IcAwiaddE1CbFbA29vPpVL4uZalSZqfQ>
 <xmx:1fm0auv0KyoRR_C2jpgPeup2larQ_VJOPHzxBMfhT-Q65SR04krzww>
 <xmx:1fm0arNd7LRAVlzMeAew5BKssaE-xhUmhz3damoFMql9fAWiQpH8zw>
 <xmx:1fm0aoXdSOMPakH9lSS57aGoCIbhCeayfXxbhvl_UY1GmZSCFXf1xg>
 <xmx:1fm0auvm_zZNGUNoXtTlup2OJeTX60ihjJPwb7vufzVNu-C01glj3fKx>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:22:05 -0400 (EDT)
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
Subject: [PATCH v14 02/15] accel/rocket: take the completion register writes
 under job_lock
Date: Thu, 24 Sep 2026 22:21:22 +1200
Message-ID: <20260924102135.92217-3-gahing@gahingwoo.com>
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

rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE under
it, so a completion can write its zero after a submit has written its one
and stop a task that has just started. Move both writes inside the existing
scoped_guard().

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
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

