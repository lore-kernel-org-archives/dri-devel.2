Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B160A3830
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUJYcFEE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00301122EE;
	Thu, 29 Oct 2026 13:37:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B3F1122D6
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9409605C5;
 Thu, 29 Oct 2026 13:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346751F01825;
 Thu, 29 Oct 2026 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280992;
 bh=A1P82utl4Io0xsJbtO1DOGIXdrEc/LiH8oRZ1H4OV5o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lUJYcFEEsv4wWW+ZS18Lzdk8jR1BdOYu9JzYXW//+I0HEwD8g/LcLdGbWK50iyVEK
 yuFxHD/06AlgEnqC43Pk1JV4WhxJEnn2sekTfE4mBkgcxhgHbBgrXeMphY3Uuxb8EE
 yyRNnfCDBZJauNC/9nYC4NKFypMbk9OTH2akB1Uux3wvcWTdYflqttPrBvCnUJFw0S
 2gdzoZrVLN8lxo/no7MU1FJVgHNzqkCNapRI1SigcAYyZD5w5PoVknBBR1+u6/qTXv
 /lhLjS6HRdjTb207UYYraaDxzcrrlyG5B+lWfpjQO9mOuMvk2rScfJTepDgGJNozC5
 74z6uAIJ+hdlA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:59 -0500
Subject: [PATCH v4 12/31] accel: ethosu: Validate timeout command offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-12-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

QREAD is supplied by the NPU. Check that its command-stream offset is
word aligned and within the validated command stream before using it to
index the command buffer in the timeout diagnostic.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_job.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 3976115902e8..77218bb17006 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -345,6 +345,8 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 {
 	struct ethosu_job *job = to_ethosu_job(bad);
 	struct ethosu_device *dev = job->dev;
+	struct ethosu_validated_cmdstream_info *cmd_info =
+		to_ethosu_bo(job->cmd_bo)->info;
 	bool running;
 	int ret;
 	u32 *bocmds = to_drm_gem_dma_obj(job->cmd_bo)->vaddr;
@@ -367,9 +369,15 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 			return DRM_GPU_SCHED_STAT_NO_HANG;
 	}
 
-	dev_err(dev->base.dev, "NPU sched timed out: NPU %s, cmdstream offset 0x%x: 0x%x\n",
-		running ? "running" : "stopped",
-		cmdaddr, bocmds[cmdaddr / 4]);
+	if (!(cmdaddr & 3) && cmdaddr < cmd_info->cmd_size)
+		dev_err(dev->base.dev,
+			"NPU sched timed out: NPU %s, cmdstream offset 0x%x: 0x%x\n",
+			running ? "running" : "stopped", cmdaddr,
+			bocmds[cmdaddr / 4]);
+	else
+		dev_err(dev->base.dev,
+			"NPU sched timed out: NPU %s, invalid cmdstream offset 0x%x\n",
+			running ? "running" : "stopped", cmdaddr);
 
 	drm_sched_stop(&dev->sched, bad);
 

-- 
2.53.0

