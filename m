Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnhH+gIX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C5F10E4ED;
	Tue, 17 Nov 2026 06:58:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584C510E4ED
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:58:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 649BD6112E;
 Tue, 17 Nov 2026 06:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C583A1F000C4;
 Tue, 17 Nov 2026 06:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794898723;
 bh=CXJ4cUrlwKKkr/vQ9C8m+Uxfi50nY/lDTKmlaeHjHBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DnhH+gIXQBwLAmKsnVm/i3EunteRYZlJwqzg45cgn9l5viOfA/vyauoev3fsTLPnl
 xFCECC4tlOvE26jq824udyBJ821JK6cHWNTjq7GAO3bYK+tPm804NrEBP4/e8YurSQ
 tmNvhcEtIjs0Ra09N+xmN2zF4OgstFlHRcq8gHCIQ9w3t1Ex5bzihHQeBHQTcZBAiK
 A3Ap63p9frUDWEcGHSaEHyPW7vElGXR4Z5vTIAdcJYMGqX+IsnH6Bwf3WffBNkqyX0
 03DsvbHTcys+yLI2BkvjEmPjPeQ0zeRx5PGk7bWzQUgxb3twlKI0Kc+cwGYTIGSRmG
 E8UGndS1CDJUg==
Message-ID: <sashiko-outbox-218284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261117064552.85256-2-Luo.Liu@cixtech.com>
References: <20261117064552.85256-1-Luo.Liu@cixtech.com>
 <20261117064552.85256-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:58:42 +0000
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
- [Medium] dt-bindings: display: cix,sky1-dp: missing output port in OF
  graph schema
- [Low] dt-bindings: display: cix,sky1-dp: unused labels in DTS example
--

commit d98f4d4238cf91c13498054d6c8b154975a5d02b
Author: Luo Liu <Luo.Liu@cixtech.com>

dt-bindings: display: add CIX Sky1 DisplayPort transmitter

This commit adds the Devicetree binding schema and MAINTAINERS entry for
the CIX Sky1 DisplayPort and USB-C DisplayPort transmitters.

> diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml b=
/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
> new file mode 100644
> index 0000000000000..ec6d02989b580
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml

[ ... ]

> +  phys:
> +    maxItems: 1
> +    description: DisplayPort PHY the controller transmits through.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Video input from the Mali D71 display pipeline (Komeda) that drives
> +      this controller. The link to the sink is through phys (USB-C combo=
 PHY
> +      or the native DP PHY), not a second OF graph port on the DPTX.

[Severity: Medium]
Should this binding use ports with port@0 for the video input and port@1
for the DisplayPort or eDP output instead of a single port property?

The phys property only references the local SoC PHY block, whereas
downstream display sinks such as dp-connector, eDP panels, and USB-C
connectors or muxes link to the transmitter output endpoint via the OF
graph (and eDP panels may also sit under an aux-bus child node).  With
only a single port defined and additionalProperties set to false, board
devicetrees cannot describe the connection to the downstream sink without
failing dtbs_check.

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    dp0: dp@14064000 {
> +        compatible =3D "cix,sky1-usbdp";
> +        reg =3D <0x14064000 0x4000>,
> +              <0x14050000 0x400>;
> +        reg-names =3D "dp", "rcsu";
> +        interrupts =3D <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&dpc0_apb>, <&dpc0_vid0>, <&dpc0_vid1>;
> +        clock-names =3D "apb", "vid0", "vid1";
> +        resets =3D <&dpc0_rst>;
> +        phys =3D <&usbc0_dp_phy>;
> +
> +        port {
> +            dp0_0_in: endpoint {
> +                remote-endpoint =3D <&dpu0_pipe0_out>;
> +            };
> +        };
> +    };

[Severity: Low]
Can the unused labels dp0 and dp0_0_in be dropped from the example?
Unreferenced labels in binding examples trigger warnings from
scripts/dtc/dt-check-style in strict mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117064552.8525=
6-1-Luo.Liu@cixtech.com?part=3D1
