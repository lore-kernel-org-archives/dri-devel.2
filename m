Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC9606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RReaqhn3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CDF10F839;
	Tue, 27 Oct 2026 21:18:12 +0000 (UTC)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B563D10E4B0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:50 +0000 (UTC)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso236754a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135870; x=1793740670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lgbyT6PeI2khIu3G1MvqRPb/iNuJirnyDT1hctA+7wQ=;
 b=q8gYmcROEiFZusZBauYFiWw4zajb9cDTAB8JMdSGXzGINFuqacBiD9BmdSD0FW9gAA
 HWmX2p2tEkeMRn/fppqSv3ywvwjpQV12wDJ+BXCyInSwejdOeR1XUgStBAZ6BadIuD1J
 8cNmBhbc4alErwf8EQzm969N+u8zwtRikoXwv2P7lcDRm+IMHHpE/KDtn2LqWLPU+rXN
 j8qAeny2MpxCI2ul9xO6zZWmW7IquEMCQUhJfSN8jra8qk6F6MxSQeY4J3/u9t8dou2X
 htSQRjIdALEX1TVgACgUB8WLIZvFGgA76QbgTAq7gDH0jakPW2jQUSY35+lKw1mO6IHl
 7AcA==
X-Gm-Message-State: AFq9FYLmTHTVIftMvGf8v+XOuIgt7TdgH3RIBiXyY9CwRE1n3BztMqGq
 gKWgVZpjC+CP1HS6o4CGxOWE2ZKpmuRn9Y+P5GomrwX5sJSRoB4eSpO0XRC4SR+w+Lv/c0qnL5F
 7HRPp34VmChahN/3YCDzY5zW6gY773CtvGOJr62+2vADkkhT9gBJHsulgtrf4LFq9qlxGirrzTK
 rrwA7uY/7qa/WkEiXxhqGlJjXGgQvPe8yBMAe0W7oY4LYMx3PACTbYXi8toGMJcCDX+HnPDhDz9
 apLEI6Wu32R1B5Ul0o6
X-Gm-Gg: AYBFou15Mzcg0p9NAF+vrY9whAN7450qGHsTa5T1bPsLxx8Gq///8uYWzHWQCouFmyV
 WIbP/kxp9mrsj8edMDx8oDcYibVXVZB/C/1v6UwIXB4xsiJ9TYs8E6f+hv/qiV+p/77vQrjTh9/
 ST8/5js2M6JszwGkIG5+Iioxp6zP+AqwuB3/BwpCmXddv4iyGBxWfs0O5C7/VVZKbO4yzaqk8cj
 VnSAaes0ozURgPbB7UD71fSc2myhaHp42kFNBEk3zd1eURjKMzXqj/r/J04sBnmummqiGFCWTxc
 5L+X+yuLwFloEsEP/WFh/oLmpR1TcthMBCqZX4QQ3/0SBKgWrJVAeO8H30DQMW1uIs6Me8SzgNS
 9DDsVSR5sttqmfAp+OOP1KIySG8uk9H3YVAtLwRHSHJjkmtVTJzGQ4TyFFiPhebFrgCogs7BKpH
 Crezfm6KAZC7do3oCLzXa/J70J/ZbVy5NvTMg=
X-Received: by 2002:a17:90a:e70e:b0:3ac:a491:3cf8 with SMTP id
 98e67ed59e1d1-3ae581b572fmr204060a91.43.1793135870167; 
 Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae5a3dd6edsm5546a91.7.2026.10.27.14.17.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso644478eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135868; x=1793740668;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lgbyT6PeI2khIu3G1MvqRPb/iNuJirnyDT1hctA+7wQ=;
 b=RReaqhn3g/IYKGF51kHP9rax8XORlFdZTy6bQpErYobyyGOWU1Nm4+j80JvxEHxgdZ
 O5U1G5WQIBMUEU0PgV0U5EDi4PF87gfCXddDgCcB4+DU3pNYEQEsRAlSQYb8M/16kRSJ
 LXy6LVDP0oyEI7e3zIIbotiR5iSK/ooqysL48=
X-Received: by 2002:a05:693c:41d7:20b0:367:3d68:8480 with SMTP id
 5a478bee46e88-36a20115c41mr798419eec.0.1793135868086; 
 Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
X-Received: by 2002:a05:693c:41d7:20b0:367:3d68:8480 with SMTP id
 5a478bee46e88-36a20115c41mr798388eec.0.1793135867298; 
 Tue, 27 Oct 2026 14:17:47 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:46 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 4/6] drm/vmwgfx: reserve dumb buffers while detaching their
 surfaces
Date: Tue, 27 Oct 2026 17:17:27 -0400
Message-ID: <20261027211729.646988-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmw_bo_free() detaches the surface associated with a dumb buffer and
clears its guest memory binding. It reserves the resource, but does not
hold the buffer reservation required by vmw_resource_mob_detach(). TTM
releases that reservation before invoking the buffer destructor.

KMS clients destroying dumb buffers can therefore trigger the reservation
assertion from vmw_resource_mob_detach(). GNOME reaches this path through
DRM_IOCTL_MODE_DESTROY_DUMB during cursor and display updates.

Reacquire the buffer reservation while detaching the surface and clearing
its dirty tracking and guest memory binding. Acquire it after
cmdbuf_mutex, following the command validation lock order, and release it
before releasing the resource and GEM object.

Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b0dc..a6d7156e4281 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -55,6 +55,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 			/* Reserve and switch the backing mob. */
 			mutex_lock(&res->dev_priv->cmdbuf_mutex);
 			(void)vmw_resource_reserve(res, false, true);
+			/* TTM drops the reservation before calling the destructor. */
+			dma_resv_lock(bo->base.resv, NULL);
 			vmw_resource_mob_detach(res);
 			if (res->dirty)
 				res->func->dirty_free(res);
@@ -62,6 +64,7 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 				vmw_bo_dirty_release(res->guest_memory_bo);
 			res->guest_memory_bo = NULL;
 			res->guest_memory_offset = 0;
+			dma_resv_unlock(bo->base.resv);
 			vmw_resource_unreserve(res, true, false, false, NULL,
 					       0);
 			mutex_unlock(&res->dev_priv->cmdbuf_mutex);
-- 
2.53.0

