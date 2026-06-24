Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE6FCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B0F10EEEB;
	Wed, 24 Jun 2026 12:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b99fbtZg";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9CD10EEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:25 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso1136518f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304164; x=1782908964; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f2YBNpTeLYg62fGg7sbOleS8wV+O2KANj9vsOiEQ0A4=;
 b=b99fbtZgzRcjySyEurLacN+1k5v9L06U0Ak+VQcTLa1L4pCk2KjWqMBqiAlusDyGUV
 K6HdJqJI+fvaSw9Xa3guH/NHNns6RTZlhSReMgdJxTnwUGhsJCk4EZLFopE37A5W9Z26
 IobqtQ91XtzHo+Dsfb8t24lcCF69l6mvUZbG/vE9kMTmdcEWJjpekj008DfTfKjX68A6
 wAHUoIb4Y/vryObMnK0HYGXE+zmZD+ZMdWEP0RHnOPUZnJ+UlDA5yEstT/hlUZ9FxDgJ
 mwDx0aZO7+rPd+TKfMaII/W1dbwm+4f6d3d0R9txK37sY1bkBm7ew1jQK7s+ZD3Q5sYY
 kbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304164; x=1782908964;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2YBNpTeLYg62fGg7sbOleS8wV+O2KANj9vsOiEQ0A4=;
 b=gSOs2xU7nZQZ9JDzHwA/ldsU1j6Wgr1gTT660f4jgcXwLAhHVSUr1vbVmU87+7hDYc
 UbzoI2tk/oJ/nE5ih/u36jQTne5EBgrU0a1sgtiIneXjOw58Jw+nkmEt0eu4xeqYgOn8
 H27Usu0tTRXqunPJPzcHiFXXDZrt2ZiWik/NFzAjGoMusPArOSa/DimdLB8aIS1Ds+OQ
 7WM+SYTBeNlPrR1u6xbqoz6+xZCx1oc+A0fV593Ms/sn2mMs6OLhMT14Osyj/YFqCPMZ
 uEcnvzD/yf4TSLqNmcL04/RWQ8/L06JVFoGeVD0VkeT4vj7qH6shopc7Db+mE17xm0rp
 25sQ==
X-Gm-Message-State: AOJu0Yx9+ISa2x15LP8lbwWbynOCakderGT8zf4niWscLYrVrC5q8n2z
 qf9Irlrm/FK48h/XcT4p37m7lJr0+nigC/LMeWB8YK52K+pZEZoosNDC
X-Gm-Gg: AfdE7cnsqQH8Tuh2WRBZIIx1mJGa2R/s3aMa3M/Rzinm+c6UxROsMnpsxJQWRAhsZxi
 e7nYrEklHpTMqcu817CT3zmkxRCiw8e/BG3eHw1ltWYE/fpJLyFiMlEen5GFXrsRMshbn6E2WzK
 GTRM7vDs0BsoS4iaS6rb0YjhlEHwXAlTvIHpuBk/dvpYSpVEfSxn59NNxWIJM7Y1ET81h9ZMXOH
 JnAkvUMhVbQkl3WnAIkOW5dYRVBmSokDTLWZ4B9DZ2TNkIMrCIP1oRrDPevPnn9aWF6wpIbNEg3
 qhhRltiH5nyQvFjWYhv0kfEa2jlgtl0hbvL4Dl0gxrhY5dHBj9K9jAIb31jxYacp8OkNVuvSzL7
 4V3lxJ+P0H6Y+TAfu1AMiH1k9DDRytN1NV9Uz6p2FsrncJhlf0w+ZGnGXYjHTEGn7db9Tx872Zm
 LTXMKS/EhmGkM5cch2rPwyYc3/Kw==
X-Received: by 2002:a5d:490e:0:b0:461:a169:f965 with SMTP id
 ffacd0b85a97d-46c0b8b182bmr3421914f8f.34.1782304163747; 
 Wed, 24 Jun 2026 05:29:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 04/10] drm/nouveau: use dma_fence_test_signaled_flag()
Date: Wed, 24 Jun 2026 13:13:28 +0200
Message-ID: <20260624122917.2483-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624122917.2483-1-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Instead of dma_fence_is_signaled_locked() use
dma_fence_test_signaled_flag().

The extra polling check seems unecessary for those use cases.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08ba0f..6601ef52e301 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -83,7 +83,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 
 	spin_lock_irqsave(&fctx->lock, flags);
 	list_for_each_entry_safe(fence, tmp, &fctx->pending, head) {
-		if (error && !dma_fence_is_signaled_locked(&fence->base))
+		if (error && !dma_fence_test_signaled_flag(&fence->base))
 			dma_fence_set_error(&fence->base, error);
 
 		if (nouveau_fence_signal(fence))
-- 
2.43.0

