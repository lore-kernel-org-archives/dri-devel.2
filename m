Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B607CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 08:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0B510E980;
	Sun,  7 Jun 2026 08:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aE1SY8r9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A6C10E980
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 08:02:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12597439CB;
 Sun,  7 Jun 2026 08:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A9B1F00893;
 Sun,  7 Jun 2026 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780819369;
 bh=743mquA8eUU6nXfjkJF2bDmypYOyMCpDQhfZo28zoc8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aE1SY8r9jkNr36mu/YYJAsW8bfiM7zw1BjgwI5hH9xzAqeIuvpxF5a5xHVcykvRhE
 5rv4zb7l0fL/AVhPq95kRC309GpG2LYn9Tk0LfK0EftcbiMuP0mz7jwTgGkVUiskib
 FsdBfriQjkjAOSaoOuF08eSIjgEI606M97YlP4uHMmQ2uHpzNScMRGEPVja8VRAJvY
 PNxXin2R+XTuVfb00frIhDpIHsfV00jTfMFLAAGOUorTUFWPoAM25MVttHHa4l78o7
 2BvhsE3Q4tELG3Xi5Wreq/lCyzxgWM6T3E3A4pyK+yA89GXQXm4j8JddNoJQxLgi0i
 ymCQKza5mtMTA==
Date: Sun, 7 Jun 2026 11:02:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jmoroni@google.com, praan@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260607080244.GA327369@unreal>
References: <20260601200012.3872274-1-xuehaohu@google.com>
 <20260604094344.GB245424@unreal>
 <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
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

On Thu, Jun 04, 2026 at 03:36:48PM -0400, David Hu wrote:
> On Thu, Jun 4, 2026 at 5:43 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > > @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
> > >                                 struct phys_vec *phys_vec, size_t nr_ranges,
> > >                                 size_t size)
> > >  {
> > > -     unsigned int nents = 0;
> > > +     size_t nents = 0;
> > >       size_t i;
> > >
> > >       if (!state || !dma_use_iova(state)) {
> > > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
> > >               nents = DIV_ROUND_UP(size, UINT_MAX);
> > >       }
> > >
> > > +     if (nents > UINT_MAX)
> >
> > I would suggest to use check_add_overflow() while calculating nents
> > instead of this check.
> 
> Hi Leon,
> 
> Thank you for the review. Using `check_add_overflow()` is a great
> suggestion and definitely
> cleaner for the accumulation loop. I'll update this for v6.
> 
> > > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
> > >       }
> > >
> > >       nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> > > +     if (!nents) {
> > > +             ret = -EINVAL;
> > > +             goto err_free_state;
> > > +     }
> >
> > Technically, this hunk is not necessary, since sg_alloc_table() will
> > return -EINVAL when nents == 0. At least, that is the behavior I relied on.
> 
> I originally added this explicit check in v5 to address Jason's
> feedback, and to make the
> failure explicit rather than relying on `sg_alloc_table()` failing
> silently on `nents=0`.

I prefer explicit checks, but I am not in favor of duplicating them.
Since sg_alloc_table() already validates this condition, we do not need
to repeat the same check in dma-buf. A comment should be sufficient to
inform future reviewers that nents == 0 is already handled.

Thanks

> 
> Jason, do you have a strong preference here? I am happy to drop the
> hunk and rely on
> `sg_alloc_table()` returning `-EINVAL` if you are both comfortable with that.
> 
> Thanks,
> David
