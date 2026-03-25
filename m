Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E775F106B522
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F5810E235;
	Wed, 25 Mar 2026 12:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EggFjcCX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEB510E1F4;
 Wed, 25 Mar 2026 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774442417; x=1805978417;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0ykjiUAp1iGLjedC402sZIXIRZSWQPp4VGFsoOIHYGQ=;
 b=EggFjcCXgLo8FxlUK2p1QoHCe7++7L6ugiBI8ATXvBSwXd3Rmny+KgWJ
 scfjd0lUn/BLVGoeP4J1gpGsTGYxQ6S/oElnRSLS/c0dUyU/NaKX3sS9f
 YyNSR5fCYvGRc3k4mtJxkg4HhGNH18OJlEJhRV9cwa44d7XOymetOD4Wh
 NOwX2IIlaXmY7y4GbnzQXTwp9nnU0zQl57jv+LqvR0uWLJYGhveT3pyjl
 LPfIx3w79K5m/FOT8bhTCnrAt0r0w8xbbmreublpdNiFPcAPRpFLcHa5F
 aBlJy0bAA9DvVLENTSwJyFizh/qrvYWBc+q5+Rr1Jkplz52WwGbrCuwcj g==;
X-CSE-ConnectionGUID: DjKcFXKHRSCrC60U847h7A==
X-CSE-MsgGUID: PomPbq8zSQuJMkn/dzQOhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86088710"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="86088710"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:40:17 -0700
X-CSE-ConnectionGUID: NpVP2QpCQ/aAk7BMZuwJiA==
X-CSE-MsgGUID: WxcnrAMbQZ2f6cr9KP47OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="229125935"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:40:11 -0700
Date: Wed, 25 Mar 2026 13:40:08 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
 Jakub Kicinski <kuba@kernel.org>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 1/4] drm/drm_ras: Add clear-error-counter netlink command
 to drm_ras
Message-ID: <acPXqL030Syciz1b@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-7-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311102913.3387468-7-riana.tauro@intel.com>
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

On Wed, Mar 11, 2026 at 03:59:15PM +0530, Riana Tauro wrote:
> Introduce a new 'clear-error-counter' DRM RAS command to reset the counter
> value for a specific error counter of a given node.
> 
> The command is a 'do' netlink request with 'node-id' and 'error-id'
> as parameters with no additional response payload.
> 
> Usage

Missing ":"

> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
> '{"node-id":1, "error-id":1}'
> None
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
