Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B6BFF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD4810F2B7;
	Thu, 30 Apr 2026 09:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d+ZyIIik";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCFD10F2B7;
 Thu, 30 Apr 2026 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777540488; x=1809076488;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VgSMKuQHRh9NgW359zqjZ9QN2R1rhbUWDwarmtAsrgk=;
 b=d+ZyIIikAWSLdq0xiKWGjm9VXnGOMofYA3vCzEeKTXNFTOHe9aqdnmAS
 Ht+Oco1zbA+Ryl3nmuBopP79+IoXROoGMaWopA7TNdsuVixf29oDoDlm7
 4c3NfSZY5C7WaY7EAhHsr/sFs6+pb8zpbfcLKQS4xNEn22Vd3oPco6LjU
 1BH54jHaQhPwmxA8uC9794upyh80yQHDvwSYbQIMlDBm9VYalhGFROwXj
 hx/XVv++ocu63CtH4ekgiWSzwRrCyS1varGSwYpPMSbalYiGXlmBq41Nw
 SWKv7jedYlqWImn5xOBPTp5QVzsWQhgvRPjVQEcowLpnizFh24HpC1pXk w==;
X-CSE-ConnectionGUID: 9VxXtvB4RWmdamUh8h1G8Q==
X-CSE-MsgGUID: vkXFVRH3SnWnSChPZ4Lc2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89177234"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89177234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:14:47 -0700
X-CSE-ConnectionGUID: tf9X7aieTjieO0kFqc06fg==
X-CSE-MsgGUID: 9Nw0AEyDSRmWRMqUwMubhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="238851628"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.118])
 ([10.245.244.118])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:14:46 -0700
Message-ID: <4dea1e78-da81-4c5b-ab8d-62d6f99e4889@intel.com>
Date: Thu, 30 Apr 2026 10:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
To: Tejas Upadhyay <tejas.upadhyay@intel.com>, intel-xe@lists.freedesktop.org
Cc: Arunpravin.PaneerSelvam@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260429123714.3913374-2-tejas.upadhyay@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260429123714.3913374-2-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 29/04/2026 13:37, Tejas Upadhyay wrote:
> gpu_buddy APIs are expected to be called with the driver-provided lock
> held, but there is no runtime enforcement of this contract. Add lockdep
> annotations to catch locking violations early.
> 
> Introduce gpu_buddy_driver_set_lock() for the driver to register the
> lock that protects the buddy manager. Add gpu_buddy_driver_lock_held()
> assertions to all exported gpu_buddy and drm_buddy APIs that
> access/modify the manager state. The lock_dep_map field is only compiled
> in when CONFIG_LOCKDEP is enabled, adding zero overhead to production
> builds.
> 
> Wire up xe_ttm_vram_mgr to register its mutex with the buddy manager
> after initialization.
> 
> Assisted-by: Claude:claude-opus-4.6

I think add:

Suggested-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>
