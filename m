Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E350C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C13610E536;
	Thu, 23 Jul 2026 04:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MYnDQNDM";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3EF10E536
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 04:36:33 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so193291a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784781393; x=1785386193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nu6C0cQg3wmr7UO3AzV/QLw3bolaRRF8B1urRbMg+8E=;
 b=MYnDQNDMO1sHwQq+75P6ha9JLL/rF8p1RkptIZRaUcIy1sCJcOszX7BEw3F08F0rIr
 4so6d7+O2iDpvOsX5NZppBMeSEl1Jcz1WnnyrHhSyMFkRty4KYvvN2sk/D8LRDS5BLxB
 7GDkW4FUcxJ1i7/2/JjVsjftCBprxSBM6heQgK9r0LMVpaxyLUGzNTvk6f46CJ7j3HyG
 AvwJ+vbc2NOLWh2pR0oTJbjSbTHtcqxfUcVs2p+GgRNsWgY3EaIEiZ2Zc1/s7qb6/eaO
 Z43iynkHJiFDYkcYjP1NY3KZvIFtWuOpE2IyXYr2qwr/iFuDWSDt3v64yupWBmUQkMLC
 qI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784781393; x=1785386193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nu6C0cQg3wmr7UO3AzV/QLw3bolaRRF8B1urRbMg+8E=;
 b=dOuFT3FceVio+jyg2gcKbJugK8fO0YH8uhVj+DMvGYZZAoY2jlOnPqY3GUz4w1VGbB
 31Oh9t/YDaRG8dzoRS5nnPCsWogGNogO9m+pdCIU8u6QArz9aUPLigLDRXxP7yaNdCXb
 RyZjOmmdft/YWaApA60YkHjcd82Xxt6LwUGt3qduVMPI0XbDqv4zwK018oDqcMXckvjn
 h5X6HaRFzB7jor1xI3F+bBwvQoCV4dmIGqUAgry6VVEzrUAnVqUvP/utifjBluiSiJeZ
 D1FD+VJ6bSM8nOjUDadycsMJYkvMTBHHk2a0jYd+ZhxNWRiYkMr6FvDGFZ4YonNbn6K8
 ueuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRL+giTatYX76PRcQFMgII7v7LvH1aukY6BUNqL3m69MLC+YIKAJzYygIamTwcA/DrUxKFeA7h0Rc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzibAMQywX2gjEvYNyls4dwXqyGiG93V6QWwZfw8AvXs+heKKq3
 3vz0ZxSkbPGS4rILAk/1b3y4zk9EaZlukAsQQoZOGlKxVr8NufR+aqeR
X-Gm-Gg: AR+sD11lbakfxHSTbXOy2lu6+e0XnG5NmS9olmwoedxzY3Kqdso/Zqhtk3p1XFoANk+
 /65kLEVmVTTwNNkcC32PGZwK/DNryfMmfamzQv4Js0ohq8GJZ0SbzC3CXn6FuBpfbCcXUYYjigf
 hG6qsdVrF6fEUF4WDl6SjwLfHpQbICU6+ZU2KW2ruizKrOf7OzNvwmYml1kn3dUTFHaYdwim4m8
 xgeuKc19JE9ocZRnvJQxfgR4AfGp6QZvbmSX5dbNAtcK/aTJIjjgLq0CkOhlHBI9tvhgZwh926f
 DmLtK1j06hJefUm7Oix9wxwaKqYJaWjyJP0q62hmcVJ04CG5C59IKh6ExBmkcKVksa+Cn5FJ+Vu
 /BN7WKorcPIe2t2wgXclTPM3ugr5zS1gR6rlOMgGgB8HEMpMRtqzF+pgtF1hUhZwV8vVKhx5n7R
 IAVrO9ZVMFGfD+n6ykK7+ADAvp9DfBwk7JbmPuMZ/3wFAZNNaiP96eHg==
X-Received: by 2002:a17:90b:1801:b0:38d:eb10:6f01 with SMTP id
 98e67ed59e1d1-38ec6455b8bmr1482702a91.4.1784781392869; 
 Wed, 22 Jul 2026 21:36:32 -0700 (PDT)
Received: from SaswatPC.localdomain ([45.123.221.191])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130a7738sm11923892c88.9.2026.07.22.21.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 21:36:32 -0700 (PDT)
From: Saswat Jung Khadka <saswatjungkhadka@gmail.com>
To: zack.rusin@broadcom.com
Cc: maaz.mombasawala@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Saswat Jung Khadka <saswatjungkhadka@gmail.com>
Subject: [PATCH v2] drm/vmwgfx: Remove unused vmw_goal_waiter_add/remove
Date: Thu, 23 Jul 2026 04:36:05 +0000
Message-ID: <20260723043605.2195-1-saswatjungkhadka@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
References: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

vmw_goal_waiter_add() and vmw_goal_waiter_remove() have had no
callers since commit db6a94b26354 ("drm/vmwgfx: Implement
dma_fence_ops properly"), which removed their only call site.
Their sibling functions vmw_seqno_waiter_add/remove are still
in active use, confirming these are leftover dead code.

Signed-off-by: Saswat Jung Khadka <saswatjungkhadka@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  2 --
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8aba..d84e077ed 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1026,8 +1026,6 @@ extern int vmw_fallback_wait(struct vmw_private *dev_priv,
 			     unsigned long timeout);
 bool vmw_seqno_waiter_add(struct vmw_private *dev_priv);
 bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv);
-bool vmw_goal_waiter_add(struct vmw_private *dev_priv);
-bool vmw_goal_waiter_remove(struct vmw_private *dev_priv);
 bool vmw_generic_waiter_add(struct vmw_private *dev_priv, u32 flag,
 			    int *waiter_count);
 bool vmw_generic_waiter_remove(struct vmw_private *dev_priv,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
index 05773eb39..88c77226c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
@@ -273,18 +273,6 @@ bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv)
 					&dev_priv->fence_queue_waiters);
 }
 
-bool vmw_goal_waiter_add(struct vmw_private *dev_priv)
-{
-	return vmw_generic_waiter_add(dev_priv, vmw_irqflag_fence_goal(dev_priv),
-					&dev_priv->goal_queue_waiters);
-}
-
-bool vmw_goal_waiter_remove(struct vmw_private *dev_priv)
-{
-	return vmw_generic_waiter_remove(dev_priv, vmw_irqflag_fence_goal(dev_priv),
-					&dev_priv->goal_queue_waiters);
-}
-
 static void vmw_irq_preinstall(struct drm_device *dev)
 {
 	struct vmw_private *dev_priv = vmw_priv(dev);
-- 
2.43.0

