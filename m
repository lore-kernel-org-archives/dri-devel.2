Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D546606A324
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hx323KDK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB3210E436;
	Thu, 12 Nov 2026 04:50:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80E410E436
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 04:50:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 889C440D60;
 Thu, 12 Nov 2026 04:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2554B1F00A05;
 Thu, 12 Nov 2026 04:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794459014;
 bh=HIRt5B5nNQh55PESYhR+4DreZOkc2TtI2/Vumccg6fY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hx323KDKyC0rBry7lHkbUg9FOHEoMFSkwXOno3MvjpeGC3Zo7HgL7ENg42+IaBN2B
 2Edr7QfXrrIn2BeiNNfJ1JtfW510w4Rjv9zXM065SwhIswvfqx9S3uHfO3bQi7leeA
 05iMocDihZdOqxcguhaGCSQagpA5zi4ExzInxk7muDsd3GDYgAIorc0Wyzbkl2kjc6
 NMjGBM/Bcsogkj81rFKj7mHLVHCTfxIJWNGxQo20k+ENRe/sIF/CpxE8i/kFYYoJdc
 wW39ZhcTCjjsy4WZjz6i7wX3b0vVUtP/MVq7yAvLSvLivL6mGPeeahaf3gHT2pE44L
 AkNV8+95U9q8g==
Message-ID: <sashiko-outbox-210396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] drm/msm: mdss: Add SM7250 support
To: "Ishu Brar" <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261112-dpu-sm7250-v2-6-8e925a3a8a7d@brar.si>
References: <20261112-dpu-sm7250-v2-0-8e925a3a8a7d@brar.si>
 <20261112-dpu-sm7250-v2-6-8e925a3a8a7d@brar.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:50:13 +0000
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
- [High] drm/msm: mdss: missing qcom,sm7250 UBWC config breaks
  msm_mdss_init()
--

commit d4f3819a63c8f3f76b2bc3a988c5686bff7ac892
Author: Ishu Brar <patches@brar.si>

drm/msm: mdss: Add SM7250 support

This commit adds the qcom,sm7250-mdss compatible entry to mdss_dt_match.

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index 259d362475c81..8097e8f9144e4 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -563,6 +563,7 @@ static const struct of_device_id mdss_dt_match[] =3D {
>  	{ .compatible =3D "qcom,sm6350-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm6375-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm7150-mdss", .data =3D &data_76k8 },
> +	{ .compatible =3D "qcom,sm7250-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm8150-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm8250-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm8350-mdss", .data =3D &data_74k },

[Severity: High]
Does qcom_ubwc_configs in drivers/soc/qcom/ubwc_config.c also need a
qcom,sm7250 entry?

Both mdss_probe() -> msm_mdss_init() and dpu_kms_hw_init() call
qcom_ubwc_config_get_data() and abort on error.  Because qcom_ubwc_configs
has no entry for qcom,sm7250, of_machine_get_match_data() returns NULL and
qcom_ubwc_config_get_data() fails with -EINVAL, preventing MDSS and DPU from
probing on SM7250.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-dpu-sm7250=
-v2-0-8e925a3a8a7d@brar.si?part=3D6
