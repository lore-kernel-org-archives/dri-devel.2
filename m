Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4B606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Na4TxIKK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED1E10E231;
	Mon,  9 Nov 2026 10:42:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D876410E231
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:42:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC5F2407C5;
 Mon,  9 Nov 2026 10:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547BA1F0089F;
 Mon,  9 Nov 2026 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794220929;
 bh=hab68m5n5oJbQO706BjbQj3ZFN7l0dweDR5TjfbuX+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Na4TxIKK2535CpV7Pgpy57Iyct/NrUWikzi0ZLZVrZUFB5E0yt8vfdFa1hRYCBlAW
 qn9BZ9xcU8H+0nXdZ0nLl+s9fH2F+bMvwiqAxEuw047cJ6HGnzxkxdlyVCLLxtXOva
 P7n/cR9VdL2paY6wWtDWW24M5d896XSCsH0jRVpWAJCU2efZBELdZYgJekKUuHNRYf
 DxRs9772oxv0SFNAq08win0cIVPizD6QuGVm/mih91PdfbE3KkY7+GL53LikxXj578
 TvNTzlxZgZKwSVoViesrZGrHJiX9dc2YrIBKSgFhLythP7YIQ9/wwZ2d52gUyVlqfn
 lnSMXg3suq0iQ==
Message-ID: <sashiko-outbox-204834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261109103010.110911-2-Luo.Liu@cixtech.com>
References: <20261109103010.110911-1-Luo.Liu@cixtech.com>
 <20261109103010.110911-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:42:08 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] dt-bindings: display: cix,sky1-dptx: missing output port and
  required phys
- [Low] dt-bindings: display: cix,sky1-dptx: non-standard
  cix,dp-max-rate property
- [Low] dt-bindings: display: cix,sky1-dptx: instance index properties
  in binding
- [Low] dt-bindings: display: cix,sky1-dptx: unused dp0 label in DTS
  example
--

commit 8c60d6c22ca4c6d5157c09f9c5eab3f993001d1b
Author: Luo Liu <Luo.Liu@cixtech.com>

dt-bindings: display: add CIX Sky1 DisplayPort transmitter

This commit adds the Devicetree binding schema and MAINTAINERS entry for
the CIX Sky1 DisplayPort transmitter controller.

> diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml=
 b/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
> new file mode 100644
> index 0000000000000..9087b5edd9f02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
> @@ -0,0 +1,108 @@

[ ... ]

> +  phys:
> +    maxItems: 1
> +    description: DisplayPort PHY the controller transmits through.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Video input from the display pipeline that drives this controller.

[Severity: Medium]
Should this binding define ports with both an input port from the display
pipeline and an output port to the downstream DisplayPort connector, eDP
panel, or Type-C bridge, and mark phys and ports as required?

With only a single input port and additionalProperties: false, board DTS
files that connect the transmitter output to a connector or panel via
ports will fail dtbs_check validation. In addition, cix_dp_parse_dt()
unconditionally calls devm_phy_get(dev, NULL) and fails probe if phys is
absent, yet phys and the OF graph port are omitted from both required and
the example.

> +
> +  cix,adapter-port:
> +    description:
> +      RCSU video adapter port of this transmitter. Sky1 numbers its five
> +      transmitters from 1 to 5. Port 3 is the native DP/eDP output.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 5
> +
> +  cix,dp-max-rate:
> +    description:
> +      Maximum link rate the board is wired for, in units of 10 kbit/s.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [162000, 270000, 540000, 810000]
> +    default: 810000

[Severity: Low]
Could this use the standard link-frequencies property from
video-interfaces.yaml on the output endpoint instead of a custom
cix,dp-max-rate property?

The values 162000, 270000, 540000, and 810000 in 10 kbit/s units come
from Linux DRM's internal drm_dp_bw_code_to_link_rate() representation and
lack a standard unit suffix, whereas DisplayPort bindings normally specify
board-supported link rates in Hz via link-frequencies on the output
endpoint.

> +
> +  cix,stream-id:
> +    description:
> +      Index of the video stream this controller uses. Sky1 has two strea=
ms,
> +      numbered 0 and 1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1
> +    default: 0

[Severity: Low]
Should cix,adapter-port and cix,stream-id be avoided in favor of
describing hardware differences via compatible strings or OF graph
endpoints?

In cix_dp_cfg_adapter(), each instance already maps its own rcsu region
from reg, and cix,adapter-port is only checked against port 3 because the
native DP/eDP port uses a different RCSU register layout (offset 0x320)
than the USB-C DP ports (offsets 0x300 and 0x304). Similarly,
cix,stream-id encodes the display pipeline stream index as a custom vendor
property rather than representing the stream routing through OF graph
ports or endpoints.

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    dp0: dp@14064000 {

[Severity: Low]
Can the unreferenced dp0 label be dropped from the example?  It is never
referenced within the example and triggers an unused-labels warning from
scripts/dtc/dt-check-style in strict mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109103010.1109=
11-1-Luo.Liu@cixtech.com?part=3D1
