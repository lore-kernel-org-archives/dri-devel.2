Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88B606A693
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=I0lYzIDE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D22010E151;
	Fri, 20 Nov 2026 21:21:58 +0000 (UTC)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C2410E151
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 21:21:51 +0000 (UTC)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3b41188c8b9so1044440a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795209711; x=1795814511;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3a6TooTJFPsYZ/tf+ZxSwI1pLfs5kZlJ1QsnflBy3dk=;
 b=ftBhZLACr1V4TGTNGT31RMwWNqowyPor4jj3j6Bo/2yVdzq+8utfUVveZkJW54q0Z9
 qkIntUZrkj0yVW6NwxAss4A2g1YVGagvxTUKYvsX/AdbmLiMdAAjOPtae/fbAZJU9UcT
 k7xUrKSDuQJTH94d9UNmtl1WO8YTjfkAw//dT8nfxDqb30wRxLXAJuV7qrtX06LEvIB6
 y+sr25qAJFyu8qQMB6Lg3PUlxRhdwBC8EQMSVNyAHOhb1ZNRMZ/YVIjGg8xugdVRxvf4
 Hhwu0jZO+4WyXIPJOZzL4Z3eFwfHPTgcx8iGAmJJViDFF0SSgIwHBCM0Ls/8cOunvFmx
 Zl1g==
X-Gm-Message-State: APuU4Z8tCOPcmi63uI7MxfBGJEqELsPO6R0GYbnK3vDI2C6MaQTLxgkY
 rjlshjPiE5LpMYPohxAZvJ73SO2NOzba+moAN+lUZgjKpKLVRX1i7W/GS4bc7bs9QKuRNvInhoe
 5rTcdITBhL9Udl4HJcbUdF/vjHxe5LmdzFV+dO0f8h5pyLCysiWm5sdGFNiONYoMC+Jk1pn6ren
 zReUqvW+7XMElU8okVw8cE62tj3fO7xDbYfKtykBRcZCw0t2s3LLMrPjeCMxnqOOPRNEw64Zc3V
 KJUT5xsfgZBtpEUzUZgQKS0vBob
X-Gm-Gg: AZFdTZfIXIZZTQuYkp1VblbMQLIxTk9yz4miiO4PjZt1VPIITrWu6/fTEp/hDw3AFWj
 OP4Ybga6e0huQZ1UX1MxvVS7rIeWL0uA2xGZbyfzYWCfs04vQLhyQV5jkALtgK/Tsx9vGmX6AMV
 LvRB2+swSo/hMZSuNOx1BJU2QVuUB0WA2RVNiTQQDZI8b+Hu3XLt5k9EfjG1qVjO9crHhOmwOp1
 N468Ba4+qoLniQQ5+kPaXKE6wx88laOjvrd5ACGpsEuNvU7z1jYqEvOuIV3Ty3MNM8eX2Npnb87
 RNibyMoNigfFg/aqvmE7ZWU43SdgisfWw9WgsWIJ+AGQj4QCDs+IxZtmVQXjgvx83i99OMB5rAW
 NJOpxbpozCIjXm+N8kdRd48JD1bhJt4l6I2nwanpP4feSpARlZbrl5/feidXDv+mftqZJ1zue/A
 m5z1Bn1bPKE8oq3qLthG5vhgzXl/3kIYl2YzV8rgVW
X-Received: by 2002:a17:90b:3f0e:b0:3b3:b6c3:ff5b with SMTP id
 98e67ed59e1d1-3b41c9059e1mr3719546a91.36.1795209711280; 
 Fri, 20 Nov 2026 13:21:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b41ff6612esm840772a91.2.2026.11.20.13.21.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Nov 2026 13:21:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so27090366d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1795209709; x=1795814509;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3a6TooTJFPsYZ/tf+ZxSwI1pLfs5kZlJ1QsnflBy3dk=;
 b=I0lYzIDE004eaJVXbAghuJ+RMG0RmTIImrtUke8iZ7djWGIWs/fLJOXLwf+zmbLAuQ
 bN7RR0R0FlcwhLUxlNfUOOfJKNnZMLPQ8dPaDKVp21g4m7pj27aGsoDMfssrO3avEwNa
 eyh0hBs8iRXIOpcBdCNvB8MnnpbSD+Bfj+K1c=
X-Received: by 2002:a05:6214:8101:b0:921:29a8:9939 with SMTP id
 6a1803df08f44-92134b6d526mr59310866d6.43.1795209709629; 
 Fri, 20 Nov 2026 13:21:49 -0800 (PST)
X-Received: by 2002:a05:6214:8101:b0:921:29a8:9939 with SMTP id
 6a1803df08f44-92134b6d526mr59310666d6.43.1795209709124; 
 Fri, 20 Nov 2026 13:21:49 -0800 (PST)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921347966desm35806566d6.3.2026.11.20.13.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:21:48 -0800 (PST)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v8] drm/vmwgfx: Reserve ttm object before resv usage
Date: Fri, 20 Nov 2026 13:23:32 -0800
Message-ID: <20261120212332.2025335-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.56.1
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We hit dma_resv_assert_held warnings, reserve the TTM buffer object when
it's being used to avoid them. Also reserve the backing guest_memory_bo
to avoid race conditions when vmw_bo_free() is cleaning up the bo.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Fixes: 7b0062036c3b ("drm/vmwgfx: Implement virtual crc generation")
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 29 +++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 8ce10cf9c19e..91afa8a0bd9f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -114,6 +114,7 @@ crc_generate_worker(struct work_struct *work)
 	u64 frame_start, frame_end;
 	u32 crc32 = 0;
 	struct vmw_surface *surf = 0;
+	bool valid_crc = false;
 
 	spin_lock_irq(&du->vkms.crc_state_lock);
 	crc_pending = du->vkms.crc_pending;
@@ -131,6 +132,7 @@ crc_generate_worker(struct work_struct *work)
 	spin_unlock_irq(&du->vkms.crc_state_lock);
 
 	if (surf) {
+		int ret;
 		if (vmw_surface_sync(vmw, surf)) {
 			drm_warn(
 				crtc->dev,
@@ -138,10 +140,35 @@ crc_generate_worker(struct work_struct *work)
 			return;
 		}
 
-		compute_crc(crtc, surf, &crc32);
+		if (surf->res.guest_memory_bo) {
+			struct vmw_resource *res = &surf->res;
+
+			mutex_lock(&res->dev_priv->cmdbuf_mutex);
+			ret = vmw_resource_reserve(res, false, true);
+			if (ret != 0)
+				goto no_res_reserve;
+			ret = ttm_bo_reserve(&res->guest_memory_bo->tbo, false,
+					     false, NULL);
+			if (ret != 0) {
+				drm_warn(&vmw->drm, "%s: failed reserve\n",
+					 __func__);
+				goto no_tbo_reserve;
+			}
+			compute_crc(crtc, surf, &crc32);
+			valid_crc = true;
+			ttm_bo_unreserve(&res->guest_memory_bo->tbo);
+no_tbo_reserve:
+			vmw_resource_unreserve(res, true, false, false, NULL,
+					       0);
+no_res_reserve:
+			mutex_unlock(&res->dev_priv->cmdbuf_mutex);
+		}
 		vmw_surface_unreference(&surf);
 	}
 
+	if (!valid_crc)
+		return;
+
 	spin_lock_irq(&du->vkms.crc_state_lock);
 	frame_start = du->vkms.frame_start;
 	frame_end = du->vkms.frame_end;
-- 
2.56.1

