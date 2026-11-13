Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147B606C567
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdENJYhf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E9710E7C1;
	Fri, 13 Nov 2026 16:12:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF5D10E7C1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:12:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5180A45E4C;
 Fri, 13 Nov 2026 16:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8371F000C4;
 Fri, 13 Nov 2026 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586335;
 bh=1GPN2CYAxENG+Z5ps/0508Q/FCgeOgFKH22MWuJY2pw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kdENJYhfofxxdQCrQU7AVdLmUf9YvwnsBBpiolACuz4+UeWwtXjazOl9nwu1F659e
 xQMPWVQ6XwfeJtc6XJXA0EAPN6J8tlke7eBUg+ZMZhbjGJT7oW4OQpL5FBxUFkzupY
 DHJHesOAEqEuyo+jnkwdjFSSuyd/YYtemhrLRn+aCp6M7RXEVN92788brUiSTDduq3
 BUXVUI0OtG+UrRL0qDYss9aQ2QAQDuAz/Gs++FB3Kh/pB92LFafP+G9d6HfubGUDgO
 Iv93fNT3kTZDzLjhE69mQN2zMoVxpmhGpfakxlF00R+AZCdNrtRh9O9Vhscyq+4LN6
 rB2pIauV6ZxMQ==
Message-ID: <sashiko-outbox-213171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113155635.1677541-2-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261113155635.1677541-2-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:12:14 +0000
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

commit 0f5d0a5d3c7e47f59b13ac8f16fb077159d613cd
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

dt-bindings: display: msm: mdss-common: describe additional block resets

This commit updates the MDSS common Device Tree binding and the SM8750 MDSS
example to allow a second reset for the MDSS hardware block.

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
this reset (and in the commit message)?

In drivers/clk/qcom/dispcc-sm8750.c (and sibling Qualcomm DISP_CC drivers),
DISP_CC_MDSS_CORE_INT2_BCR at 0xa000 is paired with MDSS_INT2_GDSC at 0xb000
and resets the secondary internal MDSS core clock domain
(disp_cc_mdss_mdp1_clk, disp_cc_mdss_mdp_lut1_clk, disp_cc_mdss_vsync1_clk,
and disp_cc_mdss_ahb1_clk), rather than an interrupt controller.  The MDSS
top-level interrupt status register (HW_INTR_STATUS) is part of the primary
MDSS core MMIO space.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155635.1677=
541-1-xiaqinghuan@mail.ustc.edu.cn?part=3D1
