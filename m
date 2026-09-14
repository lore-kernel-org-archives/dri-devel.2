Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99678C88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FB310EDAD;
	Mon, 14 Sep 2026 11:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M7wNU7Iw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A6B10EDAD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2918143B8E;
 Mon, 14 Sep 2026 11:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C61F00898;
 Mon, 14 Sep 2026 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789386899;
 bh=mzslbS9s57kHQk5KhGmaTOWstnEBnslT4LYp80HR5nQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=M7wNU7Iw1O/OBF9URQRc/i9iZNutJqNfPaElMBTKqIKZPckpJAmhf7f0gLTCu1HMt
 tMF7nnZqUHw7m4Q6qqhICroNBaY486sD0k/9xXK+kQZKWIf03oC5NPZb6udvbFfXAx
 uH9dQsLagA9St5ZWmgflKNogNNb7bUoyJMV2Na1k3ecddBe1ghAx8IqK9DNNEyT59z
 vBhTwYPX12IMLAPO4zDprisBauaJ/Yl8+H2rZ+89XAnU99qBmV8unZn7HZ+ufwajJQ
 YvybuH36cRfFJdBuDgjwQMkMRrTa3ZlgAOlnxPSTxnWtid0iAU8HJx9IoK7U2P4fUQ
 S3w2vJ3Nt0ulA==
Date: Mon, 14 Sep 2026 14:54:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260914115456.GY13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914113647.GL3968357@nvidia.com>
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

On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
> > On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> > > Expand the VFIO DMABUF revocation state to three states:
> > > Not revoked, temporarily revoked, and permanently revoked.
> > 
> > The thing is that "temporarily revoked" is actually the standard
> > invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
> > for VFIO.
> 
> I think temporarily revokes here means it is revoked from a dmabuf
> perspective

My guess is that this is more of a "change owner" operation than a
revoke operation.

The main issue here is that we have to guess the semantics instead of
having a properly named and documented operation. As Christian pointed
out, the patches describe what they are doing well, but they do not
explain why they are doing it.

> 
> Just that VFIO can make it's internal dmabuf work again, there won't
> be a notification to any importer or an expectation that something
> like iommufd will re-establish mapping automatically.
> 
> This is principally a kernel self protection mechanism where the
> userspace was expected to have removed the dmabuf before issuing a
> reset/etc. If they didn't then the kernel plonks it and userspace gets
> a mess to clean up.

Revoke/invalidate means that the importer should stop accessing the
buffer provided by the exporter. It does not specify what the exporter
should do afterwards.

So I still think that "temporarily revoked" is closer to
invalidate_mappings, with some additional dma-buf documentation to lose
the expectation that the buffer will become available again.

Thanks

> 
> Jason
