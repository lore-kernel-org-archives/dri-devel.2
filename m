Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE252606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=DPp6/sWp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mYSNldut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7BF10E778;
	Sun,  8 Nov 2026 07:06:46 +0000 (UTC)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6F110E776
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:06:30 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 428C07A00FF
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 02:00:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 08 Nov 2026 02:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794121255; x=
 1794207655; bh=qCmx6DpnIrwTlTWDw4oEodoP0i+gU4Ja/jIjM7NRimI=; b=D
 Pp6/sWphpY/crljA3CuZR9fExWocMAM3i4BCC9f7aECItz0A4jefcdUIMIWL6QO/
 9onbhUQGpKmwOYA21hr6zCHqHe7/GJkPFqKSUSoAHuNwquMBWKLT/dekAnveZnp/
 lah0DtRtoC+811lz2RnE/eN5Jd3Jx+D76eHQBhuTZCSt7VpUS+YaoIrAWFMsOxdN
 CXaoxUrkgafDtMXijoI5hSJIFPUITcvX2+iA3bYKOMYGltcZqZy6K3iAviETUCEN
 RZWuRws7gWC52Z/eTBWjSEK38CKSimYlAEUvEenByH8Rh3CuDfiUhUmKnhS86g1I
 xSIXbu5+ocdqJcl1GZFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794121255; x=1794207655; bh=q
 Cmx6DpnIrwTlTWDw4oEodoP0i+gU4Ja/jIjM7NRimI=; b=mYSNldutDrm0MG/h/
 +Mr6ezLeeCBnq7S0rc0Plf+eiKFotqm4Oc22/79wQTX4ChTvXNpCV/ip7bewLFhy
 k8+ZrhlsvJw5IKMZo3hJNdYcGtI2VH8aIvotfL3PUUg2COqXQSy+HRgtOdBCZ+gx
 qenI8v08Tq2DJkL4Q6K1oR3g9UcR213mhB/cw5iUoucqpz/wopi+B7YE1n7ju5Bs
 riYahlhqIrd62TBLdNwI/ZHtP4agXyTUeq8rWaBGEZOA3UIwYwHTz6/K5c3qwEZ5
 DPOUqCBUB9GuNjwUKoMQKTdaXiBo3jV8atshb1Dnpb0eCsHSSgxoiDxhxvu7f3U1
 tZuJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121255; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:CfAX7j84deiuMwZS7J72gfDt9I/ixRombbnVLiqYr8LspCk
 qZW6l1VVE0zW3Z+VzWZvMOdPcASkPEMH1UFAjM2Iouf7jJTchXKQcB8Jd8oQeG2i
 jB8BQ/SlZ67eS+O+NPhgckj+7WiMJdzH8Pd4zJSZjp5U/UfyIi9jJ3MDDnE3vCNi
 rUZoDsoo7hodWp04N7q0734nen3CSNMDpsoJZ53rDt0aVb50Vi+5VEVeuqfJhUGw
 l+vwC6GrxHfJ4bjfQ+Pgt8Ra0dTxQa25nHaI6kUpS6RPyGCKxLWl9GI2ckupWtSO
 yUDkaSEVmhOWPim34OPdY0R0daYWRVkPTWC7H/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:mD+YezxNul0uW96XjIapcxbq7AFt6rwK50+Ib7PpJsM=:DlVKbproDw44VuK3FXRaoSxqI9g6sF0q1Q+SGJiiono=;
X-ME-Sender: <xms:Jh7wansapv0-e4bMLHvr0jylxmpkEJzKZjZNU_oDj-biO76uJYq4AQ>
 <xme:Jh7wakkTxlk4rJMImOugPpa-lEKAqJ6JNUHsOCMVAtSFgsFKhKvWp_lIYizWtg94C
 fA3l2HtNbHowZbkAwL9sQtert_h2xwPMYcKlSpSYXPo9YcrQmmdD6F1>
X-ME-Received: <xmr:Jh7wakDoSgEtxYEtL9PvAoefULDOn10-gmZpgrtCj9XbdLxZJNNl2H0AT4grgAjDMckATXqX>
X-ME-Proxy-Cause: dmFkZTFKhclCCJN9i5LFQp5fvn9DylL5PDR95+qcmUDEkBDvAaUlhVhO6JW1PTcA0oiilr
 afxU+kS37MwfkRVrV2sLhNS1OkBSH9hrpfUYkvEeAEfTx8oUhC1lvQdEqsrvfO12L2kPDm
 Y90xvEv61R5vWsABT3XVmqKcWsSTBPoQRHs33ySAWpN7mh8mIX7nfmpu6Q5St0DdZLVl6o
 GJpMHUC7TjUVqLMHfqfKk9SHn10f5lL6CdG6YeehrsosttZtbM1aNiFk46XYC+svmJcMBn
 4w1I3sJZaXrv8SSndHCWUOH7cbPZHBY65Sr1oZjnZZRxSV2wTTFO+3xU/Lmvhk4YCMlhJn
 An92hf5ayiDz+JlUMx2f9ip6BPNZSyXqeXxkmvmU2+bQCo+6Ag/d4J/t+61YixRab1Msqm
 itojlPIWBp2werHJglOT5dTuhiS/TbONUWnYE1ymbnAb5T1c+G+UozmRi5FoQqyiLD5T4j
 dlsU0vGXJWFGiijgCcUtqvb8qh9HwCtr6jkXyR4Q6DIAYohu/AdBwoHhXdwaGnLxRUDVho
 2VCSN767LQnBQCKCmSgMzo6uQOBati/L8USUdRk1zsgA9zDobnCjvLdcMSRJaqRGt6TkEz
 dfO6e//4ABIWBCaozAk6nDHnUCojDu7A+bZDNYdGbgLU/XmnoT7Yp0ASlv2Q
X-ME-Proxy: <xmx:Jh7walTIccjng5cx9DN9G4zk5QL5sm8fApOITmG0kb6VksoMnujtcw>
 <xmx:Jh7wasK6XW7NFbx3EfQ_RXy7o7ZY1aU-dR0EIadZ7s-bN2d9KlYbCQ>
 <xmx:Jh7wam3FbG9Y_XBgK53zEGoO4RHf4Ltgod0stcqlMOclcAWIJLNjpw>
 <xmx:Jh7waguA9lI57fMbP8qlASKNhMy4VYRNjWlnHiD-mosoxxra0TNlmA>
 <xmx:Jx7wakW8cb9ZncY6CxXvwbkTgfIKCzJfhnrsXLvQ1oU0a_c__odKaORI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:00:45 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 05/16] accel/rocket: factor the completion tail out of the
 IRQ handler
Date: Sun,  8 Nov 2026 19:59:06 +1300
Message-ID: <20261108065917.135194-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the part of the IRQ handler that starts the next task or finishes
the current job into rocket_job_next_locked(). This makes the code easier
to follow and does not change behaviour.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 4a577b642849..ea23a44b1d9e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -365,6 +365,24 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
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
@@ -378,17 +396,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
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

