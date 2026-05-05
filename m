Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D2CCD343B
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F248610E483;
	Tue,  5 May 2026 22:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="aSHyHC8S";
	dkim-atps=neutral
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com
 [74.125.82.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA00610E487
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:52 +0000 (UTC)
Received: by mail-dl1-f100.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso271301c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020072; x=1778624872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYzm7RaU/mexAHzICmjLdIJWWzAicpchLD1vGt1mkIA=;
 b=O+4aTN12drJDZ1t5NbME7SJVf8QHXVSovuh5qp3UQO1C7iMwbXuK5XSuL4oepUS2u9
 vUfySg2GyoIevsbJOqMvmnaY5A0e3q7JTNjXSkAZVaUMf6DGL4xg4bY78iNKQscEHrMQ
 Od9Ukz6dIhg11foaD2asihIabc0ntTUWlgRTAsgnjIYx3yIwrMseE2oHOgRcOqWD21bS
 ayZeyLWgHyitRRniphY8lQBvOTqzJZHvZykAh+ISftfW95RHYrbeD6xPkcP65pB9ZpYZ
 /A30VTG0g9Rh8Ouw+IXb2/IGNzKHDtakJsnKb+2sxkE+LBeL+zZ3qX1ek/fBYLovgZJC
 AdcA==
X-Gm-Message-State: AOJu0YybgyMhPYu1St5n8mfpSpgBT9r/NSi47Fqlze7dDiV0f2WJC8X1
 8X9oXIW2bpMtiTR/vCQ6ZuhA6Klh5CQSuCbGk1sdAO6i+AGVpJMl05bBrd91+VilUkFll6nZp/6
 SEvfEz1tlKSm+nPmWa7TndPvFW6PPghbHf0OK4NTy7nikSajvRoywqeIyr4Z8sFiojeA/WHmiKy
 B3+2IcaIKy2W3ixi+kjoXMZz1E0J6xhKfcXbcI4PisJViVJTBpGmBLDIiFNXkBbTFjkNg8UPyTi
 VJ0Wjee/38KGgmJn62c
X-Gm-Gg: AeBDievMZNo1h8IP/fxbvpZFt4mT7vcSVwVme6K4Qx6V4VbUp7jaZZO5c7snWj5IMOa
 fTY+cuOIPbn3BdE3rISpFODCdHnPV6wjo2XUKafJJ1aryYaHbe6UzJphdG3firVHd0bzbRByVr4
 pGmK0OkaX2+6t1Alb2/BDypgx1G+/O9lcX00GULS5W98SChdOEGxgGEwewCaZiPxpZ6+s0uURA8
 ym51OJ6MQCQxfPXc3CCkipa+c/0Y2bZKoeFemx3J2TBpS3EvL0rQ4rhsBmyYpDxqcE1FTfFvPjg
 Osv+bCCD1BZBlYHyMDfEKqk0meTsZu+pXsq/PrZSWKwd2JiLrCjQkrlpeUEdoEuLnXSFv2voMxn
 zy7lgSk9ghTE3bvsOt/i1QVa1z/7Q7QSBkJ2ZRtMsT+MzVEs0jBxfsUu2zyppfTWZays8po02UK
 0Awj2neflRoffpIT0Mt+uDzm6QSl30fEkKG9v9za/89p2bkyhfOag7QD5lm4r7j2tx
X-Received: by 2002:a05:7022:ec07:b0:130:c9dc:1b6d with SMTP id
 a92af1059eb24-131b81fabcbmr360693c88.15.1778020071818; 
 Tue, 05 May 2026 15:27:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-131f99b3a79sm36382c88.5.2026.05.05.15.27.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acb0aa51c6so9328216d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020069; x=1778624869;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYzm7RaU/mexAHzICmjLdIJWWzAicpchLD1vGt1mkIA=;
 b=aSHyHC8S9ApjEMBgccInNWnTh0Qk9Ul1eV2PlPOy50nQtd3g1u8e3T7QK7fD+XGG7G
 nfB8SB3iyjyDA55AEq3VMi5tAaGnoDn1MovKI74f7Vgmpwn1CxwMoh00T0Cxl8cklF4Y
 O3VhDijsomLvWv1ntlnofgAMtym7V7kY4PsOk=
X-Received: by 2002:a05:6214:4b04:b0:89c:869e:4972 with SMTP id
 6a1803df08f44-8ba9e692ba9mr106932486d6.10.1778020068976; 
 Tue, 05 May 2026 15:27:48 -0700 (PDT)
X-Received: by 2002:a05:6214:4b04:b0:89c:869e:4972 with SMTP id
 6a1803df08f44-8ba9e692ba9mr106932146d6.10.1778020068506; 
 Tue, 05 May 2026 15:27:48 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:47 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 04/12] drm/vmwgfx: take fman->lock around fence list mutation
 in fifo_down
Date: Tue,  5 May 2026 18:22:25 -0400
Message-ID: <20260505222728.519626-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

vmw_fence_fifo_down() drops fman->lock to wait on a fence and, on
timeout, mutates fman->fence_list via list_del_init() and signals
the fence without re-acquiring the lock.  __vmw_fences_update() walks
and removes entries from the same list under fman->lock from any
other waiter, the fence-IRQ thread, or vmw_fences_update(), so the
unlocked list_del_init() can corrupt the list head.

Re-take fman->lock before manipulating fence->head and use
dma_fence_signal_locked().  Wrap the locked signalling in
dma_fence_begin_signalling() / dma_fence_end_signalling() so the
lockdep annotation that dma_fence_signal() previously provided is
preserved (the same pattern as __vmw_fences_update()).

dma_fence_put() is moved outside the lock to avoid a recursive
acquire from vmw_fence_obj_destroy(), which also takes fman->lock.

Fixes: ae2a104058e2 ("vmwgfx: Implement fence objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 4ef84ff9b638..384c6736cf6b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -367,13 +367,24 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
 		ret = vmw_fence_obj_wait(fence, false, false,
 					 VMW_FENCE_WAIT_TIMEOUT);
 
+		spin_lock(&fman->lock);
 		if (unlikely(ret != 0)) {
+			bool cookie = dma_fence_begin_signalling();
+
 			list_del_init(&fence->head);
-			dma_fence_signal(&fence->base);
+			if (fence->waiter_added) {
+				vmw_seqno_waiter_remove(fman->dev_priv);
+				fence->waiter_added = false;
+			}
+			dma_fence_signal_locked(&fence->base);
+			dma_fence_end_signalling(cookie);
 		}
 
 		BUG_ON(!list_empty(&fence->head));
+		spin_unlock(&fman->lock);
+
 		dma_fence_put(&fence->base);
+
 		spin_lock(&fman->lock);
 	}
 	spin_unlock(&fman->lock);
-- 
2.51.0

