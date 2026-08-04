Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C02C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F208A10E031;
	Tue,  4 Aug 2026 21:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mACRRa8p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB62A10E031
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 21:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D97D600B1;
 Tue,  4 Aug 2026 21:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37541F000E9;
 Tue,  4 Aug 2026 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785877291;
 bh=2mefUfUOSQEb3Po3WvN9Rb739lGP7HL7Hfbyuo5l7sc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mACRRa8pgG9vNfwCDg/hkmoIsxqTKnsnXDZUvUe0Tu+NyMyvOdusDphEArPh/N/tr
 lGWJJyt+5zEhbKfB5TcAc/IUqn/5Q7ntGdMxyP8fX2x9dADfUgGj6jfwpQUxGs4gy4
 guPJk4AbtVp4qeSwInbPtIUMB180PGOu5AanVFsO/YZxbS8Dd+MslFIcMrJXpdsRlk
 WucSAo5k2ZcbZKPELnFplWO14CBPkIELsj+16FoPdCCnk4zUg6RwCPF0xA6HGHBU7i
 fk8pNAsSD9nExW55dLJE69JMWRusQpNvt03oSjyMimqzXqyRgHddfF4fRJVKNbmhgv
 F7px7JQUOhW7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied
 boot logo
To: "Max Pedraza" <maximpedraza@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260804225617.264861-2-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 21:01:30 +0000
Message-Id: <20260804210130.A37541F000E9@smtp.kernel.org>
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
- [Medium] The `memory-region` alternative is completely broken due to conf=
licting top-level `required` constraints and a missing property definition.
--

--- Patch [1]: [PATCH v2 1/6] dt-bindings: display: add a device tree suppl=
ied boot logo ---
commit f24f24c36e68703fb2282044b3ecdd6fe92fa5c4
Author: Max Pedraza <maximpedraza@gmail.com>

dt-bindings: display: add a device tree supplied boot logo

Embedded products frequently need a product specific boot logo. This commit
adds a binding for a "linux,boot-logo-clut224" node to allow the boot logo
to be described by the device tree instead of baked into the kernel. The
image can live in the device tree directly or in a reserved memory region.

> diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-cl=
ut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut=
224.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.y=
aml

[ ... ]

> +required:
> +  - compatible
> +  - width
> +  - height
> +  - clut
> +  - data

[Severity: Medium]
Does this global required block conflict with the oneOf block below?

Since width, height, clut, and data are unconditionally required here, any
node attempting to use the memory-region alternative will fail schema
validation because it lacks these globally required properties.

> +
> +# The image either lives in the device tree or in a reserved memory regi=
on,
> +# never both.
> +oneOf:
> +  - required:
> +      - width
> +      - height
> +      - clut
> +      - data
> +  - required:
> +      - memory-region
> +
> +additionalProperties: false

[Severity: Medium]
Can this schema successfully validate a node using a memory-region?

Since memory-region is missing from the main properties block, setting
additionalProperties to false here will cause validation to reject any node
that includes it, completely preventing this configuration alternative from
being used.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804225617.2648=
61-1-maximpedraza@gmail.com?part=3D1
