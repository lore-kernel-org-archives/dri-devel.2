Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B03C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2C010F528;
	Fri, 11 Sep 2026 07:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SKmq6zxU";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 11 Sep 2026 06:14:40 UTC
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEBD10E351
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:14:40 +0000 (UTC)
Received: from seu.edu.cn (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4d62c4fcb;
 Fri, 11 Sep 2026 14:09:33 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: thierry.reding@kernel.org, mperttunen@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, bolin.liu@seu.edu.cn
Subject: [PATCH RFC] gpu: host1x: validate the firewall source mapping
Date: Fri, 11 Sep 2026 14:09:33 +0800
Message-Id: <20260911060933.94619-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08f15ebce03a1kunm50d7925d1c7389
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUlIVkkaSx5NTklDGB5NH1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
 hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=SKmq6zxU8AbvNDJYWvMjw56qUT3NfSgqVANAOs+nkFod9AgPWHuNgBwVxihCQ4qQzjNMOovnvvKwVyzyBkPxaUKoqZ35hC/vjW2Lw2EeLXqTmbCsmSn4zh0Ef2+U1l24Ev3a/F1fwJTIxiTzmfOKQHn56HUQvThUshaGfLU4lDM=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=259Tqt2SMjWpJUP49MEqUUEWra0KBcMh3JuBwiQtpaU=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

DMA pinning and CPU mapping are independent operations. Reject an
ERR_PTR or NULL source mapping before copying gather commands. Return
the mapping error through the existing job-pin unwind path.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 3800391db1b2 ("drm/tegra: Add PRIME support")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/gpu/host1x/job.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 71411bc344bb..b8e7a2752cd5 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -575,6 +575,10 @@ static inline int copy_gathers(struct device *host, struct host1x_job *job,
 
 		/* Copy the gather */
 		gather = host1x_bo_mmap(g->bo);
+		if (IS_ERR(gather))
+			return PTR_ERR(gather);
+		if (!gather)
+			return -ENOMEM;
 		memcpy(job->gather_copy_mapped + offset, gather + g->offset,
 		       g->words * sizeof(u32));
 		host1x_bo_munmap(g->bo, gather);
