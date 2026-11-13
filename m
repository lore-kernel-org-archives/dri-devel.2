Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A3606BA8A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNyJdGzJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CF911269F;
	Fri, 13 Nov 2026 16:10:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30F211269F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:10:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 326ED6140D;
 Fri, 13 Nov 2026 16:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEFF1F000C5;
 Fri, 13 Nov 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586212;
 bh=CO68uu+19Fq5kJxdGPKAsumVDWujtn/UdXPYvC2akZA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jNyJdGzJIdW93Mlm6IFepl9JH1YYEdWjpsLTLfOKoBjWw4WWhOTGbPYyAKxu9ElYR
 NzDuW6NdRlS6onI66nH3A5nOmJPiuImlHriIyRV7ibc2o56DHXsXZUAxgK/I0UmtEE
 iPU2xpp7t2LMHGqfUh0bgCVBKJ7aB/o0IYHbT6U/tsj+qkOJSvm/YEhNv9DEz3GsYj
 wEH0pSpdPCYH/ecP3KcLzdxzGWQQu34GHscuvDubLCg90wbdTjCrkroep6nr/ARcQE
 UGKNq/B/T3UBQ1eUpSZ+VCrVWPwSJu4YcvU1QfvZ0+yIFI/3SJ819Ae4BL10yoK/Gg
 uZkrRNnEnUBbg==
Message-ID: <sashiko-outbox-213169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113155606.1677313-2-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155606.1677313-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261113155606.1677313-2-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:10:12 +0000
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
- [Low] dt-bindings: display: msm: misdescribed MDSS_CORE_INT2 reset in
  mdss-common
--

commit 022650a3f28469dcfe73a6138dee6ab78a21185f
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

dt-bindings: display: msm: mdss-common: describe additional block resets

This commit updates the common MDSS Device Tree binding schema to allow a
second reset entry and adds DISP_CC_MDSS_CORE_INT2_BCR to the SM8750 MDSS
binding example.

> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.ya=
ml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> index c6305a6e03346..51ef4cc74e818 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> @@ -84,8 +84,10 @@ properties:
>            - const: cpu-cfg
> =20
>    resets:
> +    minItems: 1
>      items:
> -      - description: MDSS_CORE reset
> +      - description: MDSS core reset
> +      - description: MDSS core INT2 interrupt controller reset

[Severity: Low]
Is "MDSS core INT2 interrupt controller reset" an accurate description of
DISP_CC_MDSS_CORE_INT2_BCR in the binding and commit message?

In drivers/clk/qcom/dispcc-sm8750.c, DISP_CC_MDSS_CORE_INT2_BCR (0xa000) is
paired with MDSS_INT2_GDSC (0xb000) and controls the secondary internal MDSS
core clock and power domain (disp_cc_mdss_mdp1_clk,
disp_cc_mdss_mdp_lut1_clk, disp_cc_mdss_vsync1_clk and
disp_cc_mdss_ahb1_clk), while the MDSS interrupt controller registers reside
in the primary MDSS core MMIO space.  Later in the series, commit "arm64: d=
ts:
qcom: sm8750: describe the second MDSS block reset" already describes
DISP_CC_MDSS_CORE_INT2_BCR as belonging to the mdss_int2_gdsc and *1_clk
domain rather than an interrupt controller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155606.1677=
313-1-xiaqinghuan@mail.ustc.edu.cn?part=3D1
