Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ABCC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 03:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F1E10E36F;
	Sat,  8 Aug 2026 03:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mgbbkoOM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54B810E36F
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 03:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF0696001A;
 Sat,  8 Aug 2026 03:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9131F000E9;
 Sat,  8 Aug 2026 03:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786161329;
 bh=H0hpVNGdwY+MKDSXjIanPJ3zDQ/nz1TnJlOa+9/HRqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mgbbkoOM44sujeRC850pLwvwlGguPYVZB1GAQ++ZqncWD6vSYuZXP5Q4k557xCKCo
 O3hS7qbE//Q1CakZC7RPzfRHeHH23WI2W4VsT0oyTnQN8SxTYA2kVdv5XVfm04zkr5
 dncedapKfPBIQPyh6bAknxyleBe1rThEkabO4VkDQsR3BRjqT6//swkUdvlqhKT4i8
 flfIyKcTIs2rA4xuIWx9h1HQXaQoqsCik6VhFoiIt1VKzSGC//cVdN/12BiqdXaNVH
 WFw8FxYFspg50Tun8M87KA+Q0kvCjrjzH/drhyuy6kJe9t7LwCSkeXO1yvvvufwPZq
 v5CE+pTKyMHYA==
From: sashiko-bot@kernel.org
Subject: Re: [REGRESSION] qcom PAS TZ API migration breaks GPU and modem on
 TrustZone without PAS (sc7180 trogdor)
To: "Paul Hollinsky" <phollinsky@holtechnik.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808034716.58888-1-phollinsky@holtechnik.com>
References: <20260808034716.58888-1-phollinsky@holtechnik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 03:55:28 +0000
Message-Id: <20260808035529.4E9131F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `of_node_put()` for the device node returned by `of_get_av=
ailable_child_by_name()` causes a reference leak.
- [High] Unratelimited log spam and invalid `-EPROBE_DEFER` return to users=
pace on DRM open.
--

--- Patch [1]: [REGRESSION] qcom PAS TZ API migration breaks GPU and modem =
on TrustZone without PAS (sc7180 trogdor) ---
commit d49d60f9528ef181555257c9db8b08e995f71893
Author: Paul Hollinsky <phollinsky@holtechnik.com>

qcom PAS TZ API migration breaks GPU and modem on TrustZone without PAS (sc=
7180 trogdor)

This commit fixes boot failures on SC7180 Chromebooks caused by a recent TZ=
 API
migration. It restores SCM availability checks for the modem and delays the=
 PAS
check for the GPU until after discovering the zap-shader device tree node.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 8cd2020d4b7e9..ca5e4e560cded 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -52,6 +52,12 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, co=
nst char *fwname,
>  		return -ENODEV;
>  	}
> =20
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(dev, "PAS is not available\n");
> +		return -EPROBE_DEFER;
> +	}
> +
>  	ret =3D of_reserved_mem_region_to_resource(np, 0, &r);

[Severity: High]
This is a pre-existing issue, but does this early return in
zap_shader_load_mdt() leak the device node reference?

The np pointer is obtained via of_get_available_child_by_name() just before
this block, which increments the reference count. However, of_node_put(np) =
is
never called before returning -EPROBE_DEFER.

Because zap_available remains true, an unprivileged user can repeatedly open
the DRM device and trigger this error path on every call. Can this result in
an unbounded device node reference leak?

[Severity: High]
This is also a pre-existing issue, but does this unratelimited DRM_DEV_ERROR
in zap_shader_load_mdt() allow an unprivileged user to spam the kernel log =
by
repeatedly calling the DRM open syscall?

Furthermore, is it appropriate to return -EPROBE_DEFER here? Since this
function is reached during the DRM open syscall and not during the device
probe sequence, this propagates an internal driver core deferral code direc=
tly
to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808034716.5888=
8-1-phollinsky@holtechnik.com?part=3D1
