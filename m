Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70271606A337
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4BE112399;
	Thu, 12 Nov 2026 22:59:13 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2AF10E104
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:09 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b305d38bafso3293677b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524348; x=1795129148;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7n6Ho7cbKGIt/bJ4mNlulH+IAm5/LdmJToLUGkwX7ac=;
 b=rV04bubbEtJ2JnDFEKButriCn7CLmcu8ovMsC93JsscLqb4mb+kohOKiA4tHvLBVvj
 2MjqiuGWlUIkF7P6P91/8FHsgIy0KvDn1FvFNmcdXC99BZe+nBSyl42Y6OggZ0eeaTVG
 PisHIjLb/Kw08O7OHKe8YcXj5lEi+fMCYUamEJ3Yt9EINJvOf86jM6O7YKmP3I0emSdb
 MXWmwwgLsGXJB3WUxqkgS/qlTZdui2tjHlIBAVRGe0Nmgktn2qSicBvG1OgHovyOrLwo
 6EGg8xey2AvY8tjI3IN0lmO6C49RL2IuzSsrEE+NpFznaF0o06Qe2xiiv+SEpOSnbMQZ
 uW0A==
X-Gm-Message-State: APuU4Z8wRZ8nylUoTrwXP9Zu55KAxwBY63xWdMeGbS56FjRFXHRCLmng
 nkd+InT0A/dUJm/WwWRzGEO+NwHYV+GR/8QDQvY9OUKVoINVXkTq2tRQ
X-Gm-Gg: AYBFou1bvIxTqYLuWX1xkZL/PCnbSfCxOf5epBByJV2sImxKlCbWpL9mEEL2yQxtCoc
 mI2nEC+1ChAj8uIAVALpLVd6XS0aMmdGbp2kzbZmrw3tmdpqC6J7kWA0E9VnEDzeODFrn4x5aW4
 S7Pk/N1eL7Fa/tqtoMsg9hF/e7bBR72l8nUF8QFskOvt+W4FoHWF7kL/q9uiiCpP4OTVl1Rjd+S
 qTI3J7XSGAExm+OSkfb2d14MZZKiZkhrXRtwU6t6mDKiyVYR7a2d1jh/sz8ZxSqmtVc/Sw5LaJW
 ymy9uuPbMbMjgooOjhukGurHDA8xcOo18YTb2Ui7RODsjv5joC2yZBiakKG00CCF/5MChcBcgSc
 yx/jE0mGS1t3/2A/H5YPR3myj6LrMZGEdTZb8OiTS9vP6j5A5r9LZEuAxj8TegCha+26fzpehKn
 NySpYpNWjJRKuSV06pHk3vThAtLDuh5DSUE4oaHKcp6Tx5kYOW7Gn3kalsPLtLQm9yx/ZrJpurW
 rnG2yiwxp/99EA8cH1OYDwmqi9q+tQSjDhlShVOvHR2DZWvK/gfC4ZTIj0YpdB7m7G5Xq+sPcCz
 NZGL3hRxTKnuVjWLsmr5f2fsRuN+FQJIZ0Ze+zRjIMad9UG3junLFSNolz9X2ONnFk5lKwoPg7K
 uEm7Mt0DF/wlz6hSVxZN+8nMPwp0TyDWIwcSxI68cbT76NtvgD1URKAq3ipOZIKZ8gOmd++iGni
 vqO22Jky8V7azAkmuhzj7LXgwv
X-Received: by 2002:a05:690c:c189:b0:8b3:5f41:3c3c with SMTP id
 00721157ae682-8b4aa233286mr6243907b3.17.1794524348062; 
 Thu, 12 Nov 2026 14:59:08 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:07 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:51 -0500
Subject: [PATCH RFC 01/13] drm/gem-shmem: Map pages for the DMA device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-powervr-sgx-v1-1-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A DRM device whose DMA goes through another device sets it with
drm_dev_set_dma_dev(). The DMA helper allocates and maps for that
device, and PRIME imports attach with it, but the shmem helper still
maps and unmaps its pages for drm_device.dev, and
drm_gem_shmem_prime_import_no_map() still attaches with it. On such a
device that is a struct device without DMA ops or a DMA mask.

Map and unmap shmem pages, and attach in
drm_gem_shmem_prime_import_no_map(), for drm_dev_dma_dev(), as the DMA
helper and drm_prime do. Nothing changes for drivers that don't set a
DMA device. Of those that do and use the shmem helpers (gud, udl,
gm12u320, appletbdrm), none maps an object's pages through
drm_gem_shmem_get_pages_sgt() or imports with
drm_gem_shmem_prime_import_no_map().

The first user is powervr_sgx, later in this series: behind gma500 its
DRM device is an auxiliary device, and its DMA goes through the GPU's
PCI function.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d654a22a3..4bce0a716 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -175,7 +175,7 @@ void __drm_gem_shmem_free_sgt_locked(struct drm_gem_shmem_object *shmem)
 {
 	dma_resv_assert_held(shmem->base.resv);
 
-	dma_unmap_sgtable(shmem->base.dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
+	dma_unmap_sgtable(drm_dev_dma_dev(shmem->base.dev), shmem->sgt, DMA_BIDIRECTIONAL, 0);
 	sg_free_table(shmem->sgt);
 	kfree(shmem->sgt);
 	shmem->sgt = NULL;
@@ -535,7 +535,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
 
-	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
+	dma_unmap_sgtable(drm_dev_dma_dev(dev), shmem->sgt, DMA_BIDIRECTIONAL, 0);
 	sg_free_table(shmem->sgt);
 	kfree(shmem->sgt);
 	shmem->sgt = NULL;
@@ -854,7 +854,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 		goto err_put_pages;
 	}
 	/* Map the pages for use by the h/w. */
-	ret = dma_map_sgtable(obj->dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	ret = dma_map_sgtable(drm_dev_dma_dev(obj->dev), sgt, DMA_BIDIRECTIONAL, 0);
 	if (ret)
 		goto err_free_sgt;
 
@@ -964,7 +964,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 		return obj;
 	}
 
-	attach = dma_buf_attach(dma_buf, dev->dev);
+	attach = dma_buf_attach(dma_buf, drm_dev_dma_dev(dev));
 	if (IS_ERR(attach))
 		return ERR_CAST(attach);
 

-- 
2.50.1

