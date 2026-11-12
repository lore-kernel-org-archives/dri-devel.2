Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1541606A882
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+q8E5O4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C37910E58A;
	Thu, 12 Nov 2026 08:57:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B654510FF36
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794473838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
 b=C+q8E5O4lQJFv4qkiux7KyKKUTozpyGAehRl10GDR8JLSmRBVEmVmnowmsx29TwyDyZWDN
 fziidfkQ3GXxXGBRFmKwTfwwlAeCJfChorWeTjOu3YqUprll5VSjK3TpNmBOdBfLy7KOmV
 Q+ZE5KptEiNYmquB/U8cm8jowqoqCLo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-aiBhgfD1Pb6HyLdsJWKXYQ-1; Thu, 12 Nov 2026 03:57:17 -0500
X-MC-Unique: aiBhgfD1Pb6HyLdsJWKXYQ-1
X-Mimecast-MFC-AGG-ID: aiBhgfD1Pb6HyLdsJWKXYQ_1794473836
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso24684745e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794473836; x=1795078636;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
 b=pu47iYRk+TI36aY1ueh+oaQezM23r0rAjesAqNNhGjkzec0E+s5Vq5MQ6h+3V3Vr0k
 BswFlMlBHbQydIqo7+X0LguTKBP8kHUMWqK8TwfJKn9Hsej22frhv560jktcX+40hyq/
 JrKFtCNMoPN+9Ot6F15eA5fT9BBclB4UfImCKDYR6KGytyTzSoZPj1I5zTdBUStE4jSb
 c9IrLY3TK7Ax7wfY4Xp2T9lh+zxOGuC1DjMqEYcm9iWORvTSBhUl2trDkoBW3S81tVgD
 tc5b5Wp+79INve09z280WpZKPBuMGF1pO8No2jaH0TRju9IdUMPxTib7wdwarXaohRXF
 6Q0w==
X-Forwarded-Encrypted: i=1;
 AL+hErHOmeZAncOAg+oftO8ahQiXg+CXN2fOWTv9F6VkSKVGtIWrAaVwn8/OLu3WuuZU6wD5YmtZARMnkCg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YpQEWkKZvktNRt9ZF+hf0NH5bm/81wwH8rJ8ITGe5YQVqy8eJ
 KkBCBiyGry/l8Rs6PYLaounLirQYl5xX2+0ZI2aSwp2sN0RCdz1MFHk39lekRN3lvjGo9HfjmSZ
 uJ2mohOQUbi4Wb6jONxnLxOlTuSROkkruWUbNqh9E2muq+ufMLc6eKmEol+bqZf8TskFmOg==
X-Gm-Gg: AYBFou22fXjsUZ80o+AjPPWKObWlu5J6SczXBPGTB03udxkD+eYwyXf+/8RSiT7JDbH
 sbmQWKVcEDLtV8vNfw8L6kKBuLfm4yV75XF8uBtnRP0WRPfYv8GVeswnSIrFGwjbE4Uz1hftW2+
 YkCTpyefauxZ1b/0fLjFTlY2Ja+BqHHSO6dDEsCCcPjcL703bANyCJr1fnLCw8duQmQ0vY5DO7Y
 XkP58Z+FJArtuPrd/3kNElHKR9NujlubsWh59sGWADBPOw7+pKuhShMvDlGTj970WH48OKie+c8
 K5q2h82gQRofJY5RgXnZTGjN9ADbf9kD18ZB3LjsiRjMAHI4ZJqa5wKtlphpgLY93e8VY4J8YNk
 ZacW07cl0vQdZPJK9xZvwQ0vLmP4SNqfsYfn5ZaJh/l8=
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ba093a3cf9mr102100885e9.28.1794473835963; 
 Thu, 12 Nov 2026 00:57:15 -0800 (PST)
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ba093a3cf9mr102100215e9.28.1794473835545; 
 Thu, 12 Nov 2026 00:57:15 -0800 (PST)
Received: from localhost ([139.47.30.142]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251686sm54810695e9.3.2026.11.12.00.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 00:57:15 -0800 (PST)
Date: Thu, 12 Nov 2026 09:57:14 +0100
From: Albert Esteve <aesteve@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] [PATCH v4 1/8] memcg: Add MEMCG_DMABUF
 accounting infrastructure
Message-ID: <avV_asMMt16Q5S7S@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
 <96d6a6e828310738c0cb4550752a0b5808a81ef9.camel@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <96d6a6e828310738c0cb4550752a0b5808a81ef9.camel@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UEPPij2rIlB1bSUn-gPTF9fgsKNTbE85csxA3R_dgp0_1794473836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 08:26:35AM +0100, Thomas Hellström wrote:
> On Wed, 2026-11-04 at 12:09 +0100, Albert Esteve wrote:
> > From: "T.J. Mercier" <tjmercier@google.com>
> > 
> > Introduce a MEMCG_DMABUF stat counter and helpers for charging,
> > cancelling, and uncharging dma-buf memory against a memory cgroup.
> > 
> > The charge is tracked on struct dma_buf via a new memcg pointer.
> > The memcg reference is stored into (or cleared from) dmabuf->memcg
> > by the helpers, removing the need for callers to manage those
> > details. The release path in dma_buf_release() is reduced to a
> > single mem_cgroup_uncharge_dmabuf() call.
> > 
> > Rather than charging at the page level via __GFP_ACCOUNT, which
> > would require exporters to expose their backing pages for
> > cross-cgroup transfer via new dma_buf_ops, charges are tracked
> > externally on struct dma_buf through a single accounting path.
> > 
> > The next patch wires up the charging policy in the dma-heap ioctl.
> > 
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  4 ++
> >  drivers/dma-buf/dma-buf.c               |  3 ++
> >  include/linux/dma-buf.h                 |  4 ++
> >  include/linux/memcontrol.h              | 27 +++++++++++++
> >  mm/memcontrol.c                         | 70
> > +++++++++++++++++++++++++++++++++
> >  5 files changed, 108 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst
> > b/Documentation/admin-guide/cgroup-v2.rst
> > index 86a2a0099178..a3265a4a953e 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1662,6 +1662,10 @@ The following nested keys are defined.
> >  		Amount of memory used for storing in-kernel data
> >  		structures.
> >  
> > +	  dmabuf (npn)
> > +		Amount of memory used for exported DMA buffers
> > allocated by the cgroup.
> > +		Stays with the allocating cgroup regardless of how
> > the buffer is shared.
> > +
> >  	  workingset_refault_anon
> >  		Number of refaults of previously evicted anonymous
> > pages.
> >  
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 4c9add51f9ef..1c6b9cee7ac2 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/slab.h>
> >  #include <linux/dma-buf.h>
> > +#include <linux/memcontrol.h>
> >  #include <linux/dma-fence.h>
> >  #include <linux/dma-fence-unwrap.h>
> >  #include <linux/anon_inodes.h>
> > @@ -182,6 +183,8 @@ static void dma_buf_release(struct dentry
> > *dentry)
> >  
> >  	dmabuf->ops->release(dmabuf);
> >  
> > +	mem_cgroup_uncharge_dmabuf(dmabuf);
> > +
> >  	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
> >  		dma_resv_fini(dmabuf->resv);
> >  
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d15b2b31d3c9..23ec0ff23fba 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -27,6 +27,7 @@
> >  struct device;
> >  struct dma_buf;
> >  struct dma_buf_attachment;
> > +struct mem_cgroup;
> >  
> >  /**
> >   * struct dma_buf_ops - operations possible on struct dma_buf
> > @@ -429,6 +430,9 @@ struct dma_buf {
> >  
> >  		__poll_t active;
> >  	} cb_in, cb_out;
> > +
> > +	/** @memcg: the cgroup to which this buffer is currently
> > attributed */
> > +	struct mem_cgroup *memcg;
> >  };
> >  
> >  /**
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7d1c0ce189a8..4d1e82cf0833 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -10,6 +10,9 @@
> >  
> >  #ifndef _LINUX_MEMCONTROL_H
> >  #define _LINUX_MEMCONTROL_H
> > +
> > +struct dma_buf;
> > +
> >  #include <linux/cgroup.h>
> >  #include <linux/vm_event_item.h>
> >  #include <linux/hardirq.h>
> > @@ -40,6 +43,7 @@ enum memcg_stat_item {
> >  	MEMCG_ZSWAP_B,
> >  	MEMCG_ZSWAPPED,
> >  	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMABUF,
> >  	MEMCG_NR_STAT,
> >  };
> >  
> > @@ -667,6 +671,9 @@ int mem_cgroup_charge_hugetlb(struct folio*
> > folio, gfp_t gfp);
> >  int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned
> > short id,
> >  				   struct mm_struct *mm, gfp_t gfp);
> >  
> > +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> > +			       unsigned int nr_pages);
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >  
> >  /**
> > @@ -682,6 +689,10 @@ static inline void mem_cgroup_uncharge(struct
> > folio *folio)
> >  	__mem_cgroup_uncharge(folio);
> >  }
> >  
> > +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int
> > nr_pages);
> > +
> > +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf);
> > +
> >  void __mem_cgroup_uncharge_folios(struct folio_batch *folios);
> >  static inline void mem_cgroup_uncharge_folios(struct folio_batch
> > *folios)
> >  {
> > @@ -1167,10 +1178,26 @@ static inline int
> > mem_cgroup_swapin_charge_folio(struct folio *folio,
> >  	return 0;
> >  }
> >  
> > +static inline bool mem_cgroup_reserve_dmabuf(struct mem_cgroup
> > *memcg,
> > +					     gfp_t gfp,
> > +					     unsigned int nr_pages)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline void mem_cgroup_cancel_dmabuf(struct mem_cgroup
> > *memcg,
> > +					    unsigned int nr_pages)
> > +{
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> >  
> > +static inline void mem_cgroup_uncharge_dmabuf(struct dma_buf
> > *dmabuf)
> > +{
> > +}
> > +
> >  static inline void mem_cgroup_uncharge_folios(struct folio_batch
> > *folios)
> >  {
> >  }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 856a7d07586c..e53dd7eebc3b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -69,6 +69,7 @@
> >  #include <net/ip.h>
> >  #include "slab.h"
> >  #include "memcontrol-v1.h"
> > +#include <linux/dma-buf.h>
> >  
> >  #include <linux/uaccess.h>
> >  
> > @@ -442,6 +443,7 @@ static const unsigned int memcg_stat_items[] = {
> >  	MEMCG_ZSWAP_B,
> >  	MEMCG_ZSWAPPED,
> >  	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMABUF,
> >  };
> >  
> >  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > @@ -1625,6 +1627,7 @@ static const struct memory_stat memory_stats[]
> > = {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  	{
> > "hugetlb",			NR_HUGETLB			},
> >  #endif
> > +	{
> > "dmabuf",			MEMCG_DMABUF			},
> >  
> >  	/* The memory events */
> >  	{
> > "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
> > @@ -5658,6 +5661,73 @@ void mem_cgroup_flush_workqueue(void)
> >  	flush_workqueue(memcg_wq);
> >  }
> >  
> > +/**
> > + * mem_cgroup_reserve_dmabuf - charge a memcg for a dma-buf
> > allocation
> > + * @memcg: memcg to charge (may be %NULL)
> > + * @gfp_mask: reclaim mode
> > + * @nr_pages: number of pages to charge
> > + *
> > + * Charges @nr_pages against @memcg. Call this before allocating
> > pages so
> > + * the cgroup limit is enforced up front. On success the caller must
> > + * finalize the charge with the MEMCG_DMABUF stat update, or call
> > + * mem_cgroup_cancel_dmabuf() to undo it.
> > + *
> > + * Returns %true on success, %false if the charge would exceed the
> > limit.
> > + */
> > +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t
> > gfp_mask,
> > +			       unsigned int nr_pages)
> > +{
> > +	if (!memcg || mem_cgroup_disabled())
> > +		return true;
> > +
> > +	if (try_charge(memcg, gfp_mask, nr_pages))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(mem_cgroup_reserve_dmabuf);
> > +
> > +/**
> > + * mem_cgroup_cancel_dmabuf - undo a dma-buf charge
> > + * @memcg: memcg to uncharge (may be %NULL)
> > + * @nr_pages: same value passed to mem_cgroup_reserve_dmabuf()
> > + *
> > + * Returns @nr_pages of charge to @memcg. Use when the allocation
> > fails
> > + * after mem_cgroup_reserve_dmabuf().
> > + */
> > +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int
> > nr_pages)
> > +{
> > +	if (!memcg)
> > +		return;
> > +
> > +	if (!mem_cgroup_is_root(memcg))
> > +		refill_stock(memcg, nr_pages);
> > +}
> > +EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> > +
> > +/**
> > + * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> > + * @dmabuf: buffer to uncharge
> > + *
> > + * Reverses a finalized dma-buf charge. Drops the memcg
> > + * reference stored in @dmabuf->memcg and clears the pointer.
> > + * Safe to call when @dmabuf->memcg is %NULL.
> > + */
> > +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf)
> > +{
> > +	unsigned int nr_pages;
> > +	struct mem_cgroup *memcg = dmabuf->memcg;
> > +
> > +	if (!memcg)
> > +		return;
> > +
> > +	nr_pages = PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> > +	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
> > +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);
> > +	mem_cgroup_put(memcg);
> > +	dmabuf->memcg = NULL;
> > +}
> 
> Instead of keeping a reference on the memcg for the buffer's whole
> lifetime, shouldn't an obj_cgroup be used, which is reparented when the
> memcg goes offline?

Good point. I did not think of it, but after a brief check I think it'd
be the right object to use. I'll switch for the next version.

> Like in Dave's series here:
> 
> https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.com/

Thanks for the link! I'll use it as reference. I should mention it in the
cover letter too probably, as that series is related (should be safe as
far as it does not opt-in for dma-buf-level charging).

BR,
Albert

> 
> Thanks,
> Thomas
> 
> 
> 
> 
> > +
> >  static int __init cgroup_memory(char *s)
> >  {
> >  	char *token;

