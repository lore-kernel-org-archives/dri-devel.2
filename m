Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABC606B724
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UH6wTmRl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731D710EA94;
	Thu, 12 Nov 2026 08:48:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966A810EB5D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 509BC42ABB;
 Thu, 12 Nov 2026 08:48:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473316;
 b=ZuElMlGi4JgWvDu8OmUocCMhmJXKHTPzHV9ADF1SoDpbgEl6+0QXZIbic7SopF8JVxyd
 5jrpw7KDKwFTctdvtLfc1pVqPn+IWRDBPSoWSYC2Qnfhbwt1slZro6p2DX8Kg1O0mpWuV
 D70IB8VcYCpHf6N7adoPotCLHFUTHT1Nq0BF1Zw+mb00t46tiFXHWEGjkTEcBYw8qS33m
 GO85K8YiB3clYCGuN0nTzunQFsNLDxztX5kX23I/fV02RXPuY8gyYzXXWZNI/C1i+Epuq
 ZGjJMVMhL4pyMSF7qnNOVoLK33bRadZuBhSjGMqGvOXDiQnnV+wCRAibz/NJ9r+khmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473316;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=6R/zhoa8svTG09lSjgTlGyW8oNktUFJ95AqUC1MGVe0=;
 b=CojiEI4oeTs4jhosdqk5ZDJkycWFhpzfJLYkMd7LESLTJpln/FhzV7Ec99TZHvEQzdaI
 YithewkH9A6r59nMiFvgZWatTAhu7v06TI01pXK7yHQXKGme5m4J9gTLICjqLw/Mz+g9f
 bQKutt8CrEb4JlyeO6Nzul+TwvTGKUdKhOHhmGbH5xdO7wtyerfHiXPOim2o+c4sLUEK+
 TG5WUcsacj6xAdShsAV2WGSAJL+dWXrjy4vza1796mp/cqhdkuxKMeLHgyt8Xp3elE6uf
 f/oA6EOdXC5s3sAVnCG5iW3nONv/+tAz7AsCQW0E87KHjM56WwHzb5jzy+eEUjsSmDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9D1F51F00A07;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473316;
 bh=6R/zhoa8svTG09lSjgTlGyW8oNktUFJ95AqUC1MGVe0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=UH6wTmRlx2e664IN0rDmGIivG4ZXZ5ulNBfLSgg2JIqXJUi1UNe4jHIzlYIPFVWv1
 SoSQXOnlausBeEyKsXoTOnQ5sUFUnSFLzFQF9m0pB+0/kZ3EH0drvCSDrK6I52kt7k
 VV7EfWhjkDQBObVyDiCCsqCPznycLdNCiNawdJJkzLhJfhGLENcL51yGTBSYB0IqFV
 a/RSpDIh9FjVMIxtgWVr8bP21Qxq0szvt85LlZQ0W+Sma+3YXWiQiS/7XsZNKNwhM4
 bxcthtQEt+XVmxL2OQlQYqNOXfEivgOZ/4+zfE+hpuFWB4W2Xt97y30qXWjnHt+pGW
 rkaAUy0DOZS8Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2A7B2493E1;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:35 +0000
Subject: [PATCH v2 02/11] drm/panfrost: Refuse to sync the CPU caches of a
 heap BO
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-2-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
In-Reply-To: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=2148;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=sabqZXiqcOVlHYAJg0avzqnHVWyyC8nVoD/l1btGZFM=;
 b=EZaFwvzELyUZIeDpHLBigkeb0f38sxfR+QENoZ2o+SujrdnYH8BpvXs9ae9t/9l/ldZOF276x
 YSfTG2G0puWDNT6nGnOkBYQFT6SpvtrNj4eOEBTq5fOfdol2A12jwoK
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

panfrost_gem_sync() calls drm_gem_shmem_get_pages_sgt() on any BO that is
not write-combined. Heap BOs are write-combined only on non-coherent
GPUs; on a coherent one, a PANFROST_SYNC_BO on a heap BO reaches
drm_gem_shmem_get_pages_sgt() with bo->base.pages being the sparse page
array of the GPU fault handler, and drm_prime_pages_to_sg() dereferences
the NULL entries of the chunks not faulted in yet. On a heap BO with no
chunk faulted in yet, it instead pins the whole heap and leaves
bo->base.pages set without bo->sgts, and the next GPU fault on the heap
dereferences the NULL bo->sgts.

Heap BOs are not CPU-mappable (panfrost_ioctl_mmap_bo() refuses them, and
panfrost_gem_create() refuses PANFROST_BO_WB_MMAP for them), so there is
nothing to sync: return -EINVAL, as for imported BOs.

Found by code review (Sashiko). Not tested on a coherent GPU: the
Mali-G31 here is not coherent, so a heap BO is write-combined and the
sync returned early before.

Fixes: 7be45f548976 ("drm/panfrost: Add a PANFROST_SYNC_BO ioctl")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206561@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 518f24549..5d3925abd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -569,6 +569,14 @@ panfrost_gem_sync(struct drm_gem_object *obj, u32 type, u32 offset, u32 size)
 	if (drm_gem_is_imported(&shmem->base))
 		return -EINVAL;
 
+	/* Heap BOs are not CPU-mappable, and their pages are populated by the
+	 * GPU fault handler, one 2 MB chunk at a time, with a page array and
+	 * sg tables of its own: drm_gem_shmem_get_pages_sgt() must not touch
+	 * them.
+	 */
+	if (bo->is_heap)
+		return -EINVAL;
+
 	switch (type) {
 	case PANFROST_BO_SYNC_CPU_CACHE_FLUSH:
 	case PANFROST_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE:

-- 
2.55.0


