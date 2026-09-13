Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24251C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 16:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DF910E098;
	Sun, 13 Sep 2026 16:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T0Q8Q2ia";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086F610E098
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:52:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84FCD601DB;
 Sun, 13 Sep 2026 16:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5944D1F000FF;
 Sun, 13 Sep 2026 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789318370;
 bh=f6CYGdIlF0QxqMV9+Ks32EJAP5ALSrNcUznu+l4RCoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T0Q8Q2iaZRByFBBAaQofkmS3ZRxRnM8aS8pjTHTLJNR1qS4JCZWQ2M7fM2WOiJI3d
 pBx74618ooRQ2LNyLJCS0aZjVImxm7qtmqXPqx6hU48cDXGDPqDwzRYqOETgXODX6o
 uLfBibfDp+1GQkchNAFRNTyS/YOe6VLO6N9+A5gCPiYldD0WhuhzCRSyzKzh9wsmnY
 o47QSIfI6Qg2Xn9YuhPc7I3MZOoQLP1hdAB2C2gi3toE3mp5dg14LMyMdSfJEhhkn7
 v2HAcQeGwtTezQk23wEMk9DxMdOAjZ+2Tz7WX4JVQiVXYEEw5G6V4ycdfCDXGhSLYU
 bA66Q0IXfEl6A==
Date: Sun, 13 Sep 2026 19:52:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20260913165244.GW13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911214200.33793-10-matt@ozlabs.org>
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

On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.

The thing is that "temporarily revoked" is actually the standard
invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
for VFIO.

Thanks
