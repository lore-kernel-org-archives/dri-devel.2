Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBD606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsJqDdHw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D050710F03D;
	Sat, 14 Nov 2026 16:25:13 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD0810E16F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:20:41 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1af971cd9f9so55464c88.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644441; x=1795249241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Kn39X2pYs+jW+52+qPxiOSR0mlkbzAfD+hyR5VjqrQ=;
 b=qsJqDdHwMlOtWn9K5N/m4DseRVK2mHtdKaNrCELL2pGo7LEqfr/3cv3ooicWoamHn5
 vfdxhNganbJ0NacVRJ1N/q6uJJMpk2VISDuraWJYxwegb0Y5j1H2aT6b85LSkIrPfr3q
 Q2U+MRTxTDOG2d9YiFfSVYtWzbW85lAxZ3uyyDkrT57Z76MBVPPbSbctyLfZmw7IBQL/
 rF28J5i77+v6NKX/lDsVU2sP9kk+eWQdGz+O9oTYo1di2FM71ja0+gvtcxeJhb1dxUjW
 S++3H2gI6AO56PhnMduc6E57cOxf0ZyjHqcvKK0OT/wgXB3Htb/wGTpd5fPd/jkGKVxs
 OZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644441; x=1795249241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Kn39X2pYs+jW+52+qPxiOSR0mlkbzAfD+hyR5VjqrQ=;
 b=ztyXY3519DHj6AW7LJipbl/Pta7DWG/FqyXObd0QEAMyPMbTskHfbputXxsvNE2hUa
 uYEv8miZ0Ta5+fSfyb1QDqOgO+el97e82opzbjfWpftm0TTuxBXg3gdBzCefigGWTeyk
 czUp36z1Mk8cmTAdUfoeeliluhXgxw/m91GSggQvod5GscA57s1rEVYq0atv9N/Zv3mp
 AcMdDHP8ZQjFRmKr/54Sf0D4P8wJH1SLMPisgWX7D1WeWDePV/ByzRgCN5poiCvzO0Oh
 YSbElFuXAu4NReRD2/v210EdOazScVb3UAW9wzPxRPzsTsfF1aFTkiEuJ959HxXWGGas
 6H/g==
X-Forwarded-Encrypted: i=1;
 AL+hErFU73rWvdSMwyAikxuTidtyRLoiOQS+l+jE1plOBaW+BifXQSofOPG5+9emEq7eIW6d2E+6FlsWLE0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/LQ7sxeMdokHPeQJKHzqS5YoxHgglu+hUsOMRbwyslzHzXTeK3
 OoxxYMLERVR5m13O+04vLriso35+5a73BZIqbtf2vBUSlLUZJdLfjc41IjHuiQRMkVQ=
X-Gm-Gg: AYBFou1F2WNudj/8CbAyQ13Xq5/6rzyaQqEONWVlRYk2Lx9152dw91mbVR6zGL34mC4
 X84LBUhgyFeX5hGrLRNbaqkvGdEJpidpWAHuABzh7iYtONG4Uzo51oJFM8TWn+PddFOiBtCciVL
 sW+SkHVO+PtoN4icEGn+A6U/FtxSPPuH9tSnBcOrzHRB3Rk71K4rMY6RnmlV8vKCiPxNWvAPCDN
 s6ALgFzrY0gz20TbYSerhBaN6yESspGty4m8S7TTzLsBB4Ky2D1ak8vbSiZokgxGCwPdALm/Gsc
 LjPz2fENM1b0N+yYmjS40abKcodC+p8Eaaugv4jB+2P8ShhK0vxHQ3wpSBi0eXv/8OCiF9FMDuc
 hINYyHC/Lt2BcFpmOvZ/4w3yoecHdUhZTYH4Qqx7Yk9WALyKcd4M14j4CCWj8EkaiNi/BstbwfZ
 wRdXvqPIq3W55tPO+KStG/6rxHrZEAPeK2WtRQ5iR9edcO1cZ3UDQpUELFpLCGW59hblMU+T2O5
 ctkPHFIGxsWwbI5o2HAw2SBHfvubCzVtQVL9CYlkgJZMDVOYqXwY3P8zbousQL1rCnAH9RrqCPI
 gyc9EdU8dPsYInBXcqQ4KTy8N+mT3frTVTuqqBfJy7sORTBDPgsVOxrsyK0TgH861T8WGHmkD2X
 a7xg=
X-Received: by 2002:a05:701b:260b:b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b502fe3f20mr7840573c88.0.1794644440684; 
 Sat, 14 Nov 2026 00:20:40 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:20:39 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 4/4] drm/panfrost: Don't destroy uninitialized entities of
 a new JM context
Date: Sat, 14 Nov 2026 17:20:16 +0900
Message-ID: <20261114082016.2454-5-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114082016.2454-1-arpe1618@gmail.com>
References: <20261114082016.2454-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When panfrost_jm_ctx_create() fails, it drops its reference to the new
context, and panfrost_jm_ctx_release() then calls
drm_sched_entity_destroy() on all the entities of the context. If the
requested priority is invalid or not allowed, or drm_sched_entity_init()
fails, some or all of these entities have never been initialized,
though. Since commit fd177135f0e6 ("drm/sched: Account entity GPU
time"), drm_sched_entity_fini() then dereferences the NULL entity->stats
of such an entity, and since commit 2df5efb45425 ("drm/sched: Remove
redundant entity->rq initialization and checks"),
drm_sched_entity_flush() already dereferences its NULL entity->rq.
Userspace can hit this with JM_CTX_CREATE and an invalid priority.

On these error paths, destroy only the entities that were initialized
and free the context directly. The context is only put once it is fully
set up.

The patch and its changelog were drafted with an AI coding assistant.
The issue has not been reproduced, and the change has only been
compile-tested.

Fixes: 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging job resources")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-1f36c24e-a878-442e-991c-1b387017bee6
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 0dbed7a50910..95fd9521016d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -1097,6 +1097,7 @@ int panfrost_jm_ctx_create(struct drm_file *file,
 	struct panfrost_device *pfdev = priv->pfdev;
 	enum drm_sched_priority sched_prio;
 	struct panfrost_jm_ctx *jm_ctx;
+	u32 i;
 	int ret;
 
 	jm_ctx = kzalloc_obj(*jm_ctx);
@@ -1107,15 +1108,15 @@ int panfrost_jm_ctx_create(struct drm_file *file,
 
 	ret = jm_ctx_prio_to_drm_sched_prio(file, args->priority, &sched_prio);
 	if (ret)
-		goto err_put_jm_ctx;
+		goto err_free_jm_ctx;
 
-	for (u32 i = 0; i < NUM_JOB_SLOTS; i++) {
+	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
 
 		ret = drm_sched_entity_init(&jm_ctx->slot_entity[i], sched_prio,
 					    &sched, 1, NULL);
 		if (ret)
-			goto err_put_jm_ctx;
+			goto err_destroy_entities;
 	}
 
 	ret = xa_alloc(&priv->jm_ctxs, &args->handle, jm_ctx,
@@ -1129,6 +1130,13 @@ int panfrost_jm_ctx_create(struct drm_file *file,
 	jm_ctx->destroyed = true;
 	panfrost_jm_ctx_put(jm_ctx);
 	return ret;
+
+err_destroy_entities:
+	while (i--)
+		drm_sched_entity_destroy(&jm_ctx->slot_entity[i]);
+err_free_jm_ctx:
+	kfree(jm_ctx);
+	return ret;
 }
 
 int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
-- 
2.43.0

