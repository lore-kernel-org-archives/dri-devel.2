Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DA4C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5250810EC03;
	Tue, 30 Jun 2026 10:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QRFcPyo2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C67B010EC03;
 Tue, 30 Jun 2026 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782815520; x=1814351520;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n5RmZML6jZpT6mwNmTpxqpwLQ+nq/gtRG8PxO6ONRFM=;
 b=QRFcPyo2bA1q7KuABPtkWyxpoS/YGh/oaYbM3TjxGxzyNw34q7snqilV
 mfkYVEViCZ0Rbr1Pf2HrXebubh6+EB/UAvZhhoEw7kw/M2pYt6u7pR66s
 R4YqeectzZ5X6Ypu+Z3emChlHQfMVETvDBnuRibE+iHzOzsO3M/fhjHYM
 LaVn8o+Ue321BBbTTFAZZeyAPk5Na0BzODV1jRdz/+sfL7/8rmxiwUEAK
 VPIULPvS+utTiGU0RGy20dsW++zzHaagQAFQn1Zm1y4NT0UhKGE52VjQo
 oI0LGZLsNPZDIbmmcgQwXjjzHWWPeBkXIGDDa4QAZ5GvEcA+Pglgxia0E Q==;
X-CSE-ConnectionGUID: HA17fQytQ3CExLzzT/oifg==
X-CSE-MsgGUID: LU7/gBk2RS63yQQ25xqEMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87208139"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="87208139"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:31:59 -0700
X-CSE-ConnectionGUID: mIucPr7VTzuk/h1NiBv9ow==
X-CSE-MsgGUID: avvhI5fATEi4KaE3ZbQD9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="248863754"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP; 30 Jun 2026 03:31:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 8710295; Tue, 30 Jun 2026 12:31:55 +0200 (CEST)
Date: Tue, 30 Jun 2026 13:31:54 +0300
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
 Andi Shyti <andi.shyti@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <akObGsb18YXWItGs@kuha>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
 <akOaOD_sHI3exlXL@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akOaOD_sHI3exlXL@black.igk.intel.com>
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

On Tue, Jun 30, 2026 at 12:28:08PM +0200, Raag Jadav wrote:
> On Thu, Jun 25, 2026 at 02:59:38PM +0200, Heikki Krogerus wrote:
> > Some devices that are attached to the I2C controller use the
> > SMBus Alert signal for example to inform the host about
> > thermal events, so registering the default SMBus Alert
> > device for them. The alert device makes sure that the alert
> > is processed and passed to the correct I2C client driver.
> 
> ...
> 
> > +enum XE_I2C_CLIENT {
> > +	XE_I2C_CLIENT_AMC,
> > +	XE_I2C_CLIENT_ALERT,
> 
> Forgot to add, with this I think you can move XE_I2C_MAX_CLIENTS define
> here.

Ah, makes sense. I'll fix that.

Thanks!

-- 
heikki
