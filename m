Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88599C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB2910F10F;
	Wed, 12 Aug 2026 19:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TJz5ZM/+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0321610F103
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:28:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7699743CE6;
 Wed, 12 Aug 2026 19:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06A31F00A3A;
 Wed, 12 Aug 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786562915;
 bh=1wv4kNgnNbihJVWnQRVp4+ysqwQfrzKDVI8KwyAicVg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TJz5ZM/+RdnIO9aodwTJfkn0wijqZZUoskTs4R/zKiyhnDh28Ocu9V6cddf24E7Tw
 JESFbu+6wsuurxQTBLzIZRgEqm3ro8RUaEmSTw/HWnE8tOZuzPe1vetBm9oXmrNVTn
 BJXnqtlZI++ZyU1hGkRy7A7uPLdAfASZ9yKEqmtWt9FDBROlF57yaSf8hRKLpgnMBP
 R1UddwakP/Uya/lGKO0/x8SIzcZWaDoaj0eFj973GZ7BNq8jAyQG1MmXAu6TG92lXy
 rFJwR3duYvfvstYZ86trHP6sWf7tHRIMJJteoamYfeuLUJieC34Q2DDkuNx9Gc8LRG
 YE57PDUZtqQrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org,
 linux-leds@vger.kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:28:34 +0000
Message-Id: <20260812192834.F06A31F00A3A@smtp.kernel.org>
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
- [Medium] The schema uses `additionalProperties: false` while also referen=
cing `common.yaml#`, which will incorrectly reject standard inherited prope=
rties.
--

--- Patch [1]: [PATCH v2 1/2] dt-bindings: backlight: Add Orient Chip OCP81=
78 ---
commit e31a9b24875ae6868d7bab27e5c73b0f9db06347
Author: Wim de With <wf@dewith.io>

dt-bindings: backlight: Add Orient Chip OCP8178

This commit adds device tree bindings for the Orient Chip OCP8178 LED
backlight driver, introducing a new YAML schema.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> new file mode 100644
> index 0000000000000..57c44d3383b88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
[ ... ]
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
[ ... ]
> +required:
> +  - compatible
> +  - enable-gpios
> +
> +additionalProperties: false

[Severity: Medium]
Since this schema references common.yaml, should this be set to
unevaluatedProperties: false instead? Using additionalProperties: false
will incorrectly reject legitimate properties inherited from common.yaml
during schema validation.

> +
> +examples:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-ocp8178-ba=
cklight-v2-0-4ad18b48bef8@dewith.io?part=3D1
