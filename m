Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3555FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F7510E3C4;
	Fri, 26 Jun 2026 15:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SDf52Gxp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADD510E3C4;
 Fri, 26 Jun 2026 15:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A9B942A7C;
 Fri, 26 Jun 2026 15:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5DE1F000E9;
 Fri, 26 Jun 2026 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782489299;
 bh=HnX3YkJzFg+3/HFsm1Ylzc3uTkNta0IzAnCrp7mu+iE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SDf52GxpGNgv+SwKs1zF60r8V4sFTL6eLqeuetGHz5ah5abm2Xorp0vbLk6VPROq2
 5arCElFTIRI6AMLKM18oKfGsQKC2iHOBoaBgt9tuCfRbb3g2TZVtg/Qsn9BEznse9r
 3nchadlbDlSA8MUzwliMEPD6cxE69LZ+cSVAZNCsMWLl4mld8bc9KEyzVQVRFuIs2E
 WJNmAHpUKrmfxh6lr1a2UY4yx3X/iHqPLeNJ8zyqM717EKkb5cAOm+OCLUjfwCLL79
 l1kJS7QysIHcYqZjXeFm+3HGSgayW9I3P09wrpuGw3gfUHBa7fvzHZf9fFqsA2MBy1
 9wOzwo64D3gnw==
Date: Fri, 26 Jun 2026 17:54:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915/gt: Return bool values from a boolean helper
Message-ID: <aj51Ia0HE9xDufPh@zenone.zhora.eu>
References: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
 <53ba85083a23024c7d54b656c834c144abbb57cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ba85083a23024c7d54b656c834c144abbb57cf@intel.com>
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

Hi Jani,

On Thu, Jun 25, 2026 at 04:11:45PM +0300, Jani Nikula wrote:
> On Thu, 25 Jun 2026, Andi Shyti <andi.shyti@linux.intel.com> wrote:
> > intel_has_gpu_reset() returns logically correct values by
> > returning a function pointer when GPU reset is supported and
> > NULL otherwise. However, as a boolean helper, it is more
> > appropriate to return explicit true or false values.
> >
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/gt/intel_reset.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
> > index b2cf672564dd..a3f198646e1d 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_reset.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
> > @@ -797,9 +797,9 @@ static int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask
> >  bool intel_has_gpu_reset(const struct intel_gt *gt)
> >  {
> >  	if (!gt->i915->params.reset)
> > -		return NULL;
> > +		return false;
> >  
> > -	return intel_get_gpu_reset(gt);
> > +	return !!intel_get_gpu_reset(gt);
> 
> !! is superfluous.

OK, I can resend it. I actually like the use of "!!" because it
explicitly converts the result to 1 or 0, by definition of true
and false, but I don't have a strong opinion on it in this case.

Thanks,
Andi

> >  }
> >  
> >  bool intel_has_reset_engine(const struct intel_gt *gt)
> 
> -- 
> Jani Nikula, Intel
