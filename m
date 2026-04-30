Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA3CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897D410E40A;
	Thu, 30 Apr 2026 00:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="AwE02LAQ";
	dkim-atps=neutral
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com
 [209.85.222.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0E510E419
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:17:15 +0000 (UTC)
Received: by mail-ua1-f100.google.com with SMTP id
 a1e0cc1a2514c-953ad5a55b7so232297241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508234; x=1778113034;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kD7ZCY4JtS0gidVSnjtGaKkviofgekUENhTlmTNE3vs=;
 b=PM0+5CQNN+2XexG0g+1MqmTg5xBmZdpa0G2MTTd85HZqiYQpwPnTAo9qy1gvJYG7S8
 hRoHbumkdd9ADgHYV10DXbIqI3QQkUH0vUf67UH+QxR7mp2drKx2ZbJZMws8DUMmE2Vk
 hOKfIdj1veQVL3luwP3WKFzqr58kbLnqds7Aa/rjmjRqztxZVQvkY9kbLuLCa/rnktkU
 M0tk4XF66c4NymXoPHlKZ9QOzqCfwzv1/ZKe5B0+oZDl51cDMPfNXwymrEkza+nMSj73
 5RIOR9zttSF5F5xJIhbV484mdp3zr0vNidjjBYOPUBLD6SI5gLGtG01u9FigreLH2bdV
 D9WA==
X-Gm-Message-State: AOJu0YxcPxNH49vjLiJGjyoIU4kKGZXYpfuyfXSjuCBisLxsjT21k8iG
 UWwqEt3OBz3+m5l3WrMkwvTHeuJI1Jn7n9dnZUjE5wPNIV7SHi98qMg+4lhdyfewIW9jqvuIQGq
 f61GqfjK4aH0hoEve4R4wRMOOQL98l3fAdRIZWLOFqKL/c7LtMIkAipqL3SdYgQcIY2FwV50zQ/
 5X8rpQrkxN4AxiAjhY7CT7xaLRScSFEyb+nlkI7HYKZ/0v4i3iUT0d1hy40sgjjxInFlHc+3lO+
 C9qwkq1Bp6d+y6NyGoucCa74Xm+
X-Gm-Gg: AeBDiesV3wo7nx8ls4B5+KlvxrBb4IJD1+KsZd7s6IQZmy36aVYrIFfqPfMbNzM5+oG
 uj0nNd1qC01SVy0ACRRDfh0azRtUPdKvYl8RENZkFGlqcFEcYt2lUTM0qr4XIX9hjZHzjHQuw5O
 1wsucp1wjmLZjZ4/fRh10GqS0LL6s4IaHPovaEGgN2xwiXKih1wker9E2EygDLzjuBOpSaVPpBU
 qo1TUpPsokc786nQIkV2I6an06Ye2zW24Evu20m8CTi/CH/Ae1AFM1uzo7NicEKeAbeJMne7zk8
 wscENkoIzILgemZWhvunlQNmic7qMwYxaUgdjSnOdyjOfEd12PeJcNzZog1Cer2HN3g0Jo4UQqk
 0Zr2TKv46dHFkuiz2cskWTeO1F/2sb4i05848AvJHX67h7mJbyM7mSYN0FRf42s2DD/XCtqeeMk
 qP0/Nbr3slWeqTzenLum/NVXMoFyTIGFJxUg9FargfIxghA8CzIS36Lke0j+JVNng9mi5c0iBM
X-Received: by 2002:a05:6102:424f:b0:607:960e:aed1 with SMTP id
 ada2fe7eead31-62ad1c32bb0mr396437137.1.1777508234216; 
 Wed, 29 Apr 2026 17:17:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6298496e7f0sm226281137.23.2026.04.29.17.17.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Apr 2026 17:17:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2de07c12745so2034164eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777508233; x=1778113033;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kD7ZCY4JtS0gidVSnjtGaKkviofgekUENhTlmTNE3vs=;
 b=AwE02LAQaCDm10ZapZIUhG2SQVQwE487TO2e/MNDPPAC25xzytCBHWV95AwWc6RZMp
 x+eUC1YDzqmCEj9gO0KBjUHufRex5a4bkCy0c246gQsm+o6MBUr62eduTUD5/xJobAwx
 H+ivar42odG9mQMyzgKsy+tVTgEx7Q1LmqPBs=
X-Received: by 2002:a05:7301:fa13:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2ed3d8c4ffbmr219148eec.21.1777508233014; 
 Wed, 29 Apr 2026 17:17:13 -0700 (PDT)
X-Received: by 2002:a05:7301:fa13:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2ed3d8c4ffbmr219136eec.21.1777508232256; 
 Wed, 29 Apr 2026 17:17:12 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0ce05bsm4173885eec.26.2026.04.29.17.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:17:12 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH 3/4] drm/vmwgfx: Reserve ttm object before resv usage
Date: Wed, 29 Apr 2026 17:19:11 -0700
Message-ID: <20260430001913.482967-3-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
References: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

We hit dma_resv_assert_held warnings in several places, reserve the ttm
base object when it's being used to avoid them.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c   |  2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b0dc..6817e0b8ce99 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -55,7 +55,9 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 			/* Reserve and switch the backing mob. */
 			mutex_lock(&res->dev_priv->cmdbuf_mutex);
 			(void)vmw_resource_reserve(res, false, true);
+			ttm_bo_reserve(bo, false, false, NULL);
 			vmw_resource_mob_detach(res);
+			ttm_bo_unreserve(bo);
 			if (res->dirty)
 				res->func->dirty_free(res);
 			if (res->coherent)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..21cdfc6a1641 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -131,6 +131,7 @@ crc_generate_worker(struct work_struct *work)
 	spin_unlock_irq(&du->vkms.crc_state_lock);
 
 	if (surf) {
+		int ret;
 		if (vmw_surface_sync(vmw, surf)) {
 			drm_warn(
 				crtc->dev,
@@ -138,7 +139,18 @@ crc_generate_worker(struct work_struct *work)
 			return;
 		}
 
+		ret = ttm_bo_reserve(&surf->res.guest_memory_bo->tbo, false, false, NULL);
+		if (ret != 0) {
+			drm_warn(&vmw->drm, "%s: failed reserve\n", __func__);
+			goto done;
+		}
+
 		compute_crc(crtc, surf, &crc32);
+
+		ttm_bo_unreserve(&surf->res.guest_memory_bo->tbo);
+
+done:
+
 		vmw_surface_unreference(&surf);
 	}
 
-- 
2.54.0

