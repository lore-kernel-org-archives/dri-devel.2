Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E8EC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A5210EDEA;
	Mon, 14 Sep 2026 12:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gCsAFcR0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60E810EDA3;
 Mon, 14 Sep 2026 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789387446; x=1820923446;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=RwEZhfMJP7L6Q0UDZRqChxPxeZtWRLjjgHga4wyLG+U=;
 b=gCsAFcR0CPZkKCq2CZqPTWbYBOuU2HzZ2NpCCY2l6z80hS7W9jRJWLfm
 D4GzmbyzTHb+rQsjq309oZKFcrtvRJGR9X9JUeBsjCwKM4RiJ0y/nc6Sb
 S4mqHULrIuMh1pxQR6vo8Lld90wxMICNC0cEdbVkAdoIePDfGB8/TEPPp
 H0CTqyqX98iiJE63i0Qq4BKHWdxUds9W6pxzM7e1C3CWiNAy8DiFYNQQo
 CmTmadPqbI0ArJw6bXLFEn57vTe7Qjdx53No9gofHZ/kMk654Z+IfxBFe
 +4ZDqa05Ot3ouU+JT6t/e0IJ0TCqTOqBNw25xKlWwpHCROPG0Yt0JtHNT A==;
X-CSE-ConnectionGUID: 7Z4GsBqvSIuNHP5DavrSoA==
X-CSE-MsgGUID: 2Dai1F3KRUqQILK8XXlf0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89763227"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89763227"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 05:04:05 -0700
X-CSE-ConnectionGUID: h0RGzZDZSImuU1pjcvMo4g==
X-CSE-MsgGUID: FzTGZXnSSpmvM9i3IXefpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="274541772"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.96])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 05:03:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Jens Axboe <axboe@kernel.dk>, Jakub
 Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr
 Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-block@vger.kernel.org, netdev@vger.kernel.org,
 linux-api@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/i915: Include error-injection.h for
 ALLOW_ERROR_INJECTION()
In-Reply-To: <20260911-module-include-error_injection-v1-4-5da895d8c84d@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
 <20260911-module-include-error_injection-v1-4-5da895d8c84d@suse.com>
Date: Mon, 14 Sep 2026 15:03:56 +0300
Message-ID: <2860c528b7ce0d596a24b05f0ae2b4a9f21be301@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 11 Sep 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
> Several drivers/gpu/drm/i915/*.c files use ALLOW_ERROR_INJECTION(), which
> is defined in asm-generic/error-injection.h. They currently rely on this
> header being included indirectly through linux/module.h ->
> linux/error-injection.h.
>
> Add the missing includes in preparation for removing the
> linux/error-injection.h include from linux/module.h.

I guess merging all of this through one tree would speed things up for
you.

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree you prefer. However, please let me know
if you do want this merged through drm-intel.

Thanks for doing this.


BR,
Jani.
 

-- 
Jani Nikula, Intel
