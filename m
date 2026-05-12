Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE84CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC90510E2A4;
	Tue, 12 May 2026 16:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CagINQ09";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0233610E2A4;
 Tue, 12 May 2026 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778604731; x=1810140731;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uMkUDHv26fadIJfwxhlXn+Q0B6/mz2BnhUKt8UxkY80=;
 b=CagINQ09P3J75S/Q5adv8Lhk1wluhwpLb57T7AxH0Gav2msIBiI7k8VX
 hNzEuD4I6Tdi2WVBIwjKAWcuv7GeiHj0NgvMFL8cix7cVyNuTX3ptNnft
 A9+uQR6wMJxcY4/kWB7BOeN9U6W+ssCeav5SsvA4RbYA+IAvvTkOAx2gI
 ry1IFh7B1pGSpZkOtN4EB4AjdC4u5RdOepeWas/UptJPQTPi9qHEOdgN4
 Xx3z+fOiRtruWwsJMrFJw7Qiq0veRrrs9gFRlUVZaf2p5dAFpEdKX3xxt
 iv3QcGFnUBjUZ+kuDnomDWnT6oq6b+e0RJZfYUIzTjRHaNPIqeKIAAOcA w==;
X-CSE-ConnectionGUID: fY/hg2SDQEOljE+O8eqDbA==
X-CSE-MsgGUID: tMgQ6gBxQ+aXtiR0dEefoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83392662"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="83392662"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 09:52:11 -0700
X-CSE-ConnectionGUID: mdXamUsESZybcZORmnVW8A==
X-CSE-MsgGUID: 7WKw3oElQ361cW01f6HeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237911691"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 09:52:06 -0700
Date: Tue, 12 May 2026 18:52:03 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 maarten@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
 rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v1 09/11] drm/xe/ras: Set error threshold support
Message-ID: <agNasxWroK70Z_Jg@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-10-raag.jadav@intel.com>
 <5e90b9aa-9432-43b5-ae40-1fce383bb043@intel.com>
 <agM8ynv2w-iqsp-O@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agM8ynv2w-iqsp-O@black.igk.intel.com>
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

On Tue, May 12, 2026 at 04:44:34PM +0200, Raag Jadav wrote:
> On Mon, May 11, 2026 at 10:51:38PM +0530, Tauro, Riana wrote:
> > On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > > System controller allows programming per error threshold value, which
> > > it uses to raise error events to the driver. Set it using mailbox
> > > command so that it can be programmed by the user.

...

> > > +	if (response.status) {
> > > +		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);
> > 
> > Status should be converted to visible error codes. check [PATCH v5 3/6]
> > drm/xe/xe_ras: Add helper to clear error counter - Riana Tauro
> > 
> > <https://lore.kernel.org/intel-xe/20260504065614.3832331-11-riana.tauro@intel.com/>
> 
> Coming right up.

So I went through this and I'm wondering if these would be applicable
for non-RAS mailbox users as well? In that case should they be part
of sysctrl code?

Raag
