Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0F5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587F110E54E;
	Mon, 13 Jul 2026 08:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QslwnYl2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB7510E54E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95B8460018;
 Mon, 13 Jul 2026 08:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D761F000E9;
 Mon, 13 Jul 2026 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783929886;
 bh=fI49FtD57qiHiCZVpYxggqFypFJ+NAs6da3bEfHEoDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QslwnYl23mS0eqE3qOl8BJpWreOFc0wvAiBVbiHWL7pnyo40FO9pxuRpvgPgoX1+0
 SHUFfd6dUkwBZhET9D9KT/PFFq8aNUsD1xQyyIlofaez13WgwKg4vdKm+FuC3dE8M3
 UXSEZ4Aw4nxuNjzjuW2YUvuhFNkDGPNOIw2H8b4hDpa0jY72aYjFhLWt8OA+2dXf40
 UPGEwmMD/O25SWKf4W5JLCneaUHbsfTzlcey4iKZ79nqFjlem3UapvXuoAhr+clWtI
 LOTmZOm9bY4Ipi6gg7ha+iv15ZhJuni0a/QuwZ7lV7GzL07jRrdHHI4tJk9pBQh/7I
 qMkktBafHUTTw==
Date: Mon, 13 Jul 2026 11:04:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260713080439.GH33197@unreal>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260709132602.6a3fb084@shazbot.org>
 <CAH3zFs3OwPyTrWk7oaMYETq7sBEQ7VRfDtzWWamhiE3AJzVShw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs3OwPyTrWk7oaMYETq7sBEQ7VRfDtzWWamhiE3AJzVShw@mail.gmail.com>
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

On Fri, Jul 10, 2026 at 02:13:31PM -0700, Zhiping Zhang wrote:
> On Thu, Jul 9, 2026 at 12:26 PM Alex Williamson <alex@shazbot.org> wrote:
> >
> > >
> > On Thu, 2 Jul 2026 11:10:13 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Changes since v10:
> > >   Patch 2 (dma-buf): Per Christian König, document that the ST/PH
> > >   returned by dma_buf_get_pci_tph() is only valid until the exporter
> > >   invalidates the current mapping and must be re-queried afterwards;
> > >   note added to the wrapper kernel-doc and referenced from the callback
> > >   kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tph()
> > >   to the central dma-buf locking convention.
> > >
> > >   Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
> > >   comment to note that @revoked is additionally protected by memory_lock,
> > >   and describe the READ_ONCE() rationale in the commit log. No behavior
> > >   change.
> >
> > Sashiko has valid comments[1] across most of the series.
> >
> >  - Passing through 0b10 seems mis-categorized as High in patch 1, but
> >    is valid hardening if tph_req_type can ever hold an invalid value.
> >
> 
> agreed, not High and pre-existing: get_rp_completer_type() is from the
> original TPH
> support and untouched here. I can send the hardening change in a separate patch.
> 
> >  - The documentation error in patch 2 is real.
> >
> 
> will fix!
> 
> >  - Patch 4 ironically fails to re-validate according to the lifecycle
> >    requirements that patch 2 specifies.  This is a significant gap in
> >    the implementation proof for a real requester.
> >
> 
> Got it, I'll re-query ma_buf_get_pci_tph() there and reprogram the
> mkey's steering tag,
> so the lifecycle is honored.
> 
> >  - The broadened scope of the existing memory leak in patch 4 is
> >    already addressed in [2], ok.  Maybe should be folded into this
> >    series if mlx5 isn't going to pick it up separately.
> >
> 
>  [2] is already accepted and landing through the mlx5/RDMA tree.

It is not; the patch is intended for net and has still not been
accepted.

https://lore.kernel.org/linux-rdma/20260702222507.1234467-1-zhipingz@meta.com/

Thanks

> 
> I plan to keep it as a standalone dependency.
> 
> > Thanks,
> > Alex
> >
> > [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260702181025.2694961-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!5x8TPHfbpTXQJ872nmZaHsPIXH7HsL9ICbZR3G37yKkHgB-RukCDOy3XiLIOhfhP-yTczTyWQmud$
> > [2]https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@meta.com
> 
> Thanks,
> Zhiping
