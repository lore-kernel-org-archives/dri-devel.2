Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7D9608B7DC
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ksEBhQVW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A319610F044;
	Mon,  2 Nov 2026 15:38:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595A210F01F;
 Mon,  2 Nov 2026 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633919; x=1825169919;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hTYZdetg0DVplDyNYLvgAVyDM9iUmyOuE+J0YYj/dX8=;
 b=ksEBhQVWNbsR7b9vEN+hN45do7VgzKMrSRXYa7Of1orTGCDgmB6eG5yZ
 SLtThOzrDI/Vg9CSKWDTDIZdh64S440Wqm4iZjr9AY8WfEaf7IcjatPY9
 UU+QgYaxRCkbAuAp4WT6vNh4BqHIFd8o4VQuc1PYI3SREh8obsvBAVSx6
 qOsIJaV+bwFwztIVIq7yZ3s/FdJG2K+RVyQM1UxtFgZVfF0u/Sk11euuv
 Y5nQpy+TC+ak/9D1yuAy451ymYdW5MFry2Is1Q10vcLhp46klejpmb2QG
 agHgMvL65GBr9di2xs/TPtDWMljHwwdzIPjJHDSz/QWx735ktqjduNnSE g==;
X-CSE-ConnectionGUID: iC1UHrW5RP6wuWr5COp9ug==
X-CSE-MsgGUID: iujZY7DvRpWwy1X6ver9dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2235193"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2235193"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:38:39 -0800
X-CSE-ConnectionGUID: k6ktoBSPQW+rVY+t7HSheA==
X-CSE-MsgGUID: 82Q0zRELTwesE46+ATslGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6249005"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.10])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:38:36 -0800
Date: Mon, 2 Nov 2026 17:38:32 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hugo Sales <hugo@hsal.es>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/probe-helper: Sort and set crtcinfo before dropping
 the modeset locks
Message-ID: <auiuePf6RbhdV65A@intel.com>
References: <20261031161952.660049-1-hugo@hsal.es> <auh8pUx_kXUYSdZ8@intel.com>
 <2112993263.278931.1793633202457@app.mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2112993263.278931.1793633202457@app.mailbox.org>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 03:26:42PM +0000, Hugo Sales wrote:
> On 11/02/2026 12:05 PM WET Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Sat, Oct 31, 2026 at 04:19:52PM +0000, Hugo Sales wrote:
> > > amdgpu walks connector->modes from its atomic_check, in
> >
> > That is just wrong. connector->modes is protected by mode_config.mutex
> 
> You're right, I should have fixed the real issue rather than work around
> it. Please drop this one
> 
> I'll try to fix it in amdgpu instead. atomic_check can't take
> mode_config.mutex there, so amdgpu would pick the mode it needs while
> probing and keep its own copy, like it already does for freesync_vid_base

Yeah, that should be doable.

> 
> > And regardless of changing the locking rules or not, someone
> > should probably sprinkle lockdep asserts to bunch of places
> > where connector->modes is consulted. Perhaps even introduce
> > custom list iterator macros that include the assert...
> 
> Makes sense. amdgpu would trip them today, so I'll look at that once
> the amdgpu side is fixed

Sounds good.

-- 
Ville Syrjälä
Intel
