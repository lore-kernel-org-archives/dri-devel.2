Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494D7CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAB810ED7D;
	Thu, 11 Jun 2026 08:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YEz0Y66A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFDB10ED7D;
 Thu, 11 Jun 2026 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781166566; x=1812702566;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=PQrdG7EV4quhX26AHkiaOyDqMWYsaSvMsUL42rw95G8=;
 b=YEz0Y66A90AZ3hNd1X0TAyrcZMojFddC2Mfb2dc03XojdBi3zv76a1R/
 U7kUom7MSIDjEgVYHdv2/boOBbeirfZAW1pMccpBm+deoTsgjWNNE9fWe
 ZdlRZIjkqZGJOGTekGismS8n7BS3CfJ18QVo7wH6NAJGcjlVxvrvWtGRL
 pWBj0iHf9QD0GlSqiaZRrAsI1dPsydMIj7C55JW/+Jm/Rksnnepfsdjik
 k3fkvI7AchOp+/0J+CL8ukLGqaLpriZEbnNU3RTp2Gs4eJ219NFDYvOpE
 tZ81Psu7bxxqrRQv/hJTK/AEJuOo4u4FYuFtkyS1TMT5u59zZkUf3yALM Q==;
X-CSE-ConnectionGUID: RS95fzvNTxqa3sz8RturRQ==
X-CSE-MsgGUID: DOwCQPQJRjizmyl+A/5UYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81953795"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="81953795"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:29:25 -0700
X-CSE-ConnectionGUID: ZG4MT08iQHe6mEq2035+wQ==
X-CSE-MsgGUID: s/GNAqCUTJqY9+1lZtgZqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="240074812"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.123])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:29:13 -0700
Date: Thu, 11 Jun 2026 11:29:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Huang Rui <ray.huang@amd.com>, Eddie James <eajames@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Waiman Long <longman@redhat.com>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kaito Cheng <chengkaitao@kylinos.cn>, Muchun Song <muchun.song@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
Message-ID: <aipx1goKIsk40vrF@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
 <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
 <6b2efdee-95b0-4306-a682-0d0466497ddb@amd.com>
 <2399841f-d834-4652-8285-4a15c7d9a9b9@linux.dev>
 <d974a2ea-6102-45ff-bf36-3b25a2404e40@amd.com>
 <ail8iNvPrJnE7p58@ashevche-desk.local>
 <92683537-8404-47fe-a4ba-160e54870f0b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92683537-8404-47fe-a4ba-160e54870f0b@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Thu, Jun 11, 2026 at 10:01:25AM +0200, Christian König wrote:
> On 6/10/26 17:02, Andy Shevchenko wrote:
> > On Wed, Jun 10, 2026 at 11:11:34AM +0200, Christian König wrote:
> >> On 6/10/26 10:18, Kaitao Cheng wrote:
> >>> 在 2026/6/10 16:07, Christian König 写道:

...

> >>> Should we revert to v1, or keep list_for_each_entry() and
> >>> list_for_each_entry_safe() as they are, close this thread, and make no
> >>> changes?
> >>>
> >>> Link to v1:
> >>> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
> >>>
> >>> Or do you have any better suggestions?
> >>
> >> v1 looks perfectly reasonable to me.
> > 
> > But why not just hiding that once for all (in case they don't use the temporary
> > iterator)? Easy to automate, robust — everyone is happy?
> 
> As far as I can see that is an extremely bad idea.
> 
> The distinction between the use cases of 'iterating the list' and 'iterating
> the list while you modify it' is completely intentional.

What I meant is to keep the name, just drop the parameter (make it hidden and
being defined inside list_for_each_*_safe() cases).

> See the bool type can be implemented by int as well, but it is just a
> different use case.

> >> You should just include some patches in the same patch set to actually use
> >> the new macros.
> >>
> >> If you modify the files under drivers/dma-buf or drivers/gpu/drm/amd to use
> >> the new macro I'm happy to review that.
> > 
> 

-- 
With Best Regards,
Andy Shevchenko


