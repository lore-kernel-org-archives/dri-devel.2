Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140FCD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D9110EB51;
	Wed,  1 Apr 2026 11:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VYkqpHNP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08F910EB44;
 Wed,  1 Apr 2026 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775042632; x=1806578632;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=W+T33+IRm7vdKPwhoCLSI6f9zBvxdvjCKpEdk2NZB2A=;
 b=VYkqpHNPMQhsKf5oy9q7o1PGMRYw4vPmr1r9fR/FimGipxAfRg84LQD+
 7SSp7V3zsRYN11y7ajwyOQC+LopPd0WjVlLIpYQynFbsKWN1BddbHNFRE
 6VRdDv2a/MsX+7mFwoVDsaE6pvIkrnQZIVy5KDUDOE3MdunT1Bb9EzpwO
 BvDlI0AsWkijObThsGCFH1ChGQFOjJzJddVS3QsnDRJhHemmx/EgzAHM4
 Ff/n/iFjsp2NT9Zo43G5Z7SEuIptrPkCTMUKQ8ZFlZIuvhIroMWP32MJe
 76BLQr3os3BkGw88/vGTeS55Xmv2c8gb11O1BsqToSkR6h56cT5KYChtT A==;
X-CSE-ConnectionGUID: tzZTHggtTB+O6MyyNMgBaA==
X-CSE-MsgGUID: R0IBGkmTT8eUQRn1N6EabQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86380173"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="86380173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 04:23:52 -0700
X-CSE-ConnectionGUID: 7GQYh0CHQuandRJdHV3cPQ==
X-CSE-MsgGUID: X8kU+saVRKKmFcyLIIbD0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="226512302"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.199])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 04:23:50 -0700
Date: Wed, 1 Apr 2026 14:23:47 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jerome Tollet <jerome.tollet@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 ankit.k.nautiyal@intel.com
Subject: Re: [RESEND] drm/i915/hdmi: Poll for 200 msec for
 TMDS_Scrambler_Status
Message-ID: <ac0AQ_74Tukshr__@intel.com>
References: <20260113143107.1446909-1-ankit.k.nautiyal@intel.com>
 <20260326054112.51287-1-jtollet@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326054112.51287-1-jtollet@cisco.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Thu, Mar 26, 2026 at 06:41:12AM +0100, Jerome Tollet wrote:
> From: Jerome Tollet <jerome.tollet@gmail.com>
> 
> Hi Ankit, Ville,
> 
> Following up on this patch.
> 
> As previously reported, the SCDC polling approach fixes the 4K@60Hz HDMI
> issue on my Alder Lake-N (N100) + Cisco Desk Pro setup, and I have not
> seen regressions in testing.
> 
> Ville, do you see any remaining concern with this approach, or is there
> anything else you would like me to test to help move this forward?

My main concern is having the synchronous polling appear to fix
something now, and if we later make it asynchronous the original
problem may re-appear.

That said, after perusing the spec a bit, it looks to me that sinks
should be able sync up after at most two video fields. I suppose
having effectively two extra vblank waits in a full modeset sequence
isn't the end of world. The extra complexity of asynchronous polling
might not even be worth the hassle.

But the commit message should still highlight that (AFAICS) synchronous
polling is not required by the spec, and thus the fact that this fixes
some monitors is sort of an accidental byproduct.

-- 
Ville Syrjälä
Intel
