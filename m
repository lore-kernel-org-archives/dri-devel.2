Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E615EC61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4987A10F3B5;
	Fri, 28 Aug 2026 13:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e3tiJWME";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0122310F3B5
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:54:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE4FA43721;
 Fri, 28 Aug 2026 13:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4521F00A3A;
 Fri, 28 Aug 2026 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925252;
 bh=T3isB2H6d1Dx84uRJLozxn9jxSFH30cklxx2GVA7pdY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e3tiJWMEKxrIf7cqnKDTxZErmFVD+rv9rZlS0vmRINCbR4OdPnSkg0z6K1xurfEDF
 aHB/0Y7w0UJbh8DDMRpYGGruUbo4pJSIkfxZnJtoCH54zqbZzckRUm28O2B7RwopsJ
 hc1Agbusil0d+S1YWVlvQTCwN5dLMZ1MXwtB2gYwAALBFbOIa7G7mrPVaER04yFoSf
 Gdbv408xFpDCdq7/xM/i9s0mWINZ3LIU4jAAKIZ/iuSwuGhtwTaWBth7sK1uupdUZ4
 pgzt4b0jp/0stXADmhp3AHqiYIV73WoCg9tHvgchRFzBqFQAtUQGHZfLs2aoH3D2kl
 3a1Xqy2LDV4Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: display: bridge: Add
 starfive,jh7110-inno-hdmi-controller
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: olteanv@gmail.com, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, lee@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260828-jh7110-clean-send-v2-2-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134817eucas1p2e2756deff8871be4ea8bb5c65f9c179d@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-2-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:54:11 +0000
Message-Id: <20260828135411.EF4521F00A3A@smtp.kernel.org>
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
- [Medium] The `ports` property describes one input and one output port but=
 fails to enforce this constraint in the YAML structure.
--

commit 419cb2b368875cbe282124810522d401e4b0c458
Author: Michal Wilczynski <m.wilczynski@samsung.com>

dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-controller

This commit adds the device tree binding schema for the StarFive JH7110
Innosilicon HDMI controller.

> diff --git a/Documentation/devicetree/bindings/display/bridge/starfive,jh=
7110-inno-hdmi-controller.yaml b/Documentation/devicetree/bindings/display/=
bridge/starfive,jh7110-inno-hdmi-controller.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-in=
no-hdmi-controller.yaml
[ ... ]
> +  phy-names:
> +    const: hdmi-phy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      A graph node with one input port and one output port.

[Severity: Medium]
Does this missing structure allow invalid device trees to pass validation?

The description states there is one input port and one output port, but the
YAML lacks the internal property constraints (such as port@0 and port@1) and
the associated required list.

Without these explicit definitions, device trees missing the expected nodes
or adding extraneous invalid ports will silently pass dt_binding_check desp=
ite
violating the hardware topology constraints described.

Could explicit definitions and constraints for port@0 and port@1 be added
here to properly enforce the port counts?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D2
