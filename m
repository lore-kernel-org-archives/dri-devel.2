Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13530C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDEC890CE;
	Thu, 16 Jul 2026 08:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrK0sEdq";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A260310E168
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 09:28:17 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7e6b554044fso4401173a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784107697; x=1784712497; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZnbIoDxi2GapRWlrmBlXMx1BB+ECtF1C6EhxHJoyFKo=;
 b=LrK0sEdqgOh1euGQZeXDqWiA6pHeuJHFI4i2m9kYfWz6A72AcQUvull3ogb/4XQ8HX
 mwmeNa7fX9mg1Rq+viZJcpOeOfgmqLd15fiDx+Nsb/CXf3L6/CvhwKDuIcMNHrA3E3Ch
 iU6IdOSRNdEbdXqRJ8rROlWxlbXsauYlGlHFWzN4c/TjkQ2GvpIdLnyc9jkpI8LQB2IQ
 px6P7akHky+3BdPKeNrdsgz0hehIx3VG5Zln7+9zeYfPer50z43Iro7BGdxQWz2VU9KH
 lnrNYK/dQPrCzpjg3Uy7U1Mn8arDOSYiCcGUJ71koVh8pY8xhR1gb40SFB1HixyFowXm
 8yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784107697; x=1784712497;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZnbIoDxi2GapRWlrmBlXMx1BB+ECtF1C6EhxHJoyFKo=;
 b=VzYWalNSei5r2uPQZ9MRpj5P51mqMoPypx8ajgU5jot/K4qzF8zc2PJy0vycxP5RDa
 UVVYomXIt/r30W+lLyuuQ8T6aVOFqcNGPcZ/qIveEZdzNd/y4WbqCmA889hGKpqNSnul
 tG6GyaNJYlAVhkxBGBPul2kpPkoPpHKScS7N4f0sECXcGxmQt97KHqO4Ge+KRhDc5gR3
 EH2gi6pQuXaVB7dyb+IkrStJGRmMdxLRLzY6xOud9YkDvML8Jb5NjbEzmWQB/OxGWAjq
 KiYitYTly0/sm+SIncmH2u+S+Kwe5DLfiGzmn5bGXae7sMRqBZMpqLKEQQMY1J+QiM0J
 3mRg==
X-Gm-Message-State: AOJu0YyFiOmEPnzXPWnCR7zrJ5541IlvoSF/MfJeqaH9PFPNkIVCBV+X
 GI9fF6nD+6vc4Pa+H3VUT5lT87T5Xt5ltKHwg8aOpWvphp0/xG75YcbxCDMhJEi18Yg=
X-Gm-Gg: AfdE7cm9N2uj0HqW9Lk63MYoj7SjOEQMDpwWbe92lesMHUAJ+xxWODuKc+FTFjyVDcF
 64d/ihx8X2mm6jdQC9f4cu5WuCEaPFncRAR+G36a9F77dATVs4HGlDeszTruE3OLmzeOCAp+OG5
 bUZNGfBUG0xC16/E9hEFnxUUO0XoSBWDxCVctl1r+XJCg28N3geJL5gGsLycXmjDVjH0ab9WTif
 +hl5yFzVnDOcz48a5oeDsnJp3EFHkarJ2nLIdm/0oImssSv9IPWuf+UwJ6plNhcNL5eDVmmFBGk
 Zd4pWxo6XgBTAsgVKDVRMY2aT9xyAHQO9oD9StFSHJWAL4JoeoaiMDIjUP6jOHYOlHoAnAFNPOR
 WMmViY1On06DMnWEQEtkHcTtNxn6l6wW+S5P8fHVN5zXgdDKGLPbkoA/bNtXDtd7atw7hxIsfDz
 HbtKU1gz8opxJ+RlKihXvMP+XugcFwCPx+Sw==
X-Received: by 2002:a05:6830:6b0d:b0:7e9:db7f:49a2 with SMTP id
 46e09a7af769-7ec4ab3fed5mr3048090a34.19.1784107696616; 
 Wed, 15 Jul 2026 02:28:16 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:45::])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ec14489139sm9059985a34.5.2026.07.15.02.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 02:28:14 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:28:12 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <aldSrNgB4+EJRI0X@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260710072712.BC57B1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710072712.BC57B1F000E9@smtp.kernel.org>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

On Fri, Jul 10, 2026 at 07:27:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] On 32-bit architectures with 64-bit DMA addresses (e.g., CONFIG_ARCH_DMA_ADDR_T_64BIT), passing `dma_addr_t` to `gen_pool` functions truncates the DMA address to 32 bits, leading to broken bit allocations, leaked chunks, and possible data corruption.
> --
> 
> --- Patch [1]: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding ---
> commit 700c87449a5348e02d33589504f632f46bed92e7
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding
> 
> This commit introduces the NETDEV_A_DMABUF_RX_BUF_SIZE netlink attribute.
> It allows userspace to request an RX buffer size larger than PAGE_SIZE
> for devmem dmabuf bindings, avoiding CPU churn for large flows.
> 
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 957d6b96216b3..3ce3cc14bec07 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> [ ... ]
> > @@ -113,12 +114,13 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
> >  {
> >  	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
> >  	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
> > +	size_t niov_size = 1UL << binding->niov_shift;
> >  
> >  	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
> > -				       PAGE_SIZE)))
> 
> [Severity: High]
> This is a pre-existing issue, but can this truncate the DMA address? 
> Looking at net_devmem_free_dmabuf() in net/core/devmem.c, dma_addr is
> derived as a dma_addr_t (which can be 64-bit), but is passed to
> gen_pool_has_addr() and gen_pool_free() which expect an unsigned long. 
> 
> On 32-bit architectures with 64-bit DMA addresses (like
> CONFIG_ARCH_DMA_ADDR_T_64BIT), this will silently truncate the upper 32
> bits. If a chunk crosses a 4GB boundary in its lower 32 bits, the end
> address could wrap around, causing gen_pool_has_addr() to fail the bounds
> check and permanently leak memory via this WARN_ON path.

Let's defer pre-existing issues to future work?

> 
> > +				       niov_size)))
> >  		return;
> >  
> > -	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> > +	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
> >  }
> [ ... ]
> > @@ -288,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
> >  
> >  		owner->area.base_virtual = virtual;
> >  		owner->base_dma_addr = dma_addr;
> > -		owner->area.num_niovs = len / PAGE_SIZE;
> > +		owner->area.num_niovs = len >> niov_shift;
> >  		owner->binding = binding;
> >  
> >  		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
> 
> [Severity: High]
> This is a pre-existing issue, but does this suffer from the same 64-bit to
> 32-bit truncation? 
> 
> In net_devmem_bind_dmabuf() in net/core/devmem.c, gen_pool_add_owner()
> takes an unsigned long for its virtual address parameter. Passing the
> 64-bit dma_addr here will truncate the upper 32 bits on 32-bit systems. 
> 
> If two dmabuf chunks happen to share the same lower 32 bits, this
> truncation could cause overlapping chunk registrations. This might
> eventually lead to double allocations of the same network buffers and
> silent data corruption.

Ditto?
