Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3705EC982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2799210E2EB;
	Wed, 16 Sep 2026 16:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W/yDxESd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D438A10E19F;
 Wed, 16 Sep 2026 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789574833; x=1821110833;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=97hcJwbWQnSyhO/AE+RfsqlANRbBsH05NzqjDLVib6w=;
 b=W/yDxESdkfLmX3ezAZSHT4X0NSjqFKlWdPbGNQ/1FiKKGX61wAQpAAlN
 hAMrJ9mGy81s4xpieMa7Yb2RerN3Ohxout0VRb6ZA7tZ3Wx7GtjKcYwi/
 LscAqDvI/N474AcvUaJcdwTF1I1leGhiT4/6ZzNNJv4kAUQGTHBioyfhR
 YsRePs4cL+ld/LzI8K/2x45AluOk+OHn2XlAEh9v23cbmUBlKZ2XkO7Mj
 7leS+BXkJlHBInqlPetMQZvArzdREKNoup7OFMyiIXw60fQ5w7b2bMGnU
 cILbjqrQ7cs3L7ZElCoDHf8pMYV2D25zfig/SAgirnhiyih2FwtqmBUpB Q==;
X-CSE-ConnectionGUID: j0X8DNU4RLu7pLVTDK65oQ==
X-CSE-MsgGUID: q3jrjotZQreLm0glTXPQdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93780159"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93780159"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 09:07:01 -0700
X-CSE-ConnectionGUID: 786FK0E0SV62ILy+10QEOg==
X-CSE-MsgGUID: JMFGyQ2QSy66aZnmkg1nOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269675732"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.224])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 09:06:57 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 2/7] drm: Add drm_timeout_rel_to_jiffies()
In-Reply-To: <3f134188-0af1-4c7e-8bb8-ddb2504c9efe@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
 <c20c43109d3ebb08ad6a0c811ffaeb48f90efed5@intel.com>
 <3f134188-0af1-4c7e-8bb8-ddb2504c9efe@igalia.com>
Date: Wed, 16 Sep 2026 19:06:54 +0300
Message-ID: <0c3770584e44853af296eac4418b3cace9a1d0c6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 16 Sep 2026, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> Hi Jani,
>
> On 16/09/26 07:38, Jani Nikula wrote:
>> On Tue, 15 Sep 2026, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>>> drm_timeout_abs_to_jiffies() covers the drivers whose wait UAPI takes an
>>> absolute deadline, but there is no equivalent for the drivers that
>>> express a wait as a duration. Drivers such as i915 and v3d convert the
>>> value themselves.
>>>
>>> Converting a nanosecond duration to jiffies needs some care.
>>> nsecs_to_jiffies() returns unsigned long, so on 32-bit a large
>>> userspace-supplied timeout overflows its range and is silently truncate=
d.
>>>
>>> i915 already handles both cases in a local helper, which v3d has a copy
>>> of. Add the same conversion to the core, so that it is available to any
>>> driver and both copies can be dropped.
>>>
>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>>> ---
>>>   drivers/gpu/drm/drm_timeout.c | 45 ++++++++++++++++++++++++++++++++++=
+++++++++
>>>   include/drm/drm_timeout.h     |  1 +
>>>   2 files changed, 46 insertions(+)
>>>
>
> [...]
>
>>> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
>>> index cd9621c52062..6ee222a3e97c 100644
>>> --- a/include/drm/drm_timeout.h
>>> +++ b/include/drm/drm_timeout.h
>>> @@ -12,5 +12,6 @@
>>>   #include <linux/types.h>
>>>=20=20=20
>>>   signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
>>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
>>=20
>> The signed/unsigned differences here bug me a little. Maybe explain why
>> in the commit message if there's a rationale?
>>=20
>
> Answering both your e-mails, the rational behind this change was: don't
> make any changes to drm_timeout_abs_to_jiffies(); only move it as it is.
> As I'm the one introducing drm_timeout_rel_to_jiffies(), I took the
> liberty to implement it in a way that makes more sense to me, which is
> using `unsigned long`, considering that a timeout in jiffies should
> always be positive. Also, i915 and v3d implement the function returning
> an unsigned long.
>
> I believe that drm_timeout_abs_to_jiffies() historically returned a
> signed long because dma_fence_wait_timeout() takes a signed long timeout
> parameter (I'm not sure why).

Right. Maybe add something about it in the commit message(s) while
applying? No need to resend.

Thanks,
Jani.


>
> Best regards,
> - Ma=C3=ADra
>
>> I note that drm_timeout_rel_to_jiffies() return value is assigned to
>> unsigned long variables half the time. I guess its kernel-doc could say
>> it never returns negative values?
>>=20
>> BR,
>> Jani.
>>=20
>
>

--=20
Jani Nikula, Intel
