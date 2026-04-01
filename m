Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44452D35171
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CA310E1A7;
	Wed,  1 Apr 2026 11:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VZHDWHEg";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4F610E1A7
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:25:48 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a2beddab48so1729874e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775042747; x=1775647547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8xyKCWGX2L2w0vRQ4XMQooKM1IF5VXY9md7usUI5pIA=;
 b=VZHDWHEgXszYdPqqA4vxoHNMLd+6IG+Y4RlnU/TN8XhnmuEgZW5+0dHmtH4hnUrRQG
 8FQl2BltLdMPxR/tsaOs7IuQGqv90mjU2V7/6gHcgWME+a41iuCpvWsTa3U0V1laEIN3
 OzC27GRIzm4t4F2bT8tO/XCjcZIkVWfqspM+NXnyqSdW+8UvcZmx+gL6L+MJFXxAZ4Om
 MC2kgbL6FRmrbmXRVedTXysY9PtUsRfAUpD58aVDiQpp5rCB6G6PqFbsHE2tJZd27nf9
 jwUVNZgp2sV3ai/oDANktjUinOfTHMHpvQWsVewJXhWBZYZPQ+kQj+I/9Z7cZb210KcI
 TQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775042747; x=1775647547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xyKCWGX2L2w0vRQ4XMQooKM1IF5VXY9md7usUI5pIA=;
 b=ZaJdW6ffr163LPGXciquPvzFfuZJBxm88UHNje/d3r3sRVXGXTiEwRbvNLCddcKum5
 Rqiue4U5TB0smcw3kHYIe0JhEfeRDpeOAM9YQxrZaZiq166ttA2AaZ7bT7sh28Dgg0Q9
 9GtgZxKAiu34GiMGH0LMoXbxHDi9pKerx28oFavIlX8+nuXazwJNvF1VMTotfGDMCDLy
 kSaG36NpryHoq9kGv4UcOSPtobEiwPVM/3hwazzUUlXYL8YKvdJuNlsVNfdwVBUdWV5h
 1t5MKWYNjnQ+hNM74z41YKLTNqI8VvKjSW5upMixDZVaBJvhR4JCeenj7rMHuvY6VNov
 xgUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVot1TUQepryRywqHhENW5UcI5czeFPZaieZqBroKXbM24uTj9Ur1EG8l9s9hA0/ObKuanGnYomLY8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu2+GmfbWkBKhJw0OX+YrnTVIuxw3GfS6k41ZjJ2Nd7lHJG8SD
 CgNBjuWXJPy9zSpPeIS+lJVColkJJbuzOsq1fzhIEiGSmkAEPIFkvP/I
X-Gm-Gg: ATEYQzx/IKLvzjQdDKZHTixe68YqxvJP1T3N2qyv6y+mTDuFhY5Lq71cdcCgdpZp/Fo
 4ZnDkRG8qW5WB+xZEtWp16M6zQpJX/mq8vGllJlwjMrE0emxhDn6llsA/dHTu+4JVw+uOo8gPzA
 Wk+hQmKEXHBkMENZ5OXCHhj10xJ1xLt74YCwBZ2TMwMwlK/L8Er+96zIxvk5gx2aNZFCGgk6owr
 2xlqHsTVXVKycOaGBX+DxwSY4Mdd5qlKQ9Yo92ikD2/+wWw5SZ4OTtSaQRI8elEmS+3eTAEAVDK
 Cd4eoBG71pVjatMi3tym8i0aJiOmf2khYkSZ5Stt3VOwnrPZIx0Zr5CwobBl3pdZqRy1wRB4K4W
 HXCUVdrtEbUSM5lHjQHXIADk13atGanqAJMfaMk+jDMfA+9B43K64wfa9RW0ROA3ZScntlu2wo7
 2gKMITJSRzM1FQuqTfQPr1eEjq7qxviW5+5w==
X-Received: by 2002:a05:6512:3049:b0:5a2:b884:153f with SMTP id
 2adb3069b0e04-5a2c1ee87f3mr1190860e87.1.1775042746683; 
 Wed, 01 Apr 2026 04:25:46 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13b13bbsm3256191e87.0.2026.04.01.04.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:25:45 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 16:25:40 +0500
Message-ID: <20260401112540.451773-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
annotations, not runtime locking.

Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
xa_lock_irq/xa_unlock_irq internally.

For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
xa_unlock_irqrestore since this function can be called from hardirq
context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.

Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v3: Shortened comment per Christian König.
v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
    amdgpu_pasid_free() instead of xa_erase_irq(). (Christian König)
    https://lore.kernel.org/all/20260401104859.36990-1-mikhail.v.gavrilov@gmail.com/
v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..a1f72f5d31d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
-	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
 			    XA_LIMIT(1, (1U << bits) - 1),
 			    &amdgpu_pasid_xa_next, GFP_KERNEL);
 	if (r < 0)
@@ -84,8 +84,14 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+
+	/* Called from IRQ via amdgpu_pasid_free_cb, needs irqsave */
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

