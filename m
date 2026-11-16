Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B72606A333
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/GVgjhZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FCC10E9F4;
	Mon, 16 Nov 2026 13:31:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3234B10F1AA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:31:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CCA460DD0;
 Mon, 16 Nov 2026 13:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDC81F000C4;
 Mon, 16 Nov 2026 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794835898;
 bh=bjnLIEDd3fA8ZoSUDOtXlRcDA4ewkoBbdcAwv0SMyqU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U/GVgjhZiOBJ+vyURcnofxYLjP5GaNk8a3Mbozn16PBrzfMDMCmFBwKLqno4An5Ut
 8Y7zF/7TQtk41A8AohkeHlhwgj+xAUX1YYALIZADPahpvo7Wz97l8y+JyzPSX7rmNS
 EQ1getkclLaN6V0220WHhJBImHQ9B71gJOF2t3Fo5sh2YteULPOPruM2SfNyEZY05w
 6cEBsYAF8o80vLxEYb5h6+Mhi7K7z6X7L3SxxVZ1JZY2b/E4NGi0rvH7r/oylBUQt1
 Al03+8zgbqpIBdYEJEhpJ76Me701My53lEPB2kaRBgx924Fjx00o4tyjm4u9+9pJHS
 rc957NOulFzeQ==
Message-ID: <sashiko-outbox-217082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/11] dt-bindings: display: msm: dp-controller:
 Document Nord DisplayPort Controller
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261116-nord-drv-dt-v3-2-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-2-e3d3bf0e2c49@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:31:37 +0000
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
- [Low] dt-bindings: display: msm: dp-controller: qcom,nord-dp not in
  alphabetical order
--

commit 0ec7842c5ba3651d6f0a3de03165ad9984fb8e75
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

dt-bindings: display: msm: dp-controller: Document Nord DisplayPort Control=
ler

This commit adds the qcom,nord-dp compatible string to the qcom,sa8775p-dp
fallback group in the MSM DisplayPort controller binding.

> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.=
yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb779..9be0288261e72 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -35,6 +35,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,qcs8300-dp
> +              - qcom,nord-dp
>            - const: qcom,sa8775p-dp

[Severity: Low]
This isn't a bug, but qcom,nord-dp should be placed before qcom,qcs8300-dp
to keep the compatible enum list sorted alphabetically like the rest of
the binding.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-nord-drv-d=
t-v3-0-e3d3bf0e2c49@oss.qualcomm.com?part=3D2
