Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A760A2600
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No/t7f+k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8377910E47C;
	Wed, 18 Nov 2026 23:45:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563F410E47C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:45:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F60542A17;
 Wed, 18 Nov 2026 23:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB011F000C4;
 Wed, 18 Nov 2026 23:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045543;
 bh=SDq/7HeavZWLrUn2sveBygU/FnOm/anjslJbPK5KqIA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=No/t7f+kl/9hmDn4DEiZcmPKBb9vRgGFBOdaux+blu5b1LM535ufCugf7PA3Zg7Oj
 h23V5TFF6sUC0oWUCDhy71twKNfdwxmjc+eNEraQ9plXPfl5pMej1A2afQQdbiRgkk
 jjRv0eI6NfHuUuwWmuaYtG5b7xoa0g06P2UFHakc57+2cGpWCJ8lrpXnHrbobtO3wa
 /MqM5TV8WxWN2Kk28ejbER36k8TZZO5l+Asby3GQRsKVyC3JV7pKHnXfr22GT4ey1Z
 k6yt5QarNNkmGy9184khwDO33ypEz9TV1V/A9HQb2HoIlXYIMCqJFbKaLm8ABjW8qn
 yXKVDK4p3NwjA==
Message-ID: <sashiko-outbox-222209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] dt-bindings: soc: xilinx: Add Versal AI Engine DT
 binding
To: "Gregory Williams" <gregory.williams@amd.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118233211.4121361-12-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
 <20261118233211.4121361-12-gregory.williams@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:45:42 +0000
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
- [Medium] dt-bindings: soc: xilinx: xlnx,firmware-device-id duplicates
  power-domains
- [Low] dt-bindings: soc: xilinx: DTS example fails dt-check-style in
  strict mode
--

commit b6e53e2eec4c5f256b86a96092363aef4bc4fe16
Author: Gregory Williams <gregory.williams@amd.com>

dt-bindings: soc: xilinx: Add Versal AI Engine DT binding

This commit adds the Device Tree binding schema for the AMD Versal AI Engine
tile array processor.

> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.=
yaml b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
> new file mode 100644
> index 0000000000000..6c97b5f0fb036
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
> @@ -0,0 +1,61 @@

[ ... ]

> +  xlnx,firmware-device-id:
> +    description:
> +      Device identifier as defined by Versal firmware interface. This va=
lue is
> +      passed unchanged to firmware calls.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - xlnx,firmware-device-id
> +
> +additionalProperties: false

[Severity: Medium]
Should this binding use the standard power-domains property instead of a
custom xlnx,firmware-device-id property?

The value 0x18224072 in the example below is PM_DEV_AI from
arch/arm64/boot/dts/xilinx/xlnx-versal-power.h, which is the Versal firmware
power-domain node ID used by the xlnx,zynqmp-firmware power-domain provider
(drivers/pmdomain/xilinx/zynqmp-pm-domains.c).  Existing Versal drivers that
need the PM_DEV_* ID for firmware calls obtain it from power-domains (for
example, cqspi_of_get_pdata() in drivers/spi/spi-cadence-quadspi.c).
Omitting power-domains with additionalProperties: false also prevents DT
nodes from referencing the firmware power-domain provider.

> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      ai_engine: ai-engine@20000000000 {
> +        compatible =3D "xlnx,versal2-aieml";
> +        reg =3D <0x200 0x00 0x01 0x00>;
> +        clocks =3D <&aclk0>;
> +        clock-names =3D "aclk0";
> +        xlnx,firmware-device-id =3D <0x18224072>;
> +      };
> +    };

[Severity: Low]
This example triggers indent-unit-strict and unused-labels warnings under
scripts/dtc/dt-check-style --mode=3Dstrict because it uses 2-space indentat=
ion
instead of 4-space indentation and defines the unused label ai_engine.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118233211.4121=
361-1-gregory.williams@amd.com?part=3D11
