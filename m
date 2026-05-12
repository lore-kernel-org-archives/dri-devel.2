Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB712CD37BE
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 00:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C2910E235;
	Tue, 12 May 2026 00:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="LxQA4wJw";
	dkim-atps=neutral
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com
 [209.85.221.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E2210E945
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:25:54 +0000 (UTC)
Received: by mail-vk1-f227.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso4643547e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778545553; x=1779150353;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kD7ZCY4JtS0gidVSnjtGaKkviofgekUENhTlmTNE3vs=;
 b=ci7WGP39bke6A8+6UqkNYHANSyd87tCuFRFr6H7scFHKn4cJuieZa8rxaG6m9LOr/B
 oKyfExU0gmJymZqez1h0Mx9+jaCTF0enPEq91oN76b3VW5aMBbtlH9iWkIsCfzFFt2Gi
 vu6ZB/Hq91Z5KO4O4K/L6YMb/D9zm60YaPZUgqxktHY7Xle9sT51oP0Uc4bh/p98IdnE
 iThV61sPd306bYpWol5M+k1yiTVkAd3KSxjaqQtAFeuZeeIuufEH0sD0548kbV8MGr+P
 O03Dreh3mugGWQe+o/eA3IrSnthCBo0Bp0c5+KhVQNLfoZ+ouG3KFfMI6lSlw4iBOM0r
 7xoQ==
X-Gm-Message-State: AOJu0YyYxh7Y673hlz2BQ7ANhhhVn6BKsIehNO9q16hjROopKbfcCxZJ
 1vICgJp74koVpay9T21Syjm2arjr3TU+tiQ1cz+HBewvZGDuHFuBuDmqPa41610kqwJD/R/99ND
 BNg2fg+bqlrK70WopARjc7wUlXrNwDLRwrXEyX8wsqwZcVGoQJEhcCrG3Kq2T9FTtxPoTjECOPy
 8kkF56a4ukOk1RvqNPMJM9edLZbn8ng3c3hcxTKGE7h8JNiYRHKgZ+AmrFYus43pp8kjY9WzYjq
 IQ3yXI8kY3XuvWOqVcQoaXwhu4g
X-Gm-Gg: Acq92OGAPQxksH/JqmDaTjGC+OlSiJORJIla6ql8NVlQDJjyfSxBo1iVGnRdVqcPk9g
 feBrC3LFmoN3ULT0tDA0cZSh5rxkRTMq0TTMcqNw9Mn2hTGg8jEwP7/8HQAO6uygun7DBysYyZ6
 zQ1/Sai9P51UIH4fRLnETSI/ktURhk4k5QBEa/5Oc8kx3v+SGUJ9Q4o51oBG5EFf4iDTSBLXPcW
 01yaErZEssnsULutldo+Qc9coH/yUlWKsasy14t+bg8EBGZQxhSkevCRuDLGVnPA10ah4iZ1kgt
 lwi6PGOaRyQOd7LMz0eFfRUbhgQfYNBkJw8Fu8wgNRnngWL+z2kI/HKlIHgtJWx2BodsH05abc2
 bBeCDsFzkrW2xQkkxWPegrm0uBfFwALVGo3bjUqILDKNUF9Sy3Oqq4W8DiNxvScWKRLh2Fp5TNv
 0rYLRcwfZTf8XtLotaKkfun8IQvm2SsgKobDWYOqAoK8Z8mXqZAkvXYpPVIvdhVw==
X-Received: by 2002:a05:6102:2912:b0:62f:2ecd:3c9a with SMTP id
 ada2fe7eead31-6361478c5afmr424811137.2.1778545552980; 
 Mon, 11 May 2026 17:25:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-63140139b0dsm933008137.17.2026.05.11.17.25.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2026 17:25:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12dece274b1so7218029c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778545552; x=1779150352;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kD7ZCY4JtS0gidVSnjtGaKkviofgekUENhTlmTNE3vs=;
 b=LxQA4wJwSShTWZ6hfh/54aQpzIwWQxAYMU2AypY42w9dLWkWQiRhrCE+YLEv528HMu
 0g2L+Px2JSz1QWFjqPu+lusuEnjGbXw49YhA0ywSWFunH8gpDuuHueYw79b8JXXK8h76
 de2mn8aTzv8rFKclI4Z/V0zsKhf5YVEYMYmNg=
X-Received: by 2002:a05:7022:fa6:b0:128:d5bd:3572 with SMTP id
 a92af1059eb24-133451a2bf5mr533696c88.31.1778545551771; 
 Mon, 11 May 2026 17:25:51 -0700 (PDT)
X-Received: by 2002:a05:7022:fa6:b0:128:d5bd:3572 with SMTP id
 a92af1059eb24-133451a2bf5mr533675c88.31.1778545551032; 
 Mon, 11 May 2026 17:25:51 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm20395488c88.8.2026.05.11.17.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 17:25:50 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v2 3/5] drm/vmwgfx: Reserve ttm object before resv usage
Date: Mon, 11 May 2026 17:27:50 -0700
Message-ID: <20260512002752.2826685-4-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
References: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
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

