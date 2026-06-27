Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D16C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E0810E44E;
	Sat, 27 Jun 2026 04:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YeNtSbrH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1437B10E44C;
 Sat, 27 Jun 2026 04:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782536302; x=1814072302;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wJ1ta97rP02Dpmjs4Fryy9pvJKVOVxnFECZwKojKxy4=;
 b=YeNtSbrHXlDZqGFugBvgpgFQ++lANP/fg6G6xY1GOQHFvmCmNiW2pLn9
 xVoJsvF7PPNI5hJeJCRzLDlFCtR8oflMnSfnxEMiv8TYg5NOP9/rH/WY8
 AoQlkA8un1m1x+QE3656bRCmazMCgEBEqzUKPXOfVx1/v0HESUgYd4dgT
 YDHQkKg29tfRo/KpI5aQhIDOtElUilT+R58SnO+RAGlxeYLJbddh5xfpV
 8QVmtVoJbaiaSNE+toO6SnnUqqH64AIFMzQFAfGpMKehD55Um1d2agWQ9
 GjD9oNZLHGXtWYbF8owadx8hIZSNdNMx2nk3gdxxQ4wc87vhRUsXMMgrr A==;
X-CSE-ConnectionGUID: 7Wfm4AJxQDqEedN34e5lpg==
X-CSE-MsgGUID: AmWjrYLRRV2B1tc/UOR1GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="106115973"
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="106115973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 21:58:21 -0700
X-CSE-ConnectionGUID: FEJTac5gSSe7gTlkLlaWNQ==
X-CSE-MsgGUID: tz7724V5S8mOzmvYDpKMqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="248839081"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 21:58:19 -0700
Date: Sat, 27 Jun 2026 06:58:16 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v2] drm/i915/gt: Return bool values from a boolean helper
Message-ID: <aj9YaEM48RkX7DSo@black.igk.intel.com>
References: <20260626215232.861416-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626215232.861416-1-andi.shyti@linux.intel.com>
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

On Fri, Jun 26, 2026 at 11:52:32PM +0200, Andi Shyti wrote:
> intel_has_gpu_reset() returns logically correct values by
> returning a function pointer when GPU reset is supported and
> NULL otherwise. However, as a boolean helper, it is more
> appropriate to return explicit true or false values.
> 
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
> Link: https://lore.kernel.org/r/20260625114442.2912230-1-andi.shyti@linux.intel.com

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
