Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A481606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1dw9a6O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E91A10E29C;
	Wed, 11 Nov 2026 18:48:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F5F10E29C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:48:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFDAA41789;
 Wed, 11 Nov 2026 18:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B31F00A05;
 Wed, 11 Nov 2026 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794422897;
 bh=lzI0tNsLyUyrWyDu7YugFNUzkoiLbACEMQ/CfarIk+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O1dw9a6Oqa8lxILfDM3d0ldqqYLSDaB4s1tLOKyoAVrrkektrdlQdyNL53a4N8wnR
 o7vn/AqllOrbOv52QKtldzQt9//XSnofaKzNKYpQdI1KTBd6zrm1nSo9RBkHXRnIF3
 JFWTyAS+3mHHL9byxCybZGdFXSCQnsOTspJFuBw8WdDH7/DjEevhLd+x1cVgxJF2Yt
 JCwqEmFgGXM5bkWRk68rhc4ZTtzRRMwJsfsk9MoFScqwySH+iHEDry7IxQyVKV1qDp
 qZQ5Am+7qpYLq+1uiMLhESl4RMcRuVW5Vqj+E1m8WiOqADrrMCxw4TDIRkRSavpCLP
 R/G/cG2e9xcpQ==
Message-ID: <sashiko-outbox-209493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 18:48:16 +0000
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
- [High] arm64: dts: qcom: msm8916: mdss_dsi0 left disabled on apq8016
  boards
--

commit 1c53100e6d0a805c4396ae622f04768b412718b0
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

arm64: dts: qcom: msm8916: Disable disconnected DSI

This commit disables mdss_dsi0 and mdss_dsi0_phy by default in msm8916.dtsi
and enables them in board DTS files that have a panel or bridge attached.

> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/d=
ts/qcom/apq8016-sbc.dts
> index ba6ccf0db16ab..6c94489f5f707 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -262,6 +262,10 @@ &mdss_dsi0_out {
>  	remote-endpoint =3D <&adv7533_in>;
>  };
> =20
> +&mdss_dsi0_phy {
> +	status =3D "okay";
> +};
> +
>  &mpss {
>  	status =3D "okay";
> =20
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch=
/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> index ce75046ffdac4..370ad8b01a1a0 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> @@ -218,6 +218,10 @@ &mdss_dsi0_out {
>  	remote-endpoint =3D <&adv7533_in>;
>  };
> =20
> +&mdss_dsi0_phy {
> +	status =3D "okay";
> +};
> +
>  &pm8916_codec {
>  	qcom,mbhc-vthreshold-low =3D <75 150 237 450 500>;
>  	qcom,mbhc-vthreshold-high =3D <75 150 237 450 500>;

[Severity: High]
Should apq8016-sbc.dts and apq8016-schneider-hmibsc.dts also enable
&mdss_dsi0?

Both boards connect DSI0 to the ADV7533 bridge via &mdss_dsi0_out and do
not have an existing &mdss_dsi0 block.  With mdss_dsi0 disabled in
msm8916.dtsi, the DSI controller and ADV7533 bridge fail to probe on both
boards.  Furthermore, because apq8016-schneider-hmibsc.dts leaves &gpu
disabled, msm_drv_probe() finds zero sub-components and passes a NULL
match pointer to component_master_add_with_match(), causing a NULL pointer
dereference at boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-display-ms=
m-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com?part=3D1
