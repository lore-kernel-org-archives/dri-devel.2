Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A6606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fbxCJFxJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7FCF1129DE;
	Fri, 23 Oct 2026 07:28:40 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643A71129C4
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BR
 W6JbfIBewSRrs6cwpy1UkfXfBy3mR2z/T5ohaWkwI=; b=fbxCJFxJ9Cfqbdddyy
 M3aoFYxGWH5vvz/LtDSMMotMxOi/lXSrl6BaiDEx+YTdGI3m3X1QNAUf0sXsevGF
 e/n52vz1H/SCRN2LfbTQ7TDzjHIasKL7p3fVxU0I23bKxKmqx+AMGsiWUFedq63m
 uH5Q4r2f4izyB5QUZR090wWYI=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD394d9DNtqgRCoBw--.25139S2; 
 Fri, 23 Oct 2026 15:27:59 +0800 (CST)
From: oushixiong1025@163.com
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/msm: Report primary minor index as gpu_mem_total gpu_id
Date: Fri, 23 Oct 2026 15:26:44 +0800
Message-Id: <20261023072644.542364-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD394d9DNtqgRCoBw--.25139S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUGFyfXry8JF47JFykuFg_yoW8XFyUpr
 ZrWa4qyr18AanFvayxGFsxuw45W392qayrGryjv39rWw18Kr1q9F95ta4Yyry7Ja97CrW5
 X3WDGFWUXF10vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4R+zwmrbDH8TYQAA3-
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shixiong Ou <oushixiong@kylinos.cn>

Both gpu_mem_total emissions hardcode gpu_id 0, so events from multiple
GPUs are indistinguishable. Report dev->primary->index instead, as xe
already does in commit ce3d39fae3d3 ("drm/xe/bo: add GPU memory trace
points").

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/msm/msm_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 130ae27ee00b..46dada0b2fa0 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -28,7 +28,7 @@ MODULE_IMPORT_NS("DMA_BUF");
 static void update_device_mem(struct msm_drm_private *priv, ssize_t size)
 {
 	uint64_t total_mem = atomic64_add_return(size, &priv->total_mem);
-	trace_gpu_mem_total(0, 0, total_mem);
+	trace_gpu_mem_total(priv->dev->primary->index, 0, total_mem);
 }
 
 static void update_ctx_mem(struct drm_file *file, ssize_t size)
@@ -37,7 +37,8 @@ static void update_ctx_mem(struct drm_file *file, ssize_t size)
 	uint64_t ctx_mem = atomic64_add_return(size, &ctx->ctx_mem);
 
 	rcu_read_lock(); /* Locks file->pid! */
-	trace_gpu_mem_total(0, pid_nr(rcu_dereference(file->pid)), ctx_mem);
+	trace_gpu_mem_total(file->minor->dev->primary->index,
+			    pid_nr(rcu_dereference(file->pid)), ctx_mem);
 	rcu_read_unlock();
 
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

