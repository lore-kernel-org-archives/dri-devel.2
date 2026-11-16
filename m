Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D7606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ivz2bEkW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416D310F165;
	Mon, 16 Nov 2026 13:38:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A7E10F165
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8101E4127F;
 Mon, 16 Nov 2026 13:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0551F000C4;
 Mon, 16 Nov 2026 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794836321;
 bh=59PfDd0VpStac2ysf6Porax1g63p2cCCVlYSfpOHaNo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ivz2bEkWrds1FXElHF1G5QuonC/Y9MehV8TCrOHCLflMU+A+XxL/qz0evh0hSxSsk
 +D2nqN684cN9pZ2CKTEEFlcAL+0UOiw5xJtCieTlmjmUosihSvf/ZAPhjfkw4RJuqC
 7/6nKhmv/7fNvPINPNbdc4XN1elHaKl3ve/+y5qgbcqFqVE4DEA4c1JOux3jcRLTUP
 Mf+gQZ8Ub5tkI7okbrx6B2RKwx8K0Ea6KjeXWogYg+Mpq1/R49tDChe/rLQiXWnaK8
 j18i7QvViLCt/taC/TvjmYAmBaCdDUw3wo/VtpZFbJPX6hCHceXqzO7IpFNdwV6ILG
 Y0h6EarD37kCA==
Message-ID: <sashiko-outbox-217094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: display/msm: Document Nord MDSS
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261116-nord-drv-dt-v3-3-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-3-e3d3bf0e2c49@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:38:40 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] dt-bindings: display/msm: qcom,nord-mdss omits
  qcom,sa8775p-dp fallback
- [Low] dt-bindings: display/msm: inconsistent DP1 clocks and PHY reg
  sizes in example
--

commit 7e933ce5ebfd089e4cac22428484f5b572292bc8
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

dt-bindings: display/msm: Document Nord MDSS

This commit adds the devicetree binding schema for the Qualcomm Nord
display subsystem (MDSS 12.1).

> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss=
.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> new file mode 100644
> index 0000000000000..abd80dae4e7f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml

[ ... ]

> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dp

[Severity: Medium]
Should the compatible constraint here allow the "qcom,sa8775p-dp" fallback,
and should both displayport-controller nodes in the example below include
it?

Documentation/devicetree/bindings/display/msm/dp-controller.yaml requires
"qcom,nord-dp" to be followed by "qcom,sa8775p-dp":

Documentation/devicetree/bindings/display/msm/dp-controller.yaml
      - items:
          - enum:
              - qcom,qcs8300-dp
              - qcom,nord-dp
          - const: qcom,sa8775p-dp

Using "const: qcom,nord-dp" here rejects the required fallback, and
omitting "qcom,sa8775p-dp" from displayport-controller@af54000 and
displayport-controller@af5c000 in the example causes dt_binding_check to
fail against dp-controller.yaml.  Using "contains: const: qcom,nord-dp"
(as in qcom,qcs8300-mdss.yaml) and adding "qcom,sa8775p-dp" to the example
nodes would resolve this.

[ ... ]

> +        displayport-controller@af5c000 {
> +            compatible =3D "qcom,nord-dp";
> +
> +            reg =3D <0xaf5c000 0x200>,
> +                  <0xaf5c200 0x200>,
> +                  <0xaf5d000 0xc00>,
> +                  <0xaf5e000 0x400>,
> +                  <0xaf5f000 0x400>,
> +                  <0xaf60000 0x400>,
> +                  <0xaf61000 0x400>,
> +                  <0xaf62000 0x600>,
> +                  <0xaf63000 0x600>;
> +
> +            clocks =3D <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_AUX_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL1_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL2_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL3_CLK>;
> +            clock-names =3D "core_iface", "core_aux",
> +                          "ctrl_link", "ctrl_link_iface",
> +                          "stream_pixel", "stream_1_pixel",
> +                          "stream_2_pixel", "stream_3_pixel";
> +
> +            assigned-clocks =3D <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_C=
LK_SRC>,
> +                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_C=
LK_SRC>,
> +                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL1_C=
LK_SRC>;
> +            assigned-clock-parents =3D <&dp1_phy 0>,
> +                                     <&dp1_phy 1>,
> +                                     <&dp1_phy 1>;

[ ... ]

> +        dp1_phy: phy@fc6a00 {
> +            compatible =3D "qcom,nord-dp-phy";
> +
> +            reg =3D <0xfc6a00 0x200>,
> +                  <0xfc6200 0xd0>,
> +                  <0xfc6600 0xd0>,
> +                  <0xfc6000 0x1c8>;

[Severity: Low]
Are the assigned-clocks on displayport-controller@af5c000 and the reg sizes
on dp1_phy in the example intended to differ from the first DP instance?

displayport-controller@af5c000 requests all four stream pixel clocks in
clocks, but assigned-clocks omits MDSS_DISP_CC_MDSS_DPTX1_PIXEL2_CLK_SRC
and MDSS_DISP_CC_MDSS_DPTX1_PIXEL3_CLK_SRC (which are present on
displayport-controller@af54000).  In addition, dp1_phy uses SA8775P
register sizes (0x200, 0xd0, 0xd0, 0x1c8) instead of the qcom,nord-dp-phy
sizes used by dp0_phy (0x1d0, 0x128, 0x128, 0x200), leaving the fourth
region smaller than NORD_DP_QSERDES_COM_C_READY_STATUS at offset 0x1f8.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-nord-drv-d=
t-v3-0-e3d3bf0e2c49@oss.qualcomm.com?part=3D3
