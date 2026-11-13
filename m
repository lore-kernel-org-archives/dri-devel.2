Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F5606A884
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQg2RE/5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78E1112359;
	Fri, 13 Nov 2026 09:03:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D154110FF8A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:02:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46E3C6262C;
 Fri, 13 Nov 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560575;
 b=bU44JCbgpGNr5kptcCrL7jN8Hbm3Hgtzi0VNMUO4nqv+Q/vhXz405vykIdq5+0NsCMMB
 9BU3SpnqCILyCwJRlRYQV0nA3S/GHC8Vdh/yQIqSgQp3IKVaifsH7xePaluwL8gwq+sHc
 SFXd1hHD2MKyxoFdxbfKdOD9Zh3VhjQklgs1w08k4AhVtooGcZYaxLuxrV+etdGX8qqnl
 I1iuscE//WMU2uuvmEKzM3NsJgkbFUb/buoI0k13mZ+6d/ZYG798CDbjhNkvA4ZXIyvr8
 KQwSheaVhFQClVjdya4E2SmNEFAvU3JNpjxXcMz8J/95GPwP6SThxZ97ZPX8FX9rOPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560575;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9M9RlTgE91KmgxF0Tdaf4kzxGtvrObMNHXbTphs0Acc=;
 b=UNdmZCD1ujGUrcYb+LC07GLoOp+GP/MF9+CstBLBhK3yFOWeXJko5W85abtwx4hRhZi5
 v526SbxuIB96loaMThy71DxVuWtd2yJgH67PAyhCUsixZQk0s0xJaIc0tsEM+Ybjro0uY
 Rl8Epfh3/LGYC87NfclGEMFbQHDvjYgcjxEzOYP5hMAIjFppqC0umkTwaoLsuKbI3a58B
 XUPL+yfzN8JYyC8kt7sah7DteDelzwGgGtoxmOWq8ZmzvUxu/wFPPC7x1vrY/ejvW+eMg
 4RLpszKNvCEcgsSs7gcIU9i1EJwwLSjEmRMfgExJ2lmbeHm6aRbI1dUidsGZOIV9qLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 673F31F000C6;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560574;
 bh=9M9RlTgE91KmgxF0Tdaf4kzxGtvrObMNHXbTphs0Acc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fQg2RE/5VHmJ8fz2QR+YDGKrrOOTu0P9fzUJTRIwWTztuYozReaQIve45usIVDvQ0
 jcWEy9VHULBpDayVwLx5ZQgdwJhU5W+rrXPT+8BjC3DIBcp1zRCuytowLypWDC5tvF
 IkpknTvZzVzjsVYFbXWSFzmyrgVQFwSYMvzIiqocD/qUum9iL3TmOePDXixNcvU32x
 VShQn0q2fzEaxDe19rA/asyxEuqPpCEteBpzftgbpxjS9rKgKbnQQ6asw71RVQk2KK
 AiTwKu3M3F6pUJLMrPq/PHBmBEJ/ILU/Jk++0Pb+sUPoBMfCyeeuv04WxnAeuqpvKu
 h2rdziGTwdU+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E8948476DA;
 Fri, 13 Nov 2026 09:02:53 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:02:54 +0000
Subject: [PATCH v3 02/14] drm/panfrost: Refuse to sync the CPU caches of a
 heap BO
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-2-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
In-Reply-To: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=1768;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=HrsdWKsSgiGXkqlebjInUOvLazjeFD30/bAvYhzVDVs=;
 b=dlCqTBSrojRZUFzJOLlMFkRPGOmIXJ0x6/dG8G1sDEWPKbDF/4+G3xB2st9BIgmevHkEzr5mS
 X68MKJzh15XBSVEagT7ngMK9XkSkW+FOGCdhTwn/r1qy97NxP/J3Wce
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

On a coherent GPU a heap BO is not write-combined, so PANFROST_SYNC_BO
on it reaches drm_gem_shmem_get_pages_sgt() with bo->base.pages being
the fault handler's sparse page array, and drm_prime_pages_to_sg()
dereferences the NULL entries of the chunks not faulted in yet. With no
chunk faulted in, it pins the whole heap and sets bo->base.pages without
bo->sgts, which the next GPU fault on the heap dereferences.

Heap BOs are not CPU-mappable (panfrost_ioctl_mmap_bo() refuses them,
panfrost_gem_create() refuses PANFROST_BO_WB_MMAP for them), so there is
nothing to sync: return -EINVAL, as for imported BOs.

Found by code review (Sashiko). Not tested on a coherent GPU: on the
Mali-G31 here a heap BO is write-combined and the sync returned early.

Fixes: 7be45f548976 ("drm/panfrost: Add a PANFROST_SYNC_BO ioctl")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206561@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 518f24549..f72edb65b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -569,6 +569,10 @@ panfrost_gem_sync(struct drm_gem_object *obj, u32 type, u32 offset, u32 size)
 	if (drm_gem_is_imported(&shmem->base))
 		return -EINVAL;
 
+	/* A heap BO's pages and sg tables belong to the GPU fault handler. */
+	if (bo->is_heap)
+		return -EINVAL;
+
 	switch (type) {
 	case PANFROST_BO_SYNC_CPU_CACHE_FLUSH:
 	case PANFROST_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE:

-- 
2.55.0


