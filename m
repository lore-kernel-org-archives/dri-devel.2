Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11059C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D52A10E82B;
	Tue, 28 Jul 2026 09:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gCV9KJO7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7637010E826;
 Tue, 28 Jul 2026 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785230282; x=1816766282;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=gxtHsh5bVAVLlQWQ4LAxb8A3cKlx4dsiW68sPlea3RA=;
 b=gCV9KJO7rwnKU2b+ov4+tb5ffm5hqzQQvL/PhmcFyadveGdut78hjdjK
 x+sFgGqG+8/0GISdg40A4tPCP7Pam76iHfTuiB8sE7nEVYq4EccU3pKzz
 w6ijcuWP6wB7BCQ8Gb9ZOPSghSFzgSceNImykw4Obn08fMjL5DfH+Veip
 oFuKWRKjm7LblE9MJGJ1z60ZPegRNq7YM7gGJwxQU+E6nI7zKvjkvI+Dd
 dzee6SLogWAdvPA7m10W8/LLnVj0UH1sGTlA5YMRaqUxR6U2o9c1pR9vN
 j08gYQg7GYpwz1+t4AQvz5fvS5NfoPaatQfG8flDf0VmVbG8dxSgz2f6i A==;
X-CSE-ConnectionGUID: YE7V9M/YT5GlrD9n7CiKrQ==
X-CSE-MsgGUID: sXrFPJudSF62xsKtQbQ8VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84787768"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="84787768"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 02:18:01 -0700
X-CSE-ConnectionGUID: BxD0LiEBS0yp34ndC8SgYg==
X-CSE-MsgGUID: bPiadcGqTRmJ24OvxtdEIg==
X-ExtLoop1: 1
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.76])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 02:17:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>
Subject: Re: [PATCH 0/3] drm/xe: Disable stolen memory for driver allocations.
In-Reply-To: <20260630135523.1775379-1-dev@lankhorst.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260630135523.1775379-1-dev@lankhorst.se>
Date: Tue, 28 Jul 2026 12:17:57 +0300
Message-ID: <e7d8aefbafaaf5284c48d671a6951c8c8a614153@intel.com>
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

On Tue, 30 Jun 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
> Using stolen memory has effect on system stability on integrated at high load,
> and causes increased latency waking up from media C6 state.
>
> Only use stolen memory when needed, which is for GSC firmware and FBC.
>
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
>
> Maarten Lankhorst (3):
>   drm/xe: Avoid using stolen memory for DPT.
>   drm/xe/display: Avoid using stolen memory for framebuffer when media
>     gt exists.

AFAICT this patch was not merged at all, but patches 1 and 3 were,
i.e. what was merged was never tested. This is not how we're supposed to
roll.

BR,
Jani.

>   drm/xe/display: Do not allocate into stolen for new framebuffers.
>
>  drivers/gpu/drm/xe/display/xe_display_bo.c | 40 +++++++---------------
>  drivers/gpu/drm/xe/display/xe_fb_pin.c     | 33 +++++-------------
>  2 files changed, 21 insertions(+), 52 deletions(-)

-- 
Jani Nikula, Intel
