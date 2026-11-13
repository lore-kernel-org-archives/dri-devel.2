Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6323606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/QjL3n4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B57C10E76A;
	Fri, 13 Nov 2026 08:55:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8246611207E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:55:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5226D44EA4;
 Fri, 13 Nov 2026 08:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8421F000C8;
 Fri, 13 Nov 2026 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560137;
 bh=YWC5GW6QzXr3mcRyv3EAX+VlztrwKrULHabvYRb7ceQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N/QjL3n4wV2iXjDUIJA2alr/cn9/oM3DG1rGbEjfMiDhh+NFICzU2I5Hqx1wP3U5a
 cUlBU61JnCeWX8O5+k0Ztm7dqln1V23MIXLEXimDthEgnIrr2XG1rx/hOladHqqCRK
 9uGu1fuFLKFyyMMBRReTWQODlmkCvJPTbCU/BN+DYT5VqWHKZlxPIBwQWtXeLc+3sL
 FPmDeulQklYvhxXNNVUs9ZIl/DVtYWNQlQ17VT4cVbUH2KN8TmZvNq/r0Z4lF7luJ+
 fUlw4UkFqGOiM90fYj75sKHMIig/5GvMtW2UzucF351TPm9rzghw64SMSzKrNsePt5
 xGfQbfXL6Scvg==
Message-ID: <sashiko-outbox-212478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <114cd1bcce56c1267059826f7c9619d835a2912d.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
References: <cover.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
 <114cd1bcce56c1267059826f7c9619d835a2912d.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:55:36 +0000
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

commit a487330ddb2e36a5355178c8c4bcbb0f50bae826
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

dt-bindings: display: msm: mdss-common: describe additional block resets

This commit allows the MDSS resets property in mdss-common.yaml to accept
one or two reset entries and updates the SM8750 MDSS binding example
accordingly.

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
Is the second reset entry an interrupt controller reset?

In drivers/clk/qcom/dispcc-sm8750.c (and earlier dispcc drivers such as
dispcc-sm8450.c and dispcc-sm8550.c), DISP_CC_MDSS_CORE_INT2_BCR at 0xa000
and its paired MDSS_INT2_GDSC at 0xb000 control the secondary internal MDSS
core clock and power domain (disp_cc_mdss_mdp1_clk,
disp_cc_mdss_mdp_lut1_clk, disp_cc_mdss_vsync1_clk, and
disp_cc_mdss_ahb1_clk), while the MDSS interrupt controller registers
(HW_INTR_STATUS at offset 0x00010) are part of the primary MDSS core block.
Should this description and the commit message refer to the secondary
internal MDSS core block reset instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794558882.gi=
t.xiaqinghuan@mail.ustc.edu.cn?part=3D1
