Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CBCCA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD5E10E26A;
	Sat, 10 Oct 2026 17:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P9MTqXCc";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B007510E27A
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:22:43 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-887beafb714so284170b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791652963; x=1792257763; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kF+TnaMTCyaX+72q/YGqtBO7N1GkJDdibqP7n7gt2pE=;
 b=P9MTqXCc84TI7fS8K97Tp0ulfb9A9IzbwB6XiuW4HudvQvRwlSRQDvXH1d8SCKbum+
 PtCSO0PQ1NMGxaRPCGoc2rG4z630wOWWS6YdgdrvPMhLMToE33OodKqudg+w29N2zpOR
 bSgpnfwlfAb3KZTxOLLfWEKjJOSnSsqQldCtfAHgunIoJrKv3Fn2a9r4xNpQ4CCx3NFj
 phQwj03r2nUxswjpTGlahn4aFxxCoHe7SkKfYzQIF81Ujy1L3nlCC1cJOz4kWQCiSKR3
 uORpGUmDzDWOkKwgAXAz+Dhzb0ilXcq8OoS2gvU6tiUbOSKnTNZPG28a/+tko3FxYPjU
 dzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791652963; x=1792257763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kF+TnaMTCyaX+72q/YGqtBO7N1GkJDdibqP7n7gt2pE=;
 b=IqmBqpp3depde7w02+Reqt5uK8fm1eFKXIEvVJze6JNKqjUIeQVCmS6tqL+aUlnDHV
 ao9TLaydm4g+trqD6zoKQ40jG4JNgGm3qZrs5SDysYH5ZDj/NQAT+j8dRHHxc60vmfQB
 mv5mUKUiacK+M2ZqRQGde0p2o+ZCB2aKKBeciweQfDACjyFdW+5i8AQmAbf6D6hgx5fn
 QkzZ180M3DFykKa2k3801byLMaUbRKdVnE3vb4kxCPaibqzPUNTArnwGqgLoQVjVXZYn
 3jfjUiz1/zb4jYxmfx6YcXiP3+jKNEWE7fxDrASqaE4TL0jmhjQQtt9y6tCh+4TOUhi4
 atSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9cwMReOlau7uDXnJOEJOUA0TgTRpqzW2YJrl7cozU+jAAUg08wju4QsCmQdp1kfLksnD6v+lO/50=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYII7usRxMtn9ynmmPX4PqvhW5ascSqThf/IoNTe18MTc6I3A7k+
 JWTfOF3zwyEILE+HlGAVdFTmKRva0R12nq4ikUcN6KvW/1CFPWbzslwk
X-Gm-Gg: AYBFou1B0siUKKkuxEH4Rb6Tzk0Ah9so3kAMKTdhaBIJpKqzJGatn7Jf3+uYH+PaCd8
 Hpk87gT3G9uEp8C43/zIWKFrldwJDkommhH/DdlTjuzQVnYkw7M+Iy1S05QLK7J89LGaoxX659g
 rPTV6WjUSA7pGEphcDNqWYV0pNoeGbhWgVMpS+4hXl+mCDVr3aPtcNbvb0M1KXVX11rHaShd38k
 ALhOWh3pWMIaDxVKtbfiH8ZhYacQRoURcoTWlLOX28wNDqqdE8t43tWGVAtdtEgq+hICGAk5drD
 WeAM19vte0EfaJ4gt0fpDM65kGdYdZmpJPuDpK8M0eu6FwD+k2E+EbYz1RmFtlA3zmve6rzFVui
 zk6UK3l1hXnywO+Zxeeh43ydm5LRMotilwKbPYKKrHCAAAuTDneVVODjc69IMF+v2mBm6uWnyb0
 IUH3yTMCHjclOtHk8TGf+zv1PNH5oRZm+cejyfP/6jl8Ttia6QaR5fz8ktasUShgpy/IM=
X-Received: by 2002:a05:6a00:9296:b0:88d:20ff:15c1 with SMTP id
 d2e1a72fcca58-897c65413femr4705684b3a.18.1791652963096; 
 Sat, 10 Oct 2026 10:22:43 -0700 (PDT)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-898802de7d6sm1510213b3a.23.2026.10.10.10.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 10:22:42 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 11 Oct 2026 02:22:21 +0900
Subject: [PATCH 2/2] drm/imagination: Stop locking reservations around map
 and unmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-pvr-gpuvm-immediate-v1-2-5b298dfce4f8@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com>
In-Reply-To: <20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Frank Binns <frank.binns@imgtec.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, imagination@lists.freedesktop.org, 
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
index 3921b765688..2f1bbcfdb60 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -702,16 +702,6 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_file *pvr_file)
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
@@ -739,15 +729,6 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
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
@@ -759,15 +740,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
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
@@ -800,15 +773,6 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
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
@@ -817,15 +781,8 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
 
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

