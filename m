Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF381FF493A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265CB10E445;
	Mon, 30 Mar 2026 05:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxZmLNJJ";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974F710E441
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 05:30:46 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b97a9f4b4dcso523013666b.3
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774848645; x=1775453445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4h/NQNA+UNY/vL0CTGhvWEa0MkHre3ParL6tgrkGUs=;
 b=FxZmLNJJXfyT/qnskOZXZVs4/VzlIWk5vThZWEY6I+I6QkDXLKBOBkURDJB4inxgkE
 o1bwR7p8esp7xQwXjYgdWzSXGgfQrm+24gDM0PEA9cN4dwZ4lvrF7eWURrucemcJPJUC
 DU6FlYFRX64+lWjy3a5u4hUl3UFxtADqNogd1sPiqfFG6pYeRY/w8+MY6AIoUbTDSeYW
 Mv9cw+Zatjki+lQPfgdW2H3U5YSbUPgscPage6MdQ7RxH22+OROZF7W0U+R8YVSvIJIj
 EvmRliOaHm0J+oluieHlnWz/yFg6XKuZa3Ia+xgfdADkf4djDvzv5JwiYb8SVgBB/cl1
 67qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774848645; x=1775453445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p4h/NQNA+UNY/vL0CTGhvWEa0MkHre3ParL6tgrkGUs=;
 b=Dt6UAotC8s2ysHd/0pCdkSAfhqmrvBjcQcHoBeu3RcfFUQeej3du9siumV98QLhiet
 6mkBvYov5sWYtM9r4HOpLPcGzqrUn9yIxxNRMmnSW7dcN7jmaU7uwmafUheN5p8KANgX
 Urvt+GjlP5JVlvJmIjyFWOtBYaJ3/fP2gV9IAJDoKxpSUdtrQ3GXvBssfYjaqa9Aqvu2
 WbrceE5kGlgHOCWcFMrM9w/yB14vdEbGh+dZuMutN2XXLgx6syrr1GQr1tKRQwc9FiGU
 /YHbGTJteqYA+0dumIRO2HMNlmqvSe+O/4QezV96W8zCNq28h7xgE/eswls58iP/0PEV
 Q7vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8px/6nlApPC5XzPeAgEo9s5iLcf/AIahLDIucLIcjL4QsIXd/mOukA6Aq/cdhRyrsnB0XcUJJF7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5dfVyN7K0HjulRuvFBqqd1N78cPDDCAd3oqbTGLFfddQhx6Zm
 ZXnQWJXY9u3voiCr7nN1/HnD4NasF+4mKV4Nsk3KhUDj7si5kTPArVzh
X-Gm-Gg: ATEYQzzgZUSvk7msi0Ig5cjUkQ1gWlt2RDSmkT5LDfuIE2DIUETusqwGG2QOt1q8bGR
 2AoexU2ERxMVgAVPtbu1X2rFjSotwc3lqFxKGMlzedzwLcsX415MKLVMFFTLIp30IS/UqqeG6kD
 X1YKYVXwGVzcPW11jF76iwepSDOxHPM0BzFI5I04Gp0Ev6woLgLS7fzE21UOG7qhsk/VhpSVves
 1LI9GMmR4khOAAilZ/s75l8pxm1XVPHjdAnSSxN/00VsgTs0bBRTL/puvlV/pM50b9MDrXDJqCH
 eEyuzZ0Vw01M3Vx5Mj1PB1jbF+lXR/PeARBS0TbSHZRPkjoz1Dw77KVFXsnpm7T2B82NXK9qWRq
 E4xDVjnI4WTk/Z8LYNjYzMtHEukkCUox10ZF0aPl/F5lcuVu+jVVLqXh0PN1pC87AZNt+RjiR0S
 xhCE0ATWKPEcanr+INEf+BRroViNuBDN9L
X-Received: by 2002:a17:907:9614:b0:b9b:e5d:71d0 with SMTP id
 a640c23a62f3a-b9b5098bb2bmr700871866b.53.1774848644973; 
 Sun, 29 Mar 2026 22:30:44 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5fc9sm240417066b.36.2026.03.29.22.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 22:30:44 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: use spin_lock_irqsave for PASID IDR lock
Date: Mon, 30 Mar 2026 10:30:25 +0500
Message-ID: <20260330053025.19203-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
References: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
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

amdgpu_pasid_free() can be called from hardirq context via the fence
signal path:

  sdma_v6_0_process_trap_irq
   -> amdgpu_fence_process
    -> dma_fence_signal
     -> drm_sched_job_done
      -> dma_fence_signal
       -> amdgpu_pasid_free_cb
        -> amdgpu_pasid_free
         -> spin_lock(&amdgpu_pasid_idr_lock)  <- hardirq context

But the lock was originally taken with plain spin_lock() in process
context (amdgpu_pasid_alloc), creating an inconsistent
{HARDIRQ-ON-W} -> {IN-HARDIRQ-W} lock state that can deadlock if an
interrupt arrives while the lock is held on the same CPU.

Use spin_lock_irqsave/spin_unlock_irqrestore for all call sites of
amdgpu_pasid_idr_lock to prevent the deadlock.

This patch applies on top of "drm/amdgpu: fix sleeping allocation
under spinlock in PASID IDR".

Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 515775eab2ef..762ceb3c708a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -62,16 +62,17 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
+	unsigned long flags;
 	int pasid;
 
 	if (bits == 0)
 		return -EINVAL;
 
 	idr_preload(GFP_KERNEL);
-	spin_lock(&amdgpu_pasid_idr_lock);
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
 				 1U << bits, GFP_NOWAIT);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 	idr_preload_end();
 
 	if (pasid >= 0)
@@ -86,11 +87,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -633,7 +635,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&amdgpu_pasid_idr_lock, flags);
 	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	spin_unlock_irqrestore(&amdgpu_pasid_idr_lock, flags);
 }
-- 
2.53.0

