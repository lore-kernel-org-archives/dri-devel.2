Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E375606A884
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=MpFmoVkf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GSo5tdob
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD3D10E108;
	Sat, 14 Nov 2026 03:06:48 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0845B10ED1A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:06:37 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id 67B341381A45
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:06:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 22:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625596; x=
 1794632796; bh=+LBt2CZx+pYCe+VktFRZGdw09u24nWiEXEs5S39YV9s=; b=M
 pFmoVkfQu1JGVJTCNhtQqMEwr2liWyEIZoHL5yvbYPPxZwP/v1UovQu/4YzjOb6A
 +qGTcdvwLoaBGX6TY8c3q+4GDjjMLb+ORp2e6N7GFueze+e+w1LEZIb9W4MaqBdZ
 tluvPe9HwMTUClSp8L39OJrkuxSkjVlIuX5ArszZsk7Bgap3o/nb/dFQ30WOCPBy
 2lCyIoU/o9f9KHlaiySJAvIOLlNzr88MHA5QFoyuTSUq4wXYkaoPsjPluC272Mdm
 Ns8GvucNtSYonZuHwGSkOuSY4IpPueF1/k0y96ZCiQR+bWziBsLhkA8UL2b2AwGc
 tI5CjhGktRh0wjCljZ9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625596; x=1794632796; bh=+
 LBt2CZx+pYCe+VktFRZGdw09u24nWiEXEs5S39YV9s=; b=GSo5tdobvfAhOysz3
 4BF6b3zPdMu2r+/9DDrnpE5gePb3kcW3EjLbCs/37NWtWcgPJLlW8wdxPUfYMDsN
 ieu5MBjXH2jJSo2KaqazrBrGvS5Pe/PrUVkmR1JrsFew3I/HSdXhz3VpCiKF2T2a
 FpVWlP6H1liNGXzld/4QG8nLVt4qrrLv2XZwuyYMcHWmI5ft/DiZZ/3JCgZCRI6Q
 Tpt1NseJHQzvUuOGc6iX/9fPnkDerV+9LkHGb/BKN89p4xr7bkjcssGmdDPNsEUr
 /vRyvbjd1d1hYvA6p5sNACFwl2OptJ/QYDniimqqqrS2RBFlyz9t5otFrCtT2PRi
 BWtAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625596; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:iogV5NFT397Yqw5vfTqDosuqU+If7jA/2Xgmkx1F0kAlR+D
 gE1mIM5rkTPS9/mlseZZjhWgm8R/PZEOJEC6YdRhaWwlgz3kcYLCt5sY+RYNFqfK
 iy+rsCjPFVpEM7p8tjTzibwxwjael35lrfyWHcEj4q5B3Unq4Pl3fM2XNeR02i0u
 00nh50ecMWVZhPx8GCvf0nGPJTFxleqdgCTDtEPVf73bdo0XExULyQw/K7j44Qbm
 kyWZaU20AL5UgGrTKW2cHbkQ1N5CJiBv5J/jH7AT+B6A02JArkNgYF6mtouOLtwX
 pGuc188JRVnXEPvb1TMP9vnUGNNB1nv9WmFgP/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:XafIFsESyWSCFJ4JxBXyNSLDfMk/cjGExV12Dd3+tVI=:WrX3o+lDD5jTdTR26wtfTgnBfNa8ezWBEE2dZFQ4KSc=;
X-ME-Sender: <xms:PND3amh794LD56q87f8rG2juyPzV7O55k23-4C6KRn3BOzvA7-01Ew>
 <xme:PND3ajd8rvObjVO4nu0WaRfgKSGOd3SBEZXXQneH0K4jnzjijFNe0ARcEgVvoHGR4
 uvMR85eRIqnvf5LFPO2EEqaA_KyDDhQlxjzmaY5B2cYcKAEkY-ltb4u>
X-ME-Received: <xmr:PND3alWYdsRB9ef9UYEv99V3MhUx7UqiCh_ZdL-gd8hpiJHeJ0mylOlHCSDnziYt3ilgzbkm>
X-ME-Proxy-Cause: dmFkZTENh3Cq6bNtRDDqH//naJpK03OGhXB8Cp3eHHX2EpHYf2oBjZ1/43ruyqVDLzR5bI
 q7gV+k53czH7SJj0JMNaMvWBGkaUqaereb01ifHpul1q14DobEKJC2mDvQQE3HzqoOU9gl
 QO0UnCSJOnNpWmY1qWdj/IivEZ+5eJmA8XcRYmqsfPBSZaKqk9zCnQvCGUQuYFJdsYZGP5
 L8zECb373LU+oefpY9jKwOjkFDiU4CWxV3iExHL3zPnpeZwM1wkFJxhm/yJk+2AJ3ju4OO
 RXCknd9xSS299sQU1FiikwzYfEAyF9m0XTBIDoIn2qfRRJDU3uzKkImCFIAQPMS5Q++USP
 923CS5Nb9d9bOFy7Yh3e2DfgrlFTDA+YgZzQFEB14VPk/BfY8zaBCcNePtMsiEsymKDO6c
 W0e6TVNKDzEaqoJ2VAR5RTbrla43R+hyFAL6n9OzOnl/EmCym3tRL9zMVuSbjH+6tCN1ts
 TI9CqErl0Ry8Fkw7U5Prk50r/bH+K5gnse8OO4GGwSatLH16xsvIeclqhA1fHdF+gkT5d5
 PHPEoo529Jt5Rh512efJf7mKQoZlqE1RI9YX0hHLyamkSzDNJ1qGX/f6cwG7VwiWdwcW9X
 8szlPKTYYzpRTRFBfqDls7NX+WJEuVFmwIZsWbwOBibH7dta4PP4F+9NBUrA
X-ME-Proxy: <xmx:PND3alxWDBWWs41Vz3896FLBlfwKaT-ErVWM1MbDMRpNjfhst--mnw>
 <xmx:PND3akDSisRf8kmAG5ziw2CjLA4HYHxJPtkR7eVdFeyfTXS7iTP0YQ>
 <xmx:PND3aj78gBFNfd9oR32HUjCa44iNz1Yy_rySCcy1lyuvWSJ0tzNwew>
 <xmx:PND3ajkPlXi8PZYSg5gSett_1A6PoHDHFEznZnj_FRG0nrxTGzWRUA>
 <xmx:PND3arl3EN4pbEk5SAYd06DE_sYd_ei2A4Vi_zJmZb2QuP6Pyqod2zZ_>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:06:27 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 05/12] accel/rocket: factor the completion tail out of the
 IRQ handler
Date: Sat, 14 Nov 2026 16:05:22 +1300
Message-ID: <d3edc2ee1e2f6e431f3a22fad4466a1a59e053b6.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
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
index 41c723238b2b..68df1596014e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -367,6 +367,24 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
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
@@ -380,17 +398,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
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

