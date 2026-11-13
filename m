Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0198606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KW8qug2p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4E410E519;
	Fri, 13 Nov 2026 06:17:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AA410E519
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 06:17:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33EA760F4C;
 Fri, 13 Nov 2026 06:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A224F1F000C5;
 Fri, 13 Nov 2026 06:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794550650;
 bh=gF+Q7Ui34Qq0VtY7TAD0rthakFzomrYF9aXVXa/KptI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KW8qug2pSfjcML1x8AqLbCYQvGh80Grc8+MAhccLo5MLpofernvyDhvxHcTENFshP
 vqh3ig3rhnyxnlombdYWNwknJuR8plgi1mAm2ftyNM4oJfgw6IuLb2PX011BKHncPD
 7PMSf1RvX1R0mB3EPPZVKvxaFqGbfgOA0OSuUJnRE0wjWdvhTuXVk/u6K0Edp6xEgb
 uAg1jHydhHP+IkhTUPuD0j79ZEZpqN5xUfqDUWSLXnUTafy9ryorfdn/9TVqNSR8uT
 AQCMErLEcu1FUQJ4D8/WnEWKncRDQa6UEUHvJLq8rF9G3wRATbJdaWIt/8nEkb6xAq
 yUGyeGuJX1DOA==
Message-ID: <sashiko-outbox-212272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/msm: mdss: Add SM7250 support
To: "Ishu Brar" <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-dpu-sm7250-v3-6-30bdec59d204@brar.si>
References: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
 <20261113-dpu-sm7250-v3-6-30bdec59d204@brar.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:17:23 +0000
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

commit 9c80774ba784ea5c8dce29db13d653c875106e5d
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

[Severity: High]
Does qcom_ubwc_configs[] in drivers/soc/qcom/ubwc_config.c also need an
entry for "qcom,sm7250"?

Both msm_mdss_init() (called from mdss_probe()) and dpu_kms_hw_init() call
qcom_ubwc_config_get_data() and fail when it returns an error.  Because
qcom_ubwc_configs[] has no "qcom,sm7250" match, qcom_ubwc_config_get_data()
returns ERR_PTR(-EINVAL), so MDSS and DPU probe on SM7250 will always fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-dpu-sm7250=
-v3-0-30bdec59d204@brar.si?part=3D6
