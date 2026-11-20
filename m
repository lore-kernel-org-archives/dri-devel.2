Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081A606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDpLI2ih
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EFF10E8EF;
	Fri, 20 Nov 2026 13:34:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368A710E8EF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:34:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 587DC60F89
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0881F000D1;
 Fri, 20 Nov 2026 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795181677;
 bh=44Z2yfcfNHzClDqIZC+POhkew1sOtaWKluOUr8ddRo0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XDpLI2ihmrjIJrIlcx/lF0R0XemgIKumEpyQ/PMqHH0X/JH7dT8gvWx5fiXbBzx7G
 cK/lLX+sQtuqbWSXrKDlMYFes92HzBx5qN5oHNcT5RgjQdRamcn1ImpY4pNFwNZ2mB
 jnJav6v9/5ohqYbwyJfySR8ReGtq1QRcPrk0ClLp099zD7mF+WkV5Uy1TsV9B5HOSY
 S5SK3u9Nqro8DNeFEOgMYbmX4FUjWpGFwyi1T87K1iMwbYIbDLzLPuSacGTc3ceDrZ
 /oV3shp8zmS0NeTwjjiGGNIK4PKCfsTG+x5LMSuvcSZIqBenbFKuP8jlo6Rso+lRSp
 X8eQncjsmTUYA==
Message-ID: <sashiko-outbox-225252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH DO NOT MERGE v9 41/42] drm/tidss: oldi: Implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-41-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-41-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:34:36 +0000
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
- [Medium] drm/tidss: unchecked tidss_runtime_get() in
  tidss_oldi_read_config()
--

commit a65bf8e1088f5e847af4ee39d253fd55598fe32e
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: oldi: Implement hardware state readout

This commit implements the atomic state readout and connector readout
hooks for the tidss OLDI bridge.

> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/t=
idss_oldi.c
> index f767b0c115ac3..0ad4ef34ba640 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
[ ... ]
> @@ -350,6 +355,154 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
> =20
> +static u32 tidss_oldi_read_config(struct tidss_oldi *oldi)
> +{
> +	u32 cfg;
> +
> +	tidss_runtime_get(oldi->tidss);
> +	cfg =3D tidss_get_oldi_config(oldi->tidss, oldi->parent_vp);
> +	tidss_runtime_put(oldi->tidss);
> +
> +	return cfg;
> +}

[Severity: Medium]
Should tidss_oldi_read_config() check the return value of
tidss_runtime_get()?

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which drops the
runtime PM usage reference when resume fails.  If it fails,
tidss_get_oldi_config() reads DISPC_VP_DSS_OLDI_CFG while the DSS is
still suspended, and tidss_runtime_put() decrements the usage count a
second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D41
