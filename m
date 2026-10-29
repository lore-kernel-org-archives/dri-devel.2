Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85946606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMwkC4rb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F317611217E;
	Thu, 29 Oct 2026 10:00:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8A111215D;
 Thu, 29 Oct 2026 09:59:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6594E400F0;
 Thu, 29 Oct 2026 09:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E541F01829;
 Thu, 29 Oct 2026 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793267997;
 bh=BlR02fcSQh6d0JDhMlZWs6ZOUTC1ug5V4gj89nHdCiw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mMwkC4rbYBZKFHoDULMbOUQTiMIeewFQtew5dxFsygorpCCeQP4W1KfdBtKUNgajP
 FQFHnnpxd/k95t50EJyK0qUoUn8hQUb1P7XqFVBZgnu1mZvr/7WIx9nJ6fp6tO6VEi
 XRL8rU1K5ZUOO3EVruDcvEc2vSW/tt7XE/0njpvmEiG1DdePcgXoXTKo9vL+kINANO
 Hj8Fz75BHePb3t5otXkRaXAsHnMm/qRPQT8x+z4Y63witomkrevSCxQsCAUXoeHwW+
 GTgsVuFIXws3fjsY28HpPEsvEV3VmuhFwTCfl/OcYb3+t+MIjqkaVu55NBl0J/rdU3
 8ZcwP03x8rDFg==
From: Philipp Stanner <phasta@kernel.org>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Qiang Yu <yuq825@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sunil Khatri <sunil.khatri@amd.com>, Kees Cook <kees@kernel.org>,
 Jesse Zhang <jesse.zhang@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Prike Liang <Prike.Liang@amd.com>,
 David Rosca <david.rosca@amd.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Shixiong Ou <oushixiong@kylinos.cn>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Neill Kapron <nkapron@google.com>,
 Michael Bommarito <michael.bommarito@gmail.com>, Sam Day <me@samcday.com>,
 Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: [RFC PATCH 4/6] dma-buf: dma-fence: remove dma_fence_init64()
Date: Thu, 29 Oct 2026 10:55:41 +0100
Message-ID: <20261029095542.1526750-7-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029095542.1526750-3-phasta@kernel.org>
References: <20261029095542.1526750-3-phasta@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All users of dma_fence_init64() have been removed. They now use the
respective initialization flag in dma_fence_init().

Remove dma_fence_init64().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 27 ---------------------------
 include/linux/dma-fence.h   |  2 --
 2 files changed, 29 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index b11ee52a40d8..f7c084926ae6 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1124,33 +1124,6 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 }
 EXPORT_SYMBOL(dma_fence_init);
 
-/**
- * dma_fence_init64 - Initialize a custom fence with 64-bit seqno support.
- * @fence: the fence to initialize
- * @ops: the dma_fence_ops for operations on this fence
- * @lock: optional irqsafe spinlock to use for locking this fence
- * @context: the execution context this fence is run on
- * @seqno: a linear increasing sequence number for this context
- *
- * Initializes an allocated fence, the caller doesn't have to keep its
- * refcount after committing with this fence, but it will need to hold a
- * refcount again if &dma_fence_ops.enable_signaling gets called.
- *
- * Context and seqno are used for easy comparison between fences, allowing
- * to check which fence is later by simply using dma_fence_later().
- *
- * New users MUST NOT use external locks. Check the documentation in
- * dma_fence_init() to understand the motives behind the legacy use cases.
- */
-void
-dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
-		 spinlock_t *lock, u64 context, u64 seqno)
-{
-	__dma_fence_init(fence, ops, lock, context, seqno,
-			 BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
-}
-EXPORT_SYMBOL(dma_fence_init64);
-
 /**
  * dma_fence_driver_name - Access the driver name
  * @fence: the fence to query
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 6654bcc2441f..52e7ddfd2d06 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -300,8 +300,6 @@ struct dma_fence_ops {
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 		    spinlock_t *lock, u64 context, u64 seqno,
 		    unsigned long flags);
-void dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
-		      spinlock_t *lock, u64 context, u64 seqno);
 void dma_fence_release(struct kref *kref);
 void dma_fence_free(struct dma_fence *fence);
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
-- 
2.56.0

