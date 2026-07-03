Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA160C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C077810E67C;
	Fri,  3 Jul 2026 19:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Yj2fotET";
	dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A405510E67C;
 Fri,  3 Jul 2026 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783106041; bh=XE3pMXBPM9DjcBD8NeCGXPdXPBRsKRbm1We6CKCkULM=;
 h=Date:Subject:From:To:Cc:From;
 b=Yj2fotETXpytQ312dyRb+rh4tv7Rr2rW4rfiZ4KgxVbnVifkQ6E1MZI4UIv90WqNf
 dh2IBK7I3MQe/zmA8uIVaY/2jW5ogRhbavNLv0ihpWp7wu3ormSRrlbxckDntAHhW/
 FxdKTsrDmcYM1+kVK713FiVxjqdo8OAoen9iCR+4R0TthDS002AhUOR2kRQoi77h2s
 V7tiJyUCVVJuG4XHkzir4VxCBbPsNaedm4TwM/UsaZIBn5Nsz/R0jMcUiffQlKeYCp
 y2hQWlzkU+O2OnCjgaxO1opLYV02yhJsnJ0fuD5XnSJdsHB1ou3y89VPblSjGgfOuH
 ULnPmTKDy5iZQ==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4gsNhn2bqsz85;
 Fri, 03 Jul 2026 21:14:01 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Fri, 03 Jul 2026 21:14:00 +0200
Message-ID: <106339127b08487ca31f3abda8229954193b99fb.1783105925.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/5 v2] drm/amdgpu: debugfs: avoid extra EOLs in
 amdgpu_gem_info
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

dma_resv_describe() appends a line per each fence described. It looks
like it is supposed to be adding a new line per fence to the output
and that is how MSM and Etnaviv drivers use it. Update AMDGPU to match.

---
v2: moved the EOL before the dma_resv_describe()

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..258da62992b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1692,12 +1692,13 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
+	seq_puts(m, "\n");
+
 	/* Add the gem obj resv fence dump*/
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		dma_resv_describe(bo->tbo.base.resv, m);
 		dma_resv_unlock(bo->tbo.base.resv);
 	}
-	seq_puts(m, "\n");
 
 	return size;
 }
-- 
2.47.3

