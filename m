Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B585C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B89F10E3B2;
	Tue, 21 Jul 2026 17:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OT5ka03H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9314610EACC;
 Tue, 21 Jul 2026 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784653699; x=1816189699;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mVMWIWJnrBJufKkviFN2SwdHevpvpeFyKIUvsgpQLgU=;
 b=OT5ka03Hj4FpbByDGX+i+ohQC8nN0IQqqYCw1TXhz+HLx+oY/wLJ0CTi
 NyNY5nUqYetr1xYUTD0e4lfas3ow3rQqPVLdrT38zW5vnVV2/e+hT1gky
 5l0QA4Tb09PF3dNHbGlbwmrGt4NgZCrWawSbfUbIVSMT9XnyXMHIjE2Fz
 nBoqHEdhoK8uDPhO5r52vdZjRCMtKLH3ELBFLWeRPpJtx1A8x/BghQm2z
 2BBtWdNFHcBcjcdzYs6zbehTQVulXcFp2pcZOvoNMZHHbpA/KWEAhuvSB
 yTo/sYvQ8jPCooeQYDIZjd4Hp5FdyukbV0GVP3DpPRGG4ftxVF+D/5Xho w==;
X-CSE-ConnectionGUID: jA+3+WlcSV6ASHsgwiFwkA==
X-CSE-MsgGUID: Pr6AoOrTTEqgu97em4r4+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="108052100"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="108052100"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:08:19 -0700
X-CSE-ConnectionGUID: uZ/sfGZES5yTsDELOKMzAw==
X-CSE-MsgGUID: H9ufHB3dR5qdCLemR5XmcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="261382897"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:08:14 -0700
Date: Tue, 21 Jul 2026 19:08:11 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com, Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events to
 userspace
Message-ID: <al-neyeoG873l1xX@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
 <al8v2STXTiMhp5C5@black.igk.intel.com>
 <0e842368-3bbf-436e-839d-cc7fec29b0cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e842368-3bbf-436e-839d-cc7fec29b0cb@intel.com>
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

On Tue, Jul 21, 2026 at 06:52:51PM +0530, Tauro, Riana wrote:
> On 21-07-2026 14:07, Raag Jadav wrote:
> > On Mon, Jul 20, 2026 at 01:52:11PM +0530, Riana Tauro wrote:
> > > When an interrupt is received indicating that error counter has crossed
> > > its threshold, read the current counter value and deliver a drm_ras error
> > > event to userspace for each affected component.
> > > 
> > > To avoid sending duplicate events when the same component appears multiple
> > > times in the response. Send the error-event once per component.
> > ...
> > 
> > > +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
> > > +{
> > > +	struct xe_drm_ras *ras = &xe->ras;
> > > +	struct xe_drm_ras_counter *info;
> > > +	struct drm_ras_node *node;
> > > +	int ret;
> > > +
> > > +	/* Event is supported only if drm_ras is enabled */
> > > +	if (!xe->info.has_drm_ras)
> > > +		return;
> > > +
> > > +	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {
> > IIUC this is error_id and should be validated against first/last counter
> > range in drm_ras layer (similar to registration code).
> 
> This should be done before because we are accessing the nodes here.
> The nodes anyway won't be available in xe_drm_ras if not registered with
> drm_ras.

Yes. We get the node from severity which we already validate here, but
error_counter_range is the property of the node and unrelated to xe.
Even if you prefer it here, these checks must be in core functions to
make sure they are not abused.

> > > +		drm_warn(&xe->drm, "unsupported component %u\n", component);
> > > +		return;
> > > +	}
> > > +
> > > +	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
> > > +		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
> > > +		return;
> > > +	}
> > > +
> > > +	node = &ras->node[severity];
> > > +	info = ras->info[severity];
> > > +
> > > +	if (!info || !info[component].name)
> > > +		return;
> > > +
> > > +	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
> > > +	if (ret)
> > > +		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
> > > +				    info[component].name, error_severity[severity]);
> > > +}
> > ...
> > 
> > > +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> > > +{
> > > +	struct xe_ras_error_class counter = {0};
> > > +	u8 drm_severity, drm_component;
> > > +	u32 value;
> > > +	int ret;
> > > +
> > > +	counter.common.severity = severity;
> > > +	counter.common.component = component;
> > > +
> > > +	ret = get_counter(xe, &counter, &value);
> > > +	if (ret)
> > > +		return;
> > > +
> > > +	drm_severity = xe_to_drm_ras_severity(severity);
> > > +	drm_component = xe_to_drm_ras_component(component);
> > > +
> > > +	xe_drm_ras_event(xe, drm_component, drm_severity, value);
> > > +}
> > This entire function can be dropped. See below.
> 
> We don't need to drop function. It's cleaner to have it in the function
> than repeating it twice.

I thought we'd lay the groundwork for cper which'll also need get_counter()
in the same path, but upto you.

Raag
