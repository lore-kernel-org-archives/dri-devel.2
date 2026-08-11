Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F39BC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C49610EE57;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cNlw5EiZ";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9758210E461
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:29:14 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso2083649a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458554; x=1787063354; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aAc0xtFPkF9VlmAdoL5DiXZFcBGbk3oumqjK2pi8Bpw=;
 b=cNlw5EiZXEN5gHHRtVriARzB4FkkHCx97Fzeg8dDMWI+wrvGGGvqUXO5RMkaddlncZ
 xk3LQQGWDchv65pqO6Tr8lNsVfrzfjCbnb2gL0xkJATctrui9agl/FTRQCL2y3wpBYuK
 TH2s7vpLLJta7ZxoONJavMWsANsHO2RuIgZm2jR1XQYiDKV3kYdvemNZapiCxxLCdjkZ
 KMKoE9YA1xSFGLRaOkmcnsdwnlPho0YsrsJNkQBJNqlpDowzbxm/I1Oy+AD/rhuCLKgc
 CHs1rzSqfdRgkQs4jRnUvPrzzVcOKrEOtMApypf2LKxVubtA+3JrjSiupM2htm0fW5pd
 iybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458554; x=1787063354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aAc0xtFPkF9VlmAdoL5DiXZFcBGbk3oumqjK2pi8Bpw=;
 b=IUMdyJfia6ijOgquGr7GlGNma19R/hrV7JF17i9HCuUXmc/3zdIz8BBRthf8v9lpMP
 t+J/InG+/b77vH2fKqXvL79S156vwHbo9sQ1K86GUP7Rmrpbwkf31u+nsMaNRNC+Ild7
 rpn5T7FzcE84ZFlUCoZ9ymLxUn1uBGnwxqVhJMaNKHbK8Cgy3F3A1mnMxeORbJ3Q73Pr
 DqXTF8XG5ZrQsKWqt7ftpNzjw12Dj32TMZb45mtxJfsU/vKSSltAyuzb8e9o7oQ+sM5Y
 q81ohdCw8vpUlDEqeVD3Nk7gHz92Gq+r66Oa3UEY45Ug/xrzTieByhwokQHYikE91oUT
 Hipg==
X-Gm-Message-State: AOJu0YxUaeFZLA4XCAePc5yATctekpbgQ0yigIs5gwo9QKHrPurSjtZj
 EAsXSUqsE6HVfQlSxDptJ81F/iLbUSWqqpDR2EmdCJIFPciFE/9sLpAv
X-Gm-Gg: AR+sD10qxpkscaomqZpLfWvcZObnyDwC4sLWt9RIfQLDs8NdwDMEVgQwWCi6G7MUGlr
 WNt1Q7jhwSCszGgN8+w86luPC4AeKuxVXQQsL0ga5zt9zQiihPcJ8Ey5Z4rImjo9EmsrD0B3Ebn
 zDHpInac7cPEoJ44IHyZ11lskQJhYuzuwnWMT3xfSy34y04iXLuha2w6F5pwSZDilbgXXpm30Kf
 6jqYIaEhNjDFpshA4kKbXN78KLuQSyCb4q+8viyZW8Ix/mdc7v5oxx33ydqd3H35oPF1qwmf35i
 01ML0pQIjmtjSbXIC5gclo7vKNiFUn9vOyOwXV1FPSeE8rszeUvLLLUt+W75tZTX/TNrXH9xi10
 +SxEo2YPfr+3je6HefMmi/CiVcSf1KDUi1VdQcWriDDEA0s5RgOITKVfWMjqwOCRgkU9KJICwZk
 9sLHSwLkjtXhcvrbL+IZ4EwcjbE7IVN5nL3qEouTdl8PioX/m8CDMZMKCTZ+Q=
X-Received: by 2002:a05:6a00:3d52:b0:848:6b76:592f with SMTP id
 d2e1a72fcca58-84fa8686d9emr3316247b3a.5.1786458553736; 
 Tue, 11 Aug 2026 07:29:13 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fa954fc8asm890209b3a.50.2026.08.11.07.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:29:13 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 22:28:50 +0800
Subject: [PATCH 1/2] drm/nouveau/dmem: fix mismatched DMA unmap size for
 large folios
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-nouveau-dmem-thp-fixes-v1-1-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786458544; l=1970;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Ms56ytpwHSeFHdp6KwntU4e11PGxIQxSST+kpBvVKeU=;
 b=J5mecMWmZ3choz70xb/rBRDm8mbs+xBBy0WtROvpD9chGghI1Y9qX2K3DiSCMBIRSYRdUvbwn
 J4w19x36HDnAC44CAx0r8knwMUTbJhDgWQGJ/Qk8KO7+ukM2tsSaLMa
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

Device-private THP migration maps migration buffers with page_size()
and records that length in dma_info->size.  For a compound folio
page_size() is PAGE_SIZE << order, but two teardown sites still pass a
literal PAGE_SIZE to dma_unmap_page():

  - nouveau_dmem_migrate_to_ram() on the success path, and
  - nouveau_dmem_migrate_copy_one() on the copy-error path.

For an order > 0 folio this unmaps less than was mapped, leaking the
remainder of the IOMMU/IOVA mapping.  The other unmap sites, in
nouveau_dmem_migrate_chunk() and nouveau_dmem_evict_chunk(), already
use the saved size; use it here too.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 9442ec6e1f6c..d2abee3efb9a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -267,7 +267,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	nouveau_fence_new(&fence, dmem->migrate.chan);
 	migrate_vma_pages(&args);
 	nouveau_dmem_fence_done(&fence);
-	dma_unmap_page(drm->dev->dev, dma_info.dma_addr, PAGE_SIZE,
+	dma_unmap_page(drm->dev->dev, dma_info.dma_addr, dma_info.size,
 				DMA_BIDIRECTIONAL);
 done:
 	migrate_vma_finalize(&args);
@@ -772,7 +772,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
 	return mpfn;
 
 out_dma_unmap:
-	dma_unmap_page(dev, dma_info->dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	dma_unmap_page(dev, dma_info->dma_addr, dma_info->size, DMA_BIDIRECTIONAL);
 out_free_page:
 	nouveau_dmem_page_free_locked(drm, dpage);
 out:

-- 
2.34.1

