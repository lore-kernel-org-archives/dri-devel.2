Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF09CDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD9210EBB3;
	Tue, 23 Jun 2026 14:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="byARnB9i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4950A10EBB3;
 Tue, 23 Jun 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782226725; x=1813762725;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WiANHJqy7C9nAbf9+8IkS3SwkNgIILh9FcPzXJ3mOaQ=;
 b=byARnB9ifumjlI92HaZYigKcpTIqNz7oyM4f6+vEcZkLh94ydnyWzeOq
 u/DbQByHl1yFi10f9Gt4NXeK9Frur9VT0MzAMT/Yfz110UiFlOS7CeG7D
 Nhx2nNJ4v77qDpJxzDCiRtoZzBc+K5r+KJVmUrXSrxSGFFUZUFrS9VSxY
 ojhRRdO/nJN2NG3QD/4QckY3fr+vZGycVDNFSiQb5TxJX00RaZIVoWo4H
 ZNhAFK/2aPizr3lyYbwPzjP4UE3enMNl2vJltyKyalgHtkp1NhHu64Z/n
 /UY3eriyij76NJ3Rfk4Bj8YhpxuvTB7FkvA7LdVV/4hLAG5+SGJ4ONyjq w==;
X-CSE-ConnectionGUID: o+tpL3buQHqiovo9auqlIg==
X-CSE-MsgGUID: QG0RI0LjRnCfZxZ2YCyBtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83013020"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="83013020"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:58:45 -0700
X-CSE-ConnectionGUID: vfQPwAw4SQ2L/E7gp7BeCA==
X-CSE-MsgGUID: NU78riF4SE6yDCuVAFooig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253899854"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:58:42 -0700
Date: Tue, 23 Jun 2026 16:58:39 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/xe/mcu_i2c: Take over control of the
 controller enabling
Message-ID: <ajqfH5j58Z8L_XJN@black.igk.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
 <ajpmdQjArQkhQ8fl@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajpmdQjArQkhQ8fl@ashevche-desk.local>
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

On Tue, Jun 23, 2026 at 01:56:53PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:
> > Some platforms make an assumption that the i2c controller's
> > enabled state indicates also the power state of the
> > controller. This can create a problem when the controller is
> > in disabled state, because the hardware may assume
> > incorrectly that it is then also in low-power state.
> > 
> > To fix this, the controller is kept enabled by taking over
> > the IC_ENABLE register. The controller has to be disabled
> > when the configuration is updated and when the target
> > address or the slave address are assigned, so disabling it
> > when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> > then re-enabling it again.
> 
> ...
> 
> > +#define IC_CON				0x00
> > +#define IC_TAR				0x04
> > +#define IC_SAR				0x08
> > +#define IC_ENABLE			0x6c
> > +#define IC_ENABLE_STATUS		0x9c
> 
> Heh, I would like to have a shared header with the registers, but dunno
> if the prons will weight out the cons.

Perhaps something like i2c-algo-pca.h?

Raag
