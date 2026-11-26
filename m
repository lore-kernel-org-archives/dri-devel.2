Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D841606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anBStro1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D101A10E08F;
	Thu, 26 Nov 2026 06:13:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B7A10E08F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E99F1609F3;
 Thu, 26 Nov 2026 06:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF461F000C0;
 Thu, 26 Nov 2026 06:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795673594;
 bh=iLHgSF/n7XKvLP1gIjWglwvMShWzX1CPzOnA5uOo/UA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=anBStro1tUkQacVN4eXXDJrXHhMLJDCdp9hrpWVeFWdru3xESklNMONn8n+AfSvxA
 7DV5sL6ichqEox+xstvNfFrFdhN9HDxcLGQJ1hIHhSM0IWmxg4BE9EmzSmHXz9Q8dd
 cSU/E0Ijvc8/e2BC9fHVs80PRun3Mn3bpdhTCqAHU9ba22yABPmfeJ2+avNvzd3v56
 pEmCuRlAtY3C+64d+8xREtsWcsRoHN0cx1i6Gr5HIO6rSm2Z5cJxwaGCL6MELr6eJe
 dwyodyqCFaplNnYF+Gg5FVoew8hoVdw4TzBGZSlCx+XoFsiTQmR9rrQEW2q4P+iU0A
 0da10C7hfVEpQ==
Message-ID: <sashiko-outbox-234829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261126060003.3979478-2-Luo.Liu@cixtech.com>
References: <20261126060003.3979478-1-Luo.Liu@cixtech.com>
 <20261126060003.3979478-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:13:14 +0000
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
- [Medium] dt-bindings: display: cix,sky1-dp: missing ports/port@1 and
  aux-bus in schema
--

commit 0fd2cf4952ac57efa52ecd81791109f84491673b
Author: Luo Liu <Luo.Liu@cixtech.com>

dt-bindings: display: add CIX Sky1 DisplayPort transmitter

This commit adds the Device Tree binding schema for the Trilinear
DisplayPort transmitter integrated on CIX Sky1.

> diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml b=
/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
> new file mode 100644
> index 0000000000000..2cb4dbb8d5fe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
> @@ -0,0 +1,102 @@

[ ... ]

> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Video input from the Mali D71 display pipeline (Komeda) that drives
> +      this controller. The link to the sink is through phys (USB-C combo=
 PHY
> +      or the native DP PHY), not a second OF graph port on the DPTX.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - resets
> +  - phys
> +  - port
> +
> +additionalProperties: false

[Severity: Medium]
Should this schema define a ports container with port@0 (input) and
port@1 (output), as well as an optional aux-bus property for eDP panels,
instead of requiring a single unnumbered top-level port node?

The phys property only references the local SoC PHY provider and does not
describe downstream sink or AUX bus topology.  In addition, an output port
cannot be added as an optional property later while a top-level unnumbered
port node is required: of_graph_get_port_by_id() scopes port lookup
exclusively to a ports child node whenever one is present, so a board DTS
adding ports/port@1 would hide an SoC DTSI top-level port node unless the
binding is migrated from port to ports.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126060003.3979=
478-1-Luo.Liu@cixtech.com?part=3D1
