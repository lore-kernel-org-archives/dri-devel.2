Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7640CD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4C210E038;
	Wed, 20 May 2026 07:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CJp1K6J7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E5310E038
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779263504; x=1810799504;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=2pdK7yMl0Eu0KFZCN1GWHW+vyDl/j8o2jsVU8JerzZg=;
 b=CJp1K6J7TR4DM899l41mcBpZWtZS068lxtAcvj6H432hZl9CeDUjfKNZ
 eHDEMSrnGkALsq5FMTFj4QDEr2kjcVaMht8uJa64aNycSa6J08ad9o06E
 t4zfgBYLi2/TlKMOZRc1qvMvy3vhq0yRiqiKL3Htjcm53Ao5ddjOrcihq
 gIuzn9m+V7EyuMfeQsXA8i9oVv+6lEaGUK/+Exy8weutG6pAbMsN4hBU5
 gPl1wg4uOF2MkKxZYen17lFUoexjU9sC+kiVfHCije0/EKJ0bXeNnLIrA
 vB40Ashj8g5T98EoEElcQE3V1LPVSgvnrG7dHvSiSHc6Kw5wKhxa1O917 Q==;
X-CSE-ConnectionGUID: qA5OxaASQfmE4seSRhBxRQ==
X-CSE-MsgGUID: WSGdisK5Tli98n/CcQ8Q8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84037256"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="84037256"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:51:44 -0700
X-CSE-ConnectionGUID: EyTDGv4fQs+JFOdnTTFM0Q==
X-CSE-MsgGUID: 1xOQ8bmQTF20w+BNoD4pmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="240321993"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:51:41 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
In-Reply-To: <875x4iy1em.fsf@ocarina.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
 <78506dc5f7ff02a2bdd05de1170a1cb3e33e1abe@intel.com>
 <875x4iy1em.fsf@ocarina.mail-host-address-is-not-set>
Date: Wed, 20 May 2026 10:51:37 +0300
Message-ID: <b67b6e84021fd6d629e43132ccecae152af9bfaf@intel.com>
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

On Wed, 20 May 2026, Javier Martinez Canillas <javierm@redhat.com> wrote:
> Jani Nikula <jani.nikula@intel.com> writes:
>
> Hello Jani,
>
>> On Tue, 19 May 2026, Javier Martinez Canillas <javierm@redhat.com> wrote:
>
> [...]
>
>>>  
>>> +/* HDMI spec TMDS character rate limits (in Hz) */
>>> +#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
>>> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
>>> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
>>> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000
>>
>> Usually everything in DRM is in kHz, and Hz is the exception.
>>
>
> That is correct but in this case these constants are to be used with the
> HDMI helpers. Both struct drm_connector_hdmi_state.tmds_char_rate and
> the struct drm_bridge_funcs.hdmi_tmds_char_rate_valid() callback expect
> the TMDS char rate to be defined in Hz.

I guess I'm surprised those things were defined in terms of Hz then.

> If we define these in kHz, it means that drivers will have to * 1000 at
> every call site.

Yeah, not ideal.

>> I'm also not sure the 1_0, 1_3, and 2_0 really help anyone reading the
>> code. I won't remember what they mean in Hz or kHz, and I'll have to
>> look them up every single time.
>>
>
> I discussed this with Maxime before posting the patches since I wondered
> the same. He suggested that the max TMDS character rate was linked to the
> HDMI spec versions and that it would be more readable to name it using
> the spec version rather than the resolution.

Frankly I've never thought of the limits in terms of the spec versions,
but maybe it's just me. *shrug*

BR,
Jani.

>
> The other naming I suggested was:
>
> /* HDMI spec TMDS character rate limits (in Hz) */
> #define DRM_HDMI_TMDS_CHAR_RATE_MIN		 25000000
> #define DRM_HDMI_TMDS_CHAR_RATE_74_25MHZ	 74250000
> #define DRM_HDMI_TMDS_CHAR_RATE_148_5MHZ	148500000
> #define DRM_HDMI_TMDS_CHAR_RATE_297MHZ		297000000
> #define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_4		340000000
>
>> BR,
>> Jani.
>>

-- 
Jani Nikula, Intel
