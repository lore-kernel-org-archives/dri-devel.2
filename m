Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1483606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ByWpXUDN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E3711228B;
	Thu, 29 Oct 2026 13:21:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A632710E807;
 Thu, 29 Oct 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793280087; x=1824816087;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tkpV40hGhO5XeSgRXjpBId5i/GBz5co0mYtfaR2uPHc=;
 b=ByWpXUDNtE041PcxpjxWOiUscgxyB6wd6HHSHpTkfdqKrHt0nNRiVlNi
 iGklM75b35IAYUuhXooKHYUmke4On3DONklwepMYt50Djjh06D7hR/Rex
 esUsgPmXo0WZuKINjKwAM6b4UUGSGG7PK3uLp0KOwXMJ9Ve95Rq71K6ok
 ZTbVwrJtQ3UAP5w6ouWkzPjbCO2HwwJ57OkdBxrphXE17pJpMMiUe3njz
 NUk5U7n9eOiQY0ZCuPOO+1cX7gC1QAHtyYunBwh7eVVMghapDtlxlu7Qu
 NlkGAblFP0nufHK66JBOIdzsfzqWVolsTSSd96UzdOwOj2C2cf5pu4X9r g==;
X-CSE-ConnectionGUID: xAxVTxZPRS2H8FKEkOcdfQ==
X-CSE-MsgGUID: S5lDBfYpQx+OaaW6GCmJqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1899932"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1899932"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 06:21:26 -0700
X-CSE-ConnectionGUID: lcHCQ8oTT4+RWbV1aJm5jw==
X-CSE-MsgGUID: gd6Ro2tCRA6pOUXdfheN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5690610"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.129])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 06:21:17 -0700
Date: Thu, 29 Oct 2026 15:21:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Ilvokhin <d@ilvokhin.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Message-ID: <auNIS5n2aUD9t7yB@ashevche-desk.local>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
 <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 02:00:28PM +0100, Miguel Ojeda wrote:
> On Thu, Oct 29, 2026 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Should gem.h now include <linux/compiler_attributes.h> ?
> 
> No, it should be included for you (unless you are doing something
> custom with the compiler flags etc.).

Usually it comes to the mere drivers via types.h, in rare cases (usually some
more generic library headers, we do better granularity as it affects the almost
entire kernel. Just double check that types.h is explicitly included.

-- 
With Best Regards,
Andy Shevchenko


