Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A17C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055B810EC9E;
	Wed, 29 Jul 2026 15:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A9YEkYzJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C8F10ECA5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785338202; x=1816874202;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ylNlrwd5I+ocZZ9hMiT1FUoQDTuD4qsR1sCf+aIRzN4=;
 b=A9YEkYzJMqbBv4c5j+Z4KIEf2SC0geSFzQMRT97VVICyrlmckFffMw0m
 sYwPUanaJZ7W0A9teVkcq+mHjIhK6Z1qJBTTl7hMumlN2EEshQ+VOAz/u
 N5n3t8cTEy4NsBAO4c6GdxZ7XYFtebvjTrBceGnwhkaG9gfyP+t2D8emA
 rRSzdOmIe8kXcSC9BlkKgO5pDlHV5ryoFKKL/tB0pzYb6u4o7S1llyZ02
 aBz73vq7xiR4AgWgY81JT3aetFQsgEXNpYKnGHPFre0yyURTT3wJH/Zba
 6D6fi3PyESAe1k7tBfJ3/FlxNqpBJ0VvNbM7jEUpoKGCF21B5K2LZ9c6i Q==;
X-CSE-ConnectionGUID: 8hSUbKnkRc+FpICtOWr/IA==
X-CSE-MsgGUID: ndakj0OaQ9OzyQm60iM6Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85962506"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="85962506"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 08:16:41 -0700
X-CSE-ConnectionGUID: J+Qd/klSQyaD8SwYvHWYuA==
X-CSE-MsgGUID: 724wJqkxT76KpKAiokNrXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="256104711"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.212])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 08:16:37 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH v2] drm/log: Fix division by zero when scale module
 parameter is 0
In-Reply-To: <8012b9ea-a39d-437a-8539-9e4c3836d1bd@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260729105840.865696-1-oushixiong1025@163.com>
 <8012b9ea-a39d-437a-8539-9e4c3836d1bd@redhat.com>
Date: Wed, 29 Jul 2026 18:16:35 +0300
Message-ID: <11999f4020869c7094a718f4762a0fc475a8a8d1@intel.com>
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

On Wed, 29 Jul 2026, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> On 29/07/2026 12:58, oushixiong1025@163.com wrote:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>> 
>> The scale module parameter can be set to 0 via kernel command line or
>> sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
>> causing a division by zero in the rows/columns calculation.
>> 
>> Introduce a drm_log_scale() helper that returns scale ?: 1, and use it
>> at all read sites. This avoids a race that a setter-based clamp would
>> have between param_set_uint() and the subsequent check, where another
>> CPU could observe scale == 0.
>
> The scale module parameter is read only (that's the meaning of 0444 in 
> module_param()) so it can't be set by sysfs, or change at runtime.
>
> So this check can be done only once in drm_log_register().

Oops, missed this in my review completely, thanks!


-- 
Jani Nikula, Intel
