Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2940CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 12:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D8E10EC7B;
	Tue, 19 May 2026 12:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="q1qj6Ejv";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A5110EC7B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=LSInc1JiWKpTsleWh0NnlPhduAwurDov6fxszzRl4KU=; b=q1qj6EjvjeOCpnV9NuMTZItkZo
 T49ZLX8cYfyOlkxGJ5ed0/205ef9CdMyfpTnPrJw4d0NlREDi558jtxp6i14+ScXOJJJeOKeAI6Ca
 c6ybN1E7zSWrAAJBgiMdxBZFC6gf/BHl9K8PjFGljUMOD377kqH85RMtSd0emtLXkLcCkCtdj8PSO
 +3Y6QxsUHJCJkZp8fwY6a7sB7lowzJocWIGcFLpvXn+T5Zn5WBPWyJtrQMUhHCFk/3fQF46w7jPnf
 7cF8vntKQ5xvdQ2a1KiK9hB1UPs/bVJjk2Y+gCy4qSHwmzjWs6ixfRlnn3wz0OeKWI3dHtddEaGUA
 1Rzx+RCA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wPJYp-00000005tqO-1kxS;
 Tue, 19 May 2026 12:28:35 +0000
Date: Tue, 19 May 2026 13:28:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <quic_bkumar@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
Message-ID: <agxXc8ttEzBFOlE2@casper.infradead.org>
References: <20260519-qda-series-v1-9-b2d984c297f8@oss.qualcomm.com>
 <5e0d72fa-929a-4905-9066-6648892bef4a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e0d72fa-929a-4905-9066-6648892bef4a@web.de>
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


Feel free to ignore everything Markus says.

On Tue, May 19, 2026 at 02:14:34PM +0200, Markus Elfring wrote:
> …
> > Assisted-by: Claude:claude-4-6-sonnet
> …
> 
> Did such an information source gather the knowledge to benefit more
> from the application of scope-based resource management?
> 
> 
> …
> > +++ b/drivers/accel/qda/qda_drv.c
> …
> > @@ -32,6 +33,18 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
> >  {
> …
> > +		if (refcount_dec_and_test(&iommu_dev->refcount)) {
> > +			spin_lock_irqsave(&iommu_dev->lock, flags);
> > +			iommu_dev->assigned_pid = 0;
> > +			iommu_dev->assigned_file_priv = NULL;
> > +			spin_unlock_irqrestore(&iommu_dev->lock, flags);
> > +		}
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(spinlock_irqsave)(&iommu_dev->lock);”?
> https://elixir.bootlin.com/linux/v7.1-rc4/source/include/linux/spinlock.h#L619-L622
> 
> Regards,
> Markus
> 
