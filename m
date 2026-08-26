Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC09C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EFA10E599;
	Wed, 26 Aug 2026 21:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VH6HEusZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BD810E599
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:34:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D65860254;
 Wed, 26 Aug 2026 21:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3601F000E9;
 Wed, 26 Aug 2026 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780063;
 bh=3Z+TOG5Rh5YlDZWpoHDP6cY6zGzDvBLg2eGUzPce8ns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VH6HEusZEaxgu0eWaoIpL8VoV/rEuEj0zggZ3is8GMZVbUIUwJbyBVwK4yMnkBjts
 fbhOPT3MkU9KKPks92hlFFUBFvQySsOWNUirMhdTKg9ZSqSNY6MfS1Kjzn5RAC+rBT
 t6LUhPqHA7ADcuukayug0dY34eM25OBxurOUmmh3Qi7km9nhmSu80Gtr2s3v6XfiCf
 19OftWyTZyLtsO46gE7TGRvjMDrSgJ94YS0E3zE+DoaBzr7H3wC0PRUlsMHBbkIASd
 UW4vZoIMYKpXXZRrUX/W15Y6D0xnxMERSWJEfLCsxpR6Z6xOrY+R6oYPC9pGtendZg
 /Xs2oeVNnTi2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-10-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-10-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:34:23 +0000
Message-Id: <20260826213423.8E3601F000E9@smtp.kernel.org>
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
- [Medium] The debugfs reset knob silently fails when CONFIG_PM is disabled=
 or when runtime PM is disabled for the device.
--

commit 306a309307e2e6679d0d0021abfa0cde0b693759
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This commit introduces a new debugfs interface to manually schedule a GPU
reset. This allows developers to test potential races between the reset
sequence and other hardware register accesses.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> @@ -599,9 +600,46 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
>  };
> =20
>  #ifdef CONFIG_DEBUG_FS
> +static int reset_get(void *data, u64 *val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +
> +	*val =3D atomic_read(&pfdev->reset.pending);
> +	return 0;
> +}
> +
> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_if_in_use(pfdev->base.dev);
> +
> +	if (ret > 0) {

[Severity: Medium]
Does this strict condition handle configurations where power management is
disabled?

If the kernel is built without CONFIG_PM, or if runtime PM is disabled for
the device, pm_runtime_get_if_in_use() returns -EINVAL. Because the check
requires the return value to be strictly greater than 0, it will silently
skip the block.

Could this cause the debugfs reset knob to fail silently on these
configurations, making the testing capability unavailable without any
indication to the user?

> +		panfrost_device_schedule_reset(pfdev);
> +		flush_work(&pfdev->reset.work);
> +		pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D10
