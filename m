Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E728F3381E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E625A10E212;
	Tue, 17 Mar 2026 09:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TYKkoxTx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655F910E4FD;
 Tue, 17 Mar 2026 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773738013; x=1805274013;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=bVbMadnnMyfKG/7TEsblf9Dge4ig7t6X4Lm9Om8SJL4=;
 b=TYKkoxTxvRSZq7Az9qVdpjSnFML92GkKuquX+UInY6BNpwwjtRj59JRh
 irY9bpqX2TCZ6Qc3pz7+/z1U/kfd8OTwdzoqkf3X5OU1PBwsC30T72Omh
 grxdJuEAaSg8PVzciTcotpsi0XvQJgKnm3Gp4VFRWYsod4/gRtjqC+XgR
 w+pkvHfsV4kN5NY7AmfR5fVUsdOnTEu1gWmjA+WjkwMTmmpMs22S6WBE6
 o2Vgf3Nm9BeFsZm4OMptuV+x1+sl4C3sVQbQCuSpUXAQmL69ZNaaMFzo8
 tPW+DtIzNnEBV8C/FF+xqst1zsZU9LLQ0fvI1z5N1CcdcIuIYf+g1nAyQ g==;
X-CSE-ConnectionGUID: S+r3UHgsS1uZg7pPIMU8Rw==
X-CSE-MsgGUID: 1yHjwjgsTNa66r+w8Xs4/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74652984"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74652984"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 02:00:12 -0700
X-CSE-ConnectionGUID: ExA7lnRtRMmzYBYpc1rwEg==
X-CSE-MsgGUID: COZv2xRRS8OgN389NvNenw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226879168"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.32])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 02:00:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?utf-8?Q?Jo?=
 =?utf-8?Q?s=C3=A9?= Roberto
 de Souza <jose.souza@intel.com>, Lionel Landwerlin
 <lionel.g.landwerlin@intel.com>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
In-Reply-To: <abg6u6o_Pjxkvi0A@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <abg6u6o_Pjxkvi0A@sirena.org.uk>
Date: Tue, 17 Mar 2026 11:00:05 +0200
Message-ID: <b11ec646ffb147524dcf48dfc8540475b93054e3@intel.com>
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

On Mon, 16 Mar 2026, Mark Brown <broonie@kernel.org> wrote:
> Hi all,
>
> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> /tmp/next/build/drivers/gpu/drm/xe/xe_lrc.c: In function 'xe_lrc_ctx_init':
> /tmp/next/build/drivers/gpu/drm/xe/xe_lrc.c:1554:43: error: implicit declaration of function '_MASKED_BIT_ENABLE'; did you mean 'REG_MASKED_FIELD_ENABLE'? [-Wimplicit-function-declaration]
>  1554 |                 state_cache_perf_fix[2] = _MASKED_BIT_ENABLE(DISABLE_STATE_CACHE_PERF_FIX);
>       |                                           ^~~~~~~~~~~~~~~~~~
>       |                                           REG_MASKED_FIELD_ENABLE
>
> This is caused by an interaction with:
>
>    0e07b16371b6e (drm/xe: Allow per queue programming of COMMON_SLICE_CHICKEN3 bit13)
>
> from the drm tree and is obviously related to:
>
>    https://lore.kernel.org/r/abFpM1FHgzgARB88@sirena.org.uk
>
> This has been broken for almost a week now and just keeps getting worse.

Will be fixed real soon now. Sorry for the delay.

BR,
Jani.

-- 
Jani Nikula, Intel
