Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E74C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6437810F4C3;
	Thu,  9 Jul 2026 10:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D7dKW8LG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE1A10F462;
 Thu,  9 Jul 2026 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783591305; x=1815127305;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TEl/JPlrmtxrSDM/EEqovHLemprWyXvIvJ/ofjuX++I=;
 b=D7dKW8LGxbxaTWsh2wiRsh1Yh9wqysuKJsXFMiMZ7RYGHxbu6C/atLPe
 xT1CIPRUJt0kSvJdXnlhK3YA8k82dvMhV3mxZn/I1OQJjI4tDge0RmZxC
 MhoiM1C49+ii9ga5zqsXX7t6QOk6Nw3JzH5rSIQmr4kr7cBunTEsaHxU7
 sKuu9AQXor5pp/KgZiv4eptqMckV+COCofpBzhMywSuz05XdZMRigoKZY
 2Y6eS3RjlmBXDQs5x3C/zi6Hc4TNqlms9sCb7TmF51GS0mnorSZKgeW4d
 S8dXWoXFVgNxwpB43Z/bLvQBjQkE6A+3u0ZEewK7UCpooySOrYl9UfWQ3 g==;
X-CSE-ConnectionGUID: fDSjUg3DR1GAjImtawL2PA==
X-CSE-MsgGUID: S15zomFkRMKVY2re+wAiBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84239927"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84239927"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:01:44 -0700
X-CSE-ConnectionGUID: W2Ap1TupQRe4smn0ovnd5A==
X-CSE-MsgGUID: MK7szr82QB2Pw3ZBjm7NQg==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.49])
 ([10.245.244.49])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:01:39 -0700
Message-ID: <d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com>
Date: Thu, 9 Jul 2026 12:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Daniel Stone
 <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260703073230.19982-1-robert.mader@collabora.com>
 <6d8806b8-fc71-4699-82c4-7189a0ea2284@intel.com>
 <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
 <7d58b289-eabe-4d68-9080-c7202b0f60a0@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <7d58b289-eabe-4d68-9080-c7202b0f60a0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hey,

On 7/9/26 08:44, Borah, Chaitanya Kumar wrote:
> 
> 
> On 7/7/2026 6:31 PM, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 7/7/26 10:03, Borah, Chaitanya Kumar wrote:
>>>
>>> On 7/3/2026 1:02 PM, Robert Mader wrote:
>>>> The client cap is currently advertised unconditionally, even for drivers
>>>> that do not support plane color pipelines. If clients supporting the later,
>>> s/later/latter
>>>
>>>> like Wayland compositors or tools like drm_info, enable the client cap on
>>>> such drivers they will be left without both color pipeline and the legacy
>>>> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
>>>> conversion support.
>>>>
>>>> Prevent that by only marking the cap supported if there are actually planes
>>>> with color pipelines.
>>>>
>>>> Note: while the color pipeline replacement for the legacy properties is
>>>> still under review (1), we can assume that it will work as a drop-in
>>>> replacement.
>>> This change will but a driver can also choose to export colorops like programmable CTM_3x4 to achieve the same.
>>>
>>> We should also perhaps document this somewhere that if a driver supports LEGACY properties, it is imperative to implement some version of it with the color pipeline line property.
>> Would this be doable inside drm core? Implement the color pipeline properties, get the fixed pipeline for free?
> 
> Right now, the Bypass(default) pipeline is automatically created when we call drm_plane_create_color_pipeline_property(), we could come up with a similar helper that could also create a pipeline that replaces the legacy properties.
> 
> But this can't replace the existing helper entirely because some HW (though unlikely) might not support YUV buffers.

No need to do this for free, but a cheaper way for drivers to implement legacy
properties by only implementing the pipeline would be nice, similar to how
atomic also implements legacy modesetting and universal planes.

Kind regards,
~Maarten Lankhorst
