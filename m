Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832B8CD6E57
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83473113506;
	Mon,  1 Jun 2026 15:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U1IEqtJb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B426113505;
 Mon,  1 Jun 2026 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780328958; x=1811864958;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=mU9NP52Txgjd/Xj8Ln8Hw8lWpp3A7JJN0mbm160/1Eo=;
 b=U1IEqtJbxZ6m3P8Poa1mQ7i4oEFf+Jm1yoErbhTxfN71ZP/7Q6qszmyc
 O4qPTH8lQXwFeDhuX0SrbDXqtUN/M3rfA0JtZxTI4rux71jzOfgjrTMoh
 AOAB1+wrHZKwlAtjGPb+4wcASvKjJunx0gZ2kUSSJl+TyQJH0e/sMU3Xm
 oV4hC8foV35IRDfpehy+ODhUeQJ5kyPpZXGM6YzfSiLOykVogUyo8LchK
 LhsgFm/FiydaxkO9P7KBUPD2/BqsrpsZBXqTyhXhcfdS8AIx30ogqNVTc
 SZ1IJKJMOvZr+RNWbHTdONU2osqtx/Njkcmt6S0KLSITwcwtP14ZFar/x A==;
X-CSE-ConnectionGUID: FOAC+EC1RsW7Hwlq0DOGdg==
X-CSE-MsgGUID: 41zpkB44TT+DCOuCtvOlSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="92203298"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="92203298"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 08:49:17 -0700
X-CSE-ConnectionGUID: jDHDHS1NTWevVpjgRwB6nA==
X-CSE-MsgGUID: NMKyajc5S5GD/qQaXxPymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="243715787"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.121])
 by orviesa009-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:49:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: Re: [PULL] drm-misc-fixes
In-Reply-To: <e1a2cc27fb04a88be23973d3cb7868f3d4471d0d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260529070009.GA313534@linux.fritz.box>
 <ddf0233e50044059c85279f928661563ef6a55bf@intel.com>
 <e1a2cc27fb04a88be23973d3cb7868f3d4471d0d@intel.com>
Date: Mon, 01 Jun 2026 18:49:09 +0300
Message-ID: <d479f1185cd1ae6eb52a7d44e944408c3447c8e4@intel.com>
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

On Mon, 01 Jun 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 01 Jun 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Fri, 29 May 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Rajat Gupta (1):
>>>       drm: prevent integer overflows in dumb buffer creation helpers
>>
>> Looks like this commit 5ab62dd3687b ("drm: prevent integer overflows in
>> dumb buffer creation helpers") regressed in our CI, awaiting
>> confirmation.
>
> The IGT test kms_big_fb uses max width and height from GetResources, and
> i915 and xe use max_width 16384 and max_height 16384 in mode config.
>
> The regressing commit adds random hard limits not based on anything:
>
> +       /* Reject unreasonable inputs early.  Dumb buffers are for software
> +        * rendering; nothing legitimate needs more than 8192x8192 at 32bpp.
> +        * This prevents overflows in downstream alignment helpers.
> +        */
> +       if (args->width >= 8192 || args->height >= 8192 || args->bpp > 32)
> +               return -EINVAL;
>
> This is now in v7.1-rc6. Please revert ASAP.

Ah, missed this clue in the pull request:

On Fri, 29 May 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> here is this week's PR from drm-misc-fixes. There's one cross-subsys
> commit to the dma-buf code. Commit 5ab62dd3687b ("drm: prevent integer
> overflows in dumb buffer creation helpers") has not Link tag because
> it went through the security list.

We have the whole review and CI processes in place to catch silly
mistakes, and then we proceed to shoot ourselves in the foot and bypass
all of that because "security", and expedite the regressions
everywhere. I'll bet this will be in stable kernels in no time too. This
is stupid.

Please also read [1] with its recent updates.


BR,
Jani.


[1] https://docs.kernel.org/process/security-bugs.html#what-qualifies-as-a-security-bug


>
>
> BR,
> Jani.
>
>
>>
>> No matter what, it's immediately suspect because AFAICT it was not
>> posted on the lists, and the commit doesn't have a Link: trailer
>> pointing at the patch.
>>
>> This is not how we're supposed to roll. What's going on?
>>
>>
>> BR,
>> Jani.

-- 
Jani Nikula, Intel
