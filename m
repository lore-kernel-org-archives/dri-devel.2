Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD068C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C0910E02F;
	Tue, 22 Sep 2026 12:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hBQqvV5I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F79C10E02F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:46:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FACF40748;
 Tue, 22 Sep 2026 12:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C44D1F000FF;
 Tue, 22 Sep 2026 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790081202;
 bh=vlNJMjJNJtuYUwJ6hjN6VVFtsO/8YcI81Stq8tii+WQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hBQqvV5ICsYllg261MfYuphG3h6WkPbZKDyufD9/q9DTxX8jpr+ElXNmwioPCz5yM
 1witd8EDmwQ8iTS4hOmWc8mah/fzkNgIeCTKxQ7NlUdVuOUUDSo1qyFe2uUVtyooF3
 /WNLE98K/4kF8tlsdfxvmMfoBgWMLrWXp/Gdc1ontFZJZbFt+kYfskbspQYRtynxVT
 L+kIsDU1TsBGTd4vwaba3vCmq/1mIdZrNZTHvxCjoVwuRMBfqDh6kx9b+hPkL86KJ9
 /B1b22H547VJCMI3l72LQcJLZGddxE4FyF4mJDy/WZc/KgZOojmGB8CrHbaJWy2eZ2
 h+ZAnIioIleIQ==
Date: Tue, 22 Sep 2026 15:46:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>,
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
Message-ID: <20260922124637.GG563127@unreal>
References: <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922124137.GD1507824@nvidia.com>
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

On Tue, Sep 22, 2026 at 09:41:37AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2026 at 04:09:18PM +0200, Christian König wrote:
> > >> I would avoid that and just re-create the DMA-buf fd from
> > >> scratch. The extra overhead is negligible and one way state
> > >> transmissions are usually much easier to handle.
> > > 
> > > Yeah, maybe we should have done that. Might be too late now.
> > 
> > It's already uAPI? 
> 
> Yeah, but Matt is making some changes here so maybe new stuff can
> avoid this. I'm not sure.

Jason, the proposed semantics is not UAPI yet.

Matt only added the new struct in this patch.
https://lore.kernel.org/all/20260911214200.33793-10-matt@ozlabs.org/#Z31include:uapi:linux:vfio.h

Thanks

> 
> Jason
