Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41461C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C41A10E14C;
	Tue, 30 Jun 2026 03:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NoF2BhyF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04BF10E14C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 03:22:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42A5740AF1;
 Tue, 30 Jun 2026 03:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B511F000E9;
 Tue, 30 Jun 2026 03:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782789774;
 bh=nftAbf1AZX3ZWHgeC+M3GVQwz9rYxdEbrMlJbNUJuVg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NoF2BhyF7fxO+xxdDzk46ikF1+oIPzHW5pABcoGhEHlm5iwfRJ/e5B6ycv/74nXOW
 ot3OxQxI0tMS5XjG4h0fttTILaYwbowdo5N0yWdT8e1Fq7lCgKDENvLoQ2c484tFPl
 HG+e0YJy+RP93YRQ7cOdlCwK/LbWoxjG2Ji/QMzlYckS9N9Gcqh/yEsoUHb1kF2hcD
 j7EPeOJT3Y4e70UKBzOb8uSN4VyjyySGubanCgBYrqNeI0eko+9/goI+LgpJBfPZ3h
 bBFAeUVDsir76A+W/H4pUoS+aVAGcwVvmgNjfnWdrHHoYRz7wUMOBU1VsEe8RKq4jg
 Rurp12wONgQsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: fix error handling in
 intel_display_driver_probe_noirq
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630031652.67747-1-yaolu@kylinos.cn>
References: <20260630031652.67747-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:22:53 +0000
Message-Id: <20260630032254.05B511F000E9@smtp.kernel.org>
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
- [High] Moving `intel_dmc_init()` before workqueue allocations causes a de=
terministic NULL pointer dereference in `queue_work()` during device probe.
--

commit ae307def86c4a6f405ddfe4fec9bd326757af84d
Author: Lu Yao <yaolu@kylinos.cn>
Subject: drm/i915/display: fix error handling in intel_display_driver_probe=
_noirq

This commit modifies the error handling path during display driver probe by
moving the intel_dmc_init call earlier and introducing a cleanup label for
intel_mode_config_init.

> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/driver=
s/gpu/drm/i915/display/intel_display_driver.c
> index d0729936f6816..d69bdfb19efe5 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -223,6 +223,8 @@ int intel_display_driver_probe_noirq(struct intel_dis=
play *display)
>  	if (!HAS_DISPLAY(display))
>  		return 0;
> =20
> +	intel_dmc_init(display);
> +

[Severity: High]
Does this cause a NULL pointer dereference during device probe?

Looking at intel_dmc_init() in intel_dmc.c, it attempts to queue work on the
unordered workqueue:

void intel_dmc_init(struct intel_display *display)
{
    ...
    queue_work(display->wq.unordered, &dmc->work);
    ...
}

However, display->wq.unordered is allocated further down in this function,
so it appears it will be NULL when intel_dmc_init() is called here.

>  	display->hotplug.dp_wq =3D alloc_ordered_workqueue("intel-dp", 0);
>  	if (!display->hotplug.dp_wq) {
>  		ret =3D -ENOMEM;
[ ... ]
> @@ -254,33 +256,31 @@ int intel_display_driver_probe_noirq(struct intel_d=
isplay *display)
>  		goto cleanup_wq_cleanup;
>  	}
> =20
> -	intel_dmc_init(display);
> -
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630031652.6774=
7-1-yaolu@kylinos.cn?part=3D1
