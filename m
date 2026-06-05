Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8F8CD8C90
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBD3112D5A;
	Sat,  6 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KIgw9HCr";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC5511AA73
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:44:03 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2c0c2d8b95bso15932835ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780685043; x=1781289843; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VmToUT+A6qp8UgJ/VhXar74M6fIQJS1C/pR1f1V3ExQ=;
 b=KIgw9HCrIemelwWFk0Eno+9iRUBpAOBF9ukO9IF+kuQ/ODWGtvwL/AsBAXcqh9kX8Y
 Jy9nNVcXSslxbsHyppNHRyEr+qEeed/1r4U3x9poNSVxMJKUtdzt6KLjgxSye33R4NFs
 6SOnVzbZ+u1qZpVpDflqQzEw2eYCcXfmEFvYFUFimEGtAELtWCV60ZULRKcm4qOb2aur
 +OFJ0akgoDEFr8sKBMnuABfc+XTmI08sF06ys1bLfQWBKOj0Vyo9hAUOTUuXPynhA6M/
 r3ZqA76e9syg8/vmZdmZv/9/Cwlm5ZvansA8lvQg0Fyw0SCCEOSMakTGURi1Q4FDi6CO
 l3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780685043; x=1781289843;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmToUT+A6qp8UgJ/VhXar74M6fIQJS1C/pR1f1V3ExQ=;
 b=SD/PKlKU5u/qDXKHmuqKr4YYO0aQRbQcqK53eIwxeM3QhGcUXX9d/2rJJ3opIHZRDy
 rxP7N60YeY5gMMIdYKd6zmy2oP124Gak7K+VlTLTppBBQReujOj4NB6Yj2RZTWptz3nb
 julFOORiQ2hMeLuc0pgr3K2OXtB70oZaWFwEEp+/4U5oWrNAqCPBxIbrsR0Os2YJDqZh
 F9+vjlQNkjuTgYGfTDbwD8XFb2wjXtGDCGsedkWTDwL7JuL3UT1pHrhyDJR8WV4kyLqy
 aqXVHHIFteEUK3o4dQLpkbva8NvOQFHY+LaTwOK1BhczJ+4jUcFFja2octY1EROSyv/3
 JJ4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bxabHGZ7ovp0+F/XjxcES65BBAV3mzqxho4GN7NWGgUUY8ih5e0WVFVsS6H6G0gVyzmgSADeQBOw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdQqcwj1pJh3B5WJdY59Em0c8If7DCbjxejbngSolXSqTTdPiF
 DAa9XyE18l/KkcgbvWW2Nf7fKwSOhg1u3T2In4OIj7BSko38e6v7Vrcw
X-Gm-Gg: Acq92OH2BEPFz2SIhiOR61ZHDSeleEKbom+0ClR4j5+A1Xqz67ZIl+NpvHjUcmAE9cX
 rKkm02fdaijz2mFg6GxXHf5RSq78xYaeFH2gk1t369Mz+W5o3ba8eyyaXbsu58RxSe5FJYCGgkY
 Zcc4nZ0Lm5BjzKQCL06ph/EU6OMVCst8B41ToR6Ihu932hDemlG8q/y5C7UCpJjAxipGMKMXN9H
 ENqIYPy0QXWXW6u/twMVoh6R6vwdrYiLY6pfQ0dPIqMLlhdBU1Ie/PFx539V5PURdxPSxVtvUGC
 FwJIL4TvAUizF2UD1Gf+boRzewg0c52OsR2ghq77ajQmJPa3X62ezZwJRwbaaliJf3BJYWcnHE4
 1WqtuEj/vxMfvTXk8A8i9NyxmnpQEhmtnq84KHSXWyNkHX11YTrGVTiE12oQ9WqRnCBK9MWL6Wk
 R414OS/Dr99LfLoyKoStPXZ8yJ1Soleuzne+8AMPLIYi20Q78LyDX1nOk=
X-Received: by 2002:a17:903:18c:b0:2c0:e5ee:f56c with SMTP id
 d9443c01a7336-2c1e881fefemr54368775ad.20.1780685042865; 
 Fri, 05 Jun 2026 11:44:02 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:58::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1663981basm96908105ad.67.2026.06.05.11.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 11:44:02 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:44:00 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/4] udmabuf: emit one sg entry per pinned folio
Message-ID: <aiMY8CpckM8Jav0g@devvm29614.prn0.facebook.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
 <bdce2488-fe77-4f36-9ed6-dd2c785fa7c1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdce2488-fe77-4f36-9ed6-dd2c785fa7c1@amd.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

On Fri, Jun 05, 2026 at 11:30:07AM +0200, Christian König wrote:
> On 6/4/26 02:42, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
> > underlying folio was larger.
> > 
> > Instead, walk folios[] and emit one sg entry per folio. When folios
> > represent large pages (as is for MFD_HUGETLB), each sg entry is a large
> > page. Normal PAGE_SIZE sg tables are unchanged.
> > 
> > Required by net/core/devmem to support rx-buf-size > PAGE_SIZE with
> > udmabuf.
> 
> That doesn't explain why this is required.

Sure, can definitely add. Devmem currently requires dmabuf sg entries to
be length and size aligned when it allocates niovs for NIC page pools.
Though udmabuf is not violating any dmabuf contract by emitting
PAGE_SIZE entries and the above restriction is probably more a
shortfalling of devmem, by emitting a single entry per folio this patch
allows udmabuf to be used by devmem for large pages.

> 
> Please note that accessing the pages/folio of an sg-table returned by DMA-buf is illegal and strictly forbidden!
> 
> Regards,
> Christian.

It seems both devmem and io_uring zcrx at least introspect through to
the sg-table to build NIC page pools (not accessing the memory itself,
however). Is there a better way?

Best,
Bobby

> 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  drivers/dma-buf/udmabuf.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index 94b8ecb892bb..f28dd3788ada 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -141,26 +141,63 @@ static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> >         vm_unmap_ram(map->vaddr, ubuf->pagecount);
> >  }
> > 
> > +/* Return the number of contiguous pages backed by the folio at @i.
> > + * A udmabuf may map only part of a folio, or reference the same folio
> > + * in multiple non-contiguous runs, so folio_nr_pages() can't be used.
> > + */
> > +static pgoff_t udmabuf_folio_nr_pages(struct udmabuf *ubuf, pgoff_t i)
> > +{
> > +       struct folio *f = ubuf->folios[i];
> > +       pgoff_t j;
> > +
> > +       for (j = 1; i + j < ubuf->pagecount; j++) {
> > +               if (ubuf->folios[i + j] != f)
> > +                       break;
> > +               /* Same folio, but not a sequential offset within it. */
> > +               if (ubuf->offsets[i + j] != ubuf->offsets[i] + j * PAGE_SIZE)
> > +                       break;
> > +       }
> > +       return j;
> > +}
> > +
> > +/* Count the contiguous folio runs in @ubuf, one sg entry per run. */
> > +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
> > +{
> > +       unsigned int nents = 0;
> > +       pgoff_t i;
> > +
> > +       for (i = 0; i < ubuf->pagecount; i += udmabuf_folio_nr_pages(ubuf, i))
> > +               nents++;
> > +       return nents;
> > +}
> > +
> >  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
> >                                      enum dma_data_direction direction)
> >  {
> >         struct udmabuf *ubuf = buf->priv;
> > -       struct sg_table *sg;
> >         struct scatterlist *sgl;
> > -       unsigned int i = 0;
> > +       struct sg_table *sg;
> > +       pgoff_t i, run;
> > +       unsigned int nents;
> >         int ret;
> > 
> > +       nents = udmabuf_sg_nents(ubuf);
> > +
> >         sg = kzalloc_obj(*sg);
> >         if (!sg)
> >                 return ERR_PTR(-ENOMEM);
> > 
> > -       ret = sg_alloc_table(sg, ubuf->pagecount, GFP_KERNEL);
> > +       ret = sg_alloc_table(sg, nents, GFP_KERNEL);
> >         if (ret < 0)
> >                 goto err_alloc;
> > 
> > -       for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
> > -               sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
> > +       sgl = sg->sgl;
> > +       for (i = 0; i < ubuf->pagecount; i += run) {
> > +               run = udmabuf_folio_nr_pages(ubuf, i);
> > +               sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
> >                              ubuf->offsets[i]);
> > +               sgl = sg_next(sgl);
> > +       }
> > 
> >         ret = dma_map_sgtable(dev, sg, direction, 0);
> >         if (ret < 0)
> > 
> > --
> > 2.53.0-Meta
> > 
> 
