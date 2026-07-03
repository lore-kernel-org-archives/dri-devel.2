Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E24C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E6210E59E;
	Fri,  3 Jul 2026 09:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QteJ+t1w";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F6410E59E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:00:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b61b52b6so1924435e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783069240; x=1783674040; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=17LXBsqJWXMdbXOj6D6oFUX+lcM/gu/+EbDoLE3v86Q=;
 b=QteJ+t1wJaQDnwu1AX0wBUpQwqepJL/S9ahDvaWNz7GDfajkfhC3uX4bOX/iSO+Ar7
 tYguCYf2ZeSRV+CP9FE1ibNhqHo4R2haNqjYgby/tVmmr7WodGA2EAC964NUhAMNVf/d
 6CJtKIs/5VhbXs2t/eav0RQFZs5jZyDq9hu63xR+meyGC5h5QsmXYgIBs+a3PU0so2JN
 FWeSQ9n+lCYNFt6euTMzgy66CJf4ughEZ4vBHCL18cQZwL+Iz6AE4MYe01pMynydgVQC
 IIK6z5sSeIS252EEl63tPqknEUrIBBSF2kztAt1qseHRAEc2InWxmCpWDRV51d/xCEwO
 gO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783069240; x=1783674040;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=17LXBsqJWXMdbXOj6D6oFUX+lcM/gu/+EbDoLE3v86Q=;
 b=XPhQIEMU39oO0dyWBEZfhbEYQyptGXZCWXSDGLkxwa894Z+AIv+0EOSjxDP4wx5j3l
 K696ZhNfnQS2KTpSHaZ2wzc4kwUJwJIEJ9AinS7IZzECXsbjpX5jAWc6CVm7KvwOlwfp
 Cs6742jUTgAKTxIJnxDC5GxCbNbOmEFw3rpCfwenVQF/fayghPq80yJw/JGmTepI0b0m
 fkmGbsYksnHY4L6abOqvaMRikuCsXoLZORPr1U9woyQuWA93ZYUC350NxWooefaegjQH
 +G2cBtdBr0hMOQFzNj7HnJVUBpi8jLfDGIQ1M2sQYr8hEdQb4FEt+n44Y5IV3idZwEvm
 pC/g==
X-Gm-Message-State: AOJu0YwXQNNr0qf3gGPhFbEekYExbHgsfIaza8K0mrWAHuPve9K6YtEr
 s+VNc4DkCyatizuSU1MiUEyDJIBDV17zZWyUWkbASElOIlt5ylfnF+RolpA8QQ==
X-Gm-Gg: AfdE7clb9HQpVtVV3Y7E5at3ey+yeTf5TaeoBLOkPut6f6tjeVwTmHubRNZhsl56aov
 ZKY+icbfdG/T8R7MVWaiH/BLUXVlZPPEi+jTm9nsWZk0uKaeTyyTmvx4nZ0QNRE+wflzD12aeR2
 +2UFfgJu1b8e4tvrFY72QWfV5aMRu/5JJ3RUK0dOXo0Lpt2ju5BeyxOxd27KQGIoCyCHqAQE5zV
 6EKF4vEdXOy5RfJVwsGvg1j+wdYRloaNxKXmL7QfElqBiaiq+4MKh5bxPALHnKVyie+PMdLu4MZ
 XL/OElJFC91bVCyer1hMupqjpl98NKfjTaaQu/hbdm9kZUk+v5JJA1ZMGM9Cj171LAraRppcFip
 L1sl5o8Fdw4lIM9iDGJivK28lTZ8Fr4c3qiMJuZOudtaDGahEQohAfHGTl59XiotmHBDmUa81nh
 2t3KYVaT7B4zo=
X-Received: by 2002:a05:600c:60a:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-493c3cf49f7mr80184765e9.30.1783069240081; 
 Fri, 03 Jul 2026 02:00:40 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef17c82sm129905895e9.1.2026.07.03.02.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 02:00:39 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:00:37 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, boris.brezillon@collabora.com,
 kees@kernel.org
Subject: Re: [PATCH 0/2] drm/tests: shmem: Fix intermittent DMA overflow on
 ppc64le/s390x
Message-ID: <akd6NQvMG6-4sWQQ@fedora>
References: <20260703063517.6346-1-jose.exposito89@gmail.com>
 <dcc6e658-210f-4cc9-a589-369d7983f170@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc6e658-210f-4cc9-a589-369d7983f170@suse.de>
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

Hi Thomas,

Thanks for your review.

On Fri, Jul 03, 2026 at 08:53:30AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.07.26 um 08:34 schrieb José Expósito:
> > Two drm_gem_shmem KUnit tests, drm_gem_shmem_test_get_pages_sgt() and
> > drm_gem_shmem_test_purge(), intermittently fail on ppc64le and s390x CI
> > with a DMA address overflow warning followed by -EIO:
> > 
> >    DMA addr 0x00000001130b0000+65536 overflow (mask ffffffff, bus limit 0).
> >    Expected sgt is not error, but is: -5
> > 
> > Both tests call `drm_gem_shmem_get_pages_sgt()`, which internally pins
> > backing pages and DMA-maps them via `dma_map_sgtable()`. The DMA mapping
> > path is:
> > 
> >    drm_gem_shmem_test_purge()
> >      drm_gem_shmem_get_pages_sgt()
> >        drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
> >          dma_map_sgtable()                  [mapping.c]
> >            __dma_map_sg_attrs()
> >              dma_direct_map_sg()            [direct.c]
> >                dma_direct_map_phys()        [kernel/dma/direct.h]
> >                  dma_capable()              Checks addr against DMA mask
> >                    -> FAILS: addr > 0xFFFFFFFF
> > 
> > KUnit devices are initialized with a 32-bit DMA mask
> > (`DMA_BIT_MASK(32)`) in `lib/kunit/device.c`. On systems where the kernel
> > allocates backing pages at physical addresses above 4GB, `dma_capable()`
> > returns false because the address exceeds the 32-bit mask. The `dma_set_mask()`
> > function updates `*dev->dma_mask` to the given value; setting it to
> > `DMA_BIT_MASK(64)` allows any physical address to pass the check.
> > 
> > The failure is intermittent because pages may or may not be allocated
> > above 4GB on any given run depend on memory pressure.
> > 
> > A third test in the same suite, `drm_gem_shmem_test_obj_create_private`,
> > already calls `dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64))` before its
> > DMA mapping. This series applies the same fix to the two remaining tests.
> 
> Instead of doing whack-a-mole, is it possible to move the existing fix from
> drm_gem_shmem_test_obj_create_private() to _test_init at [1] ? The DMA mask
> would then be the same on all tests. [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/tests/drm_gem_shmem_test.c#L359

Yes, I think it is possible. However, this is an intermittent failure that
I couldn't reproduce locally and I tried to reduce as much as possible the
risk of regression limitting the change to the 2 affected tests.

I'm afraid I don't have enough knoledge about GEM's internals to know if moving
the fix to the init function could introduce unwanted side-effects in the other
tests. If you think it'd be safe, I'll trust you and move it.

Jose

PS - Next week I'll be away from keyboard, so any change would need to wait a bit

> Best regards Thomas
> > 
> > José Expósito (2):
> >    drm/tests: shmem: Set DMA mask to 64-bit in
> >      drm_gem_shmem_test_get_pages_sgt
> >    drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem_test_purge
> > 
> >   drivers/gpu/drm/tests/drm_gem_shmem_test.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 
> 
