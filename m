Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C394CCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2052010E095;
	Wed, 13 May 2026 18:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pNZpPezw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3965F10E095
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:55:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 554B860126;
 Wed, 13 May 2026 18:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D013CC2BCB7;
 Wed, 13 May 2026 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778698503;
 bh=mdi9g/KaPEC280U/FqLeU0lAH63bhv2L359Pq7ECmJg=;
 h=From:To:Cc:Subject:Date:From;
 b=pNZpPezwJRjIZ6HCrsq9p4zZUFFQfNJUfFsF4KQ37g+S5LKQXGVNPiMcCa1vFlTWL
 k17ydn+Kvyr4N2lSoG8HIsPGm6x7nc1jtYZtPc+KGi3+yUfE1X5g8ipKEnH4g9sQuB
 F2id2NrODNu5dd4QL/VNO/W5RrOx3c1il+U2Tu6UvIB6pqLlIxfrPWmPd3/I9byFs+
 IjrOGLyrIB0A78T7jQaFvmiQy0Cm5poOQkpUGUTHrnNCEJ14Vrk3D4wI+Ppo7wU6Cp
 aj7Vb/g4cDe/awwTNwX/S5AOv2gbuTNSM1pz7GW29IBk4G7Xz4UuOXPobiMgOZ5RGg
 K9e8XILhs80/Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel: ethosu: Validate SRAM size on submit
Date: Wed, 13 May 2026 13:54:34 -0500
Message-ID: <20260513185434.1667045-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Regions with a BO are checked against the BO size, but the SRAM
region is not. The SRAM region doesn't have a BO, but the command stream
region size should be checked against the SRAM size. The job's
"sram_size" isn't useful here because an evil userspace could lie about
the size.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_job.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index ec85f4156744..e7b07cdbcced 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -417,9 +417,21 @@ static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 		struct drm_gem_object *gem;
 
 		/* Can only omit a BO handle if the region is not used or used for SRAM */
-		if (!job->region_bo_handles[i] &&
-		    (!cmd_info->region_size[i] || (i == ETHOSU_SRAM_REGION && job->sram_size)))
-			continue;
+		if (!job->region_bo_handles[i]) {
+			if (!cmd_info->region_size[i])
+				continue;
+			if (i == ETHOSU_SRAM_REGION) {
+				if (cmd_info->region_size[i] <= edev->npu_info.sram_size)
+					continue;
+
+				dev_err(dev->dev,
+					"cmd stream region %d size greater than SRAM size (%llu > %u)\n",
+					i, cmd_info->region_size[i], 
+					edev->npu_info.sram_size);
+				ret = -EINVAL;
+				goto out_cleanup_job;
+			}
+		}
 
 		if (job->region_bo_handles[i] && !cmd_info->region_size[i]) {
 			dev_err(dev->dev,
-- 
2.53.0

