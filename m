Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86966C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D729D10E197;
	Mon, 21 Sep 2026 18:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gOdnZbI2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F353510E197
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:26:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76DAC60008;
 Mon, 21 Sep 2026 18:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982FA1F000FF;
 Mon, 21 Sep 2026 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015194;
 bh=W0aH694xxaoojSNRYyLlLh44l7vy/hpaF+r9VEUSMgs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gOdnZbI2dOxrwDHL+p++DOOeat1WGShjE280jRHpCna79izreHHhkFfbd6Yu0ZUwA
 3DLFoG8Ls+PthHGygAO09tGQx11rHskmffxGXNeZECfj9KSheghbFiGVXeHwNkSxBU
 t/4uEtItd7ETB+h9H28iOVPy/QpHWOUzCKR3nmX3lvQvA9eerFdalY/luJJc4Ghvrc
 DTuL34TaoUhthWPYIgDtczKEJcrVHV1crNqaaW4qZJkKlaZ+65THYHSVBRnMU0PoRb
 /FfLZsmK8oSOLtATBhVWTZJEHeqTyvrVjyQN9mIfXoE1PTirI2qDxu429ToyvuS/PY
 9hI+W0JtfMziw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:26:33 +0000
Message-Id: <20260921182633.982FA1F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: clock: missing msm8952 in constraints conditional b=
lock
--

commit 08e2cd81c0f804c9a9db2e8d8d60babe26ca3d55
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible

Document the rpmcc found on MSM8952.

> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Do=
cumentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -56,6 +56,11 @@ properties:
>                - qcom,rpmcc-shikra
>            - const: qcom,rpmcc-qcm2290
>            - const: qcom,rpmcc
> +      - items:
> +          - enum:
> +              - qcom,rpmcc-msm8952
> +          - const: qcom,rpmcc-msm8976
> +          - const: qcom,rpmcc

[Severity: Medium]
Does qcom,rpmcc-msm8952 also need to be added to the allOf conditional
block that enforces the xo clock constraints?

Because qcom,rpmcc-msm8952 falls back to qcom,rpmcc-msm8976, it shares the
same xo clock requirement. Currently, qcom,rpmcc-msm8976 is listed in the
conditional block:

Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml:
  - if:
      properties:
        compatible:
          contains:
            enum:
              ...
              - qcom,rpmcc-msm8974
              - qcom,rpmcc-msm8976
              ...
    then:
      properties:
        clocks:
          items:
            - description: xo clock

Should qcom,rpmcc-msm8952 be added to this enum list? When running
dt_binding_check on a device tree containing the qcom,rpmcc-msm8952
compatible string, the clock constraints will not be enforced.

> =20
>    '#clock-cells':
>      const: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D12
