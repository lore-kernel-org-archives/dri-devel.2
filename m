Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08BAFF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EFE010E2CE;
	Tue, 31 Mar 2026 08:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QXdHaeEt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C8F10E2CE
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:39:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D6BB7600CB;
 Tue, 31 Mar 2026 08:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E524DC19423;
 Tue, 31 Mar 2026 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774946380;
 bh=9sA0RSLV5+ly21pfDzUPFohcEh6PFz1+BwavgS11Jjk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QXdHaeEtt5Ygpyji6z/xXuLjEqwGjMQ/Sp1FN/mQ2+fxi2PSQp7uWY/j0NOmTQSTw
 wL8FNAz3qm7sxxFcktmOGZoPY0Ijih+SPXYWE8u6EYWx5qVJ87XUTfv6G+eIXPVNuh
 mbDjmCJQlg4JPOprQJhnmegmjeeTDKhk7fAXzwQHPdd4KVN60L7abuTEXxteDa1mV9
 P2SCxMQ3nTv39zNrP4dCNDeUH88jiuMxgs6k9PqoPpCFkSLvJuwquC2I/jeBe8S67m
 ywYE3vpGeijji9987NQqLhFiSlMRfwsXVV1LMpaeO5cKfvGYMtHiqkGjGR5SyMmXKy
 NVL5A4/QbSnFA==
Date: Tue, 31 Mar 2026 11:39:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331083936.GB814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
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

On Thu, Mar 26, 2026 at 03:55:44PM -0700, Zhiping Zhang wrote:
> On Thu, Mar 26, 2026 at 3:41 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > >
> > On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > > >  struct vfio_device_feature_dma_buf {
> > > >     __u32   region_index;
> > > >     __u32   open_flags;
> > > > -   __u32   flags;
> > > > -   __u32   nr_ranges;
> > > > +   __u32   flags;
> > > > +#define VFIO_DMABUF_FL_TPH         (1U << 0) /* TPH info is present */
> > > > +#define VFIO_DMABUF_TPH_PH_SHIFT   1         /* bits 1-2: PH (2-bit) */
> > > > +#define VFIO_DMABUF_TPH_PH_MASK    0x6U
> > > > +#define VFIO_DMABUF_TPH_ST_SHIFT   16        /* bits 16-31: steering tag */
> > > > +#define VFIO_DMABUF_TPH_ST_MASK            0xffff0000U
> > >
> > > This extension of flags is basically kills future extension of this
> > > struct for anything that includes TPH.
> > >
> > > Add new
> > > enum vfio_device_feature_dma_buf_flags {
> > >     VFIO_DMABUF_FL_TPH  = 1 << 0
> > > }
> 
> yes we can do that.
> 
> > >
> > > > +   __u32   nr_ranges;
> > >
> > > add your "__u16 steering_tag" and "__u8 ph" fields here.
> >
> That is what I did in V1, Leon.

Not really, you did only half of the work. You didn't introduce new flag
and didn't calculate "old dma range" position.

Thanks
