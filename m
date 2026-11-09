Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B61606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+Wgjlqu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD1E10F047;
	Mon,  9 Nov 2026 06:33:27 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8632B10F054
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:20 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-8b33a08df33so3584747b3.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205999; x=1794810799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rX+dEml+No5QZRkQLtKrKb52OuDQv2oA0jRUy4Jf2h8=;
 b=G+WgjlquLcNfPc/S1QaKXQ4cEsEz0Fefm7J2KzyzkcxgDuC7eInrsdqWxP7BbAlXu/
 tqKcIVY1MeoPaW+4x1ttVKkctaBHd8aq5DNhDojDnd7S42ogY9tWyitgqaSznIUslNA0
 0uGUg4Z2Bmoy/GxmEe6GIuQ8zCxirOUsLjWypjUgoZm6+ktKYVsDeMBekF2uktSUgFgb
 w9D/eW9UZRLuyreFoypunRyI3neX/k+iSyuK4zBom4mwGu8hKPxn6lFbWO6Y4Q6MGros
 JsnFQeHY5NY/fI1xfVKp6owrDU8KN+Erp4B0gUj8tswD+ProCoVkSltw0lmU8IqVmIa6
 ODdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205999; x=1794810799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rX+dEml+No5QZRkQLtKrKb52OuDQv2oA0jRUy4Jf2h8=;
 b=SRG5o4pGWrVMm7QSiU1BWRsIjnB391XDZseST8vZ2pQSNO6F9hvL8JvIG8Epreedmu
 BkDjxo6HFd7Wj0pucOCjt7ZiFrC8cmfWtm0fSQ0VWKdH3Jz2BCT/wfbeKaJ00pVKhtOs
 gVor6YacWH5e7XhAHBvayw8aQMQDCdjSZrpMK2a6Kd64AI+E7hTantUEw6uPY28exSWu
 Ui2RYrrzdZUqfNPEMC8jxT/lYhoe1ojMV+en/E8I59X0iSTy2GA8C7eRgb9Hl+jDQPzt
 uGgZmzNC99iHsV/YbmIM2nufv/vPPMdfMug5B1JJNUW80DAyDUAZ+iqwQmXtQ4Wg1aW4
 zWdA==
X-Gm-Message-State: APuU4Z/GmWBd1kZyeLIX/y5VVUpA/DKrm01B0mhIcwXLw+KeQ1ue4PLY
 Q+XycJ//V7Vc0jnW3Vydh8SgOIpMXEEj518FsYwLu+tj5Gvo2A0Xy4BjPXrGOA==
X-Gm-Gg: AYBFou2Y5XwNX5D+EBiC2arGnTr8tp1k8lMm6wKm0oiRxyUJ39dg5Q9UAv7uP/cqWcM
 bAlu07HQQZrF6TL/6HvCx6/aSdjIgF59HwCeufaIpigJu2c99PGbVNhjeg9hzjqyJ0vHYtW9Lh6
 WQPfcm6oNRjGjs4XFlopdjr6rz6h6oRsjp36aPFtTbFHAa8rbyLPgkTk3iYBWFWW04zpQNZ4Dst
 cd6d86UwqOwBEUzG2+2jMnIkvW2i5PQ9QRLXXSzyX3HG1Ud7r8dbS548aGz7OXwWworQtdBarud
 xe4AS6q0lo3oPuddVikVU+syCnRcwDuUO4Ua0BhYQS/sHGDOmJo5rq2HURAwBgiN6IWyjCYPUjM
 68RJCUWMxOUYfCAdlFD4NKJtEowISNxf96uBMFZ8DqTdPphjF3DapyxBNNS9AH79ZZIsYKEWgnQ
 NrtdBWH/Ewly3oHgm0dzcwuXpmZOnjQJJrDt1Nw5e6pMdln0ygeXSgqJ3vYzTNxAC3XBY5j+TE0
 0Jg5N7kyWsszRSKfWSkO8BqZAeF4WM1MPZcHptrtAAF4SirtJjOQgBj1le1Bf9lRP/+Tk6BKy+e
 m7dveMbnBv107HFnX0hHeM2uoMySOJLd2Rwqs2is1m6QPW9M8BZoqcGDRZGx4GRHwv4=
X-Received: by 2002:a05:690c:6204:b0:8b0:a30a:7f31 with SMTP id
 00721157ae682-8b36caba6b2mr18827467b3.29.1794205999423; 
 Sun, 08 Nov 2026 22:33:19 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:18 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 5/6] drm/gma500: Propagate SGX MMU setup and GEM pin
 failures
Date: Mon,  9 Nov 2026 03:33:02 -0300
Message-ID: <20261109063303.32658-6-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check the GEM GPU address and perform transactional MMU insertion before
changing cache attributes or publishing the GTT mapping. On failure,
release temporary pages without publishing a pin and return the error.

Propagate stolen-memory mapping failures through probe cleanup before
installing a hardware context. Existing cache-attribute error handling
is unchanged. This depends on the preceding rollback fix.

Fixes: ae012bdc5799 ("drm/gma500: Hook up the MMU")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
 drivers/gpu/drm/gma500/gem.c     | 19 ++++++++++++++-----
 drivers/gpu/drm/gma500/psb_drv.c |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index fa5d3f137..c79713e26 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -32,7 +32,7 @@ int psb_gem_pin(struct psb_gem_object *pobj)
 	struct drm_gem_object *obj = &pobj->base;
 	struct drm_device *dev = obj->dev;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
-	u32 gpu_base = dev_priv->gtt.gatt_start;
+	u64 gpu_address = (u64)dev_priv->gtt.gatt_start + pobj->offset;
 	struct page **pages;
 	unsigned int npages;
 	int ret;
@@ -44,6 +44,11 @@ int psb_gem_pin(struct psb_gem_object *pobj)
 	if (pobj->in_gart || pobj->stolen)
 		goto out; /* already mapped */
 
+	if (gpu_address >= BIT_ULL(32)) {
+		ret = -ERANGE;
+		goto err_dma_resv_unlock;
+	}
+
 	pages = drm_gem_get_pages(obj);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
@@ -52,12 +57,14 @@ int psb_gem_pin(struct psb_gem_object *pobj)
 
 	npages = obj->size / PAGE_SIZE;
 
-	set_pages_array_wc(pages, npages);
+	ret = psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu),
+				   pages, gpu_address, npages, 0, 0,
+				   PSB_MMU_CACHED_MEMORY);
+	if (ret)
+		goto err_put_pages;
 
+	set_pages_array_wc(pages, npages);
 	psb_gtt_insert_pages(dev_priv, &pobj->resource, pages);
-	psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu), pages,
-			     (gpu_base + pobj->offset), npages, 0, 0,
-			     PSB_MMU_CACHED_MEMORY);
 
 	pobj->pages = pages;
 
@@ -67,6 +74,8 @@ int psb_gem_pin(struct psb_gem_object *pobj)
 
 	return 0;
 
+err_put_pages:
+	drm_gem_put_pages(obj, pages, false, false);
 err_dma_resv_unlock:
 	dma_resv_unlock(obj->resv);
 	return ret;
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index d17cb5b4a..d942f7264 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -354,6 +354,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 					  dev_priv->stolen_base >> PAGE_SHIFT,
 					  pg->gatt_start,
 					  pg->stolen_size >> PAGE_SHIFT, 0);
+	if (ret)
+		goto out_err;
 
 	psb_mmu_set_pd_context(psb_mmu_get_default_pd(dev_priv->mmu), 0);
 	psb_mmu_set_pd_context(dev_priv->pf_pd, 1);
