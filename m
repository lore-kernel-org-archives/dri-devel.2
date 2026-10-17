Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F20CCF2C7
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA27910E24A;
	Sat, 17 Oct 2026 08:47:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A21D10E24A
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 08:46:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CFF36022E;
 Sat, 17 Oct 2026 08:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA3D1F000C4;
 Sat, 17 Oct 2026 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792226815;
 bh=UDSWgbYXbnGUSCcFRMC9/MRfO1zFrV5OAysM1OoZ3HY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hJAX42kI1wt6z7U+/2vk7ANPG7EaqoZg4M2/Gav2KtWx4DntN44vaZZKOXgmwghPv
 e19RQk5WHmjBD5tNeoIddiyPFBDNLnfbKhxfdzLbuSCXt5kXw7v4zL0fC9BVQ6FeXo
 7bugJ8GmMWGblbtKA3HL91c+tFd5PjTI1qVypruh/hRM0/chQWiVj/CCbzA1V6zGZw
 CJNPlskQPxMgta04RMpj7+OusMey2M4ZOcqkS8GXUmoZXuvws6/uQ6whf8a7DbuMka
 9LicUOJqKn6k1vwdYmqghSJqtIWtjqR6Y2FVlmxtfHSnh2ocZYEa1iZRnUJhu8xStz
 CyeMkMX0x++EQ==
Message-ID: <sashiko-outbox-175408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: add Smartisan TD4362
To: tianshi12127 <tianshi12127@gmail.com>, dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261017083531.766557-3-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017083531.766557-3-tianshi12127@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 08:46:54 +0000
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
- [Medium] dt-bindings: display: panel: smartisan,td4362 uses PMIC lab/ibb =
supply names
--

commit 6d3f290b8760784bb6a0903d2ec93dcc896d4221
Author: Lu Chen <tianshi12127@gmail.com>

dt-bindings: display: panel: add Smartisan TD4362

This commit documents the devicetree binding for the Smartisan TD4362
1080x2242 command mode MIPI-DSI panel found in the Smartisan R1
smartphone.

> diff --git a/Documentation/devicetree/bindings/display/panel/smartisan,td=
4362.yaml b/Documentation/devicetree/bindings/display/panel/smartisan,td436=
2.yaml
> new file mode 100644
> index 0000000000000..a46bc2f530300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/smartisan,td4362.ya=
ml
> @@ -0,0 +1,75 @@

[ ... ]

> +properties:
> +  compatible:
> +    items:
> +      - const: smartisan,td4362
> +
> +  reg:
> +    maxItems: 1
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +  lab-supply:
> +    description: Positive source voltage rail
> +
> +  ibb-supply:
> +    description: Negative source voltage rail

[Severity: Medium]
Should lab-supply and ibb-supply in properties, required, and examples be
named vsp-supply and vsn-supply instead?

In devicetree bindings, *-supply properties on a consumer node describe the
power rail inputs of the panel itself rather than the host PMIC regulator
blocks (Qualcomm LAB and IBB) that supply them.

As noted in the property descriptions (Positive source voltage rail and
Negative source voltage rail) and in other Synaptics TD43xx panel bindings
such as Documentation/devicetree/bindings/display/panel/boe,td4320.yaml,
sony,td4353-jdi.yaml, and synaptics,td4300-panel.yaml, the panel's positive
and negative source voltage inputs are vsp-supply and vsn-supply (wired as
vsp-supply =3D <&lab>; and vsn-supply =3D <&ibb>; in the board devicetree).

> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - lab-supply
> +  - ibb-supply
> +  - reset-gpios
> +  - port

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017083531.7665=
57-1-tianshi12127@gmail.com?part=3D2
