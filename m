Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67A60A2608
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4AH2Vh/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F0610E064;
	Fri, 13 Nov 2026 16:03:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7909410E064
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:03:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76FFB61206;
 Fri, 13 Nov 2026 16:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB03C1F000C7;
 Fri, 13 Nov 2026 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585786;
 bh=NbihbEQJPVQoQOFmz3p3syO0iZBpjiwZ0+6YQ9VA/GE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d4AH2Vh/N/1kVaG/dw24WvUr3s5DOrK8JTCWKGheE5sGE10Cni13+LCGzHWOvVjmI
 SPsYfLeIy6IUEdJshtZ3Rx7KOltNXUdF4i46GRpr5amISrcisgvRGOrktDwb6p7kE/
 smGumJudcAD3A/NZ1QYIfQ0Dl7gdcC88uSTVcQ0P1sjFoDwp7mrzi5n3cl/vHd+/Gi
 sdBDoxzn9eFirFlDQoYklxvkmMfYvylh+sim6/1OuZ0rQs5Y4novl1gAaKIBWRjjhy
 afHCiOlYXtRFUuO2g4KYPzGsQvtT01sF75A4EXDH7GVf23Wdz+AIUCuW69Hi4TG3Hj
 coyUpuOrGivqg==
Message-ID: <sashiko-outbox-213145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8750: describe the second MDSS
 block reset
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113155606.1677313-4-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155606.1677313-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261113155606.1677313-4-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:03:05 +0000
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
- [Medium] arm64: dts: qcom: sm8750: unattached
  DISP_CC_MDSS_CORE_INT2_BCR reset on mdss
--

commit 048c5dc3c561337c4cf2b84db1d42eb1d5cdd378
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

arm64: dts: qcom: sm8750: describe the second MDSS block reset

This commit adds DISP_CC_MDSS_CORE_INT2_BCR as a second reset to the
SM8750 MDSS device tree node.

> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/q=
com/sm8750.dtsi
> index cf947acc57602..0f3e649787315 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -3359,7 +3359,8 @@ mdss: display-subsystem@ae00000 {
>  				 <&gcc GCC_DISP_HF_AXI_CLK>,
>  				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> =20
> -			resets =3D <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +			resets =3D <&dispcc DISP_CC_MDSS_CORE_BCR>,
> +				 <&dispcc DISP_CC_MDSS_CORE_INT2_BCR>;

[Severity: Medium]
Should the mdss node assert and deassert DISP_CC_MDSS_CORE_INT2_BCR when its
corresponding power domain and clocks are not attached to the device?

In drivers/clk/qcom/dispcc-sm8750.c, DISP_CC_MDSS_CORE_INT2_BCR at 0xa000 is
the block reset for a separate secondary domain with its own power domain
(MDSS_INT2_GDSC at 0xb000) and clock branches (disp_cc_mdss_mdp1_clk,
disp_cc_mdss_mdp_lut1_clk, disp_cc_mdss_vsync1_clk, and
disp_cc_mdss_ahb1_clk).  The mdss and mdss_mdp nodes in sm8750.dtsi only
attach MDSS_GDSC and the primary MDP0 clocks, so msm_mdss_reset() toggles a
reset for a domain whose GDSC and clocks are neither attached nor enabled.

In addition, while the commit message notes that DISP_CC_MDSS_CORE_INT2_BCR
belongs to the mdss_int2_gdsc domain and that this two-reset configuration
has not been tested on hardware, the companion binding in
Documentation/devicetree/bindings/display/msm/mdss-common.yaml still
describes the second reset as an MDSS core INT2 interrupt controller reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155606.1677=
313-1-xiaqinghuan@mail.ustc.edu.cn?part=3D3
