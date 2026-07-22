Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1E8C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B3910EE75;
	Wed, 22 Jul 2026 19:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eTFfIjru";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F6510EE75
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:11:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 478AE40E39;
 Wed, 22 Jul 2026 19:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5201F00A3A;
 Wed, 22 Jul 2026 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784747513;
 bh=vL5nPh4o6MXCf/s+NtMF2bC3ljo2mQx+oVudDkpVEgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eTFfIjru/QUItuXKr9qQlwnI7sN+nzt2YWlGOisSrneiJwZ0iOOgDvu5C3C9d3ndl
 dsZ+cYF27mnoIkFq/qWMspyMkK0xD3ZuuFNBErjNmZfuLPW5e3M8jU9sTrA59u81g2
 hArACttRwEY79r3FF8848n25tg8JUVB8VRp1nC8AOWyrezZiBF1KnnRca6Qrb4PqeR
 kP28VpouFGaFi0tqx2rCUVFpf4g8ZG4d+cyvYjvT3KKAsg4ItdrJ04wN7d5XbJsaTv
 cyda4nRMs0AxZP7OMQfqHJAxUcJZSmi1Kl5SPRpraldcY+4SMKRm6QFNJvoEd03Rtx
 OIxNjJJ7awZYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/exynos: remove simplefb nodes before init
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-exynos-dsim-fixes-v3-3-0c31ae1dbecc@disroot.org>
References: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
 <20260723-exynos-dsim-fixes-v3-3-0c31ae1dbecc@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 19:11:52 +0000
Message-Id: <20260722191153.0A5201F00A3A@smtp.kernel.org>
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
- [Medium] Mismatch between commit message intent and code ordering for rem=
oving conflicting framebuffers.
--

--- Patch [3]: [PATCH v3 3/3] drm/exynos: remove simplefb nodes before init=
 ---
commit 7166a20a30c24daba54ef2dcd52625f999da3053
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/exynos: remove simplefb nodes before init

The simple-framebuffer uses the framebuffer region initialized by the
boot loader for display. However, with Linux the DSI and FIMD/DECON
stack is initialized from scratch.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.c
> index 9ee30086879f9..7657f86a9d19d 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
[ ... ]
> @@ -273,6 +274,11 @@ static int exynos_drm_bind(struct device *dev)
>  	if (ret)
>  		goto err_mode_config_cleanup;
> =20
> +	/* Remove existing devices which own the framebuffer memory. */
> +	ret =3D aperture_remove_all_conflicting_devices(exynos_drm_driver.name);

[Severity: Medium]
Does this code match the sequence described in the commit message?

The commit message explicitly states that "the framebuffer must be destroye=
d,
which releases the memory region, followed by proper IP re-initialization."

However, looking at exynos_drm_bind(), this call to
aperture_remove_all_conflicting_devices() happens right after
component_bind_all(). Since component callbacks like fimd_bind() reset the
hardware IPs, the IP re-initialization is actually happening before the
conflicting framebuffer device is removed.

Should the framebuffer removal happen before calling component_bind_all()
instead?

> +	if (ret)
> +		goto err_unbind_all;
> +
>  	ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-exynos-dsi=
m-fixes-v3-0-0c31ae1dbecc@disroot.org?part=3D3
