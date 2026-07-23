Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DCDC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF7010F048;
	Thu, 23 Jul 2026 09:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nJx7M8mX";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7171110F048
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:51:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495437bb891so2898245e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784800266; x=1785405066; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h9FrgNeXvQXeP5ztByoZ2RKg2y/qZdfAkNQeX3ODWAs=;
 b=nJx7M8mX0AwRINDNOSf7MdXZkmVu2zz+bFeREVhNRl+Cc8/OGyljSzRyODcX2xhTwp
 cen3qW0is2tR00bTMHuDEJhobUjNZGo4PX0f9glMNGDz1rNUUsz0CQkXwl1fwrUr3tjK
 Bi7uPZC46gdJ0ogEIJl2BmhJMfVnba0Vrx5DMTgpAAmFPlSFVh3qElSoxqqAi+nTy8dS
 3Rr23rkPhYmlZD9+RbBiBtSEXtYTyLbRW3gmsPQ3IaMjXrdG6pnSiaO60p7mnGeTxTZV
 yvRPvYCsU606aiz8FEhAA3f9MrsAoi7EPl6hRGet/Nt4iTGDuvm12v2WB1cEHpNXIkKP
 ABKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800266; x=1785405066;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h9FrgNeXvQXeP5ztByoZ2RKg2y/qZdfAkNQeX3ODWAs=;
 b=sSlfgQSbY531ExTkMahcHqkXKi0Ghj/aygoYIDbjSdvV4IxOXVnXuBfpiulZyIqoQg
 e09XNE+fAy+Xuc4zJotuamiyxiQUU1ubGeBc0G/Kfl20fJsFINjfkF1+lH3b1X+GtZXw
 F790hSl5V4do44aksNHweVIMlyVxXDpSaXX5eseNUWtDacHmwjWT/gfGU9Yf4iVkPAqr
 XP9s0FYwGRGX9YWClCy/5aV7FD/d426z+9vhnrb9Ba0dhsn1YaKzZDpJGELMu14AtKKl
 ks5E6WlXP2tYwuC4uH4g9thRVFhriuhkC8eMLv92LFxn6D4fcNji4CvW2DrCFwMuAb/X
 /cYw==
X-Gm-Message-State: AOJu0YzWpWFYWZXyww6ATsmE+BLbO1ydRYNWNYBkHSnoIgxwHDfTnKZn
 33vxIg2jqad3Fv32LsPMay9r6gYFMoW5ut9Ofr56QnbWncz660+OAP78QWV/sw==
X-Gm-Gg: AR+sD11ywfp8cW0tSjNXOASh5Ls35S6sGLGyGIMa8k4I5XY5DSzoV50nnEmRRWS1zn1
 5RQ7NHwnGorK7klcOr9sgpixgs3OPWqoJtla4ARPCpIzBYfkq4uUjEKMdaupNJIJ9GEtcU2o8CQ
 NRgZ5bsiQQygA/PT+4BK78mU+buXdsfMnJ5K2sJ3Iy2TInRqyNfQPwbXC33UkT8b6gBz6IRBmau
 vAq5quWrN6Libdb1kMo8w/plMMxMoIgv6xlbfQQXp4jYWvKNlyzEsDBzGJJyJaRlGlXn6Iafu8Y
 H/CnMYufLs7ndVVVxL+suhwdxh3DtXZIFVYZ0RHMf+pKwlAEdAx+9H0MQtpN1Zbb7KhnJXc2dXt
 4OsB6SUBUEddhITeVq1eM+mgHB3xugArofKMb4LMnchB1bj3mQ2LhYAk0bBDZkGZfwgovyff0qr
 ys
X-Received: by 2002:a05:600c:4684:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-495745ac56cmr20876415e9.16.1784800265223; 
 Thu, 23 Jul 2026 02:51:05 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495765e3f3dsm16288645e9.2.2026.07.23.02.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:51:04 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:51:03 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org,
 =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito@redhat.com>
Subject: Re: [PATCH v3] drm/tests: shmem: Set DMA mask to 64-bit in
 drm_gem_shmem
Message-ID: <amHkBwhcNaUPQqd7@fedora>
References: <20260703150808.3832-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703150808.3832-1-jose.exposito89@gmail.com>
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

On Fri, Jul 03, 2026 at 05:07:43PM +0200, José Expósito wrote:
> From: José Expósito <jose.exposito@redhat.com>
> 
> drm_gem_shmem_test_purge [1] and drm_gem_shmem_test_get_pages_sgt [2]
> intermittently fail on ppc64le and s390x CI systems with a DMA address
> overflow:
> 
>   DMA addr 0x0000000100307000+4096 overflow (mask ffffffff, bus limit 0)
>   WARNING: kernel/dma/direct.h:114 dma_direct_map_sg+0x778/0x920
> 
>   drm_gem_shmem_test_purge: ASSERTION FAILED at
>     drivers/gpu/drm/tests/drm_gem_shmem_test.c:330
>     Expected sgt is not error, but is: -5
> 
> The call chain leading to the failure is:
> 
>   drm_gem_shmem_test_purge() / drm_gem_shmem_test_get_pages_sgt()
>     drm_gem_shmem_get_pages_sgt()
>       drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
>         dma_map_sgtable()                  [mapping.c]
>           __dma_map_sg_attrs()
>             dma_direct_map_sg()            [direct.c]
>               dma_direct_map_phys()        [kernel/dma/direct.h]
>                 dma_capable()              Checks addr against DMA mask
>                   -> FAILS: addr > 0xFFFFFFFF
> 
> The root cause is that KUnit devices are initialized with a 32-bit DMA
> mask (DMA_BIT_MASK(32)) in lib/kunit/device.c. On ppc64le and s390x
> systems with physical memory above 4GB, page allocations can land at
> addresses that exceed this mask. When drm_gem_shmem_get_pages_sgt()
> attempts to DMA-map these pages via dma_map_sgtable(), the DMA layer
> rejects the mapping because the physical address overflows the 32-bit
> mask.
> 
> The failure is intermittent because pages may or may not be allocated
> above 4GB on any given run depend on memory pressure.
> 
> Fix by setting a 64-bit DMA mask on the device before calling
> drm_gem_shmem_get_pages_sgt() for all tests, following the same pattern
> already used in drm_gem_shmem_test_obj_create_private().
> 
> [1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_s390x/15128551935/artifacts/jobwatch/logs/recipes/21561049/tasks/220716793/results/1014626315/logs/dmesg.log
> [2] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_ppc64le/15128551933/artifacts/jobwatch/logs/recipes/21561041/tasks/220716705/results/1014628163/logs/dmesg.log
> 
> Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
> Closes: https://datawarehouse.cki-project.org/issue/5345
> Closes: https://datawarehouse.cki-project.org/issue/3184
> Assisted-by: Claude:claude-4.6-opus
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: José Expósito <jose.exposito@redhat.com>


Applied to drm-misc-fixes, thanks a lot for your review Thomas.

Jose

> ---
> 
> v2:
> 
>   - Move fix to drm_gem_shmem_test_init() (Thomas Zimmermann)
>   - Link to v1: https://lore.kernel.org/dri-devel/20260703063517.6346-1-jose.exposito89@gmail.com/
> 
> v3:
> 
>   - Improve comments (Sashiko Bot)
>   - Link to v2: https://lore.kernel.org/dri-devel/20260703142749.4099-1-jose.exposito89@gmail.com/
> ---
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index 44a190109249..5e69ff1d1ad6 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -95,13 +95,9 @@ static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
>  	sg_init_one(sgt->sgl, buf, TEST_SIZE);
>  
>  	/*
> -	 * Set the DMA mask to 64-bits and map the sgtables
> -	 * otherwise drm_gem_shmem_free will cause a warning
> -	 * on debug kernels.
> +	 * Map the sgtables otherwise drm_gem_shmem_free will cause a warning on
> +	 * debug kernels.
>  	 */
> -	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
> -	KUNIT_ASSERT_EQ(test, ret, 0);
> -
>  	ret = dma_map_sgtable(drm_dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> @@ -352,11 +348,19 @@ static int drm_gem_shmem_test_init(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm_dev;
> +	int ret;
>  
>  	/* Allocate a parent device */
>  	dev = drm_kunit_helper_alloc_device(test);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
>  
> +	/*
> +	 * Set the DMA mask to 64-bits to avoid intermittent failures calling
> +	 * drm_gem_shmem_get_pages_sgt().
> +	 */
> +	ret = dma_set_mask(dev, DMA_BIT_MASK(64));
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
>  	/*
>  	 * The DRM core will automatically initialize the GEM core and create
>  	 * a DRM Memory Manager object which provides an address space pool
> -- 
> 2.54.0
> 
