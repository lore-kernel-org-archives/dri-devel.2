Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB83C9830C
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3255F10F0CC;
	Wed, 23 Sep 2026 14:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H1ZzjTwx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D8D10F0CC;
 Wed, 23 Sep 2026 14:21:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5382A60210;
 Wed, 23 Sep 2026 14:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D9C1F00893;
 Wed, 23 Sep 2026 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790173275;
 bh=Zpxa6lQYuSY9C6rSba8LywJv9qFzNYW6sVW2PoLYyEQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H1ZzjTwx9VQDn2DKVVGImlT6El+ZsmwiO4Ior93AVTLtPEjCIVVnURb4+++XrFI3/
 Lwv1Pq0Jb8DrOYQtqei+lfWu9yCyqB+V5WGUBb1HHsIHDlFheOc2ztYKD1ve3EntAu
 NK5Ga5s3EVP4ku5waC3mwNyXe2cRpMBFbBMcKnN0BfkydPRXGKFIuG/SnzLqF9jx+q
 4xWSQBCjL8TUiFF83xhlDT8h+TipZvMmmRcWkujMPbXWrOhJigeW8vIkFl03xYfopg
 Jl2Mx764fc79HxruP6L3dMh+/7pB/eL2VwrFsOn6Ld0mi5iMS8y7d/gZvbUKvyK+Ek
 OE0g4dCiA+MYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm: Provide a drm_dev_release_barrier() function
 to wait for device release callbacks
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260923140844.390822-2-thomas.hellstrom@linux.intel.com>
References: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
 <20260923140844.390822-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:21:14 +0000
Message-Id: <20260923142114.D3D9C1F00893@smtp.kernel.org>
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
- [High] drm: NULL pointer dereference in drm_WARN_ON_ONCE on error path
--

commit 5d11ff8a335cc538f36d72b0645fb2d88466a4ce
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Subject: drm: Provide a drm_dev_release_barrier() function to wait for devi=
ce release callbacks

This commit adds a new drm_dev_release_barrier() function allowing drivers
to wait until all device release callbacks have finished executing. It uses=
=20
a driver-owned SRCU domain to synchronize completion of release actions.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 0cdc606af8d18..df32821e693ac 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
[ ... ]
> +void drm_dev_release_barrier(const struct drm_driver *driver)
> +{
> +	if (drm_WARN_ON_ONCE(NULL, !driver || !driver->release_srcu))
> +		return;

[Severity: High]
Will passing NULL as the drm parameter to drm_WARN_ON_ONCE() cause a kernel=
=20
panic here?

If the warning condition is met, drm_WARN_ON_ONCE() passes the NULL pointer=
=20
to __drm_to_dev(), which returns NULL. This NULL pointer is then passed to=
=20
dev_driver_string() and dev_name().

Because dev_driver_string() unconditionally dereferences the dev pointer vi=
a=20
READ_ONCE(dev->driver), this transforms a non-fatal warning condition into =
an=20
immediate kernel crash on the error path instead of gracefully returning.

Should a standard WARN_ON_ONCE() be used here instead since no drm_device i=
s=20
available in this context?

> +
> +	synchronize_srcu(driver->release_srcu);
> +}
> +EXPORT_SYMBOL(drm_dev_release_barrier);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923140844.3908=
22-1-thomas.hellstrom@linux.intel.com?part=3D1
