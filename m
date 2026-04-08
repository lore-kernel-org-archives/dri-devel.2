Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5091073CB6
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2E910E64E;
	Wed,  8 Apr 2026 13:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XtZ6yuti";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D07410E64E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775654554; x=1807190554;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=LmHeyhD+xWiUMBK0rcCv1qZyP5u3ZdtJDIfD+PLnO5A=;
 b=XtZ6yutiZAvGWKxpcaEn7PWVbGr+uMkb9Re58lmRHr1EgQlYkGCDrxw8
 uBrySKnyCI1qkvvnXUGF2L9mtRMhTPWKwBCSLTB8ZmP5v+ymnsg3hu9O8
 +yzXwcaWeK/s0xqr/cOafqxgtv3e08NA+9uMCVx59hbw2jmpzzS7o7yEo
 1WDTb+TfpZePcIOriniFH/30v2GncLdVcq+DxlYOa6evJydFpeO/SiWNu
 ITNpKFZILQFtqmEtkQxO9rjKymhSITuJmGDxstyMJF3YO+VMBA12S2Opv
 lWgXHQ0PXaWbk6y4UN/iX0HN1GOzVXnUErIrTmcVfXPTBKFLVmlv7LBKt Q==;
X-CSE-ConnectionGUID: X4uFJoa6RXGlA8qtHrMrNg==
X-CSE-MsgGUID: mmRjIW/kSSiSV5qoLS2gzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87333878"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="87333878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 06:22:33 -0700
X-CSE-ConnectionGUID: a9JeELtYSuSsTQ1SBmJVPg==
X-CSE-MsgGUID: nIT5Yd1+RriMn15MlWCEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="232836912"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.32])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 06:22:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Denis Demchenko <den.demchenko@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/edid: Add quirk for YUK monitor 0xaa01
In-Reply-To: <3b1385aa-1588-4d72-b632-b47f95f24f78@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260401044238.15201-1-den.demchenko@gmail.com>
 <ef9f7a9da9de1fbda178e6ee4c92bbb9d4faad92@intel.com>
 <3b1385aa-1588-4d72-b632-b47f95f24f78@gmail.com>
Date: Wed, 08 Apr 2026 16:22:28 +0300
Message-ID: <a3208885cfc0652807367cceae6845c111857d10@intel.com>
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

On Wed, 08 Apr 2026, Denis Demchenko <den.demchenko@gmail.com> wrote:
> Good day,
>
>
> Gitlab issue opened: 
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5134
>
> Here are the requested logs:
> EDID: edid.txt
>
> dmesg: dmesg.txt
>
> The issue is reproducible without the quirk and results in a black screen.
> With EDID_QUIRK_FORCE_8BPC applied, the monitor works correctly.

Thanks. I'm fine with the quirk if the AMD folks don't spot anything
else missing on their side.

BR,
Jani.


-- 
Jani Nikula, Intel
