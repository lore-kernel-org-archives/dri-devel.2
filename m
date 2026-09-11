Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47077C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB3410E17E;
	Fri, 11 Sep 2026 07:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WM4g31/V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B4810F503
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DD664183E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB1D1F000FF;
 Fri, 11 Sep 2026 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789112592;
 bh=qo8lCZzrr0jxFPdwpJP9YznMpKDuoy7361WCAbPF1h8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WM4g31/Vrf+RLfX0eR2i5egUY8hD/mjFbMY327xFJsN/xmf+yhsy+FSPwt+sb0nxy
 NrL9QIRMNI8SjPnYzDyFmq0pK/P/vlU22SZMXwPrhWOe6vnUBBR2aYl69oApj/eKtr
 TnjbzfEyCVWBm6mbEGW2y073731wvx7QgARI5P0W1PQiiEGaV8EUuf9O+F3aOoX6jH
 +FmJpj86kyZUrxUjGYUKWwsEN5V0dnJ0VneXPk9nlkkqmvJIIBzYAdzKZRO3EBq2HB
 NNMgOMSiddo97vMNQT9bYsmfGRqWq0H00Emmd5DHtg3QtNFFp077hljv8bmdolSX2Y
 RucSydDKx4weA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: display: panel: panel-simple: Add
 lg,sw49410 compatible"
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260911-topic-lg_sw49410_revert-v1-1-c9385a9e1926@oss.qualcomm.com>
References: <20260911-topic-lg_sw49410_revert-v1-1-c9385a9e1926@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:43:11 +0000
Message-Id: <20260911074311.BFB1D1F000FF@smtp.kernel.org>
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
- [Medium] Reverting the 'lg,sw49410' compatible from panel-simple.yaml lea=
ves the corresponding in-tree device tree node with an undocumented compati=
ble string, causing a dtbs_check warning.
--

commit 28eecf951716dcb353efba4db6671dff19420f95
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Revert "dt-bindings: display: panel: panel-simple: Add lg,sw49410 compatibl=
e"

This reverts the addition of the lg,sw49410 compatible string from the
panel-simple bindings. The commit states the panel needs more specific
handling and that the intended compatible was supposed to contain both
the display panel name and driver IC model number.

Link: https://lore.kernel.org/all/20260614-judyln-panel-v3-2-07f4134441bd@p=
ostmarketos.org/

> Moreover, the other compatible that didn't make it in the end landed in
> the Qualcomm tree some time ago, instead of the one this revert
> removes, so it's not even used.

[Severity: Medium]
Is this statement accurate?

Looking at arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts, this compatible
string appears to be actively used by the display_panel node:

arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts:display_panel {
        ...
        compatible =3D "lg,sw49410-lh609qh1", "lg,sw49410";
        ...
}

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 3d1cc11ba3aa4..de722f45f862a 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml

[ ... ]

> @@ -206,8 +206,6 @@ properties:
>        - lemaker,bl035-rgb-002
>          # LG 7" (800x480 pixels) TFT LCD panel
>        - lg,lb070wv8
> -        # LG 6.1" (1440x3120) IPS LCD panel
> -      - lg,sw49410

[Severity: Medium]
Does removing this documentation leave the in-tree device tree node in
arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts completely undocumented?

Running make dtbs_check on the tree with this revert applied will complain
about the undocumented compatible strings lg,sw49410-lh609qh1 and lg,sw49410
for this panel node, resulting in a schema validation error.

>          # Logic Technologies LT161010-2NHC 7" WVGA TFT Cap Touch Module
>        - logictechno,lt161010-2nhc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-topic-lg_s=
w49410_revert-v1-1-c9385a9e1926@oss.qualcomm.com?part=3D1
