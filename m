Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349F606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZ5Jxm6G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4AE10E7CA;
	Wed, 18 Nov 2026 10:46:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA8D10E53B;
 Wed, 18 Nov 2026 10:45:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 594E7620D7;
 Wed, 18 Nov 2026 10:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A101F000C4;
 Wed, 18 Nov 2026 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794998755;
 bh=YDSF4vMnZxyCsRB/mXgxAU9tjokM+Rr45Uv6HTlpgb0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IZ5Jxm6GDwN9SauXSocsxFt4WrGBsXgXqdOd7/AEzxMjHCnD8TzTeyWOKiCMlwTFT
 mH9nEYi9gUfnCRRjzmyrbvO3R4kBvPgdFrXW9/MI2tZGxbIIUUnBrqy+BKXYa6aJqE
 Qxt1LSzyO274UewCixWmpF1D5naTuBqR2nbZ9cp0yG3BFdnnstVMt1ZM/DA9D/dBbq
 Jj+9ppOqTtaj/L66PUI1IU6Nj9RS8GjGK/zI7+OOzlMDDrdvAu4PV6XwA2JrYyxp8o
 QwRmaXMtvVrbzb0K6UTavTAetq1CPnNzI5tkYAI/UyazHqQ1yEtlxIhMtt0Ett1LHY
 VOL6R194Azc7g==
Message-ID: <sashiko-outbox-220741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] drm: Move DSC capability reading helper out of i915
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261118-feat_move_i915_helper-v1-8-652177f3107a@bootlin.com>
References: <20261118-feat_move_i915_helper-v1-0-652177f3107a@bootlin.com>
 <20261118-feat_move_i915_helper-v1-8-652177f3107a@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:45:54 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/dp: kernel-doc function name mismatch for
  drm_dp_dsc_read_dpcd()
--

commit 383d83dc14220cf2fa31928b2396a83fa5b46bff
Author: Kory Maincent <kory.maincent@bootlin.com>

drm: Move DSC capability reading helper out of i915

This commit moves the DSC DPCD capability reading helper from the i915
driver into the generic DRM DisplayPort helpers as drm_dp_dsc_read_dpcd().

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index fc3d4db1c7639..06bf7a6ec8934 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -5144,3 +5144,33 @@ int drm_dp_read_edp_sink_rates(struct drm_dp_aux *=
aux, u8 edp_dpcd_rev,
>  	return num_sink_rates;
>  }
>  EXPORT_SYMBOL_GPL(drm_dp_read_edp_sink_rates);
> +
> +/**
> + * drm_dp_read_dsc_dpcd() - read the DSC capabilities from the DPCD
> + * @aux: DisplayPort AUX channel
> + * @dsc_dpcd: Buffer to store the DSC capabilities read from the DPCD
> + *
> + * Attempts to read the sink DSC capabilities from the DPCD of @aux.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int drm_dp_dsc_read_dpcd(struct drm_dp_aux *aux,
> +			 u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])

[Severity: Low]
Should the kernel-doc header name drm_dp_dsc_read_dpcd() instead of
drm_dp_read_dsc_dpcd() to match the function definition and avoid a W=3D1 /
htmldocs kernel-doc warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-feat_move_=
i915_helper-v1-0-652177f3107a@bootlin.com?part=3D8
