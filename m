Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B6606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kwj2yoBg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5223110E7D0;
	Thu, 29 Oct 2026 08:44:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A566110E059;
 Thu, 29 Oct 2026 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793263446; x=1824799446;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=WP/QAZ7Uc8hCjUk9W10FsuMb7rLn58PCckd869LjBFA=;
 b=kwj2yoBgupyp5IAV0wK58klQS9NyrD3FpPZHuPNibHJZvXoMXe1ONcDQ
 lxjQi6P5W13Cw2q8CmZlim51OjyincDA/L1gVq57Mg1ct9HZHUfyuSdtu
 lNXLO4bvGoV0uwpCrCOkDMMzEqn5jV6tA5kdDBk3HeOtaHDw5qu3mJCfX
 paLbRGWPiT1NJhQBbd+vsl0SOVK+mM/iOZAA3CfsmvEAu3W4GdimuKXd6
 nS6rtFwsyWu6JL6EhDS4F3VSzASNv7B9YNyPmb9kEiV9O487BzX9A/eXa
 q4SobvY8hehlW5EC6+5SIcflMiOja0cC86OKyCf2M+Jf41jMEhHyIDGxs Q==;
X-CSE-ConnectionGUID: xL5kNg9dQeCNBF2L1HWPwQ==
X-CSE-MsgGUID: wBCLWs4MS/mLTpZFWpeycg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2011320"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2011320"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 01:44:06 -0700
X-CSE-ConnectionGUID: oDqzyd5cQ0OZV3ZmvaMS7A==
X-CSE-MsgGUID: gVbT5JW4Somf8pxelwKQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5411378"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.74])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 01:43:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6n?=
 =?utf-8?Q?ig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
In-Reply-To: <auHf-pdvGkPibgTp@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
 <auHf-pdvGkPibgTp@zenone.zhora.eu>
Date: Thu, 29 Oct 2026 10:43:56 +0200
Message-ID: <b3045bc3ae77ef78a1f479448a5dc780d89bf38d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
> Hi Dmitry,
>
> On Wed, Oct 28, 2026 at 08:19:44AM +0000, Dmitry Ilvokhin wrote:
>> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
>> nonnull") added the macro __nonnull_args() to wrap raw compiler
>> attribute.
>> 
>> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
>> nonnull attribute usage across the tree and keep the attribute's quirks
>> in one place rather than open-coded at every call site.
>> 
>> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Pushed this patch to drm-intel-next, thanks for the patch and review.

BR,
Jani.


-- 
Jani Nikula, Intel
