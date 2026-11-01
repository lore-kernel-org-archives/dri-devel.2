Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA3606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M5mUDqQ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9734F10E455;
	Sun,  1 Nov 2026 20:04:38 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F3D10E455
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 20:04:32 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so4369488eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793563472; x=1794168272; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EADMVsLqtl7UawIMCnC7ocVxqfEpyyxisoL1Jal/32g=;
 b=M5mUDqQ+dXKyHPBw0BcHCI1P+qffb/kQJksXoMFJ5eXFjN2OfR459QgKljbtW5wIPQ
 jpvFl1n6fP9lhtJ8n+ChBucg3ECHyfgXYT6Qg/PmpBv74xMp01IT+7NzbW9HvbkUGRKU
 8c+ZVMLoPhm31xNcm+7bkrZYQTroNIEJp943S3Egh2MoaydKcgxHWClK1tsvv7Knbaix
 L4EY0+LLCRV41oo/T4vckc+pIJrYVKDlhqOUFWmAbFwIWKn5ddxfpLiDQ7306KUiiFLW
 DEfZz8rOQKBx9Um/mtCa5DwoQEnTXdZ5NRF9PXKF2sD9O0JEI0C/OaQbQ6jBd517PFFu
 7khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793563472; x=1794168272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EADMVsLqtl7UawIMCnC7ocVxqfEpyyxisoL1Jal/32g=;
 b=rmMvs/9RdeWzbpDYWg2NbOMQDe9r9z9qY4Q9O9a1dG7//iXxZvcmo2/0Tqjz8+orwH
 zm98gw7Wwj1Gw1ALzgfJx3DIbrF8qazVUmx8kg4VBiHwvlVCg0Yd5ByX0tIUhiHD7iia
 sNXH+yc+gDfGu11yYXupWM458KE59MquK2vqx+llnsyGREvqOFFII+4l8zYu3NJ+kzPq
 ch61rYjynPwt90+g9Vz2sA7CC5gBj3N56QCglox2UxF/32ui1BUm90t7+lb8vcgit+lO
 mhHF9b8OChZAlB0SbjBtM2ctGVBmMURLReRsuzq4kSk4zKeJKLeYszQyxU1QxkzplJzT
 1CeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4L6cpuXQJ5c5LWZirIQvP0RTJHJ1RX5y4Srb8kS2/JUcVCq5/H0C6rM2rHWNicDUURdgF9xWmaic=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+CvQxezWpjx2YWKTQBN0KdKn3pyrCvonbIAcXq0oS5cGJc2FWr
 3CP37dUPUnzdzGsCso/fsShZRiCiPQLzT5XMbJd1Kct3gS19CzsI+Ti/
X-Gm-Gg: AYBFou1TLPMq+ngx2un7fSItL2AGSAQWsz7ZOB2VyoFycjCkKukr8xmbehtdWzYxhL/
 1Bw4gyHQ1s1SbUsN8xIg28wK94kuIlydpQdlLOKRBHtcGQnIX7tvY8Wm1lp3D6xgg1iSZGie2re
 5yH8EXC95DAMyu/xy7mVp13r0/UuptRewdzccJwbv7b9FQvR90GrhkAnhKnuAEdnje2zML7lRRt
 QtO/j+aJvwJ6mR/w9sgfrtR6XDJz2JxL1ZwOOTZXAr8256ohma7nNu9UQJggj/3VuShf5Zo5oS2
 ytUaUC0gTU41P4JMJ1eO8Sh2m2jK7QIBzeWp3SNbOveio69Tt7aFPVNL1LC+D0T5LspHrEORPJj
 4C/MYfgPNLYXCCYORKChb0PS2GvFSDRrY6Xf6FhNe/W4fW2BG74yrSr57VC49lyjKrF4FH8HxRn
 44KVhbgLVrAq04QZeg8hh8vrroMqP2lecPewM/gm0j2ZbaGz9VQ3nhl30tjWq943aTFw9ViIbJM
 YF03TIAAaaRW2rKtEjHfWOEuRQR8wiXEywy8q0cA+wJF9jpeWivAi8wlaew7tjTQwJzNySG33hF
 apZTeWZHJwxeo6L1GUY4vg/pTWN3GiVJVfohPdF1NYdxBEhbk2rf01pDVfNFOyJunXsnDVcKF8e
 Sh322ck+5cWC09FL6uGXpwUcOY+SydUe7Cvh4Zg2zqoO0AiEE5w3xguRS2OdpS3Mp5whG5bIjhZ
 K+fA==
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id
 5a478bee46e88-36a42345b05mr16145992eec.11.1793563471296; 
 Sun, 01 Nov 2026 12:04:31 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm29251211eec.28.2026.11.01.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 12:04:30 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
 GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/nvkm: clear use.enabled when subdev init fails
Date: Sun,  1 Nov 2026 12:04:28 -0800
Message-ID: <20261101200428.16959-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Kepler boards without the video decode falcon firmware installed
(msvld/mspdec/msppp), every other VA-API decode attempt binds to an
engine with no ucode loaded. The submitted work never completes, which
leads to a context switch timeout, a channel recovery that cannot reset
the engine, and eviction waits on fences that never signal. The process
ends up stuck in D state, or killed by SIGBUS when it touches a buffer
evicted after the wait times out:

  msvld: unable to load firmware data
  msvld: init failed, -19
  fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
  vo[5444]: channel 14 killed!
  WARNING: drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c:117 at nvkm_runl_rc+0x2a4/0x3b0 [nouveau]
  [TTM] Buffer eviction failed
  WARNING: drivers/gpu/drm/nouveau/nouveau_bo.c:1092 at nouveau_bo_move_ntfy.part.0+0x9b/0x100 [nouveau]

Tracing nvkm_subdev_ref() and nvkm_subdev_init_() shows the pattern:
a reference taken with enabled=0 runs nvkm_falcon_init(), which
returns -ENODEV; the next reference sees enabled=1 and succeeds
without running it.

Clear use.enabled when init() fails, so that every later reference
retries init and fails cleanly.  The other readers of use.enabled are
fini() handlers that use it to skip teardown, which they now also do
after a failed init().

On a GK107 (Quadro K1100M) without video firmware, playing H.264 with
mpv --hwdec=auto: without this patch the GPU channel is killed within a
minute and mpv hangs; with it, VA-API decoder creation fails, mpv falls
back to software decoding, and no faults are logged.

Fixes: 8478cd5a740a ("drm/nouveau/nvkm: add locking to subdev/engine init paths")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
index aab5a73f467a..ff6858f5e5d3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
@@ -157,6 +157,7 @@ nvkm_subdev_init_(struct nvkm_subdev *subdev)
 		ret = subdev->func->init(subdev);
 		if (ret) {
 			nvkm_error(subdev, "init failed, %d\n", ret);
+			subdev->use.enabled = false;
 			return ret;
 		}
 	}
-- 
2.56.0

