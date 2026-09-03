Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E1CC79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254BF10F8A3;
	Fri,  4 Sep 2026 07:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TU1y0Fu9";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6439410E12F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:38:39 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-4b3a61bdf22so1176167b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788449918; x=1789054718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TFqVnAblzbxrI+EAUaJsxOTnDTvuhAtdFCDTH/5pOYk=;
 b=TU1y0Fu9bGd7jZTMbUr1kWwrVUPCNEYeG1QNpeIDTIQwlzcJZewi3Z34NFYHk8yrdP
 VAi38yZhaXZBKUyTv6bFJtYNJBBgRC6fxUFWOv7rFQP57zaILlrNKKO2lHTRHohn6v/c
 +SLNqtBsvAWbLbbTf+9o1rCKINFxfPMZ9c/CB8Z/5fb3O+dB6HXpOYu+evMwK8+VKbyD
 4blMgwr4u/FyN6fPpIGiPSxs90ucqBIzWHAdwC9LiMxATYoIukzEaWfq9nfzzN8de7rW
 IM2AxjJhhWayqttNdDxVt7Hm7bL6Qe3dmM5A11X7DrbVIPm4oRoqgY/iuTszW7ulfagt
 HMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788449918; x=1789054718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TFqVnAblzbxrI+EAUaJsxOTnDTvuhAtdFCDTH/5pOYk=;
 b=aDdJQxMWebW3oyhmGPFpoBtmefVC6vzsRrw6caAw++3CrKdNJd9YjqQoK3Ld/ZfJYN
 lx0JFzHV4pR04rYkmAy3uleI/EgAc5HrvMiWN0ABbGDWmlbx7skWBaalIIetffBN/j1r
 rYvd39utKf+ek2w1wCMcPzpj7H/KTgDLnwbksbUfxk1j6mJjsIIB1hdCxDK6c640deEQ
 CwWXwJgoQgxQPzKVaIvHuZjysyGBxl8ZuGKmDW/FdsN6bZEVHW5tg+EwaozwI8d8haJM
 ODWJnp3mMYgFxOSAKttVzwoN9CxLRlosaMNa1X0Z5GgM9Or+qYdOAdvMZ0kYuVzKSh8R
 deQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydfkGG/b+hSX2BN2V3QVcChYPY+x6gkkrNooFg4+k0ciqUvnpxn6IaWEVpVV9Rwwn5UnNKv23fEO8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m0/1Lvcrd7+gqAODLEA/rYc2CVP85VO4/fb93eP+eWgW7ada7k
 /O+EB4VZcC/zaM4AuwBc1LBjn2zOzOfET9XpOijhuyGdL+ONngN3NH4J
X-Gm-Gg: AYBFou0LvUVUn1jHwrppnSFHTbAYoqWA7tGQdLYKXwCKaUTT04Di/nqSEfc6vy5A+01
 Eap6RM5MGN7HS1EYMCExUcv8yd9gEDwjCOQex6wW346iBqiX7BENoKIpUvhyd2HfsIVikiADXsP
 jT2gjRlqH39wCtX8UtZYcDMi2LHdJqjaolum0dK5wWfAIUrKHJidjfiSChpqf5CWTDcM2mfjRFt
 8to2e3qinSLIwqqt8Dwx5KZvSz9XgbR+/kBizEK+DNZdzkRQjjpqIWqliDSUihrNWZngCPYnxGW
 QYDXEfDOYXNlaW+epab4ZA2SwUMKBS3aerG/LN1+p1uPXoqpKjTqVRqcTx6Si5lBpTtQZJon9eh
 oe581/kCBQWisfy87xf89Cb7Oxu08Cv8EB0b99ZZl6gMGJCxoV5caTaHVeaa3Rocw7DJLlfx+vf
 G61wfua/J71WguWK7M3USXdtzGoS3n4PZ9x18hAbUWup4EB/6+zvPWoTrhopHXnvLPNjWrniwfg
 2MXTpKQjBzkYGzLUUZgSPaT5g7F+sE=
X-Received: by 2002:a05:6820:2903:b0:6b1:6c11:686a with SMTP id
 006d021491bc7-6b480128609mr9833673eaf.29.1788449918414; 
 Thu, 03 Sep 2026 08:38:38 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dbedc6fasm148433eaf.3.2026.09.03.08.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:38:37 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] drm/vmwgfx: Replace kmap_atomic() with kmap_local_page()
Date: Thu,  3 Sep 2026 10:37:57 -0500
Message-ID: <20260903153757.26291-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

kmap_atomic() is deprecated in favour of kmap_local_page(), as described
in Documentation/mm/highmem.rst.

The conversion is safe in vmw_mob_build_pt(): the mapping is created and
torn down within a single iteration of the pt_page loop, preserving the
strict stack-based ordering that kmap_local_page() requires. Between the
map and the unmap the code only writes page table entries through the
mapped address and calls the vmw_piter accessors, which are non-sleeping
array and scatterlist lookups, so neither pagefault_disable() nor
preempt_disable() is needed.

Reword the function comment to match. Avoiding TLB thrashing, the reason
given there for using temporary mappings, still applies.

Build-tested only.

Assisted-by: LLM sparse
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
index de7a504de..edc1ba5df 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
@@ -451,7 +451,7 @@ static void vmw_mob_assign_ppn(u32 **addr, dma_addr_t val)
  * @pt_pages:       Array of page pointers to the page table pages.
  *
  * Returns the number of page table pages actually used.
- * Uses atomic kmaps of highmem pages to avoid TLB thrashing.
+ * Uses local kmaps of highmem pages to avoid TLB thrashing.
  */
 static unsigned long vmw_mob_build_pt(struct vmw_piter *data_iter,
 				      unsigned long num_data_pages,
@@ -467,7 +467,7 @@ static unsigned long vmw_mob_build_pt(struct vmw_piter *data_iter,
 	for (pt_page = 0; pt_page < num_pt_pages; ++pt_page) {
 		page = vmw_piter_page(pt_iter);
 
-		save_addr = addr = kmap_atomic(page);
+		save_addr = addr = kmap_local_page(page);
 
 		for (i = 0; i < PAGE_SIZE / VMW_PPN_SIZE; ++i) {
 			vmw_mob_assign_ppn(&addr,
@@ -476,7 +476,7 @@ static unsigned long vmw_mob_build_pt(struct vmw_piter *data_iter,
 				break;
 			WARN_ON(!vmw_piter_next(data_iter));
 		}
-		kunmap_atomic(save_addr);
+		kunmap_local(save_addr);
 		vmw_piter_next(pt_iter);
 	}
 
-- 
2.55.0

