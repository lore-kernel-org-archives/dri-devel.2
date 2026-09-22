Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAAAC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CD310E179;
	Tue, 22 Sep 2026 08:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="bWymhEoA";
	dkim-atps=neutral
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DB710EA5C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:11:20 +0000 (UTC)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260922081119epoutp01190ef5ca6a42561757c53a3786b80f5c~XlldnEoUZ0110601106epoutp01C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:11:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260922081119epoutp01190ef5ca6a42561757c53a3786b80f5c~XlldnEoUZ0110601106epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790064679;
 bh=ppb5NdBs58x4r+h1AiWGI65C0tz0hajebc59pJdtVVc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bWymhEoAbXtMJqxPf+9fH0OCAuU1sL6J65djBskJZ5xl5XsgNwYDQM0O4pf0F9023
 oS/t8w4ur7A/VSkeP71iTgqCQS0otXuu+9pMnuJFEGKVrJg4HJRwtyCAhBu12eD23Y
 PLEmbliDWWmf4uuYlrLcuH3Le7/aCOK+8ZQmU3eo=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20260922081118epcas2p48387828cf8cdea44e389d9b98ab5d0aa~XlldX3Q_n2333523335epcas2p4h;
 Tue, 22 Sep 2026 08:11:18 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.199]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4hpt8k2zyFz2SSKg; Tue, 22 Sep
 2026 08:11:18 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20260922081117epcas2p1cf1d6776edabec5931a622c385accc24~XllcgHZFi1436814368epcas2p1l;
 Tue, 22 Sep 2026 08:11:17 +0000 (GMT)
Received: from KORCO090182.samsungds.net (unknown [12.80.211.164]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260922081117epsmtip24ae96a6810c6b9b73c7ba684ea9201e7~Xllcb-Xjs2973429734epsmtip2z;
 Tue, 22 Sep 2026 08:11:17 +0000 (GMT)
Date: Tue, 22 Sep 2026 17:11:14 +0900
From: Janghyuck Kim <janghyuck.kim@samsung.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: sumit.semwal@linaro.org, phasta@kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: don't WARN_ON_ONCE() on a failing
 dmabuf->ops->vmap()
Message-ID: <arI4IlBCtaIgirFs@KORCO090182.samsungds.net>
MIME-Version: 1.0
In-Reply-To: <1bd9bcfc-4b4f-4235-8073-585197b29727@amd.com>
X-CMS-MailID: 20260922081117epcas2p1cf1d6776edabec5931a622c385accc24
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----2-A87u3RbSrJ3XvU_rY9Iz3CwCKX-wh1tRaDlfrw5UdaQK4O=_63062_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d
References: <CGME20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d@epcas2p3.samsung.com>
 <20260921100946.353521-1-janghyuck.kim@samsung.com>
 <1bd9bcfc-4b4f-4235-8073-585197b29727@amd.com>
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

------2-A87u3RbSrJ3XvU_rY9Iz3CwCKX-wh1tRaDlfrw5UdaQK4O=_63062_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 2026-09-21 13:39, Christian König wrote:
> On 9/21/26 12:09, Janghyuck Kim wrote:
> > dma_buf_vmap() escalates any non-zero return from dmabuf->ops->vmap()
> > into a WARN_ON_ONCE(). But a failing vmap() is not, by itself,
> > evidence of a violated invariant or a driver bug -- it's an ordinary
> > runtime failure of a fallible operation, no different from any other
> > allocation-shaped kernel API that can return an error. The dma-buf
> > core has no visibility into what a given exporter's vmap()
> > implementation considers a normal failure versus an internal bug;
> > that distinction, if it matters at all, belongs to the exporter, not
> > to this generic passthrough.
> 
> Well not quite, apart from some not so relevant HW workarounds the vmap callback is mostly used for fbdev emulation.
> 
Fair point about fbdev being the historical motivation. However,
->vmap() is not limited to fbdev; for example, the mainline CMA dma-buf
heap calls vmap() and explicitly returns -ENOMEM when the mapping cannot
be established.

More generally, ->vmap() is a fallible callback whose API allows it to
return an error. The exact reason for failure is exporter-specific, so I
don't think the dma-buf core should treat every ->vmap() failure as an
exporter bug and unconditionally WARN on it.

The fatal_signal_pending() case is simply one concrete example of how
vmap() can fail under memory pressure without indicating a driver bug.
> > -ENOMEM is a concrete, easily reproduced example of this. Page
> > allocation on the vmap()/vmalloc() path can fail purely because the
> > calling task has a fatal signal pending: should_reclaim_retry() in
> > mm/page_alloc.c intentionally gives up reclaim and returns false
> > once fatal_signal_pending(current) is true, so that a task that is
> > already being killed (e.g. by a userspace low-memory killer) isn't
> > stuck retrying reclaim on its way out. The resulting -ENOMEM from
> > dmabuf->ops->vmap() is expected behaviour in that case, not a bug in
> > the exporter -- and it is far from the only way ops->vmap() can
> > legitimately fail (an exporter may just as well refuse to vmap a
> > buffer for other, unrelated reasons of its own).
> > 
> > This is exactly the kind of condition Documentation/process/coding-style.rst
> > warns against for WARN*():
> > 
> >     WARN*() must not be used for a condition that is expected to
> >     trigger easily, for example, by user space actions.
> > 
> > A failing vmap() is reachable purely by driving the system into low
> > memory and then issuing an ioctl that happens to map a dma-buf -- no
> > driver misbehaviour required. Turning that into a WARN_ON_ONCE(),
> > and on panic_on_warn kernels into an outright panic, doesn't help
> > debugging; it just turns an otherwise-recoverable error into a fatal
> > one.
> 
> WOW STOP! A driver allowing to vmap() through an IOCTL is a major no-go!
> 
> vmap() on a DMA-buf has very very limited use cases which should mostly only be trigger able as superuser.
> 
> At least on 32bit system you can otherwise trivially exhaust the vmap area of the kernel and that is even worse than a simple WARN_ON_ONCE().
Fair point. To be clear, I'm not arguing that an unprivileged ioctl
should be allowed to trigger vmap() without appropriate access control.
If a driver exposes that, I agree that it should be addressed in the
driver.

My point is separate: even a legitimate, one-off vmap() may fail under
memory pressure, and such a failure does not by itself indicate driver
misbehaviour. The fatal_signal_pending() case is one example where
memory allocation may give up rather than continue reclaim.

I'll drop the "no driver misbehaviour required" wording, since I agree
it could be read as endorsing unrestricted ioctl-triggered vmap, which
wasn't my intention.
> 
> Regards,
> Christian.
> 
> > 
> > Drop the WARN_ON_ONCE() and simply propagate the error, consistent
> > with how other allocation-failure paths in the kernel are handled.
> > The dma_buf_vmap_unlocked()/dma_buf_vmap() contract is unchanged:
> > both still return the negative errno from dmabuf->ops->vmap() to the
> > caller. Only the WARN_ON_ONCE() splat (and, transitively, the panic
> > on panic_on_warn kernels) is removed.
> > 
> > Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 36cdc342627e..252495761a21 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1670,7 +1670,7 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
> >         BUG_ON(iosys_map_is_set(&dmabuf->vmap_ptr));
> > 
> >         ret = dmabuf->ops->vmap(dmabuf, &ptr);
> > -       if (WARN_ON_ONCE(ret))
> > +       if (ret)
> >                 return ret;
> > 
> >         dmabuf->vmap_ptr = ptr;
> > --
> > 2.34.1
> > 
> 
> 

------2-A87u3RbSrJ3XvU_rY9Iz3CwCKX-wh1tRaDlfrw5UdaQK4O=_63062_
Content-Type: text/plain; charset="utf-8"


------2-A87u3RbSrJ3XvU_rY9Iz3CwCKX-wh1tRaDlfrw5UdaQK4O=_63062_--
