Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9FBC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308BC10EF65;
	Wed, 23 Sep 2026 07:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LhqXWsnh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD6E10EF43;
 Wed, 23 Sep 2026 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790150071; x=1821686071;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=4DH4K3tfkaK9V9RiCAKIyVd1DTGuF1vHrVkTonYhHbo=;
 b=LhqXWsnh2tOF4C8Xu82tyX0jvePaEhWvTSCjT72ZOGYVz0FnqF1B7CLf
 fUSZgel5ioHnezPxCOcBOl4pd3pTsdMPMuX4Ih4NqcJcNvsgD5dkyH2kf
 GnwJRrJqy++z4ay04fhVoTbBMQEoyW2G4SXIytaNfoWQlq4IK3+BgtsFO
 wxI7p0+CZE2SXL1hO0ztH0GJuzpSoWsJs3kxYXguEK9WH8u7FUd+DuR6A
 nfXcpf1PyphJR/7D9Tkip7la38oSYxvEUT3/fuH/gjMfRqEiXF/oc708t
 MpwkbdVN90NOBN8CRjuy+F/tyLLymGqkf90UmIU0T8kZ+Lt8NA8ZdyccU w==;
X-CSE-ConnectionGUID: uiIhRG5vRkKcPUl6XLq5CA==
X-CSE-MsgGUID: IE7KpOg+SfS5slClm8lLkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90688422"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="90688422"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:54:30 -0700
X-CSE-ConnectionGUID: A4BXvKRzRcGzUZcXT2Uhlg==
X-CSE-MsgGUID: CW20GOR+TKquj3QKu4TogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="272090591"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.245])
 ([10.245.245.245])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:54:29 -0700
Message-ID: <6aefc78b4a0e5a16084c67bb22e6eada9974b363.camel@linux.intel.com>
Subject: Re: [PATCH] drm/pagemap: Drop ratelimiting from dev_unhold_work
 debug trace
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Varun Gupta <varun.gupta@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, matthew.brost@intel.com, 
 arvind.yadav@intel.com, himal.prasad.ghimiray@intel.com
Date: Wed, 23 Sep 2026 09:54:26 +0200
In-Reply-To: <20260921062648.1166903-2-varun.gupta@intel.com>
References: <20260921062648.1166903-2-varun.gupta@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Mon, 2026-09-21 at 11:56 +0530, Varun Gupta wrote:
> Reference-drop trace in drm_pagemap_dev_unhold_work() was changed
> from drm_dbg() to drm_dbg_ratelimited() to reduce serial console
> bottlenecks.
> However, when the ratelimit kicks in, the kernel's ratelimiting
> subsystem
> logs a "callbacks suppressed" notification at the KERN_WARNING level.
> Revert the trace macro back to drm_dbg()
>=20
> Fixes: b66b036c959f ("drm/pagemap: Prevent CPU stalls during
> unbounded pagemap teardown")
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/drm_pagemap.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_pagemap.c
> b/drivers/gpu/drm/drm_pagemap.c
> index 0867bfbde5c5..ba97daedcd49 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -1009,7 +1009,7 @@ static void drm_pagemap_dev_unhold_work(struct
> work_struct *work)
> =C2=A0		struct drm_device *drm =3D dev_hold->drm;
> =C2=A0		struct module *module =3D drm->driver->fops->owner;
> =C2=A0
> -		drm_dbg_ratelimited(drm, "Releasing reference on
> provider device and module.\n");
> +		drm_dbg(drm, "Releasing reference on provider device
> and module.\n");
> =C2=A0		drm_dev_put(drm);
> =C2=A0		module_put(module);
> =C2=A0		kfree(dev_hold);
