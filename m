Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09A2C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B68C10E241;
	Mon, 21 Sep 2026 06:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ro57mYWB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1957C10E14B;
 Mon, 21 Sep 2026 06:33:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 085A060142;
 Mon, 21 Sep 2026 06:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D4D1F000FF;
 Mon, 21 Sep 2026 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789972390;
 bh=Gs0ogbLjaOerJvtQD6LY+dIL5ZerBmaywmvWiFZF2Z8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ro57mYWBluUBZyPaNmyl9rd9UwkRmwER4XJlHmQdQ5F7KwVPA31xAEsS+AxvzFHD5
 0DpFtjoVp9Tjh/PLjHCOUycBGaQY8ndnWtMEskYw8CGuwg6V8FrW2+wXfxh/GcUUct
 wJ8pqu0m/KGv5ybRwmHT/MRQotvJJ4zvgtZ/XJiDiAISqtD6rFI4OqMehP9DqJP0UV
 2oDbXnkwDtfclck89TwDDT4GkKZTiMZm5fS3abExakPXv44hCB2B/P/iJS526wO81L
 45UNASOvssR0YT+C0USgxxXvgeEmGrxtGRFbh+9mSkqAmVz+DxEXnUqj4Jy82MiQvr
 bljce+yCs1Xrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: Drop ratelimiting from dev_unhold_work
 debug trace
To: "Varun Gupta" <varun.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260921062648.1166903-2-varun.gupta@intel.com>
References: <20260921062648.1166903-2-varun.gupta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:33:09 +0000
Message-Id: <20260921063310.89D4D1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/pagemap: CPU stall re-introduced by unbounded drm_dbg() loop
--

commit ea1ff5e58f9772cc1eaec3db21133d24e24bd4f0
Author: Varun Gupta <varun.gupta@intel.com>

drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace

This commit reverts the use of drm_dbg_ratelimited back to drm_dbg in
drm_pagemap_dev_unhold_work to avoid "callbacks suppressed" notifications
from the kernel's ratelimiting subsystem.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index c66c58f85c345..743988036a5f8 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -1102,7 +1102,7 @@ static void drm_pagemap_dev_unhold_work(struct work=
_struct *work)
>  		struct drm_device *drm =3D dev_hold->drm;
>  		struct module *module =3D drm->driver->fops->owner;
> =20
> -		drm_dbg_ratelimited(drm, "Releasing reference on provider device and m=
odule.\n");
> +		drm_dbg(drm, "Releasing reference on provider device and module.\n");

[Severity: Medium]
Does this code re-introduce a serial console bottleneck and potential CPU s=
tall
during teardown?

When tearing down an unbounded number of DRM pagemaps,
drm_pagemap_dev_unhold_work() iterates over the entire
drm_pagemap_unhold_list. If DRM debugging is enabled, drm_dbg() is now
called for every single entry unconditionally.

If the goal is to prevent the "callbacks suppressed" warning from the
ratelimiting subsystem, would it be better to drop the repetitive log
entirely, or perhaps log once outside the loop, rather than reverting
the CPU stall fix?

>  		drm_dev_put(drm);
>  		module_put(module);
>  		kfree(dev_hold);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921062648.1166=
903-2-varun.gupta@intel.com?part=3D1
