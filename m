Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B3C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60F310EF06;
	Thu, 23 Jul 2026 00:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JDCJZCnQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F30C10EF1B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:54:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0C97600E1;
 Thu, 23 Jul 2026 00:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F01F000E9;
 Thu, 23 Jul 2026 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784768092;
 bh=7a+5ud8CPt2otmTC1QtMOUqRvGL5uYkledr9yBCS3V4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JDCJZCnQaEEm3j4Tmdr9jYQ4v+9cdOPIEDjjM3YqFujEjiVXAXDHpz0B7up7EnVUu
 9NYMlg/AICW+y9CKJeLflIuxMoeR12idqtfV+MvLGrUQ8KaR9y8dlpgZjLstE41x6H
 0erYWvXOhU5OpgH+W7w+0g49K9Zq0hv8kXthxTnRmjQCTLc+qSqUGHmjeUKst475Pp
 4C+JoQRRx7vypqCixxj1SvfbVJ9fS1Zxe9qG9DP3ub7NkG0lT4IAyAZymmNusGfS5h
 q9P5l7FOGfudi9VckFYHM1c2DypS6HZ2j5+3FVMVc7BMJjum3oKHyIsp+1d/cz+hdQ
 Jx8QMx+M4Uw0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] drm/amd/display: use drmm allocation for
 writeback connector
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723003205.330362-3-John.Harrison@Igalia.com>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
 <20260723003205.330362-3-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:54:51 +0000
Message-Id: <20260723005452.2E0F01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Double-free and Use-After-Free of `aencoder` and `aconnector` obje=
cts in the error path of `amdgpu_dm_initialize_drm_device`.
--

--- Patch [2]: [PATCH v8 2/8] drm/amd/display: use drmm allocation for writ=
eback connector ---
commit eb7f6e488f88ce78a34b3146c10bca2e0792ad3e
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/amd/display: use drmm allocation for writeback connector

Currently memory used for writeback connectors isn't freed on driver
unbinding, leaking the memory. Use drm_device-memory allocation
function for the writeback connector, making sure that the memory is
freed on the driver unbinding.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f8d8132ea50ed..289da9d00b056 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -2621,7 +2622,7 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
>  		link =3D dc_get_link_at_index(dm->dc, i);
> =20
>  		if (link->connector_signal =3D=3D SIGNAL_TYPE_VIRTUAL) {
> -			struct amdgpu_dm_wb_connector *wbcon =3D kzalloc_obj(*wbcon);
> +			struct amdgpu_dm_wb_connector *wbcon =3D drmm_kzalloc_obj(adev_to_drm=
(adev), *wbcon);
> =20
>  			if (!wbcon) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connec=
tor\n");
> @@ -2630,7 +2631,6 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
> =20
>  			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback conn=
ector\n");
> -				kfree(wbcon);
>  				continue;
>  			}

[ ... ]

>  	return 0;
>  fail:
>  	kfree(aencoder);
>  	kfree(aconnector);

[Severity: High]
This isn't a bug introduced by this patch, but could this error path lead t=
o a
use-after-free and double-free?

If amdgpu_dm_encoder_init() succeeds, it registers aencoder into the
device's encoder list. If a failure occurs later (for example, in
amdgpu_dm_connector_init() or when registering IRQ handlers), the code jumps
to the fail label and unconditionally calls kfree(aencoder) without
unregistering it.

Additionally, if an allocation fails in a subsequent loop iteration:

		aconnector =3D kzalloc_obj(*aconnector);
		if (!aconnector)
			goto fail;

The aencoder pointer still holds the successfully registered object from
the previous iteration, which is then erroneously freed again.

When the device initialization fails, the DRM subsystem tears down the devi=
ce
via drm_mode_config_cleanup(), which iterates over the encoder and connector
lists and calls their destroy callbacks. These callbacks will dereference t=
he
previously freed memory (use-after-free) and call kfree() on it again
(double-free).

Would it be safer to update this error path to clean up properly, or perhaps
use drmm_ managed allocations for these objects as well?

>
>  	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723003205.3303=
62-1-John.Harrison@Igalia.com?part=3D2
