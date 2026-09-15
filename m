Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04184C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D8910E262;
	Tue, 15 Sep 2026 21:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aBf4NVPp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2DC10E262
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:17:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB1E640597;
 Tue, 15 Sep 2026 21:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9409E1F00893;
 Tue, 15 Sep 2026 21:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789507047;
 bh=Kk9SLsv0fNNfWd47WJQCIpWkgR/ipvdbi5Km3j3cQ28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aBf4NVPpfQxSKs0OMU++ugGqONbYPMYBPadJ82yJHRbuRK1jRRQPv72U6R4Lwyfal
 C3UhEv7AoQDqHpQII99F9qqmAr8T9xue0fdx8Mdxmiql0ba9w04VetzPh9zTUjONrC
 lvLWnoqxodw9aFEaxH38WyqxXBk1A0BZ6yrtC9B27jCIZKzKujQB5wr6A7WNk3H1q3
 hIaBAS8293XLpD4NKZf4hluNPx3ctCC+i7Ug0BPHOwGFTwLF0u8A7QaHNDDJkl91uz
 2Vf+DzESSiaMuaUI7tprahR4KUALiUa918KpaQ3ezLhWr8BeQPMptfbz9IcSrU7qpG
 YXMu8BE98eqcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915210647.695187-2-lyude@redhat.com>
References: <20260915210647.695187-1-lyude@redhat.com>
 <20260915210647.695187-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:17:27 +0000
Message-Id: <20260915211727.9409E1F00893@smtp.kernel.org>
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
- [Medium] nouveau: nvif_device_gcx_ready negative error codes handled as b=
itmask
--

commit 181d7ad17939e59149b939f631f63cac7294478a
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE

This commit adds support for querying the GSP to see if the GPU is ready
to enter Gc6 and/or GcOff before runtime suspending. If the GPU is not
ready, the runtime suspend process is delayed.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -1164,6 +1165,14 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
> =20
> +	/* Check if the GPU itself is ready for runtime suspend, otherwise mark=
 as busy and check
> +	 * again in a bit. */
> +	if (!(nvif_device_gcx_ready(nvif) & NV_DEVICE_GCOFF_READY)) {
> +		NV_DEBUG(drm, "GPU isn't ready for suspend yet, delaying...\n");
> +		pm_runtime_mark_last_busy(dev);
> +		return -EBUSY;
> +	}
> +

[Severity: Medium]
Should this check for a negative error code before applying the bitmask?

The nvif_device_gcx_ready() function can return negative error codes
if the underlying RPC call fails. Because this returned integer is
directly bitwise ANDed with NV_DEVICE_GCOFF_READY (which is BIT(1)),
the two's complement representation of a negative error code will yield
an arbitrary true or false result depending on its specific bit pattern.

For example, if an error returns -EINVAL (-22), bit 1 is set. The bitwise
check evaluates to true, which bypasses the delay and unsafely puts the
GPU to sleep. Alternatively, if the error is -ENOMEM (-12), bit 1 is
cleared, which evaluates to false and delays the suspend.

> diff --git a/drivers/gpu/drm/nouveau/nvif/device.c b/drivers/gpu/drm/nouv=
eau/nvif/device.c
> --- a/drivers/gpu/drm/nouveau/nvif/device.c
> +++ b/drivers/gpu/drm/nouveau/nvif/device.c
[ ... ]
> +int
> +nvif_device_gcx_ready(struct nvif_device *device)
> +{
> +	struct nv_device_gcx_ready_v0 args =3D {};
> +	int ret;
> +
> +	ret =3D nvif_object_mthd(&device->object, NV_DEVICE_V0_GCX_READY, &args=
, sizeof(args));
> +	if (ret)
> +		return ret;
> +
> +	return args.ready;
> +}

Here is where nvif_device_gcx_ready() explicitly propagates the negative
error code returned from nvif_object_mthd() on failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915210647.6951=
87-1-lyude@redhat.com?part=3D1
