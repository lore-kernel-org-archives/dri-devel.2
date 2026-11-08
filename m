Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EF606A33B
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwNpdQ9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2279210E76B;
	Sun,  8 Nov 2026 05:16:57 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7863B10E75F
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:16:51 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1b1ce85287aso52612c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115011; x=1794719811; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NRKj6bOqQvpAl7mRq0D5pUwiApxRT0gl15oz7QQ4eDc=;
 b=uwNpdQ9qy912mV2nHilVzUY/Fs0gG1fMvDqrIe1UwRsilRLVTt3y1TxtMl0BUq6Be2
 sBRavD6EzRmWn576fpQj1Ob4Ma8To4gBdA3hvIcvIeG/frPLViTApLLrcHiGglEisnRX
 3EhezWaGxkLSgWb18wo2H1uVQyOjLujStaicrMrE1SpudUZB9Fcx1WD2891H8xok0BIn
 sdv+E5JQJG9Yz71nDwuiGGTsvAIWwkS/JBC0JqtC9zMNIV6kvFPIj4cL468n1V/bENIO
 NMtcQoFtN5xK7O/mDiB2KyxYKjs1X5DaGrCPbyvs/rp36hhOdHPb+WekkzoSi/ddxe0W
 0BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115011; x=1794719811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NRKj6bOqQvpAl7mRq0D5pUwiApxRT0gl15oz7QQ4eDc=;
 b=MhzxXJorQepzFcqUn+jlT6Z+LBA25+OB0OM+rKqG7G93mTRY8+QFBGIO9x96efEA/F
 0WXgYR/9hoBoffy/eGgxOJZpCkuOcO1HdG9odr0+RsA+9hQey0obxF+t2YhxJyhJfAUy
 PErKfA5VUqpy6R0+B2jJX8EMOxSyr0kx80VlcAlH74NHefXZU+vYtsFWwwa+nHtlf8/N
 1zGY23uzVDEQKAyzqHn0vJ5soCTreMWw7I85Bnr/W8X/E4CqkS1n/jWqZl6GVEQbDeWz
 3p+0rLuQ2JM4TymEA0+ySj+b4kRFusPB9C9bp5kPN0i8gkOXV5LW89jGGUfc/rTo4s9Y
 neqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjKYNh7XoYla0DrqBPi34D0SeczDgd+YiQ7zP1GCODat+t6XA00q6kOiRDsnwU/SQXNeokrLeAtho=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tzWO+iba3EqDTKBkjoeY8Yun+hT0X8b4Her+32/CbXIxtMMch
 d1+KaBPtHUbulRs/nPv4mCUvG8t1+G9w5PF/bObtpCExA2M/YjfklmuE
X-Gm-Gg: AYBFou2M+kLtU3kVGNPH/Ut4fFdmqRcyRLOQL4zk0v/1WBYcS57O1e/L4dAM2FCnphZ
 2oZ7fUbdJMGueVZKlOZFr73mtf5aP2S6LiIsTIuP0ktRhHOp44mWIyYHiQLVSL0kbRvyD42Phy+
 T4/AOKpPH29OWYdxbXCXRlhn16LDjcy1SQHNdY0bTMz8nGWiAYBk35hi5yFugRsFqTMWRToSwPb
 52E7XgwpZzdTY3rK7Obs2HIjRpOa9MLeOWmW6WR3ACwJTp+QNuyuEVQlYvzgKxk3zqj/JUKp0qO
 UPp9L6YJ3oA3zMs5NeXKWjpLyuWjR2Fu1Lsq5NTFie1XbtxNfUoMJDFUrOy1ny0opEW6hx5Jwca
 kPlSsoFzaiu2+JytPBXAvF+akJKRXd5NudWtqdWDItGVfOM36w9hpAHHYYDumUeQu3bvV9HSM0l
 NZKmf9zArRqWOcSy4NtyQJ9ryXv7gEycbEQZ4/dQBFme6jN1V83mxmENMs+wCifycWzK7W7IYPG
 Lrdy5mmXKNLngF3Q0Gg6umiJPKexHqno7xkvGzUceHrr0T5402dHNFcXWsWTVveh9wuPjITZvf/
 6ObnYGTuJ31G8azY7xREmAJxfA==
X-Received: by 2002:a05:701a:c919:b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-1b39fe93a6cmr866284c88.16.1794115010609; 
 Sat, 07 Nov 2026 21:16:50 -0800 (PST)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d60absm2750989eec.26.2026.11.07.21.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:16:50 -0800 (PST)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 08 Nov 2026 14:16:24 +0900
Subject: [PATCH v2 2/6] drm/imagination: Stop locking reservations around
 map and unmap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-pvr-vm-bind-v2-2-730103d2cc9a@gmail.com>
References: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
In-Reply-To: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Matt Coster <opensource@mtcoster.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

The GPUVA lists are now protected by gpuva.lock instead of the
reservations, so map and unmap no longer need to lock the reservations.
Nothing else on that path relies on them.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 44 ------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index d551d9a4ab4..12ebf0daf88 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -10,7 +10,6 @@
 #include "pvr_rogue_fwif.h"
 #include "pvr_rogue_heap_config.h"
 
-#include <drm/drm_exec.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_print.h>
@@ -684,16 +683,6 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_file *pvr_file)
 	}
 }
 
-static int
-pvr_vm_lock_extra(struct drm_gpuvm_exec *vm_exec)
-{
-	struct pvr_vm_bind_op *bind_op = vm_exec->extra.priv;
-	struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
-
-	/* Acquire lock on the GEM object being mapped/unmapped. */
-	return drm_exec_lock_obj(&vm_exec->exec, gem_from_pvr_gem(pvr_obj));
-}
-
 /**
  * pvr_vm_map() - Map a section of physical memory into a section of
  * device-virtual memory.
@@ -721,15 +710,6 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	   u64 pvr_obj_offset, u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
-	struct drm_gpuvm_exec vm_exec = {
-		.vm = &vm_ctx->gpuvm_mgr,
-		.flags = DRM_EXEC_INTERRUPTIBLE_WAIT |
-			 DRM_EXEC_IGNORE_DUPLICATES,
-		.extra = {
-			.fn = pvr_vm_lock_extra,
-			.priv = &bind_op,
-		},
-	};
 
 	int err = pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
 					  pvr_obj_offset, device_addr,
@@ -741,15 +721,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	pvr_gem_object_get(pvr_obj);
 
 	mutex_lock(&vm_ctx->lock);
-	err = drm_gpuvm_exec_lock(&vm_exec);
-	if (err)
-		goto err_cleanup;
-
 	err = pvr_vm_bind_op_exec(&bind_op);
-
-	drm_gpuvm_exec_unlock(&vm_exec);
-
-err_cleanup:
 	mutex_unlock(&vm_ctx->lock);
 
 	pvr_vm_bind_op_fini(&bind_op);
@@ -782,15 +754,6 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
 			u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
-	struct drm_gpuvm_exec vm_exec = {
-		.vm = &vm_ctx->gpuvm_mgr,
-		.flags = DRM_EXEC_INTERRUPTIBLE_WAIT |
-			 DRM_EXEC_IGNORE_DUPLICATES,
-		.extra = {
-			.fn = pvr_vm_lock_extra,
-			.priv = &bind_op,
-		},
-	};
 
 	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, pvr_obj,
 					    device_addr, size);
@@ -799,15 +762,8 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
 
 	pvr_gem_object_get(pvr_obj);
 
-	err = drm_gpuvm_exec_lock(&vm_exec);
-	if (err)
-		goto err_cleanup;
-
 	err = pvr_vm_bind_op_exec(&bind_op);
 
-	drm_gpuvm_exec_unlock(&vm_exec);
-
-err_cleanup:
 	pvr_vm_bind_op_fini(&bind_op);
 
 	return err;

-- 
2.43.0

