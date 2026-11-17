Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF08606A887
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp4Edevx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C2D10E03F;
	Tue, 17 Nov 2026 12:51:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D12010F6CC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:51:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6BAA403BF;
 Tue, 17 Nov 2026 12:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344AF1F000C4;
 Tue, 17 Nov 2026 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794919874;
 bh=bPc/tkXm29ES90LPGNiFh5SDVDhkBJg4N6KrnFhUIiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gp4Edevxixx2PwmFnm0t5IWia2+eCwdShKNoZ6tIHDordHMY2sRIM2hYFhzda7gqr
 aU7TymabDq6atfO79h3rwS0UiNL3kyIlPvJANPCwzE+hvddKWUAP6Jk9cJ53/1Wos8
 uvT8GjV/WjaVvjlJ0szRvdRxNx9nuw9+OOqhOw81CWm7aeU2ZOk5ITq9dIYJihtZ4Z
 sFp7IQbEsZkdH10oaQZ3ODgckjoAd7K9N9iUj0wHHgtnblmaz3gmgnqeJb4mSt3TkB
 yUjQiV8OjrcH1jECQyqy1kNuHFK/Cw/OovGQtbKEpxTLlrC9johFebxeLs4jzd9CNq
 4cNWZJdfDENsA==
Message-ID: <sashiko-outbox-218806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/11] dt-bindings: input: touchscreen: add Silicon
 Works SW42902
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-7-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-7-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:51:13 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: input: touchscreen: username handle used in
  sign-off and maintainer
- [Medium] dt-bindings: input: lg,sw42902: power rails modeled as GPIOs
  instead of supplies
--

commit c2a344c3130db163c68195828fdefbdfd36cd07a
Author: rofikkerneldev <rofikcoga@gmail.com>

> dt-bindings: input: touchscreen: add Silicon Works SW42902
>
> Document the I2C touchscreen and its interrupt, reset, power-enable,
> and panel-size properties.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Developer's Certificate of Origin requires a real human name (known
identity) rather than an account handle or pseudonym in Signed-off-by
trailers, the commit Author header, the binding's maintainers list, and
MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw429=
02.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.ya=
ml
> new file mode 100644
> index 0000000000000..c56cfb8530eeb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> @@ -0,0 +1,74 @@

[ ... ]

> +  vcl-gpios:
> +    maxItems: 1
> +    description: Active-high enable for the 3.3 V rail
> +
> +  vdd-gpios:
> +    maxItems: 1
> +    description: Active-high enable for the 1.8 V rail
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - vcl-gpios
> +  - vdd-gpios

[Severity: Medium]
Should the 3.3 V VCL and 1.8 V VDD power inputs be described as
vcl-supply and vdd-supply regulator properties instead of vcl-gpios and
vdd-gpios?

VCL and VDD are power supply rails on the SW42902 controller rather than
GPIO pins, so requiring GPIO properties in the binding prevents it from
describing boards powered by PMIC regulators or always-on supplies.
GPIO-switched rails on a specific board can be modeled as regulator-fixed
nodes in the board DTS connected to vcl-supply and vdd-supply.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D6
