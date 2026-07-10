Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F57C44509
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D27710F965;
	Fri, 10 Jul 2026 19:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+oSygXn";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CE810F960
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:07 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so8037955e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710486; x=1784315286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zbrYcqmMOcj7F4MQKjHREDeErg/FeYwN50JFqd0IkSY=;
 b=i+oSygXnGIF7RDeABxAQkP++3FoHIFTch2k4T5tASWfc/nrwxSF4WtVOm63zAxRiOR
 M6CfAPmJXFtOVnBmzwKw6ErQ8Y42mfTffwN3yptvyW3a7+dU9WU1/OWiSwekZk9BUy2N
 PCSXsG0HvSaHs04qwaUifTNgdfHXxLl8NKcDbc9RSc/ZwC2uSoQSguSfuQAYDhTZYgbQ
 IOd1KDr9x+d1PzmxmiFjcIEp1XrigVWTNFdNvAMxsh2i+dG6WpgONn84iJtd2jSG/Oea
 E0taIPUosuuvVpTP6dctRaxlZJZxREyJX8t+jw8U83KJWOOJ853Vq20kSpPVAps+1V2o
 Y4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710486; x=1784315286;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zbrYcqmMOcj7F4MQKjHREDeErg/FeYwN50JFqd0IkSY=;
 b=FgrLCis3Og4jOlGKLvVGD3o+zYLT03H43rMYmEAjxPBYjCHEWEulb4BOrXfoFKRDGx
 s1AsSreY8ebyvTvoT8vemtlJ8rswjvd2W/uqXOKWS+JShiOuaq+ouEaUvr2Vr8iPzjXI
 jNw0p8UFTZRJok+pNi9KBH2c9UWE7TEKOKyVA7fOICoEBqAxL6IHM1es76yEVgXfVODr
 WhdrEZnK7aPEFYN0qIzZ4HD9ZF//pHXzGnuEc9Bba3m8ycDo7Ugn0h7VYFDewaRdyBNn
 AuXas1YySb+iCXBpJou1qHX2f/AaBVz/Reh2uwnblYa4Trb21fPH6bOoWHDp2Wy9Qwo3
 6PZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDRXi6TUARjmUqYZjMKdr7MbqP6rLT4Rz/2Wk6kHbhjjH7P2NX8vTsSH3tdA2au7uwXQRrdvkcMOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/grMJYMsX6BBhL5nCPAuRIAmgAdAQwZDmVm9dnxiTQSwAc1I1
 02DiPsUpjh7jIzBATgaW7v9lDQ2+GTScovCJrBIa/7OYMnuHjdkSGsOG
X-Gm-Gg: AfdE7cmjSvtRCcb4S1nKuBd4yVA5rEWk8xBd0LU2CX2JEMEBX1gUitITnhhe6qvOtFg
 4P57KPBDcj+nxALIJbKu57VEZ+157Y/7Ci6ut39IdbJ7w4pdPA+BlHQ4tTWqQMdMmZRJp/Trhd+
 MPz5JmtYyJrhj1p4s131xFFdBKIQPtE5WLi9UFc/na17bc8Zp943UmMsP3yD/Oc36CeyMi81pz2
 O+zgSpBBgZwanwEzXEPkj4EB0eRt69B6YeQdaZc56/iMaiP7K/4tggtaUvmOOFMaM/gIWgSesiS
 O90pMJDyBU8ydsm264nqZFT1CWNAnID4mHg8R+lMqbkHnR3/UpaZ6G1Xy4p+Pjp8f0mTYxk7wga
 cgUb384wk+qtNm+kSRH5vtCazB2oQPlBrTGICBLSzLMAzzbR2F9KtnaQDppDsMF3GUoKXXxaOLR
 a/J2IUQjeIRYFJddWUuHau6gb3lv9I3fnB5zfN
X-Received: by 2002:a05:600c:4ece:b0:493:a613:56b2 with SMTP id
 5b1f17b1804b1-493f87d8573mr1160215e9.8.1783710485433; 
 Fri, 10 Jul 2026 12:08:05 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:08:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] drm/ttm: support using drm_exec during eviction v4
Date: Fri, 10 Jul 2026 20:52:51 +0200
Message-ID: <20260710190752.2355-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Allow specifying a drm_exec object in TTMs operation context which is
used to lock objects during eviction.

This allows to handle deadlocks much more gracefully and with that
avoid returning -ENOMEM on heavily contended domains.

v2: rebased on top of Thomas work
v3: rebased again
v4: adjust to dma_resv changes

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 12 ++++++++----
 include/drm/ttm/ttm_bo.h          |  5 +++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 1bdd69643c313..570640ae79d84 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -38,6 +38,7 @@
 #include <drm/ttm/ttm_tt.h>
 
 #include <drm/drm_cache.h>
+#include <drm/drm_exec.h>
 
 struct ttm_transfer_obj {
 	struct ttm_buffer_object base;
@@ -839,7 +840,9 @@ static int ttm_lru_walk_ticketlock(struct ttm_bo_lru_cursor *curs,
 	struct ttm_lru_walk_arg *arg = curs->arg;
 	int ret;
 
-	if (arg->ctx->interruptible)
+	if (arg->ctx->exec)
+		ret = drm_exec_lock_resv(arg->ctx->exec, resv);
+	else if (arg->ctx->interruptible)
 		ret = dma_resv_lock_interruptible(resv, arg->ticket);
 	else
 		ret = dma_resv_lock(resv, arg->ticket);
@@ -853,7 +856,8 @@ static int ttm_lru_walk_ticketlock(struct ttm_bo_lru_cursor *curs,
 		 * trylocking for this walk.
 		 */
 		arg->ticket = NULL;
-	} else if (ret == -EDEADLK) {
+
+	} else if (!arg->ctx->exec && ret == -EDEADLK) {
 		/* Caller needs to exit the ww transaction. */
 		ret = -ENOSPC;
 	}
@@ -993,8 +997,8 @@ __ttm_bo_lru_cursor_iter(struct ttm_bo_lru_cursor *curs, bool first)
 		if (!ttm_lru_walk_trylock(curs, res->bo->base.resv)) {
 			struct dma_resv *resv;
 
-			if (!arg->ticket || arg->ctx->no_wait_gpu ||
-			    arg->trylock_only) {
+			if ((!arg->ticket || arg->ctx->no_wait_gpu ||
+			     arg->trylock_only) && !arg->ctx->exec) {
 				spin_unlock(lru_lock);
 				continue;
 			}
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index e1221e3be7bda..0ffa84a5caa65 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -186,6 +186,11 @@ struct ttm_operation_ctx {
 	 * @bytes_moved: Statistics on how many bytes have been moved.
 	 */
 	uint64_t bytes_moved;
+	/*
+	 * @exec: optional drm_exec object to use for locking and contention
+	 * handling
+	 */
+	struct drm_exec *exec;
 };
 
 struct ttm_lru_walk;
-- 
2.43.0

