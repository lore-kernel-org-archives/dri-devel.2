Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C69C88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B515B10E894;
	Wed, 16 Sep 2026 10:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iRR3Vb7G";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D6410E6D2;
 Wed, 16 Sep 2026 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789555126; x=1821091126;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=Xxykja+4BoQlnwOxSeW9w41xWfp/zSMiUOg5SOqiDLI=;
 b=iRR3Vb7GH3MKD7Rpj8HuiIay1ntqoUoH6WMIPi7ptEZNrnz+OKruATkm
 04RANuEiur/qmfgvGZlZcxLgCQ1bnl8fyT1KU+Hc844w57qes9zC9j+Ga
 tGNPNMZrDqkwz4p21Fvcc7ExArmSypsoUcHJgCW7lS8LrVIOgeJ5vG5oP
 sBSknrhuyafuUdBubBC1WO655Z0AS4lXvvnRqF4keKKl2Cp7s3jVu48O3
 8DbRt+NFpWkjZMFtV4ThVCpOTFDJrPiuQNDvzlNHHai43yuwI6xnJs54E
 M7Q/iW8ooZ0da9MZPtC17EQEmrRDhPySZ92/p0fAmjioiXh8h3uDigkq8 A==;
X-CSE-ConnectionGUID: pKF8vw1gTCiO/QFQYSHwGg==
X-CSE-MsgGUID: M813it9iRSiJVetTKrAlBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112696478"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112696478"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:38:45 -0700
X-CSE-ConnectionGUID: PArHnSarQJ6INAQ9PBuLTQ==
X-CSE-MsgGUID: FPa+hUYUSR2kOVzjtbOrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273270270"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.147])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:38:40 -0700
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
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v3 2/7] drm: Add drm_timeout_rel_to_jiffies()
In-Reply-To: <c20c43109d3ebb08ad6a0c811ffaeb48f90efed5@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
 <c20c43109d3ebb08ad6a0c811ffaeb48f90efed5@intel.com>
Date: Wed, 16 Sep 2026 13:38:37 +0300
Message-ID: <92e315da6bd0a3daa36948f4de2e1b4f82c49e27@intel.com>
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

On Wed, 16 Sep 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Tue, 15 Sep 2026, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>> drm_timeout_abs_to_jiffies() covers the drivers whose wait UAPI takes an
>> absolute deadline, but there is no equivalent for the drivers that
>> express a wait as a duration. Drivers such as i915 and v3d convert the
>> value themselves.
>>
>> Converting a nanosecond duration to jiffies needs some care.
>> nsecs_to_jiffies() returns unsigned long, so on 32-bit a large
>> userspace-supplied timeout overflows its range and is silently truncated.
>>
>> i915 already handles both cases in a local helper, which v3d has a copy
>> of. Add the same conversion to the core, so that it is available to any
>> driver and both copies can be dropped.
>>
>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> ---
>>  drivers/gpu/drm/drm_timeout.c | 45 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/drm/drm_timeout.h     |  1 +
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout=
.c
>> index 35e10293e0a1..ee545475429c 100644
>> --- a/drivers/gpu/drm/drm_timeout.c
>> +++ b/drivers/gpu/drm/drm_timeout.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/export.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/ktime.h>
>> +#include <linux/math64.h>
>>  #include <linux/sched.h>
>>=20=20
>>  #include <drm/drm_timeout.h>
>> @@ -48,3 +49,47 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeou=
t_nsec)
>>  	return timeout_jiffies64 + 1;
>>  }
>>  EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
>> +
>> +/**
>> + * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative=
 value
>> + * @timeout_nsec: relative timeout in ns, 0 for poll
>> + *
>> + * Calculate the timeout in jiffies from a relative timeout in ns, for =
drivers
>> + * whose UAPI expresses a wait as a duration rather than as a deadline.
>> + *
>> + * The result is clamped to MAX_JIFFY_OFFSET. That keeps it positive on=
ce it is
>> + * converted to the signed long taken by dma_fence_wait_timeout() and f=
riends,
>> + * which matters on 32-bit, and keeps it distinct from MAX_SCHEDULE_TIM=
EOUT so
>> + * that a finite wait is never understood as an infinite one.
>> + *
>> + * It's strongly discouraged to use relative timeouts in uAPIs, as they=
 do not
>> + * survive a restarted ioctl. A signal-interrupted ioctl is re-entered =
with the
>> + * same arguments, so the duration starts counting from zero again. New=
 uAPIs
>> + * should take an absolute deadline and use drm_timeout_abs_to_jiffies(=
).
>> + *
>> + * Returns:
>> + * 0 if @timeout_nsec is 0. Otherwise the equivalent number of jiffies =
and
>> + * clamped to MAX_JIFFY_OFFSET.
>> + */
>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
>> +{
>> +	u64 secs;
>> +	u32 rem;
>> +
>> +	/* Make 0 timeout means poll, as for the absolute variant. */
>> +	if (timeout_nsec =3D=3D 0)
>> +		return 0;
>> +
>> +	/*
>> +	 * As nsecs_to_jiffies64() does not guard against overflow, split
>> +	 * the timeout into whole seconds and nanoseconds. This way
>> +	 * nsecs_to_jiffies64() is always handed a value below a second.
>> +	 */
>> +	secs =3D div_u64_rem(timeout_nsec, NSEC_PER_SEC, &rem);
>> +	if (secs >=3D MAX_JIFFY_OFFSET / HZ)
>> +		return MAX_JIFFY_OFFSET;
>> +
>> +	return min_t(u64, MAX_JIFFY_OFFSET,
>> +		     secs_to_jiffies(secs) + nsecs_to_jiffies64(rem) + 1);
>> +}
>> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
>> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
>> index cd9621c52062..6ee222a3e97c 100644
>> --- a/include/drm/drm_timeout.h
>> +++ b/include/drm/drm_timeout.h
>> @@ -12,5 +12,6 @@
>>  #include <linux/types.h>
>>=20=20
>>  signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
>
> The signed/unsigned differences here bug me a little. Maybe explain why
> in the commit message if there's a rationale?
>
> I note that drm_timeout_rel_to_jiffies() return value is assigned to
> unsigned long variables half the time. I guess its kernel-doc could say
> it never returns negative values?

Gah, I meant drm_timeout_abs_to_jiffies() here, sorry.

>
> BR,
> Jani.
>
>
>
>
>>=20=20
>>  #endif

--=20
Jani Nikula, Intel
