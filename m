Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937E5C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A9610E063;
	Fri, 14 Aug 2026 02:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JjOPcAwg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079F710E063
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:26:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AE68600B0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D081F000E9;
 Fri, 14 Aug 2026 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786674412;
 bh=2nIm3ONQo61f4xkgwHMZKcydlzS+nvMOhYdqJm8QfJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JjOPcAwgEjgMI+RL5IUNa4Qris8gASOGdA2LkQuvqLtpR/rPsV6uOY9LEbXokb6ru
 tpp3S6D8p+kFxFMWXtxYglvzPz4frEhjobNhYn1f+V1i1M7h8K+5WH+UP296PcH2ts
 X5DEd/mR2AMDyq20ua97tfbVgnMT73T8RqNbjIJNX6f99+SS8TNR0Id2CJzd2AaxVq
 2NeIaMwfgoiIrk5C9AgnWK4afqJlEo/km231APn91p5c3/Zxr6u4aVQLFr7Ox0UJUz
 MCx3uBlwdR3bkMP51M+t2Ehh7ydbIVvRHhMrTrxguylv8O77PaWOyXOUV165Ksh0uC
 8XTzR6s3lmiGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 69/78] drm/tidss: encoder: Switch to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-69-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-69-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:26:52 +0000
Message-Id: <20260814022652.B5D081F000E9@smtp.kernel.org>
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
- [Low] Incomplete API migration in the tidss driver leaving a deprecated A=
PI in use.
--

--- Patch [69]: [PATCH v2 69/78] drm/tidss: encoder: Switch to atomic_creat=
e_state ---
commit 4b163072222fe41ca874889e053936b933e75ded
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: encoder: Switch to atomic_create_state

This commit updates the tidss driver to replace the deprecated atomic_reset
callback with atomic_create_state for the bridge functions.

> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tids=
s/tidss_encoder.c
> index 34db8d2a3792e..698f8d964ca00 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.c
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.c
> @@ -76,7 +76,7 @@ static int tidss_bridge_atomic_check(struct drm_bridge =
*bridge,
>  static const struct drm_bridge_funcs tidss_bridge_funcs =3D {
>  	.attach				=3D tidss_bridge_attach,
>  	.atomic_check			=3D tidss_bridge_atomic_check,
> -	.atomic_reset			=3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state			=3D drm_atomic_helper_bridge_create_state,

[Severity: Low]
Does this migration also need to update tidss_oldi_bridge_funcs in
drivers/gpu/drm/tidss/tidss_oldi.c?=20

Looking at the driver, it appears that struct still uses the deprecated
atomic_reset callback:

drivers/gpu/drm/tidss/tidss_oldi.c:tidss_oldi_bridge_funcs {
        ...
        .atomic_reset =3D drm_atomic_helper_bridge_reset,
        ...
}

Should this be updated to atomic_create_state as well to completely remove
dependencies on the deprecated API from the tidss driver?

>  	.atomic_duplicate_state		=3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state		=3D drm_atomic_helper_bridge_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D69
