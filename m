Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51898606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPfHwZu3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA5C10E12C;
	Fri, 13 Nov 2026 06:14:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01F310E12C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 06:14:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2108E60F4C;
 Fri, 13 Nov 2026 06:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BCB1F000C4;
 Fri, 13 Nov 2026 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794550476;
 bh=Q44Rtdokva8R0o9T+p1SzXM0YgXSl9Xi9xwtccuxZJA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oPfHwZu3WhyklIPoRfy9QKdXrjbUsyuHNLjDsCbOplyA59Si26JhCasYXmr+pDrb1
 eilIV2c8nBXac1QGqAslVltOfjlHoqfITMKvkuOtGabOsCGml8ObElWraIjgce7k5d
 Iyif+WgXbiGroNFzg3K8os0V/KAY/pQawDttHFyueJKAr+19jl6z3d7SBk6HQaM1hJ
 07pMDHE+eKeGRGhDW0Vgu9sV6C2KjYZG/XgsJmRtDjG/bbT6uS/EnuRU890UP/4EQV
 ZS/Tqf3HFzLoKlODuLP2T7tIl0tYKwcnRJyEwwxB94exjuV5YLqNtMmG9nJDzIKzV8
 a3yFSyVc/ndzQ==
Message-ID: <sashiko-outbox-212271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] drm/msm/dpu: Add SM7250 support
To: "Ishu Brar" <patches@brar.si>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-dpu-sm7250-v3-5-30bdec59d204@brar.si>
References: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
 <20261113-dpu-sm7250-v3-5-30bdec59d204@brar.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:14:36 +0000
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

commit 59825eaff1e766d3f8d177a85a687c71ae26eb1b
Author: Ishu Brar <patches@brar.si>

drm/msm/dpu: Add SM7250 support

This commit adds the DPU 6.1 hardware catalog definitions and device tree
match entry for the Qualcomm SM7250 platform.

[ ... ]

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
Does qcom_ubwc_configs[] in drivers/soc/qcom/ubwc_config.c also need an
entry for "qcom,sm7250"?

During initialization, dpu_kms_hw_init() calls qcom_ubwc_config_get_data(),
which looks up the machine root compatible in qcom_ubwc_configs[]. Without
a "qcom,sm7250" entry there, qcom_ubwc_config_get_data() returns
ERR_PTR(-EINVAL) and DPU initialization fails on SM7250.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-dpu-sm7250=
-v3-0-30bdec59d204@brar.si?part=3D5
