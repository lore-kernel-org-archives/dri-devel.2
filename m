Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F242EC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C948920D;
	Fri, 17 Jul 2026 06:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ItmessVj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AEC8920D;
 Fri, 17 Jul 2026 06:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784270453; x=1815806453;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=vulebB9C8nuEp8cKObMoDXnbn4yRAgWEntVwrmSpMRM=;
 b=ItmessVjYRS9wprEw73U63CSS2O4vz98fRyI7sPkGaP4Fm5vAi1sMGJu
 Mmz80kUqem91eTNBMBoNRKq0wCiCaEU+l3PdCFRcGbz2wGT011VPzIOia
 UNUUvzBz3g/t5hO5z01sm3kqjTlljI1cOW0VMQn+cuJhROep/Rxic3Ynz
 NXaGOL1gTRapvy9c+DHo5v66ezrrFXRy58RnPx6z3cbQV7ABGgzA2aSfE
 g/CxGnAKq1mCx2w+6GoI0imI6ZSNJylVi4MQzfXkB61erDit+Cane313Y
 YYZpj4ORbCAy68ZZQBukSsNfCS0GAmb/KGWcF7Uxn1LCptec8S4eIc0MU Q==;
X-CSE-ConnectionGUID: utMZu0QhQ16DDDd38YDX5Q==
X-CSE-MsgGUID: FZ3bZOdeQTuey0ItkznBhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96073424"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="96073424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 23:40:53 -0700
X-CSE-ConnectionGUID: e5E06XyOS2GvPc7NvW7vhQ==
X-CSE-MsgGUID: AEJHUp6ZSnKxRrcRC3FlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="258701243"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 23:40:49 -0700
Date: Fri, 17 Jul 2026 08:40:45 +0200
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
Subject: Re: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
Message-ID: <alnObRca4xNQMgi7@black.igk.intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-8-riana.tauro@intel.com>
 <ak9yEyDF_tlJe-Rx@black.igk.intel.com>
 <918f2fc4-2aec-43a4-b52a-028011aa91b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918f2fc4-2aec-43a4-b52a-028011aa91b4@intel.com>
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

On Thu, Jul 16, 2026 at 03:27:59PM +0530, Tauro, Riana wrote:
> On 09-07-2026 15:34, Raag Jadav wrote:
> > On Wed, Jul 01, 2026 at 03:14:13PM +0530, Riana Tauro wrote:
> > > Add error-event support for Correctable errors in CRI. Report an error
> > > event to userspace for every component that has crossed the threshold on
> > > receiving an interrupt.
> > ...
> > 
> > > +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> > > +{
> > > +	u8 drm_severity, drm_component;
> > > +	u32 value;
> > > +	int ret;
> > > +
> > > +	drm_severity = xe_to_drm_ras_severity(severity);
> > > +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
> > > +		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);
> > This is uapi and not coming from sysctrl, so the message is a bit
> > misleading. But if at all it needs validation, it should be done in
> > drm_ras layer.
> 
> You mean in the ras_event function?  The parameters to this function are
> coming from sysctrl.
> So added sysctrl flag

We shouldn't be at this point without valid severity and component, and
this also contradicts the if condition which is for uapi.

> > > +		return;
> > > +	}
> > > +
> > > +	drm_component = xe_to_drm_ras_component(component);
> > > +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
> > > +		xe_warn(xe, "sysctrl: unexpected component %u\n", component);
> > Ditto.
> > 
> > > +		return;
> > > +	}
> > > +
> > > +	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);
> > No, instead of converting back and forth just do get_counter() using
> > sysctrl values and send_event() afterwards.
> 
> The reason for using this is to avoid unnecessary churn of moving the get
> counter above or use forward declaration.
> Yeah i can use that too directly.

You already get a counter as part of threshold crossed event, which you
can directly pass to get_counter() instead of dealing with severity and
component individually.

Raag
