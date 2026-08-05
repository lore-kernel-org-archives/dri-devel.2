Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0298C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4302E10ED94;
	Wed,  5 Aug 2026 09:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CpKAevCK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190BA10ED94;
 Wed,  5 Aug 2026 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785921338; x=1817457338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5dcY8ESx+RVNPlUE25EgFhFzJCXhmNTvvsHfNdhT9nM=;
 b=CpKAevCKxSmUKeYTZG+aTm00VAOiVzZQlSs0UxXuxSxxGCxSy2ZO326U
 +z5S+QRQ3s98kowQRMkGx1PRLgaE2rHkqS3oWBk8m2hTbHTUELrEII4UF
 38aWQqQ8E33s+OPQofjTAJg6GfWLW1aF+vH+Ctlh0iH8ktP3eLj20XTVs
 LKV9VOrxM+axug37iYu2q/xXk+fdtTzKwY1vqkebOOKUB3uP2my3bE+gc
 w9AA7aDeA57bDBPlm69wqg4gTHJ9Ibq+2+hs5E7Pe8xonOTvJHGAz3zOF
 H/Is6OCDFlFwHB/HrTm8TuWAZM5dASZFRBf008iZo8WH4SRehAp2Twm/K A==;
X-CSE-ConnectionGUID: fAnFyoBWQ2ilXVU4KwlMDg==
X-CSE-MsgGUID: y7GnhhL9SFicqk8xqhW2rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86566650"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86566650"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:15:37 -0700
X-CSE-ConnectionGUID: bxIbxG0oRBCtlCijk/I7cA==
X-CSE-MsgGUID: /goR08lSROGLoWPWQY/9JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="286409185"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:14:01 -0700
Date: Wed, 5 Aug 2026 11:13:57 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v13 4/4] drm/xe/ras: Use fault-inject to trigger
 cold-reset wedge
Message-ID: <anL-1UiSNMQfsXEk@black.igk.intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
 <20260805071152.1225416-10-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805071152.1225416-10-mallesh.koujalagi@intel.com>
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

On Wed, Aug 05, 2026 at 12:41:57PM +0530, Mallesh Koujalagi wrote:
> Use the fault-inject framework to trigger the cold-reset
> wedge path (punit_error_handler()) for testing the
> wedge/recovery flow.
> 
> Usage:
>   echo 100 > .../wedge_cold_reset/probability
>   echo 1   > .../wedge_cold_reset/times
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v13:
> - Rename inject_punit_error to wedge_cold_reset. (Riana)
> - Sashiko corner case issue addressed with
>   commit 20bc4883c7c0 ("drm/xe/ras: Fix boot-time ras error processing").

If the issue is already fixed, I don't see why this patch is still needed.
But if it helps in any case,

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
