Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44532C61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1AF10E650;
	Thu, 27 Aug 2026 13:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PEd2rSx1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EC310E626;
 Thu, 27 Aug 2026 13:03:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22D03601EF;
 Thu, 27 Aug 2026 13:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973CA1F00A3A;
 Thu, 27 Aug 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787835778;
 bh=zRPQBXXcUnYAKNpJMAoxpuvic4qZ6IZ4FjiQOCplJP0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PEd2rSx1tLjzLrnHvZz7ZDeHY2x1MiiH35/vmsdxjM+tG1S07QQTvGP+AeRTudus0
 o0LHgVddmEATC+muml8Vd0xIw3j5BIPk8WB86kT0BEzqotXANUtX3E3ozFQWXCzqwv
 0LuS1bxkUzDKJPnNDDOhnEMEO/LlUNC0SlZPsmencvYHnKaZH1ms06ofK+csyYsgjQ
 AYyLxwKUgPYLHLhy1KHosq1kL+4UJGmFLLiRMHnB75mX7UR7Wr3Q/MQW7l4ed4EqA7
 ytDCMsMN+FLAEN2OokJCSWYYnQUH0C+UyioNatHcTgbOSKMuyeFrjgFG2usSVKIyoV
 xfd+bs1w2TZUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] drm/mode_config: Use dma_resv_alloc for lockdep
 annotation
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-7-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:02:58 +0000
Message-Id: <20260827130258.973CA1F00A3A@smtp.kernel.org>
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
- [Medium] Missing cleanup of drm_mode_config resources on dma_resv_alloc()=
 failure path.
--

commit 80153f7004414d9b79ec627bceffaa8edbb89641
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/mode_config: Use dma_resv_alloc for lockdep annotation

This commit replaces the stack-allocated dma_resv in the lockdep
annotation code with a dynamically allocated one using dma_resv_alloc().
If the allocation fails, it returns -ENOMEM early.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -658,10 +658,12 @@ int drmm_mode_config_init(struct drm_device *dev)
>  	if (IS_ENABLED(CONFIG_LOCKDEP)) {
>  		struct drm_modeset_acquire_ctx modeset_ctx;
>  		struct ww_acquire_ctx resv_ctx;
> -		struct dma_resv resv;
> +		struct dma_resv *resv;
>  		int ret;
> =20
> -		dma_resv_init(&resv);
> +		resv =3D dma_resv_alloc();
> +		if (!resv)
> +			return -ENOMEM;

[Severity: Medium]
Does returning -ENOMEM here leak the drm_mode_config resources?

Since drmm_add_action_or_reset() hasn't been called yet to register the
managed cleanup action, should this failure path call
drm_mode_config_cleanup() before returning, similar to how it is handled
earlier in drmm_mode_config_init() when drm_mode_create_standard_properties=
()
fails?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D6
