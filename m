Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BF6CD98F7
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7491310EE5E;
	Wed, 17 Jun 2026 07:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FFFkPHIq";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055C910E852
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 20:58:04 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-488b3fd8d0dso593057b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643484; x=1782248284; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rG4yjs4p+4H4P31U7PQCtrU7WZ2EeT+JyZMQJymeW5U=;
 b=FFFkPHIq3hI0uQh8IvbqP/vZDAHx2f7vNOM3XKb/rI+Re7RZ3mLqbzU1SIcpy520QE
 uWPpWxqJ/MvU/1MPoiHZ30EySL1Ln49p8tEdWS0lW9DirLVxkzL88DjAyNwPcXMQGW0G
 e0Te0q3D1kEUP10XJjoDep3jRe9GCWy15IrvXvEDpL39hdbKIS4MhWda76ofgUDd9gVb
 FEt/EHtZtwOwH6qkhoSmSEmJHz8VtSb9CMQ85KmQKxfsHm98l5BFffsGCRYwgmIALru/
 LpjRN9XEKH2aKkNN6BOH//VP3k7KrXIUs+UVsZNvMUETEU9bG/4ph0XxdtcfiB5ayRpO
 Drhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643484; x=1782248284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rG4yjs4p+4H4P31U7PQCtrU7WZ2EeT+JyZMQJymeW5U=;
 b=h3CKAc36/WWtSqLpyiWxgy3o55gb8l3W8JZc01swbMBA66Q1WXDZd6wwQ0b/a2Frva
 B0HIU6P3scZzgGK1EjUMwAwN/ySZvI+Tl+QiNKk+6hMiLN68N61PNS4uMJndFAkQvHvw
 3jccvSYDVnCj5gHz35nLHUY0RxDS1GW1I/7JMW4bCobzsklb8fokEU+x5cRryancc/lZ
 5UxlctXbsipGkbtA5EeP+8Yp/b4nIYqN8e+sH2GgJ+f0hHufTkQfM009KbfTY052vKXc
 AD+ITCXWw2J3ksl+/zZ0hdbthN3Csdw4sO/RYpXp8OuG0clgwXFl0Zh9o6ZH/iG9CUFz
 FDHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zb21PPp2+eMWB2F/rVCfGURgb+RCVwSebvZxXTxF8xKTUNugxY6Hp/XGxxNeZPIejxHfH0WHLZzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgKgmri9kscHx4+1DkXuhFgZPUC485JXCLEz0VazCv36/CctIJ
 U3oY8nHYHpNvdxchpdT2bwaBfIYf6vi9mNffEUfKvDFHI7EyVmFUl5rU
X-Gm-Gg: Acq92OGNywi8F5A59pDKN5LDRrBHPfjZ39LWy+Pa29pUylXhnWfWE+ob5BoB6ogPRXZ
 8dDJN5XBsPytAcTMDKAdH2PjUTUeg1euryuaPLa1jnZQYlc2MelQdxVQyJaOlBmXM9n9sSIjzCm
 BQOXevn0vbdzYHCTXjPBt3p24ssJLmkWF6R2526keB+4vOfVbcjrdwZMvOQL5eub40YggSOsj0h
 9zLPQCSCEuKzhsJn2sTVlFmOgGSjXii5nLTKWpChqxAc2zeYuh+6PLn5d2LQWQknpcBqwpWscM4
 HmNfG6AAMshr4pGqEZBnaLbB+mB8BIggC5L4nvFjNZct8ON3Dtx52BKofpGb0VNr9f+m4CfxS2i
 i58xnIVU3eqHUv5kalqlzmwohhkKPfOc0UTSr1+FU/0cyNk7MyGQlWu9WgW4jJ0Z24lUgG56a1m
 ihhvUs6wj38dEpjQ+RdOCDZYxIVWmZlmkFgHg7ahPTcOg=
X-Received: by 2002:a05:6808:2f0f:b0:479:f7e7:4a81 with SMTP id
 5614622812f47-489425d7d4cmr1016628b6e.0.1781643483758; 
 Tue, 16 Jun 2026 13:58:03 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:8::])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875df7fc36sm5099675b6e.9.2026.06.16.13.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 13:58:03 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:57:49 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>,
 "razor@blackwall.org" <razor@blackwall.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "almasrymina@google.com" <almasrymina@google.com>,
 "matttbe@kernel.org" <matttbe@kernel.org>,
 "skhawaja@google.com" <skhawaja@google.com>,
 "dw@davidwei.uk" <dw@davidwei.uk>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
Message-ID: <ajG4zaK9zu7qZT1+@devvm29614.prn0.facebook.com>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
 <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
 <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:07:22 +0000
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

On Tue, Jun 16, 2026 at 06:04:03AM +0000, Kasireddy, Vivek wrote:
> Adding Jason to this discussion.
> 
> Hi Bobby,
> 
> > Subject: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
> > folio
> > 
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
> > underlying folio was larger.
> > 
> > Instead, walk folios[] and emit one sg entry per folio. When folios
> We have recently merged a patch (that will make it into 7.2) from Jason that
> replaced sg_set_folio() with sg_alloc_table_from_pages() in udmabuf driver:
> https://gitlab.freedesktop.org/drm/tip/-/commit/5bf888673e0dda5a53220fa0c4956271a46c353c
> 
> Since you are relying on sg_set_folio(), the core argument against its usage
> in udmabuf is that it doesn't work well with offsets > PAGE_SIZE, resulting
> in a malformed scatterlist. Not sure if this can be fixed easily.
> 
> > represent large pages (as is for MFD_HUGETLB), each sg entry is a large
> > page. Normal PAGE_SIZE sg tables are unchanged.
> > 
> > This is helpful for importers like net/core/devmem that expect dmabuf sg
> IMO, udmabuf needs to detect whether importers can handle segments that
> are > PAGE_SIZE and set the entries appropriately. Please look into how the
> GPU drivers and other dmabuf exporters/importers handle this situation, so
> that we can adopt best practices to address this issue.
> 
> Thanks,
> Vivek

Hey Vivek,

It sounds looks like that patch might solve my problem. I'll apply and
troubleshoot from there.

Thanks!

Best,
Bobby

> 
> > entries to be size and length aligned. Prior to this patch udmabuf
> > handed over one PAGE_SIZE sg entry per page, so devmem only saw
> > PAGE_SIZE chunks regardless of the underlying folio size.
> > 
> > dma_map_sgtable() does not always merge contiguous pages for us, so we
> > do this internally before exporting.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  drivers/dma-buf/udmabuf.c | 52
> > ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 47 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index 94b8ecb892bb..9b751dd98b12 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -141,26 +141,68 @@ static void vunmap_udmabuf(struct dma_buf
> > *buf, struct iosys_map *map)
> >  	vm_unmap_ram(map->vaddr, ubuf->pagecount);
> >  }
> > 
> > +/* Return the number of contiguous pages backed by the folio at @i.
> > + * A udmabuf may map only part of a folio, or reference the same folio
> > + * in multiple non-contiguous runs, so folio_nr_pages() can't be used.
> > + */
> > +static pgoff_t udmabuf_folio_nr_pages(struct udmabuf *ubuf, pgoff_t i)
> > +{
> > +	struct folio *f = ubuf->folios[i];
> > +	pgoff_t j;
> > +
> > +	for (j = 1; i + j < ubuf->pagecount; j++) {
> > +		if (ubuf->folios[i + j] != f)
> > +			break;
> > +		/* Same folio, but not a sequential offset within it. */
> > +		if (ubuf->offsets[i + j] != ubuf->offsets[i] + j * PAGE_SIZE)
> > +			break;
> > +	}
> > +	return j;
> > +}
> > +
> > +/* Count the contiguous folio runs in @ubuf, one sg entry per run.
> > + *
> > + * Coalescing folios into a single sg entry up front lets importers actually
> > + * see large chunks. We can't rely on dma_map_sgtable() to do this for us
> > as
> > + * the dma_map_direct() path preserves the input scatterlist lengths
> > verbatim.
> > + */
> > +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
> > +{
> > +	unsigned int nents = 0;
> > +	pgoff_t i;
> > +
> > +	for (i = 0; i < ubuf->pagecount; i += udmabuf_folio_nr_pages(ubuf,
> > i))
> > +		nents++;
> > +	return nents;
> > +}
> > +
> >  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf
> > *buf,
> >  				     enum dma_data_direction direction)
> >  {
> >  	struct udmabuf *ubuf = buf->priv;
> > -	struct sg_table *sg;
> >  	struct scatterlist *sgl;
> > -	unsigned int i = 0;
> > +	struct sg_table *sg;
> > +	pgoff_t i, run;
> > +	unsigned int nents;
> >  	int ret;
> > 
> > +	nents = udmabuf_sg_nents(ubuf);
> > +
> >  	sg = kzalloc_obj(*sg);
> >  	if (!sg)
> >  		return ERR_PTR(-ENOMEM);
> > 
> > -	ret = sg_alloc_table(sg, ubuf->pagecount, GFP_KERNEL);
> > +	ret = sg_alloc_table(sg, nents, GFP_KERNEL);
> >  	if (ret < 0)
> >  		goto err_alloc;
> > 
> > -	for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
> > -		sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
> > +	sgl = sg->sgl;
> > +	for (i = 0; i < ubuf->pagecount; i += run) {
> > +		run = udmabuf_folio_nr_pages(ubuf, i);
> > +		sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
> >  			     ubuf->offsets[i]);
> > +		sgl = sg_next(sgl);
> > +	}
> > 
> >  	ret = dma_map_sgtable(dev, sg, direction, 0);
> >  	if (ret < 0)
> > 
> > --
> > 2.53.0-Meta
> 
