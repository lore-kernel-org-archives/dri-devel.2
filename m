Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFC606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaAhySX7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFB310FBFD;
	Wed, 25 Nov 2026 12:03:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B62610FBFD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 547F840039;
 Wed, 25 Nov 2026 12:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B301F000D3;
 Wed, 25 Nov 2026 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795608175;
 bh=V9TKf4WtCTvR9I52TeH2cF3cN0LpAp6aloqNAu0lJjM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AaAhySX7+qf1R5JAquO4IkC8cLyaan5d347nQCRfVi/B45M4fCjz5oBtJj44BOlBk
 d+sMks58itm/N/LinlW4j1vHE/RmcPdodu2qMQhVEnXg9KcfSKzc3FaQGgBTseYw0Z
 gFYCVH9BrrSV8uCQyC+0pQvddkSn/kKMScpDzU0JqebxnvRA7GNHHDkwPNMZngjUQK
 594XugGSVxhhN0Vw5ux2CfBMvVx55XwtQc1lgzUphxqkTJpM7pH4UYZkYaUk2BtrSd
 q8ebMRKpG8xpkbMT9SV2OC8MT768yckuW9h5wPwcDxs30s7l1ZwdLxqOAK7it5LOwZ
 C5fo3Qv7QtCHw==
Message-ID: <sashiko-outbox-233327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/bridge: analogix_dp: Propagate errors from
 runtime resume
To: "Nikita Zhandarovich" <n.zhandarovich@fintech.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125114319.1089186-4-n.zhandarovich@fintech.ru>
References: <20261125114319.1089186-1-n.zhandarovich@fintech.ru>
 <20261125114319.1089186-4-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:02:55 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/bridge: analogix_dp: power_on() error check breaks Exynos
  DP AUX
- [Low] drm/bridge: analogix_dp: wrong Fixes trailer for
  analogix_dp_resume()
--

commit 0706ac6bd7c68642ccd0c9e6f4e7ccc36e6bc48b
Author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

> drm/bridge: analogix_dp: Propagate errors from runtime resume
>
> Stop controller initialization when platform or PHY power-on fails and
> return the original error to the resume caller. Unwind the platform
> power callback only after it has completed successfully, then release
> the controller clock. Do not call phy_power_off() after a failed
> phy_power_on(), since no successful PHY power reference was acquired.
>
> Also stop and unwind platform power if setting the PHY mode fails.
>
> Fixes: 3424e3a4f844 ("drm: bridge: analogix/dp: split exynos dp driver to=
 bridge directory")
> Fixes: 2c0883459ed6 ("drm/bridge: analogix_dp: Add support for phy config=
uration.")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[Severity: Low]
In 3424e3a4f844 ("drm: bridge: analogix/dp: split exynos dp driver to
bridge directory"), analogix_dp_resume() only called clk_prepare_enable()
and already checked and propagated its error.  The unchecked
dp->plat_data->power_on() and phy_power_on() calls in analogix_dp_resume()
were added later by 73f613908eb1 ("drm/bridge: analogix_dp: move platform
and PHY power handling into runtime PM").  Should the first Fixes tag
reference 73f613908eb1 ("drm/bridge: analogix_dp: move platform and PHY
power handling into runtime PM") instead?

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
Does aborting analogix_dp_resume() on dp->plat_data->power_on() failure
break DP AUX transfers on Exynos when no CRTC is bound to the encoder?

In this tree, the prerequisite Exynos pipe-clock conversion noted below the
--- separator is not present, so exynos_dp_poweron() still fails whenever
encoder->crtc is NULL:

drivers/gpu/drm/exynos/exynos_dp.c:exynos_dp_crtc_clock_enable() {
	struct exynos_dp_device *dp =3D to_dp(plat_data);
	struct drm_encoder *encoder =3D &dp->encoder;

	if (!encoder->crtc)
		return -EPERM;

When analogix_dpaux_transfer() calls pm_runtime_resume_and_get() before a
modeset attaches a CRTC (for example during devm_of_dp_aux_populate_bus()
at probe time or pre-modeset EDID reads in analogix_dp_bridge_edid_read()),
analogix_dp_resume() now aborts with -EPERM before powering on the PHY or
initializing the DP controller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125114319.1089=
186-1-n.zhandarovich@fintech.ru?part=3D3
