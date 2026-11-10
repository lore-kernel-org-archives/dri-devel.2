Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7F606A75E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVvygpft
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8708610E288;
	Tue, 10 Nov 2026 13:12:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFF510E288
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:12:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEB56456E9;
 Tue, 10 Nov 2026 13:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DE41F008A6;
 Tue, 10 Nov 2026 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794316343;
 bh=4TnoQ31cxBTJa9Bni6H9V/OFa4756WScSdnspb3np/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jVvygpftu8kxS/GLStdNtNg9TcIAr59kxoVu0CZOdGYKfmGM6SElTJOPDpjvJdsSH
 NDAIq1RuPGp2chlprozu7Sc7H84ajxOr6jbknBelEG8oV0jucdP9ajhBLgBs7EARpA
 FHjDSWEtDh87WLJprhI4xoGxglD5UkNrtSihYmXxXD4pCzBPj1wu3B7GVOQiBucAQI
 DYsLU5dWAZFLeD4x7vTZLvdHpjmtUL38D0kBJ0m+R3ze47yZrc4Jq4X3LdoDE5ZNoa
 6rCVNsOInx5T6wQSMc9r/kASCXQjshkpOXcYAnBa8VWPyzrM8lNJYwtvJdzr0/vDp3
 s2iugZto2KkZA==
Message-ID: <sashiko-outbox-207102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261110-display-msm-of-graph-v1-1-0f3106f817b4@oss.qualcomm.com>
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
 <20261110-display-msm-of-graph-v1-1-0f3106f817b4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:12:22 +0000
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
- [High] arm64: dts: qcom: msm8916: broken display and probe crash on
  apq8016 boards
--

commit 84868fbeac14d1ada5236c28cee63ebec6ea8fbd
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

arm64: dts: qcom: msm8916: Disable disconnected DSI

This commit disables mdss_dsi0 and mdss_dsi0_phy by default in msm8916.dtsi
and enables them in four Samsung board DTS files that define a DSI panel.

> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/=
qcom/msm8916.dtsi
> index e39743e220438..7d351cd15f901 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1634,6 +1634,8 @@ mdss_dsi0: dsi@1a98000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> =20
> +				status =3D "disabled";
> +
>  				ports {
>  					#address-cells =3D <1>;
>  					#size-cells =3D <0>;
> @@ -1668,6 +1670,8 @@ mdss_dsi0_phy: phy@1a98300 {
>  				clocks =3D <&gcc GCC_MDSS_AHB_CLK>,
>  					 <&xo_board>;
>  				clock-names =3D "iface", "ref";
> +
> +				status =3D "disabled";
>  			};
>  		};

[Severity: High]
Does disabling mdss_dsi0 and mdss_dsi0_phy here break display and audio on
apq8016-sbc.dts and apq8016-schneider-hmibsc.dts, and cause a NULL pointer
dereference during boot on apq8016-schneider-hmibsc.dts?

Both APQ8016 boards enable &mdss and connect &mdss_dsi0_out to an I2C
ADV7533 DSI-to-HDMI bridge (remote-endpoint =3D <&adv7533_in>) instead of a
child panel node, without setting status =3D "okay" on &mdss_dsi0 or
&mdss_dsi0_phy.  With mdss_dsi0 disabled, adv7533_parse_dt() fails with
-ENODEV because of_graph_get_remote_node() sees an unavailable remote paren=
t,
which also prevents the &sound card referencing &adv_bridge from probing.

In addition, on apq8016-schneider-hmibsc.dts where &mdss is enabled and &gpu
remains disabled, add_mdp_components() skips the disabled mdss_dsi0 node and
leaves match as NULL.  mdp5_dev_probe() -> msm_drv_probe() then passes
match =3D NULL to component_master_add_with_match(), which dereferences
match->num.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-display-ms=
m-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com?part=3D1
