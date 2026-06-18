Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63036CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 18:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1DD10F3AE;
	Thu, 18 Jun 2026 18:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OrdosJIR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F8110EE80;
 Thu, 18 Jun 2026 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781807970; x=1813343970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5E4fOFYYdjiA1aUmrlQPzU6/9fVBnDOSMta32mX78Dk=;
 b=OrdosJIR1GTPy5PbLrHIGhtgw7pmfIO/ds4roiRbe5wPMb/vUH9Xv6Wy
 6Qp07D+8TUFsCClJsB68gQ/t1yB7mXBUOSxw2g2J7zz0azZYND9ypjpxs
 9gnOfXB817PDmu5UEpu7Bc92FK3CzcuVAGczsw08cXKONB592qnbtksJc
 tBRxFoshxfRhF49E0g0RD90+7U6sBv6imtSOijfx6S/YVgX2KUF2vbdzv
 ZefrdVR4sEMp2lKx4vIa52m/4St5CQSW4865FxBCJYEaqtTibcfNmW2JD
 S1zjXWFjdhCAbuOhkjdhDJ7Wi21gHoK6wPHB8CaI9PqA3+o/e+m+IaPLv Q==;
X-CSE-ConnectionGUID: uChiT3/dSwGdAT05kWbm9Q==
X-CSE-MsgGUID: RYggJqfYSVmlevjejg0NuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82527388"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; d="scan'208";a="82527388"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 11:39:29 -0700
X-CSE-ConnectionGUID: +F8wzZwUTQuyPP2GgpY+rQ==
X-CSE-MsgGUID: l+JEMbVxRBWUY1K0ilsxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; d="scan'208";a="247563562"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.79])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 11:39:27 -0700
Date: Thu, 18 Jun 2026 21:39:23 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh
 rate changes on eDP
Message-ID: <ajQ7W44qv28-i6Pq@intel.com>
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
 <3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org>
 <31da350f-adfc-4b2c-a7c5-5ed884ffd9ca@mailbox.org>
 <ai_40qUa-MVdbOEf@intel.com>
 <18f0c14b-f973-4e1a-948b-5274cc36895c@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18f0c14b-f973-4e1a-948b-5274cc36895c@mailbox.org>
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

On Tue, Jun 16, 2026 at 09:21:01AM +0200, Michel Dänzer wrote:
> On 6/15/26 15:06, Ville Syrjälä wrote:
> > 
> > What we're doing here is selecting the actual timings to drive an internal laptop 
> > panel, given some random cooked up modeline from userspace.
> 
> How can user space know what cooked-up modes it can (not) expect to work with this?

Without VRR support it can only expect modes that have the same refresh
rate as one of the modes on the connector's mode list to work. With VRR
support anything within the VRR range should generally work. That's
assuming other parameters (eg. scaling) are acceptable of course.

> 
> 
> > We pick the actual mode from the set of "fixed modes" (ie. the modes
> > that the panel/system itself has reported as supported via
> > EDID/VBT/ACPI/etc.). For non-VRR panels we just pick the fixed mode
> > whose refresh rate is closest to the user specified mode, and reject
> > the commit if it's not close enough (<= 1 Hz).
> 
> Can't programming different mode timings result in the panel blanking intermittently?

Userspace can specify that a modeset is not allowed, thus if the
driver can't achieve the refresh rate change without blinks the
commit will be rejected.

-- 
Ville Syrjälä
Intel
