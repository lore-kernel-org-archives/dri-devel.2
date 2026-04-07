Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E52DEDB7CF
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBC689E1A;
	Tue,  7 Apr 2026 07:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MBgEXcoI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CB689E1A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775548310; x=1807084310;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=zPidFyj/5K+uqm5xMG/ZLu1N7jXnDCjX5osQ6GMESPI=;
 b=MBgEXcoIJ7nmSB5hUopNGK7B/JUBsdL3C+w9iAkIqxAJXLnX8X/Vua+v
 9RmfUzKp5MGwzjgXjDQz9N5obaeEPysPoGfYHbYM03yPQl/OkaTCXrRx+
 /p/vcsQ3fybMcsndrsoymKnWgeSbVX4thli3b196PjQe3RwBxSaNRmboS
 65HSXocUgtuEJXzX0HMc4GtQyNfVEA/m7PWcDlvlh/qSa+bR1YQmKn8WP
 MTVN4OtSvYYy4W1af+JZWKdoU1AXfMEydc7d3hrjaN4seu1I089u9BjfW
 JGx4dYx7CmWGeMM5lAdwLBQXQKZCNgvzYmTpRE5PvMh6X0PYLUu+qnQc2 A==;
X-CSE-ConnectionGUID: VyPzynZuSYujypb4dDKsCg==
X-CSE-MsgGUID: sLmxAPUZQc6ag+i1o6JKdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79095296"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="79095296"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 00:51:49 -0700
X-CSE-ConnectionGUID: U+4bHYwUTs6n+pnpsjyJJw==
X-CSE-MsgGUID: zTjYf6VsS/KZXRgvDOlx9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="232132566"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.244])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 00:51:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: denis <den.demchenko@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Denis Demchenko <den.demchenko@gmail.com>
Subject: Re: [PATCH] drm/edid: Add quirk for YUK monitor 0xaa01
In-Reply-To: <20260401044238.15201-1-den.demchenko@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260401044238.15201-1-den.demchenko@gmail.com>
Date: Tue, 07 Apr 2026 10:51:44 +0300
Message-ID: <ef9f7a9da9de1fbda178e6ee4c92bbb9d4faad92@intel.com>
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

On Wed, 01 Apr 2026, denis <den.demchenko@gmail.com> wrote:
> From: Denis Demchenko <den.demchenko@gmail.com>
>
> This monitor results in a black screen with amdgpu unless
> EDID_QUIRK_FORCE_8BPC is applied.
>
> Add a quirk to force 8bpc which fixes the issue.
>
> Signed-off-by: Denis Demchenko <den.demchenko@gmail.com>

Would be really useful to have an fdo gitlab issue with the EDID and
possibly dmesg attached before applying quirks.

BR,
Jani.

> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ff432ac6b..b533eb74e 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -253,6 +253,9 @@ static const struct edid_quirk {
>  	/* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 bpc */
>  	EDID_QUIRK('S', 'H', 'P', 0x154c, BIT(EDID_QUIRK_FORCE_6BPC)),
>  
> +	/* YUK */
> +	EDID_QUIRK('Y', 'U', 'K', 0xaa01, EDID_QUIRK_FORCE_8BPC),
> +
>  	/*
>  	 * @drm_edid_internal_quirk entries end here, following with the
>  	 * @drm_edid_quirk entries.

-- 
Jani Nikula, Intel
