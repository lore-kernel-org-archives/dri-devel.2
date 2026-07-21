Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E396C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D102B10E2AE;
	Tue, 21 Jul 2026 06:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="coLxwpF8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD6510E1F7;
 Tue, 21 Jul 2026 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784613785; x=1816149785;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oUiLEZWxz0krgAJtw0tElQ84P0GVfJgHVML4fwWkZp4=;
 b=coLxwpF8zaPbEwVQt2Z+IELe63tFJ20DtTdpSLSJjllOQypNpi/6QIQK
 38/UdT5QOyI6k7hTbMFJnmsyZRuklR74AaGtSzHNLjfVKqUCAgalqWy4T
 Sh5L59qLIPgNprs8tsm3nra0fbG/9EbbJiqdfmjl3csaG7xPzEEZ4qQ6q
 FXix6tqx2r1ipeXuBgPrIT0vtLQ91AWdOA5iDPc+NwwFWBMUVigxDhRYt
 W72ktn9OR3KP82Q/xz2rr2w5T9t2muEVpnA5DOXmaMi7mJHeiJ3F3N1Gj
 fx5aAu9jxZoGCiMmGlkeuEASSZd8rR7nU32Y3IWSO9dTSz8H4An/Qx3dZ A==;
X-CSE-ConnectionGUID: a3hpxaG4Qxugigeenv2ChQ==
X-CSE-MsgGUID: 5B3Iw4FRQG+3uJluuRrhJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85147415"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85147415"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 23:03:05 -0700
X-CSE-ConnectionGUID: S3iE7oTOS56QFS9mPBh+pw==
X-CSE-MsgGUID: 0b2SClBgTuWTePuS3ULHhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="257722919"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 23:03:00 -0700
Date: Tue, 21 Jul 2026 08:02:56 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v5 1/3] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <al8LkE_elgQCxcXk@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-6-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082208.2648279-6-riana.tauro@intel.com>
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

On Mon, Jul 20, 2026 at 01:52:10PM +0530, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-report' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
> 
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-report' to receive 'error-event'
> notifications.

...

> v4: send event to all network namespaces (Sashiko)
>     remove has_listeners check

Curious, is it possible to have a has_listeners() that covers all
namespaces?

Raag
