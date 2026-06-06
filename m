Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9587DCD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 20:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B827A10E0B7;
	Sat,  6 Jun 2026 20:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WHMJXySw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD8E10E0B7
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 20:00:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DB29600AE;
 Sat,  6 Jun 2026 20:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2681F00893;
 Sat,  6 Jun 2026 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780776058;
 bh=jAb28imRu/bjJnFNC/WNdyB7LpxJe8LZ1uEGML4XQFg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WHMJXySwEGbWv7hD15SLwqbBtCcRvqgg6sA/bFuMZe7KgDYHrAJlMpABotLswr3s4
 OIGQ6rk6aUN6g/6rRfQOJAOvYtbHBFeHDmWhq9CLxkAKqDmoWO88ksUnQJeS9QcCRV
 +f4NiP7Ao7hRLlS2+rvhxdvRg8/V4OMMJruxXYh8xTXbGtlzzs4634igpY9gMfufOX
 WJCG1q/6bgN9uZcx7gzx/dKHB2ZteKZVtaSOiQyW7Cle6sNtPCOB8YCcPBqeL8bWlk
 Y3+VxM7lzzc37iAIiqZDizbc7RSXtdIrpSOTlyn0SZeCXfOF9a83pxijobiNhaadLZ
 wlUDwGTVLu4UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: replace deprecated DRM_ERROR
 macros
To: "Piyush Patle" <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606195316.28048-1-piyushpatle228@gmail.com>
References: <20260606195316.28048-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 20:00:57 +0000
Message-Id: <20260606200057.CF2681F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of the EDID buffer in `ptn3460_edid_read()` on success=
ful reads.
- [High] Race condition in bridge power state tracking (`ptn_bridge->enable=
d`).
- [High] Improper error handling of short I2C transfers leads to kernel mem=
ory disclosure.
--

commit 4e9f35dc1b32e95bb7e2572ee3b691a3841b8e02
Author: Piyush Patle <piyushpatle228@gmail.com>

drm/bridge: nxp-ptn3460: replace deprecated DRM_ERROR macros
   =20
This commit replaces DRM_ERROR() with device-aware equivalents like
drm_err() and dev_err() throughout the nxp-ptn3460 bridge driver.

> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridg=
e/nxp-ptn3460.c
> index 7acb11f16dc19..6f09c1247d7d8 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> @@ -54,13 +54,15 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *=
ptn_bridge, char addr,
> =20
>  	ret =3D i2c_master_send(ptn_bridge->client, &addr, 1);
>  	if (ret < 0) {
> -		DRM_ERROR("Failed to send i2c command, ret=3D%d\n", ret);
> +		dev_err(&ptn_bridge->client->dev,
> +			"Failed to send i2c command, ret=3D%d\n", ret);
>  		return ret;
>  	}
> =20
>  	ret =3D i2c_master_recv(ptn_bridge->client, buf, len);
>  	if (ret < 0) {
> -		DRM_ERROR("Failed to recv i2c data, ret=3D%d\n", ret);
> +		dev_err(&ptn_bridge->client->dev,
> +			"Failed to recv i2c data, ret=3D%d\n", ret);
>  		return ret;
>  	}

[Severity: High]
This is a pre-existing issue, but does this properly handle short I2C
transfers?

The i2c_master_recv() function returns the positive number of bytes
transferred on success. If a short read occurs (e.g. the hardware NACKs
mid-transfer), the return value is positive but less than len.

Because the check is only for ret < 0, a short read is incorrectly treated
as a full success, which leaves the target buffer partially uninitialized.

In ptn3460_edid_read(), this uninitialized memory is then copied by
drm_edid_alloc() and exposed to userspace, which could leak kernel memory.

> =20
> @@ -78,7 +80,8 @@ static int ptn3460_write_byte(struct ptn3460_bridge *pt=
n_bridge, char addr,
> =20
>  	ret =3D i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
>  	if (ret < 0) {
> -		DRM_ERROR("Failed to send i2c command, ret=3D%d\n", ret);
> +		dev_err(&ptn_bridge->client->dev,
> +			"Failed to send i2c command, ret=3D%d\n", ret);
>  		return ret;
>  	}

[Severity: High]
This is a pre-existing issue, but does this similarly miss short writes?

Like i2c_master_recv(), i2c_master_send() returns the number of bytes
transferred. If this is a short write, ret will be positive but less than
the requested size.

Ignoring a short write could cause silent hardware configuration failures.

[ ... ]

> @@ -166,10 +171,8 @@ static const struct drm_edid *ptn3460_edid_read(stru=
ct drm_bridge *bridge,
>  	ptn3460_pre_enable(&ptn_bridge->bridge);

[Severity: High]
This is a pre-existing issue, but is the bridge power state tracking
subject to a race condition here?

In ptn3460_edid_read(), ptn_bridge->enabled is read and then updated
by ptn3460_pre_enable() without locking.

Because ptn3460_edid_read() runs under connector->mutex while the atomic
commit tail runs bridge callbacks asynchronously, a concurrent atomic modes=
et
could disable the bridge while ptn3460_edid_read() is actively performing I=
2C
transactions.

Could this lead to hardware lockups and I2C bus hangs?

> =20
>  	edid =3D kmalloc(EDID_LENGTH, GFP_KERNEL);
> -	if (!edid) {
> -		DRM_ERROR("Failed to allocate EDID\n");
> +	if (!edid)
>  		goto out;
> -	}
> =20
>  	ret =3D ptn3460_read_bytes(ptn_bridge, PTN3460_EDID_ADDR, edid,
>  				 EDID_LENGTH);

[Severity: High]
This is a pre-existing issue, but does this function leak the edid buffer
on the success path?

Looking at ptn3460_edid_read() after the I2C read succeeds:

	drm_edid =3D drm_edid_alloc(edid, EDID_LENGTH);

out:
	if (power_off)
		ptn3460_disable(&ptn_bridge->bridge);

	return drm_edid;

The drm_edid_alloc() function uses kmemdup() to create its own copy of
the memory. Since there is no kfree(edid) before returning on success,
the original edid buffer appears to be leaked.

Since userspace can repeatedly trigger EDID reads, could this lead to
an unbounded memory leak and kernel memory exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606195316.2804=
8-1-piyushpatle228@gmail.com?part=3D1
