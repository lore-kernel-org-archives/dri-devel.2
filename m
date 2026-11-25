Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39B606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVfClb3M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2401710E91F;
	Wed, 25 Nov 2026 16:03:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA53710E91F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:03:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32E6962F86;
 Wed, 25 Nov 2026 16:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B131F000D4;
 Wed, 25 Nov 2026 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795622581;
 bh=HjAGZwudmC4b7RpOkzNSCKon4LaPQdqgjhPJAY4djKQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CVfClb3MDESfa506Z/7T0vyW1zTUBM9vYbJeqe1eCYnFlUZHNUCot/KnHH78pXG0m
 4nLci2/f6eejfvCFzWjNaYMQenWCLKQ/dIpaD2is9QNx4Jqcg1S46r+7dZ40G0OJLJ
 UfiylWPLeQwjxwa+C0Aiy6i3oxkmZ7z3jeT5WwjjqLBF541tmXelKdrUyyDrgChYuc
 7LcZ/AtQZ1H00zuXZ+AJTjKZ3m4F1Ys36gJTWlO+XDQdBrHizxAjM1/zjd6JNmBl86
 zSRTR6gtU0iXjJqe7SKFJUVoiC/MO21sPd8koQN6/gb+QLm9mUP0CdoCkekqJ79xAI
 +4vE315GYdEuQ==
Message-ID: <sashiko-outbox-233697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/bridge: analogix_dp: Propagate errors from
 runtime resume
To: "Nikita Zhandarovich" <n.zhandarovich@fintech.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125153958.1349811-4-n.zhandarovich@fintech.ru>
References: <20261125153958.1349811-1-n.zhandarovich@fintech.ru>
 <20261125153958.1349811-4-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:03:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/bridge: analogix_dp: power_on() error check breaks Exynos
  DP AUX
--

commit b5122fa2090e46cf82c87fc8f96ad53a322e3824
Author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

drm/bridge: analogix_dp: Propagate errors from runtime resume

This commit checks return values from plat_data->power_on(), phy_set_mode(),
and phy_power_on() in analogix_dp_resume(), unwinding platform power and
disabling dp->clock on error.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 4d3d72476dd95..9228655893a0b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1539,15 +1539,30 @@ int analogix_dp_resume(struct analogix_dp_device =
*dp)
>  		return ret;
>  	}
> =20
> -	if (dp->plat_data->power_on)
> -		dp->plat_data->power_on(dp->plat_data);
> +	if (dp->plat_data->power_on) {
> +		ret =3D dp->plat_data->power_on(dp->plat_data);
> +		if (ret)
> +			goto err_disable_clk;
> +	}

[Severity: High]
Does aborting analogix_dp_resume() on a non-zero return from
dp->plat_data->power_on() break DP AUX access on Exynos DP before a CRTC is
attached?

On Exynos DP, dp->plat_data.power_on is exynos_dp_poweron(), which calls
exynos_dp_crtc_clock_enable():

drivers/gpu/drm/exynos/exynos_dp.c:exynos_dp_crtc_clock_enable() {
	...
	if (!encoder->crtc)
		return -EPERM;
	...
}

Because encoder->crtc is NULL until an atomic modeset binds a CRTC to the
encoder (and becomes NULL again when the display is disabled), runtime
resume triggered by analogix_dpaux_transfer() now fails with -EPERM,
skipping phy_power_on() and analogix_dp_init_dp() and breaking AUX bus
panel population at probe time as well as pre-modeset EDID reads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125153958.1349=
811-1-n.zhandarovich@fintech.ru?part=3D3
