Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A48606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMySI1SP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E413610E69F;
	Mon,  9 Nov 2026 05:55:19 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B9810E685
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:55:08 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-67583c777abso564293d50.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203707; x=1794808507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=By4YKJPwkvqXleS4TekGiY9zokvFWmRdIpuA5Cf+kg4=;
 b=VMySI1SPTkbIvELZKZaABL5AVjulc2JuDi+KDM2M/0HtrYubDaaRGMIRPMl8IxYd/h
 +wNsiwsZmGjF2KQA5e+BJGX9HgWzI3ANRcexvdSsimVKh7vQUsLFSrB7x73uWraz+XkC
 xlK2EK8fbYMf9OX/QhjWmeudjn1ZmMndR+6QIDFVN6kgqiFE7mutxLWPifdnuAtJgO05
 G88mAcPXOzy3Hl8R6rDaprAq62vyUhy4MSFHP3XjO8CJRihOm42V0wWHW/ngpKtD6zPd
 vGFdcRcITNT+eEu06uE58g+67iT3ILuQ6ZuIQYTlP0l+34hR05w71Vh5TSRYvwoqKXLe
 +mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203707; x=1794808507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=By4YKJPwkvqXleS4TekGiY9zokvFWmRdIpuA5Cf+kg4=;
 b=l24QuP4Tm/k2zxwi/CHAcGn7qWyREo6a0Zubx4cueBE8pJZU+kvylzftTdTtcmd2kL
 PWcLlW98rUIXyWIoLf8Pej5VLJdZCfn/B4Uk6ORMMPlMe9Ec3jWlZHh+S1NANQ7E1M55
 QBW1QRvBkQfZ/YXohrRlqwmYSZDvV9j+VlUjrKlP5+zal1aJ44xBfb2dlCt1exLiXqkY
 CjUIcufEGX30Dsxha41vFAleIyfj4OLanIn1SUWxjGTIGXZcxVcJyv61ZU784eXK5s7r
 0mSAG1XAile70IKjZGxu09/4Har/Iawdlv05qA8Up6mHbMIPpT8Mu4uuDQUVHa2G96Ho
 5/pw==
X-Gm-Message-State: APuU4Z9ADOwLW5iPKsCATX3R1SgNHW1Y4nIOTnVSaZzq+edEPQRloCyG
 a2bWwu4RgquwGIzkqZdkvZnRf7+UnicIIM2uW2mCLst9swdfyajcj+HfrVQdIQ1X
X-Gm-Gg: AYBFou3nW6ytl2IgyvBMeTInvge1pkVtLRjHLvZhcRxI3JPFrp0sccKsHfqAM31ol2n
 ZtL4WSl0oz2zCGY2LpA0soZLnM5nEfL4KrcKioCjpCarlpZnqx28P9oXy5AJ3mXQwQm8CplLY9T
 HJ1zqPOMOmeK0y8+9nk5EmrNRb9LGIRwCIvOFtxQTyka/MaSpAMzhy5Imwd60xk1qHtfNhZ2fF5
 plM12ZeOUdPXqSoAAySz2BG2Aadn93UIfeTq6/MThD5/jK6LlDGSwXNl5kSCZm9cChhC+VyvtYt
 57X+JgCjSwiiGciSPF5vmq/WDCWB+gfDWtnsDhev4OF3Pz0leUywyyZCOBxgXrBYEw9KKuxy8+w
 WEneCORncLNLFzAYEheC0tRqSYBKJpG3jsMUE80SZqS0aVFb7An8tXhYuSoLEMfoCnGX7pb0c9Z
 J745xSEd3O4ga9m8o94RCJCHbYQsifO6KHHHdHI+yxeNO6eU82j/L+FQ+M2oOAsqqPmtgnoi4Er
 s+DdsbymSh2uENBZ+qsC8j+Nd4nhGQwPr74VV1xFpLaBd6YUA8aoTWG5EcImlCkguA19GoJ3kEc
 4ZJwFrgY+Hu6oovDfS1yth2GKtlZVpnCL7yKouX/huPwKPfEbreepZG3fUewI46B2tV9ZGtXNER
 49KMrZrbKms/rIA==
X-Received: by 2002:a05:690e:b88:b0:67c:18:cc8d with SMTP id
 956f58d0204a3-67c29723f28mr3509662d50.0.1794203707490; 
 Sun, 08 Nov 2026 21:55:07 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:55:07 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com,
 Gabriel Gama <operatingsystemsdepression@gmail.com>
Subject: [RFC PATCH 5/6] drm/gma500: Propagate SGX MMU setup and GEM pin
 failures
Date: Mon,  9 Nov 2026 02:54:49 -0300
Message-ID: <20261109055451.17458-6-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
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
