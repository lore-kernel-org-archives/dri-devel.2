Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71656606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BF630q41
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA8B10FCBC;
	Wed, 18 Nov 2026 13:46:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C3710FCB8;
 Wed, 18 Nov 2026 13:46:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 296EA43C4C;
 Wed, 18 Nov 2026 13:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CE41F000C4;
 Wed, 18 Nov 2026 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795009564;
 bh=pPXr6ZCubONThIoJKyV+i68TlUC5jfmFsiJb4vkRMA4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BF630q41fDa0YTryLkmikWFt8M8IFNVoUeiLZYloRM6NAJ3Pn5aNB+eNloqvaSTSD
 LQEdO8aC8IUEJ/VmNAArMxv688r95lZa0iRbq3jwpwnvovy3vM7Jc7eAlXtRIlJCFq
 rkpYDcTPCzc2hUQL33mpsZx5kmYtKzWUuuu8ODyqQJ2MuUspad+nr94OAb8ZGk5ivp
 GaV3+Hp/MxM1E4Vj+W7nLqapxJ0/69KoAXXq+93yVeoqBmIuaWTbLGZCo0JcB7HE+a
 /K0s3iM91e/rMBeJJ86bgZUDHMWI7j/UA0wkRT01IYBZyoTKnNsJLfK5FLv5ci2jG4
 BMqkf3rqFznVQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 David Rosca <david.rosca@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.or
Subject: [PATCH v2 2/3] dma-buf: Port users of dma_fence_init64()
Date: Wed, 18 Nov 2026 14:45:22 +0100
Message-ID: <20261118134522.1646892-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118134522.1646892-2-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_fence_init() now natively allows for selecting 64-bit seqno support.
Port all users of dma_fence_init64() to this unified method.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-chain.c                  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   | 5 +++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a588f55ea4d3..7d1495235577 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -261,8 +261,8 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 			seqno = max(prev->seqno, seqno);
 	}
 
-	dma_fence_init64(&chain->base, &dma_fence_chain_ops, NULL,
-			 context, seqno);
+	dma_fence_init(&chain->base, &dma_fence_chain_ops, NULL,
+		       context, seqno, BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/*
 	 * dma_fence_chain_enable_signaling() is invoked while holding
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..2924f34da316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -133,9 +133,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	ev_fence->evf_mgr = evf_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
 	spin_lock_init(&ev_fence->lock);
-	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
-			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
-			 atomic_inc_return(&evf_mgr->ev_fence_seq));
+	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
+		       &ev_fence->lock, evf_mgr->ev_fence_ctx,
+		       atomic_inc_return(&evf_mgr->ev_fence_seq),
+		       BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/* Remember it for newly added BOs */
 	dma_fence_put(evf_mgr->ev_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b7cebe392108..ac66b831daf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -274,8 +274,9 @@ static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
 	bool signaled = false;
 
 	spin_lock_init(&fence->lock);
-	dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
-			 fence_drv->context, seq);
+	dma_fence_init(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
+		       fence_drv->context, seq,
+		       BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/* Make sure the fence is visible to the hang detect worker */
 	dma_fence_put(userq->last_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index b0002c898386..f8cc258dcdef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -100,8 +100,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
 	spin_lock_init(&f->lock);
 
-	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
-			 vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
+	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
+		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq),
+		       BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
 
 	/* TODO: We probably need a separate wq here */
 	dma_fence_get(&f->base);
-- 
2.56.0

