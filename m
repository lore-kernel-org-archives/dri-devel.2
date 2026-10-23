Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C360A5BCA
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvZlswrX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14369112983;
	Fri, 23 Oct 2026 06:40:24 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8771D10E598
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:17 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so4399335e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737616; x=1793342416; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7r0UNu5wEL8POkOSz3+rOlJOKvPQ5Qd38WxY0JoWHCY=;
 b=nvZlswrXUTemp8U1tTORLe558Cf93+OqkImac0QW+2FFBVC9FyhGW8ej+CP4ydnn0i
 3vMUgjZf8q6tVYKg0gSdv1dHWHF1Ou528CnxhkZBbM+Cm6inL6Cid4OiGCSRczHypk6I
 T73pAOH1PXNMLpd7GibZZWoixf1l7nQebYzbp1pCpMuVSWbOO9BKmYvEfbloX4mSlBP9
 Z2jNrKEI4lFuGlSuQtSS2bQjUPpxdS7fQdJhQD99EazCz1GMg/ZcaLUb1gXbn3DgB2Dq
 JVmcl/PF56lMnjqCPD5zzfMyeyI1E7kjPzR7+exhLdvOpNAdvISYAPQxvKLqaR5LwN0F
 vqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737616; x=1793342416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7r0UNu5wEL8POkOSz3+rOlJOKvPQ5Qd38WxY0JoWHCY=;
 b=Kil33y3qAaqXz/mY3IBwlxQj6p0WNfsZ8SDhgyV7lK18MohuFiXm8fRCWmiLXy5EOM
 6vMC+b+5/6WFJFUTpRSrtDnaVS7pHG2QrEqoLh2+25K70lF6PNtd317MALM7/de6xOLp
 xebS79jfA0kd+EXntifyN0TG6JCZx4h+VSnReBOIEg4wU+eiZtgojYHFmweBTxSO0tWB
 itDn8PSoWjNxn7EVp3ffsqAzCeLAnldFHmcccolGqUfPweoOUpBJiy4mjPsaNkEAG0oC
 XT4WBzeJqDHkdHoLpMxwTj1kq31DOItrqSz25JUV1BwQ+2Isyg7KNEuWiUOKvlKynSU6
 /jLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJZdRzk410Rqvc9K+1lInzNl5jJTp9XdltjIXMHNpm04vN5IO+TbQ8kRNJw6h3DY9XOZz+q1xW0Kk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIE4s37l/lYYahhIHkmWGvwH0OuE1dRnpzYEepQkp86kXvlCc3T
 i3jwZOoiE3QYF1X+uIyoKkdArO5SC14u1rq6BNiT03l3uurHBtJmuFLv
X-Gm-Gg: AYBFou3dx5O62NNYF1PfXvTIhDXI9ntLwYRCRKR4g4fXZLZZo7MPU8EeCjCla9XI5RI
 +Mb4WwTnHSGsv1OZ1oS4JxkH5GfWk5td7sOpbXCzoPEAEJX8M0RjGl89tOVvm/VOtCJ2ByB3o0P
 yIg+9QCnDqpMQU8lYPDjLp9SzHAZgjUnwUGsEwLrh0UKymbo81FODF2cbTYQMOuBr7tNLjOB283
 siXo7WtvKFfdBcU5HrNMrszpL/ORYt6mzW9UfvOYLK8yAfPW5ul4acVGvW0ZYTNggaP0Ui3p/Cd
 Y88ATuvbMEdlmHwKnxFji6u/zjCLFjQ7sKzxl2/iNjgd33nay87PsrxbySSf08dQdR3K3Pwmfp3
 Qb9TUnQHbUMuXjmZLh1M7LGwKpPcgZj+rnv5d/V4OZt/Mt5sezv+lFR3dE7k6NWMG5GzDBipzSp
 +tfjW6FwXkpXU9CsefIiiNPVXP4D3nrzxc+zUsT5c2UJesn3F/eOr4HNLc5dLllOKF2GCjUIvCI
 yAHp2gj8rW8v+ElBiRfGuHmUTXe/kiBywZYtFChBw3ORIvClWz9Vh+rbVXHIKrghP9mxPBxQDaf
 BCBiN6h1KTkBYTA1LEf8Hq7xUPvodWR+g4XxPFmmLTnHgovs+fiUfFanwqXQdyxBWl//zrse+hx
 86m0=
X-Received: by 2002:a05:600c:6387:b0:4a2:bbd:ea3a with SMTP id
 5b1f17b1804b1-4a211c51aa9mr18565345e9.6.1792737615806; 
 Thu, 22 Oct 2026 23:40:15 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:40:15 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:37 +0200
Subject: [PATCH v3 12/16] accel/thames: Install memory mappings populated
 and dirty
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-12-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GEM DMA mmap helper maps the whole buffer up front, but with pages
that fault on their first write, since the A53 in the J722S has no
hardware dirty-bit management. The GEM shmem helper maps by page fault,
one at each page's first touch and another at its first write, which
its write-notify needs. Neither helper can install the pages writable
and dirty, so the driver sets the protection itself: for contiguous
buffers it calls dma_mmap_pages() with it, and for the others it
installs the pages with remap_pfn_range().

This saves 20% of the total time in the first invoke of a model on the
J722S.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/thames/thames_gem.c | 76 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/thames/thames_gem.c b/drivers/accel/thames/thames_gem.c
index 5a4dc497768f..9f55169c6370 100644
--- a/drivers/accel/thames/thames_gem.c
+++ b/drivers/accel/thames/thames_gem.c
@@ -808,12 +808,82 @@ static void thames_gem_shmem_bo_free(struct drm_gem_object *obj)
 	drm_gem_shmem_free(&bo->shmem);
 }
 
+/*
+ * Installed dirty and writable: the A53s have no hardware dirty-bit management,
+ * so every first write would fault.
+ */
+static int thames_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
+{
+	struct drm_gem_dma_object *dma_obj = to_drm_gem_dma_obj(obj);
+	pgprot_t prot;
+	int ret;
+
+	vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
+	vm_flags_mod(vma, VM_DONTDUMP | VM_DONTEXPAND, VM_PFNMAP);
+
+	prot = vm_get_page_prot(vma->vm_flags);
+	if (vma->vm_flags & VM_WRITE)
+		prot = pte_pgprot(pte_mkdirty(pte_mkwrite_novma(pfn_pte(0, prot))));
+	vma->vm_page_prot = prot;
+
+	ret = dma_mmap_pages(drm_dev_dma_dev(obj->dev), vma, vma->vm_end - vma->vm_start,
+			     virt_to_page(dma_obj->vaddr));
+	if (ret)
+		drm_gem_vm_close(vma);
+
+	return ret;
+}
+
+/*
+ * Every page installed now, dirty and writable: they are pinned for the
+ * object's life, and the helper would take two faults on each.
+ */
+static int thames_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
+{
+	struct thames_gem_object *bo = to_thames_bo(obj);
+	unsigned long addr = vma->vm_start;
+	struct scatterlist *sg;
+	pgprot_t prot;
+	unsigned int i;
+	int ret;
+
+	if (vma_is_cow_mapping(vma))
+		return -EINVAL;
+
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+
+	prot = vm_get_page_prot(vma->vm_flags);
+	if (vma->vm_flags & VM_WRITE)
+		prot = pte_pgprot(pte_mkdirty(pte_mkwrite_novma(pfn_pte(0, prot))));
+	vma->vm_page_prot = prot;
+
+	for_each_sgtable_sg(bo->shmem.sgt, sg, i) {
+		unsigned long len = min_t(unsigned long, sg->length, vma->vm_end - addr);
+
+		ret = remap_pfn_range(vma, addr, page_to_pfn(sg_page(sg)), len, prot);
+		if (ret)
+			return ret;
+
+		addr += len;
+		if (addr == vma->vm_end)
+			break;
+	}
+
+	return 0;
+}
+
+/* Only the GEM reference: the pages are pinned for the object's life. */
+static const struct vm_operations_struct thames_gem_shmem_vm_ops = {
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
 static const struct drm_gem_object_funcs thames_gem_funcs = {
 	.free = thames_gem_bo_free,
 	.print_info = drm_gem_dma_object_print_info,
 	.get_sg_table = drm_gem_dma_object_get_sg_table,
 	.vmap = drm_gem_dma_object_vmap,
-	.mmap = drm_gem_dma_object_mmap,
+	.mmap = thames_gem_mmap,
 	.vm_ops = &drm_gem_dma_vm_ops,
 };
 
@@ -825,8 +895,8 @@ static const struct drm_gem_object_funcs thames_gem_shmem_funcs = {
 	.get_sg_table = drm_gem_shmem_object_get_sg_table,
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
-	.mmap = drm_gem_shmem_object_mmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = thames_gem_shmem_mmap,
+	.vm_ops = &thames_gem_shmem_vm_ops,
 };
 
 int thames_ioctl_bo_create(struct drm_device *ddev, void *data, struct drm_file *file)

-- 
2.54.0

