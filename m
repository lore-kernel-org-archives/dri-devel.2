Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37BB10E1E5;
	Fri,  3 Jul 2026 14:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ehtt5AtR";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4C610F829
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:30:15 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493c00f74baso3967065e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783089014; x=1783693814; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tMsZehFZxnEebhNAaTggDAJKcB8gIw83JVVP0PiXA10=;
 b=Ehtt5AtRd971mmDjEZVbsvHRDZLBkrwINPpXvf98Lk4NtFMtncHYlMhatteyVv3tF9
 +nPLt2/WiGCCqVKsagFOVj6Ivo6/s454Llgrz/+6ScS+vSurGKI8akHt6tKSJx+xLPyT
 vXRT8K3pu0MBJQloxEesnjdMbHxuA6Z8WBTyA+LpkPNBLyupkJnEiRrl83PE0Uh4qCpJ
 d/2+PM47A4sJ+0bQJu8QLQHuYnbssZJdTpggzm7ZvZbqcRKlDI4hFGH7+oYF87uRm+e2
 B9tMjBwNmtDJTwOl+vV9bP0Hq+XJjReyclpyygqPO0mb9uKfCd/h43z4frSZRcg3wQIN
 4CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783089014; x=1783693814;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tMsZehFZxnEebhNAaTggDAJKcB8gIw83JVVP0PiXA10=;
 b=E8f92gOGor1Z2qnvINu+WdIq2+yklRSnJZ2FsHbsZy832FxcE5S8JNHdLMFM0XaZrK
 tzkm/Uh/culOf+AYdnCtU9L0CDOKkcJGi/8LhWwBnO1pTvu3Kved2s5azPQYjxZEjnfE
 3V2iZUlHXTrdlcE1uwsbRBiyqiROfPT2uVfYjXTe2EBT5MnNx/fSoczzhfnKtnSAPKMm
 4VZYt8hxTjnfCyEpmyxT86c0LxJxtyzdYHFelbzvHcN0hBWBul3rsx3whnY3CFHPA/Xm
 /klFjfNl/OO0LR/7tNc9AM3NkuvMTexZbStUO4NjzuAwqztmU/Vo7g5rPV7Fkm32/lEB
 /2xA==
X-Gm-Message-State: AOJu0YxwfpiDOH8XGfH5+RDKfeKQHgCmmr8BPifXoTOcDLDK/3OfKrnu
 Jo0uzU7m3Kg4uk4LAU/tHJ7McYbVivHjeCwyGRS+yTaNaapJb3veiGAR
X-Gm-Gg: AfdE7cmlcpwKDePv5KCR+BAVjivue4dDhIbjEEkha2+oTN1NPrT+KgwrreAD7YzhUt+
 +/9Msz0TI9i9kpo4/5XsQmI8LarF6/8oMV2gKTlujIj2apN6lbGV40zPyjbhHjJwBG0cqI5Vs5m
 baE+C6SpIzVmSk0+zJxsHTl08q8Tp6Ksq50edgGMLl5rJCvSBNzwSEbRH6zWuerbamPGniCjbUL
 IzeJ/u6qNMS0bTG9N/hdoSJ4V3OrlBOGDluJz3gW4dgpW8+qYCpXRdrmSkrLuGzWodbKcaPHfrO
 mpQLSj9Rz61IymfLeMqwe1WBsCSiCapoHl3u/XBGtUnqAtv16Xb9mRtlROqNz2bdMQ8BLZYl2ai
 CC5pzZdn8ggEcgbHf7quR8CTwGgpQ68tePK0VUFfm/g3DkhroEzowSvtDSHQca2BSpwYv970ST7
 J2tPDrwPGE8ag=
X-Received: by 2002:a05:600c:a00e:b0:493:b91c:6bf with SMTP id
 5b1f17b1804b1-493d0f32fe9mr1178165e9.18.1783089014127; 
 Fri, 03 Jul 2026 07:30:14 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm173315555e9.0.2026.07.03.07.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:30:13 -0700 (PDT)
Date: Fri, 3 Jul 2026 16:30:12 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, boris.brezillon@collabora.com,
 kees@kernel.org
Subject: Re: [PATCH 0/2] drm/tests: shmem: Fix intermittent DMA overflow on
 ppc64le/s390x
Message-ID: <akfHdPXvbROST6eB@fedora>
References: <20260703063517.6346-1-jose.exposito89@gmail.com>
 <dcc6e658-210f-4cc9-a589-369d7983f170@suse.de>
 <akd6NQvMG6-4sWQQ@fedora>
 <285af006-f403-4c3d-8cd6-e0318c188b85@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <285af006-f403-4c3d-8cd6-e0318c188b85@suse.de>
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

On Fri, Jul 03, 2026 at 12:32:18PM +0200, Thomas Zimmermann wrote:
> Hi José
> Am 03.07.26 um 11:00 schrieb José Expósito:
> > Hi Thomas,
> > 
> > Thanks for your review.
> > 
> > On Fri, Jul 03, 2026 at 08:53:30AM +0200, Thomas Zimmermann wrote:
> > > Hi
> > > 
> > > Am 03.07.26 um 08:34 schrieb José Expósito:
> > > > Two drm_gem_shmem KUnit tests, drm_gem_shmem_test_get_pages_sgt() and
> > > > drm_gem_shmem_test_purge(), intermittently fail on ppc64le and s390x CI
> > > > with a DMA address overflow warning followed by -EIO:
> > > > 
> > > >     DMA addr 0x00000001130b0000+65536 overflow (mask ffffffff, bus limit 0).
> > > >     Expected sgt is not error, but is: -5
> > > > 
> > > > Both tests call `drm_gem_shmem_get_pages_sgt()`, which internally pins
> > > > backing pages and DMA-maps them via `dma_map_sgtable()`. The DMA mapping
> > > > path is:
> > > > 
> > > >     drm_gem_shmem_test_purge()
> > > >       drm_gem_shmem_get_pages_sgt()
> > > >         drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
> > > >           dma_map_sgtable()                  [mapping.c]
> > > >             __dma_map_sg_attrs()
> > > >               dma_direct_map_sg()            [direct.c]
> > > >                 dma_direct_map_phys()        [kernel/dma/direct.h]
> > > >                   dma_capable()              Checks addr against DMA mask
> > > >                     -> FAILS: addr > 0xFFFFFFFF
> > > > 
> > > > KUnit devices are initialized with a 32-bit DMA mask
> > > > (`DMA_BIT_MASK(32)`) in `lib/kunit/device.c`. On systems where the kernel
> > > > allocates backing pages at physical addresses above 4GB, `dma_capable()`
> > > > returns false because the address exceeds the 32-bit mask. The `dma_set_mask()`
> > > > function updates `*dev->dma_mask` to the given value; setting it to
> > > > `DMA_BIT_MASK(64)` allows any physical address to pass the check.
> > > > 
> > > > The failure is intermittent because pages may or may not be allocated
> > > > above 4GB on any given run depend on memory pressure.
> > > > 
> > > > A third test in the same suite, `drm_gem_shmem_test_obj_create_private`,
> > > > already calls `dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64))` before its
> > > > DMA mapping. This series applies the same fix to the two remaining tests.
> > > Instead of doing whack-a-mole, is it possible to move the existing fix from
> > > drm_gem_shmem_test_obj_create_private() to _test_init at [1] ? The DMA mask
> > > would then be the same on all tests. [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/tests/drm_gem_shmem_test.c#L359
> > Yes, I think it is possible. However, this is an intermittent failure that
> > I couldn't reproduce locally and I tried to reduce as much as possible the
> > risk of regression limitting the change to the 2 affected tests.
> > 
> > I'm afraid I don't have enough knoledge about GEM's internals to know if moving
> > the fix to the init function could introduce unwanted side-effects in the other
> > tests. If you think it'd be safe, I'll trust you and move it.
> 
> Please do. I don't see why it should not work, and it's an easy revert it
> doesn't.

I just sent v2 with the suggested change. I run the test in several
architectures and I didn't run into any issue:

https://lore.kernel.org/dri-devel/20260703142749.4099-1-jose.exposito89@gmail.com/

Thanks,
Jose

> 
> Best regards
> Thomas
> 
> > 
> > Jose
> > 
> > PS - Next week I'll be away from keyboard, so any change would need to wait a bit
> > 
> > > Best regards Thomas
> > > > José Expósito (2):
> > > >     drm/tests: shmem: Set DMA mask to 64-bit in
> > > >       drm_gem_shmem_test_get_pages_sgt
> > > >     drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem_test_purge
> > > > 
> > > >    drivers/gpu/drm/tests/drm_gem_shmem_test.c | 9 ++++++++-
> > > >    1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > -- 
> > > --
> > > Thomas Zimmermann
> > > Graphics Driver Developer
> > > SUSE Software Solutions Germany GmbH
> > > Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> > > GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> > > 
> > > 
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
