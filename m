Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB03FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2D510E321;
	Tue, 28 Apr 2026 11:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YMDze/Te";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D0610E311;
 Tue, 28 Apr 2026 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777374576; x=1808910576;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=ay2Te7p98W7UWUNyjbMMPjBv35QX/kzz4x6ZOlnWI4w=;
 b=YMDze/TeuUX/0lAKUlI/90Ohe7yc1z0bKSwRc4ARK6ASGPKrrBnjw14+
 yzsBrOh7Kdx/i4zqFhTvwG3meQYOBsgQejHf+To/U0gBw/4ZyITUjSCnP
 h4QMkpH36jyZBGc/BA1XvJgSQhQLIkKIY/BFyUckxjkzoQabKr4tqpezy
 wVAGFbdqspFbNjbXdKZBEloHRyUHxatf7nmEzPGSuDH66bp3a8F+/ZOFO
 RGEPOBSY7sLQ24GwXTK8g7yhTc4ynNFBHtXYiLE12NDZ/qujez4DmsbIa
 2VMN7C8i9z6M8GpPFkMVhNKu3RliHOaFjFSTCaMAk0rF1kDkH6+RGFrXF Q==;
X-CSE-ConnectionGUID: 3u8kfLDIRl2eTHm0Ps2sxw==
X-CSE-MsgGUID: lPhNlEGOSFOKtLE6iTso7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88589727"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="88589727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 04:09:36 -0700
X-CSE-ConnectionGUID: LD4maPvmRnS0+qHIb+3GGw==
X-CSE-MsgGUID: EcKwJ/HIS2eJtbt13SgYdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="229358230"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.208])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 04:09:33 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
In-Reply-To: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
Date: Tue, 28 Apr 2026 14:09:31 +0300
Message-ID: <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
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

On Tue, 28 Apr 2026, Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koen=
ig@baylibre.com> wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
>
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect xe_devcoredump.o.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
> Hello,
>
> (implicit) v1 of this patch is available at=20
> https://lore.kernel.org/20260427160902.1126027-2-u.kleine-koenig%40baylib=
re.com.
>
> The only changes since then is that instead of dropping the kernel line,
> init_utsname()->release is used, which is nearly what Jani Nikula
> suggested.

Almost the same, but better. ;)

I wonder if most UTS_RELEASE uses in the kernel should be changed the
same way?


BR,
Jani.


>
> Best regards
> Uwe
>
>  drivers/gpu/drm/xe/xe_devcoredump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> index 558a1a9841a0..07c7c89240d8 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -8,7 +8,7 @@
>=20=20
>  #include <linux/ascii85.h>
>  #include <linux/devcoredump.h>
> -#include <generated/utsrelease.h>
> +#include <linux/utsname.h>
>=20=20
>  #include <drm/drm_managed.h>
>=20=20
> @@ -101,7 +101,7 @@ static ssize_t __xe_devcoredump_read(char *buffer, ss=
ize_t count,
>=20=20
>  	drm_puts(&p, "**** Xe Device Coredump ****\n");
>  	drm_printf(&p, "Reason: %s\n", ss->reason);
> -	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
> +	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
>  	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
>=20=20
>  	ts =3D ktime_to_timespec64(ss->snapshot_time);
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

--=20
Jani Nikula, Intel
