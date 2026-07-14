Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D82C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFCA10E6BE;
	Tue, 14 Jul 2026 13:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6CxU0Ar";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBB310E6C3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:21:36 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8e5be46f663so7538296d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035295; x=1784640095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ljyj9DkB5xbAZqgYsTFaAqTNeOS834qmzh1t0MU7eq0=;
 b=P6CxU0Are2FDh+IOSod1sXiggNUR5PalhfNDzxfyTQZarifv3XzPPVn3Hl64KeEBxQ
 mhT7mXzyNz4FVsV4KqqoCYu33UzzH+xFaczimIYSM03/s8+FiNGVAXm4glgjSX17OlpA
 NXKI1Neducy4ofhc3ORR3Dm3z5BCOwBUvF5jEPnCG6ssrN3Ey2ZWrK7Q/4v7B92fcx9z
 tv3LmZbFQfz7urkKzbSnOcwieyQTM3FqIZaBa3GQ5NkjRiTEuLq4FagHj2oTYu1SkxTZ
 ssIREKdVbJ42fQON8FfNeLBSq06+eZRi/630Wab6VUMPFnlA7oPCoZTSRq7bQqcL9nL6
 iTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035295; x=1784640095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ljyj9DkB5xbAZqgYsTFaAqTNeOS834qmzh1t0MU7eq0=;
 b=EVXizCEPL0InVO4qBB72EZXJod1BzsSfdSP8EV70u1JS70YbsXRZSRVmABsY5NulKO
 mBHOqKjGmnqy0Km7T+53VR1Sw+xWlzQUCPKLPzYsiCBz3+AlZtoBv3xhpTZYWfaItjfU
 0jG6hTzdmqyPyPBZRG+ZuqCBapN/iq3aY6mOI4rIGZWEpZzVIrrrOrHxYt8/LnntDMl/
 /Suu38KgsHpIz7h6lVmiXVDEx1+vVmsC6LggGJ+1Wt3nbMgzHkRdj5CQLKtVAW02MMFP
 yTw35+hbn5KtP0y2VDd2iTliKxlKqXtmxB9sZ6b87a1vGTkU034TkquM6pMR158h2rVn
 7bPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRaTyLbOQWQorsWkhHkii40uXKNbCF6ELTBA93GUDh230rVDfWFD2Ted8CjM68NfFVsC1tLJSwNtw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz5GqeW0pNYyl9GiGLRgiXi5mQkoQwrUZlZy7HyhEU0k65hV+j
 BtHO6AwM24Nl4mUIGIOyoTFvFDxWpwDhtbEoZGhHuNXbm7jDllgIdk0/
X-Gm-Gg: AfdE7cn62h1w3XaTZMe+gegBWdaxJobkASRISXQ0hu8SjdPw0578OzTYaF3YeoSvA61
 USmASA29p4R36g0Slw0TxWyOplCuPIhTFecYDdAztBiuDdlj7rvDcZqqFQczWNYJ8/il13X50vw
 +qrMC6z7Vpv2CypMUp4yUplMRZIBj33Rg3Nx5xVrjqV4DmP99lGFdLeCbOLR4ryhUm185L2i7m9
 AvVLBTdhA3WWNLefIghHINAgsaKzYwtdTxZ/eYLVzOmfE4vMo82LttynozEXHrx+Dv6zgz/lTwA
 ZDMah5F069js0Lue9mUdKyVBU3/3C764IHveL/LzShXHk7G4LrhkkTb33cigunDA/91+9ooX9DZ
 RJf2gWyjU+pyNC6GXlAAq432B3TnQZApl+1OqylbG6T83mNaOTRGWroIvOv7aBkiVnNZKjhI=
X-Received: by 2002:a05:6214:27c3:b0:8fd:6de3:dd8b with SMTP id
 6a1803df08f44-90402b67f93mr150157116d6.65.1784035295372; 
 Tue, 14 Jul 2026 06:21:35 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9063df4319asm66297986d6.38.2026.07.14.06.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:21:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/tegra: Finalize GEM object on initialization failure
Date: Tue, 14 Jul 2026 21:19:22 +0800
Message-ID: <20260714131923.1575860-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tegra_bo_alloc_object() allocates bo and passes its embedded GEM object
to drm_gem_object_init().

drm_gem_object_init() initializes the GEM private state before creating
the shmem backing file. If the file creation fails, it returns an error
with the reservation object and GPUVA mutex still initialized.

The current error path directly frees bo, bypassing the matching GEM
private-object cleanup. Finalize the partially initialized GEM object
with drm_gem_private_object_fini() before freeing bo.

This issue was found by a static analysis tool I am developing.

Fixes: c28d4a317fef ("drm/tegra: gem: Extract tegra_bo_alloc_object()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 436394e04812..eb513cb7521c 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -314,8 +314,10 @@ static struct tegra_bo *tegra_bo_alloc_object(struct drm_device *drm,
 	size = round_up(size, PAGE_SIZE);
 
 	err = drm_gem_object_init(drm, &bo->gem, size);
-	if (err < 0)
+	if (err < 0) {
+		drm_gem_private_object_fini(&bo->gem);
 		goto free;
+	}
 
 	err = drm_gem_create_mmap_offset(&bo->gem);
 	if (err < 0)
-- 
2.43.0

