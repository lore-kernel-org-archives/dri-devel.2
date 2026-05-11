Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D94CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 09:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DB210E186;
	Mon, 11 May 2026 09:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oKuflpx4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FAC10E06B;
 Mon, 11 May 2026 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778492010; x=1810028010;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Nxn/SJxFgpyHXhNu+xmkiMum9B7+qkLommG6kbe2hTk=;
 b=oKuflpx4ss9kvxOozisGS+qdHjKihtTeMAQQ98MfjttgzHB1OX3GsTSE
 fNdh6o9Hzt92jXx9G76vFmru+oi8XcjXu99jrjn1elnFqtUmdxAiVwuZ0
 /DkRQgC1iDUoQrBV8Q5xqjgSe7tVHGgsUbzVxU888OckM6MmNiJcQT8m2
 tkewwO/TAHCo9ZDztERBEBLT3kp5MEbpj1ZXcD0s1Oe2LuyVIW5dp4YRk
 pf1BL0eDLyViUU/3Rn4dk5iDWfObN9Y2heVj3+oq6mU/rGxVIdrVh0T59
 F++6KXh0HNKove9oKHwSK/6fvgPVLl78Cl0NgcxNZpBXO540IOcFodhl2 w==;
X-CSE-ConnectionGUID: lVDG/9wfTlyrC7+n2SyNGA==
X-CSE-MsgGUID: J8kTdF3vTayfqiY59xJAZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90751103"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="90751103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:33:29 -0700
X-CSE-ConnectionGUID: zwhdx/fdQZSUhe4FLlBejw==
X-CSE-MsgGUID: SYQIv4xNSNWmwSjhhkCBJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="241376626"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.253])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:33:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Aaron Esau <aaron1esau@gmail.com>, intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, mika.kahola@intel.com, stable@vger.kernel.org, Aaron
 Esau <aaron1esau@gmail.com>, Marco Nenciarini <mnencia@kcore.it>, Imre
 Deak <imre.deak@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 0/3] drm/i915/cx0: fix PLL enable failure handling on
 Meteor Lake
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260509162407.510539-1-aaron1esau@gmail.com>
Date: Mon, 11 May 2026 12:33:21 +0300
Message-ID: <cdf591ba648d7b3d6a4ae5fead14f5faa92e52ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, 09 May 2026, Aaron Esau <aaron1esau@gmail.com> wrote:
> On Meteor Lake with a hybrid Intel/NVIDIA GPU setup, s2idle resume can
> leave the CX0 PHY MSGBUS unresponsive. When this happens, the PLL
> enable sequence silently fails: register writes via MSGBUS are dropped,
> the PLL never locks, but the driver marks it as enabled and proceeds to
> drive the pipe.
>
> The root cause of the MSGBUS becoming unresponsive appears to be the
> NVIDIA dGPU not participating in S0ix (addressed via the
> NVreg_EnableS0ixPowerManagement module parameter). However, the i915
> driver should handle PLL enable failures gracefully regardless of the
> trigger.

The way I read this is: There's an issue with an out-of-tree proprietary
driver, you can only reproduce the issue with said proprietary driver,
and the upstream driver should jump through hoops to workaround the
issue in the proprietary driver, in ways that we won't be able to test
in our CI. And the expectation to work around this upstream is because
you can't really do anything about the proprietary driver.

Is that about right?

Apart from adding a bunch of generic error handling code superficially
unrelated to the proprietary driver.

The reason the CRTC enable path generally doesn't have error propagation
is that 1) the allowed errors on atomic commit are *very* limited, 2)
nonblocking commits are even more limited, and 3) even on failures the
display pipe must be running.

You simply can't bail out in the middle of hsw_crtc_enable() like
suggested in patch 2.

See [1] for more. Also see parts about tainted kernels in [2].


BR,
Jani.


[1] https://docs.kernel.org/gpu/drm-kms.html#c.drm_mode_config_funcs
[2] https://docs.kernel.org/admin-guide/reporting-issues.html


>
> This series:
>   1. Fixes intel_cx0_pll_is_enabled() to check the hardware ACK bit,
>      not just the driver-set REQUEST bit, so a PLL that failed to lock
>      is correctly reported as disabled.
>   2. Adds error propagation through the DPLL enable path: changes the
>      .enable callback to return int, threads errors through
>      _intel_enable_shared_dpll() and intel_dpll_enable(), and checks
>      the result in hsw_crtc_enable() and ilk_pch_enable().
>   3. Makes the CX0 PLL enable path return -ETIMEDOUT when the PHY
>      fails to come out of reset or the PLL fails to lock.
>
> Found on a Lenovo ThinkPad with Intel Ultra 7 155H and NVIDIA RTX 2000
> Ada. Kernel traces before each crash:
>
>   i915: Failed to bring PHY A to idle.
>   i915: PHY A Read 0c70 failed after 3 retries.
>   i915: Timeout waiting for DDI BUF A to get active
>   i915: [CRTC:149:pipe A] flip_done timed out
>
> Aaron Esau (3):
>   drm/i915/cx0: check PLL ACK bit in intel_cx0_pll_is_enabled()
>   drm/i915/dpll: add error propagation to DPLL enable path
>   drm/i915/cx0: return errors from CX0 PLL enable on failure
>
>  drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 54 ++++++++----
>  drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +-
>  drivers/gpu/drm/i915/display/intel_display.c  | 10 ++-
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 87 ++++++++++++++-----
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.h |  2 +-
>  .../gpu/drm/i915/display/intel_pch_display.c  |  7 +-
>  6 files changed, 117 insertions(+), 49 deletions(-)

-- 
Jani Nikula, Intel
