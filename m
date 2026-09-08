Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5ADC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D212510E3E5;
	Tue,  8 Sep 2026 20:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nDininVL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3034410E3E5;
 Tue,  8 Sep 2026 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=ZMEWZWXTXy0juUhCP/VyyM3JVOauhXG+wy/tuimbToY=; b=nDininVLMc5mMXDKjwlnZEW+t5
 5Xw81cbU76TOGCDu9EPI/j6qbrVfutRABD9THlZlii3RLb+v/xP6CUyXhu1tMSfyi0NtgnjkowXRK
 sWthtG28KM4WX/hWcRLKZ+M0T2J/ABIxTvnEfp7zn8YJuAEm6ttmuyV7GloouowYKvqikq27hTSWG
 dR393y/7JxWoeThKqK4ictdoKqAm7KRXCn8b3mjo72zG/qToBWYOCX3vzjmlvKZmF+rsNF/bYgv9a
 8w57+wx3yzON6qBjtyo6FiaJYLZZOiiL9uXiUGGzAk3e8kjQLvdm5pxwF2mbc6tqnM9P+SI/umYHe
 M7MuWWBw==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x41z9-00Gfaw-PE; Tue, 08 Sep 2026 22:00:04 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 08 Sep 2026 16:59:51 -0300
Subject: [PATCH] Revert "drm/amdgpu: debugfs: avoid extra EOLs in
 amdgpu_gem_info"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-amdgpu_debugfs-v1-1-3b659e744691@igalia.com>
X-B4-Tracking: v=1; b=H4sIADZpoGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwML3cTclPSC0viU1KTS9LRi3SRT48QUQyPzNGOzRCWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgB0cmgjcgAAAA==
X-Change-ID: 20260908-amdgpu_debugfs-b53ad127f36a
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

This reverts commit c119d05a36a884482decc67e55944648f8cba97e.

It removes the newline even when there are no fences attached to a
struct dma_resv, leading to multiple BOs being output on the same line,
making the debug file less readable, not more as the commit intended.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5d9d137209b6..1b6c32a177fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1701,9 +1701,8 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		dma_resv_describe(bo->tbo.base.resv, m);
 		dma_resv_unlock(bo->tbo.base.resv);
-	} else {
-		seq_puts(m, "\n");
 	}
+	seq_puts(m, "\n");
 
 	return size;
 }

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260908-amdgpu_debugfs-b53ad127f36a

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

