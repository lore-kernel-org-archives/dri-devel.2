Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885B2CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2EB10EA6E;
	Tue, 23 Jun 2026 10:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JCbbUVAC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9387210EA7C;
 Tue, 23 Jun 2026 10:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782209745; x=1813745745;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vhwRlaHfCUw5+P27ffYkoK22J+Bfg1u7ICXMTgzUUzE=;
 b=JCbbUVACXkHRWkCaDMSv0jC/8//idZhaD/xHG9nB36QmsrUo/P/aydV3
 /q1aCdHVcEHhRFaikv4ovD+HtXc1qhrbDrguQx+Dni0TaM9K3lQp1D0Ft
 BQjNSVh8CEszcytInRV7v8QKIUJ7YFqDtNhFEp97L/npqNzzRWHk8A2ep
 Nh3kNjXMVZC9nqA6cdihZepu/9DL9W6K2jL+FsjggCw32bbCssHg9vC2S
 Gn7AC+F9dFwS5jvw5eeXfNKxCzvOyGy27CUGWwOvCuUWMtgLxk3+Jz/rt
 9U7g00NWblVIwKiVlaapQ/C6053UGuc7DNENGJjtHuIHwm5r9wPSN/dd9 g==;
X-CSE-ConnectionGUID: TKeMAHweR0qRUuhNfWfxWQ==
X-CSE-MsgGUID: Xo8IQUIkQseCSLlXVVjL4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82817958"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82817958"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:15:44 -0700
X-CSE-ConnectionGUID: +lTD6a5QRh61rwNw/QSWkg==
X-CSE-MsgGUID: 070HlsbHQsminhHLuVg+Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253359490"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP; 23 Jun 2026 03:15:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 6A8D095; Tue, 23 Jun 2026 12:15:39 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:15:37 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] drm/xe/i2c: alerts and controller enabling
 modifications
Message-ID: <ajpcyS3s6hArVQy8@kuha>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
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

Hi Raag,

I completely forgot the enum for the clients that you proposed
off-list. Sorry about that. I'll add it in v2.

On Mon, Jun 22, 2026 at 01:47:57PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> This includes support for the SMBus alerts, and special handling for the
> IC_ENABLE register.
> 
> Thanks,
> 
> Heikki Krogerus (2):
>   drm/xe/i2c: Handler for SMBus Alerts
>   drm/xe/mcu_i2c: Take over control of the controller enabling
> 
>  drivers/gpu/drm/xe/Makefile       |  1 +
>  drivers/gpu/drm/xe/xe_i2c.c       | 86 ++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_i2c.h       | 16 ++++++
>  drivers/gpu/drm/xe/xe_i2c_smbus.c | 59 +++++++++++++++++++++
>  4 files changed, 154 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_i2c_smbus.c

thanks,

-- 
heikki
