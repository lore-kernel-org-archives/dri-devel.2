Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5714606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2UqB7dS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125AB112435;
	Thu, 29 Oct 2026 16:01:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1493311242B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:01:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC65E43882;
 Thu, 29 Oct 2026 16:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8003D1F01816;
 Thu, 29 Oct 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793289662;
 bh=yWQBZdKwYPknyhR1ZTrFCJ4aE3HypJnngTbN5hSuA+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=n2UqB7dSuTofD/3gI3MDpOjn0/XaiWYNGo5OddSA56jhBdGyopbKHgm+ENtVkMgp+
 gCn+wsOF+N8A9B0WjerC66AEX5ulkSnHe0wD38qqSinDztfHu4bUbdALl+zP9MgQWE
 d/+gu6UHwvenaAkLCVWxlDBoZi61wQ0na+/JXMwgzd7XXG9IbISZmPRrJuKxScdWkq
 A6gWl6Bc7jHeUy8c8eDSXkQfo3GbCvi5ajLDUcIh1AhbBiA2OA27YEMIgp2emixnfh
 tx/v7E0C8CEbQneptTgJtGwXf9xz/YQFWtBisFgBg8oAmxZ2V27Bnj3aH3KFVhoXSD
 Z83wG5jm7A5qg==
Date: Thu, 29 Oct 2026 11:00:58 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/31] accel: ethosu: Fix probe error cleanup
Message-ID: <20261029160058.GA1232511-robh@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-3-4aa25e22578e@kernel.org>
 <auNrrlOyKRzSp6vv@lizhi-Precision-Tower-5810>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNrrlOyKRzSp6vv@lizhi-Precision-Tower-5810>
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

On Thu, Oct 29, 2026 at 11:52:14AM -0400, Frank Li wrote:
> On Thu, Oct 29, 2026 at 08:35:50AM -0500, Rob Herring (Arm) wrote:
> > Once the job scheduler has been initialized, failures from ethosu_init()
> > or drm_dev_register() return from probe without tearing it down. The
> > registration failure also leaves the SRAM-pool allocation in use, because
> > the platform remove callback is not called after a failed probe.
> >
> > Unwind the initialized resources on both paths. Also do not call
> > drm_sched_fini() after a failed drm_sched_init(): the scheduler initializer
> > already unwinds its partial setup, while drm_sched_fini() requires a
> > successfully initialized scheduler.
> >
> > Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v2:
> >  - Adjust for previous patch reworking runtime-PM suspend
> > ---
> >  drivers/accel/ethosu/ethosu_drv.c | 13 ++++++++++++-
> >  drivers/accel/ethosu/ethosu_job.c |  6 +-----
> >  2 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> > index ae7ebf29cb2f..9ee144c41550 100644
> > --- a/drivers/accel/ethosu/ethosu_drv.c
> > +++ b/drivers/accel/ethosu/ethosu_drv.c
> > @@ -375,9 +375,20 @@ static int ethosu_probe(struct platform_device *pdev)
> >
> >  	ret = ethosu_init(ethosudev);
> >  	if (ret)
> > -		return ret;
> > +		goto err_job_fini;
> >
> >  	ret = drm_dev_register(&ethosudev->base, 0);
> > +	if (ret)
> > +		goto err_sram_free;
> > +
> > +	return 0;
> > +
> > +err_sram_free:
> > +	if (ethosudev->sram)
> > +		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> > +			      ethosudev->npu_info.sram_size);
> 
> Does worth add devm_gen_pool_dma_alloc()?

We want this backported to stable, so I think we want it as-is and then 
perhaps later add a helper.

Rob
