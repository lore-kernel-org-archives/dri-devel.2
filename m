Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9771BC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6FE10E0CC;
	Wed, 26 Aug 2026 21:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="frRsqImR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D617010E0CC
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:31:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC3E94152F;
 Wed, 26 Aug 2026 21:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D58D1F000E9;
 Wed, 26 Aug 2026 21:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787779896;
 bh=g66OlWT8R8PfxMlOfz/HY0zKvhyvBE1zgm69UPFVLOs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=frRsqImRHY8O80T4yG9h4ctEGYGLdZ1FppFhy7KP7S6QejLXynNQcverrLxMVKiRD
 JCESdUrAlFIS98s9kOB9z7cQxi/TbcpivwsKujg8h6euOcGoHfpshnkekSWA/8OT42
 u3mjJXiwTUTLb5S4Eey80rcm0tEuJdB9ILZxfzSOt3E395sY0i2CTC545pIFP2TsFx
 Xua4JuzRKWrQLxAcuPtRnUxQtiS2Z3H5fN6ecEoA9XXPRAYfW3xfkye7WHU9SfYjyO
 Y8JygaixN+qM2X/fy8jCWulEoZv1Nj3+P/X34Z2zn8HDn7jq3ah5XBtJFt6daNllXP
 O3Um2KvpHpv+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/16] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-8-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-8-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:31:36 +0000
Message-Id: <20260826213136.7D58D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Calling pm_runtime_put_noidle() before pm_runtime_disable() during=
 device teardown introduces a race condition that can lead to accessing sus=
pended hardware.

Pre-existing issues:
- [High] Unchecked pm_runtime_get_sync() failure leads to register access w=
hile hardware is suspended.
--

commit d10f29fd6bb7082083a7547ad09e4497f2af934a
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

This commit addresses issues where the PM usage count is not correctly
adjusted during probe and unplug, which prevented the runtime suspend
callback from being invoked or caused the usage count to monotonically
increase on reloads. It manually adjusts the PM reference count in these
paths and disables autosuspend during device teardown.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 0cc277efb5850..f6066aef47666 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -334,9 +335,13 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	if (err < 0)
>  		goto out_devreg;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> +
>  	return 0;
> =20
>  out_devreg:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);

[Severity: High]
Does calling pm_runtime_put_noidle() before pm_runtime_disable() create a
race condition here?

If a concurrent job completes in the background (since schedulers have not
been stopped yet), could its interrupt handler call
pm_runtime_put_autosuspend()?

Because the teardown thread just dropped its reference, this concurrent put
could drop the usage count to 0 and suspend the device immediately.

When pm_runtime_disable() then flushes pending work and returns, the teardo=
wn
thread will proceed to panfrost_device_disable_hw(). Could accessing the
registers of the now-suspended device result in a synchronous external abor=
t?

Would it be safer to call pm_runtime_put_noidle() after pm_runtime_disable()
to guarantee no further runtime PM state transitions occur during teardown?

>  	panfrost_device_disable_hw(pfdev);
>  	panfrost_gem_fini(pfdev);
[ ... ]
> @@ -363,6 +368,8 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
>  	pm_runtime_get_sync(pfdev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but does ignoring the return val=
ue
of pm_runtime_get_sync() risk causing a system crash?

If waking the device fails (for example, due to a clock or regulator
failure), it will return a negative error code and the device remains
suspended. Since the error is ignored, panfrost_device_fini() proceeds
unconditionally.

Could this lead to panfrost_device_disable_hw() attempting to access
registers while the hardware is powered off, resulting in a bus error?

Note that while follow-up patch 9 in this series adds a drm_WARN_ON() here,
it doesn't appear to abort the teardown or prevent subsequent hardware acce=
sses
on failure.

> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);

[Severity: High]
Does the same race condition mentioned above also apply here in
panfrost_device_fini()?

If a background job completes and triggers a suspend after the reference is
dropped but before pm_runtime_disable() finishes, could this cause
panfrost_device_disable_hw() to access a powered-off device?

> =20
>  	panfrost_device_disable_hw(pfdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D8
