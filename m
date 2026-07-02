Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6094BC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D7210F4DE;
	Thu,  2 Jul 2026 16:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Xi2/p22H";
	dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB4910F4DE;
 Thu,  2 Jul 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783009482; bh=xtfEKNw6wJCBOVy7WR/hQK9kzhH/JkuJxV7BK+/tQEg=;
 h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
 b=Xi2/p22HDNkf9hsbUGrRhYTbZIWuuLON7SqzXHNmMSIGL9uc3fLzsxSIsYyySHIOA
 xW6BTR+g2j5Hqn0Vzo2StBM952H4DQEd/mB5XCeX0RHe6wSxExMxQ6cT4Q9zHgZmCM
 pp7wvTmPoXWdMV/7buFDKk4YMeNhG/gtFZJx2px1a9Sh01dhJkSSfmKs0d8Wp+tofx
 Ai4eCeaVjgVdHakIQJQOxS+8nC/h4D8AUSAnV9c6ktSrgoCMMugVzaArvm0m5NX4GP
 iBq9craGKulxnO7o3iG8N5+RCEF3ssumI4aSpcucK2LL1IuRucZf2X2oStBLASLeDP
 bAcnrGEM3Ss7A==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4grhzt35GnzZr;
 Thu, 02 Jul 2026 18:24:42 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 02 Jul 2026 18:24:41 +0200
Message-ID: <982728e51afbb9d400372e98676ad76335a56410.1783009338.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/5] drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
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

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..9ee894e0dbe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1696,8 +1696,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		dma_resv_describe(bo->tbo.base.resv, m);
 		dma_resv_unlock(bo->tbo.base.resv);
+	} else {
+		seq_puts(m, "\n");
 	}
-	seq_puts(m, "\n");
 
 	return size;
 }
-- 
2.47.3

