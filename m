Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF665606A897
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gY70MHX6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224A110E46E;
	Thu, 12 Nov 2026 04:54:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C3A10E46E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 04:54:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9506F41438;
 Thu, 12 Nov 2026 04:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F11F00A0D;
 Thu, 12 Nov 2026 04:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794459245;
 bh=5IvI3ny+Myq1O82n3c9+7DHtZFn1bWsneuTWZKLGf2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gY70MHX6eSzBQ88RYGXHfUDaetTBtzBHxCFNqMF6nns8GHslDW8Z6PBAsKMCfs709
 L5u+ZRskgPky7Lzww8MAEqm9YFOhuGjruR8xwRw9Se5xIqS4rSwRtxu8xaqC2T96vh
 Jw/jMW2B81wBItwlSiV/I+YeMhRLmdWSir150qBN5wBG8Ttsdy/qCbdPQ5GVYgCqsV
 HB5CqWS9g7unctRRSjdmz7DEF/yJYljpbJQ/IsH6pgcnmnui9bEvIsEQLn/ngs5Npj
 nnYekf5H/r0/y/tQlhyw2a6N2vLrZRgvUBWbEsJ4ciCJ3DQNu6/fYOvStiuDp+elWJ
 H4ef7Bk7S0qQQ==
Message-ID: <sashiko-outbox-210400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] drm/msm/dpu: Add SM7250 support
To: "Ishu Brar" <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261112-dpu-sm7250-v2-5-8e925a3a8a7d@brar.si>
References: <20261112-dpu-sm7250-v2-0-8e925a3a8a7d@brar.si>
 <20261112-dpu-sm7250-v2-5-8e925a3a8a7d@brar.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:54:04 +0000
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
- [High] drm/msm/dpu: missing qcom,sm7250 in qcom_ubwc_configs breaks
  probe
--

commit 028e2a72798ab5d56d8d81bb276fb38107826ea0
Author: Ishu Brar <patches@brar.si>

drm/msm/dpu: Add SM7250 support

This commit adds DPU 6.1 hardware catalog definitions and device tree match
data for the Qualcomm SM7250 platform.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index 1b6286dccfc00..908d401ec4020 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1506,6 +1506,7 @@ static const struct of_device_id dpu_dt_match[] =3D=
 {
>  	{ .compatible =3D "qcom,sm6350-dpu", .data =3D &dpu_sm6350_cfg, },
>  	{ .compatible =3D "qcom,sm6375-dpu", .data =3D &dpu_sm6375_cfg, },
>  	{ .compatible =3D "qcom,sm7150-dpu", .data =3D &dpu_sm7150_cfg, },
> +	{ .compatible =3D "qcom,sm7250-dpu", .data =3D &dpu_sm7250_cfg, },

[Severity: High]
Does qcom_ubwc_configs in drivers/soc/qcom/ubwc_config.c also need an entry
for "qcom,sm7250"?

During probe, msm_mdss_init() and dpu_kms_hw_init() call
qcom_ubwc_config_get_data(), which looks up the machine root compatible in
qcom_ubwc_configs via of_machine_get_match_data().  Without a matching
"qcom,sm7250" entry in qcom_ubwc_configs, qcom_ubwc_config_get_data()
returns ERR_PTR(-EINVAL) and display initialization on SM7250 fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-dpu-sm7250=
-v2-0-8e925a3a8a7d@brar.si?part=3D5
