Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED4C54FDF
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C8710E120;
	Wed, 29 Jul 2026 21:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g6P7wRDO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09AFE10E0C4;
 Wed, 29 Jul 2026 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785360207; x=1816896207;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=5RAkndojq9KcmPXnY07daoJpRqSd1VwCLWE/ReWiCu8=;
 b=g6P7wRDOFt68rQQN/xBc4nyQOlvCW9Trcad6YUe92zF5dJPYhAabX0Dl
 PXZ3Fv/yf1klHguyqzfqE8Mg+AuOxG5fTpd1nm0Pi+NKgd6WsTf2MWW9Y
 gmW0++IOjuZS7zwXK7OYKNNHP/NZiimsmw7At2+u4JwNTubyRGbhqjZD1
 md97FO6Axr6jddekjwezl8XIgbZdsq7KutsP5JW6I8xtFjm3sC158e+c8
 wIkNRXJQ1C5e91LveRYxyH6H+6lPFU6vond0sBJUXKNXL3/PFr8tMpDB6
 t3wVkvD/BzsICEIBhe6CyLofJQCbxxJbWPbo5D4Lb/17cR+E6zuowht4r g==;
X-CSE-ConnectionGUID: kl2TWNMSQJS81sPg1YK+/Q==
X-CSE-MsgGUID: WwKbkjYYSwWu9EKW3Km6WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="73513798"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; d="scan'208";a="73513798"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 14:23:27 -0700
X-CSE-ConnectionGUID: WK1lmFafRwe8XcBmpmSbjA==
X-CSE-MsgGUID: df29Evc5Q4WKKGZWyPuHNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; d="scan'208";a="256188462"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.96])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 14:23:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jerome Tollet <jerome.tollet@gmail.com>
Cc: ankit.k.nautiyal@intel.com, ville.syrjala@linux.intel.com,
 arun.r.murthy@intel.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jerome Tollet <jerome.tollet@gmail.com>
Subject: Re: Question about drm-intel-next vs drm-intel-next-fixes for HDMI
 scrambling patch
In-Reply-To: <20260729161606.81668-1-jerome.tollet@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260729161606.81668-1-jerome.tollet@gmail.com>
Date: Thu, 30 Jul 2026 00:23:22 +0300
Message-ID: <6b812bfdbcfcf3a090b22413db3ef57d75bc2058@intel.com>
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

On Wed, 29 Jul 2026, Jerome Tollet <jerome.tollet@gmail.com> wrote:
> Hi Jani,
>
> I would like to better understand the i915 patch flow, rather than question
> the decision itself.
>
> The commit b7d51d65e4f1 ("drm/i915/hdmi: Poll for 200 msec for
> TMDS_Scrambler_Status") was pushed to drm-intel-next on June 11. It was then
> included in the July 2 drm-intel-next pull, described as the first feature
> pull towards v7.3.
>
> However, it was not included in the drm-intel-next-fixes pulls for v7.2,
> including the June 25 pull, and it is consequently not present in v7.2-rc5.
>
> Could you please explain how the decision is made to route a patch to
> drm-intel-next versus drm-intel-next-fixes? In this particular case, was
> there a technical or review reason why the patch was not considered for the
> v7.2 fixes pull, or was it mainly a timing/queueing decision?
>
> I am asking to understand the process for future contributions.

All i915 patches get applied to drm-intel-next first, and fixes are
cherry-picked to drm-intel-fixes/drm-intel-next-fixes based on Fixes:
and Cc: stable trailers. In this case, the patch had neither, and none
were added while applying the patch.

It can still be cherry-picked for drm-intel-fixes if necessary.


BR,
Jani.

-- 
Jani Nikula, Intel
