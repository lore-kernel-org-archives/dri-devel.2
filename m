Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF8FCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C088710F603;
	Wed,  7 Oct 2026 14:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Kyx7sf5b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD83910E5C1;
 Wed,  7 Oct 2026 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791382251; x=1822918251;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=B/z1/b5cd4l4WqPSJtZIHJTSirnhnuOeNRlR2O0vABY=;
 b=Kyx7sf5b9RhBDdM/IbA/gND6UP+jVSUSYuCX+OLuP2NCNAR/PGCirwDZ
 sATjDwrePbvwmKmKARgWRPSO9SqTTuMllrKoB4DAdugkp96O0RlDEjt4U
 lMgCsYRNrnv2MU/tMw9UD+aKbGlnt/a6P+RVydCUHM/JIYU7BdWzdHqtf
 687++5gnbJ5UVVfhmJX2xsvA3r7upUBi4ARt5Y4xxWil+W4Nu8iclH8fb
 9tWTCJlDFLOmjoYxZZfI4WtCsJTEu44StkTp7xz6mthDagKF+azQlfhQy
 tFXmpCOJBIGkU6UX071nhPTJg2+S3kypnS99t9GsgFJqjo7E0KNNVpio8 w==;
X-CSE-ConnectionGUID: EbEeF3tpRSiUO9XIILONbA==
X-CSE-MsgGUID: ihCP6KCVTmyK4mbdcfkjxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="149314"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="149314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 07:10:51 -0700
X-CSE-ConnectionGUID: M3c3SqVOQLKja4vNVlUang==
X-CSE-MsgGUID: 9HdvoDwQRFCDuHzkDedXQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="305440278"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.231])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 07:10:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/edid: Honor overrides when DDC is unresponsive
In-Reply-To: <8fd336cc-6dae-4a9e-97d0-0c5eddab589c@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
 <1efb1842489bc50e87ab0476e3d3ad861d6ef807@intel.com>
 <8fd336cc-6dae-4a9e-97d0-0c5eddab589c@amd.com>
Date: Wed, 07 Oct 2026 17:10:46 +0300
Message-ID: <a0c27fb3b765b41eeedeb102295a0ee473efe08a@intel.com>
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

On Sat, 19 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
> On 9/18/26 04:41, Jani Nikula wrote:
>> On Thu, 17 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>> DRM's EDID read helpers probe DDC before consulting debugfs or firmware
>>> overrides. This preserves connector-detection semantics for drivers that
>>> use a successful EDID read as evidence that a sink is connected, but it
>>> prevents drivers with independent presence detection from using an
>>> override when DDC is unresponsive.
>> 
>> IOW, your use case is that you want to use an override EDID with
>> reliable presence detection other than the DDC probe, and don't want to
>> use connector forcing.
>> 
>>> This affects AMD Display Core, which establishes physical presence from
>>> HPD before attempting to read the EDID. When a connected sink stops
>>> responding over DDC, the configured override is ignored and AMDGPU falls
>>> back to a 640x480 mode.
>>>
>>> Add an override-only EDID reader that does not access hardware, then use
>>> it in AMD Display Core before trying ACPI, VBIOS, or DDC sources. The new
>>> helper preserves DRM_FORCE_OFF handling and the existing preference for
>>> debugfs overrides over firmware EDIDs.
>> 
>> It was quite a bit of work to unify the firmware/override EDID handling
>> to be the same for all drivers. I'm not exactly thrilled about exposing
>> a mechanism to *only* get the override EDID, just to allow drivers to
>> deviate from the unified mechanisms.
>> 
>> The goal was to plug in the override at the low level, hidden away from
>> drivers, to make it as close to the normal case as possible. One of the
>> follow-up ideas, which I never really got around to, was to do the exact
>> same validity checking in _drm_do_get_edid() for override EDIDs as
>> regular EDIDs.
>> 
>> I'm thinking maybe we need a way to allow drivers to define a
>> drm_probe_ddc() alternative as a connector callback? If you set it, you
>> can use another mechanism for presence detection than DDC probe,
>> otherwise fall back to DDC probe. It could be used in the regular case
>> too, if you have a reliable and quicker mechanism than DDC probe.
>> 
> Well I guess the real reason that this deviation in amdgpu exists is 
> because of the ability to read the EDID from ACPI.
>
> See dm_helpers_probe_acpi_edid() for what it does.  Should we bump that 
> up to DRM core so all drivers could use it?

I guess would be nice to make it generic, but I'm not sure how many
places might break. Maybe some of our cases might get fixed! ;D

I wonder if it could be opt-in in the connector?

BR,
Jani.


>
> It was added to admgpu for consistency with Windows behavior - Windows 
> pulls from ACPI first.
>
> But if there isn't appettite for this being used everywhere; yeah maybe 
> switching to a callback might work too (I haven't prototyped it yet).

-- 
Jani Nikula, Intel
