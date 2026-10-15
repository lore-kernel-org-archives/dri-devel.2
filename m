Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCBCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562A010E0A7;
	Thu, 15 Oct 2026 15:59:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB8F10E0A7
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:59:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B673F60120
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053C1F000C4;
 Thu, 15 Oct 2026 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792079972;
 bh=OqfcDI535G5KJe84WxecOVU8rlFikjp9cRDocSP3nnY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aDRTx3vfOsnfO1gMEbTHHRnX81dqmIecAxA8pkHw+woZwKyN4Mjrj+NqEPW6mdQwF
 soiZ1e+yR3gqgyzN+lnNM4QRS2qqoeZ9w56IRLcUqx2ZBRoa9DtOh/af3gNBsV+uSC
 edxJCylwETkJxkO8NIauuQuHefUXStgzzOX9EPFXEJfvGdiZePYmo4rTCKKL4diqgo
 5K4qv8UhHnncJWE1k90tKREGnEYq51S8TR+61+K7MEkbE/9jzdrirCBRC8Y0nTiXAs
 403ukcDisqhOxJVTmcY03CkhCdHrHD1i1cpHsgVRgPfX5EJuoMmawZJZghCoOOUaQe
 WdiZ1ubutFvjQ==
Message-ID: <sashiko-outbox-173120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/28] drm/atomic_sro: Create documentation
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-10-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-10-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:59:31 +0000
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
- [Medium] drm: atomic_sro_install_state API forces drivers to ignore falli=
ble resource acquisition errors
--

commit 5d8a38d52cf88932aa75f1dc6ea53c59a6c116b9
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Create documentation

This commit adds documentation for the State Read-Out (SRO) infrastructure.
It explains how drivers should integrate with the SRO phases to initialize
KMS atomic state from the hardware state left by the firmware at boot.

> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> index 14fddd7601658..6cd002e857d98 100644
> --- a/drivers/gpu/drm/drm_atomic_sro.c
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
> @@ -14,6 +14,37 @@
>  #include "drm_internal.h"
>  #include "drm_crtc_internal.h"
> =20
> +/**
> + * DOC: overview

[ ... ]

> + * The second phase is the installation. Once all states have been read
> + * out, drm_atomic_sro_install_state() walks through the
> + * &struct drm_atomic_sro_state and assigns each readout state as the
> + * object's current state. Before doing so, it calls the optional
> + * atomic_sro_install_state hook on each object. This gives drivers a
> + * chance to acquire the resources needed to keep the hardware state
> + * active, such as power domains, clocks, or interrupts. This hook
> + * cannot fail.

[Severity: Medium]
By designing the atomic_sro_install_state hook so it cannot fail, does this
API force drivers to silently ignore fallible resource acquisition errors?

Resource acquisitions like clk_prepare_enable and pm_runtime_get_sync can
fail due to temporary resource issues. If a clock or power domain enable
fails when the infrastructure calls atomic_sro_install_state, the driver
cannot propagate the error.

Could this lead to a situation where the DRM core installs the state and
proceeds as if the display is active, while the underlying hardware remains
unclocked or unpowered, potentially causing a hardware lockup or system
crash on subsequent register access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D10
