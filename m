Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30306CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5236010EF0F;
	Tue,  2 Jun 2026 10:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DBoIW+oy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF09D10EF0E;
 Tue,  2 Jun 2026 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780397634; x=1811933634;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Ni/tmRSfbzwa4khERF7pyUpxahTIJcKaBFVK8/nxsuA=;
 b=DBoIW+oyb9Mp3AOUChz72pKYD6mBiY9NAhLPct81HRS5hVVM64IdqWpr
 tsjDIJhOXEfRleJSkezpd4+069+n7BykcU6zc/DrHPn+MyygOi2fVpI99
 AnxXK1GUKMvKdzjTeG8EIdOsZWe/ILjvx6+XlAEFO2Y1x4S//jKGYZr8Z
 ARsFqdIaa2E/a8wZrmAzfX835IPRyj5vLHz2FkRSAPOkECmZaRpS9pj1F
 QEyuajoAJzshOy0LGwwa8lBYYtUk5rOBn1HnpNJHX2l+JTSw8T8CE+WUT
 seMe3TX7pKDXdxNDRx1flMpSDb58GtD0UjoPmTeD1bxiz++PCVbpw5oVv w==;
X-CSE-ConnectionGUID: kXTNdKaRS6ur2g3QLbd16w==
X-CSE-MsgGUID: mJ2F9eymSkitHbzza51MLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81206863"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81206863"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 03:53:54 -0700
X-CSE-ConnectionGUID: vbXWBbnLQ8y+BeiLtvtnGg==
X-CSE-MsgGUID: 9XNaPig7QH6L+umPL8IIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="243971915"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.253])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 03:53:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Saarinen, Jani" <jani.saarinen@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, "rajat.gupta@oss.qualcomm.com"
 <rajat.gupta@oss.qualcomm.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Syrjala, Ville" <ville.syrjala@intel.com>
Subject: RE: [PATCH] drm/dumb-buffers: Increase size limits to match current
 devices
In-Reply-To: <PH3PPFAB42632359128CE02EC820D17E137E0122@PH3PPFAB4263235.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260602073027.192758-1-tzimmermann@suse.de>
 <PH3PPFAB42632359128CE02EC820D17E137E0122@PH3PPFAB4263235.namprd11.prod.outlook.com>
Date: Tue, 02 Jun 2026 13:53:47 +0300
Message-ID: <577c2e6c08b96844a5144bee0d5a0536b4ab939e@intel.com>
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

On Tue, 02 Jun 2026, "Saarinen, Jani" <jani.saarinen@intel.com> wrote:
> Hi, 
>> -----Original Message-----
>> From: Thomas Zimmermann <tzimmermann@suse.de>
>> Sent: Tuesday, 2 June 2026 10.30
>> To: rajat.gupta@oss.qualcomm.com; jani.nikula@linux.intel.com; Saarinen,
>> Jani <jani.saarinen@intel.com>; simona@ffwll.ch; airlied@gmail.com;
>> mripard@kernel.org; maarten.lankhorst@linux.intel.com
>> Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; intel-
>> xe@lists.freedesktop.org; Thomas Zimmermann <tzimmermann@suse.de>
>> Subject: [PATCH] drm/dumb-buffers: Increase size limits to match current
>> devices
>> 
>> Increase the limits for dumb-buffer arguments to sizes of 16384x16384 at 64
>> bpp. Such buffer sizes are still within 32-bit unsigned limits.
>> Fixes CI and high-end devices.
>> 
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 5ab62dd3687b ("drm: prevent integer overflows in dumb buffer
>> creation helpers")
>> Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
>> Closes: https://lore.kernel.org/dri-
>> devel/ddf0233e50044059c85279f928661563ef6a55bf@intel.com/
>
> Seems not helping on i915 CI BAT issue https://lore.kernel.org/intel-gfx/178038951063.34290.3796875109342598028@6beec6c84f66/T/#u 
> => https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_167719v1/index.html?

Right, so vgem_basic has this, among other things:

	bo.width = 1<<15;
	bo.height = 1<<15;
	bo.bpp = 16;
	vgem_create(fd, &bo);

i.e. 32768x32768.

Not so sure about this one.

Anyone else care to chime in?


BR,
Jani.

>
>> Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>
> Br,
> Jani
>
>> ---
>>  drivers/gpu/drm/drm_dumb_buffers.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c
>> b/drivers/gpu/drm/drm_dumb_buffers.c
>> index e60130b2bb0c..9c4cfb3210aa 100644
>> --- a/drivers/gpu/drm/drm_dumb_buffers.c
>> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
>> @@ -201,11 +201,12 @@ int drm_mode_create_dumb(struct drm_device
>> *dev,
>>  	if (!args->width || !args->height || !args->bpp)
>>  		return -EINVAL;
>> 
>> -	/* Reject unreasonable inputs early.  Dumb buffers are for software
>> -	 * rendering; nothing legitimate needs more than 8192x8192 at
>> 32bpp.
>> -	 * This prevents overflows in downstream alignment helpers.
>> +	/*
>> +	 * Reject unreasonable inputs early. Dumb buffers are for software
>> +	 * rendering; nothing legitimate needs more than 16384x16384 at
>> +	 * 64 bpp. This prevents overflows in downstream alignment helpers.
>>  	 */
>> -	if (args->width >= 8192 || args->height >= 8192 || args->bpp > 32)
>> +	if (args->width > 16384 || args->height > 16384 || args->bpp > 64)
>>  		return -EINVAL;
>> 
>>  	/* overflow checks for 32bit size calculations */
>> 
>> base-commit: a980196655477a8f5067112946401fe52e510664
>> --
>> 2.54.0
>

-- 
Jani Nikula, Intel
