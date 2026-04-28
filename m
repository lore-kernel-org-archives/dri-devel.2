Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D9FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A52110EA88;
	Tue, 28 Apr 2026 08:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jVclxR6r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73EC10E30D;
 Tue, 28 Apr 2026 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363707; x=1808899707;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=fzGOc8yrRwhH4cK53Ssfj+EHs4gcJvOuup0Tc7OURec=;
 b=jVclxR6rSpVtRGHGeheE+fpRAsVhtcXd/bBuzUKlz8WQhjnGeyaY+Nlv
 kZSv301oUYfx1GbgY6aBgRAwVutKUzrMSSjGdkNdkdDL3tvCZ2+vRWsTe
 5fSGcRgzDDTYAcp7pS/WqI5iquNQY7Qv+3eNsdhx4nEOvl80+zBTQSJxG
 2BGcA1l2uOedypB/wv6CK7j3QwZQF6sbMl7fhk80p33LDRZw5yB7ki+df
 hBcuYo41DyYuxtAaY41sEhYzNbIe63kiHaD1UNzNBDZ8u3MpKCLLetlOw
 mIDsXTe+dYDrnZAspQ51jrgiQ09H4YgC3cYoZ3vv6pcacXLXUiZLNdy0i Q==;
X-CSE-ConnectionGUID: XAS6R4ylSjCqwBj0vNDN4g==
X-CSE-MsgGUID: McwX2j4HR66vxaRapRe1Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78143683"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="78143683"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 01:08:26 -0700
X-CSE-ConnectionGUID: pIuhJKFrT+yBg1kd06mbfw==
X-CSE-MsgGUID: /lpu6fYaSwOOIVb4qA808A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="231240123"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.208])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 01:08:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?=
 =?utf-8?Q?_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Don't emit UTS_RELEASE as part of device coredump
In-Reply-To: <ae_dpnVNS4liMfxe@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260427160902.1126027-2-u.kleine-koenig@baylibre.com>
 <ae_dpnVNS4liMfxe@intel.com>
Date: Tue, 28 Apr 2026 11:08:21 +0300
Message-ID: <9c7244e954a12e2026d1148e4e9c75f02f9d6071@intel.com>
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

On Mon, 27 Apr 2026, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> On Mon, Apr 27, 2026 at 06:09:03PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
>> UTS_RELEASE changes quite easily (e.g. uncommitted changes in the source
>
> we know, this is exactly why we use it ;)
> We want to be able to differentiate if it is a distro build versus custom=
 build.
>
>> tree or new commits). So when checking if a patch introduces changes to =
the
>> resulting binary each usage of UTS_RELEASE is a source of annoyance as
>> it introduces changes not caused by the change under test.

Would it help to use init_uts_ns.name.release from
init/version-timestamp.c instead of UTS_RELEASE? No rebuilds, info
retained.

BR,
Jani.



>>=20
>> It's little helpful to emit the kernel version in the device coredump, so
>> drop the kernel version line from it.
>
> That's a driver decision, no?!
> We think it is useful and this change breaks the tools that are parsing i=
t.
> So, please drop this patch.
>
> Thanks,
> Rodrigo.
>
>>=20
>> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
>> ---
>> Hello,
>>=20
>> I'm not really sure if my assertion above that the kernel version isn't
>> helpful is actually true.
>>=20
>> If yes, there are a few more very similar changes to make:
>>=20
>> 	$ git grep -E 'drm_p.*UTS_RELEASE' v7.1-rc1 drivers/gpu/
>> 	v7.1-rc1:drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c:      drm_pri=
ntf(&p, "kernel: " UTS_RELEASE "\n");
>> 	v7.1-rc1:drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c:     drm_pri=
ntf(p, "kernel: " UTS_RELEASE "\n");
>> 	v7.1-rc1:drivers/gpu/drm/msm/msm_gpu.c: drm_printf(&p, "kernel: " UTS_R=
ELEASE "\n");
>> 	v7.1-rc1:drivers/gpu/drm/xe/xe_devcoredump.c:   drm_puts(&p, "kernel: "=
 UTS_RELEASE "\n");
>>=20
>> Best regards
>> Uwe
>>=20
>>  drivers/gpu/drm/xe/xe_devcoredump.c | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe=
_devcoredump.c
>> index 558a1a9841a0..260e3f19286b 100644
>> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
>> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
>> @@ -101,7 +101,6 @@ static ssize_t __xe_devcoredump_read(char *buffer, s=
size_t count,
>>=20=20
>>  	drm_puts(&p, "**** Xe Device Coredump ****\n");
>>  	drm_printf(&p, "Reason: %s\n", ss->reason);
>> -	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
>>  	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
>>=20=20
>>  	ts =3D ktime_to_timespec64(ss->snapshot_time);
>>=20
>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>> --=20
>> 2.47.3
>>=20

--=20
Jani Nikula, Intel
