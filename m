Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF57606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JewtO0RC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4362B10E02A;
	Sat, 31 Oct 2026 08:10:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2531110E02A
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 08:10:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 105E8600C8;
 Sat, 31 Oct 2026 08:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5131F000C1;
 Sat, 31 Oct 2026 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793434233;
 bh=7eA8chfB+Xh27aL92koSgHTWRDI0JRvJKB98b8OjBiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JewtO0RCEY4cMELGYaOn0QGj2w7K5cPVItLWaItD/Iog6BkQjGAqwpMz8kaMGub5g
 5V+qVfUq6G/YuhgZSUYNtTcf7aSrJ3o2IDoWljcsmeSCVk6lWJaut4Z8QGqySIhCaa
 dOsgbkL6juaov/mL7Er950ndjLXkr/q78IrDd7xa62tQU+WItOOI03a6cESrfwi7zZ
 KLdTFn0yMc4KahA06IhFy6MufvIxOm0e06n/MnvItOpWDJdbd6kWqBsw5G/IfjMzv6
 3ppO1d79LcBJRqEwyX6R6sAMwMBbEm682ip8UAi26XY+VxvO8z5lh4s2na/buspkoL
 Et8yzFQNj8SSA==
Message-ID: <sashiko-outbox-191820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/msm: mdss: Add SM7250 support
To: "Ishu Brar" <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261031-dpu-sm7250-v1-5-159f403ec405@brar.si>
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
 <20261031-dpu-sm7250-v1-5-159f403ec405@brar.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:10:33 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: mdss: missing qcom,sm7250 UBWC config breaks msm_mdss_ini=
t()
--

commit 0057475d95677bf9a33c044b3beaf8c21ba53ed1
Author: Ishu Brar <patches@brar.si>

drm/msm: mdss: Add SM7250 support

This commit adds the qcom,sm7250-mdss compatible entry to mdss_dt_match[]
to enable MDSS support on SM7250 platforms.

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index e69b122f2687a..f619052bbb463 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -562,6 +562,7 @@ static const struct of_device_id mdss_dt_match[] =3D {
>  	{ .compatible =3D "qcom,sm6350-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm6375-mdss", .data =3D &data_76k8 },
>  	{ .compatible =3D "qcom,sm7150-mdss", .data =3D &data_76k8 },
> +	{ .compatible =3D "qcom,sm7250-mdss", .data =3D &data_76k8 },

[Severity: High]
Will mdss_probe() and dpu_kms_hw_init() fail with -EINVAL on SM7250 because
qcom,sm7250 is missing from qcom_ubwc_configs[]?

During probe, mdss_probe() -> msm_mdss_init() requires a valid UBWC
configuration:

drivers/gpu/drm/msm/msm_mdss.c:msm_mdss_init() {
	...
	msm_mdss->mdss_data =3D qcom_ubwc_config_get_data();
	if (IS_ERR(msm_mdss->mdss_data))
		return ERR_CAST(msm_mdss->mdss_data);
	...
}

Similarly, dpu_kms_hw_init() in drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
calls qcom_ubwc_config_get_data() and aborts on error:

drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:dpu_kms_hw_init() {
	...
	dpu_kms->mdss =3D qcom_ubwc_config_get_data();
	if (IS_ERR(dpu_kms->mdss)) {
		rc =3D PTR_ERR(dpu_kms->mdss);
		DPU_ERROR("failed to get UBWC config data: %d\n", rc);
		goto err_pm_put;
	}
	...
}

Because DRM_MSM selects QCOM_UBWC_CONFIG, qcom_ubwc_config_get_data() in
drivers/soc/qcom/ubwc_config.c matches the root machine compatible against
qcom_ubwc_configs[] via of_machine_get_match_data() and returns
ERR_PTR(-EINVAL) when no entry is found.

Currently, qcom_ubwc_configs[] only contains entries for qcom,sm7125,
qcom,sm7150, qcom,sm7225, and qcom,sm7325 in the SM7xxx family:

drivers/soc/qcom/ubwc_config.c:
	{ .compatible =3D "qcom,sm7150", .data =3D &ubwc_2_0_hbb14, },
	{ .compatible =3D "qcom,sm7225", .data =3D &ubwc_2_0_hbb14, },
	{ .compatible =3D "qcom,sm7325", .data =3D &ubwc_3_1_hbb14, },

Does qcom_ubwc_configs[] also need a qcom,sm7250 entry so that MDSS and DPU
initialization can succeed on SM7250?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-dpu-sm7250=
-v1-0-159f403ec405@brar.si?part=3D5
