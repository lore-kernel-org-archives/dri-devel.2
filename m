Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF19C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F8710E0DA;
	Tue,  8 Sep 2026 09:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bA50JpBo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1965210E0DA
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:36:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7AC740187;
 Tue,  8 Sep 2026 09:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DBE1F00A3A;
 Tue,  8 Sep 2026 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788860186;
 bh=Mq34waoJSk3F6r5C2Uw1p9anvggTnBAYjIx5URUw9Hk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bA50JpBoC1nkh7i1D2n3vOEyGjXcM2i6D3F2cGoV/Q2HTTs6JLvQySm35PQV9hkpK
 LWAssyaQFRRg2v8EgbX/eooDQjs99LFVqQzGR1V/LyT6NnOwD84gME8Um3rbP+NYHR
 tzYNuw3Gj3pPr0sGlZKnvPK2i5Tk/CUoXyG2dOz75KnW/gSYVlJ4Z4kH2tMIM8aPCQ
 q3sIwaUJAV2SFZ3lTMOVYid6bM83LyI5s3Ez54Nk6NrQmFnhj9Z6QrE1907S/y5G3f
 lTwlE7I0DcT4Y9UeH1w4a7IbPGEzaj7zaVrQE0KgJOqk0RMM0VvngnpcXDDPlegIV2
 itRftGnN63/bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: display: verisilicon,dc: add
 support for nuvoton,ma35d1-dcu
To: "Joey Lu" <a0987203069@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260908092840.225220-2-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
 <20260908092840.225220-2-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:36:25 +0000
Message-Id: <20260908093626.60DBE1F00A3A@smtp.kernel.org>
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
- [Low] The schema fails to restrict the `ports` property to prevent `port@=
1` for the `nuvoton,ma35d1-dcu` compatible, despite the hardware only havin=
g a single output port.
--

commit aa050e9da3d62c01f3875ac6fea01c9b0fc78e94
Author: Joey Lu <a0987203069@gmail.com>

dt-bindings: display: verisilicon,dc: add support for nuvoton,ma35d1-dcu

This commit adds support for the Nuvoton MA35D1 DCUltraLite in the
verisilicon,dc binding. It adjusts the global minimum clocks and resets,
and applies specific topology limits for supported variants via an allOf
block.

> diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yam=
l b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> --- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
> +++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
[ ... ]
> @@ -79,6 +84,45 @@ required:
[ ... ]
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nuvoton,ma35d1-dcu
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +
> +        clock-names:
> +          maxItems: 4
> +
> +        resets:
> +          maxItems: 1
> +
> +        reset-names:
> +          maxItems: 1

[Severity: Low]
Does this conditional block also need to restrict the ports property?

The commit message notes that the DCUltraLite has a single output port,
but the schema doesn't restrict port@1 from being used for the
nuvoton,ma35d1-dcu compatible. Without disallowing the non-existent
second output port here, an invalid device tree specifying port@1 would
silently pass static schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092840.2252=
20-1-a0987203069@gmail.com?part=3D1
