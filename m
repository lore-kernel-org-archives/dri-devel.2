Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE1AC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C4D10EB51;
	Tue, 30 Jun 2026 08:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dCnbgDJw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94F010EB44;
 Tue, 30 Jun 2026 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782809203; x=1814345203;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fWhGWkg1sVC+Zopw1ah/LLgRFnq+PnpA3zeYqg1SVDo=;
 b=dCnbgDJwOofH0T8PwMO2PNH9xdvxxxwbNo1YJTNmRgv89S1hp+eTbAQ2
 tAKurWWMG5PKl8Iyxc0OPTZ27nDd1ARHuUgE1T789JZ+GwpsBWQA/jKHu
 yA2+OVe08pRVZJgxeoGzEA/rHnbuT6EKCgzV1FnHekbQ2Fw75sj2asIaP
 Q3v3PKT9UHy+TfCVg67LpjyplhkzpOgpR/dDrsFkIlvPEM3EZOcIGAPpp
 lNWIcHIL51+uZwcMKGwweBbjXo8AaPuwK/TWdzzEyRDLAzJbB59psotMC
 9IatrqoE5yXP2dEIPb83T6CB+zl1iuvM4HpTVX1EfOJnOAZmED2tZL0mP A==;
X-CSE-ConnectionGUID: 0h2nS27LSrecIbH3HmeaWA==
X-CSE-MsgGUID: f/ZeF1xkTcCKGEyqfwtN7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83651073"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="83651073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 01:46:42 -0700
X-CSE-ConnectionGUID: +X9lGev+TKiS7ZuuBWMq9Q==
X-CSE-MsgGUID: WjPREsZyTKSgs5LuE5kwEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="251799766"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 01:46:39 -0700
Date: Tue, 30 Jun 2026 10:46:36 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
Subject: Re: [PATCH v2 3/3] drm/xe/mcu_i2c: Take over control of the
 controller enabling
Message-ID: <akOCbMKgTbzbZI7R@black.igk.intel.com>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125939.429078-4-heikki.krogerus@linux.intel.com>
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

On Thu, Jun 25, 2026 at 02:59:39PM +0200, Heikki Krogerus wrote:
> Some platforms make an assumption that the i2c controller's
> enabled state indicates also the power state of the
> controller. This can create a problem when the controller is
> in disabled state, because the hardware may assume
> incorrectly that it is then also in low-power state.
> 
> To fix this, the controller is kept enabled by taking over
> the IC_ENABLE register. The controller has to be disabled
> when the configuration is updated and when the target
> address or the slave address are assigned, so disabling it
> when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> then re-enabling it again.

I don't have enough context here, so I'll leave this one to the
maintainers.

Raag
