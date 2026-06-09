Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23363CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2D810E111;
	Tue,  9 Jun 2026 07:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HhxtLC+3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2050C10E10F;
 Tue,  9 Jun 2026 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780988576; x=1812524576;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yzH6uJSi6Qy/tGngU0UZEQlj4llniF58GR8UVGOo5h0=;
 b=HhxtLC+3DtIZry9DaHdwPlRDQhjNmMMLt4qt68nqfIvlC0bs3jG+oU9+
 k9oysQLfrFyHiBvblQuXJIO6AaNUA/Dx9Y79zwhp6+uYfS3BzyIbcpbYN
 jOGKz1NFJIxJEcCHllojj5xHeVBzxuM3wIgkO71CXuJHQTDv1ntkIgg2m
 uBwkUAQPVPKWorwLIUx6E7VHJFzRGN+bAW8a6o93A7caO7cfs9UKAhZHC
 NePGdh4BCjt/fiPORIUk9N4HsYVypBzOvzPg86RWMRXjDv4pbHG6qtdR0
 BI7jFB1dhlRczhthMRcEI1akzOwjEesME6IOCHHbNbRgs+gJm+aYj+E1t Q==;
X-CSE-ConnectionGUID: n1FxodbbQIm2Dk25S8jc6Q==
X-CSE-MsgGUID: Wc4vfLSeRqGOV9wBq3iYjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85364897"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="85364897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 00:02:55 -0700
X-CSE-ConnectionGUID: NtMsANXzRtq8/DTsdCsIOw==
X-CSE-MsgGUID: Qc9xZ1QCR5ObTHR46qYy4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="243342065"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.245.39])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 00:02:42 -0700
Date: Tue, 9 Jun 2026 10:02:40 +0300
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
 Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v2 07/14] spi: fsi: Open-code message transfer walk
Message-ID: <aie6kH06I6mMeoED@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-5-kaitao.cheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609062526.94907-5-kaitao.cheng@linux.dev>
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

On Tue, Jun 09, 2026 at 02:25:19PM +0800, Kaitao Cheng wrote:
>
> A later change will make list_for_each_entry() cache the next element
> before entering the loop body. fsi_spi_transfer_one_message() can combine
> the current transfer with the following transfer and then advance the
> cursor to that consumed entry.
> 
> Keep the transfer walk open-coded so the loop step observes that cursor
> update and skips the consumed transfer. This preserves the existing
> message sequencing semantics and prepares the code for the list iterator
> update.

...

> -	list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
> +	for (transfer = list_first_entry(&mesg->transfers,
> +					 typeof(*transfer), transfer_list);

You can keep this on a single line for more logical split.

	for (transfer = list_first_entry(&mesg->transfers, typeof(*transfer), transfer_list);

it's under relaxed limits for the line length.

> +	     !list_entry_is_head(transfer, &mesg->transfers, transfer_list);
> +	     transfer = list_next_entry(transfer, transfer_list)) {

-- 
With Best Regards,
Andy Shevchenko


