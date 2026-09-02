Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1EBC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60F010F3FA;
	Thu,  3 Sep 2026 07:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbe51pbd";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5748510EF76
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 01:27:27 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-85c9a79590aso601239b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 18:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788312447; x=1788917247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e5O92yk8UhYFXMSpdx81mnV2Y01T+eEkYBzZoAbcWuA=;
 b=nbe51pbdJFYt6EtZ6nA3wmeYRAuvR4YmAaM2D8EeQyF+aeJfYF324PzxkUNHW/jKHI
 CHGYhRdIgw+zkiI4R82it2MHbJox8CALZKtGc0w1rBUikPbW0qdwq5rWEaSYD4Yik5is
 JeK8QaMsLG1WzTy8R+kn5Z5n95rn3xFc7WTpTLil36eNRgE5TfO6frcC7dNgMHwlzoWP
 i1boHV9R69CrRLnlZQQCiXYiDFVaNGfa4OA5dynXTPjFTuCCpjy3fqKlFYicy1nnb+Ik
 zUi35DYtMIlmu/MHdwm+vzRKIjaObIeMMKxeAxK9XMYSJnf4OZoL9mZtgAv0qHhmfwIx
 taIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788312447; x=1788917247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e5O92yk8UhYFXMSpdx81mnV2Y01T+eEkYBzZoAbcWuA=;
 b=KoCufH+jNegJMZ8zPLSXJU0/nMlh38B32snXM9myd2pebrJ8qvcIO7QHa5eaXSWUd5
 ioOJ6bPfUfZlC0nuawtNHJsG7K95UIe/aBEbdHkkLkCxoSB48lzPJzE44ZbilnYb7xK9
 fwlDxGgSy7emr4TCHBLoC9aYeDcWvNE9tamGWbG40E/dfPh22kIZextN3+iH+XBLVcy4
 wXkmfFsC0JiZ14XtRY6qfZJiz5C92P9tF9iJeJP+WR1isQMB3/GAmWGewd+m1xRB7yBE
 ei9ik9LOFHdSl5jY0yCzMODyn5ugpBbbOs1tpUszgapugBZPeXBTmfoggpfcvvlBvShT
 sbkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXj7ufYrIT6kq4o9pLp9tgsghb3d/HyphK4LUJG6TX12fsLXYux9R+gGg9+o3hdiW0S/B+eLGCsgk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nIMT3xBiv5NI4H/aPs/mGDVPiUdBJal4ZsATSTPDRM8wntvP9B
 zLPJ995SJgk1cVkjn4IWxjuMH5lTRMXi4ymMibvHo9NHyHmZQTaAqck=
X-Gm-Gg: AYBFou2U2ETxf31Lm2FHhOFWCAT4z6bgwdH0i5mRVtHPzr4SrEqe9YeXGyjmXvSPUQb
 QrE+g6Lz3disX6ClYJYdaZhl9Yaqb4n2nLkmaEJAir3YLcTzCwiKru0zbP0T9IiRAXXBepxOIK1
 dTq27Y2C1TYToAqYViK91v7XFYRJonuS6AuKdCRVlc4nCarFImZkTjAximB+RPWMULeEkSeQ9OP
 F54tIYi0j0DwuNyxd8lG7r1JCC5j7VCSuHkMzt9vz+G1g0WcMqvqY+ha7vnt7+rwJWkpEkiwnOt
 JBuwpc4vkdRilhsWQXFr8ygFF72vrQwsrozgNWGsB7bo5pX/uTq+Q/f6Z5gVg4D/ISt+RXCMMmW
 EqrEt4Wwg6vLGpKN/HzP+64vWSLwZ/8wgP+qBXClN7F9UVnEozjIeaw1mxLanPRA2j45ddefaUe
 7tdHXp6X7EyH7XS5IJGZOP1Db0s6blqCIvPzqJVLjaNE5hx4a3CEq/PsvOKRge3+sptkuiDpa+0
 YqqY+B6pvPmiPBNJJzWdrCdBg==
X-Received: by 2002:a05:6a00:3c8d:b0:853:5152:a3e9 with SMTP id
 d2e1a72fcca58-85ed8023e20mr2355505b3a.11.1788312446696; 
 Tue, 01 Sep 2026 18:27:26 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db2bd6de7sm560259b3a.23.2026.09.01.18.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 18:27:26 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/msm: RCU-free the scheduler-containing ring and VM objects
Date: Wed,  2 Sep 2026 10:27:20 +0900
Message-ID: <20260902012720.880783-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Both struct msm_ringbuffer and struct msm_gem_vm embed a struct
drm_gpu_scheduler.  msm_ringbuffer_destroy() and the VM free callback
msm_gem_vm_free() call drm_sched_fini() on the embedded scheduler and then
free the containing object with plain kfree().

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
scheduler fence keeps a .release callback so it is not ops-detached on
signalling.  A finished fence exported to userspace (the submit out-fence, or
a VM_BIND fence, via sync_file / drm_syncobj) keeps pointing at the embedded
scheduler after the ring/VM is freed, so a later get_timeline_name() --
reachable unprivileged through SYNC_IOC_FILE_INFO -- dereferences freed slab
memory (KASAN slab-use-after-free read).

Per the dma-fence lifetime contract the exporter must keep the data backing a
signalled fence alive for an RCU grace period.  Free the scheduler-containing
objects with kfree_rcu() instead of kfree().

Fixes: 1d8a5ca436ee ("drm/msm: Conversion to drm scheduler")
Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.h        | 3 +++
 drivers/gpu/drm/msm/msm_gem_vma.c    | 2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c | 2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 762e546d25ef..43a938e8f288 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -68,6 +68,9 @@ struct msm_gem_vm {
 	/** @base: Inherit from drm_gpuvm. */
 	struct drm_gpuvm base;
 
+	/** @rcu: RCU-delayed free so an exported sched fence->sched stays valid. */
+	struct rcu_head rcu;
+
 	/**
 	 * @sched: Scheduler used for asynchronous VM_BIND request.
 	 *
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3ed05ab0eeef..a427e9b331ac 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -166,7 +166,7 @@ msm_gem_vm_free(struct drm_gpuvm *gpuvm)
 	dma_fence_put(vm->last_fence);
 	put_pid(vm->pid);
 	kfree(vm->log);
-	kfree(vm);
+	kfree_rcu(vm, rcu);
 }
 
 /**
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 0d14c31bd4e4..a11c25fb4608 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -138,5 +138,5 @@ void msm_ringbuffer_destroy(struct msm_ringbuffer *ring)
 
 	msm_gem_kernel_put(ring->bo, ring->gpu->vm);
 
-	kfree(ring);
+	kfree_rcu(ring, rcu);
 }
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 28ca8c9f7463..05206f523eba 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -55,6 +55,7 @@ struct msm_ringbuffer {
 	/*
 	 * The job scheduler for this ring.
 	 */
+	struct rcu_head rcu;
 	struct drm_gpu_scheduler sched;
 
 	/*
