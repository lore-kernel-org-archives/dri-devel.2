Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6611DC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEB210FBDF;
	Tue, 15 Sep 2026 11:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jT8opjhi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55D510FBDF
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:37:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 285BF600D1;
 Tue, 15 Sep 2026 11:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B2C1F000FF;
 Tue, 15 Sep 2026 11:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472276;
 bh=sYl0ytaxMndC1p5mXgQdcUeluV41DyVTbBzozC+8wMQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jT8opjhiEdiQ6cfZBvQJD0vOKpDRx9kZiBi7PTWcOOCnISBEmjC68q9lBiLmmyVxJ
 iob0stPbv2i937MR1CZVLg7lxadp1tIYhyFZJ46CUww4G8oS+Cr0tabAeZW0lEqyVd
 j9hJqlmA7n6jBYw37ANWmvCeSVbP1Rx+vDuRz0uMjsbnxJ41MvrFUy8FHsxiuX6pzC
 XQaiHKrR0eSgEdY65kwKMCidRNNqiyt5WZjaUlIIkah5mviZF1bdyZq3lS9z+nsq3d
 nVwbUqvpuBb1MNJNqImVgC9WwVU0RZwLkfO0UUk1CX1nO8KvJ1T5wULwLE64WCpaxk
 69QSMkkgdihcg==
Date: Tue, 15 Sep 2026 14:37:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
Message-ID: <20260915113752.GK13683@unreal>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
 <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com>
 <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com>
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

On Fri, Sep 11, 2026 at 09:58:28AM +0200, Christian König wrote:
> Hi Zhiping,
> 
> sorry I'm completely underwater at the moment and don't have time to take another look at the full set.
> 
> But IIRC you already fixed my documentation requirements and skimming over the patch once more I can't see anything wrong of hand.
> 
> So feel free to add Acked-by: Christian König <christian.koenig@amd.com> to patch "dma-buf: add optional get_pci_tph() callback" and push it upstream through the VFIO channels.

Christian,

I'm slightly confused here. In the other thread, you expressed concerns
about having PCI details common to every device in the P2P world in the
dma-buf code, but here you seem fine with adding a niche P2P feature.

Thanks,
