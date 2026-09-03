Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BAC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2A710F63D;
	Thu,  3 Sep 2026 14:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ir74EYxC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F387110F63D;
 Thu,  3 Sep 2026 14:50:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82CA540B32;
 Thu,  3 Sep 2026 14:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DE31F000E9;
 Thu,  3 Sep 2026 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788447030;
 bh=ybxJBVLrXv/G3fxvl3wlgNthJjWeu9EpETK3/009/H4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ir74EYxCSi717vuRxLlY/suOWYRLiI3ARno93Hw2EEQMh9oHLge35gVxy456p48/2
 KwLpLVLWBV4X+1qLOnv+agr/f2r5u7vmJ9Q6XKveTHF52awOqHG/+AbNnLkCc1uVMg
 4mfG2C9uO9Yx6qUzgFzuL9TNjBSPmzr6sxmOMyPeKydyQpOZjccWlHPte9SqJeLjWS
 bjyQe4geRdOF9Q0OEokI8NS50k6uXBlOV9imxF8Ryz/vyX/EnfeYKrK5AfJKDmMGzV
 kRAJX3Ik8GUPLkJPPNZZVjePV75QPta+dMdIdMxzYHAdB/4xfjeTkWNKkfnqgAL6We
 5OGQihEoE6/BQ==
Date: Thu, 3 Sep 2026 16:50:24 +0200
From: Thorsten Blum <blum@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix memory leak in query_perf_config_list()
Message-ID: <apmJMLS9bdriCN03@kernel.org>
References: <20260823205028.178597-2-thorsten.blum@linux.dev>
 <178815839811.55476.6042238739250760944@jlahtine-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178815839811.55476.6042238739250760944@jlahtine-mobl>
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

On Mon, Aug 31, 2026 at 09:39:58AM +0300, Joonas Lahtinen wrote:
> Quoting Thorsten Blum (2026-08-23 23:50:28)
> > When krealloc() fails, free the original oa_config_ids before returning
> > to avoid a memory leak.
> > 
> > Fixes: 4f6ccc74a85c ("drm/i915: add support for perf configuration queries")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  drivers/gpu/drm/i915/i915_query.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> > index 0c55fb6e9727..11157fb14db3 100644
> > --- a/drivers/gpu/drm/i915/i915_query.c
> > +++ b/drivers/gpu/drm/i915/i915_query.c
> > @@ -403,8 +403,10 @@ static int query_perf_config_list(struct drm_i915_private *i915,
> >                 ids = krealloc(oa_config_ids,
> >                                n_configs * sizeof(*oa_config_ids),
> >                                GFP_KERNEL);
> > -               if (!ids)
> > +               if (!ids) {
> > +                       kfree(oa_config_ids);
> >                         return -ENOMEM;
> 
> Instead of duplicating the code once more, could we just refactor into
> "goto err_ids;" style to clean up the function?
> 
> Regards, Joonas

I think the cleanup should be a separate patch, since this minimal fix
should make it easier to backport to stable.

Thanks,
Thorsten
