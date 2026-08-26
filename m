Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916EEC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD0910ED90;
	Wed, 26 Aug 2026 16:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hmjRSNiQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7B410ED8E;
 Wed, 26 Aug 2026 16:47:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 858D441975;
 Wed, 26 Aug 2026 16:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87E71F000E9;
 Wed, 26 Aug 2026 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787762837;
 bh=1DSSzfZy/8TicLVWwNtrldrAFs7EU5V9nHRFHxpXEAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hmjRSNiQdRRu5uBLAFtgQwWWGwsxL+0r6TiQUiLwYR8RY9opCXbTamEK37n/8SB+K
 A+g0mM31Vo50QsnnBktl5ybfnczn5dLEm26BEl9P2oGIDBpJ/sBy3G1eqAjj1Cxizq
 YS8vmXAkAQW8vZVM4u7CmZb0/wc5pU6LCXIgxcfOeMqNwu29j1JjCbcxJy3mwrJiX6
 LQGJh+YPhUOriz45CPDU1H5ZbLRVRtapZAfTWjGQ8P+X1/Jq/XFeF5v/YYVDbeOihC
 P6g4NhnGPQi3rvLOaDf+0MGXbSbHC4qXh8EApXahbIsJEP0dZvPmtN/QzB9SDE6YrB
 7kw52RLIT6AWw==
Date: Wed, 26 Aug 2026 18:47:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/i915/gem: Use simpler versions of min*()
Message-ID: <ao8YOAaBsWijMecG@zenone.zhora.eu>
References: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
 <ao2bfCVRT8LuOJCb@zenone.zhora.eu>
 <ao6lOyo5abFmwpN9@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao6lOyo5abFmwpN9@ashevche-desk.local>
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

Hi Andy,

> > > -		nr_pages = min_array(((unsigned long[]) {
> > > -					folio_nr_pages(folio),
> > > -					page_count - i,
> > > -					max_segment / PAGE_SIZE,
> > > -				      }), 3);
> > > +		nr_pages = min3(folio_nr_pages(folio),
> > > +				page_count - i, max_segment / PAGE_SIZE);
> > 
> > thanks for your patch, but there is another patch involving (and
> > fixing) this line of code[*]. You are welcome to join the review.
> 
> Thanks for pointing this out! Do you prefer my to be rebased on top?
> Otherwise one can apply this patch first.
> 
> > [*] https://patchwork.freedesktop.org/patch/746877/?series=172332&rev=1
> 
> Note, my patch doesn't change existing behaviour.

yeah... besides that patch has had some reviews to follow up;
Krzysztof will have a little conflict easy to fix.

I reviewed and pushed your branch to drm-intel-gt-next.

Thanks,
Andi
