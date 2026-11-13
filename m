Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D96070235
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6em482u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91A810E7A6;
	Fri, 13 Nov 2026 16:05:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E7710E7A6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:05:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65F31628E8;
 Fri, 13 Nov 2026 16:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33931F000C5;
 Fri, 13 Nov 2026 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585915;
 bh=zDDhxeiq4AimuU9FB2NEBaVGfhWia5vA4S5VTaY0WE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V6em482utP9GKUhzxT9JherybdfYjin3Vm0VzAfIeSQqtkQhwxNGw/cFZwD2i2WES
 XQHxQlaiNBGOWe7VBVwf/AGPr4BCvmjW+arh9iV/9tYqRrVnvqGtL/MFiOFxW/LrHp
 j5RrkE4G1SFrz17Sv3nOj8mj9t6xldMsNIYTGb1GlriJIEtwgbs9SzRmG9wsmvsp0M
 Az9x+cTUA6W4gOS+USxveV8H9atuaJkszJl9ldQmkW8qEZCdP1SyRg4ocNde+0pZ7z
 RGBdvByxsnXKnomZRK9OrxyA8tFUJDCSuqzWHaEKKlCG1Y2IP5O3w1SONf+y3dKjrz
 AFtsUnQESDtiQ==
Message-ID: <sashiko-outbox-213154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8750: describe the second MDSS
 block reset
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113155635.1677541-4-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261113155635.1677541-4-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:05:14 +0000
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
- [Medium] arm64: dts: qcom: sm8750: unattached INT2 domain reset on
  mdss
--

commit b3b8b6c811f21fdd572edc7ec2e32709cdaa973b
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

arm64: dts: qcom: sm8750: describe the second MDSS block reset

This commit adds DISP_CC_MDSS_CORE_INT2_BCR to the resets property of the
mdss display-subsystem node in the SM8750 device tree.

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
Should the mdss node assert DISP_CC_MDSS_CORE_INT2_BCR when it does not
attach the corresponding MDSS_INT2_GDSC power domain or clocks?

In drivers/clk/qcom/dispcc-sm8750.c, DISP_CC_MDSS_CORE_INT2_BCR (at 0xa000)
is the block reset for the secondary MDSS_CORE_INT2 domain governed by
mdss_int2_gdsc (at 0xb000) and the disp_cc_mdss_*1_clk branches.  Here,
mdss only attaches MDSS_GDSC and the primary MDSS_CORE clocks, so
mdss_probe() -> msm_mdss_init() -> msm_mdss_reset() will reset an
unattached power and clock domain.

In addition, commit "dt-bindings: display: msm: mdss-common: describe
additional block resets" in this series still documents this second reset
entry in Documentation/devicetree/bindings/display/msm/mdss-common.yaml as
"MDSS core INT2 interrupt controller reset", which contradicts the commit
message here describing it as a separate GDSC and clock domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155635.1677=
541-1-xiaqinghuan@mail.ustc.edu.cn?part=3D3
