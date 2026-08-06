Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA98CC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB0710F27B;
	Thu,  6 Aug 2026 17:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jjO0TcOf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A061410F27B
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:45:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF6C360AB0;
 Thu,  6 Aug 2026 17:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384541F000E9;
 Thu,  6 Aug 2026 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786038339;
 bh=iVTYkIoaXD4DsPFBAUwZ/Ve7pvApUzD96ATmPYcwsJI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jjO0TcOff9Ur0HbDmmZ6TuNdNRagwDWCR8midXza9jcjG849mC+oUSyiclXVnjtRu
 hdTswt8s0wQXe86nPaV5mpyBLthIrtAaULtogaHc9hN4vdXQ3tJ1RGVhPgXKjx2Uuc
 geuCPRR0Rh/ej6gT0b+yObrstxtkZbj6goLht+DMz+TR2N2IcsujDyf/D9TGXUA0Et
 9Xklom34wAE/XEo+4P3+8P1oIfLqHOmJRwwSgND/rPpZj3BmnxvD+DMakZXCkDJp0r
 QFdFQGjyGqnxUj4ZgmbxCKyPP62/IXH77bZcsKEVIIweG51t1pSoTNjTRDBqz542Vk
 r2B0yDnB3gKpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/21] drm/bridge: synopsys: dw-dp: Drop useless
 reservation of first slot
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-17-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-17-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:45:38 +0000
Message-Id: <20260806174539.384541F000E9@smtp.kernel.org>
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
- [High] Sleeping functions (mutex_lock and usleep_range) are invoked from =
within the DRM bridge atomic enable/disable paths, violating atomic context=
 constraints.
--

--- Patch [17]: [PATCH v11 17/21] drm/bridge: synopsys: dw-dp: Drop useless=
 reservation of first slot ---
commit 8eeeddc14d0ae1c89dc44b8a4cd95896d24d3082
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Drop useless reservation of first slot

This patch removes the reservation of the first SDP slot in the atomic
enable path because it potentially races with audio SDP reservation. The
author mentions it is unnecessary or leftover development code, and that
slot 0 works fine without being reserved.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 31495a813e408..d8682ccdfec87 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1713,9 +1713,6 @@ static void dw_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge,
>  		return;
>  	}
> =20
> -	scoped_guard(mutex, &dp->sdp_lock)
> -		set_bit(0, dp->sdp_reg_bank);
> -
>  	ret =3D dw_dp_link_enable(dp);

[Severity: High]
This isn't a bug introduced by this patch, but this function executes durin=
g the
DRM atomic commit sequence where sleeping is strictly forbidden. While this
patch removes one instance of mutex acquisition, the remaining atomic enable
and disable paths still contain sleeping functions.

For example, dw_dp_link_enable() eventually calls dw_dp_link_train_fast() w=
hich
sleeps:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_link_train_fast() {
    ...
    usleep_range(500, 1000);
    ...
}

Other functions in the atomic path, such as dw_dp_send_sdp() and
dw_dp_bridge_atomic_disable(), also acquire the same mutex:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_atomic_disable() {
    ...
    scoped_guard(mutex, &dp->sdp_lock)
    ...
}

Can these remaining sleeping functions cause kernel warnings or deadlocks d=
uring
standard display modeset operations?

>  	if (ret < 0) {
>  		dev_err(dp->dev, "failed to enable link: %d\n", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D17
