Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E66BC4453E
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE2910E484;
	Wed, 22 Jul 2026 16:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jDuxNPWf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF43E898A4;
 Wed, 22 Jul 2026 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784736015; x=1816272015;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1zRTEO00XxFeWtKklsleVZ0TNy8IkE/o7sELHkS3++s=;
 b=jDuxNPWfO203k4aV+i6+eLCl88jMWU5dFfQJNhWqq1ODmp79UjYn3iNG
 LWUiGGQeU+K50wLIYHD8+/t52D0AUD2rtHexTMrFbvL14zWjwQhD8QCsq
 VKpoeZG+H21XmLRz+bk3WZk2MX40QavibQoTxSakhsF7Yy7k+DCby7kpA
 Kv9GAz/e7pQCh3Mo2nLjmtabdeAV7q668rlldbQMV4qDs+KCNAWCKxlzX
 +QDIKN6RUNfJDHeZgrhZAuU9pUvhvSiGIlcV8wZ6HKnIVo2eKAaWAuBCa
 IQvccAq9fYD2LpddT16itdW3odn6fR6Qn51tFVepjm/ABAN7X/tGGbGy+ w==;
X-CSE-ConnectionGUID: C6CAmCBCRL2GjI8dGNxcvQ==
X-CSE-MsgGUID: xQi8+ORMSni1dhHGFjZr6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85392222"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="85392222"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 09:00:15 -0700
X-CSE-ConnectionGUID: Cy9bI4TySqyAuqWQXHXGmw==
X-CSE-MsgGUID: IKH/QChjTmqxM1Lvsp/JUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="281409534"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.245.212])
 ([10.245.245.212])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 09:00:09 -0700
Message-ID: <b35fcd55-ac18-48b7-8b72-98cf5aae7afa@intel.com>
Date: Wed, 22 Jul 2026 17:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tests/gpu_buddy: fix interleaving in buffer clearance
 test
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260722061718.629966-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260722061718.629966-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 22/07/2026 07:17, Arunpravin Paneer Selvam wrote:
> The resume clearance test skipped every other allocation, expecting an
> interleaved clear/dirty layout. But the buddy allocator hands out blocks
> contiguously, so this just allocated half the pages in one chunk and never
> exercised gpu_buddy_reset_clear()'s force-merge of opposite-state buddies.
> Allocate all pages into two lists instead and free one cleared, one dirty,
> to build a truly interleaved pattern.
> 
> Fixes: e3335ccbf4da ("drm/tests/gpu_buddy: add a new test case for buffer clearance during resume")
> Closes: https://sashiko.dev/#/patchset/20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com?part=1
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>
