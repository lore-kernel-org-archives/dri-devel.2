Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC4ACA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 09:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2E510E1B8;
	Sun, 11 Oct 2026 09:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QtaEi5zn";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F206F10E1B8
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 09:46:02 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2dd9cbb661bso7356005ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791711962; x=1792316762; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MZP+nJjW1ldXPLrJ2aA+g+89NLmL7+5znNakFjQ9T0o=;
 b=QtaEi5znR56u2FHZpxqUqCWLvCWdQ3sdO+oMJB1KFXWBobiDmBIH6gbKi5qo9x2UdL
 pdEeKeeKeJglWhQEnM1AvsZ1vHo/E6++MSCkInZS5G4YMz9XHG23kRplpETMDla0jQQh
 sxqmcV3ZyrT8QnjVq+d6ZhSG9ADYiIqE5+FF6xOAoeL2eJKxQqwN65PM8iBLZp1HcJCV
 fQvtu3M42QB0ug624H7r3X48YqBEFw174aPz6hFLAgIi9ubvXqfFhBdm79LF6zQRqQic
 xJAX8MBQfD+Z1tvFrglo8rPoKgdROxokZQlYBSqhA7olxMh8vaJiiSuWXWqoGanrqTG1
 fyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791711962; x=1792316762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MZP+nJjW1ldXPLrJ2aA+g+89NLmL7+5znNakFjQ9T0o=;
 b=IFSHPkY1C0SyLxS6xj65iBKvWTZcaS3J+zPqWBf/LEpOQNSzBoMcKONDFDTpCC+tn5
 Rg0CykQh4lbDLE4Zq8xqc3WFDIa8Liagjs9xE56UKxzC/gNF7rzLqXBS6r/4LsQUhiNa
 WLxucBt0QOHzOSrBGchAa5OcFjnhxrg991Z4fUxjrDxQVz/Um3RdiZkpPm7LEYTH/vZR
 AYJ1klB0X4w1bFsSiY78kbvnkhpxGvZNYaPKIoHzGGJXo7NUTwcmUcVWpgmsIY1BWSrs
 /9AGLgoTn+G0p5G6oIZ+biG5smsEi5sJr3ZKC0VcB3TA8xT1oEpA3CTMaQEPy1izVGPi
 qTfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwUCY54IRc0V2ssoZq9kHrDCDEhoIYqoJJXXGhIqliUnN18SKPjVF+S7YwItuHRWocHDnk1/bKM90=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKi62VPXWKmxjJy/rK1AQhgl1wM1eJL9XMYjgLybZNyn7u4DyP
 WCqA0BcLWx3WReLzG0dJYvPwheUWc4ajxSZaMnNrXGqgfT6tc2DvhUiO
X-Gm-Gg: AYBFou3TcLwkI5AxVO362pDNltzkavAJq3x2cjkl8fT2sUgpg1MSLTcXC09ORU10Qne
 jEyWnIFxDtGTXLIY1H8Oz2d0rEEMsYKXrtGJvm6GGsG+SG6qF5SPQ32Vo0SKVKfHf10DLfR4zT3
 MBeb+dmsTC9GFbDRBrF4lTwEBPYNJGB5ZZ9NVz4jsv1/o3GkLK4z6FozPg0dnV9eiSILF9YHJxu
 tCMNkDeA95F5ynhcNW1t32Pnjdy1uODWBiKUk9J9uCpxUIOdJFff2Osx18qaYnsTS/oulaH567S
 zloY2DwYBet2C0La76uiDCmvMmlas2xbkcvZBqbQK6wGrNuORb4MIx7VQhkVuec6vkBjH4p5GbQ
 gwVEWDrYSvkJlnzvEQ1IsalG23N0qOQM/e/LywzsbCOCMal80VS++amQfmH9jhMXj7vToW3Op+J
 x+Ayy8mhegcgZhSRq+OW2I1nkx3zUv614ILmMpninEmOoflIpiUHwMCH1Qx7jvZ8SOz6A=
X-Received: by 2002:a17:902:cec2:b0:2e6:1715:e48d with SMTP id
 d9443c01a7336-2e842ac8863mr65438955ad.35.1791711962471; 
 Sun, 11 Oct 2026 02:46:02 -0700 (PDT)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422ba80asm31067695ad.63.2026.10.11.02.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 02:46:02 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 11 Oct 2026 18:45:33 +0900
Subject: [PATCH v2 2/2] drm/imagination: Stop locking reservations around
 map and unmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-pvr-gpuvm-immediate-v2-2-744ddc6644c3@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
In-Reply-To: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Frank Binns <frank.binns@imgtec.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

The GPUVA lists are now protected by gpuva.lock instead of the
reservations, so map and unmap no longer need to lock the reservations.
Nothing else on that path relies on them.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 43 ------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 807a01aab1d..08ce6542550 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -704,16 +704,6 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_file *pvr_file)
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
@@ -741,15 +731,6 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
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
@@ -761,15 +742,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
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
@@ -802,15 +775,6 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
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
@@ -819,15 +783,8 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
 
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

