Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26370CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F80710E0F0;
	Tue,  9 Jun 2026 06:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kpQ3nSGT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C7B10E0E4;
 Tue,  9 Jun 2026 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780987656; x=1812523656;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JtgXQ+CUhI8fqj7NEQN4vNa7+C8S/fPck+oJyjJdK2k=;
 b=kpQ3nSGTVttOwWGNobS+IC4i0fCpDM0hevIMLeDnN+FnHSp8Tg+o2+7+
 iUsl2bsFYQgzGqDCJmiYP2JI+s8uQ3ORT7OiJiPFI8pf5fCypASbgoLQt
 KSoaWRnfjHwlUWmk1m9OXF7TEkU/q9frDYMyAbqTWmnRlcFyIbsGHNfQL
 6woofQDB5pHRrQFuvzDaCgylnkMZi2AndsQgHZRc9R3vYHmxV7V75O8ZX
 m5OqH+3NQeh7He0w+LN/EFlXvmxNneSNq2m6Xyf5+qcDa4TOICmBMz6vn
 ALcebFmFidcODUCjYvqwgdpnNfQXGV3PZjSBYIAk6UICLScxlOMgPNWLD g==;
X-CSE-ConnectionGUID: sfDoTrKRTj2HKSr28I1aNA==
X-CSE-MsgGUID: /vUoybC1TyCbpKyFJPaZRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81783739"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="81783739"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 23:47:34 -0700
X-CSE-ConnectionGUID: +shHRdOKTfGiz+VFC8i6ig==
X-CSE-MsgGUID: c7oiHZEDR2ikmK04/uJN0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="250060711"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.245.39])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 23:47:22 -0700
Date: Tue, 9 Jun 2026 09:47:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Eddie James <eajames@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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
 Kaito Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
Message-ID: <aie299WveL1utNya@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609061347.93688-1-kaitao.cheng@linux.dev>
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

On Tue, Jun 09, 2026 at 02:13:33PM +0800, Kaitao Cheng wrote:
> 
> This series prepares for, and then updates, the list_for_each_entry()
> family so the common entry iterators cache their next or previous cursor
> before the loop body runs.
> 
> The first 13 patches open-code loops that intentionally depend on the
> old "derive the next entry from the current cursor at the end of the
> iteration" behaviour.  These loops append work to the list being walked,
> restart traversal after dropping a lock, skip an entry consumed by the
> current iteration, or otherwise adjust the cursor in the loop body.
> 
> The final patch changes include/linux/list.h to keep a private cursor in
> the common entry iterators while preserving the public macro interface.
> The safe variants remain available when callers need the temporary
> cursor explicitly or have stronger mutation requirements.

Something is really wrong with the patch series email chaining.
Patches 3, 10, and 13 start the subthreads. Please, check your
tools and fix them accordingly.

Note, `git format-patch ...` should not have this "side-effect"
when used correctly.

-- 
With Best Regards,
Andy Shevchenko


